# 异常追踪与 JIRA 实现双向联动最佳实践

---

> _作者： 苏桐桐、刘锐_

[**异常追踪**](/exception/) 是<<< custom_key.brand_name >>>推出的、基于内部异常有效协调的沟通管理工具。

**JIRA** 为企业内部项目管理工具。

???+ info

    当应用程序或系统出现异常时，通常需要及时处理以保证系统的正常运行。通过[**异常追踪**](/exception/)与 JIRA 双向联动，可以让企业内部相关人员快速了解、分析问题故障发生的原因、追溯并记录故障的处理过程，有效提高人员的沟通效率，极大降低了故障处理成本。



![异常追踪与 IM 互动流程——Jira流程图](../images/im_jira_01.png)


## 准备工作

- [x] Jira 平台（需要有管理员权限）
- [x] <<< custom_key.brand_name >>>空间帐号
- [x] [Dataflux Func <<< custom_key.brand_name >>>特别版](https://func.guance.com/) 


## Jira

获取 Jira 平台对应项目的 project、项目地址、api_token、username，后续<<< custom_key.brand_name >>>脚本需要用到。

**只有管理员才有权限进行以上操作**



## <<< custom_key.brand_name >>>

### 创建 API Key

API Key 可参考文档 [API Key](/management/api-key/index.md)

其中 key name 设置为 `Jira 系统`，有利于区分该评论信息来源于<<< custom_key.brand_name >>>或者是 Jira，且 key name 会作为 user 展示在<<< custom_key.brand_name >>> `issue` 当中。

### Func 脚本编写

- 登陆 Func

登陆到已经部署的[Dataflux Func <<< custom_key.brand_name >>>特别版](https://func.guance.com/) 

- 添加 Python 依赖

1. 点击 **管理** 菜单
2. 点击 **实验性功能**，打开**启用 PIP 工具**开关，如已开启，请忽略此步骤。
3. 点击 **PIP 工具**，安装 **Python 包**，填入**jira**，选择默认数据源即可，如果默认数据源没有当前依赖，可以切换其他数据源，点击**安装**按钮，完成依赖安装操作。

- 编写脚本

1. 点击 **开发** 菜单;
2. 点击 **新建脚本集** 按钮，填写脚本**ID**，可以自定义，这里填写`Issue_to_jira`，点击 **保存**按钮；
3. 选择 `Issue_to_jira`，点击**新建脚本**，这个ID 也可以随便写；
4. 粘贴以下脚本内容，调整配置信息。

```python
import requests
import json
import time
from datetime import datetime, timedelta
from jira import JIRA

# <<< custom_key.brand_name >>>配置，注意修改df_api_key
base_url = 'https://openapi.guance.com'
channel_list_url = base_url + '/api/v1/channel/quick_list'
issue_list_url = base_url + '/api/v1/issue/list'
create_issue_reply_url = base_url + '/api/v1/issue/reply/create'
df_api_key = 'vy2EV......fuTtn'

# JIRA配置，以下配置均为必填项,修改为自己的环境
username = 'sutt'
api_token = 'ATATT3xFfGF0eVvhZUkO0tTas8JnNYEsxGIJqWGinVyQL0ME......B6E'
jira_server_url = 'https://***.net/'
project_key = 'projectName'

#连接JIRA
def connect_to_jira(username, api_token, jira_server_url):
    try:
        jira_connection = JIRA(basic_auth=(username, api_token), server=jira_server_url)
        print("成功连接到JIRA!")
        return jira_connection
    except Exception as e:
        print(f"连接JIRA出错: {e}")
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
                print(issue_response.text)  # 打印响应内容，帮助调试

                if issue_response.status_code == 200:
                    issue_lists = issue_response.json()['content']
                    for issue in issue_lists:
                        issue_uuid = issue["uuid"]
                        print(f"UUID from Guance: {issue_uuid}")  # 打印 UUID 调试

                        issue_data = {
                            'project': {'key': project_key},
                            'summary': issue["name"],
                            'description': issue["description"],
                            'issuetype': {'name': '缺陷'},
                            'priority': {'name': 'Medium'},
                            'labels': [issue_uuid]  # 使用label来存储issue_id
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
        print("在过去的一分钟内没有更新的事务或者新的评论。")

@DFF.API('Create_JIRA_Issue_Reply2')
def guance():
    print("do start")
    sync_issues_from_guance_to_jira()
    sync_comments_from_jira_to_guance()

```

![Img](../images/im_jira_02.png)

- 发布脚本

点击**发布**按钮即完成发布。发布完成后，表示 API 已经发布成功，可以对外进行服务。

- 自动触发配置

**自动触发配置** 可以定时执行 API。

1. 从**管理**菜单进入，点击**自动触发配置**按钮;
2. 点击右上角**新建**按钮进行新建;
3. 选择执行的脚本，参数可以不指定，勾选对应的执行频率，这里调整为按**每分钟重复**，**保存**即可。

![Img](../images/im_jira_03.png)


### 创建 issue

<<< custom_key.brand_name >>>有两种创建 issue 的方式

- [x] 直接创建
- [x] 通过监控器创建

#### 直接创建

1. 登陆<<< custom_key.brand_name >>>控制台
2. 点击**异常追踪**菜单，点击右上角**新建Issue**按钮，填写 issue 信息，保存即可。

#### 通过监控器创建

**通过监控器创建**即通过监控器产生事件信息，进行创建issue。

1. 登陆<<< custom_key.brand_name >>>控制台
2. 点击左侧**监控**菜单
3. 可以新增监控器，也可以调整原有的监控器。编辑对应的监控器，开启**同步创建 Issue**开关，保存。

## 效果图

### Jira 效果：

![Img](../images/im_jira_04.png)
自动产生了 Jira issue，当进行评论后，可以在<<< custom_key.brand_name >>>上展示 `issue` 的处理过程。


### <<< custom_key.brand_name >>>效果

<<< custom_key.brand_name >>>上也会同步 Jira `issue` 处理过程。

![Img](../images/im_jira_05.png)
