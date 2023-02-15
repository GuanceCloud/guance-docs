# Modify an Alarm Policy

---

<br />**post /api/v1/monitor/group/\{monitor_uuid\}/modify**

## Overview
Modify the specified alarm policy configuration information according to `monitor_uuid`.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| monitor_uuid | string | Y | Alarm policy UUID<br> |


## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | Monitor name<br>Allow null: False <br> |
| alertOpt | json |  | Alarm setting<br>Allow null: False <br> |
| alertOpt.silentTimeout | integer |  | Alarm setting<br>Allow null: False <br> |
| alertOpt.alertTarget | array |  | Triggering action<br>Allow null: False <br> |

## Supplementary Description of Parameters







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
        "name": "修改后的名称",
        "status": 0,
        "type": "aliyun_rds_mysql",
        "updateAt": 1642593872.2646232,
        "updator": "wsak_0f70ae95544143549f6ac2cb56ee0037",
        "uuid": "monitor_84cbb7c18f964771b8153fbca1013615",
        "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-DAEC1D96-1053-4CBC-8997-398635FE1884"
} 
```




