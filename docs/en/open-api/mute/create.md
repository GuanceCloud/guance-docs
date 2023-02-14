# Create a Mute Rule

---

<br />**post /api/v1/monitor/mute/create**

## Overview
Create a mute rule.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| muteRanges | array |  | Range of mute<br>Example: Monitor A <br>Allow null: False <br> |
| tags | json |  | Tag set<br>Allow null: False <br> |
| notifyTargets | array |  | Notification target<br>Allow null: False <br> |
| notifyMessage | string |  | Notification information<br>Allow null: False <br> |
| notifyTime | integer |  | Notification time, default to `-1` when not set.<br>Example: None <br>Allow null: False <br> |
| start | integer |  | Start timestamp milliseconds<br>Example: 60 <br>Allow null: False <br> |
| end | integer |  | End timestamp in milliseconds, `-1` for forever.<br>Example: 60 <br>Allow null: False <br> |
| repeatTimeSet | int | Y | The repeated configuration value is passed 1, and the silence time is passed 0 for a single time.<br>Example: 0 <br>Allow null: False <br> |
| repeatCrontabSet | None |  | Repeat crontab configuration<br>Allow null: False <br> |
| repeatCrontabSet.min | string |  | Minutes<br>Example: 10 <br>Allow null: False <br> |
| repeatCrontabSet.hour | string |  | Hours<br>Example: 10 <br>Allow null: False <br> |
| repeatCrontabSet.day | string |  | Days<br>Example: * <br>Allow null: False <br> |
| repeatCrontabSet.month | string |  | Months<br>Example: * <br>Allow null: False <br> |
| repeatCrontabSet.week | string |  | Weeks<br>Example: 1,3 <br>Allow null: False <br> |
| crontabDuration | int |  | End time minus start time, positive integer in s.<br>Example: 3600 <br>Allow null: False <br> |
| repeatExpire | int |  | Repeat end time, specific timestamp, if it is forever repeated transmission 0.<br>Example: 0 <br>Allow null: False <br> |

## Supplementary Description of Parameters


*Data description.*

- Request parameter description

| Parameter Name           | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| muteRanges       | list | mute range, including monitor, intelligent check, self-built patrol, SLO and mute policy |
| tags             | dict | tag                                                 |
| notifyTargets    | list | to: The list is the notification object, and type is its notification type                |
| notifyTime       | int  | Notification time, the second timestamp corresponding to the time point, -1 for immediate notification   |
| start            | int  | mute start time                                         |
| end              | int  | mute end time                                         |
| repeatTimeSet    | int  | Whether to repeat mute, 1 means to turn on repeated mute, and 0 means only once      |
| repeatCrontabSet | dict | Time allocation of repeated mute rules                               |
| repeatExpire     | int  | expiry time of repeated mute                                   |
| crontabDuration  | int  | Represent the duration of mute after the start of the timed task          |

------




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/create' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"tags": {"host": ["10-23-190-37"]},"repeatTimeSet":0, "start": 1669878235, "end": 1669888235, "notifyTargets": []}' \
  --compressed \
  --insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1669878266,
        "creator": "wsak_60b430adbf1440ad991a4647e9ef411a",
        "crontab": "",
        "crontabDuration": 0,
        "deleteAt": -1,
        "end": 1669888235,
        "id": null,
        "muteRanges": [],
        "notifyMessage": "",
        "notifyTargets": [],
        "notifyTime": -1,
        "repeatExpire": -1,
        "start": 1669878235,
        "status": 0,
        "tags": {
            "host": [
                "10-23-190-37"
            ]
        },
        "type": "host",
        "updateAt": 1669878266.470657,
        "updator": "wsak_60b430adbf1440ad991a4647e9ef411a",
        "uuid": "mute_f5533997b770444b91d507527c361e34",
        "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1391A46B-581E-43F9-9B0D-EA850F384A45"
} 
```




