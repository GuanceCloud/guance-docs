# Import Pipeline Rules

---

<br />**POST /api/v1/pipeline/import**

## Overview
Import one or more Pipelines


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:-------------------------|
| pipelines            | array    | Y         | List of pipelines<br>Allow null: False <br> |
| isForce              | boolean  |           | Whether to replace when the specific type exists with a default<br>Allow null: False <br> |
| pipelineType         | string   | Y         | Used to distinguish whether the import is from the logging menu or the management menu<br>Example: logging <br>Optional values: ['logging', 'all'] <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/pipeline/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"pipelines":[{"asDefault":0,"category":"logging","content":"ZW51bWVyYXRl\n","extend":{},"isDisable":false,"name":"eee","source":["calico-node"],"testData":"W10=\n"}],"pipelineType":"all"}' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "fail_count": 0,
        "success_count": 1
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-F1FA4700-68DF-4808-995E-45D6161D67B1"
} 
```