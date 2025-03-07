# 【Func函数】列出

---

<br />**GET /api/v1/outer_function/list**

## 概述
列出 OpenAPI 允许执行的 Func 函数列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| _fuzzySearch | string |  | 模糊搜索查询字段<br>例子: 超级VIP模板 <br>允许为空: False <br> |
| funcId | string |  | 根据函数Id搜索<br>例子: 超级VIP模板 <br>允许为空: False <br> |
| funcTitle | string |  | 根据函数标题搜索, 以Like 方式查询<br>例子: 超级VIP模板 <br>允许为空: False <br> |
| funcTags | commaarray |  | 函数标签,用于根据标签过滤函数<br>例子:  <br>允许为空: False <br> |
| funcScriptId | string |  | 脚本集合ID<br>例子:  <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/outer_function/list' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## 响应
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
            "scriptSetTitle": "<<< custom_key.brand_name >>>支持",
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
            "scriptSetTitle": "<<< custom_key.brand_name >>>支持",
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




