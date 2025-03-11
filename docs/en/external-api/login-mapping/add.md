# 【Login Mapping】Add a Mapping Configuration

---

<br />**POST /api/v1/login_mapping/field/add**

## Overview



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| workspaceUUID        | string   | Y          | Workspace UUID<br>Example: Workspace UUID <br>Allow empty: False <br> |
| sourceField          | string   | Y          | Source field<br>Example: sourceField <br>Allow empty: False <br>Maximum length: 40 <br> |
| sourceValue          | string   | Y          | Source field value<br>Example: <br>Allow empty: False <br>Maximum length: 40 <br> |
| targetValues         | array    | Y          | Target field values (currently defaults to the UUID of roles)<br>Example: ['readOnly'] <br> |

## Additional Parameter Explanation



## Request Example
```shell
curl '<Endpoint>/api/v1/login_mapping/field/add' \
  -X 'POST' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <random characters>' \
  -H 'X-Df-Signature: <signature>' \
  -H 'X-Df-Timestamp: <timestamp>' \
  --data-raw $'{"workspaceUUID": "wksp_xxxx","sourceField": "email","sourceValue": "xxx@qq.com","targetValues": [  "readOnly"]}'
```



## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1715323808,
        "creator": "sys",
        "deleteAt": -1,
        "id": null,
        "isSystem": true,
        "sourceField": "email",
        "sourceValue": "xxx@qq.com",
        "status": 0,
        "targetValues": [
            "readOnly"
        ],
        "updateAt": 1715323808,
        "updator": "sys",
        "uuid": "lgmp_xxxxx",
        "workspaceUUID": "wksp_xxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-978CA704-5646-45D8-ACAE-84975BDD2250"
} 
```