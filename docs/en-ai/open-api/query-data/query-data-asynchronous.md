# Asynchronous DQL Data Query

---

<br />**POST /api/v1/df/asynchronous/query_data**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| queries | array |  | Multiple command queries, its content is a list composed of query objects<br>Allow null: False <br> |
| fieldTagDescNeeded | boolean |  | Whether field or tag description information is needed<br>Allow null: False <br> |

## Additional Parameter Explanation

*Query Explanation*

--------------

1. Parameter Description

| Parameter Name  | Type  | Required  | Description  |
| :------------- | :------------- | :------------- | :------------- |
|  queries | array  |  Y |  Multiple command queries, its content is a list composed of query objects  |
|  fieldTagDescNeeded  | boolean |   | Whether field or tag description information is needed |


2. Structure Explanation of `queries[*]` Member Parameters
*** Note, the `async_id` parameter has been added based on the "DQL Data Query" interface ***

| Parameter Name  | Type  | Required  | Description  |
| :------------- | :------------- | :------------- | :------------- |
| `async_id` | string  |  N |  Asynchronous query task ID, this value comes from the `content.data[*].async_id` in the previous DQL query result; if this value exists in the previous query response, it must be included in this query |
|  qtype | string  |  Y |  Query statement type <br/> dql: indicates a DQL type query statement; <br/> promql: indicates a PromQL type query statement   |
|  query | json  |  Y |  Query structure |
|  query.q  | string |   | Query statement consistent with the qtype, for example, a DQL or PromQL query statement |
|  query.promqlType  | enum |   | Effective when qtype=promql, PromQL query type, optional values are `instantQuery` and `rangeQuery`, default value is `rangeQuery` |
|  query.highlight  | boolean |   | Whether to display highlighted data |
|  query.timeRange  | array  |   | List of timestamps for time range |
|  query.disableMultipleField  | bool  |   | Whether to enable single-column mode, default is `true` |
|  query.showLabel  | bool  |   | Whether to display object labels, default is none |
|  query.funcList  | array  |   | Re-aggregates DQL return values, note that this parameter is invalid when disableMultipleField=False |
|  query.slimit  | integer  |   | Time series group size, only valid for metrics queries |
|  query.soffset  | integer  |   | Time series group offset |
|  query.limit  | integer  |   | Page size |
|  query.offset  | integer  |   | Page offset |
|  query.orderby  | array  |   | Sort list, `{fieldName:method}`, note that sorting for Mearsurement queries only supports fieldName=time; method in ["desc", "asc"]; note that sorting for Mearsurement queries only supports fieldName=time |
|  query.sorderby  | array  |   | Sort list, sorderby column is an expression supporting all aggregation functions that return a single value min max last avg p90 p95 count, `{fieldName:method}`, structure is the same as orderby |
|  query.order_by  | array  |   | Sort list, structure is `[{"column": "field", "order": "DESC"}]`, compatible with Doris engine fields |
|  query.sorder_by  | array  |   | Sort list, structure is `[{"column": "field", "order": "DESC"}]`, compatible with Doris engine fields |
|  query.density  | string  |   | Response point density, priority is less than autoDensity and greater than the density set in the DQL statement |
|  query.interval  | integer  |   | Unit is seconds, time slice interval used to calculate the number of response points; calculated number of points is less than or equal to the number of points when density=high, then it is valid, otherwise it is invalid |
|  query.search_after  | array  |   | Pagination query marker. The search_after value from the previous request response with identical parameters should be used as the parameter for this request. |
|  query.maxPointCount  | integer  |   | Maximum number of points |
|  query.workspaceUUID  | string  |   | UUID of the workspace to query |
|  query.workspaceUUIDs  | array  |   | UUIDs of the workspaces to query, takes precedence over query.workspaceUUID |
|  query.output_format  | string  |   | lineprotocol: line protocol output, defaults to existing output format if not specified |
|  query.cursor_time  | integer  |   | Segment query threshold: For the first segmented query, set cursor_time to end_time; for subsequent segmented queries, set cursor_time to next_cursor_time in the response |
|  query.disable_sampling  | bool  |   | Sampling disable switch, default value is false |


3. Explanation of Response Point Density `density` Parameter Values

| Optional Value  | Description  |
| :------------- | :------------- |
|  lower |  Low, 60 points  |
|  low   |  Lower, 180 points |
|  medium|   Medium, 360 points |
|  high  |  Higher, 720 points |

* Note the priority of the point density parameter, maximum density `density[high]` </br>
maxPointCount > interval > density > control parameters in the DQL statement   

4. Common Query Explanations

  - [Unrecovered Event Query](../../../studio-backend/unrecovered-event-query/)
</br>
Note: When performing data queries via the openapi interface, the default role is Administrator. Be aware that data access rules may apply.


## Response
```shell
 
```