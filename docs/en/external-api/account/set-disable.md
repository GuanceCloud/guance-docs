# [Frontend Account] Enable/Disable

---

<br />**POST /api/v1/account/set-disable**

## Overview



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| accountUUIDs         | array    | Y         | Account UUID<br>Example: ['acnt_xxxx', 'acnt_yyyy'] <br>Can be empty: False <br> |
| isDisable            | boolean  | Y         | Whether to disable, true for disable, false for enable<br>Example: True <br>Can be empty: False <br>Possible values: [True, False] <br> |

## Additional Parameter Notes



## Request Example
```shell
curl '<Endpoint>/api/v1/account/set-disable' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <random string>' \
  -H 'X-Df-Signature: <signature>' \
  -H 'X-Df-Timestamp: <timestamp>' \
  --data-raw $'{"accountUUIDs": ["acnt_a95702ad60d04209b3ba42650e75c8a8"],"isDisable": true}'
```



## Response
```shell
{
    "code": 200,
    "content": {},
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-93470524-DF6A-4474-A07F-5294E7C3D880"
} 
```