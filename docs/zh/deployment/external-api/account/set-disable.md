# 【前台账号】启用/禁用

---

<br />**POST /api/v1/account/set-disable**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| accountUUIDs | array | Y | 账号UUID<br>例子: ['acnt_xxxx', 'acnt_yyyy'] <br>允许为空: False <br> |
| isDisable | boolean | Y | 是否禁用, true禁用, false启用<br>例子: True <br>允许为空: False <br>可选值: [True, False] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/account/set-disable' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <随机字符>' \
  -H 'X-Df-Signature: <签名>' \
  -H 'X-Df-Timestamp: <时间戳>' \
  --data-raw $'{"accountUUIDs": ["acnt_a95702ad60d04209b3ba42650e75c8a8"],"isDisable": true}'

```




## 响应
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




