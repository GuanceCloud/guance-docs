# 获取某个 SLO 详情

---

<br />**GET /api/v1/slo/\{slo_uuid\}/get**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| slo_uuid | string | Y | SLO 的 UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/slo/monitor_5ebbxxxx/get' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "alertPolicyInfos": [
            {
                "name": "lwc SLO 转告警策略测试",
                "uuid": "altpl_xxx"
            }
        ],
        "config": {
            "checkRange": 604800,
            "describe": "LWC测试OpenAPI",
            "goal": 90.0,
            "interval": "10m",
            "minGoal": 60.0,
            "sli_infos": [
                {
                    "id": "rul_xxxx",
                    "name": "whytest-反馈问题验证",
                    "status": 2
                },
                {
                    "id": "rul_xxxxx",
                    "name": "lml-tes",
                    "status": 0
                }
            ]
        },
        "createAt": 1722913524,
        "creator": "wsak_xxxxx",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "wsak_xxxxx",
            "iconUrl": "",
            "name": "LWC测试",
            "status": 0,
            "username": "wsak_xxxxx",
            "uuid": "wsak_xxxxx"
        },
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "id": 4901,
        "name": "LWC-Test-2024-08-06-002",
        "score": 0,
        "status": 0,
        "tagInfo": [],
        "type": "slo",
        "updateAt": -1,
        "updator": "",
        "updatorInfo": {},
        "uuid": "monitor_xxxxxxxx4",
        "workspaceUUID": "wksp_xxxxxxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "2309539005843156069"
} 
```




