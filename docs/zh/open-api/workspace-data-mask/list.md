# 列出

---

<br />**GET /api/v1/data_mask_rule/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索规则名称<br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/data_mask_rule/list' \
-H 'Content-Type: application/json' \
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
                "createAt": 1715571687,
                "creator": "acnt_xxxxxe",
                "creatorInfo": {
                    "uuid": "xx",
                    "status": 0,
                    "username": "xx",
                    "name": "xx",
                    "iconUrl": "",
                    "email": "xx",
                    "acntWsNickname": "xx"
                },
                "deleteAt": -1,
                "field": "aaabbb",
                "id": 150,
                "name": "gary-test123321",
                "reExpr": "https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_\\+.~#?&//=]*)",
                "roleUUIDs": [
                    "wsAdmin"
                ],
                "roles": [
                    {
                        "name": "Administrator",
                        "uuid": "wsAdmin"
                    }
                ],
                "status": 0,
                "type": "logging",
                "updateAt": 1715910622,
                "updator": "acnt_xxxxx1",
                "updatorInfo": {
                    "uuid": "xx",
                    "status": 0,
                    "username": "xx",
                    "name": "xx",
                    "iconUrl": "",
                    "email": "xx",
                    "acntWsNickname": "xx"
                },
                "uuid": "wdmk_xxxx6",
                "workspaceUUID": "wksp_xxxx015d"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 1,
        "totalCount": 11
    },
    "success": true,
    "traceId": "TRACE-DDB4E1C4-9E98-4D80-94BE-745918802B8B"
} 
```




