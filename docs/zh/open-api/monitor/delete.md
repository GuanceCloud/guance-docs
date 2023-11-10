# 删除一个告警策略

---

<br />**POST /api/v1/monitor/group/\{monitor_uuid\}/delete**

## 概述
根据`monitor_uuid`删除指定的告警策略, 并将该分组下的 检查器转移至【默认分组】下




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| monitor_uuid | string | Y | 告警策略UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/monitor/group/monitor_70a7e8549ea54bbeaeb9e4eaec52bad2/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw 'null' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "monitor_84cbb7c18f964771b8153fbca1013615": "修改后的名称"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-7ED823AD-60ED-40BD-ABDB-8D7F3F400B9F"
} 
```




