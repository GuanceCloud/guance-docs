# 获取空间角色敏感数据脱敏字段

---

<br />**GET /api/v1/workspace/role/sensitive_mask_fields**

## 概述
获取空间角色敏感数据脱敏字段




## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/role/sensitive_mask_fields' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
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




