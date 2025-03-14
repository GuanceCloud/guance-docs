# Get an Alarm Policy

---

<br />**get /api/v1/monitor/group/\{monitor_uuid\}/get**

## Overview
Get an alarm policy.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| monitor_uuid | string | Y | Alarm policy UUID<br> |


## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/monitor/group/monitor_70a7e8549ea54bbeaeb9e4eaec52bad2/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "alertOpt": {
            "alertTarget": [],
            "silentTimeout": 0
        },
        "config": {},
        "createAt": 1641870634,
        "creator": "acnt_63c77346766c11ebb7caf2b2c21faf74",
        "deleteAt": -1,
        "id": 769,
        "name": "阿里云 RDS Mysql 检测库",
        "status": 0,
        "type": "aliyun_rds_mysql",
        "updateAt": 1642476869,
        "updator": "acnt_c94179b4766811ebb1435a810562cdd6",
        "uuid": "monitor_84cbb7c18f964771b8153fbca1013615",
        "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-B1EBC133-BED9-47B8-AE53-2282C55A0253"
} 
```




