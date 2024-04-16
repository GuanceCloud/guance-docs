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
curl 'https://openapi.guance.com/api/v1/dashboard/carousel/csel_66f8ae3900484007bc0c807832b7be11/get' \
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
                "dsbd_e4ce57f12e2145fa9c5994195906a5fe": "dcl test"
            }
        ],
        "dashboardUUIDs": [
            "dsbd_e4ce57f12e2145fa9c5994195906a5fe"
        ],
        "deleteAt": -1,
        "id": 30,
        "intervalTime": "30s",
        "name": "test2",
        "status": 0,
        "updateAt": 1698663545,
        "updator": "wsak_xxxxx",
        "uuid": "csel_66f8ae3900484007bc0c807832b7be11",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-7B80C86C-F512-44F1-8598-80760F31E0AE"
} 
```




