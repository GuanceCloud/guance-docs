# Best Practices for Two-way Synchronization Between Incident and JIRA

---

> _Authors: Su Tongtong, Liu Rui_

[**Incidents**](/exception/) is a tool launched by <<< custom_key.brand_name >>> that facilitates effective coordination and communication management based on internal anomalies.

**JIRA** is an enterprise-level project management tool.

???+ info

    When an application or system experiences an anomaly, it usually needs to be handled promptly to ensure the normal operation of the system. Through two-way synchronization between [**Incidents**](/exception/) and JIRA, relevant personnel within the enterprise can quickly understand and analyze the causes of problem failures, trace and record the handling process of the failure, effectively improving communication efficiency and significantly reducing the cost of fault handling.



![Incident Interaction Flow with IM —— Jira Flowchart](../images/im_jira_01.png)


## Preparations

- [x] Jira platform (admin privileges required)
- [x] <<< custom_key.brand_name >>> workspace account
- [x] [Dataflux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/) 


## Jira

Obtain the corresponding project's `project`, project URL, `api_token`, and `username` from the Jira platform. These will be used in subsequent <<< custom_key.brand_name >>> scripts.

**Only administrators have permission to perform the above operations**



## <<< custom_key.brand_name >>>

### Create API Key

Refer to the documentation [API Key](/management/api-key/index.md) for creating an API key.

Set the key name as `Jira System`, which helps distinguish whether the comment information originates from <<< custom_key.brand_name >>> or Jira, and the key name will be displayed as the user in <<< custom_key.brand_name >>> `issue`.

### Func Script Writing

- Log in to Func

Log in to the already deployed [Dataflux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/) 

- Add Python Dependencies

1. Click on the **Manage** menu
2. Click on **Experimental Features**, turn on the **Enable PIP Tool** switch; if already enabled, ignore this step.
3. Click on **PIP Tool**, install the **Python package**, enter **jira**, select the default data source. If the default data source does not contain the current dependency, you can switch to another data source, click the **Install** button to complete the installation of dependencies.

- Write the Script

1. Click on the **Development** menu;
2. Click the **Create Script Set** button, fill in the script **ID**, which can be customized, here fill in `Issue_to_jira`, click the **Save** button;
3. Select `Issue_to_jira`, click **Create Script**, this ID can also be freely written;
4. Paste the following script content and adjust the configuration information.

