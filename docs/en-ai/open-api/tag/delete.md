# Delete Tag

---

<br />**POST /api/v1/tag/delete**

## Overview
Delete a tag



## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| tagUUIDs | array | Y | Tag UUIDs<br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/tag/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"tagUUIDs":["tag_xxxx32", "tag_xxxx32"]}' \
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
    "traceId": "TRACE-98CE1D22-B5ED-4186-A940-A50718572B36"
} 
```