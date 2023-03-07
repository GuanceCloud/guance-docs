# 删除一个/多个Pipeline

---

<br />**get /api/v1/pipeline/delete**

## 概述
删除一个/多个Pipeline




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| pipelineUUIDs | commaArray | Y | Pipeline的uuid们<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/pipeline/delete?pipelineUUIDs=pl_d221f03ac39d468d8d7fb262b5792607' \
-H 'DF-API-KEY: <DF-API-KEY>' \
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
    "traceId": "TRACE-E06D4798-E062-4909-A189-521E57129E54"
} 
```




