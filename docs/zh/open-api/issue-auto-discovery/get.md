# 获取自动发现配置

---

<br />**GET /api/v1/issue_auto_discovery/\{cfg_uuid\}/get**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | Issue 自动发现配置UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue_auto_discovery/iatdc_xxxxx/get' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "`source` = \"lwctest\"",
        "config": {
            "channelUUIDs": [
                "chan_xxxxx"
            ],
            "description": "这是issue定义中的描述信息修改后",
            "extend": {
                "manager": [
                    "acnt_xxxx"
                ],
                "text": "这是issue定义中的描述信息修改后"
            },
            "level": "system_level_0",
            "name": "这是issue定义中的标题"
        },
        "createAt": 1735893393,
        "creator": "wsak_xxxx",
        "declaration": {
            "organization": "xxx"
        },
        "deleteAt": -1,
        "description": "这是一个新建issue自动发现规则测试例子",
        "dimensions": [
            "name"
        ],
        "dqlNamespace": "keyevent",
        "every": 300,
        "id": 47,
        "name": "test-core-worker",
        "status": 0,
        "updateAt": 1735893669.0875816,
        "updator": "wsak_xxxx",
        "uuid": "iatdc_xxxx",
        "workspaceUUID": "wksp_xxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "1634728700182310814"
} 
```




