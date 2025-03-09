# Feature Menu Settings (old)

---

<br />**POST /api/v1/workspace/menu/set**

## Overview
Set the feature menu for the current workspace


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| menu | array | Y | List of configured menu items<br>Can be empty: False <br> |
| menu[*] | json | Y | Menu item<br>Can be empty: False <br> |
| menu[*].key | string | Y | Menu item<br>Example: CloudDial <br>Can be empty: False <br>Possible values: ['Scene', 'Events', 'Incident', 'Objectadmin', 'MetricQuery', 'LogIndi', 'APM', 'RUM', 'CloudDial', 'Security Check', 'GitLabCI', 'Monitor', 'Integration', 'Workspace', 'Billing'] <br> |
| menu[*].value | int | Y | Whether the menu item is enabled: 1 Enabled, 0 Disabled<br>Example: 1 <br>Can be empty: False <br>Possible values: [0, 1] <br> |

## Additional Parameter Explanation


**Parameter Description**

| Parameter Name | Type    | Required | Description                     |
| :------ | :------- | :---- | :------------------------ |
| menu   | array[json]   | Y    | List of menu items               |
| key    | string  | Y    | Menu item                |
| value  | int     | Y    | Whether enabled: 0 Disabled, 1 Enabled |


**Menu Item Description**

| Key                | Description           |
| :------------------ | :-------------- |
| Scene              | Scenarios           |
| Events             | Events           |
| Incident           | Incident Tracking       |
| Objectadmin        | Infrastructure       |
| MetricQuery        | Metrics           |
| LogIndi            | Logs           |
| APM                | APM         |
| RUM                | RUM         |
| CloudDial          | Synthetic Tests     |
| Security Check     | Security Check       |
| GitLabCI           | CI Visualization      |
| Monitor            | Monitoring           |
| Integration        | Integration           |
| Workspace          | Management           |
| Billing            | Paid Plans and Billing |

Note:
<br/>
1. If not configured, the frontend treats it as a new menu item and defaults to enabled.
<br/>
2. The menu configuration in the admin backend affects the final display of the workspace configuration.


## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/menu/set' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \

--data-raw '{"menu":[{"key":"Scene","value":1},{"key":"Events","value":1},{"key":"Incident","value":1},{"key":"Objectadmin","value":1},{"key":"MetricQuery","value":1},{"key":"LogIndi","value":1},{"key":"APM","value":1},{"key":"RUM","value":1},{"key":"CloudDial","value":1},{"key":"Security Check","value":1},{"key":"GitLabCI","value":1},{"key":"Monitor","value":1},{"key":"Integration","value":1},{"key":"Workspace","value":1},{"key":"Billing","value":1}]}' \


```


## Response
```shell
{
    "code": 200,
    "content": {
        "config": [
            {
                "key": "Scene",
                "value": 1
            },
            {
                "key": "Events",
                "value": 1
            },
            {
                "key": "Incident",
                "value": 1
            },
            {
                "key": "Objectadmin",
                "value": 1
            },
            {
                "key": "MetricQuery",
                "value": 1
            },
            {
                "key": "LogIndi",
                "value": 1
            },
            {
                "key": "APM",
                "value": 1
            },
            {
                "key": "RUM",
                "value": 1
            },
            {
                "key": "CloudDial",
                "value": 1
            },
            {
                "key": "Security Check",
                "value": 1
            },
            {
                "key": "GitLabCI",
                "value": 1
            },
            {
                "key": "Monitor",
                "value": 1
            },
            {
                "key": "Integration",
                "value": 1
            },
            {
                "key": "Workspace",
                "value": 1
            },
            {
                "key": "Billing",
                "value": 1
            }
        ],
        "createAt": 1697627382,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "id": 763,
        "keyCode": "WsMenuCfg",
        "status": 0,
        "updateAt": 1697627382,
        "updator": "acnt_xxxx32",
        "uuid": "ctcf_xxxx32",
        "workspaceUUID": "wksp_xxxx20"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "475074598825122309"
} 
```