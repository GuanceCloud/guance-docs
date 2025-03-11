# Create a Mute Rule

---

<br />**POST /api/v1/monitor/mute/create**

## Overview
Create a mute rule



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| muteRanges           | array    |            | Mute range<br>Can be empty: False <br> |
| name                 | string   |            | Rule name<br>Example: Name A <br>Can be empty: False <br> |
| description          | string   |            | Description<br>Example: Description A <br>Can be empty: False <br>Can be an empty string: True <br> |
| tags                 | json     |            | Tag set<br>Can be empty: False <br> |
| filterString         | string   |            | Event attributes<br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 2048 <br> |
| notifyTargets        | array    |            | Notification targets<br>Can be empty: False <br> |
| notifyMessage        | string   |            | Notification message<br>Can be empty: False <br>Maximum length: 3000 <br> |
| notifyTimeStr        | string   |            | Notification time, %Y/%m/%d %H:%M:%S<br>Example: 2023/08/21 19:19:00 <br>Can be empty: False <br>Can be an empty string: True <br> |
| startTime            | string   |            | Start time %Y/%m/%d %H:%M:%S<br>Example: 2023/08/21 19:19:00 <br>Can be empty: False <br> |
| endTime              | string   |            | End time %Y/%m/%d %H:%M:%S<br>Example: 2023/08/21 19:19:00 <br>Can be empty: False <br>Can be an empty string: True <br> |
| repeatTimeSet        | int      | Y          | Repeat configuration value pass 1, mute time is single pass 0<br>Example: 0 <br>Can be empty: False <br> |
| repeatCrontabSet     | None     |            | Repeat crontab configuration<br>Can be empty: False <br> |
| repeatCrontabSet.min | string   |            | Minute<br>Example: 10 <br>Can be empty: False <br> |
| repeatCrontabSet.hour| string   |            | Hour<br>Example: 10 <br>Can be empty: False <br> |
| repeatCrontabSet.day | string   |            | Day<br>Example: * <br>Can be empty: False <br> |
| repeatCrontabSet.month| string |            | Month<br>Example: * <br>Can be empty: False <br> |
| repeatCrontabSet.week| string   |            | Week<br>Example: 1,3 <br>Can be empty: False <br> |
| crontabDuration      | int      |            | End time minus start time, positive integer, unit in seconds<br>Example: 3600 <br>Can be empty: False <br> |
| repeatExpireTime     | string   |            | Repeat expiration time %Y/%m/%d %H:%M:%S<br>Example: 0 <br>Can be empty: False <br>Can be an empty string: True <br> |
| timezone             | str      | Y          | Mute rule timezone<br>Example: Asia/Shanghai <br>Can be empty: False <br> |
| type                 | str      | Y          | Mute rule type<br>Example: custom <br>Can be empty: False <br>Possible values: ['checker', 'alertPolicy', 'tag', 'custom'] <br> |
| declaration          | json     |            | Custom declaration information<br>Can be empty: False <br> |

## Additional Parameter Explanation


Data explanation.*

**1. Request Parameter Explanation**

| Parameter Name       | Type | Description                                                     |
| -------------------- | ---- | --------------------------------------------------------------- |
| type                | string | Corresponds to the mute rule type Checker:checker, Alert Policy:alertPolicy, Checker Tag:tag, Custom:custom                  |
| muteRanges          | list  | Mute range, includes checkers, intelligent inspections, user-defined inspections, SLO, alert policies |
| name                | str   | Rule name                                                       |
| description         | str   | Description                                                     |
| tags                | dict  | Advanced configuration, event attributes                                               |
| filterString        | str   | Event attributes (expression form input parameter)                              |
| notifyTargets       | list  | To: List of notification targets, type as their notification type               |
| repeatTimeSet       | int   | Whether to repeat mute, 1 means enable repeating mute, 0 means only once         |
| repeatCrontabSet    | dict  | Configuration for repeating mute rules                                      |
| crontabDuration     | int   | Represents the duration of silence after the scheduled task starts                    |
| notifyTargets       | list  | To: List of notification targets, type as their notification type               |
| notifyTimeStr       | str   | Notification time, %Y/%m/%d %H:%M:%S                                     |
| startTime           | str   | Mute start time %Y/%m/%d %H:%M:%S                                        |
| endTime             | str   | Mute end time %Y/%m/%d %H:%M:%S                                          |
| repeatExpireTime    | str   | 0 means always repeating, repeat mute expiration time %Y/%m/%d %H:%M:%S                 |
| timezone            | str   | Corresponding task timezone default Asia/Shanghai                               |
| repeatExpire        | int   | Repeating mute expiration time (deprecated on 2023-08-24)                        |
| start               | int   | Mute start time (deprecated on 2023-08-24)                                  |
| end                 | int   | Mute end time (deprecated on 2023-08-24)                                    |
| notifyTime          | int   | Notification time, timestamp in seconds corresponding to the time point, -1 means immediate notification (deprecated on 2023-08-24) |
| declaration         | dict  | Custom declaration information |

--------------

**2. Mute Range Explanation**

