# Get Default Configuration Status for Issue

---

<br />**GET /api/v1/issue-level/config/get**

## Overview




## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue-level/config/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "isDisabled": false
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-CDE3B645-7CE4-43E1-B06B-090F72A3902C"
} 
```