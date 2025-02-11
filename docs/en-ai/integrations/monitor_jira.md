---
title: 'Incident Events and Jira Integration'
summary: 'When our application or system encounters an incident, it typically needs to be handled promptly to ensure normal operation. To better manage and track these incidents, we can send them to Jira to create issues. This allows us to track, analyze, and resolve these problems within Jira, thereby improving our ability to manage and track incidents, ensuring better system operation. Additionally, this method helps us analyze and solve problems more effectively, enhancing system stability and reliability.'
__int_icon: 'icon/monitor_jira'
---

<!-- markdownlint-disable MD025 -->

# Incident Events and Jira Integration
<!-- markdownlint-enable -->

When our application or system encounters an incident, it typically needs to be handled promptly to ensure normal operation. To better manage and track these incidents, we can send them to Jira to create issues. This allows us to track, analyze, and resolve these problems within Jira, thereby improving our ability to manage and track incidents, ensuring better system operation. Additionally, this method helps us analyze and solve problems more effectively, enhancing system stability and reliability.

## Configuration {#config}

### Preparation

1. Deploy a [DataFlux Func (Automata) Guance Special Edition](https://func.guance.com/#/) to generate an authorization link.
2. Create a [webhook custom notification object](https://docs.guance.com/monitoring/notify-object/#4-webhook) (the webhook URL is the authorization link URL of Func).
3. Correctly configure the [monitor](https://docs.guance.com/monitoring/monitor/).

### Deployment Process

#### Create Webhook Custom Notification Object

In the Guance Studio under **Monitoring / Notification Targets Management**, create a new notification object, select **webhook custom**, and fill in the webhook URL with the authorization link address of the deployed DataFlux Func.

![1693212890543.png](imgs/monitor_jira/monitor_jira01.png)

> Note: In Func, choose an authorization link without parameters.

#### Create Monitor

In the Guance Studio under **Monitoring / Monitors**, create a new monitor, select the metrics you need to observe, configure the event notification content, and specify the alert notification object in the alert policy as the name of the **webhook custom** notification object we just created.

![1693212934306.png](imgs/monitor_jira/monitor_jira02.png)

#### Write Listener Script

After configuring the monitoring rules, we need to write a script in the already installed and configured DataFlux Func to fetch new messages and send them to Jira to create issues.

First, we need to introduce some constants such as `jira_server`, `username`, `password`, `project_key`, etc.

```Python
import json
from jira import JIRA

jira_server = "http://xxxxxx:8080/"
username = "xxxx"
password = "xxxxx"
project_key = "XXXXXXXXX"
```

After introducing the necessary constants, we need to understand the data structure of the monitoring events to parse and create the issues sent to Jira.

```JSON
{
    "Result":100,
    "date":1693034940,
    "df_at_accounts":[

    ],
    "df_at_accounts_nodata":[

    ],
    "df_channels":[
        "chan_968577392a1c4714a464cd2f6ee42a9c"
    ],
    "df_check_range_end":1693034880,
    "df_check_range_start":1693034820,
    "df_date_range":60,
    "df_dimension_tags":"{\"host\":\"share\"}",
    "df_event_id":"event-f20a38aa58b54c6c8d4c9a84e655db1a",
    "df_event_link":"https://console.guance.com/keyevents/monitor?time=1693034040000%2C1693035000000&tags=%7B%22df_event_id%22%3A%22event-f20a38aa58b54c6c8d4c9a84e655db1a%22%7D&w=wksp_968577392a1c4714a464cd2f6ee42a9c",
    "df_event_reason":"\u6ee1\u8db3\u76d1\u63a7\u5668\u4e2d\u6545\u969c\u7684\u8ba4\u5b9a\u6761\u4ef6\uff0c\u4ea7\u751f\u6545\u969c\u4e8b\u4ef6",
    "df_exec_mode":"crontab",
    "df_issue_duration":3840,
    "df_issue_start_time":1693031100,
    "df_label":"[]",
    "df_language":"zh",
    "df_message":">\u7b49\u7ea7\uff1acritical    \n>\u5b9e\u4f8b\uff1ashare    \n>\u5185\u5bb9\uff1a\u78c1\u76d8\u4f7f\u7528\u7387\u4e3a 100.00%    \n>\u5efa\u8bae\uff1a\u767b\u5f55\u534e\u4e3a\u4e91\u63a7\u5236\u53f0\u67e5\u770b RDS \u662f\u5426\u6709\u5f02\u5e38",
    "df_monitor_checker":"custom_metric",
    "df_monitor_checker_event_ref":"13713ac25e993a37d2ca5899e2a7bba6",
    "df_monitor_checker_id":"rul_c439124e218f4c0c9cb114b5d04eeab4",
    "df_monitor_checker_name":"\u5b9e\u4f8b\u540d\u79f0\u4e3a {host} \u78c1\u76d8\u4f7f\u7528\u7387\u8fc7\u9ad8",
    "df_monitor_checker_ref":"aad7deb63b2e58b301f823517fea944d",
    "df_monitor_checker_sub":"check",
    "df_monitor_checker_value":"100",
    "df_monitor_id":"monitor_6774968876c14586bc5afc6d7144f52f",
    "df_monitor_name":"\u9ed8\u8ba4",
    "df_monitor_type":"custom",
    "df_site_name":"\u4e2d\u56fd\u533a1\uff08\u676d\u5dde\uff09",
    "df_source":"monitor",
    "df_status":"critical",
    "df_sub_status":"critical",
    "df_title":"\u5b9e\u4f8b\u540d\u79f0\u4e3a share \u78c1\u76d8\u4f7f\u7528\u7387\u8fc7\u9ad8",
    "df_workspace_name":"observer",
    "df_workspace_uuid":"wksp_968577392a1c4714a464cd2f6ee42a9c",
    "host":"share",
    "timestamp":1693034940,
    "workspace_name":"observer",
    "workspace_uuid":"wksp_968577392a1c4714a464cd2f6ee42a9c"
}
```

This **JSON** contains the event title `df_title`, event details `df_message`, and event status `df_status`. Of course, this **JSON** also includes other relevant information such as event creation time, anomaly value, workspace ID, etc., which can be included in the issue if needed.

With the input data structure clear, we can now write the function to create a Jira issue.

```Python
@DFF.API('Create_JIRA_Issue_Reply')
def create_jira_issue_reply(**kwargs):

    # Create Jira instance
    jira = JIRA(server=jira_server, basic_auth=(username, password))
    # Get Guance event data
    event = json.dumps(kwargs)
    print(event)
    summary  = kwargs["df_title"]
    description = kwargs["df_message"]

    # Define issue fields
    issue_dict = {
        'project': {'key': project_key},
        'summary': summary,
        'description': description,
        'issuetype': {'name': '故障'},  # Change issue type to Task
        'assignee': {'name': 'pacher'},
        'priority': {'name': 'Highest'}
    }

    # Create issue
    issue = jira.create_issue(fields=issue_dict)

    # Print the key of the newly created issue
    print(f"Newly created issue key: {issue.key}")
```

We create a Jira issue by using the event details obtained from Guance, forming an issue dictionary, and sending it to Jira. After successful transmission, a log is generated, which is the `issue.key` we created.

![1693213100705.png](imgs/monitor_jira/monitor_jira03.png)

Then we can view the corresponding issue in Jira using the created `issue.key`.

![1693213121459.png](imgs/monitor_jira/monitor_jira04.png)

After writing the script, click Publish to complete the setup.