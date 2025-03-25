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
| recipient | array | Y | Recipient information<br>Example: [acnt_xxxx, xxx@<<< custom_key.brand_main_domain >>>, acnt_yyy] <br>Allow null: False <br> |
| variables | json |  | View variable information<br>Allow null: True <br> |
| timeRange | string | Y | Query time range<br>Example: 1d <br>Allow null: True <br> |
| crontab | string |  | Crontab for the scheduled task<br>Example: 1 2 * * * <br>Allow null: True <br>Allow empty string: True <br> |
| singleExecuteTime | int |  | Timestamp for single execution<br>Allow null: True <br> |
| extend | json |  | Additional information<br>Allow null: True <br> |
| timezone | string | Y | Timezone for the scheduled report<br>Example: Asia/Shanghai <br>Allow null: True <br> |
| notifyType | string | Y | Notification type for the scheduled report<br>Example: email <br>Allow null: True <br>Optional values: ['email', 'dingTalkRobot', 'wechatRobot', 'feishuRobot'] <br> |

## Parameter Supplementary Notes


Data notes.*

- Request parameter notes

| Parameter Name           | type | Description                                                 |
| ------------------------ | ---- | ---------------------------------------------------------- |
| title       | string | Name of the scheduled report |
| content             | string | Content of the scheduled report                                                 |
| dashboardUUID       | string  | Dashboard UUID of the scheduled report     |
| recipient            | list  | List of recipient information for the scheduled report, including user account acnt_/email/notification target uuid                                         |
| variables            | json  | View variable information                                         |
| timeRange            | string  | Query time range, integer plus d/h/m format, such as: 3d, 15m, 2h                                       |
| crontab            | string  | Crontab for repeated execution of the scheduled task                                         |
| singleExecuteTime            | int  | Timestamp for single execution                                         |
| extend            | json  | Extended information used to display information on the frontend interface                                         |
| timezone            | string  | Timezone                                         |
| notifyType            | string  | Notification type, enumerated values (email, dingTalkRobot, wechatRobot, feishuRobot)                                         |

- Notes on the extend extended field

| Parameter Name           | type | Description                                                 |
| ------------------------ | ---- | ---------------------------------------------------------- |
| shareConfig       | json | Share configuration for the scheduled report |    ｜
| shareConfig.shareMethod  | string | Share method for the scheduled report public or enciphered default is public                           |
| shareConfig.password     | string | Password for sharing the scheduled report encrypted share password                         |




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/crontab_report/cron_xxxx32/modify' \
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