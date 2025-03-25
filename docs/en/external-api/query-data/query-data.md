# [Data Query] DQL Data Query

---

<br />**POST /api/v1/df/{workspace_uuid}/query_data**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| workspace_uuid | string | Y | The uuid of the workspace for the query<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| sceneUUID | string |  | Scene UUID<br>Allow empty: False <br> |
| dashboardUUID | string |  | View UUID<br>Allow empty: False <br> |
| testTimeout | float |  | Timeout time for creating ban operations (valid in debug mode)<br>Allow empty: False <br> |
| queries | array |  | Multi-command query, its content is a list composed of query objects<br>Allow empty: False <br> |
| fieldTagDescNeeded | boolean |  | Whether to need field or tag description information<br>Allow empty: False <br> |
| expensiveQueryCheck | boolean |  | Whether to check wildcard left* situations<br>Allow empty: False <br> |
| dataQueryPreview | json |  | Data access preview function<br>Allow empty: False <br> |
| dataQueryPreview.maskFields | string |  | Desensitization fields, multiple fields separated by commas<br>Example: message,host <br>Allow empty: False <br>Allow empty string: True <br> |
| dataQueryPreview.reExprs | array |  | Regular expressions<br>Example: [{'name': 'jjj', 'reExpr': 'ss', 'enable': 0}, {'name': 'lll', 'reExpr': 'ss', 'enable': 1}] <br>Allow empty: False <br> |

## Parameter Additional Notes

*Query Description*

--------------

1. Field descriptions for elements in the `queries` array

| Parameter Name        | type  | Required  | Description          |
|----------------------|----------|----|------------------------|
| sceneUUID     | string  | Y | Scene UUID |
| dashboardUUID | string  | Y | View UUID |
| queries[*]    | string  | Y | Query List |

2. DQL JSON structure parameter description (`queries[*]` element)

* Basic Fields *

| Parameter Name  | type  | Required  | Description  |
| :------------ | :------------ | :------------ | :------------ |
| qtype | string  | Y | Type of the query statement <br/> dql: Indicates a DQL type query statement; <br/> promql: Indicates a PromQl type query statement   |
| query | json  | Y | Query structure |
| query.q  | string |  | Query statement consistent with the qtype type, such as dql or promql query statement |
| query.promqlType  | enum |  | Effective when qtype=promql, PromQL query type, optional values `instantQuery` and `rangeQuery`, default value is `rangeQuery` |
| query.highlight  | boolean |  | Whether to display highlighted data |
| query.timeRange  | array  |  | List of timestamps for the time range |
| query.disableMultipleField  | bool  |  | Whether to enable single-column mode, default is `true` |
| query.showLabel  | bool  |  | Whether to display object labels, default none |
| query.funcList  | array  |  | Re-aggregate modifiers for DQL return values, note that this parameter is invalid when disableMultipleField=False |
| query.slimit  | integer  |  | Time series grouping size, only effective for metrics queries |
| query.soffset  | integer  |  | Time series grouping offset |
| query.limit  | integer  |  | Page size |
| query.offset  | integer  |  | Page offset |
| query.orderby  | array  |  | Sort list, `{fieldName:method}` , Note that sorting for metrics queries only supports fieldName=time; method in ["desc", "asc"]; Note that sorting for metrics queries only supports fieldName=time |
| query.sorderby  | array  |  | Sort list, sorderby's column is an expression, supports all aggregation functions returning a single value min max last avg p90 p95 count, `{fieldName:method}`, same structure as orderby |
| query.order_by  | array  |  | Sort list, structure is [{"column": "field", "order": "DESC"}], Doris engine compatible field |
| query.sorder_by  | array  |  | Sort list, structure is [{"column": "field", "order": "DESC"}], Doris engine compatible field |
| query.density  | string  |  | Response point density, lower priority than autoDensity and higher than density set in the DQL statement |
| query.interval  | integer  |  | Unit is seconds, time slice interval used to calculate the number of response points; if the calculated number of points is less than or equal to the number of points when density=high, it is valid, otherwise invalid |
| query.search_after  | array  |  | Pagination marker, returned by the current interface pagination marker, used for input in the next request |
| query.maxPointCount  | integer  |  | Maximum number of points |
| query.workspaceUUID  | string  |  | The uuid of the workspace to be queried |
| query.output_format  | string  |  | lineprotocol: row protocol output, default remains unchanged if not specified |
| query.cursor_time  | integer  |  | Segment query threshold: Set cursor_time to end_time for the first segment query; for subsequent segment queries, set cursor_time to next_cursor_time in the response |
| query.disable_sampling  | bool  |  | Sampling disable switch, default value is false |

* Response point density `density` parameter value description *

| Optional Values  | Description  |
| :------------ | :------------ |
| lower | Lower, 60 points  |
| low   | Low, 180 points |
| medium| Medium, 360 points |
| high  | High, 720 points |

* Note the priority of the point density parameter, maximum density `density[high]` </br>
maxPointCount > interval > density > control parameters in the DQL statement

3. Common Query Descriptions

  - [Unrecovered Event Query](../../../studio-backend/unrecovered-event-query/)




## Response
```shell
 
```




</example>