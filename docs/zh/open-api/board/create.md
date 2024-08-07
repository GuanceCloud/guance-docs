# 创建一个仪表板

---

<br />**POST /api/v1/dashboards/create**

## 概述
创建一个空仪表板，或者是根据`仪表板模板`创建一个仪表板
规则:
  - 参数中的`name`字段将覆盖`templateInfo`中的`title`




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 仪表板名称<br>允许为空: False <br>最大长度: 128 <br> |
| desc | string |  | 描述<br>例子: 描述1 <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 2048 <br> |
| extend | json |  | 仪表板的额外数据, 默认为{}<br>例子: {} <br>允许为空: False <br> |
| mapping | array |  | 视图变量的字段映射信息，默认为 []<br>例子: [{'class': 'host_processes', 'field': 'create_time', 'mapping': 'username', 'datasource': 'object'}] <br>允许为空: False <br> |
| tagNames | array |  | 关联的 tag 列表<br>允许为空: False <br> |
| templateInfo | json |  | 仪表板模板数据<br>例子: {} <br>允许为空: False <br>允许为空字符串: False <br> |
| specifyDashboardUUID | string |  | 指定新建仪表板的uuid, 必须以`dsbd_custom_`为前缀后接 32 位长度的小写字母数字<br>例子: dsbd_custom_a70974b902424baea1ddeead2db87278 <br>允许为空: False <br>允许为空字符串: False <br>$matchRegExp: ^dsbd_custom_[a-z0-9]{32}$ <br> |

## 参数补充说明

参数说明:

模板的基础结构组成包含: 视图结构(含图表结构, 视图变量结构，图表分组结构)

**`templateInfo`的主体结构说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|title             |string | 必须 |  视图标题名称 |
|summary             |string |  |  模板的摘要信息 |
|dashboardType       |string |  |  已废弃，默认为`CUSTOM` |
|dashboardExtend     |json |  |  视图额外数据信息 |
|dashboardMapping    |array[json] |  |  视图变量的字段映射配置列表 |
|iconSet             |json |   |  仪表版图标信息 |
|iconSet.url             |json |   |  仪表版中等图标链接地址 |
|iconSet.icon             |json |   |  仪表版小图标链接地址 |
|icon             |string |   |  仪表版小图标文件名 |
|thumbnail             |string |   |  仪表版中等图标文件名 |
|main             |json |   |  仪表板内容结构 |
|main.type    |string     |   | 模板类型, 该字段为系统字段，可忽略|
|main.vars    |array[json]     |   | 视图变量配置列表 |
|main.vars[#]    |json     |   | 视图变量配置结构 |
|main.groups    |array[string]     |   | 图表分组名列表 |
|main.charts    |array[json]     |   | 视图的图表配置列表 |
|main.charts[#]    |json     |   | 图表配置结构 |



**`dashboardMapping[#]`的主体结构说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|


**`main.charts[#]`的主体结构说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|name             |string | 必须 |  图表名字 |
|type             |string | 必须 |  图表类型 |
|pos              |json |  |  图表的位置结构 |
|pos.i              |string |  |   |
|pos.h              |string |  |  高度 |
|pos.w              |string |  |  宽度 |
|pos.x              |string |  |  x轴坐标 |
|pos.y              |string |  |  y轴坐标 |
|group              |json[string] |  |  分组信息 |
|group.name         |string |  |  分组名, 没有分组是允许为 null |
|queries          |array[json] | 必须 |  图表查询查询语句结构列表 |


**`时序图表` 结构 `main.charts[#].type=sequence` 其主体结构参数如下: **

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|name             |string | 必须 |  图表名字 |
|type             |string | 必须 |  图表类型 |
|pos             |string | 必须 |  图表类型 |
|queries          |array[json] | 必须 |  图表查询查询语句结构列表 |


**`main.vars[#]`的主体结构说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dashboards/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "x5T8APwi", "templateInfo": {"dashboardBindSet": [], "dashboardExtend": {}, "dashboardMapping": [], "dashboardOwnerType": "node", "dashboardType": "CUSTOM", "iconSet": {}, "main": {"charts": [{"extend": {"settings": {"chartType": "bar", "colors": [{"color": "#3ab8ff", "key": "count(trace_id){\"status\": \"ok\"}"}, {"color": "#f97575", "key": "count(trace_id){\"status\": \"error\"}"}], "openStack": true, "options": {"yAxis": {"axisLabel": {"color": "#666"}, "axisLine": {"show": true}, "axisTick": {"show": false}, "splitLine": {"show": false}, "splitNumber": 1}}, "xAxisShowType": "time"}}, "group": {"name": null}, "name": "请求数", "pos": null, "queries": [{"checked": true, "datasource": "dataflux", "qtype": "dql", "query": {"density": "lower", "filter": [{"logic": "and", "name": "service", "op": "=", "value": "front-api"}], "groupBy": " by `status`", "groupByTime": "auto", "q": "T::re(`.*`):(count(`trace_id`)){ `service` = 'front-api' } [::auto] by `status`"}, "unit": "", "uuid": "6aed3c00-7a99-11ec-8689-536665ee3a48"}], "type": "sequence"}], "groups": [], "type": "template", "vars": []}, "summary": "", "tagInfo": [], "tags": [], "thumbnail": "", "title": "lwc-链路资源"}}' \
--compressed 
```




## 响应
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




