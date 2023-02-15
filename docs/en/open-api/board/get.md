# et a Dashboard

---

<br />**get /api/v1/dashboards/\{dashboard_uuid\}/get**

## Overview
Get the specified dashboard information from `dashboard_uuid`.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | View UUID<br> |


## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboards/dsbd_501b8277ba88479b82020dbfc92e110c/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [
            {
                "chartUUID": "chrt_1cbdbf10c1494c80b36b91b4e0e1ab90",
                "pos": {
                    "h": 11,
                    "i": "chrt_2e650ef84b1a4eb389011fd95f7db11e",
                    "w": 11,
                    "x": 0,
                    "y": 0
                }
            }
        ],
        "createAt": 1642587228,
        "createdWay": "import",
        "creator": "acnt_5fc5bb139e474911b6d3d300863f0c8b",
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {},
        "iconSet": {},
        "id": 2494,
        "mapping": [],
        "name": "testt",
        "ownerType": "node",
        "status": 0,
        "tag_info": {
            "dsbd_541083cc19ec4d27ad597839a0477a97": [
                {
                    "id": "tag_07a3a85d01474c1585add18bfb1b5cde",
                    "name": "openapi"
                },
                {
                    "id": "tag_977d40b3f40c4d3f8e90956698b57c48",
                    "name": "test"
                }
            ]
        },
        "type": "CUSTOM",
        "updateAt": 1642587908,
        "updator": "wsak_c1c8af0c545541428403c09481f1baf8",
        "uuid": "dsbd_541083cc19ec4d27ad597839a0477a97",
        "workspaceUUID": "wksp_c4201f4ef30c4a86b01a998e7544f822"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-B4C47390-FA67-4FD8-851C-342C3C97F957"
} 
```




