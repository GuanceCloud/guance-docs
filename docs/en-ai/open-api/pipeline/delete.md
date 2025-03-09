# Delete Pipeline Rule

---

<br />**GET /api/v1/pipeline/delete**

## Overview
Delete one or multiple Pipelines


## Query Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| pipelineUUIDs         | commaArray | Y        | UUIDs of the Pipelines<br>Allow empty: False <br> |

## Additional Parameter Explanation



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/pipeline/delete?pipelineUUIDs=pl_xxxx32' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-E06D4798-E062-4909-A189-521E57129E54"
} 
```