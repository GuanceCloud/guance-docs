# Modify a Dashboard

---

<br />**POST /api/v1/dashboards/\{dashboard_uuid\}/modify**

## Overview
Modify the property information of a dashboard.


## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | View UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string |  | View name<br>Example: Test View 1 <br>Can be empty: False <br> |
| desc | string |  | Description<br>Example: Description 1 <br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 2048 <br> |
| identifier | string |  | Identifier ID -- Added on December 25, 2024<br>Example: xxxx <br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 128 <br> |
| extend | json |  | Additional view information<br>Example: {} <br>Can be empty: False <br> |
| mapping | array |  | Mapping, defaults to []<br>Example: [] <br>Can be empty: False <br> |
| tagNames | array |  | Tag names, note that this field is fully updated<br>Can be empty: False <br> |
| isPublic | int |  | Whether it is publicly displayed, 1 for public, 0 for private, -1 for custom<br>Example: 1 <br>Can be empty: False <br> |
| permissionSet | array |  | Custom operation permissions configuration when isPublic is -1, can configure (roles (except owner), member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Can be empty: False <br> |
| readPermissionSet | array |  | Custom read permissions configuration when isPublic is -1, can configure (roles (except owner), member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Can be empty: False <br> |

## Additional Parameter Notes



## Response
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 11,
                    "i": "chrt_xxxx32",
                    "w": 11,
                    "x": 0,
                    "y": 0
                }
            }
        ],
        "createAt": 1642587228,
        "createdWay": "import",
        "creator": "acnt_xxxx32",
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
        "updator": "wsak_xxxxx",
        "updatorInfo": {
            "iconUrl": "",
            "name": "First Key",
            "username": "AK(wsak_xxxxx)"
        },
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-5F0F4D27-0A77-41B3-9E05-227648467853"
} 
```