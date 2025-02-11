# Create a Single Scheduled Report

---

<br />**POST /api/v1/crontab_report/add**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| title | string | Y | Scheduled report title<br>Allow null: True <br>Maximum length: 200 <br> |
| content | string |  | Scheduled report content<br>Allow null: True <br>Maximum length: 1000 <br>Allow empty string: True <br> |
| dashboardUUID | string | Y | Dashboard UUID<br>Allow null: False <br> |
| recipient | array | Y | Recipient information<br>Example: [acnt_xxxx, 22@qq.com, acnt_yyy] <br>Allow null: False <br> |
| variables | json |  | View variable information<br>Allow null: True <br> |
| timeRange | string | Y | Query time range<br>Example: 1d <br>Allow null: True <br> |
| crontab | string |  | Crontab for scheduled task<br>Example: 1 2 * * * <br>Allow null: True <br>Allow empty string: True <br> |
| singleExecuteTime | int |  | Timestamp for single execution<br>Allow null: True <br> |
| extend | json |  | Additional information<br>Allow null: True <br> |
| timezone | string | Y | Timezone for the scheduled report<br>Example: Asia/Shanghai <br>Allow null: True <br> |
| notifyType | string | Y | Notification type for the scheduled report<br>Example: email <br>Allow null: True <br>Possible values: ['email', 'dingTalkRobot', 'wechatRobot', 'feishuRobot'] <br> |

## Additional Parameter Explanation


Data description.*

- Request parameter explanation

| Parameter Name           | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| title       | string | Scheduled report title |
| content             | string | Scheduled report content                                                 |
| dashboardUUID       | string  | Dashboard UUID of the scheduled report     |
| recipient            | list  | List of recipients for the scheduled report, including user account acnt_/email/notification object UUID                                         |
| variables            | json  | View variable information                                         |
| timeRange            | string  | Query time range, integer plus d/h/m format, e.g., 3d, 15m, 2h                                       |
| crontab            | string  | Crontab for repeated scheduled tasks                                         |
| singleExecuteTime            | int  | Timestamp for single execution                                         |
| extend            | json  | Extended information used for displaying information on the frontend interface                                         |
| timezone            | string  | Timezone                                         |
| notifyType            | string  | Notification type, enumerated values (email, dingTalkRobot, wechatRobot, feishuRobot)                                         |

- Extend field explanation

| Parameter Name           | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| shareConfig       | json | Share configuration for the scheduled report |    ｜
| shareConfig.shareMethod  | string | Share method for the scheduled report, public or enciphered. Default is public                           |
| shareConfig.password     | string | Password for encrypted sharing of the scheduled report                         |




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/crontab_report/add' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Accept: application/json, text/plain, */*' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"title":"ceshi2","content":"","dashboardUUID":"dsbd_xxxx32","recipient":["acnt_xxxx32"],"timeRange":"1d","singleExecuteTime":1698718800,"crontab":"","extend":{"cycleTimeType":"once","hour":"10","minutes":"20","dashboardInfo":{"value":"dsbd_xxxx32","label":"whytest"}},"timezone":"Asia/Shanghai","notifyType":"email"}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "content": "",
        "createAt": 1698665760,
        "creator": "wsak_xxxxx",
        "crontab": "",
        "dashboardUUID": "dsbd_xxxx32",
        "deleteAt": -1,
        "executed": 0,
        "extend": {
            "cycleTimeType": "once",
            "dashboardInfo": {
                "label": "whytest",
                "value": "dsbd_xxxx32"
            },
            "hour": "10",
            "minutes": "20"
        },
        "id": 205,
        "isLocked": 0,
        "notifyType": "email",
        "recipient": [
            "acnt_xxxx32"
        ],
        "singleExecuteTime": 1698718800,
        "status": 0,
        "timeRange": "1d",
        "timezone": "Asia/Shanghai",
        "title": "ceshi2",
        "updateAt": 1698665760,
        "updator": "wsak_xxxxx",
        "uuid": "cron_xxxx32",
        "variables": {},
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-F4667E68-FB26-4987-891B-F00909A2948D"
} 
```