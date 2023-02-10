# 删除一个/多个监控器

---

<br />**post /api/v1/monitor/check/delete**

## 概述
删除一个/多个监控器




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ruleUUIDs | array | Y | 检查器的UUID列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
``shell
curl 'https://openapi.guance.com/api/v1/monitor/check/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"ruleUUIDs": ["rul_692741d674ac4aea9980979721591b35", "rul_79f1adceb3c8418d943f38767d05f981"]}' \
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
    "traceId": "TRACE-F010835F-BD10-429A-974C-8CFED4A76F0D"
} 
```




