# Create a Single Scheduled Report

---

<br />**POST /api/v1/crontab_report/add**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| title | string | Y | Scheduled report title<br>Allow null: True <br>Maximum length: 200 <br> |
| content | string | N | Scheduled report content<br>Allow null: True <br>Maximum length: 1000 <br>Allow empty string: True <br> |
| dashboardUUID | string | Y | Dashboard UUID<br>Allow null: False <br> |
| recipient | array | Y | Recipient information<br>Example: [acnt_xxxx, 22@qq.com, acnt_yyy] <br>Allow null: False <br> |
| variables | json | N | View variable information<br>Allow null: True <br> |
| timeRange | string | Y | Query time range<br>Example: 1d <br>Allow null: True <br> |
| crontab | string | N | Crontab for scheduled task<br>Example: 1 2 * * * <br>Allow null: True <br>Allow empty string: True <br> |
| singleExecuteTime | int | N | Timestamp for single execution<br>Allow null: True <br> |
| extend | json | N | Additional information<br>Allow null: True <br> |
| timezone | string | Y | Timezone for scheduled report<br>Example: Asia/Shanghai <br>Allow null: True <br> |
| notifyType | string | Y | Notification type for scheduled report<br>Example: email <br>Allow null: True <br>Optional values: ['email', 'dingTalkRobot', 'wechatRobot', 'feishuRobot'] <br> |

## Additional Parameter Notes


Data Description.*

- Request Parameter Explanation

| Parameter Name           | Type | Description                                                 |
| ------------------------ | ---- | ----------------------------------------------------------- |
| title       | string | Scheduled report title |
| content             | string | Scheduled report content                                                 |
| dashboardUUID       | string  | Dashboard UUID for the scheduled report     |
| recipient            | list  | List of recipients for the scheduled report, including user account acnt_/email/notification target UUID                                         |
| variables            | json  | View variable information                                         |
| timeRange            | string  | Query time range, in format integer+d/h/m, e.g., 3d, 15m, 2h                                       |
| crontab            | string  | Crontab for repeated scheduled tasks                                         |
| singleExecuteTime            | int  | Timestamp for single execution                                         |
| extend            | json  | Extended information used for displaying on the frontend interface                                         |
| timezone            | string  | Timezone                                         |
| notifyType            | string  | Notification type, enum values (email, dingTalkRobot, wechatRobot, feishuRobot)                                         |

- Extend Field Explanation

| Parameter Name           | Type | Description                                                 |
| ------------------------ | ---- | ----------------------------------------------------------- |
| shareConfig       | json | Sharing configuration for the scheduled report |    ｜
| shareConfig.shareMethod  | string | Sharing method for the scheduled report, public or enciphered, default is public                           |
| shareConfig.password     | string | Password for encrypted sharing of the scheduled report                         |




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/crontab_report/add' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Accept: application/json, text/plain, */*' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"title":"test2","content":"","dashboardUUID":"dsbd_xxxx32","recipient":["acnt_xxxx32"],"timeRange":"1d","singleExecuteTime":1698718800,"crontab":"","extend":{"cycleTimeType":"once","hour":"10","minutes":"20","dashboardInfo":{"value":"dsbd_xxxx32","label":"whytest"}},"timezone":"Asia/Shanghai","notifyType":"email"}' \
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
        "title": "test2",
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