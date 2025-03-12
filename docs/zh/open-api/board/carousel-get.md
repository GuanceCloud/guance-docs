# 获取单个仪表板轮播配置

---

<br />**GET /api/v1/dashboard/carousel/\{carousel_uuid\}/get**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| carousel_uuid | string | Y | 轮播UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboard/carousel/csel_xxxx32/get' \
-H 'Accept-Language: zh' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "accountUUID": "wsak_xxxxx",
        "createAt": 1698663545,
        "creator": "wsak_xxxxx",
        "dashboardInfo": [
            {
                "dsbd_xxxx32": "dcl test"
            }
        ],
        "dashboardUUIDs": [
            "dsbd_xxxx32"
        ],
        "deleteAt": -1,
        "id": 30,
        "intervalTime": "30s",
        "name": "test2",
        "status": 0,
        "updateAt": 1698663545,
        "updator": "wsak_xxxxx",
        "uuid": "csel_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-7B80C86C-F512-44F1-8598-80760F31E0AE"
} 
```




