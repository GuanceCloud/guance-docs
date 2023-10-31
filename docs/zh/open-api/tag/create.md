# 添加标签

---

<br />**POST /api/v1/tag/create**

## 概述
新建标签




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | tag标签名<br>允许为空: False <br>最大长度: 50 <br> |
| description | string |  | tag描述<br>允许为空: False <br>最大长度: 100 <br> |
| colour | string |  | tag颜色<br>允许为空: False <br>最大长度: 50 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/tag/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"test_1","description":"temp_test","colour":"style_key3"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "colour": "style_key3",
        "createAt": 1698754975,
        "creator": "wsak_72b16919b18c411496b6dd06fc9ccc72",
        "deleteAt": -1,
        "description": "temp_test",
        "id": 358,
        "name": "test_1",
        "status": 0,
        "updateAt": 1698754975,
        "updator": "wsak_72b16919b18c411496b6dd06fc9ccc72",
        "uuid": "tag_769821ae7f2c435d8ffe6c510cc3d38c",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-DEC68DA3-9AFB-4B56-A57D-530A2B67AFED"
} 
```




