# 获取Pipeline列表

---

<br />**GET /api/v1/pipeline/list**

## 概述
获取Pipeline列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 文件名称(source值)<br>允许为空: False <br> |
| type | string |  | Pipeline文件类型<br>允许为空: False <br>可选值: ['local', 'central'] <br> |
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
                "uuid": "pl_xxxx32"
            },
            {
                "asDefault": 0,
                "category": "logging",
                "creator": "acnt_xxxx32",
                "name": "eee",
                "status": 0,
                "updateAt": 1677814027,
                "uuid": "pl_xxxx32"
            },
            {
                "asDefault": 0,
                "category": "logging",
                "creator": "acnt_xxxx32",
                "name": "JMauto_logging1",
                "status": 0,
                "updateAt": 1677640634,
                "uuid": "pl_xxxx32"
            },
            {
                "asDefault": 0,
                "category": "logging",
                "creator": "acnt_xxxx32",
                "name": "1",
                "status": 0,
                "updateAt": 1677637485,
                "uuid": "pl_xxxx32"
            },
            {
                "asDefault": 0,
                "category": "logging",
                "creator": "acnt_xxxx32",
                "name": "kodolog",
                "status": 2,
                "updateAt": 1677636474,
                "uuid": "pl_xxxx32"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-ABDC1CCF-BC78-4463-8276-2F14225B1A6B"
} 
```




