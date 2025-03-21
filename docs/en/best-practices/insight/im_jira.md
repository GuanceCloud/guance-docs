# Best Practices for Bidirectional Integration between Incident and JIRA

---

> _Authors: Su Tongtong, Liu Rui_

[**Incident**](/exception/) is a communication management tool launched by <<< custom_key.brand_name >>> for effective coordination of internal incidents.

**JIRA** is an enterprise-level project management tool.

???+ info

    When an application or system encounters an incident, it typically needs to be handled promptly to ensure normal system operation. By integrating [**Incident**](/exception/) with JIRA bidirectionally, relevant personnel within the enterprise can quickly understand and analyze the cause of the problem, trace and record the handling process, effectively improving communication efficiency and significantly reducing incident resolution costs.

![Incident Interaction Process with IM —— Jira Flowchart](../images/im_jira_01.png)

## Preparation

- [x] Jira platform (requires administrator privileges)
- [x] <<< custom_key.brand_name >>> workspace account
- [x] [Dataflux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/) 

## Jira

Obtain the corresponding project key, project URL, API token, and username from the Jira platform. These will be used in subsequent <<< custom_key.brand_name >>> scripts.

**Only administrators have permission to perform these operations**

## <<< custom_key.brand_name >>>

### Create API Key

Refer to the documentation for [API Key](/management/api-key/index.md).

Set the key name to `Jira System` to distinguish whether the comment information originates from <<< custom_key.brand_name >>> or Jira. The key name will also appear as the user in <<< custom_key.brand_name >>> `issue`.

### Func Script Development

- Log in to Func

Log in to the deployed [Dataflux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/)

- Add Python Dependencies

1. Click on the **Manage** menu
2. Click **Experimental Features**, turn on the **Enable PIP Tool** switch. If already enabled, ignore this step.
3. Click **PIP Tool**, install the **Python package**, enter **jira**, select the default data source. If the default data source does not contain the current dependency, switch to another data source and click the **Install** button to complete the dependency installation.

- Write the Script

1. Click on the **Development** menu;
2. Click the **Create Script Set** button, fill in the script **ID**, which can be customized. Here, fill in `Issue_to_jira`, then click the **Save** button;
3. Select `Issue_to_jira`, click **Create Script**, this ID can also be customized;
4. Paste the following script content and adjust the configuration information.

```python
import requests
import json
import time
from datetime import datetime, timedelta
from jira import JIRA

# <<< custom_key.brand_name >>> configuration, note to modify df_api_key
base_url = 'https://openapi.<<< custom_key.brand_main_domain >>>'
channel_list_url = base_url + '/api/v1/channel/quick_list'
issue_list_url = base_url + '/api/v1/issue/list'
create_issue_reply_url = base_url + '/api/v1/issue/reply/create'
df_api_key = 'vy2EV......fuTtn'

# JIRA configuration, all configurations are mandatory, modify them for your environment
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
                            'issuetype': {'name': 'Bug'},
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

Click the **Publish** button to complete the publication. After publishing, the API is successfully published and can provide external services.

- Automatic Trigger Configuration

**Automatic Trigger Configuration** can schedule API execution.

1. From the **Manage** menu, click the **Automatic Trigger Configuration** button;
2. Click the **New** button in the top-right corner to create a new configuration;
3. Select the script to execute. Parameters can be left unspecified. Choose the execution frequency, here set it to **Repeat Every Minute**, and **Save**.

![Img](../images/im_jira_03.png)

### Create Issue

<<< custom_key.brand_name >>> supports two methods for creating issues:

- [x] Direct Creation
- [x] Creation via Monitor

#### Direct Creation

1. Log in to the <<< custom_key.brand_name >>> console
2. Click the **Incident** menu, then click the **Create Issue** button in the top-right corner. Fill in the issue information and save.

#### Creation via Monitor

**Creation via Monitor** involves generating event information through monitors to create issues.

1. Log in to the <<< custom_key.brand_name >>> console
2. Click the **Monitoring** menu on the left
3. You can add new monitors or adjust existing ones. Edit the corresponding monitor, enable the **Synchronize Issue Creation** switch, and save.

## Screenshots

### Jira Effect:

![Img](../images/im_jira_04.png)
Jira issues are automatically generated, and when comments are made, the handling process of the `issue` can be displayed on <<< custom_key.brand_name >>>.

### <<< custom_key.brand_name >>> Effect

<<< custom_key.brand_name >>> synchronizes the Jira `issue` handling process.

![Img](../images/im_jira_05.png)