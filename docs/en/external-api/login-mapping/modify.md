# 【Login Mapping】Modify a Mapping Configuration

---

<br />**POST /api/v1/login_mapping/field/\{lgmp_uuid\}/modify**

## Overview



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:--------------------------|
| lgmp_uuid            | string   | Y          | Mapping configuration ID<br> |

## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:--------------------------|
| workspaceUUID        | string   |            | Workspace UUID<br>Example: Workspace UUID <br>Can be empty: False <br> |
| sourceField          | string   | Y          | Source field<br>Example: sourceField <br>Can be empty: False <br>Maximum length: 40 <br> |
| sourceValue          | string   | Y          | Source field value<br>Example: <br>Can be empty: False <br>Maximum length: 40 <br> |
| targetValues         | array    | Y          | Target field values (currently defaults to role UUID values)<br>Example: ['readOnly'] <br> |

## Additional Parameter Notes



## Request Example
```shell
curl '<Endpoint>/api/v1/login_mapping/field/lgmp_xxxxx/modify' \
  -X 'POST' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <random characters>' \
  -H 'X-Df-Signature: <signature>' \
  -H 'X-Df-Timestamp: <timestamp>' \
  --data-raw $'{ "workspaceUUID": "wksp_xxxx", "sourceField": "email2", "sourceValue": "xxx@qq.com", "targetValues": ["readOnly" ]}'
```

## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-FC3488AA-3452-4031-9BDA-3CD710025D66"
} 
```