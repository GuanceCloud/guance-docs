# 启用一个静默规则

---

<br />**post /api/v1/monitor/mute/\{mute_uuid\}/enable**

## 概述
根据`mute_uuid`启用一个静默规则




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| mute_uuid | string | Y | 静默规则UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl '<Endpoint>/api/v1/monitor/mute/mute_d0736e059fd74d859cdcdce102687378/enable' \
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
    "traceId": "TRACE-5191E0CC-076F-42D4-80C6-16A3FC9E0A09"
} 
```




