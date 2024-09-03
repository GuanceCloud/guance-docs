# 删除一个查看器

---

<br />**GET /api/v1/viewer/\{viewer_uuid\}/delete**

## 概述
删除查看器




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| viewer_uuid | string | Y | 查看器UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/viewer/dsbd_xxxx32/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "dsbd_xxxx32": "modify_viewer"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-ADF4A5FE-4BA1-4FDA-8157-E4EEDD07FF82"
} 
```




