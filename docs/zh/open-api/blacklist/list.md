# 获取黑名单列表

---

<br />**GET /api/v1/blacklist/list**

## 概述
获取黑名单列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string | Y | 黑名单类型/查询日志黑名单type值为logging.查询管理子菜单下的黑名单type值传all字符串即查询所有黑名单<br>允许为空: False <br>例子: logging/all <br> |
| search | string |  | 搜索名字<br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/blacklist/list?type=all&pageIndex=1&pageSize=20' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "conditions": "{ source =  'kodo-log'  and ( host in [ '127.0.0.1' ] )}",
            "createAt": 1678029404,
            "creator": "xxx",
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
            "filters": [
                {
                    "condition": "and",
                    "name": "host",
                    "operation": "in",
                    "value": [
                        "127.0.0.1"
                    ]
                }
            ],
            "id": 59,
            "source": "kodo-log",
            "status": 0,
            "type": "logging",
            "updateAt": 1678029404,
            "updator": "xxx",
            "updatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "uuid": "blist_xxx481",
            "workspaceUUID": "wksp_xxx115"
        },
        {
            "conditions": "{ source =  'kodo-log'  and ( name in [ 'a' ] )}",
            "createAt": 1677653414,
            "creator": "xx",
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
            "filters": [
                {
                    "condition": "and",
                    "name": "name",
                    "operation": "in",
                    "value": [
                        "a"
                    ]
                }
            ],
            "id": 24,
            "source": "kodo-log",
            "status": 0,
            "type": "logging",
            "updateAt": 1678027698,
            "updator": "xx",
            "updatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "uuid": "blist_xxxd36",
            "workspaceUUID": "wksp_xxx115"
        },
        {
            "conditions": "{ source =  'datakit'  and ( status in [ 'ok' ,  'info' ]  and  host in [ 'cc-testing-cluster-001' ]  and  message in [ 'kodo' ] )}",
            "createAt": 1677565045,
            "creator": "xx",
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
            "filters": [
                {
                    "condition": "and",
                    "name": "status",
                    "operation": "in",
                    "value": [
                        "ok",
                        "info"
                    ]
                },
                {
                    "condition": "and",
                    "name": "host",
                    "operation": "in",
                    "value": [
                        "cc-testing-cluster-001"
                    ]
                },
                {
                    "condition": "and",
                    "name": "message",
                    "operation": "in",
                    "value": [
                        "kodo"
                    ]
                }
            ],
            "id": 16,
            "source": "datakit",
            "status": 0,
            "type": "logging",
            "updateAt": 1677565045,
            "updator": "xx",
            "updatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "uuid": "blist_xxx6b5",
            "workspaceUUID": "wksp_xxx115"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 3,
        "pageIndex": 1,
        "pageSize": 20,
        "totalCount": 3
    },
    "success": true,
    "traceId": "TRACE-E7DF5A1A-0B7F-47F7-815E-F73AB4F2F8CF"
} 
```




