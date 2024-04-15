# 告警策略-自定义通知日期 创建

---

<br />**POST /api/v1/notice/date/add**

## 概述
告警策略-自定义通知日期 创建




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
curl 'https://openapi.guance.com/api/v1/notice/date/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "test001", "noticeDates": ["2024/01/01","2024/05/01"]}' \
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
            "2024/01/01",
            "2024/05/01"
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
        "id": null,
        "name": "test001",
        "status": 0,
        "updateAt": 1705566710,
        "updator": "xxx",
        "uuid": "ndate_302cd65724974557aa25f45dade30f00",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6C9D0B1B-9591-45B9-B196-692A8FDF06F2"
} 
```




