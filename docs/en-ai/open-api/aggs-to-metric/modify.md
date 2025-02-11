# Modify Aggregated Metrics

---

<br />**POST /api/v1/aggs_to_metric/\{rule_uuid\}/modify**

## Overview
Modify the rule for generating metrics

## Route Parameters

| Parameter Name | Type   | Required | Description             |
|:--------------|:-------|:--------|:-----------------------|
| rule_uuid     | string | Y       | ID of the aggregated metric rule |

## Body Request Parameters

| Parameter Name            | Type   | Required | Description                                                                                                                                                                                                                     |
|:-------------------------|:-------|:--------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| extend                   | json   | Y       | Additional information <br> Allow empty: False <br>                                                                                                                                                                             |
| jsonScript               | json   | Y       | Rule configuration <br> Allow empty: False <br>                                                                                                                                                                                 |
| jsonScript.type          | string | Y       | Type <br> Example: rumToMetric <br> Allow empty: False <br> Allow empty string: False <br> Options: ['logToMetric', 'rumToMetric', 'apmToMetric', 'metricToMetric', 'securityToMetric'] <br>                                    |
| jsonScript.query         | json   | Y       | DQL query related information <br> Allow empty: False <br>                                                                                                                                                                      |
| jsonScript.metricInfo    | json   | Y       | Metric set configuration information <br> Allow empty: False <br>                                                                                                                                                               |
| jsonScript.metricInfo.every | string | Y       | Frequency <br> Example: 5m <br> Allow empty string: False <br>                                                                                                                                                                  |
| jsonScript.metricInfo.metric | string | Y       | Metric set name <br> Example: cpu <br> Allow empty string: False <br>                                                                                                                                                           |
| jsonScript.metricInfo.metricField | string | Y       | Metric name <br> Example: load5s <br> Allow empty string: False <br>                                                                                                                                                            |
| jsonScript.metricInfo.unit | string |         | Unit <br> Example: load5s <br> Allow empty string: True <br>                                                                                                                                                                    |
| jsonScript.metricInfo.desc | string |         | Description <br> Example: xxx <br> Allow empty string: True <br>                                                                                                                                                                |

## Parameter Additional Notes

*Data Explanation.*

### 1. `jsonScript` Parameter Explanation

| Parameter Name | Type  | Required | Description                    |
|----------------|-------|----------|----------------------------------|
| type           | String| Required | Data source type, enum type      |
| query          | Json  | Required | Query information               |
| metricInfo     | Json  | Required | Metric set configuration information |

--------------

### 2. Explanation of `jsonScript.type`

| Key                | Description                  |
|--------------------|------------------------------|
| rumToMetric        | RUM generated metrics        |
| apmToMetric        | APM generated metrics        |
| logToMetric        | Logging generated metrics    |
| metricToMetric     | Metric generated metrics     |
| securityToMetric   | Security Check generated metrics |

--------------

### 3. Explanation of `jsonScript.metricInfo`

| Parameter Name | Type   | Required | Description                                                                 |
|----------------|--------|----------|-------------------------------------------------------------------------------|
| every          | String | Required | Frequency, unit is (minutes: m), example: 15m                              |
| metric         | String | Required | Metric set name                                                             |
| metricField    | String | Required | Metric name                                                                 |
| unit           | String |          | Unit                                                                        |
| desc           | String |          | Description                                                                 |

--------------

#### 3.1 Explanation of `jsonScript.metricInfo.unit` Units

Unit format: custom/["unit type", "unit"], example: custom/["time", "ms"]<br/>
Custom unit format: custom/["custom", "custom unit"], example: custom/["custom", "tt"]<br/>
Standard unit types, refer to [Unit Explanation](../../../studio-backend/unit/)

--------------

### 4. Explanation of `jsonScript.query`

| Parameter Name | Type   | Required | Description                                                                 |
|----------------|--------|----------|-------------------------------------------------------------------------------|
| q              | String | Required | Query statement                                                             |
| qtype          | String |          | Query syntax type, dql/promql                                                |
| qmode          | String |          | Query type, selector: selectorQuery, handwritten: customQuery, affects front-end query echo style |

--------------

### 5. Explanation of `extend`

| Parameter Name | Type             | Required | Description                                                                 |
|----------------|------------------|----------|-------------------------------------------------------------------------------|
| filters        | Array[dict]      |          | Filter condition list when not a log type                                   |
| groupBy        | Array[str]       |          | Grouping information                                                        |
| funcName       | string           | Required | Aggregation function, enum values ("count", "avg", "max", "sum", "min", "count_distinct", "p75", "p95", "p99") |
| fieldKey       | string           | Required | Aggregation field                                                           |
| index          | string           |          | Index name when log type                                                    |
| source         | string           |          | Represents different meanings in different types: Log type: source, APM type: service, RUM type: app_id, Metric type: Mearsurement, Security Check: category |
| filterString   | string           |          | Filter condition when log type, original filter string, example: 'host:hangzhou123 -service:coredns internal:true' |

Note:
All fields in the `extend` field are only used for front-end display and do not affect the actual metric generation query, which follows the query information configured in `jsonScript.query`.

--------------

### 6. Structure Explanation of `extend.filters`

| Parameter Name | Type   | Required | Description                                                                 |
|----------------|--------|----------|-------------------------------------------------------------------------------|
| condition      | string |          | Relationship with the previous filter condition, options: `and`, `or`; default value: `and` |
| name           | string |          | Field name to be filtered                                                   |
| op             | string |          | Operator, options: `=`, `!=`, `match`, `not match`                          |
| values         | array  |          | Value list                                                                  |
| values[#]      | string/int/boolean |          | Can be string/number/boolean, specific elements from `values` are compared based on `op`, e.g., only values[0] participates in comparison when `op` is `=` |

#### 6.1 Example of `extend.filters`

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

### 7. Overall Structure Example:

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
curl 'https://openapi.guance.com/api/v1/objc_cfg/rul_xxxx/create' \
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