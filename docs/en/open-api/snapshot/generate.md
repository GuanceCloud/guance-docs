# Create an Intelligent Inspection

---

<br />**post /api/v1/snapshots/create**

## Overview
Create a snapshot configuration.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | Snapshot name<br>Allow null: False <br> |
| type | string | Y | Types of snapshots<br>Allow null: False <br> |
| content | json | Y | User configuration data<br>Allow null: False <br> |

## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/snapshots/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "xxx15", "type": "logging", "content": {"routeParams": {"source": "all"}, "routeName": "Log", "routeQuery": {"time": "1642585478000,1642586378999"}}}' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "accountUUID": "wsak_9c2d4d998d9548949ce05680552254af",
        "content": {
            "routeName": "Log",
            "routeParams": {
                "source": "all"
            },
            "routeQuery": {
                "time": "1642576399000,1642577299999"
            }
        },
        "createAt": 1642577335.899078,
        "creator": "wsak_9c2d4d998d9548949ce05680552254af",
        "deleteAt": -1,
        "id": null,
        "name": "opentest-han1",
        "status": 0,
        "type": "logging",
        "updateAt": 1642577335.899272,
        "updator": "wsak_9c2d4d998d9548949ce05680552254af",
        "uuid": "snap_0c6f2b870629429db12fa920310605f8",
        "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-E2CA5DEE-E525-4CD4-B0F2-7F5B7492C3E4"
} 
```




