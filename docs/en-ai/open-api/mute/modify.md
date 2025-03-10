# Modify a Mute Rule

---

<br />**POST /api/v1/monitor/mute/\{obj_uuid\}/modify**

## Overview
Modify a mute rule




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| obj_uuid             | string   | Y         | ID of the mute configuration<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| name                 | string   |           | Rule name<br>Example: Name A <br>Allow empty: False <br> |
| description          | string   |           | Description<br>Example: Description A <br>Allow empty: False <br>Allow empty string: True <br> |
| tags                 | json     |           | Set of tags<br>Allow empty: False <br> |
| filterString         | string   |           | Event properties<br>Allow empty: False <br>Allow empty string: True <br>Maximum length: 2048 <br> |
| muteRanges           | array    |           | Mute ranges<br>Example: Monitor A <br>Allow empty: False <br> |
| notifyTargets        | array    |           | Notification targets<br>Allow empty: False <br> |
| notifyMessage        | string   |           | Notification message<br>Allow empty: False <br>Maximum length: 3000 <br> |
| notifyTimeStr        | string   |           | Notification time, %Y/%m/%d %H:%M:%S<br>Example: 2023/08/21 19:19:00 <br>Allow empty: False <br>Allow empty string: True <br> |
| startTime            | string   |           | Start time %Y/%m/%d %H:%M:%S<br>Example: 2023/08/21 19:19:00 <br>Allow empty: False <br> |
| endTime              | string   |           | End time %Y/%m/%d %H:%M:%S<br>Example: 2023/08/21 19:19:00 <br>Allow empty: False <br>Allow empty string: True <br> |
| repeatTimeSet        | int      | Y         | Set to 1 for repeating, set to 0 for single occurrence<br>Example: 0 <br>Allow empty: False <br> |
| repeatCrontabSet     | None     |           | Repeating crontab configuration<br>Allow empty: False <br> |
| repeatCrontabSet.min | string   |           | Minute<br>Example: 10 <br>Allow empty: False <br> |
| repeatCrontabSet.hour| string   |           | Hour<br>Example: 10 <br>Allow empty: False <br> |
| repeatCrontabSet.day | string   |           | Day<br>Example: * <br>Allow empty: False <br> |
| repeatCrontabSet.month| string  |           | Month<br>Example: * <br>Allow empty: False <br> |
| repeatCrontabSet.week| string   |           | Week<br>Example: 1,3 <br>Allow empty: False <br> |
| crontabDuration      | int      |           | Duration in seconds from end time minus start time<br>Example: 3600 <br>Allow empty: False <br> |
| repeatExpireTime     | string   |           | Expiration time for repeated mutes %Y/%m/%d %H:%M:%S<br>Example:  <br>Allow empty: False <br>Allow empty string: True <br> |
| timezone             | str      | Y         | Timezone for the mute rule<br>Example: Asia/Shanghai <br>Allow empty: False <br> |
| type                 | str      | Y         | Type of mute rule<br>Example: custom <br>Allow empty: False <br>Possible values: ['checker', 'alertPolicy', 'tag', 'custom'] <br> |
| declaration          | json     |           | Custom declaration information<br>Allow empty: False <br> |

## Additional Parameter Explanation


Data Explanation.*

- Request Parameter Explanation

| Parameter Name       | Type | Description                                                 |
| -------------------- | ---- | ----------------------------------------------------------- |
| muteRanges           | list | Mute ranges, including monitors, intelligent checks, user-defined checks, SLOs, alert strategies |
| name                 | str  | Rule name                                                   |
| description          | str  | Description                                                 |
| tags                 | dict | Tags                                                        |
| filterString         | str  | Event properties (expression format input)                  |
| notifyTargets        | list | List of notification objects, with type as notification type |
| repeatTimeSet        | int  | Whether to repeat mute, 1 for enabled, 0 for single occurrence |
| repeatCrontabSet     | dict | Configuration for repeating mute rules                      |
| crontabDuration      | int  | Duration in seconds for the scheduled task                   |
| notifyTargets        | list | List of notification objects, with type as notification type |
| notifyTimeStr        | str  | Notification time, %Y/%m/%d %H:%M:%S                        |
| startTime            | str  | Start time of mute, %Y/%m/%d %H:%M:%S                       |
| endTime              | str  | End time of mute, %Y/%m/%d %H:%M:%S                         |
| repeatExpireTime     | str  | Expiration time for repeated mute, %Y/%m/%d %H:%M:%S       |
| timezone             | str  | Task timezone, default is Asia/Shanghai                     |
| type                 | str  | Type of mute rule, checker: monitor: tag: custom            |
| repeatExpire         | int  | Expiration time for repeated mute (deprecated on 2023-08-24) |
| start                | int  | Start time of mute (deprecated on 2023-08-24)               |
| end                  | int  | End time of mute (deprecated on 2023-08-24)                 |
| notifyTime           | int  | Notification time, Unix timestamp in seconds, -1 for immediate notification (deprecated on 2023-08-24) |
| declaration          | dict | Custom declaration information                              |



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/monitor/mute/<obj_uuid>/modify' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"name":"Name A","description":"Description A","startTime":"2023/08/22 16:27:27","notifyTargets":[{"to":["notify_xxxx32"],"type":"notifyObject"}],"tags":{},"muteRanges":[{"name":"Multiple points {version}","checkerUUID":"rul_xxxx32","type":"Monitor"}],"type":"checker","timezone":"Asia/Shanghai","repeatTimeSet":1,"repeatCrontabSet":{"min":"0","hour":"1","day":"*","month":"*","week":"0,5,6,4"},"crontabDuration":10800,"repeatExpireTime":"2023/09/09 00:00:00","notifyTimeStr":"","notifyMessage":"dcscsadcsdacasdcsdacsdac"}' \
  --compressed \
  --insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1692771116,
        "creator": "acnt_xxxx32",
        "crontab": "",
        "crontabDuration": 0,
        "deleteAt": -1,
        "description": "Description A",
        "end": 1692772267,
        "endTime": "2023/08/23 14:31:07",
        "id": 643,
        "muteRanges": [
            {
                "checkerUUID": "rul_xxxx32",
                "name": "Aerospike cluster 【{cluster_name}】 namespace 【{{ ns }}】 has high Memory usage",
                "type": "Monitor"
            }
        ],
        "name": "Name A",
        "notifyMessage": "cjkackcnkjcklasc",
        "notifyTargets": [
            {
                "to": [
                    "acnt_xxxx32"
                ],
                "type": "mail"
            }
        ],
        "notifyTime": 1692769507,
        "notifyTimeStr": "2023/08/23 13:45:07",
        "repeatExpire": -1,
        "repeatExpireTime": "-1",
        "start": 1692770407,
        "startTime": "2023/08/23 14:00:07",
        "status": 0,
        "tags": {},
        "timezone": "Asia/Shanghai",
        "type": "checker",
        "updateAt": 1692771117,
        "updator": "acnt_xxxx32",
        "uuid": "mute_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-C5BE0235-BB41-437E-801E-F925E98F8616"
} 
```