# 获取仪表板轮播列表

---

<br />**GET /api/v1/dashboard/carousel/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 轮播仪表板名称搜索<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dashboard/carousel/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "accountUUID": "wsak_xxxxx",
            "createAt": 1698663545,
            "creator": "wsak_xxxxx",
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
        {
            "accountUUID": "wsak_xxxxx",
            "createAt": 1698663461,
            "creator": "wsak_xxxxx",
            "dashboardUUIDs": [
                "dsbd_e4ce57f12e2145fa9c5994195906a5fe"
            ],
            "deleteAt": -1,
            "id": 29,
            "intervalTime": "30s",
            "name": "test1",
            "status": 0,
            "updateAt": 1698663461,
            "updator": "wsak_xxxxx",
            "uuid": "csel_58b3ec27b9244ecc8e39f39c0d5c673d",
            "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-BDD0B37E-13B9-48B8-90B2-C9281B8C866F"
} 
```




