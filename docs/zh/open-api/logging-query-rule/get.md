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
        "conditions": "`container_id` IN ['xxxx']",
        "createAt": 1724400669,
        "creator": "wsak_xxx",
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "dd": "dd",
            "fawf": "afawf",
            "organization": "xxx"
        },
        "deleteAt": -1,
        "desc": "",
        "extend": {
            "container_id": [
                "xxxx"
            ]
        },
        "id": 254,
        "indexWsInfo": {
            "default": {
                "indexInfo": {
                    "name": "default",
                    "status": 0
                },
                "wsInfo": {
                    "name": "【Doris】开发测试一起用_",
                    "status": 0
                }
            }
        },
        "indexes": [
            "default"
        ],
        "logic": "and",
        "maskFields": "",
        "name": "test_modify_name",
        "reExprs": [],
        "relRoleInfos": [
            {}
        ],
        "roleUUIDs": [
            "role_xxxx"
        ],
        "status": 0,
        "updateAt": 1724400877,
        "updator": "wsak_xxxx",
        "uuid": "lqrl_xxx",
        "workspaceUUID": "wksp_xxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-3D4B9E8E-CCB6-486F-81E8-16B3FE2E7519"
} 
```




