# 删除一个/多个黑名单

---

<br />**GET /api/v1/blacklist/delete**

## 概述
删除一个/多个黑名单




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| blacklistUUIDs | commaArray | Y | 黑名单过滤规则uuid们<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/blacklist/delete?blacklistUUIDs=blist_xxxx32' \
-H 'DF-API-KEY: <DF-API-KEY>' \
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
    "traceId": "TRACE-2373CA38-F685-49FE-9233-E7BB6AEBE8F8"
} 
```




