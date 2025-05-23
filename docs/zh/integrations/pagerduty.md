---
title: '异常事件与 PagerDuty 联动'
summary: '当我们的应用程序或系统出现异常时，通常需要及时处理以保证系统的正常运行。为了更好地管理和跟踪异常事件，我们可以将这些事件发送到 PagerDuty 中创建事件，这样我们就可以在 PagerDuty 中进行跟踪、分析和解决这些问题，通过快速地将异常事件发送到 PagerDuty 中创建事件，为我们提供更好的管理和跟踪异常事件的能力，从而更好地保证系统的正常运行。同时，这种方法也可以帮助我们更好地分析和解决问题，提高系统的稳定性和可靠性。'
__int_icon: 'icon/pagerduty'
---

<!-- markdownlint-disable MD025 -->

# 异常事件与 PagerDuty 联动
<!-- markdownlint-enable -->

当我们的应用程序或系统出现异常时，通常需要及时处理以保证系统的正常运行。为了更好地管理和跟踪异常事件，我们可以将这些事件发送到 PagerDuty 中创建事件，这样我们就可以在 PagerDuty 中进行跟踪、分析和解决这些问题，通过快速地将异常事件发送到 PagerDuty 中创建事件，为我们提供更好的管理和跟踪异常事件的能力，从而更好地保证系统的正常运行。同时，这种方法也可以帮助我们更好地分析和解决问题，提高系统的稳定性和可靠性。

## 配置 {#config}

### 准备工作

1. 部署一个 [Dataflux Func <<< custom_key.brand_name >>>特别版](https://<<< custom_key.func_domain >>>/#/) 生成授权链接
2. 创建[webhook 自定义通知对象](<<< homepage >>>/monitoring/notify-object/#4-webhook) (webhook 地址为 Func 授权链接地址)
3. 正确配置[监控器](<<< homepage >>>/monitoring/monitor/)
4. 在 PagerDuty 中创建一个 **Integrations** 为**Events API V2** 的 Services



### 部署流程

#### 创建 Webhook 自定义通知对象

在<<< custom_key.brand_name >>> studio 中【监控/通知对象管理】中新建一个通知对象，选择**webhook 自定义**，webhook 地址填入我们部署的 Dataflux Func 的授权链接地址

![1693212890543.png](imgs/pagerduty/pagerduty01.png)

> 注意 Func 中的授权链接请选择不带参数的授权链接

#### 创建监控器

在<<< custom_key.brand_name >>> studio 中【监控/监控器】中新建一个监控器，选择需要观测的指标，配置好事件的通知内容后需要将告警策略中的告警通知对象指定为我们刚刚创建的**webhook 自定义**的通知对象的名称。

![1693212934306.png](imgs/pagerduty/pagerduty02.png)

#### 编写监听脚本

在做好监控器的检测规则配置后，我们需要在已经安装配置好的 Dataflux Func 中编写获取新消息并发送到 PagerDuty 生成事件的脚本。

首先我们需要引入一些常量，比如 `events_url`, `routing_key`等。

```Python
import requests
import json

events_url = "https://events.pagerduty.com/v2/enqueue"
routing_key = "xxxxxxxxxx"
```

再引入了我们需要的常量后我们需要知道监控事件的数据结构，从而解析并创建发送到 PagerDuty 的事件

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
    "df_event_link":"https://<<< custom_key.studio_main_site >>>/keyevents/monitor?time=1693034040000%2C1693035000000&tags=%7B%22df_event_id%22%3A%22event-f20a38aa58b54c6c8d4c9a84e655db1a%22%7D&w=wksp_968577392a1c4714a464cd2f6ee42a9c",
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
    "df_monitor_checker_name":"\u5b9e\u4f8b\u540d\u79f0\u4e3a {{host}} \u78c1\u76d8\u4f7f\u7528\u7387\u8fc7\u9ad8",
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

在这个 **Json** 中包含了我们需要用到的事件标题`df_title`、事件详情`df_message`和事件状态`df_status`等信息，当然这个 **Json** 中也包含了事件生产时间、异常值、工作空间 ID 等其他相关的信息，如果我们有需要的话也可以自行填入到我们需要生成的事件中去。

再明确了输入的数据结构后，我们就可以编写创建 PagerDuty 事件的函数了

```Python
@DFF.API('Create_PagerDuty_Issue_Reply')
def create_pagerduty_issue_reply(**kwargs):
    # 获取<<< custom_key.brand_name >>>事件数据
    event = json.dumps(kwargs)
    print("Guance_event：", event)
    summary  = kwargs["df_title"]
    description = kwargs["df_message"]
    serverity = kwargs["df_status"]
    df_event_link = kwargs["df_event_link"]
    workspace_name = kwargs["workspace_name"]
    result = kwargs["Result"]
    date = kwargs["date"]
    # 构建请求数据
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
            "severity": serverity,
            "custom_details": {
                "result": result,
                "date": date,
                "description": description
            }
        },
        "client": "Guance" + workspace_name,
        "client_url": df_event_link
    }
    # 创建事件
    response = requests.post(events_url, headers=headers, data=json.dumps(payload))
    # 打印新事件
    print(response.status_code)
    print(response.text)
```

我们通过创建 PagerDuty 实例将获取到的<<< custom_key.brand_name >>>中的事件详情创建成事件字典，从而发送的 PagerDuty 中，再发送成功后会生日志包含`dedup_key`和`status`信息

![1693213100705.png](imgs/pagerduty/pagerduty03.png)

然后我们就可以在 PagerDuty 中和邮件中查看到相应的告警信息了

![1693213121459.png](imgs/pagerduty/pagerduty04.png)

也可以通过 PagerDuty 配置的邮箱收取告警信息

![169321311459.png](imgs/pagerduty/pagerduty05.png)

再编写好脚本后我们点击发布即可。
