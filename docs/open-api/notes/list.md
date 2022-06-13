# 获取笔记列表

---

<br />**get /api/v1/notes/list**

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
curl '<Endpoint>/api/v1/notes/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "createAt": 1642588739,
                "creator": "acnt_5fc5bb139e474911b6d3d300863f0c8b",
                "creatorInfo": {
                    "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_5fc5bb139e474911b6d3d300863f0c8b.png",
                    "name": "66",
                    "username": "66@qq.com"
                },
                "deleteAt": -1,
                "id": 185,
                "isFavourited": false,
                "name": "我的笔记",
                "pos": [
                    {
                        "chartUUID": "chrt_dc6c1f939f5541bf8302c6d79f5f9800"
                    }
                ],
                "status": 0,
                "updateAt": 1642588739,
                "updator": "acnt_5fc5bb139e474911b6d3d300863f0c8b",
                "updatorInfo": {
                    "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_5fc5bb139e474911b6d3d300863f0c8b.png",
                    "name": "66",
                    "username": "66@qq.com"
                },
                "uuid": "notes_35018053b8864ec190b3a6dbd5b44ab0",
                "workspaceUUID": "wksp_c4201f4ef30c4a86b01a998e7544f822"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-123ADCD7-95F0-4EDC-A27A-649885FAF9CD"
} 
```




