# 删除一个仪表板

---

<br />**post /api/v1/dashboards/\{dashboard_uuid\}/delete**

## 概述
根据指定的`dashboard_uuid` 删除仪表板




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | 视图ID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dashboards/dsbd_501b8277ba88479b82020dbfc92e110c/delete' \
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
        "dsbd_541083cc19ec4d27ad597839a0477a97": "test"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-AFBA9730-1A3A-4D2A-AF3B-EEDE315AB6CD"
} 
```




