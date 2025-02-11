# Create a Mute Rule

---

<br />**POST /api/v1/monitor/mute/create**

## Overview
Create a mute rule



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| muteRanges | array |  | Mute ranges<br>Can be null: False <br> |
| name | string |  | Rule name<br>Example: Name A <br>Can be null: False <br> |
| description | string |  | Description<br>Example: Description A <br>Can be null: False <br>Can be empty string: True <br> |
| tags | json |  | Tag set<br>Can be null: False <br> |
| filterString | string |  | Event attributes<br>Can be null: False <br>Can be empty string: True <br>Maximum length: 2048 <br> |
| notifyTargets | array |  | Notification targets<br>Can be null: False <br> |
| notifyMessage | string |  | Notification message<br>Can be null: False <br>Maximum length: 3000 <br> |
| notifyTimeStr | string |  | Notification time, %Y/%m/%d %H:%M:%S<br>Example: 2023/08/21 19:19:00 <br>Can be null: False <br>Can be empty string: True <br> |
| startTime | string |  | Start time %Y/%m/%d %H:%M:%S<br>Example: 2023/08/21 19:19:00 <br>Can be null: False <br> |
| endTime | string |  | End time %Y/%m/%d %H:%M:%S<br>Example: 2023/08/21 19:19:00 <br>Can be null: False <br>Can be empty string: True <br> |
| repeatTimeSet | int | Y | Repeat configuration value 1 for repeated mute, 0 for single occurrence<br>Example: 0 <br>Can be null: False <br> |
| repeatCrontabSet | None |  | Repeated crontab configuration<br>Can be null: False <br> |
| repeatCrontabSet.min | string |  | Minute<br>Example: 10 <br>Can be null: False <br> |
| repeatCrontabSet.hour | string |  | Hour<br>Example: 10 <br>Can be null: False <br> |
| repeatCrontabSet.day | string |  | Day<br>Example: * <br>Can be null: False <br> |
| repeatCrontabSet.month | string |  | Month<br>Example: * <br>Can be null: False <br> |
| repeatCrontabSet.week | string |  | Week<br>Example: 1,3 <br>Can be null: False <br> |
| crontabDuration | int |  | End time minus start time, positive integer, unit is seconds<br>Example: 3600 <br>Can be null: False <br> |
| repeatExpireTime | string |  | Repeat expiration time %Y/%m/%d %H:%M:%S<br>Example: 0 <br>Can be null: False <br>Can be empty string: True <br> |
| timezone | str | Y | Timezone of the mute rule<br>Example: Asia/Shanghai <br>Can be null: False <br> |
| type | str | Y | Type of mute rule<br>Example: custom <br>Can be null: False <br>Possible values: ['checker', 'alertPolicy', 'tag', 'custom'] <br> |
| declaration | json |  | Custom declaration information<br>Can be null: False <br> |

## Additional Parameter Notes


Data notes.*

**1. Request parameter explanation**

| Parameter Name           | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| type          |  string  | Corresponds to the mute rule type Checker:checker, Alert policy:alertPolicy, Checker tag:tag, Custom:custom                  |
| muteRanges       | list | Mute ranges, including checkers, intelligent inspections, user-defined inspections, SLO, alert policies |
| name             | str  | Rule name           |
| description      | str  | Description            |
| tags             | dict | Advanced configuration, event attributes                                                 |
| filterString     | str  | Event attributes (expression format input)            |
| notifyTargets    | list | To: List of notification objects, type as their notification type                  |
| repeatTimeSet    | int  | Whether to repeat mute, 1 represents enabling repeated mute, 0 represents only once         |
| repeatCrontabSet | dict | Configuration for repeating mute rules                               |
| crontabDuration  | int  | Represents the duration of silence after the scheduled task starts               |
| notifyTargets    | list | To: List of notification objects, type as their notification type                  ｜
| notifyTimeStr    | str  | Notification time, %Y/%m/%d %H:%M:%S    |
| startTime        | str  | Start time of silence  %Y/%m/%d %H:%M:%S                 |
| endTime          | str  | End time of silence  %Y/%m/%d %H:%M:%S                 |
| repeatExpireTime | str  | 0 means forever repeat, repeat expiration time of silence %Y/%m/%d %H:%M:%S             |
| timezone         | str  | Corresponding task timezone default Asia/Shanghai              |
| repeatExpire     | int  | Repeat expiration time of silence (deprecated on 2023-08-24)                |
| start            | int  | Start time of silence (deprecated on 2023-08-24)                  |
| end              | int  | End time of silence (deprecated on 2023-08-24)                  ｜
| notifyTime       | int  | Notification time, timestamp in seconds corresponding to the time point, -1 means immediate notification (deprecated on 2023-08-24) |
| declaration             | dict  | Custom declaration information |

