# 启用一个自建监控器

---

<br />**post /api/v1/self_built_checker/enable**

## 概述
根据`checker_uuid`启用一个自建监控器




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ruleUUID | string |  | 自建监控器的UUID<br>例子: rul_xxxxx <br>允许为空: False <br> |
| refKey | string |  | 自建监控器的关联key<br>例子: xxx <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/self_built_checker/rul_d0736e059fd74d859cdcdce102687378/enable' \
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



