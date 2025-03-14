# Get Current Workspace Info

---

<br />**get /api/v1/workspace/get**

## Overview
Get the workspace information to which the current caller belongs.




## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "billingState": "normal",
        "cliToken": "wkcli_2dc439f6693711eb8ff97aeee04b54af",
        "createAt": 1612697128,
        "creator": "mact-U2kcQuQum4Cs7YdLAe49B9Hg",
        "dashboardUUID": null,
        "dbUUID": "ifdb_c0fss9qc8kg4gj9bjjag",
        "deleteAt": -1,
        "desc": "m修改修改hhhhh",
        "durationSet": {
            "backup_log": "180d",
            "keyevent": "14d",
            "logging": "14d",
            "network": "2d",
            "rp": "30d",
            "rum": "7d",
            "security": "90d",
            "tracing": "7d"
        },
        "enablePublicDataway": 1,
        "esInstanceUUID": "es_1f32b130567411ec9cfbacde48001122",
        "extend": {},
        "exterId": "team-y25aVfh4neXCspQrcfqEaM",
        "id": 2,
        "isOpenWarehouse": 0,
        "memberCount": 75,
        "name": "开发测试一起用",
        "rpName": "rp4",
        "status": 0,
        "token": "tkn_2dc438b6693711eb8ff97aeee04b54af",
        "updateAt": 1642562104,
        "updator": "acnt_6f2fd4c0766d11ebb56ef2b2c21faf74",
        "uuid": "wksp_2dc431d6693711eb8ff97aeee04b54af",
        "versionType": "pay"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-C8664FD5-8EFB-4CB3-895F-B019D2A212E3"
} 
```