--------------

**2. Explanation of mute ranges**

|  Parameter Name        |   Type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| type          |  string  |  Y | Corresponds to the mute rule type Checker:checker, Alert policy:alertPolicy, Checker tag:tag, Custom:custom                  |
| muteRanges         |  list  |  Y | Mute ranges, [] represents all selected                |
| tags       |  dict  |  Y | Advanced configuration, event attributes                |
| filterString     | str  | Event attributes (expression format input)            |

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

Type as checker, checker type, example:
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

Type as alertPolicy, alert policy type, example:
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

Type as tag, checker tag, example:
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

Type as custom, custom type, example:
```json
{
    "tags": {
        "service": [
            "kodo.nsq.consumer"
        ]
    },
    "muteRanges": [
        {
            "name": "Checker optimization verification - Update 2",
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

filterString is the new event attribute, syntax follows the Explorer syntax. The interface currently also supports tags as the old event attributes, giving priority to the value of filterString, for example:
```json
{
    "filterString": "df_status:ok OR host:web001",
    "muteRanges": [],
    "type": "checker"
}
```

--------------

**3. Explanation of mute time**

Mute time is divided into single occurrence and repeated mutes.

--------------

Configuration parameters for single occurrence mute:

|  Parameter Name        |   Type  |          Description          |
|---------------|----------|------------------------|
| repeatTimeSet    | int  | Whether to repeat mute, 1 represents enabling repeated mute, 0 represents only once         |
| startTime        | str  | Start time of silence  %Y/%m/%d %H:%M:%S                 |
| endTime          | str  | End time of silence  %Y/%m/%d %H:%M:%S                 |
| timezone         | str  | Corresponding task timezone default Asia/Shanghai              |

repeatTimeSet is 0, single occurrence mute, example:
```json
{
    "startTime": "2024/03/27 14:06:57",
    "endTime": "2024/03/27 15:06:57",
    "timezone": "Asia/Shanghai",
    "repeatTimeSet": 0
}
```

--------------

Configuration parameters for repeated mute:

|  Parameter Name        |   Type  |          Description          |
|---------------|----------|------------------------|
| repeatTimeSet    | int  | Whether to repeat mute, 1 represents enabling repeated mute, 0 represents only once         |
| repeatCrontabSet | dict | Configuration for repeating mute rules using Crontab (Crontab syntax)                              |
| crontabDuration  | int  | Duration of silence after the scheduled task starts, unit is seconds               |
| repeatExpireTime | str  | 0 means forever repeat, repeat expiration time of silence %Y/%m/%d %H:%M:%S             |
| timezone         | str  | Corresponding task timezone default Asia/Shanghai              |

repeatTimeSet is 1, repeated mute, example:
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
curl 'https://openapi.guance.com/api/v1/monitor/mute/create' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"name":"Name A","description":"Description A","startTime":"2023/08/23 14:00:07","endTime":"2023/08/23 14:31:07","notifyTargets":[{"to":["acnt_xxxx32"],"type":"mail"}],"tags":{},"muteRanges":[{"name":"Aerospike Cluster【{cluster_name}】Namespace【{{ ns }}】 Memory usage too high","checkerUUID":"rul_xxxx32","type":"checker"}],"type":"checker","timezone":"Asia/Shanghai","notifyMessage":"cjkackcnkjcklasc","notifyTimeStr":"2023/08/23 13:45:07","repeatTimeSet":0}' \
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
                "name": "Aerospike Cluster【{cluster_name}】Namespace【{{ ns }}】 Memory usage too high",
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