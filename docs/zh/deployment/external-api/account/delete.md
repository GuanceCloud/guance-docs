# 【前台账号】删除

---

<br />**POST /api/v1/account/delete**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| accountUUIDs | array | Y | 账号UUID<br>例子: ['acnt_xxxx', 'acnt_yyyy'] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl '<Endpoint>/api/v1/account/delete' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <随机字符>' \
  -H 'X-Df-Signature: <签名>' \
  -H 'X-Df-Timestamp: <时间戳>' \
  --data-raw $'{"accountUUIDs": ["acnt_xxx"]}'
```




## 响应
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




