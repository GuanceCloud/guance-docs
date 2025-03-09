# Invite One or Multiple Members

---

<br />**POST /api/v1/workspace/member/batch_invitation**

## Overview
Invite one or multiple members



## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| to | array | Y | List of invitees<br>Example: ['xx1@jiagouyun.com', 'xx2@jiagouyun.com'] <br>Allow null: True <br> |
| roleUUIDs | array | Y | List of role UUIDs for invitees<br>Example: ['xxx', 'xxx'] <br>Allow null: False <br> |
| method | string | Y | Invitation method<br>Example: None <br>Allow null: False <br>Optional values: ['email'] <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member/batch_invitation' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"to": ["241927@qq.com"], "method": "email", "roleUUIDs": ["general"]}' \
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
    "traceId": "TRACE-B6A69C1D-ED27-42C2-93FD-BC943F8675D2"
} 
```