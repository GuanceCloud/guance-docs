# 修改单个定时报告

---

<br />**POST /api/v1/crontab_report/\{report_uuid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| report_uuid | string | Y | 定时报告的uuid<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| title | string | Y | 定时报告名称<br>允许为空: True <br>最大长度: 200 <br> |
| content | string |  | 定时报告内容<br>允许为空: True <br>最大长度: 1000 <br>允许空字符串: True <br> |
| dashboardUUID | string | Y | 仪表板uuid<br>允许为空: False <br> |
| recipient | array | Y | 收件人信息<br>例子: [acnt_xxxx, 22@qq.com, acnt_yyy] <br>允许为空: False <br> |
| variables | json |  | 视图变量信息<br>允许为空: True <br> |
| timeRange | string | Y | 查询时间范围<br>例子: 1d <br>允许为空: True <br> |
| crontab | string |  | 定时任务的crontab<br>例子: 1 2 * * * <br>允许为空: True <br>允许空字符串: True <br> |
| singleExecuteTime | int |  | 单次执行的时间戳<br>允许为空: True <br> |
| extend | json |  | 额外信息<br>允许为空: True <br> |
| timezone | string | Y | 定时报告时区<br>例子: Asia/Shanghai <br>允许为空: True <br> |
| notifyType | string | Y | 定时报告通知类型<br>例子: email <br>允许为空: True <br>可选值: ['email', 'dingTalkRobot', 'wechatRobot', 'feishuRobot'] <br> |

## 参数补充说明


数据说明.*

- 请求参数说明

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| title       | string | 定时报告名称 |
| content             | string | 定时报告内容                                                 |
| dashboardUUID       | string  | 定时报告的仪表板UUID     |
| recipient            | list  | 定时报告的接收人信息列表,用户账号acnt_/邮箱/通知对象uuid                                         |
| variables            | json  | 视图变量信息                                         |
| timeRange            | string  | 查询时间范围,整数加d/h/m格式, 列如: 3d, 15m, 2h                                       |
| crontab            | string  | 重复执行的定时任务的crontab                                         |
| singleExecuteTime            | int  | 单次执行的时间戳                                         |
| extend            | json  | 扩展信息,用于前端界面展示信息显示                                         |
| timezone            | string  | 时区                                         |
| notifyType            | string  | 通知类型,枚举值(email,dingTalkRobot,wecharRobot, feishuRobot)                                         |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/crontab_report/cron_cf1be3e00408416b9a1f1b8a7e233223/modify' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Accept: application/json, text/plain, */*' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"title":"ceshi3","content":"","dashboardUUID":"dsbd_28a1718f1b5547a58a40f2167948bdc6","recipient":["notify_b1f535d0b52a4788a6343778fab64ba0"],"timeRange":"1d","singleExecuteTime":-1,"crontab":"10 10 03,14,13 * *","variables":{},"extend":{"cycleTimeType":"day","hour":"10","minutes":"10","dashboardInfo":{}},"timezone":"Asia/Shanghai","notifyType":"dingTalkRobot"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "content": "",
        "createAt": 1698666812,
        "creator": "wsak_818fc4d5ff714411b0cc4db916de3e5f",
        "crontab": "10 10 03,14,13 * *",
        "dashboardUUID": "dsbd_28a1718f1b5547a58a40f2167948bdc6",
        "deleteAt": -1,
        "executed": 0,
        "extend": {
            "cycleTimeType": "day",
            "dashboardInfo": {},
            "hour": "10",
            "minutes": "10"
        },
        "id": 206,
        "isLocked": 0,
        "notifyType": "dingTalkRobot",
        "recipient": [
            "notify_b1f535d0b52a4788a6343778fab64ba0"
        ],
        "singleExecuteTime": -1,
        "status": 0,
        "timeRange": "1d",
        "timezone": "Asia/Shanghai",
        "title": "ceshi3",
        "updateAt": 1698667256,
        "updator": "wsak_818fc4d5ff714411b0cc4db916de3e5f",
        "uuid": "cron_cf1be3e00408416b9a1f1b8a7e233223",
        "variables": {},
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-060F8B2A-6502-44AB-81A0-E51E4006D205"
} 
```



