# Modify a Dashboard

---

<br />**post /api/v1/dashboards/\{dashboard_uuid\}/modify**

## Overview
Modify the property information of the dashboard.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | View UUID<br> |


## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | View name<br>Example: test view 1 <br>Allow null: False <br> |
| extend | json |  | View additional information<br>Example: {} <br>Allow null: False <br> |
| mapping | array |  | mapping, default to[]<br>Example: [] <br>Allow null: False <br> |
| tagNames | array |  | The name of the tag, note that this field is updated in full<br>Allow null: False <br> |

## Supplementary Description of Parameters







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
        "dashboardBidding": {},
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {},
        "iconSet": {},
        "id": 2494,
        "mapping": [],
        "name": "testt",
        "old_name": "openapi",
        "ownerType": "node",
        "status": 0,
        "tag_info": {
            "sceneInfo": [],
            "tagInfo": []
        },
        "type": "CUSTOM",
        "updateAt": 1642587908.306098,
        "updator": "wsak_c1c8af0c545541428403c09481f1baf8",
        "updatorInfo": {
            "iconUrl": "",
            "name": "第一个key",
            "username": "AK(wsak_c1c8af0c545541428403c09481f1baf8)"
        },
        "uuid": "dsbd_541083cc19ec4d27ad597839a0477a97",
        "workspaceUUID": "wksp_c4201f4ef30c4a86b01a998e7544f822"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-5F0F4D27-0A77-41B3-9E05-227648467853"
} 
```




