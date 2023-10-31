# 获取标签信息

---

<br />**GET /api/v1/tag/\{tag_uuid\}/get**

## 概述
获取标签详情




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| tag_uuid | string | Y | 标签UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/tag/tag_1e2950a080c949039285a5edfce12cd4/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "colour": "style_key3",
        "createAt": 1698754516,
        "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "deleteAt": -1,
        "description": "temp_test",
        "id": 357,
        "name": "test_ha",
        "status": 0,
        "updateAt": 1698754516,
        "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "uuid": "tag_1e2950a080c949039285a5edfce12cd4",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-614EDF3A-BB62-4DC4-BBDD-6BC0F2C7FC54"
} 
```




