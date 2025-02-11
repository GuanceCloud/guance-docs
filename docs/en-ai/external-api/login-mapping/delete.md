# 【Login Mapping】Delete a Mapping Configuration

---

<br />**POST /api/v1/login_mapping/field/\{lgmp_uuid\}/delete**

## Overview




## Route Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:--------|:-------------------------|
| lgmp_uuid     | string | Y       | ID of the mapping configuration<br> |


## Additional Parameter Notes





## Request Example
```shell
curl '<Endpoint>/api/v1/login_mapping/field/lgmp_xxx17/delete' \
  -X 'POST' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <random characters>' \
  -H 'X-Df-Signature: <signature>' \
  -H 'X-Df-Timestamp: <timestamp>'
```




## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-D9E0B7D1-CEC1-4134-BD47-ABC747EF1AAD"
} 
```