# Get Role

---

<br />**GET /api/v1/role/\{role_uuid\}/get**

## Overview
Retrieve a role



## Route Parameters

| Parameter Name | Type   | Required | Description          |
|:--------------|:-------|:---------|:---------------------|
| role_uuid     | string | Y        | Role UUID            |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/role/role_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1677140944,
        "creator": "acnt_xxxx32",
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
        "name": "Billing Plan and Invoice",
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
        "updator": "acnt_xxxx32",
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "lwc@qq.com",
            "iconUrl": "",
            "name": "lwc@qq.com",
            "username": "lwc@qq.com"
        },
        "uuid": "role_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-BC3B2F08-DEC1-4EDA-9958-4391F976A981"
} 
```

### Notes on Translated Terms:
- **付费计划与账单** has been translated to **Billing Plan and Invoice** based on the context provided. If this term needs to be adjusted, please provide additional context or specific terminology preferences.