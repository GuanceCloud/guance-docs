# 获取一个告警策略

---

<br />**GET /api/v1/alert_policy/\{alert_policy_uuid\}/get**

## 概述
获取一个告警策略




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| alert_policy_uuid | string | Y | 告警策略UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/alert_policy/altpl_a293c3584b8143778d4fed7a54315c11/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "alertOpt": {
            "aggFields": [
                "df_monitor_checker_id"
            ],
            "aggInterval": 120,
            "alertTarget": [
                {
                    "targets": [
                        {
                            "status": "warning",
                            "to": [
                                "notify_9fddc9eb5eb24b8cb1323a8417e0299e"
                            ]
                        }
                    ]
                }
            ],
            "silentTimeout": 21600
        },
        "createAt": 1706152082,
        "creator": "wsak_0897f0d91a0b4d9a9532a0c28fe33c41",
        "declaration": {},
        "deleteAt": -1,
        "id": 4100,
        "name": "jj_modify",
        "notifyObjectName": {
            "notify_9fddc9eb5eb24b8cb1323a8417e0299e": "金磊测试无密钥"
        },
        "ruleTimezone": "Asia/shanghai",
        "score": 0,
        "status": 0,
        "updateAt": 1706152340,
        "updator": "wsak_0897f0d91a0b4d9a9532a0c28fe33c41",
        "uuid": "altpl_a293c3584b8143778d4fed7a54315c11",
        "workspaceUUID": "wksp_be64f5691e7a46c38f92ac5c05035a4b"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-F50BB1EB-5CF5-4B07-A633-4EF2E7EA4FD8"
} 
```




