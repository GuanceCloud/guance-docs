# Func List

---

<br />**get /api/v1/outer_function/list**

## Overview
List Func allowed by OpenAPI.




## Query Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| _fuzzySearch | string |  | Fuzzy search query field<br>Example: Super VIP template <br>Allow null: False <br> |
| funcId | string |  | Search according to function Id<br>Example: Super VIP template <br>Allow null: False <br> |
| funcTitle | string |  | Search according to the function title and query in Like mode<br>Example: Super VIP template <br>Allow null: False <br> |
| funcTags | commaarray |  | Function tags, which are used to filter functions according to tags.<br>Example:  <br>Allow null: False <br> |
| funcScriptId | string |  | Script collection ID<br>Example:  <br> |

## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/outer_function/list' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## Response
```shell
{
    "code": 200,
    "content": [
        {
            "argsJSON": [
                "workspace_uuid",
                "workspace_token",
                "your_name"
            ],
            "category": "openapi",
            "definition": "test(workspace_uuid, workspace_token, your_name='OpenAPI 用户')",
            "description": "测试接口，主要方便用户测试是否能够通过 OpenAPI 调通 DataFlux Func",
            "extraConfigJSON": null,
            "id": "guance__openapi.test",
            "integration": null,
            "kwargsJSON": {
                "workspace_token": {},
                "workspace_uuid": {},
                "your_name": {
                    "default": "OpenAPI 用户"
                }
            },
            "name": "test",
            "scriptDescription": null,
            "scriptId": "guance__openapi",
            "scriptSetDescription": null,
            "scriptSetId": "guance",
            "scriptSetTitle": "观测云支持",
            "scriptTitle": null,
            "tagsJSON": null,
            "title": "测试",
            "url": "/api/v1/func/guance__openapi.test"
        },
        {
            "argsJSON": [
                "workspace_uuid",
                "workspace_token",
                "data"
            ],
            "category": "openapi",
            "definition": "report_event(workspace_uuid, workspace_token, data)",
            "description": "报告事件，通过 DataFlux Func 实现事件写入\n支持自建巡检，以及监控器配套的所有告警处理逻辑\n\n参数：\n    data {dict,list} 上报的事件数据或其列表，结构如下：\n                        {\n                            \\\"title\\\"         : {str}      事件标题，只支持单行文本\n                            \\\"message\\\"       : {str}      事件内容，支持 Markdown\n                            \\\"status\\\"        : {str}      事件级别，可选值为： ok, info, warning, error, critical\n                            \\\"dimension_tags\\\": {str,dict} 事件维度，如：{ 'host': 'web001' } 或其序列化后的字符串\n                        }",
            "extraConfigJSON": null,
            "id": "guance__openapi.report_event",
            "integration": null,
            "kwargsJSON": {
                "data": {},
                "workspace_token": {},
                "workspace_uuid": {}
            },
            "name": "report_event",
            "scriptDescription": null,
            "scriptId": "guance__openapi",
            "scriptSetDescription": null,
            "scriptSetId": "guance",
            "scriptSetTitle": "观测云支持",
            "scriptTitle": null,
            "tagsJSON": null,
            "title": "报告事件",
            "url": "/api/v1/func/guance__openapi.report_event"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1B02BD5D-D249-4D56-8762-9D6CB31FF0D1"
} 
```




