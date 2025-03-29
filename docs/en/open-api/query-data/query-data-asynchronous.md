# Asynchronous DQL Data Query

---

<br />**POST /api/v1/df/asynchronous/query_data**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| queries | array |  | Multi-command query, its content is a list composed of query objects<br>Allow empty: False <br> |
| fieldTagDescNeeded | boolean |  | Whether to need field or tag description information<br>Allow empty: False <br> |

## Parameter Additional Explanation

*Query Description*

--------------

1. Parameter Description

| Parameter Name  | type  | Required  | Description  |
| :------------ | :------------ | :------------ | :------------ |
|  queries | array  |  Y |  Multi-command query, its content is a list composed of query objects  |
|  fieldTagDescNeeded  | boolean |   | Whether to need field or tag description information |


2. Structure Description of queries[\*] Member Parameters
*** Note, the `async_id` parameter has been added based on the "DQL Data Query" interface ***

| Parameter Name  | type  | Required  | Description  |
| :------------ | :------------ | :------------ | :------------ |
| `async_id` | string  |  N |  Asynchronous query task ID, this value comes from the content.data[\*].async_id in the previous DQL query result; if the previous query response contains this value, then this query must include this value |
|  qtype | string  |  Y |  Type of the query statement <br/> dql: Indicates a DQL type query statement; <br/> promql: Indicates a PromQl type query statement   |
|  query | json  |  Y |  Query structure |
|  query.q  | string |   | Query statement consistent with the qtype type, such as DQL or PromQL query statements |
|  query.ignore_cache  | boolean |   | Whether to disable cache for the query, default is false, which means using cache |
|  query.promqlType  | enum |   | Effective when qtype=promql, PromQL query type, optional values are `instantQuery` and `rangeQuery`, default value is `rangeQuery` |
|  query.highlight  | boolean |   | Whether to display highlighted data |
|  query.timeRange  | array  |   | List of timestamps for the time range |
|  query.disableMultipleField  | bool  |   | Whether to enable single-column mode, default is `true` |
|  query.showLabel  | bool  |   | Whether to display object labels, default is none |
|  query.funcList  | array  |   | Further aggregate and modify the return values of DQL, note that this parameter is invalid when disableMultipleField=False |
|  query.slimit  | integer  |   | Time series grouping size, only effective for Metrics queries |
|  query.soffset  | integer  |   | Time series grouping offset |
|  query.limit  | integer  |   | Page size |
|  query.offset  | integer  |   | Page offset |
|  query.orderby  | array  |   | Sorting list, `{fieldName:method}` , note that sorting for Measurement queries only supports fieldName=time; method in ["desc", "asc"]; note that sorting for Measurement queries only supports fieldName=time |
|  query.sorderby  | array  |   | Sorting list, sorderby's column is an expression supporting all aggregation functions that return a single value: min max last avg p90 p95 count, `{fieldName:method}`, structure is consistent with orderby |
|  query.order_by  | array  |   | Sorting list, structure is `[{"column": "field", "order": "DESC"}]`, Doris engine compatible field |
|  query.sorder_by  | array  |   | Sorting list, structure is `[{"column": "field", "order": "DESC"}]`, Doris engine compatible field |
|  query.density  | string  |   | Point density of the response, priority is less than autoDensity and greater than the density set in the DQL statement |
|  query.interval  | integer  |   | Unit is seconds, time slice interval used to calculate the number of response points; if the calculated number of points is less than or equal to the number of points when density=high, it is valid, otherwise invalid |
|  query.search_after  | array  |   | Pagination query marker. Use the search_after value from the previous request's response as the parameter for this request with identical parameters. |
|  query.maxPointCount  | integer  |   | Maximum number of points |
|  query.workspaceUUID  | string  |   | UUID of the workspace to be queried |
|  query.workspaceUUIDs  | array  |   | UUIDs of the workspaces to be queried, takes precedence over query.workspaceUUID |
|  query.output_format  | string  |   | lineprotocol: Line protocol output, default remains unchanged if not specified |
|  query.cursor_time  | integer  |   | Segment query threshold: When performing the first segment query, set cursor_time to end_time; for subsequent segment queries, set cursor_time to the next_cursor_time in the response |
|  query.disable_sampling  | bool  |   | Sampling disable switch, default value is false |


3. Description of Response Point Density `density` Parameter Values

| Optional Value  | Description  |
| :------------ | :------------ |
|  lower |  Lower, 60 points  |
|  low   |  Low, 180 points |
|  medium|   Medium, 360 points |
|  high  |  Low, 720 points |

* Note the priority of point density parameters, maximum density `density[high]` * </br>
maxPointCount > interval > density > control parameters in the DQL statement   

4. Common Query Descriptions

  - [Unrecovered Event Query](../../../studio-backend/unrecovered-event-query/)
</br>
Note: When performing data queries using the openapi interface, the default role is Administrator. Be aware that data access rules may apply restrictions.




## Response
```shell
 
```