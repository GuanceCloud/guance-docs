# Create a single scheduled report

---

<br />**POST /api/v1/crontab_report/add**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| title | string | Y | Scheduled report name<br>Allow empty: True <br>Maximum length: 200 <br> |
| content | string |  | Scheduled report content<br>Allow empty: True <br>Maximum length: 1000 <br>Allow empty string: True <br> |
| dashboardUUID | string | Y | Dashboard uuid<br>Allow empty: False <br> |
| recipient | array | Y | Recipient information<br>Example: [acnt_xxxx, xxx@<<< custom_key.brand_main_domain >>>, acnt_yyy] <br>Allow empty: False <br> |
| variables | json |  | View variable information<br>Allow empty: True <br> |
| timeRange | string | Y | Query time range<br>Example: 1d <br>Allow empty: True <br> |
| crontab | string |  | Crontab for the scheduled task<br>Example: 1 2 * * * <br>Allow empty: True <br>Allow empty string: True <br> |
| singleExecuteTime | int |  | Timestamp for single execution<br>Allow empty: True <br> |
| extend | json |  | Additional information<br>Allow empty: True <br> |
| timezone | string | Y | Scheduled report timezone<br>Example: Asia/Shanghai <br>Allow empty: True <br> |
| notifyType | string | Y | Scheduled report notification type<br>Example: email <br>Allow empty: True <br>Optional values: ['email', 'dingTalkRobot', 'wechatRobot', 'feishuRobot'] <br> |

## Supplementary Parameter Explanation


Data explanation.*

- Request parameter explanation

| Parameter Name           | type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| title       | string | Scheduled report name |
| content             | string | Scheduled report content                                                 |
| dashboardUUID       | string  | Scheduled report's dashboard UUID     |
| recipient            | list  | List of recipients for the scheduled report, user account acnt_/email/notification target uuid                                         |
| variables            | json  | View variable information                                         |
| timeRange            | string  | Query time range, integer plus d/h/m format, example: 3d, 15m, 2h                                       |
| crontab            | string  | Crontab for repeated execution of the scheduled task                                         |
| singleExecuteTime            | int  | Timestamp for single execution                                         |
| extend            | json  | Extended information, used for displaying interface information                                         |
| timezone            | string  | Timezone                                         |
| notifyType            | string  | Notification type, enumerated values (email, dingTalkRobot, wecharRobot, feishuRobot)                                         |

- Extend extended field explanation

| Parameter Name           | type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| shareConfig       | json | Scheduled report sharing configuration |    ｜
| shareConfig.shareMethod  | string | Scheduled report sharing configuration public or enciphered default is public                           |
| shareConfig.password     | string | Scheduled report sharing password encrypted sharing password                         |




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