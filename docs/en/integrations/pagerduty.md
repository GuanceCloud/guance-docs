---
title: 'Incident Events and PagerDuty Integration'
summary: 'When our application or system encounters an incident, it usually needs to be handled promptly to ensure normal operation. To better manage and track incident events, we can send these events to PagerDuty to create incidents. This allows us to track, analyze, and resolve issues within PagerDuty, providing better management and tracking capabilities for incident events, thereby ensuring the normal operation of the system. Additionally, this method also helps us better analyze and solve problems, improving system stability and reliability.'
__int_icon: 'icon/pagerduty'
---

<!-- markdownlint-disable MD025 -->

# Incident Events and PagerDuty Integration
<!-- markdownlint-enable -->

When our application or system encounters an incident, it usually needs to be handled promptly to ensure normal operation. To better manage and track incident events, we can send these events to PagerDuty to create incidents. This allows us to track, analyze, and resolve issues within PagerDuty, providing better management and tracking capabilities for incident events, thereby ensuring the normal operation of the system. Additionally, this method also helps us better analyze and solve problems, improving system stability and reliability.

## Configuration {#config}

### Preparation

1. Deploy a [DataFlux Func (Automata)](https://func.guance.com/#/) to generate an authorization link.
2. Create a [webhook custom notification target](https://docs.guance.com/monitoring/notify-object/#4-webhook) (the webhook URL should be the authorization link URL of DataFlux Func).
3. Properly configure the [monitor](https://docs.guance.com/monitoring/monitor/).
4. In PagerDuty, create a **Service** with an **Integration** of type **Events API V2**.

### Deployment Process

#### Create Webhook Custom Notification Target

In the Guance Studio under **Monitoring / Notification Targets Management**, create a new notification target, select **webhook custom**, and enter the authorization link URL of the deployed DataFlux Func as the webhook URL.

![1693212890543.png](imgs/pagerduty/pagerduty01.png)

> Note: Choose an authorization link in DataFlux Func that does not include parameters.

#### Create Monitor

In the Guance Studio under **Monitoring / Monitors**, create a new monitor, select the metrics you want to observe, and after configuring the alert content, specify the alert notification target as the name of the **webhook custom** notification target we just created.

![1693212934306.png](imgs/pagerduty/pagerduty02.png)

#### Write Listener Script

After configuring the monitor's detection rules, we need to write a script in the already installed and configured DataFlux Func to fetch new messages and send them to PagerDuty to create incidents.

First, we need to import some constants such as `events_url` and `routing_key`.

```Python
import requests
import json

events_url = "https://events.pagerduty.com/v2/enqueue"
routing_key = "xxxxxxxxxx"
```

After importing the necessary constants, we need to understand the structure of the monitoring event data so that we can parse and create events to send to PagerDuty.

```JSON
{
    "Result": 100,
    "date": 1693034940,
    "df_at_accounts": [],
    "df_at_accounts_nodata": [],
    "df_channels": [
        "chan_968577392a1c4714a464cd2f6ee42a9c"
    ],
    "df_check_range_end": 1693034880,
    "df_check_range_start": 1693034820,
    "df_date_range": 60,
    "df_dimension_tags": "{\"host\":\"share\"}",
    "df_event_id": "event-f20a38aa58b54c6c8d4c9a84e655db1a",
    "df_event_link": "https://console.guance.com/keyevents/monitor?time=1693034040000%2C1693035000000&tags=%7B%22df_event_id%22%3A%22event-f20a38aa58b54c6c8d4c9a84e655db1a%7D&w=wksp_968577392a1c4714a464cd2f6ee42a9c",
    "df_event_reason": "满足监控器中的故障认定条件，产生故障事件",
    "df_exec_mode": "crontab",
    "df_issue_duration": 3840,
    "df_issue_start_time": 1693031100,
    "df_label": "[]",
    "df_language": "zh",
    "df_message": ">\u7b49\u7ea7\uff1acritical    \n>\u5b9e\u4f8b\uff1ashare    \n>\u5185\u5bb9\uff1a\u78c1\u76d8\u4f7f\u7528\u7387\u4e3a 100.00%    \n>\u5efa\u8bae\uff1a\u767b\u5f55\u534e\u4e3a\u4e91\u63a7\u5236\u53f0\u67e5\u770b RDS \u662f\u5426\u6709\u5f02\u5e38",
    "df_monitor_checker": "custom_metric",
    "df_monitor_checker_event_ref": "13713ac25e993a37d2ca5899e2a7bba6",
    "df_monitor_checker_id": "rul_c439124e218f4c0c9cb114b5d04eeab4",
    "df_monitor_checker_name": "实例名称为 {host} 磁盘使用率为过高",
    "df_monitor_checker_ref": "aad7deb63b2e58b301f823517fea944d",
    "df_monitor_checker_sub": "check",
    "df_monitor_checker_value": "100",
    "df_monitor_id": "monitor_6774968876c14586bc5afc6d7144f52f",
    "df_monitor_name": "默认",
    "df_monitor_type": "custom",
    "df_site_name": "中国区1（杭州）",
    "df_source": "monitor",
    "df_status": "critical",
    "df_sub_status": "critical",
    "df_title": "实例名称为 share 磁盘使用率过高",
    "df_workspace_name": "observer",
    "df_workspace_uuid": "wksp_968577392a1c4714a464cd2f6ee42a9c",
    "host": "share",
    "timestamp": 1693034940,
    "workspace_name": "observer",
    "workspace_uuid": "wksp_968577392a1c4714a464cd2f6ee42a9c"
}
```

This **JSON** contains information about the event title `df_title`, event details `df_message`, and event status `df_status`, among other related information such as event generation time, anomaly value, workspace ID, etc., which can be included in the events we need to generate if required.

After clarifying the input data structure, we can write the function to create PagerDuty incidents.

```Python
@DFF.API('Create_PagerDuty_Issue_Reply')
def create_pagerduty_issue_reply(**kwargs):
    # Get Guance event data
    event = json.dumps(kwargs)
    print("Guance_event:", event)
    summary = kwargs["df_title"]
    description = kwargs["df_message"]
    severity = kwargs["df_status"]
    df_event_link = kwargs["df_event_link"]
    workspace_name = kwargs["workspace_name"]
    result = kwargs["Result"]
    date = kwargs["date"]
    # Build request data
    headers = {
        "Content-Type": "application/json",
        "Accept": "application/vnd.pagerduty+json;version=2",
    }

    payload = {
        "routing_key": routing_key,
        "event_action": "trigger",
        "payload": {
            "summary": summary,
            "source": "monitoringtool:cloudvendor:central-region-dc-01:852559987:cluster/api-stats-prod-003",
            "severity": severity,
            "custom_details": {
                "result": result,
                "date": date,
                "description": description
            }
        },
        "client": "Guance" + workspace_name,
        "client_url": df_event_link
    }
    # Create incident
    response = requests.post(events_url, headers=headers, data=json.dumps(payload))
    # Print new incident
    print(response.status_code)
    print(response.text)
```

We create a PagerDuty incident by transforming the event details obtained from Guance into an incident dictionary and sending it to PagerDuty. After successful transmission, logs containing `dedup_key` and `status` information will be generated.

![1693213100705.png](imgs/pagerduty/pagerduty03.png)

Then we can view the corresponding alert information in PagerDuty and emails.

![1693213121459.png](imgs/pagerduty/pagerduty04.png)

Also, alert information can be received via the email configured in PagerDuty.

![169321311459.png](imgs/pagerduty/pagerduty05.png)

After writing the script, click publish to complete the process.
