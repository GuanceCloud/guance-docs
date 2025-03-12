# Create an Alarm Policy

---

<br />**post /api/v1/monitor/group/create**

## Overview
Create an alarm policy.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| type | string |  | Trigger rule type, default to `custom`<br>Allow null: True <br> |
| name | string | Y | Alarm policy name<br>Allow null: False <br> |
| alertOpt | json |  | Alarm setting<br>Allow null: False <br> |
| alertOpt.silentTimeout | integer |  | Alarm setting<br>Allow null: False <br> |
| alertOpt.alertTarget | array |  | Triggering action<br>Allow null: False <br> |

## Supplementary Description of Parameters


*Description of Relevant Parameters.*

**1. alertOpt Parameter Description*

| Parameter Name | Type| Required | Description|
| :---- | :-- | :--- | :------- |
| name   | string | Required | Rule name|
| type   | string | Required | Checker type |
| alertOpt  | Dict | Required | Alarm setting|
| alertOpt[#].silentTimeout | integer | | Silence timeout-timestamp|
| alertOpt[#].alertTarget       | Array[Dict] | | Alarm action|


**2. Monitor Trigger Action Parameter Description `alertOpt.alertTarget`**

| key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| type | Enum | Required | Alarm type and value range [`mail`,`dingTalkRobot`,`HTTPRequest`,`DataFluxFunc`] |
| status | Array[String] | Required | The status value of the event that needs to send an alarm, `critical`,`error`,`warning`,`info`,`ok`, `ALL` |
| status[#] | String | Required | The status of the event. Value ALL, primary, ok, info, warning and danger |
| minInterval | Integer | | Maximum alarm interval in seconds. 0/null means alarms are always sent. |
| allowWeekDays | Array[Integer] | | Week of Allowed Alerts |
| \{Extra Fields\} | | | Additional fields related to alertTarget[#].type, see text under. |


**3. When `alertOpt.alertTarget[\*].type`=`mail`, the parameter alertTarget[\*]**

| key     | Type          | Required | Description |
| :------ | :------------ | :------- | :-------- |
| to      | Array[String] | Required | Mail address list                      |
| to[#]   | String        | Required | Mail address                          |
| title   | String        |      | Message title, which defaults to the title of event |
| content | String        |      | Message content, which defaults to the message of event|

**4. When `alertOpt.alertTarget[\*].type`=`DataFluxFunc`, the parameter alertTarget[\*]**

| key    | Type   | Required | Description         |
| :----- | :----- | :------- | :----------- |
| funcId | String | Required     | Function ID    |
| kwargs | Dict   | Required     | Function tuning parameters |

**5. When `alertOpt.alertTarget[\*].type`=`notifyObject`, the parameter alertTarget[\*]**

| key      | Type   | Required | Description    |
| :------- | :----- | :------- | :------------------ |
| to  | Array[String] | Required    | UUID list of notification objects |




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/group/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "JMcCQWwy", "alertOpt": {}}' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "alertOpt": {},
        "config": {},
        "createAt": 1642592063.695837,
        "creator": "wsak_0f70ae95544143549f6ac2cb56ee0037",
        "deleteAt": -1,
        "id": null,
        "name": "mmmm",
        "status": 0,
        "type": "custom",
        "updateAt": 1642592063.6958542,
        "updator": "wsak_0f70ae95544143549f6ac2cb56ee0037",
        "uuid": "monitor_38cb283e41d642be933fdf3b12ade3ec",
        "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-C3A66595-5770-49D8-ADBF-4DD4F12109ED"
} 
```




