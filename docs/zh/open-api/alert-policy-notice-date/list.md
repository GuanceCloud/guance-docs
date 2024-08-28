# 告警策略-自定义通知日期 列出

---

<br />**GET /api/v1/notice/date/list**

## 概述
告警策略-自定义通知日期 列出




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索自定义通知日期的配置名称<br>允许为空: True <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 10000 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/notice/date/list?pageIndex=1&pageSize=10' \
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
                "createAt": 1705567043,
                "creator": "xx",
                "dates": [
                    "2024/01/01",
                    "2024/05/01"
                ],
                "deleteAt": -1,
                "id": 5,
                "name": "test001",
                "status": 0,
                "updateAt": 1705567043,
                "updator": "xxx",
                "uuid": "ndate_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            },
            {
                "createAt": 1705566710,
                "creator": "xxx",
                "dates": [
                    "2025.01.01",
                    "2025.10.01"
                ],
                "deleteAt": -1,
                "id": 4,
                "name": "test002",
                "status": 0,
                "updateAt": 1705567170,
                "updator": "xx",
                "uuid": "ndate_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            },
            {
                "createAt": 1705560344,
                "creator": "acnt_xxxx32",
                "dates": [
                    "2025-03-04",
                    "2026.04.09"
                ],
                "deleteAt": -1,
                "id": 1,
                "name": "jinlei_03",
                "status": 0,
                "updateAt": 1705562459,
                "updator": "acnt_xxxx32",
                "uuid": "ndate_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            }
        ],
        "declaration": {
            "asd": [
                "afaw"
            ],
            "asdasd": [
                "dawdawd"
            ],
            "business": "aaa",
            "fawf": [
                "afawf"
            ],
            "organization": "6540c09e4243b300077a9675"
        }
    },
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 3,
        "pageIndex": 1,
        "pageSize": 20,
        "totalCount": 3
    },
    "success": true,
    "traceId": "TRACE-545F2180-3696-4EED-A8B1-9EF909A47510"
} 
```




