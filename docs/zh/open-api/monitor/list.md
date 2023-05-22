# 获取告警策略列表

---

<br />**get /api/v1/monitor/group/list**

## 概述
分页获取告警策略列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索告警策略名称<br>允许为空: True <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/monitor/group/list?pageIndex=1&pageSize=10' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "alertOpt": {
                "alertTarget": [
                    {
                        "status": [
                            "critical",
                            "error",
                            "warning"
                        ],
                        "to": [],
                        "type": "mail"
                    },
                    {
                        "status": [
                            "critical",
                            "error",
                            "warning"
                        ],
                        "to": [
                            "notify_797efeea4ccd400383d1960bc3f6da1e"
                        ],
                        "type": "notifyObject"
                    }
                ],
                "silentTimeout": 1800
            },
            "config": {},
            "createAt": 1641869038,
            "creator": "acnt_4731c3ae86e211eb8a766eb01d27615a",
            "deleteAt": -1,
            "id": 768,
            "name": "默认分组",
            "ruleCount": 15,
            "status": 0,
            "type": "default",
            "updateAt": 1642580425,
            "updator": "acnt_6f2fd4c0766d11ebb56ef2b2c21faf74",
            "uuid": "monitor_3f5e5d2108f74e07b8fb1e7459aae2b8",
            "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 1,
        "totalCount": 48
    },
    "success": true,
    "traceId": "TRACE-DCAA8E03-E266-4EE3-AAD6-C38E2EF59689"
} 
```




