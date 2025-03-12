# Data Query with DQL

---

<br />**POST /api/v1/df/\{workspace_uuid\}/query_data**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| workspace_uuid        | string   | Y          | The UUID of the workspace to query<br> |


## Body Request Parameters

| Parameter Name            | Type     | Required   | Description              |
|:-------------------------|:---------|:-----------|:-------------------------|
| sceneUUID                | string   |            | Scene UUID<br>Allow null: False <br> |
| dashboardUUID            | string   |            | View UUID<br>Allow null: False <br> |
| testTimeout              | float    |            | Timeout for ban operation (valid in debug mode)<br>Allow null: False <br> |
| queries                  | array    |            | Multi-command query, list of query objects<br>Allow null: False <br> |
| fieldTagDescNeeded       | boolean  |            | Whether field or tag description is needed<br>Allow null: False <br> |
| expensiveQueryCheck      | boolean  |            | Whether to check wildcard left *<br>Allow null: False <br> |
| dataQueryPreview         | json     |            | Data access preview feature<br>Allow null: False <br> |
| dataQueryPreview.maskFields | string  |            | Masked fields, multiple fields separated by commas<br>Example: message,host <br>Allow null: False <br>Allow empty string: True <br> |
| dataQueryPreview.reExprs | array    |            | Regular expressions<br>Example: [{'name': 'jjj', 'reExpr': 'ss', 'enable': 0}, {'name': 'lll', 'reExpr': 'ss', 'enable': 1}] <br>Allow null: False <br> |

## Additional Parameter Explanation

*Query Explanation*

--------------

1. Description of Fields in `queries` Array Elements

| Parameter Name        | Type     | Required | Description              |
|-----------------------|----------|----------|--------------------------|
| sceneUUID             | string   | Y        | Scene UUID               |
| dashboardUUID         | string   | Y        | View UUID                |
| queries[*]            | string   | Y        | Query list               |

2. DQL JSON Structure Parameter Explanation (`queries[*]` Elements)

* Basic Fields *

| Parameter Name  | Type     | Required | Description  |
| :-------------- | :------- | :------- | :----------- |
| qtype           | string   | Y        | Type of query statement <br/> dql: indicates a DQL type query statement; <br/> promql: indicates a PromQL type query statement   |
| query           | json     | Y        | Query structure |
| query.q         | string   |          | Query statement consistent with qtype, e.g., DQL or PromQL query statement |
| query.highlight | boolean  |          | Whether to display highlighted data |
| query.timeRange | array    |          | List of timestamps for time range |
| query.disableMultipleField | bool     |          | Whether to enable single-column mode, default is `true` |
| query.showLabel | bool     |          | Whether to show object labels, default none |
| query.funcList  | array    |          | Aggregates and modifies DQL return values, note that this parameter is invalid when disableMultipleField=False |
| query.slimit    | integer  |          | Time series grouping size, only valid for metrics queries |
| query.soffset   | integer  |          | Time series grouping offset |
| query.limit     | integer  |          | Page size |
| query.offset    | integer  |          | Page offset |
| query.orderby   | array    |          | Sort list, `{fieldName:method}`, note that sorting for Measurement queries only supports fieldName=time; method in ["desc", "asc"]; note that sorting for Measurement queries only supports fieldName=time |
| query.sorderby  | array    |          | Sort list, sorderby column is an expression supporting all single-value aggregation functions min max last avg p90 p95 count, `{fieldName:method}`, same structure as orderby |
| query.order_by  | array    |          | Sort list, structure `[{"column": "field", "order": "DESC"}]`, compatible field for Doris engine |
| query.sorder_by | array    |          | Sort list, structure `[{"column": "field", "order": "DESC"}]`, compatible field for Doris engine |
| query.density   | string   |          | Response point density, lower priority than autoDensity and higher than density set in DQL statement |
| query.interval  | integer  |          | Unit is seconds, time slice interval used to calculate response points; if calculated points are less than or equal to the number of points when density=high, it is valid, otherwise invalid |
| query.search_after | array   |          | Pagination marker, returned by the current API endpoint for use in the next request |
| query.maxPointCount | integer |          | Maximum number of points |
| query.workspaceUUID | string  |          | UUID of the workspace to query |
| query.output_format | string  |          | lineprotocol: row protocol output, defaults to existing output format if not specified |
| query.cursor_time | integer |          | Segment query threshold: set cursor_time to end_time for the first segment query; for subsequent segment queries, set cursor_time to next_cursor_time from the response |
| query.disable_sampling | bool    |          | Sampling disable switch, default value is false |

* Explanation of Response Point Density `density` Parameter Values *

| Option  | Description  |
| :------ | :----------- |
| lower   | Low, 60 points |
| low     | Low, 180 points |
| medium  | Medium, 360 points |
| high    | High, 720 points |

* Note the priority of density parameters, maximum density `density[high]` </br>
maxPointCount > interval > density > control parameters in DQL statement

3. Common Query Explanations

  - [Unrecovered Event Query](../../../studio-backend/unrecovered-event-query/)




## Response
```shell
 
```