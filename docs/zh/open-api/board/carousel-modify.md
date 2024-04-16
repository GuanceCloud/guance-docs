# 修改单个仪表板轮播配置

---

<br />**POST /api/v1/dashboard/carousel/\{carousel_uuid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| carousel_uuid | string | Y | 轮播UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| dashboardUUIDs | array | Y | 仪表板轮播列表名称<br>允许为空: False <br> |
| name | string | Y | 仪表板轮播名称<br>允许为空: False <br>最大长度: 256 <br> |
| intervalTime | string | Y | 轮播频率<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dashboard/carousel/csel_66f8ae3900484007bc0c807832b7be11/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"test2","dashboardUUIDs":["dsbd_e4ce57f12e2145fa9c5994195906a5fe", "dsbd_28a1718f1b5547a58a40f2167948bdc6"],"intervalTime":"40s"}' \
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
        "dashboardUUIDs": [
            "dsbd_e4ce57f12e2145fa9c5994195906a5fe",
            "dsbd_28a1718f1b5547a58a40f2167948bdc6"
        ],
        "deleteAt": -1,
        "id": 30,
        "intervalTime": "40s",
        "name": "test2",
        "status": 0,
        "updateAt": 1698664410,
        "updator": "wsak_xxxxx",
        "uuid": "csel_66f8ae3900484007bc0c807832b7be11",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1D046084-B570-4955-B84B-CE5E226E7668"
} 
```




