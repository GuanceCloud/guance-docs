# 获取单个数据访问规则

---

<br />**GET /api/v1/logging_query_rule/\{logging_query_rule_uuid\}/get**

## 概述
获取单个数据访问规则




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| logging_query_rule_uuid | string | Y | 数据访问规则uuid<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/logging_query_rule/lqrl_xxxx32/get' \
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
        "creator": "acnt_xxxx32",
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
        "updator": "acnt_xxxx32",
        "uuid": "lqrl_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-22837C00-0EC4-4B08-9ECB-F131459A8E24"
} 
```




