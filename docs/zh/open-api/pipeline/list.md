# 获取Pipeline列表

---

<br />**GET /api/v1/pipeline/list**

## 概述
获取Pipeline列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 文件名称(source值)<br>允许为空: False <br> |
| categories | commaArray |  | 类别列表，以逗号分隔<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/pipeline/list' \
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
                "asDefault": 0,
                "category": "logging",
                "creator": "xxx",
                "name": "openapi_test",
                "status": 0,
                "updateAt": 1678026470,
                "uuid": "pl_d221f03ac39d468d8d7fb262b5792607"
            },
            {
                "asDefault": 0,
                "category": "logging",
                "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
                "name": "eee",
                "status": 0,
                "updateAt": 1677814027,
                "uuid": "pl_820594c9ba5a48fa930952946ca778f1"
            },
            {
                "asDefault": 0,
                "category": "logging",
                "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
                "name": "JMauto_logging1",
                "status": 0,
                "updateAt": 1677640634,
                "uuid": "pl_b1d5fe7e4c854998b78244f1903e307f"
            },
            {
                "asDefault": 0,
                "category": "logging",
                "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
                "name": "1",
                "status": 0,
                "updateAt": 1677637485,
                "uuid": "pl_f69f03d5dea44fe4951f63e93a35996f"
            },
            {
                "asDefault": 0,
                "category": "logging",
                "creator": "acnt_4e8a5d1ba8434e4dbb3cdcd240483151",
                "name": "kodolog",
                "status": 2,
                "updateAt": 1677636474,
                "uuid": "pl_7d2866db086b4850a5acbd44660d3877"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-ABDC1CCF-BC78-4463-8276-2F14225B1A6B"
} 
```




