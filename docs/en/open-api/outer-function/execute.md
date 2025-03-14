# [Func Function] Execute External Function

---

<br />**POST /api/v1/outer_function/execute**

## Overview
Initiate an execution request for a specified Func function


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| funcId | string | Y | Function ID<br>Example: hello_world_msg <br>Can be empty: False <br> |
| funcBody | json |  | Function request body<br>Can be empty: False <br> |
| funcBody.kwargs | json |  | Function call dictionary parameters (**kwargs)<br>Example: {'msg': 'tom'} <br>Can be empty: False <br> |
| funcBody.options | json |  | Return type (default raw)<br>Can be empty: False <br> |
| funcBody.options.returnType | custom_enum |  | Return type (default raw)<br>Example: jsonDumps <br>Can be empty: False <br>Options: ['ALL', 'raw', 'repr', 'jsonDumps'] <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/outer_function/execute' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw $'{\n  "funcId": "guance__openapi.test",\n  "funcBody": {\n    "kwargs": {\n      "workspace_token": {},\n        "workspace_uuid": {},\n        "your_name": {\n          "default": "OpenAPI User"\n        }\n    }\n  }\n}' \
  --compressed
```


## Response
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
            "bodyDump": "{\n  \\\"kwargs\\\": {\n    \\\"workspace_token\\\": {},\n    \\\"workspace_uuid\\\": {},\n    \\\"your_name\\\": {\n      \\\"default\\\": \\\"OpenAPI User\\\"\n    }\n  }\n}",
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