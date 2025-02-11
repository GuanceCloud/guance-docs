# Feature Menu Settings (Old)

---

<br />**POST /api/v1/workspace/menu/set**

## Overview
Set the current workspace feature menu



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| menu | array | Y | List of configured menu items<br>Can be empty: False <br> |
| menu[*] | json | Y | Menu item configuration<br>Can be empty: False <br> |
| menu[*].key | string | Y | Menu item key<br>Example: CloudDial <br>Can be empty: False <br>Optional values: ['Scene', 'Events', 'Incident', 'Objectadmin', 'Metrics', 'LogIndi', 'APM', 'RUM', 'Synthetic Tests', 'Security Check', 'GitLabCI', 'Monitor', 'Integration', 'Workspace', 'Billing'] <br> |
| menu[*].value | int | Y | Whether the menu item is enabled: 1 for enabled, 0 for disabled<br>Example: 1 <br>Can be empty: False <br>Optional values: [0, 1] <br> |

## Additional Parameter Notes


**Parameter Description**

| Parameter Name | Type    | Required | Description                     |
| :------ | :------- | :---- | :------------------------ |
| menu   | array[json]   | Y    | List of menu items               |
| key    | string  | Y    | Menu item key                |
| value  | int     | Y    | Enable status: 0 for disabled, 1 for enabled |


**Menu Item Descriptions**

| Key                | Description           |
| :------------------ | :-------------- |
| Scene              | Scene           |
| Events             | Events           |
| Incident           | Incident       |
| Objectadmin        | Infrastructure       |
| Metrics            | Metrics           |
| LogIndi            | Logs           |
| APM                | Application Performance Monitoring   |
| RUM                | User Access Monitoring   |
| Synthetic Tests          | Availability Monitoring     |
| Security Check         | Security Check       |
| GitLabCI           | CI Visualization      |
| Monitor            | Monitoring           |
| Integration        | Integration           |
| Workspace          | Management           |
| Billing            | Paid Plan and Billing |

Note:
<br/>
1. If not configured, the frontend treats it as a new menu and defaults to enabled.
<br/>
2. The menu configurations in the management backend affect the final display of workspace configurations.



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/menu/set' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \

--data-raw '{"menu":[{"key":"Scene","value":1},{"key":"Events","value":1},{"key":"Incident","value":1},{"key":"Objectadmin","value":1},{"key":"Metrics","value":1},{"key":"LogIndi","value":1},{"key":"APM","value":1},{"key":"RUM","value":1},{"key":"Synthetic Tests","value":1},{"key":"Security Check","value":1},{"key":"GitLabCI","value":1},{"key":"Monitor","value":1},{"key":"Integration","value":1},{"key":"Workspace","value":1},{"key":"Billing","value":1}]}' \


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
                "key": "Metrics",
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
                "key": "Synthetic Tests",
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