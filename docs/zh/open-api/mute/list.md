# 获取静默规则列表

---

<br />**GET /api/v1/monitor/mute/list**

## 概述
分页获取静默规则列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索规则名<br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1642572752,
            "creator": "wsak_xxxxx",
            "deleteAt": -1,
            "end": 1642576351,
            "id": 383,
            "notifyMessage": "",
            "notifyTargets": [],
            "notifyTime": -1,
            "start": 1642572751,
            "status": 0,
            "tags": [
                {
                    "host": "testname"
                }
            ],
            "type": "host",
            "updateAt": 1642572752,
            "updator": "wsak_xxxxx",
            "updatorInfo": {
                "name": "frasgreager",
                "username": "xxxx"
            },
            "uuid": "mute_9cfc0c557a5b4df6924c0f9648be8890",
            "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 2,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-AB73EEDD-3873-4EBD-A424-722022770AD5"
} 
```




