# 修改标签

---

<br />**POST /api/v1/tag/\{tag_uuid\}/modify**

## 概述
修改标签




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| tag_uuid | string | Y | 标签UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | tag标签名<br>允许为空: False <br>最大长度: 50 <br> |
| description | string |  | tag描述<br>允许为空: False <br>最大长度: 100 <br> |
| colour | string |  | tag颜色<br>允许为空: False <br>最大长度: 50 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/tag/tag_1e2950a080c949039285a5edfce12cd4/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"test_15","description":"temp_test_modify","colour":"style_key3"}' \
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
        "description": "temp_test_modify",
        "id": 357,
        "name": "test_15",
        "status": 0,
        "updateAt": 1698755100.0688698,
        "updator": "wsak_72b16919b18c411496b6dd06fc9ccc72",
        "uuid": "tag_1e2950a080c949039285a5edfce12cd4",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-CF5D416A-259C-43B7-A6B0-E8F00E234ED6"
} 
```




