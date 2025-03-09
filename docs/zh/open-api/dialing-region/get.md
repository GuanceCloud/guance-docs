# 获取一个自建节点的配置

---

<br />**GET /api/v1/dialing_region/\{region_uuid\}/info**

## 概述
获取一个自建节点的配置




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| region_uuid | string | Y | 【云拨测节点】的ID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dialing_region/reg_xxxx20/info' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "ak": {
            "ak": "xxxxx",
            "external_id": "wksp_xxxx32",
            "owner": "",
            "parent_ak": "ak_xxxx20",
            "sk": "xxxx",
            "status": "",
            "update_at": 0
        },
        "regionInfo": {
            "city": "Shahrak",
            "company": "",
            "country": "Afghanistan",
            "create_at": 0,
            "external_id": "wksp_xxxx32",
            "heartbeat": -1,
            "internal": false,
            "isp": "telecom",
            "keycode": "Afghanistan-Shahrak-telecom",
            "name": "test",
            "owner": "custom",
            "parent_ak": "ak_xxxx20",
            "province": "",
            "region": "Afghanistan-Shahrak-telecom",
            "status": "",
            "uuid": "reg_xxxx20"
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6829E84B-B44B-4B27-8B6E-CB164994B22B"
} 
```




