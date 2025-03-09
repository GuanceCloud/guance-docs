# 【Aggregation to Metrics】Create

---

<br />**POST /api/v1/aggs_to_metric/add**

## Overview
Create an aggregation to metrics rule


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| extend | json | Y | Additional information<br>Allow null: False <br> |
| jsonScript | json | Y | Rule configuration<br>Allow null: False <br> |
| jsonScript.type | string | Y | Type<br>Example: rumToMetric <br>Allow null: False <br>Allow empty string: False <br>Possible values: ['logToMetric', 'rumToMetric', 'apmToMetric', 'metricToMetric', 'securityToMetric'] <br> |
| jsonScript.query | json | Y | DQL query related information<br>Allow null: False <br> |
| jsonScript.metricInfo | json | Y | Metric configuration information<br>Allow null: False <br> |
| jsonScript.metricInfo.every | string | Y | Frequency<br>Example: 5m <br>Allow empty string: False <br> |
| jsonScript.metricInfo.metric | string | Y | Mearsurement name<br>Example: cpu <br>Allow empty string: False <br> |
| jsonScript.metricInfo.metricField | string | Y | Metric name<br>Example: load5s <br>Allow empty string: False <br> |
| jsonScript.metricInfo.unit | string |  | Unit<br>Example: load5s <br>Allow empty string: True <br> |
| jsonScript.metricInfo.desc | string |  | Description<br>Example: xxx <br>Allow empty string: True <br> |

## Additional Parameter Explanation


*Request parameter explanation.*

**1. **`jsonScript` parameter explanation**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|type                   |String|Required| Data source type, enumerated type|
|query                  |Json|Required| Query information|
|metricInfo             |Json|Required| Metric configuration information|

--------------

**2. Explanation of `jsonScript.type` types**

|Key|Description|
|---|----|
|rumToMetric| RUM to metric|
|apmToMetric| APM to metric|
|logToMetric| Logging to metric|
|metricToMetric| Metric to metric|
|securityToMetric| Security check to metric|

--------------

**3. Explanation of `jsonScript.metricInfo` types**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|every                  |String|Required| Frequency, options are 1m, 5m, 15m, unit is (minutes/m)|
|metric                 |String|Required| Mearsurement name |
|metricField            |String|Required| Metric name |
|unit                   |String| | Unit |
|desc                   |String| | Description |

--------------

**3.1 Explanation of `jsonScript.metricInfo.unit` units**

Unit format: custom/["unit type", "unit"], example: custom/["time", "ms"]
<br/>
Custom unit format: custom/["custom", "custom unit"], example: custom/["custom", "tt"]
<br/>
Standard unit types, refer to [ Unit Description ](../../../studio-backend/unit/)

--------------

**4. Explanation of `jsonScript.query` types**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|q                      |String|Required| Query statement  |
|qtype                  |String| | Query syntax type, dql/promql |
|qmode                  |String| | Query type, selector box: selectorQuery, manual: customQuery, this field affects the style of query echo on the frontend|

--------------

**5. **`extend` parameter explanation**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|filters                |Array[dict]| | Filter condition list when not log type|
|groupBy                |Array[str]| Grouping information|
|funcName               |string|Required| Aggregation function (must be passed when qmode is selector box mode, used for frontend echo), enumerated values ("count", "avg", "max", "sum", "min", "count_distinct", "p75", "p95", "p99") |
|fieldKey               |string|Required| Aggregation field (must be passed when qmode is selector box mode, used for frontend echo)|
|index                  |string| | Index name when log type|
|source                 |string| | This field represents different meanings in different types: log type: source, application performance type: service, user visit type: application app_id, metric type: mearsurement, security check: category|
|filterString           |string| | Filter condition when log type, original filter string, example: 'host:hangzhou123 -service:coredns internal:true'|

Note: 
All fields in the extend field are only used for frontend echo display. The actual generation of metric queries follows the query information configured in jsonScript.query.
<br/>

--------------

**6. Structure explanation of `extend.filters`**

| Parameter Name             | Type  | Required  | Description          |
|--------------------|----------|----|------------------------|
|condition           |string |  | Relationship with the previous filter condition, possible values: `and`, `or`; default value: `and` |
|name                |string |  | Field name to be filtered |
|op                  |string |  | Operator, possible values: `=`, `!=`, `match`, `not match`|
|values              |array |  | Value list |
|values[#]           |string/int/boolean |  | Can be string/number/boolean, during data comparison it will select specific elements from `values` based on the characteristics of `operation`, for example, when `operation` is `=`, only values[0] participates in the operation |

**6.1 Example of `extend.filters`:**

```json
[
  {
      "name": "A",
      "condition": "and",
      "op": "match",
      "values": ["error"]
  },
  {
      "name": "tagC",
      "condition": "and",
      "op": "=",
      "values": ["ok"]
  }
]
```

**7. **Overall structure example:**
```json
    {
      "extend": {
        "filters": [],
        "groupBy": ["host_ip"],
        "funcName": "count",
        "fieldKey": "*",
        "index": "default",
        "source": "*",
        "filterString": "host:hangzhou123 region:guanzhou"
      },
      "jsonScript": {
        "type": "logToMetric",
        "metricInfo": {
          "every": "1m",
          "metric": "test",
          "metricField": "001-test",
          "unit": "custom/[\"timeStamp\",\"ms\"]",
          "desc": ""
        },
        "query": {
          "q": "L('default')::RE(`.*`):(count(`*`)) { `host`='hangzhou123' and `region`='guanzhou'  } BY `host_ip`",
          "qtype": "dql"
        }
      }
    }
```




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/objc_cfg/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"extend":{"filters":[],"groupBy":["host_ip"],"funcName":"count","fieldKey":"*","index":"default","source":"*","filterString":"host:hangzhou123 region:guanzhou"},"jsonScript":{"type":"logToMetric","metricInfo":{"every":"1m","metric":"test","metricField":"001-test","unit":"custom/[\"timeStamp\",\"ms\"]","desc":""},"query":{"q":"L('default')::RE(`.*`):(count(`*`)) { `host`='hangzhou123' and `region`='guanzhou'  } BY `host_ip`","qtype":"dql"}}}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "workspaceUUID": "wksp_xxxx",
        "monitorUUID": "",
        "updator": null,
        "type": "aggs",
        "refKey": "",
        "secret": null,
        "jsonScript": {
            "type": "logToMetric",
            "metricInfo": {
                "every": "1m",
                "metric": "test",
                "metricField": "001-test",
                "unit": "custom/[\"timeStamp\",\"ms\"]",
                "desc": ""
            },
            "query": {
                "q": "L('default')::RE(`.*`):(count(`*`)) { `host`='hangzhou123' and `region`='guanzhou'  } BY `host_ip`",
                "qtype": "dql"
            }
        },
        "crontabInfo": {
            "id": "cron-4VdviPep3oHc",
            "crontab": null
        },
        "extend": {
            "filters": [],
            "groupBy": [
                "host_ip"
            ],
            "funcName": "count",
            "fieldKey": "*",
            "index": "default",
            "source": "*",
            "filterString": "host:hangzhou123 region:guanzhou"
        },
        "createdWay": "manual",
        "isLocked": false,
        "openPermissionSet": false,
        "permissionSet": [],
        "id": null,
        "uuid": "rul_xxxx",
        "status": 0,
        "creator": "acnt_xxxx",
        "createAt": 1734594428,
        "deleteAt": -1,
        "updateAt": null,
        "__operation_info": {
            "uuid": "rul_xxxx"
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "1111139030457458757"
} 
```