# 启用/禁用监控器

---

<br />**POST /api/v1/checker/set_disable**

## 概述
启用/禁用一个监控器




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean | Y | 设置启用状态<br>允许为空: False <br> |
| ruleUUIDs | array | Y | 检查项的UUID列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/checker/set_disable' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"ruleUUIDs":["rul_xxxx32"],"isDisable":true}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-68A1C512-21C2-48F9-A12A-C70EE3722C5C"
} 
```




