# Get Default Configuration Status of Issue

---

<br />**GET /api/v1/issue-level/config/get**

## Overview




## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue-level/config/get' \
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




## Response Explanation
The response indicates whether the default configuration for Issue is enabled or disabled. In this case, `"isDisabled": false` means that the default configuration is not disabled (i.e., it is enabled).