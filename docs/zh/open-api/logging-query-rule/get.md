# 获取单个数据访问规则

---

<br />**GET /api/v1/logging_query_rule/\{logging_query_rule_uuid\}/get**

## 概述
获取单个数据访问规则




## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/logging_query_rule/lqrl_3ca770bfc3354becb13d9f667b071cd2/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "`host` = wildcard('cvsdbvjk')",
        "createAt": 1695293435,
        "creator": "acnt_c05ef27fe2dd483ca04131a19df7370f",
        "deleteAt": -1,
        "extend": {
            "*host": [
                "cvsdbvjk"
            ]
        },
        "id": 127,
        "indexes": [
            "default"
        ],
        "logic": "and",
        "roleUUIDs": [
            "general"
        ],
        "status": 0,
        "updateAt": 1695293435,
        "updator": "acnt_c05ef27fe2dd483ca04131a19df7370f",
        "uuid": "lqrl_3ca770bfc3354becb13d9f667b071cd2",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-22837C00-0EC4-4B08-9ECB-F131459A8E24"
} 
```




