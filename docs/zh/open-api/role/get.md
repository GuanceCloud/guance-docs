# 获取角色

---

<br />**GET /api/v1/role/\{role_uuid\}/get**

## 概述
获取角色




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| role_uuid | string | Y | 角色UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/role/role_3552e414acc0415fa584c2caf0acf3fc/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1677140944,
        "creator": "acnt_e52a5a7b6418464cb2acbeaa199e7fd1",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "lwc@qq.com",
            "iconUrl": "",
            "name": "lwc@qq.com",
            "username": "lwc@qq.com"
        },
        "deleteAt": -1,
        "desc": "",
        "id": 92,
        "isSystem": 0,
        "name": "付费计划与账单",
        "permissions": [
            "billing.billingRead",
            "routine.defaultAccess",
            "metric.Query",
            "log.Query",
            "infrastructure.Query",
            "event.Query",
            "trace.Query",
            "rum.Query",
            "security.Query",
            "anomaly.issueManage",
            "anomaly.issueReplyRead",
            "anomaly.issueRead",
            "anomaly.issueReplyManage",
            "snapshot.create",
            "snapshot.delete",
            "dataScanner.cfgManage",
            "scene.serviceManage",
            "label.labelCfgManage",
            "anomaly.issueLevelManage"
        ],
        "status": 0,
        "updateAt": 1677140944,
        "updator": "acnt_e52a5a7b6418464cb2acbeaa199e7fd1",
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "lwc@qq.com",
            "iconUrl": "",
            "name": "lwc@qq.com",
            "username": "lwc@qq.com"
        },
        "uuid": "role_3552e414acc0415fa584c2caf0acf3fc",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-BC3B2F08-DEC1-4EDA-9958-4391F976A981"
} 
```



