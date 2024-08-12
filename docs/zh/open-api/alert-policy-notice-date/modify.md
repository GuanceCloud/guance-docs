# 告警策略-自定义通知日期 修改

---

<br />**POST /api/v1/notice/date/\{notice_date_uuid\}/modify**

## 概述
告警策略-自定义通知日期 修改




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| notice_date_uuid | string | Y | 告警策略-自定义通知日期配置的唯一UUID<br>允许为空字符串: False <br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 名称<br>允许为空: False <br>最大长度: 256 <br> |
| noticeDates | array |  | 日期列表<br>例子: ['2024/01/02', '2024/02/03'] <br>允许为空: False <br> |

## 参数补充说明


数据说明.*

- 请求体参数说明

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| name       | str | 告警策略-自定义通知日期配置名称 |
| noticeDates    | list | 日志列表,示例: ["2024/01/01","2024/05/01", "2024/10/01"]                               |

------




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/notice/date/ndate_302cd65724974557aa25f45dade30f00/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "test002", "noticeDates": ["2025/01/01","2025/10/01"]}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1705566710,
        "creator": "xxxx",
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
        "updateAt": 1705567170.109928,
        "updator": "xxxx",
        "uuid": "ndate_302cd65724974557aa25f45dade30f00",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-53EB1233-2398-4ABD-8CA0-BF14D8C3AA4D"
} 
```




