# Get Workspace Role Sensitive Data Masking Fields

---

<br />**GET /api/v1/workspace/role/sensitive_mask_fields**

## Overview
Get the current workspace feature menu




## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/role/sensitive_mask_fields' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "dd": "dd",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "logging": {
            "readOnly": [
                "message"
            ]
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-22B58595-D7B9-45FE-BB5C-42EDC1CFDAD1"
} 
```



In this translation, specific terms such as "工作空间" are translated to "workspace," and "敏感数据脱敏字段" is translated to "sensitive data masking fields." The API endpoint and response structure are kept intact to ensure compatibility and accuracy.