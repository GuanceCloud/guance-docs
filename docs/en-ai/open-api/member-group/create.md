# Create a Team

---

<br />**POST /api/v1/workspace/member_group/add**

## Overview
Create a new team



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | Team name<br>Allow null: False <br>Maximum length: 48 <br> |
| accountUUIDs | array | N | Account list<br>Example: ['xxxx', 'xxx'] <br>Allow null: True <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member_group/add' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"name": "Test","accountUUIDs": ["acnt_xxxx32"]}' \
  --compressed \
  --insecure
```



## Response
```shell
{
    "code": 200,
    "content": {
        "uuid": "group_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-799143AC-5EDC-4901-A8B6-5AAE1F9D6655"
} 
```