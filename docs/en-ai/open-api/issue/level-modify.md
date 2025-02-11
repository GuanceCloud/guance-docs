# Issue-Custom Level Modification

---

<br />**POST /api/v1/issue-level/\{issue_level_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------------|:-------|:-----|:----------------|
| issue_level_uuid | string | Y | issue_level_uuid<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------------|:-------|:-----|:----------------|
| name | string |  | Custom level name<br>Example: name <br>Allow null: False <br>Maximum length: 256 <br> |
| description | string |  | Custom level description<br>Example: description <br>Allow null: False <br> |
| extend | json |  | Additional extended information<br>Example: {} <br>Allow null: True <br> |
| color | string |  | Custom level color<br>Example: description <br>Allow null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue-level/<issue_level_uuid>/modify' \
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