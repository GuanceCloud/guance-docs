# Delete Custom Issue Level

---

<br />**POST /api/v1/issue-level/delete**

## Overview



## Body Request Parameters

| Parameter Name | Type   | Required | Description                                |
|:--------------|:-------|:---------|:-------------------------------------------|
| uuids         | array  | Y        | Custom issue level UUIDs<br>Example: ['uuid1', 'uuid2'] <br>Allow empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue-level/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"uuids": []}'\
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
    "traceId": "TRACE-2B1E09C8-2401-4C52-ABF9-093CC9873742"
} 
```