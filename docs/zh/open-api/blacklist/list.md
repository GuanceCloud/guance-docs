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
            "uuid": "blist_92c88afa154f44ca851e8465c8408481",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        },
        {
            "conditions": "{ source =  'kodo-log'  and ( name in [ 'a' ] )}",
            "createAt": 1677653414,
            "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
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
            "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "uuid": "blist_58770f806d104f63bdee9bc1941bed36",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        },
        {
            "conditions": "{ source =  'datakit'  and ( status in [ 'ok' ,  'info' ]  and  host in [ 'cc-testing-cluster-001' ]  and  message in [ 'kodo' ] )}",
            "createAt": 1677565045,
            "creator": "acnt_7df07453091748b08f5ea2514f6a22f2",
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
            "updator": "acnt_7df07453091748b08f5ea2514f6a22f2",
            "uuid": "blist_ae7363822a164625bb6a85abdee4b6b5",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
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




