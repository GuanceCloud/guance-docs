# Modify a Single Scheduled Report

---

<br />**POST /api/v1/crontab_report/\{report_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| report_uuid | string | Y | UUID of the scheduled report<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| title | string | Y | Name of the scheduled report<br>Allow null: True <br>Maximum length: 200 <br> |
| content | string |  | Content of the scheduled report<br>Allow null: True <br>Maximum length: 1000 <br>Allow empty string: True <br> |
| dashboardUUID | string | Y | UUID of the dashboard<br>Allow null: False <br> |
| recipient | array | Y | Recipient information<br>Example: [acnt_xxxx, 22@qq.com, acnt_yyy] <br>Allow null: False <br> |
| variables | json |  | View variable information<br>Allow null: True <br> |
| timeRange | string | Y | Query time range<br>Example: 1d <br>Allow null: True <br> |
| crontab | string |  | Crontab expression for the scheduled task<br>Example: 1 2 * * * <br>Allow null: True <br>Allow empty string: True <br> |
| singleExecuteTime | int |  | Timestamp for single execution<br>Allow null: True <br> |
| extend | json |  | Additional information<br>Allow null: True <br> |
| timezone | string | Y | Timezone for the scheduled report<br>Example: Asia/Shanghai <br>Allow null: True <br> |
| notifyType | string | Y | Notification type for the scheduled report<br>Example: email <br>Allow null: True <br>Possible values: ['email', 'dingTalkRobot', 'wechatRobot', 'feishuRobot'] <br> |

## Additional Parameter Explanation


Data Explanation.*

- Request parameter explanation

| Parameter Name           | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| title       | string | Name of the scheduled report |
| content             | string | Content of the scheduled report                                                 |
| dashboardUUID       | string  | UUID of the dashboard associated with the scheduled report     |
| recipient            | list  | List of recipients for the scheduled report, including user accounts (acnt_/email/notification target UUID)                                         |
| variables            | json  | View variable information                                         |
| timeRange            | string  | Query time range, in the format of integer + d/h/m, e.g., 3d, 15m, 2h                                       |
| crontab            | string  | Crontab expression for repeated execution of the scheduled task                                         |
| singleExecuteTime            | int  | Timestamp for single execution                                         |
| extend            | json  | Extended information, used for displaying additional information on the frontend interface                                         |
| timezone            | string  | Timezone                                         |
| notifyType            | string  | Notification type, enum values (email, dingTalkRobot, wechatRobot, feishuRobot)                                         |

- Extend field explanation

| Parameter Name           | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| shareConfig       | json | Sharing configuration for the scheduled report |    ｜
| shareConfig.shareMethod  | string | Sharing method for the scheduled report: public or enciphered. Default is public                           |
| shareConfig.password     | string | Password for encrypted sharing of the scheduled report                         |




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/crontab_report/cron_xxxx32/modify' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Accept: application/json, text/plain, */*' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"title":"test3","content":"","dashboardUUID":"dsbd_xxxx32","recipient":["notify_xxxx32"],"timeRange":"1d","singleExecuteTime":-1,"crontab":"10 10 03,14,13 * *","variables":{},"extend":{"cycleTimeType":"day","hour":"10","minutes":"10","dashboardInfo":{}},"timezone":"Asia/Shanghai","notifyType":"dingTalkRobot"}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "content": "",
        "createAt": 1698666812,
        "creator": "wsak_xxxxx",
        "crontab": "10 10 03,14,13 * *",
        "dashboardUUID": "dsbd_xxxx32",
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
            "notify_xxxx32"
        ],
        "singleExecuteTime": -1,
        "status": 0,
        "timeRange": "1d",
        "timezone": "Asia/Shanghai",
        "title": "test3",
        "updateAt": 1698667256,
        "updator": "wsak_xxxxx",
        "uuid": "cron_xxxx32",
        "variables": {},
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-060F8B2A-6502-44AB-81A0-E51E4006D205"
} 
```