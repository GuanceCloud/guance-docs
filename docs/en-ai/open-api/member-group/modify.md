# Modify a Team

---

<br />**POST /api/v1/workspace/member_group/\{group_uuid\}/modify**

## Overview
Modify a team



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------------|:-------|:-----|:----------------|
| group_uuid | string | Y | Team UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------------|:-------|:-----|:----------------|
| name | string | Y | Team name<br>Allow null: False <br>Maximum length: 48 <br> |
| accountUUIDs | array | Y | Account list<br>Example: ['xxxx', 'xxx'] <br>Allow null: True <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member_group/group_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "Test222","accountUUIDs": ["acnt_xxxx32"]}' \
--compressed 
```




## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-EC42FB1A-8ABA-45E4-83E1-E2E01661C6B3"
} 
```