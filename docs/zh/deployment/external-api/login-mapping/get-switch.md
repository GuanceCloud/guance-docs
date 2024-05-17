# 【Login Mapping】获取开关状态信息

---

<br />**GET /api/v1/login_mapping/switch/get**

## 概述




## 参数补充说明





## 请求例子
```shell
curl '<Endpoint>/api/v1/login_mapping/switch/get' \
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
        "isDisable": true,
        "type": "GlobalValid"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-F37BF2D0-3A5E-4F38-90BD-2471F08146B6"
} 
```




