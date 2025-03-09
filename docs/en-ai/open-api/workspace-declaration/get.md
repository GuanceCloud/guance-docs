# Get Declaration Information

---

<br />**GET /api/v1/workspace/declaration/get**

## Overview




## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/declaration/get' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "subdepartment": "subdepartment1",
        "business": [
            "business unit",
            "industry department one"
        ],
        "declaration": null,
        "organization": "88"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-5E647E30-769E-419C-BE5B-348824B41A42"
} 
```