```python
import requests
import json
import time
from datetime import datetime, timedelta
from jira import JIRA

# <<< custom_key.brand_name >>> configuration, remember to modify df_api_key
base_url = 'https://openapi.<<< custom_key.brand_main_domain >>>'
channel_list_url = base_url + '/api/v1/channel/quick_list'
issue_list_url = base_url + '/api/v1/issue/list'
create_issue_reply_url = base_url + '/api/v1/issue/reply/create'
df_api_key = 'vy2EV......fuTtn'

# JIRA configuration, all configurations below are mandatory, modify them to your own environment
username = 'sutt'
api_token = 'ATATT3xFfGF0eVvhZUkO0tTas8JnNYEsxGIJqWGinVyQL0ME......B6E'
jira_server_url = 'https://***.net/'
project_key = 'projectName'

# Connect to JIRA
def connect_to_jira(username, api_token, jira_server_url):
    try:
        jira_connection = JIRA(basic_auth=(username, api_token), server=jira_server_url)
        print("Successfully connected to JIRA!")
        return jira_connection
    except Exception as e:
        print(f"Error connecting to JIRA: {e}")
        return None

jira_instance = connect_to_jira(username, api_token, jira_server_url)

def sync_issues_from_guance_to_jira():
    headers = {
        'DF-API-KEY': df_api_key,
        'Content-Type': 'application/json;charset=UTF-8'
    }

    one_minute_ago = datetime.now() - timedelta(minutes=1)
    one_minute_ago_time = int(one_minute_ago.timestamp())
    current_time = int(time.time())

    response = requests.get(channel_list_url, headers=headers)
    if response.status_code == 200:
        channel_list = response.json()["content"]
        for channel in channel_list:
            if channel["name"] == "default":
                body = {
                    'channelUUID': channel["uuid"],
                    'startTime': one_minute_ago_time,
                    'endTime': current_time
                }
                issue_response = requests.post(issue_list_url, headers=headers, data=json.dumps(body))
                print(issue_response.text)  # Print response content for debugging

                if issue_response.status_code == 200:
                    issue_lists = issue_response.json()['content']
                    for issue in issue_lists:
                        issue_uuid = issue["uuid"]
                        print(f"UUID from Guance: {issue_uuid}")  # Print UUID for debugging

                        issue_data = {
                            'project': {'key': project_key},
                            'summary': issue["name"],
                            'description': issue["description"],
                            'issuetype': {'name': 'Defect'},
                            'priority': {'name': 'Medium'},
                            'labels': [issue_uuid]  # Use label to store issue_id
                        }
                        created_issue = jira_instance.create_issue(fields=issue_data)
                        print(f"Created JIRA issue: {created_issue.key}")

def create_issue_reply(issue_uuid, content):
    headers = {
        'DF-API-KEY': df_api_key,
        'Content-Type': 'application/json;charset=UTF-8'
    }
    body = {
        'issueUUID': issue_uuid,
        'content': content,
        'extend': {}
    }
    response = requests.post(create_issue_reply_url, headers=headers, data=json.dumps(body))
    if response.status_code == 200:
        print(f"Successfully created a reply for issueUUID: {issue_uuid}")
    else:
        print(f"Failed to create a reply for issueUUID: {issue_uuid}. Status code: {response.status_code}")

def sync_comments_from_jira_to_guance():
    end_time = datetime.now()
    start_time = end_time - timedelta(minutes=1)
    start_time_str = start_time.strftime('%Y-%m-%d %H:%M')
    end_time_str = end_time.strftime('%Y-%m-%d %H:%M')

    jql_str = f'project = {project_key} AND updated >= "{start_time_str}" AND updated <= "{end_time_str}"'
    recently_updated_issues = jira_instance.search_issues(jql_str)

    has_updates = False
    for issue in recently_updated_issues:
        comments = jira_instance.comments(issue)
        new_comments = [comment for comment in comments if start_time_str <= comment.created.split('.')[0].replace("T", " ") <= end_time_str]

        issue_labels = issue.fields.labels
        guance_issue_id = None
        for label in issue_labels:
            if label.startswith("issue"):
                guance_issue_id = label
                break

        if guance_issue_id and new_comments:
            has_updates = True
            for comment in new_comments:
                create_issue_reply(guance_issue_id, comment.body)

    if not has_updates:
        print("No updates or new comments in the last minute.")

@DFF.API('Create_JIRA_Issue_Reply2')
def guance():
    print("do start")
    sync_issues_from_guance_to_jira()
    sync_comments_from_jira_to_guance()

```

![Img](../images/im_jira_02.png)

- Publish Script

Click the **Publish** button to complete the publishing. After publishing, it indicates that the API has been successfully published and can provide external services.

- Automatic Trigger Configuration

**Automatic Trigger Configuration** can schedule periodic execution of APIs.

1. Enter from the **Manage** menu, click the **Automatic Trigger Configuration** button;
2. Click the **New** button at the top right corner to create a new trigger;
3. Select the script to execute, parameters can be left unspecified, select the appropriate execution frequency, adjust it to repeat every **minute**, then **save**.

![Img](../images/im_jira_03.png)


### Create Issue

There are two ways to create issues in <<< custom_key.brand_name >>>

- [x] Direct creation
- [x] Creation through monitors

#### Direct Creation

1. Log in to <<< custom_key.brand_name >>> console
2. Click the **Incident** menu, click the **Create Issue** button at the top right corner, fill in the issue information, and save.

#### Creation through Monitors

**Creation through monitors** means generating event information via monitors to create issues.

1. Log in to <<< custom_key.brand_name >>> console
2. Click the **Monitoring** menu on the left
3. You can add new monitors or adjust existing ones. Edit the corresponding monitor, enable the **Synchronize Issue Creation** switch, and save.

## Effect Diagrams

### Jira Effect:

![Img](../images/im_jira_04.png)
Automatically generates Jira issues, and after commenting, the handling process of the `issue` can be displayed on <<< custom_key.brand_name >>>.


### <<< custom_key.brand_name >>> Effect

The handling process of Jira `issues` will also be synchronized on <<< custom_key.brand_name >>>.

![Img](../images/im_jira_05.png)