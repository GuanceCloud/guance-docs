# 【Aggregation to Metrics】Create

---

<br />**POST /api/v1/aggs_to_metric/add**

## Overview
Create a metrics generation rule



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| extend | json | Y | Additional information<br>Can be empty: False <br> |
| jsonScript | json | Y | Rule configuration<br>Can be empty: False <br> |
| jsonScript.type | string | Y | Type<br>Example: rumToMetric <br>Can be empty: False <br>Can be an empty string: False <br>Optional values: ['logToMetric', 'rumToMetric', 'apmToMetric', 'metricToMetric', 'securityToMetric'] <br> |
| jsonScript.query | json | Y | DQL query related information<br>Can be empty: False <br> |
| jsonScript.metricInfo | json | Y | Metrics configuration information<br>Can be empty: False <br> |
| jsonScript.metricInfo.every | string | Y | Frequency<br>Example: 5m <br>Can be an empty string: False <br> |
| jsonScript.metricInfo.metric | string | Y | Measurement name<br>Example: cpu <br>Can be an empty string: False <br> |
| jsonScript.metricInfo.metricField | string | Y | Metric name<br>Example: load5s <br>Can be an empty string: False <br> |
| jsonScript.metricInfo.unit | string |  | Unit<br>Example: load5s <br>Can be an empty string: True <br> |
| jsonScript.metricInfo.desc | string |  | Description<br>Example: xxx <br>Can be an empty string: True <br> |

## Additional Parameter Explanation


*Request parameter explanation.*

**1. **`jsonScript` parameter explanation**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|type                   |String|Required| Data source type, enumerated type|
|query                  |Json|Required| Query information|
|metricInfo             |Json|Required| Measurement configuration information|

--------------

**2. Check type `jsonScript.type` explanation**

|Key|Description|
|---|----|
|rumToMetric| RUM generated metric|
|apmToMetric| APM generated metric|
|logToMetric| Logging generated metric|
|metricToMetric| Metric generated metric|
|securityToMetric| Security Check generated metric|

--------------

**3. Check type `jsonScript.metricInfo` explanation**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|every                  |String|Required| Frequency, options are 1m, 5m, 15m, unit is (minutes/m)|
|metric                 |String     |Required| Measurement name |
|metricField            |String     |Required| Metric name |
|unit                   |String     || Unit |
|desc                   |String     || Description |

--------------

**3.1 Check type `jsonScript.metricInfo.unit` unit explanation**

Unit format: custom/["unit type","unit"] , example: custom/["time","ms"]
<br/>
Custom unit format: custom/["custom","custom unit"], example: custom/["custom","tt"]
<br/>
Standard unit types, refer to [ Unit Documentation ](../../../studio-backend/unit/)

--------------

**4. Check type `jsonScript.query` explanation**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|q                      |String|Required| Query statement  |
|qtype                  |String     || Query syntax type, dql/promql |
|qmode                  |String     || Query type, selector box: selectorQuery , handwritten: customQuery, this field affects the style of front-end query echo|

--------------

**5. **`extend` parameter explanation**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|filters                   |Array[dict]|| Filter condition list when not log type|
|groupBy                   |Array[str]| Grouping information|
|funcName                  |string|Required| Aggregation function (must be passed when qmode is selector mode, used for front-end echo), enumerated values ("count", "avg", "max", "sum", "min", "count_distinct", "p75", "p95", "p99") |
|fieldKey                  |string|Required| Aggregation field (must be passed when qmode is selector mode, used for front-end echo)|
|index                     |string|| Index name when log type|
|source                    |string|| This field represents different meanings in different types: log type: source source, application performance type: service service, user access type: application app_id, metrics type: measurement, security check: category category|
|filterString              |string|| Filter condition when log type, original filter string, example: 'host:hangzhou123 -service:coredns internal:true'|

Note: 
All fields in the extend field are only used for front-end echo display, the actual metric generation query statement follows the query information configured in jsonScript.query
<br/>

--------------

**6. Main structure explanation of `extend.filters`**

| Parameter Name             | Type  | Required  | Description          |
|--------------------|----------|----|------------------------|
|condition           |string |  | Relationship with the previous filter condition, optional values: `and`, `or`; default value: `and` |
|name                |string |  | Field name to be filtered |
|op           |string |  | Operator, optional values:  `=`, `!=`, `match`, `not match`|
|values               |array |  | Value list |
|values[#]            |string/int/boolean |  | Can be string/number/boolean, during data comparison it will take specific elements from `values` based on the characteristics of `operation`, for example, if `operation` is `=`, only values[0] participates in the operation |

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

**7. Overall structure example:**
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
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/objc_cfg/create' \
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