# 删除一个快照

---

<br />**POST /api/v1/snapshots/\{snapshot_uuid\}/delete**

## 概述
根据`snapshot_uuid`删除指定的快照配置




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| snapshot_uuid | string | Y | 快照UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/snapshots/snap_xxxx32/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw 'null' \
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
    "traceId": "TRACE-478399EF-25DA-4B91-9543-FFAC521E77B1"
} 
```




