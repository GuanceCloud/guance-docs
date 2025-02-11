# 【Data Query】DQL Data Query

---

<br />**POST /api/v1/df/\{workspace_uuid\}/query_data**

## Overview

## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| workspace_uuid        | string   | Y          | UUID of the workspace to query<br> |

## Body Request Parameters

| Parameter Name            | Type     | Required   | Description              |
|:-------------------------|:---------|:-----------|:------------------------|
| sceneUUID                 | string   | N          | Scene UUID<br>Allow empty: False <br> |
| dashboardUUID             | string   | N          | View UUID<br>Allow empty: False <br> |
| testTimeout               | float    | N          | Timeout for ban operation (valid in debug mode)<br>Allow empty: False <br> |
| queries                   | array    | N          | Multi-command query, a list of query objects<br>Allow empty: False <br> |
| fieldTagDescNeeded        | boolean  | N          | Whether to include field or tag description information<br>Allow empty: False <br> |
| expensiveQueryCheck       | boolean  | N          | Whether to check wildcard left* situations<br>Allow empty: False <br> |
| dataQueryPreview          | json     | N          | Data access preview feature<br>Allow empty: False <br> |
| dataQueryPreview.maskFields | string  | N          | Masked fields, multiple fields separated by commas<br>Example: message,host <br>Allow empty: False <br>Allow empty string: True <br> |
| dataQueryPreview.reExprs  | array    | N          | Regular expressions<br>Example: [{'name': 'jjj', 'reExpr': 'ss', 'enable': 0}, {'name': 'lll', 'reExpr': 'ss', 'enable': 1}] <br>Allow empty: False <br> |

## Additional Parameter Notes

*Query Description*

--------------

1. Description of Fields in `queries` Array Elements

| Parameter Name | Type   | Required | Description          |
|---------------|--------|----------|----------------------|
| sceneUUID     | string | Y        | Scene UUID           |
| dashboardUUID | string | Y        | View UUID            |
| queries[*]    | string | Y        | Query list           |

2. DQL JSON Structure Parameter Description (`queries[*]` Element)

* Basic Fields *

| Parameter Name      | Type    | Required | Description                                                                                             |
| :----------------- | :------ | :------- | :------------------------------------------------------------------------------------------------------ |
| qtype              | string  | Y        | Query statement type <br/> dql: indicates a DQL type query statement; <br/> promql: indicates a PromQl type query statement   |
| query              | json    | Y        | Query structure                                                                                         |
| query.q            | string  |          | Query statement consistent with the `qtype`, e.g., dql or promql query statement                        |
| query.highlight    | boolean |          | Whether to display highlighted data                                                                     |
| query.timeRange    | array   |          | List of timestamps for the time range                                                                   |
| query.disableMultipleField | bool   |          | Whether to enable single-column mode, default is `true`                                                 |
| query.showLabel    | bool    |          | Whether to show object labels, default is none                                                          |
| query.funcList    | array   |          | Modifies DQL return values with further aggregation, invalid when `disableMultipleField=false`         |
| query.slimit      | integer |          | Time series group size, only valid for metrics queries                                                  |
| query.soffset     | integer |          | Time series group offset                                                                                |
| query.limit       | integer |          | Page size                                                                                                |
| query.offset      | integer |          | Page offset                                                                                              |
| query.orderby     | array   |          | Sort list, `{fieldName:method}`; note that sorting for Mearsurement queries only supports `fieldName=time`; methods are ["desc", "asc"] |
| query.sorderby    | array   |          | Sort list, `sorderby` columns are expressions supporting all single-value aggregation functions like min max last avg p90 p95 count, `{fieldName:method}`, structure same as `orderby` |
| query.order_by    | array   |          | Sort list, structure is `[{"column": "field", "order": "DESC"}]`, compatible field for Doris engine |
| query.sorder_by   | array   |          | Sort list, structure is `[{"column": "field", "order": "DESC"}]`, compatible field for Doris engine |
| query.density     | string  |          | Point density of response, priority lower than `autoDensity` and higher than density set in DQL statement |
| query.interval    | integer |          | Unit is seconds, time slice interval used to calculate response points; effective if calculated point count <= point count when `density=high`, otherwise ineffective |
| query.search_after | array   |          | Pagination marker, returned by this interface for use in the next request                               |
| query.maxPointCount | integer |          | Maximum number of points                                                                                 |
| query.workspaceUUID | string  |          | UUID of the workspace to query                                                                           |
| query.output_format | string  |          | Output format: lineprotocol, defaults to existing output format if not specified                        |
| query.cursor_time | integer |          | Segment query threshold: set `cursor_time` to `end_time` for the first segment query; for subsequent segment queries, set `cursor_time` to `next_cursor_time` from the response |
| query.disable_sampling | bool   |          | Sampling disable switch, default value is false                                                         |

* Response Point Density `density` Parameter Values Description *

| Optional Value | Description                |
| :------------- | :------------------------- |
| lower          | Low, 60 points             |
| low            | Low, 180 points            |
| medium         | Medium, 360 points         |
| high           | High, 720 points           |

* Note the priority of the point density parameter, maximum density `density[high]` * </br>
maxPointCount > interval > density > control parameters in DQL statement

3. Common Query Descriptions

  - [Unrecovered Event Query](../../../studio-backend/unrecovered-event-query/)

## Response
```shell
 
```