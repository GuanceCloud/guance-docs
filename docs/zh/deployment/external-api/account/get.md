# 【前台账号】获取

---

<br />**GET /api/v1/account/get**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| accountUUID | string |  | 账号的UUID<br>例子: acnt-c846ed9e105911ea83fad20d0b94ecd1 <br>允许为空: False <br> |
| exterId | string |  | 外部接入账号id<br>允许为空: False <br>例子: acnt-uJm5JYubZA3qewBmx3AtvU <br> |
| wsRoleNeeded | string |  | 是否需要返回关联空间和角色信息, true 为 需要, false 不需要<br>例子: supper_xxx <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/account/get?accountUUID=acnt_b3ba42650e75c8a8xxx' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <随机字符>' \
  -H 'X-Df-Signature: <签名>' \
  -H 'X-Df-Timestamp: <时间戳>'
```




## 响应
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




