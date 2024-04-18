# 新建单个仪表板轮播配置

---

<br />**POST /api/v1/dashboard/carousel/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| dashboardUUIDs | array | Y | 仪表板轮播列表名称<br>允许为空: False <br> |
| name | string | Y | 仪表板轮播名称<br>允许为空: False <br>最大长度: 256 <br> |
| intervalTime | string | Y | 轮播频率<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dashboard/carousel/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"test1","dashboardUUIDs":["dsbd_e4ce57f12e2145fa9c5994195906a5fe"],"intervalTime":"30s"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
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
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-F7A6DEEE-80B5-4815-AA58-670F75428CD4"
} 
```




