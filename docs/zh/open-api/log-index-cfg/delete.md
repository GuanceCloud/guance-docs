# 删除一个绑定索引

---

<br />**post /api/v1/log_index_cfg/delete**

## 概述
删除一个绑定索引




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| cfgUUID | string | Y | 配置UUID<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/log_index_cfg/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"cfgUUID":"lgim_1145381480dd4a4f95bccdb1f0889141"}' \
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
    "traceId": "TRACE-63EE56F5-8EFB-4FF9-994D-11868B6EFA80"
} 
```




