# 启用/禁用 Pipeline 规则

---

<br />**POST /api/v1/pipeline/batch_set_disable**

## 概述
启用/禁用 Pipeline 规则




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean | Y | 设置启用状态<br>允许为空: False <br> |
| plUUIDs | array | Y | pipeline的UUID<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/pipeline/batch_set_disable' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"plUUIDs":["pl_xxxx32","pl_xxxx32"],"isDisable":false}' \
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
    "traceId": "TRACE-F15D7D75-6D0C-4EAF-A91D-3ECB12481AF8"
} 
```




