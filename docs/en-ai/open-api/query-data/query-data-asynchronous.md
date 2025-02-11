# Asynchronous DQL Data Query

---

<br />**POST /api/v1/df/asynchronous/query_data**

## Overview

## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| queries              | array    |           | Multi-command query, the content is a list of query objects <br> Allow null: False <br> |
| fieldTagDescNeeded   | boolean  |           | Whether field or tag description information is needed <br> Allow null: False <br> |

## Parameter Additional Explanation

*Query Explanation*

--------------

1. Parameter Explanation

| Parameter Name          | Type      | Required  | Description  |
| :----------------------| :-------- | :-------- | :----------- |
| queries                | array     | Y         | Multi-command query, the content is a list of query objects |
| fieldTagDescNeeded     | boolean   |           | Whether field or tag description information is needed |

2. Structure of `queries[*]` Member Parameters
*** Note: The `async_id` parameter has been added based on the "DQL Data Query" interface ***

| Parameter Name          | Type      | Required  | Description  |
| :----------------------| :-------- | :-------- | :----------- |
| `async_id`             | string    | N         | Asynchronous query task ID; this value comes from the `content.data[*].async_id` in the previous DQL query result; if this value exists in the last query result, it must be included in the current query |
| qtype                  | string    | Y         | Query statement type <br/> dql: indicates a DQL type query statement; <br/> promql: indicates a PromQl type query statement |
| query                  | json      | Y         | Query structure |
| query.q                | string    |           | Query statement consistent with the `qtype`, e.g., DQL or PromQL query statement |
| query.highlight        | boolean   |           | Whether to display highlighted data |
| query.timeRange        | array     |           | List of timestamps for the time range |
| query.disableMultipleField | bool    |           | Whether to enable single-column mode, default is `true` |
| query.showLabel        | bool      |           | Whether to display object labels, default is none |
| query.funcList         | array     |           | Re-aggregates DQL return values; note that this parameter is invalid when `disableMultipleField=False` |
| query.slimit           | integer   |           | Time series grouping size, only valid for metrics queries |
| query.soffset          | integer   |           | Time series grouping offset |
| query.limit            | integer   |           | Page size |
| query.offset           | integer   |           | Page offset |
| query.orderby          | array     |           | Sorting list, `{fieldName:method}`; note that sorting for Mearsurement queries only supports `fieldName=time`; method options are ["desc", "asc"] |
| query.sorderby         | array     |           | Sorting list, where `sorderby` columns are expressions supporting all single-value aggregation functions like min, max, last, avg, p90, p95, count, `{fieldName:method}`, same structure as `orderby` |
| query.order_by         | array     |           | Sorting list, structure `[{"column": "field", "order": "DESC"}]`, compatible with Doris engine fields |
| query.sorder_by        | array     |           | Sorting list, structure `[{"column": "field", "order": "DESC"}]`, compatible with Doris engine fields |
| query.density          | string    |           | Response point density, priority lower than `autoDensity` and higher than density set in DQL statement |
| query.interval         | integer   |           | Unit is seconds, time slice interval used to calculate response points; effective if calculated point count is less than or equal to high-density point count, otherwise invalid |
| query.search_after     | array     |           | Pagination marker. Use the `search_after` value from the last response with the same parameters as the parameter for this request |
| query.maxPointCount    | integer   |           | Maximum number of points |
| query.workspaceUUID    | string    |           | UUID of the workspace to query |
| query.workspaceUUIDs   | array     |           | UUIDs of workspaces to query, takes precedence over `query.workspaceUUID` |
| query.output_format    | string    |           | lineprotocol: output in line protocol format; defaults to existing output format if not specified |
| query.cursor_time      | integer   |           | Segment query threshold: set `cursor_time` to `end_time` for the first segment query; for subsequent segment queries, set `cursor_time` to `next_cursor_time` in the response |
| query.disable_sampling | bool      |           | Sampling disable switch, default value is false |

3. Explanation of Response Point Density `density` Parameter Values

| Option | Description |
| :----- | :---------- |
| lower  | Low, 60 points |
| low    | Low, 180 points |
| medium | Medium, 360 points |
| high   | High, 720 points |

* Note the priority of the point density parameter, maximum density `density[high]` </br>
maxPointCount > interval > density > control parameters in DQL statement

4. Common Query Explanations

  - [Unrecovered Event Query](../../../studio-backend/unrecovered-event-query/)
</br>
Note: When performing data queries via openapi interface, the default role is Administrator. Be aware of possible data access rule restrictions.


## Response
```shell
 
```