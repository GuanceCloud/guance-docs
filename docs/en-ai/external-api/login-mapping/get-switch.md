# 【Login Mapping】Get Switch Status Information

---

<br />**GET /api/v1/login_mapping/switch/get**

## Overview




## Additional Parameter Description





## Request Example
```shell
curl '<Endpoint>/api/v1/login_mapping/switch/get' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <random string>' \
  -H 'X-Df-Signature: <signature>' \
  -H 'X-Df-Timestamp: <timestamp>'
```




## Response
```shell
{
    "code": 200,
    "content": {
        "isDisable": true,
        "type": "GlobalValid"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-F37BF2D0-3A5E-4F38-90BD-2471F08146B6"
} 
```