# 获取一个自建节点的配置

---

<br />**get /api/v1/dialing_region/\{region_uuid\}/info**

## 概述
获取一个自建节点的配置




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| region_uuid | string | Y | 【云拨测节点】的ID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dialing_region/reg_cg2britepb7e977fpm8g/info' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "ak": {
            "ak": "4jwIcxedYwSdTsn9rZ0f",
            "external_id": "wksp_ed134a6485c8484dbd0e58ce9a9c6115",
            "owner": "",
            "parent_ak": "ak_c1imts73q2c335d71cn0",
            "sk": "utiGZCqZkEe6ZzKyW30xczv96joMrmvGAfxuJ7Fr",
            "status": "",
            "update_at": 0
        },
        "regionInfo": {
            "city": "Shahrak",
            "company": "",
            "country": "Afghanistan",
            "create_at": 0,
            "external_id": "wksp_ed134a6485c8484dbd0e58ce9a9c6115",
            "heartbeat": -1,
            "internal": false,
            "isp": "telecom",
            "keycode": "Afghanistan-Shahrak-telecom",
            "name": "test",
            "owner": "custom",
            "parent_ak": "ak_c1imts73q2c335d71cn0",
            "province": "",
            "region": "Afghanistan-Shahrak-telecom",
            "status": "",
            "uuid": "reg_cg2britepb7e977fpm8g"
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6829E84B-B44B-4B27-8B6E-CB164994B22B"
} 
```




