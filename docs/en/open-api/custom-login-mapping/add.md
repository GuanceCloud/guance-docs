# 【Custom Mapping Rules】Add a Mapping Configuration

---

<br />**POST /api/v1/login_mapping/field/add**

## Overview



## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| sourceField           | string   | Y        | Source field<br>Example: sourceField <br>Allow empty: False <br>Maximum length: 256 <br> |
| sourceValue           | string   | Y        | Source field value<br>Example:  <br>Allow empty: False <br>Maximum length: 256 <br> |
| targetValues          | array    | Y        | Target field values (currently defaults to list of role UUIDs)<br>Example: readOnly <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/login_mapping/field/add' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw '{"sourceField":"name","sourceValue":"lisa","targetValues":["wsAdmin","role_xxxx32"]}' \
  --compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1697427020,
        "creator": "mact_xxxx22",
        "deleteAt": -1,
        "id": null,
        "isSystem": true,
        "sourceField": "name",
        "sourceValue": "lisa",
        "status": 0,
        "targetValues": [
            "wsAdmin",
            "role_xxxxxxxx"
        ],
        "updateAt": 1697427020,
        "updator": "mact_xxxxxx",
        "uuid": "lgmp_xxxxxxxxxxxxxx",
        "workspaceUUID": "wksp_bb191037aa7exxxxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "12119540197801491096"
} 
```