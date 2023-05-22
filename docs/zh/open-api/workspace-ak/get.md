# 获取一个Key

---

<br />**get /api/v1/workspace/accesskey/\{ak_uuid\}/get**

## 概述
获取一个Key




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ak_uuid | string | Y | ak 的 UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/accesskey/wsak_b0f7f2b592614f0bbdb003eb9961717d/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1677808718,
        "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "creatorInfo": {
            "email": "88@qq.com",
            "iconUrl": "",
            "name": "88测试",
            "username": "测试"
        },
        "deleteAt": -1,
        "id": 4,
        "name": "test",
        "sk": "aD8ewPWSu07NcdoG92KnXlvk6FHOBCfQ",
        "status": 0,
        "updateAt": 1677808718,
        "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "uuid": "wsak_b0f7f2b592614f0bbdb003eb9961717d",
        "workspaceUUID": "wksp_8ea5c78a71e64298bffd4d3ec03f1a5f"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-652BF56F-67F6-4A08-AF35-2BDFDCF12D89"
} 
```




