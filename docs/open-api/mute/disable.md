# 禁用一个静默规则

---

<br />**post /api/v1/monitor/mute/\{mute_uuid\}/disable**

## 概述
根据`mute_uuid`禁用一个静默规则




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| mute_uuid | string | Y | 静默规则UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/mute_71e719ee94f84d65a3fa68fb3054a815/disable' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw 'null' \
--compressed \
--insecure
```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1969B4EA-18AE-4D23-AAC7-3FC6586493EB"
} 
```




