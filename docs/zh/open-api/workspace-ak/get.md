# 获取一个Key

---

<br />**GET /api/v1/workspace/accesskey/\{ak_uuid\}/get**

## 概述
获取一个Key




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ak_uuid | string | Y | ak 的 UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/accesskey/wsak_xxxxx/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1677808718,
        "creator": "acnt_xxxx32",
        "creatorInfo": {
            "email": "88@qq.com",
            "iconUrl": "",
            "name": "88测试",
            "username": "测试"
        },
        "deleteAt": -1,
        "id": 4,
        "name": "test",
        "sk": "xxxx",
        "status": 0,
        "updateAt": 1677808718,
        "updator": "acnt_xxxx32",
        "uuid": "wsak_xxxxx",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-652BF56F-67F6-4A08-AF35-2BDFDCF12D89"
} 
```




