# 创建一个笔记

---

<br />**POST /api/v1/notes/create**

## 概述
创建笔记, `charUUIDs`为该笔记绑定的图表信息




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 笔记名称<br>允许为空: False <br>最大长度: 128 <br> |
| chartUUIDs | array |  | 笔记类型, 默认为 CUSTOM<br>例子: CUSTOM <br>允许为空: False <br>最大长度: 32 <br> |
| extend | json |  | 笔记的额外数据, 默认为{}<br>例子: {} <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notes/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"openapi_note","chartUUIDs":["chrt_xxxx32","chrt_xxxx32"],"extend":{"fixedTime":"15m"}}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1677656782,
        "creator": "wsak_xxxxx",
        "deleteAt": -1,
        "extend": {
            "fixedTime": "15m"
        },
        "id": null,
        "isPublic": 1,
        "name": "jinlei_openapi",
        "pos": [
            {
                "chartUUID": "chrt_xxxx32"
            },
            {
                "chartUUID": "chrt_xxxx32"
            }
        ],
        "status": 0,
        "updateAt": 1677656782,
        "updator": "wsak_xxxxx",
        "uuid": "notes_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-7FBE845D-2099-4403-A040-51782A27B02A"
} 
```




