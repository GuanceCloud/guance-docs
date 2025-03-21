# 获取笔记列表

---

<br />**GET /api/v1/notes/list**

## 概述
列出所有符合条件的笔记内容, 当前接口无分页




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 笔记名称搜索<br>允许为空: False <br> |

## 参数补充说明

参数说明:




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notes/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "createAt": 1642588739,
                "creator": "acnt_xxxx32",
                "creatorInfo": {
                    "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                    "name": "66",
                    "username": "xxx@<<< custom_key.brand_main_domain >>>"
                },
                "deleteAt": -1,
                "id": 185,
                "isFavourited": false,
                "name": "我的笔记",
                "pos": [
                    {
                        "chartUUID": "chrt_xxxx32"
                    }
                ],
                "status": 0,
                "updateAt": 1642588739,
                "updator": "acnt_xxxx32",
                "updatorInfo": {
                    "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                    "name": "66",
                    "username": "xxx@<<< custom_key.brand_main_domain >>>"
                },
                "uuid": "notes_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-123ADCD7-95F0-4EDC-A27A-649885FAF9CD"
} 
```




