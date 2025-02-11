# Issue-Reply Deletion

---

<br />**DELETE /api/v1/issue/reply/\{reply_uuid\}/delete**

## Overview




## Route Parameters

| Parameter Name   | Type    | Required | Description              |
|:-------------|:------|:------|:----------------|
| reply_uuid   | string | Yes  | reply_uuid<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue/reply/repim_xxxx32/delete' \
-X 'DELETE' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
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
    "traceId": "14221792535104901781"
} 
```