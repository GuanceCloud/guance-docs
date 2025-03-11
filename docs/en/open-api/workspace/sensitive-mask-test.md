# Workspace Sensitive Data Masking Rule Test

---

<br />**POST /api/v1/workspace/sensitive_mask_rule/test**

## Overview
Workspace sensitive data masking rule test

## Body Request Parameters

| Parameter Name | Type   | Required | Description                                                                                             |
|:--------------|:-------|:--------|:------------------------------------------------------------------------------------------------------|
| roleUUIDs     | array  | Y       | Account roles associated<br>Allow empty: False <br>Example: ['general', 'role_43f57c813b034c4b806a1a647b4ee387'] <br> |
| namespace     | string | Y       | Masking type<br>Allow empty: False <br>Allow empty string: False <br>Example: logging <br>Possible values: ['logging', 'metric', 'object', 'custom_object', 'keyevent', 'tracing', 'rum', 'security', 'network', 'profiling', 'billing'] <br> |
| data          | array  | Y       | Email headers<br>Allow empty: False <br>Example: [{'host': 'hangzhou_127', 'message': 'xxxL, id: 234887209348'}, {'host': 'xihu', 'message': 'xxxL, id: 234234234'}] <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/sensitive_mask_rule/test' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"namespace":"logging","roleUUIDs":["readOnly"],"data":[{"host":"jinlei","message":"sakldfu93w4urfjsndf / GET"},{"host":"hangzhou1234","message":"tokenUUID: 9083hsdf"}]}' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": [
        {
            "declaration": {
                "asd": "aa,bb,cc,1,True",
                "asdasd": "dawdawd",
                "business": "aaa",
                "dd": "dd",
                "fawf": "afawf",
                "organization": "64fe7b4062f74d0007b46676"
            },
            "host": "jinlei",
            "message": "sakldfu93w4urfjsndf / GET"
        },
        {
            "declaration": {
                "asd": "aa,bb,cc,1,True",
                "asdasd": "dawdawd",
                "business": "aaa",
                "dd": "dd",
                "fawf": "afawf",
                "organization": "64fe7b4062f74d0007b46676"
            },
            "host": "******",
            "message": "tokenUUID: ***"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-D402A9AC-2B08-4F14-A034-8DDBBBF20546"
} 
```