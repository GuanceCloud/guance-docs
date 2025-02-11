# Delete a Dial Testing Task

---

<br />**POST /api/v1/dialing_task/delete**

## Overview




## Body Request Parameters

| Parameter Name | Type   | Required | Description                              |
|:--------------|:-------|:--------|:-----------------------------------------|
| taskUUIDs     | array  | Y       | List of UUIDs for the dial testing tasks <br>Allow Null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dialing_task/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"taskUUIDs":["dial_xxxx32"]}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {},
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4E49DEAB-8321-4EFF-96FC-71D5CC4C00A1"
} 
```