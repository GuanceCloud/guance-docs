# Issue - Custom Level Addition

---

<br />**POST /api/v1/issue-level/add**

## Overview




## Body Request Parameters

| Parameter Name | Type   | Required | Description |
|:--------------|:-------|:--------|:------------|
| name          | string | Y       | Custom level name<br>Example: name <br>Allow empty: False <br>Maximum length: 256 <br> |
| description   | string |         | Custom level description<br>Example: description <br>Allow empty: False <br> |
| extend        | json   |         | Additional extended information<br>Example: {} <br>Allow empty: True <br> |
| color         | string | Y       | Custom level color<br>Example: description <br>Allow empty: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue-level/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "custom-1","color": "#E94444","description": "Custom level description 2"}'\
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "color": "#E94444",
        "createAt": 1694593524,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "description": "Custom level description 2",
        "extend": {},
        "id": 3,
        "name": "custom-1",
        "status": 0,
        "updateAt": 1694593524,
        "updator": "acnt_xxxx32",
        "uuid": "issl_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-2B1E09C8-2401-4C52-ABF9-093CC9873742"
} 
```