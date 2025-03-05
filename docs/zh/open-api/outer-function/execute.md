# 【Func函数】执行外部函数

---

<br />**POST /api/v1/outer_function/execute**

## 概述
对指定的 Func 函数发起一次执行请求




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| funcId | string | Y | 函数ID<br>例子: hello_world_msg <br>允许为空: False <br> |
| funcBody | json |  | 函数请求体<br>允许为空: False <br> |
| funcBody.kwargs | json |  | 函数调用字典参数（**kwargs）<br>例子: {'msg': 'tom'} <br>允许为空: False <br> |
| funcBody.options | json |  | 返回类型（默认raw）<br>允许为空: False <br> |
| funcBody.options.returnType | custom_enum |  | 返回类型（默认raw）<br>例子: jsonDumps <br>允许为空: False <br>可选值: ['ALL', 'raw', 'repr', 'jsonDumps'] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/outer_function/execute' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw $'{\n  "funcId": "guance__openapi.test",\n  "funcBody": {\n    "kwargs": {\n      "workspace_token": {},\n        "workspace_uuid": {},\n        "your_name": {\n          "default": "OpenAPI 用户"\n        }\n    }\n  }\n}' \
  --compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "detail": {
            "einfoTEXT": "redis.exceptions.DataError: Invalid input of type: 'dict'. Convert to a bytes, string, int or float first.",
            "id": "task-4G5qTZol2lW2"
        },
        "error": 599.3,
        "message": "Calling Function failed",
        "ok": false,
        "reason": "EFuncFailed",
        "reqCost": 41,
        "reqDump": {
            "bodyDump": "{\n  \\\"kwargs\\\": {\n    \\\"workspace_token\\\": {},\n    \\\"workspace_uuid\\\": {},\n    \\\"your_name\\\": {\n      \\\"default\\\": \\\"OpenAPI 用户\\\"\n    }\n  }\n}",
            "method": "POST",
            "url": "/api/v1/func/guance__openapi.test"
        },
        "reqTime": "2022-09-08T03:54:24.529Z",
        "respTime": "2022-09-08T03:54:24.570Z",
        "traceId": "TRACE-16435F71-4C2E-4026-A5D8-0B6B9ADD23AE"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-16435F71-4C2E-4026-A5D8-0B6B9ADD23AE"
} 
```




