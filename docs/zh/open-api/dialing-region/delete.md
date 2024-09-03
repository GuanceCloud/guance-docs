# 删除一个自建节点

---

<br />**GET /api/v1/dialing_region/\{region_uuid\}/delete**

## 概述
删除一个自建节点




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| region_uuid | string | Y | 拨测节点的ID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dialing_region/reg_xxxx20/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {},
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4E49DEAB-8321-4EFF-96FC-71D5CC4C00A1"
} 
```




