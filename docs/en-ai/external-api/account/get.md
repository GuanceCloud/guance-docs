# [Frontend Account] Acquisition

---

<br />**GET /api/v1/account/get**

## Overview




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| accountUUID | string | Yes | UUID of the account<br>Example: acnt-c846ed9e105911ea83fad20d0b94ecd1 <br>Can be empty: False <br> |
| exterId | string | Yes | External access account ID<br>Can be empty: False <br>Example: acnt-uJm5JYubZA3qewBmx3AtvU <br> |
| wsRoleNeeded | string | Yes | Whether to return associated workspace and role information, true for yes, false for no<br>Example: supper_xxx <br>Can be empty: False <br> |

## Additional Parameter Explanation





## Request Example
```shell
curl '<Endpoint>/api/v1/account/get?accountUUID=acnt_b3ba42650e75c8a8xxx' \
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
    "content": {
        "attributes": {},
        "canaryPublic": false,
        "createAt": 1715135066,
        "creator": "extend",
        "deleteAt": -1,
        "email": "hd_phone02@qq.com",
        "enableMFA": false,
        "extend": {
            "lastLoginTime": 1715135086
        },
        "exterId": "acnt-yf5o9juQBxTeTcADbroE8",
        "id": 3023,
        "isUsed": 1,
        "language": "en",
        "mfaSecret": "*********************",
        "mobile": "15435364656",
        "name": "hd_phone02",
        "nameSpace": "",
        "status": 0,
        "statusPageSubs": 0,
        "timezone": "",
        "tokenHoldTime": 604800,
        "tokenMaxValidDuration": 2592000,
        "updateAt": 1715135066,
        "updator": "extend",
        "userIconUrl": null,
        "username": "hd_phone02",
        "uuid": "acnt_a95702ad60d04209b3ba42650e75c8a8"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6839324A-2A95-4FE1-95DE-92DE4FF206B1"
} 
```