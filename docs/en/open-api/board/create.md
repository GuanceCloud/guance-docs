# Create a Dashboard

---

<br />**post /api/v1/dashboards/create**

## Overview
Create an empty dashboard, or create a dashboard according to `the dashboard template`
Rules:
  - Disable the creation of dashboards with the same name
  - The `name` field in the parameter overrides`title` in `templateInfo`




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 仪表板名称<br>Allow null: False <br>最大长度: 128 <br> |
| extend | json |  | 仪表板的额外数据, 默认为{}<br>例子: {} <br>Allow null: False <br> |
| mapping | array |  | 视图变量的字段映射信息，默认为 []<br>例子: [{'class': 'host_processes', 'field': 'create_time', 'mapping': 'username', 'datasource': 'object'}] <br>Allow null: False <br> |
| tagNames | array |  | 关联的 tag 列表<br>Allow null: False <br> |
| templateInfo | json |  | 仪表板模板数据<br>例子: {} <br>Allow null: False <br>允许空字符串: False <br> |

## Parameter Supplement

Parameter description:

The basic structure of template includes: view structure (including chart structure, view variable structure and chart grouping structure)

**Description of the Body Structure of `templateInfo`**

|  Parameter Name                |   Type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|
|title             |string | Must |  View Title Name |
|summary             |string |  |  Summary information for templates |
|dashboardType       |string |  |  Abandoned, default to `CUSTOM` |
|dashboardExtend     |json |  |  View additional data information |
|dashboardMapping    |array[json] |  |  Field mapping configuration list for view variables |
|iconSet             |json |   |  Dashboard icon information |
|iconSet.url             |json |   |  Link address of medium icon in dashboard |
|iconSet.icon             |json |   |  Link address of small icon in dashboard |
|icon             |string |   |  Dashboard small icon file name |
|thumbnail             |string |   |  Dashboard medium icon file name |
|main             |json |   |  Dashboard content structure |
|main.type    |string     |   | Template type, which is a system field and can be ignored|
|main.vars    |array[json]     |   | View variable configuration list |
|main.vars[#]    |json     |   | View variable configuration structure |
|main.groups    |array[string]     |   | List of chart group names |
|main.charts    |array[json]     |   | Chart configuration list for view |
|main.charts[#]    |json     |   | Chart configuration structure |



**Subject Structure Description of `dashboardMapping[#]`**

|  Parameter Name                |   Type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|


**Subject Structure Description of `main.charts[#]`**

|  Parameter Name                |   Type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|
|name             |string | Must |  Chart name |
|type             |string | Must |  Chart type |
|pos              |json |  |  Position structure of chart |
|pos.i              |string |  |   |
|pos.h              |string |  |  Height |
|pos.w              |string |  |  Width |
|pos.x              |string |  |  x-axis coordinates |
|pos.y              |string |  |  y-axis coordinates |
|group              |json[string] |  |  Packet information |
|group.name         |string |  |  Grouping name, no grouping is allowed to be null |
|queries          |array[json] | Must |  Chart query query statement structure list |


**`sequence diagram` structure `main.charts[#].type=sequence`; The main structure parameters are as follows: **

|  Parameter Name                |   Type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|
|name             |string | Must |  Chart name |
|type             |string | Must |  Chart type |
|pos             |string | Must |  Chart type |
|queries          |array[json] | Must |  Chart query query statement structure list |


**Subject Structure Description of `main.vars[#]`**

|  Parameter Name                |   Type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboards/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "x5T8APwi", "templateInfo": {"dashboardBindSet": [], "dashboardExtend": {}, "dashboardMapping": [], "dashboardOwnerType": "node", "dashboardType": "CUSTOM", "iconSet": {}, "main": {"charts": [{"extend": {"settings": {"chartType": "bar", "colors": [{"color": "#3ab8ff", "key": "count(trace_id){\"status\": \"ok\"}"}, {"color": "#f97575", "key": "count(trace_id){\"status\": \"error\"}"}], "openStack": true, "options": {"yAxis": {"axisLabel": {"color": "#666"}, "axisLine": {"show": true}, "axisTick": {"show": false}, "splitLine": {"show": false}, "splitNumber": 1}}, "xAxisShowType": "time"}}, "group": {"name": null}, "name": "请求数", "pos": null, "queries": [{"checked": true, "datasource": "dataflux", "qtype": "dql", "query": {"density": "lower", "filter": [{"logic": "and", "name": "service", "op": "=", "value": "front-api"}], "groupBy": " by `status`", "groupByTime": "auto", "q": "T::re(`.*`):(count(`trace_id`)){ `service` = 'front-api' } [::auto] by `status`"}, "unit": "", "uuid": "6aed3c00-7a99-11ec-8689-536665ee3a48"}], "type": "sequence"}], "groups": [], "type": "template", "vars": []}, "summary": "", "tagInfo": [], "tags": [], "thumbnail": "", "title": "lwc-链路资源"}}' \
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
                "chartUUID": "chrt_57e4b4a3f18c4d5ea705c893adeaaf49",
                "pos": {
                    "h": 9,
                    "i": 0,
                    "w": 8,
                    "x": 0,
                    "y": 0
                }
            },
            {
                "chartUUID": "chrt_bc6448e0e8bd4931abc24dfeb4ebde44",
                "pos": {
                    "h": 9,
                    "i": 1,
                    "w": 8,
                    "x": 0,
                    "y": 9
                }
            },
            {
                "chartUUID": "chrt_b32f5173a6f6490dad2a94bb396dfc09",
                "pos": {
                    "h": 9,
                    "i": 2,
                    "w": 8,
                    "x": 8,
                    "y": 0
                }
            },
            {
                "chartUUID": "chrt_87c97cfc44374f398fe57ec6c440835b",
                "pos": {
                    "h": 9,
                    "i": 3,
                    "w": 8,
                    "x": 16,
                    "y": 0
                }
            },
            {
                "chartUUID": "chrt_e03caef30cd8475e88f9453fff165381",
                "pos": {
                    "h": 9,
                    "i": 4,
                    "w": 8,
                    "x": 8,
                    "y": 9
                }
            },
            {
                "chartUUID": "chrt_280a547f6f6b4ec3832bb7c3e769249b",
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
        "creator": "acnt_a5d6130c19524a6b9fe91d421eaf8603",
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {},
        "iconSet": {
            "icon": "http://testing-static-res.cloudcare.cn/dataflux-template/dashboard/cpu/icon.svg",
            "url": "http://testing-static-res.cloudcare.cn/dataflux-template/dashboard/cpu/cpu.png"
        },
        "id": null,
        "mapping": [],
        "name": "CPU 监控视图-lwctest",
        "ownerType": "node",
        "status": 0,
        "tag_info": [
            {
                "id": "tag_e48c1d03a3d044808ab0e074086c0c72",
                "name": "测试"
            }
        ],
        "type": "CUSTOM",
        "updateAt": 1641953280.0015464,
        "updator": "acnt_a5d6130c19524a6b9fe91d421eaf8603",
        "uuid": "dsbd_9285271961be40069ddfa27af07a3538",
        "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-97C1194E-40E6-43A3-B6DF-6637D96BECDB"
} 
```




