# Create a Key

---

<br />**POST /api/v1/workspace/accesskey/add**

## Overview
Create a Key




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | AK name information<br>Example: xxx <br>Can be empty: False <br> |
| roleUUIDs | array |  | Specify the role list of the API key (excluding owner)<br>Can be empty: False <br> |

## Additional Parameter Notes


**1. Request Parameter Notes*

| Parameter Name | Type | Required | Description |
| :---- | :-- | :--- | :------- |
| name   | string | Required | API Key Name |
| roleUUIDs   | array | | Specify the role UUID of the API Key (excluding owner, default is ['wsAdmin']), added in the iteration on 2025-03-12 |




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/accesskey/add' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"name": "88"}' \
  --compressed \
  --insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1678024319,
        "creator": "xxxx",
        "deleteAt": -1,
        "id": null,
        "name": "88",
        "sk": "xxx",
        "status": 0,
        "updateAt": 1678024319,
        "updator": "xxx",
        "uuid": "xxx",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-A294E29E-33DE-48A5-A379-0BAA1519D256"
} 
```