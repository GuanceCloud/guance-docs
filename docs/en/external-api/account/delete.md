# [Frontend Account] Deletion

---

<br />**POST /api/v1/account/delete**

## Overview



## Body Request Parameters

| Parameter Name       | Type   | Required | Description                             |
|:-------------------|:------|:-------|:---------------------------------------|
| accountUUIDs        | array | Y      | Account UUID<br>Example: ['acnt_xxxx', 'acnt_yyyy'] <br>Allow empty: False <br> |

## Additional Parameter Explanation



## Request Example
```shell
curl '<Endpoint>/api/v1/account/delete' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <random string>' \
  -H 'X-Df-Signature: <signature>' \
  -H 'X-Df-Timestamp: <timestamp>' \
  --data-raw $'{"accountUUIDs": ["acnt_xxx"]}'
```



## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4E35F036-A866-483A-8E6A-3DBB31452FD5"
} 
```