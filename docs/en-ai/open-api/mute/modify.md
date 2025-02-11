# Modify a Mute Rule

---

<br />**POST /api/v1/monitor/mute/\{obj_uuid\}/modify**

## Overview
Modify a mute rule



## Route Parameters

| Parameter Name    | Type   | Required | Description               |
|:--------------|:-----|:-------|:------------------------|
| obj_uuid     | string | Y      | ID of the mute configuration<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-----------------|:------|:----|:--------------------------|
| name             | string | N   | Rule name<br>Example: Name A <br>Can be empty: False <br> |
| description      | string | N   | Description<br>Example: Description A <br>Can be empty: False <br>Can be an empty string: True <br> |
| tags             | json   | N   | Tag set<br>Can be empty: False <br> |
| filterString     | string | N   | Event attributes<br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 2048 <br> |
| muteRanges       | array  | N   | Mute ranges<br>Example: Monitor A <br>Can be empty: False <br> |
| notifyTargets    | array  | N   | Notification targets<br>Can be empty: False <br> |
| notifyMessage    | string | N   | Notification message<br>Can be empty: False <br>Maximum length: 3000 <br> |
| notifyTimeStr    | string | N   | Notification time, %Y/%m/%d %H:%M:%S<br>Example: 2023/08/21 19:19:00 <br>Can be empty: False <br>Can be an empty string: True <br> |
| startTime        | string | N   | Start time %Y/%m/%d %H:%M:%S<br>Example: 2023/08/21 19:19:00 <br>Can be empty: False <br> |
| endTime          | string | N   | End time %Y/%m/%d %H:%M:%S<br>Example: 2023/08/21 19:19:00 <br>Can be empty: False <br>Can be an empty string: True <br> |
| repeatTimeSet    | int    | Y   | Set to 1 for repeated mute, set to 0 for one-time mute<br>Example: 0 <br>Can be empty: False <br> |
| repeatCrontabSet | None   | N   | Repeated crontab configuration<br>Can be empty: False <br> |
| repeatCrontabSet.min | string | N   | Minute<br>Example: 10 <br>Can be empty: False <br> |
| repeatCrontabSet.hour | string | N   | Hour<br>Example: 10 <br>Can be empty: False <br> |
| repeatCrontabSet.day | string | N   | Day<br>Example: * <br>Can be empty: False <br> |
| repeatCrontabSet.month | string | N   | Month<br>Example: * <br>Can be empty: False <br> |
| repeatCrontabSet.week | string | N   | Week<br>Example: 1,3 <br>Can be empty: False <br> |
| crontabDuration  | int    | N   | Difference between end time and start time, positive integer, unit in seconds<br>Example: 3600 <br>Can be empty: False <br> |
| repeatExpireTime | string | N   | Repeat expiration time %Y/%m/%d %H:%M:%S<br>Example: <br>Can be empty: False <br>Can be an empty string: True <br> |
| timezone         | str    | Y   | Timezone of the mute rule<br>Example: Asia/Shanghai <br>Can be empty: False <br> |
| type             | str    | Y   | Type of the mute rule<br>Example: custom <br>Can be empty: False <br>Possible values: ['checker', 'alertPolicy', 'tag', 'custom'] <br> |
| declaration      | json   | N   | Custom declaration information<br>Can be empty: False <br> |

## Additional Parameter Explanation


Data Explanation.*

- Request parameter explanation

| Parameter Name           | Type | Description                                                                 |
| ------------------- | ---- | --------------------------------------------------------------------------- |
| muteRanges          | list | Mute ranges, including monitors, intelligent inspections, user-defined inspections, SLOs, alert policies |
| name                | str  | Rule name                                                                 |
| description         | str  | Description                                                               |
| tags                | dict | Tags                                                                      |
| filterString        | str  | Event attributes (expression format input)                                      |
| notifyTargets       | list | `to`: List of notification targets, `type` is their notification type                    |
| repeatTimeSet       | int  | Whether to repeat the mute, 1 means enable repeated mute, 0 means only once                 |
| repeatCrontabSet    | dict | Configuration for repeated mute rules                                          |
| crontabDuration     | int  | Duration of silence after the scheduled task starts                                |
| notifyTargets       | list | `to`: List of notification targets, `type` is their notification type                    |
| notifyTimeStr       | str  | Notification time, %Y/%m/%d %H:%M:%S                                             |
| startTime           | str  | Start time of the mute, %Y/%m/%d %H:%M:%S                                            |
| endTime             | str  | End time of the mute, %Y/%m/%d %H:%M:%S                                              |
| repeatExpireTime    | str  | Expiration time of repeated mute, %Y/%m/%d %H:%M:%S                                   |
| timezone            | str  | Corresponding task timezone, default Asia/Shanghai                                       |
| type                | str  | Corresponding mute rule type checker:monitor:tag:custom                                 |
| repeatExpire        | int  | Expiration time of repeated mute (discontinued on 2023-08-24)                             |
| start               | int  | Start time of the mute (discontinued on 2023-08-24)                                     |
| end                 | int  | End time of the mute (discontinued on 2023-08-24)                                       |
| notifyTime          | int  | Notification time, timestamp corresponding to the second-level time point, -1 means immediate notification (discontinued on 2023-08-24) |
| declaration         | dict | Custom declaration information                                                   |



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/<obj_uuid>/modify' \
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
                "name": "Aerospike cluster 【{cluster_name}】 space 【{{ ns }}】 Memory usage is too high",
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