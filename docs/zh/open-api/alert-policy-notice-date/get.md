# 告警策略-自定义通知日期 获取

---

<br />**GET /api/v1/notice/date/\{notice_date_uuid\}/get**

## 概述
告警策略-自定义通知日期 获取




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| notice_date_uuid | string | Y | 告警策略-自定义通知日期配置的唯一UUID<br>允许为空字符串: False <br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/notice/date/ndate_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1705566710,
        "creator": "xxx",
        "dates": [
            "2025/01/01",
            "2025/10/01"
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
        },
        "deleteAt": -1,
        "id": 4,
        "name": "test002",
        "status": 0,
        "updateAt": 1705567170,
        "updator": "xxx",
        "uuid": "ndate_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-CB587B59-4BCA-4CEE-97FE-38334ED9F96E"
} 
```




