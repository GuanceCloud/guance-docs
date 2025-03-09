# Create a Dashboard

---

<br />**POST /api/v1/dashboards/create**

## Overview
Create an empty dashboard, or create a dashboard based on a `dashboard template`.

Rules:
  - The `name` field in the parameters will override the `title` in `templateInfo`



## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:------------------------|
| name                 | string   | Y        | Dashboard name<br>Allow null: False <br>Maximum length: 128 <br> |
| desc                 | string   |          | Description<br>Example: Description 1 <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 2048 <br> |
| identifier           | string   |          | Identifier ID -- New identifier ID added on 2024.12.25<br>Example: xxxx <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 128 <br> |
| extend               | json     |          | Additional data for the dashboard, defaults to {}<br>Example: {} <br>Allow null: False <br> |
| mapping              | array    |          | Field mapping information for view variables, defaults to []<br>Example: [{'class': 'host_processes', 'field': 'create_time', 'mapping': 'username', 'datasource': 'object'}] <br>Allow null: False <br> |
| tagNames             | array    |          | List of associated tags<br>Allow null: False <br> |
| templateInfo         | json     |          | Dashboard template data<br>Example: {} <br>Allow null: False <br>Allow empty string: False <br> |
| specifyDashboardUUID | string   |          | Specify the UUID for the newly created dashboard, must start with `dsbd_custom_` followed by 32 lowercase letters or numbers<br>Example: dsbd_custom_xxxx32 <br>Allow null: False <br>Allow empty string: False <br>$matchRegExp: ^dsbd_custom_[a-z0-9]{32}$ <br> |
| isPublic             | int      |          | Whether it is publicly displayed, 1 for public, 0 for private, -1 indicates custom settings<br>Example: 1 <br>Allow null: False <br> |
| openPermissionSet    | boolean  |          | Deprecated as of 2024-11-27. No longer effective. Use `isPublic` set to -1 to indicate custom permission configuration.<br>Allow null: False <br> |
| permissionSet        | array    |          | Operation permission configuration when `isPublic` is set to -1, can configure (roles except owner, member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Allow null: False <br> |
| readPermissionSet    | array    |          | Read permission configuration when `isPublic` is set to -1, can configure (roles except owner, member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Allow null: False <br> |

## Parameter Supplemental Explanation

Parameter description:

The basic structure of the template includes: view structure (including chart structure, view variable structure, chart grouping structure)

**Main structure explanation of `templateInfo`**

| Parameter Name                | Type   | Required | Description          |
|------------------------------|--------|----------|----------------------|
| title                        | string | Required | View title name      |
| summary                      | string |          | Template summary information |
| identifier                   | string |          | Template identifier ID -- New identifier ID added on 2024.12.25 |
| dashboardType                | string |          | Deprecated, defaults to `CUSTOM` |
| dashboardExtend              | json   |          | Additional data information for the view |
| dashboardMapping             | array[json] |          | Field mapping configuration list for view variables |
| iconSet                      | json   |          | Icon information for the dashboard |
| iconSet.url                  | json   |          | Medium icon URL for the dashboard |
| iconSet.icon                 | json   |          | Small icon URL for the dashboard |
| icon                         | string |          | Small icon filename for the dashboard |
| thumbnail                    | string |          | Medium icon filename for the dashboard |
| main                         | json   |          | Content structure of the dashboard |
| main.type                    | string |          | Template type, this field is a system field and can be ignored |
| main.vars                    | array[json] |          | View variable configuration list |
| main.vars[#]                 | json   |          | View variable configuration structure |
| main.groups                  | array[string] |          | List of chart group names |
| main.charts                  | array[json] |          | Chart configuration list for the view |
| main.charts[#]               | json   |          | Chart configuration structure |


**Main structure explanation of `dashboardMapping[#]`**

| Parameter Name                | Type   | Required | Description          |
|------------------------------|--------|----------|----------------------|


**Main structure explanation of `main.charts[#]`**

| Parameter Name                | Type   | Required | Description          |
|------------------------------|--------|----------|----------------------|
| name                         | string | Required | Chart name           |
| type                         | string | Required | Chart type           |
| pos                          | json   |          | Chart position structure |
| pos.i                        | string |          |                      |
| pos.h                        | string |          | Height               |
| pos.w                        | string |          | Width                |
| pos.x                        | string |          | X-axis coordinate    |
| pos.y                        | string |          | Y-axis coordinate    |
| group                        | json[string] |          | Group information   |
| group.name                   | string |          | Group name, can be null if no group |
| queries                      | array[json] | Required | List of chart query statement structures |


**Structure of `Time Series Chart` when `main.charts[#].type=sequence`:**

| Parameter Name                | Type   | Required | Description          |
|------------------------------|--------|----------|----------------------|
| name                         | string | Required | Chart name           |
| type                         | string | Required | Chart type           |
| pos                          | string | Required | Chart type           |
| queries                      | array[json] | Required | List of chart query statement structures |


**Main structure explanation of `main.vars[#]`**

| Parameter Name                | Type   | Required | Description          |
|------------------------------|--------|----------|----------------------|




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboards/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "x5T8APwi", "templateInfo": {"dashboardBindSet": [], "dashboardExtend": {}, "dashboardMapping": [], "dashboardOwnerType": "node", "dashboardType": "CUSTOM", "iconSet": {}, "main": {"charts": [{"extend": {"settings": {"chartType": "bar", "colors": [{"color": "#3ab8ff", "key": "count(trace_id){\"status\": \"ok\"}"}, {"color": "#f97575", "key": "count(trace_id){\"status\": \"error\"}"}], "openStack": true, "options": {"yAxis": {"axisLabel": {"color": "#666"}, "axisLine": {"show": true}, "axisTick": {"show": false}, "splitLine": {"show": false}, "splitNumber": 1}}, "xAxisShowType": "time"}}, "group": {"name": null}, "name": "Request Count", "pos": null, "queries": [{"checked": true, "datasource": "dataflux", "qtype": "dql", "query": {"density": "lower", "filter": [{"logic": "and", "name": "service", "op": "=", "value": "front-api"}], "groupBy": " by `status`", "groupByTime": "auto", "q": "T::re(`.*`):(count(`trace_id`)){ `service` = 'front-api' } [::auto] by `status`"}, "unit": "", "uuid": "6aed3c00-7a99-11ec-8689-536665ee3a48"}], "type": "sequence"}], "groups": [], "type": "template", "vars": []}, "summary": "", "tagInfo": [], "tags": [], "thumbnail": "", "title": "lwc-link resources"}}' \
--compressed 
```




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
                    "h": 9,
                    "i": 0,
                    "w": 8,
                    "x": 0,
                    "y": 0
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 9,
                    "i": 1,
                    "w": 8,
                    "x": 0,
                    "y": 9
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 9,
                    "i": 2,
                    "w": 8,
                    "x": 8,
                    "y": 0
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 9,
                    "i": 3,
                    "w": 8,
                    "x": 16,
                    "y": 0
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 9,
                    "i": 4,
                    "w": 8,
                    "x": 8,
                    "y": 9
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 9,
                    "i": 5,
                    "w": 8,
                    "x": 16,
                    "y": 9
                }
            }
        ],
        "createAt": 1641953280.0015242,
        "createdWay": "manual",
        "creator": "acnt_xxxx32",
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {},
        "iconSet": {
            "icon": "http://testing-static-res.cloudcare.cn/dataflux-template/dashboard/cpu/icon.svg",
            "url": "http://testing-static-res.cloudcare.cn/dataflux-template/dashboard/cpu/cpu.png"
        },
        "id": null,
        "mapping": [],
        "name": "CPU Monitoring View-lwctest",
        "ownerType": "node",
        "status": 0,
        "tag_info": [
            {
                "id": "tag_xxxx32",
                "name": "Testing"
            }
        ],
        "type": "CUSTOM",
        "updateAt": 1641953280.0015464,
        "updator": "acnt_xxxx32",
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-97C1194E-40E6-43A3-B6DF-6637D96BECDB"
} 
```