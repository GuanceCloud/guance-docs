# 空间 敏感数据脱敏规则测试

---

<br />**POST /api/v1/workspace/sensitive_mask_rule/test**

## 概述
空间 敏感数据脱敏规则测试




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| roleUUIDs | array | Y | 账号对应的 角色<br>允许为空: False <br>例子: ['general', 'role_43f57c813b034c4b806a1a647b4ee387'] <br> |
| namespace | string | Y | 脱敏类型<br>允许为空: False <br>允许为空字符串: False <br>例子: logging <br>可选值: ['logging', 'metric', 'object', 'custom_object', 'keyevent', 'tracing', 'rum', 'security', 'network', 'profiling', 'billing'] <br> |
| data | array | Y | 邮件头部<br>允许为空: False <br>例子: [{'host': 'hangzhou_127', 'message': 'xxxL, id: 234887209348'}, {'host': 'xihu', 'message': 'xxxL, id: 234234234'}] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/sensitive_mask_rule/test' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"namespace":"logging","roleUUIDs":["readOnly"],"data":[{"host":"jinlei","message":"sakldfu93w4urfjsndf / GET"},{"host":"hangzhou1234","message":"tokenUUID: 9083hsdf"}]}' \
--compressed
```




## 响应
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




