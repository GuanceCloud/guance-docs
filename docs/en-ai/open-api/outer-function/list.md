# [Func Functions] List

---

<br />**GET /api/v1/outer_function/list**

## Overview
List the Func functions that are allowed to be executed via OpenAPI


## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| _fuzzySearch | string | No | Fuzzy search query field<br>Example: Super VIP Template <br>Can be empty: False <br> |
| funcId | string | No | Search by function ID<br>Example: Super VIP Template <br>Can be empty: False <br> |
| funcTitle | string | No | Search by function title using a LIKE query<br>Example: Super VIP Template <br>Can be empty: False <br> |
| funcTags | commaarray | No | Function tags, used for filtering functions by tags<br>Example:  <br>Can be empty: False <br> |
| funcScriptId | string | No | Script collection ID<br>Example:  <br> |

## Additional Parameter Notes



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
            "definition": "test(workspace_uuid, workspace_token, your_name='OpenAPI User')",
            "description": "Test interface, mainly for users to test whether they can successfully invoke DataFlux Func via OpenAPI",
            "extraConfigJSON": null,
            "id": "guance__openapi.test",
            "integration": null,
            "kwargsJSON": {
                "workspace_token": {},
                "workspace_uuid": {},
                "your_name": {
                    "default": "OpenAPI User"
                }
            },
            "name": "test",
            "scriptDescription": null,
            "scriptId": "guance__openapi",
            "scriptSetDescription": null,
            "scriptSetId": "guance",
            "scriptSetTitle": "Guance Support",
            "scriptTitle": null,
            "tagsJSON": null,
            "title": "Test",
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
            "description": "Report events, implemented through DataFlux Func to write events\nSupports user-defined inspections and all alert handling logic of monitors\n\nParameters:\n    data {dict,list} Event data or list of event data to report, structure as follows:\n                        {\n                            \"title\"         : {str}      Event title, supports single-line text only\n                            \"message\"       : {str}      Event content, supports Markdown\n                            \"status\"        : {str}      Event level, optional values: ok, info, warning, error, critical\n                            \"dimension_tags\": {str,dict} Event dimensions, e.g., { 'host': 'web001' } or its serialized string\n                        }",
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
            "scriptSetTitle": "Guance Support",
            "scriptTitle": null,
            "tagsJSON": null,
            "title": "Report Event",
            "url": "/api/v1/func/guance__openapi.report_event"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1B02BD5D-D249-4D56-8762-9D6CB31FF0D1"
} 
```