| Parameter Name      | Type  | Required | Description                                              |
| ------------------- |-------|----------|----------------------------------------------------------|
| type               | string| Y        | Corresponds to the mute rule type Checker:checker, Alert Policy:alertPolicy, Checker Tag:tag, Custom:custom                  |
| muteRanges         | list  | Y        | Mute range, [] represents selecting all                             |
| tags               | dict  | Y        | Advanced configuration, event attributes                           |
| filterString       | str   | Event attributes (expression form input parameter)                   |

Tags configuration supports negative selection configuration, example:
```json
{
    "tags": {
        "-host": [
            "cn-hangzhou"
        ]
    },
    "muteRanges": [],
    "type": "checker"
}
```

Type is checker, checker type, example:
```json
{
    "tags": {
        "host": [
            "cn-hangzhou"
        ]
    },
    "muteRanges": [
        {
            "name": "Infrastructure survival detection - ReplicaSet type - {Result}",
            "checkerUUID": "rul_xxxx22",
        },
        {
            "name": "hhh",
            "checkerUUID": "rul_xxxx21",
        }
    ],
    "type": "checker"
}
```

Type is alertPolicy, alert policy type, example:
```json
{
    "tags": {
        "host": [
            "cn-hangzhou"
        ]
    },
    "muteRanges": [
        {
            "name": "gary-test1234",
            "alertPolicyUUID": "altpl_xxxx26",
        }
    ],
    "type": "alertPolicy",
}
```

Type is tag, checker tag, example:
```json
{
    "tags": {
        "service": [
            "kodo.nsq.consumer"
        ]
    },
    "muteRanges": [
        {
            "name": "zyl_test",
            "tagUUID": "tag_xxxx23",
        },
        {
            "name": "0306",
            "tagUUID": "tag_xxxx28",
        }
    ],
    "type": "tag"
}
```

Type is custom, custom type, example:
```json
{
    "tags": {
        "service": [
            "kodo.nsq.consumer"
        ]
    },
    "muteRanges": [
        {
            "name": "Monitor optimization verification - Update 2",
            "checkerUUID": "rul_xxxx22",
        },
        {
            "name": "0306",
            "tagUUID": "tag_xxxx25",
        },
        {
            "name": "slo_test",
            "sloUUID": "monitor_xxxx25",
        }
    ],
    "type": "custom",
}
```

filterString is the new event attribute syntax follows the Explorer syntax, currently the API also supports tags as old event attributes and prefers the value of filterString, for example:
```json
{
    "filterString": "df_status:ok OR host:web001",
    "muteRanges": [],
    "type": "checker"
}
```

--------------

**3. Mute Time Explanation**

Mute time can be either single or repeating.

--------------

Single mute configuration parameters:

| Parameter Name      | Type  | Description                                              |
| ------------------- |-------|----------------------------------------------------------|
| repeatTimeSet       | int   | Whether to repeat mute, 1 means enable repeating mute, 0 means only once         |
| startTime           | str   | Mute start time %Y/%m/%d %H:%M:%S                                        |
| endTime             | str   | Mute end time %Y/%m/%d %H:%M:%S                                          |
| timezone            | str   | Corresponding task timezone default Asia/Shanghai                               |

repeatTimeSet is 0, single mute, example:
```json
{
    "startTime": "2024/03/27 14:06:57",
    "endTime": "2024/03/27 15:06:57",
    "timezone": "Asia/Shanghai",
    "repeatTimeSet": 0
}
```

--------------

Repeating mute configuration parameters:

| Parameter Name      | Type  | Description                                              |
| ------------------- |-------|----------------------------------------------------------|
| repeatTimeSet       | int   | Whether to repeat mute, 1 means enable repeating mute, 0 means only once         |
| repeatCrontabSet    | dict  | Configuration for repeating mute rules, used with Crontab syntax                       |
| crontabDuration     | int   | Represents the duration of silence after the scheduled task starts, unit in seconds                    |
| repeatExpireTime    | str   | 0 means always repeating, repeat mute expiration time %Y/%m/%d %H:%M:%S                 |
| timezone            | str   | Corresponding task timezone default Asia/Shanghai                               |

repeatTimeSet is 1, repeating mute, example:
```json
{
    "timezone": "Asia/Shanghai",
    "repeatTimeSet": 1,
    "repeatCrontabSet": {
        "min": "0",
        "hour": "0",
        "day": "*",
        "month": "*",
        "week": "1,2"
    },
    "crontabDuration": 18000,
    "repeatExpireTime": "0"
}
```
--------------




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/monitor/mute/create' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"name":"Name A","description":"Description A","startTime":"2023/08/23 14:00:07","endTime":"2023/08/23 14:31:07","notifyTargets":[{"to":["acnt_xxxx32"],"type":"mail"}],"tags":{},"muteRanges":[{"name":"Aerospike cluster 【{cluster_name}】 namespace 【{{ ns }}】 Memory usage rate too high","checkerUUID":"rul_xxxx32","type":"checker"}],"type":"checker","timezone":"Asia/Shanghai","notifyMessage":"cjkackcnkjcklasc","notifyTimeStr":"2023/08/23 13:45:07","repeatTimeSet":0}' \
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
                "name": "Aerospike cluster 【{cluster_name}】 namespace 【{{ ns }}】 Memory usage rate too high",
                "type": "checker"
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