# DQL Data Query

---

<br />**POST /api/v1/df/query_data_v1**

## Overview
DQL data query



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| queries              | array    |            | Multi-command query, its content is a list composed of query objects<br>Allow empty: False <br> |
| fieldTagDescNeeded   | boolean  |            | Whether field or tag description information is needed<br>Allow empty: False <br> |

## Parameter Additional Explanation

*Query Description*

--------------

1. Parameter Description

| Parameter Name  | Type   | Required | Description  |
| :------------- | :----- | :------- | :----------- |
| queries         | array  | Y        | Multi-command query, its content is a list composed of query objects  |
| fieldTagDescNeeded | boolean |           | Whether field or tag description information is needed |


2. Structure Description for `queries[*]` Member Parameters

| Parameter Name  | Type   | Required | Description  |
| :------------- | :----- | :------- | :----------- |
| qtype          | string | Y        | The type of the query statement <br/> dql: Indicates a DQL type query statement; <br/> promql: Indicates a PromQL type query statement   |
| query          | json   | Y        | Query structure |
| query.q        | string |          | Query statement consistent with the qtype type, such as DQL or PromQL query statements |
| query.ignore_cache | boolean |      | Whether to disable cache for the query, default is false, meaning use cache |
| query.promqlType | enum   |       | Effective when qtype=promql, PromQL query type, optional values are `instantQuery` and `rangeQuery`, default value is `rangeQuery` |
| query.highlight | boolean |       | Whether to display highlighted data |
| query.timeRange | array  |       | List of timestamps for the time range |
| query.disableMultipleField | bool |       | Whether to enable single-column mode, default is `true` |
| query.showLabel | bool   |       | Whether to display object labels, default is none |
| query.funcList | array  |       | Re-aggregate the returned values of DQL, note that this parameter is invalid when disableMultipleField=False |
| query.slimit    | integer |       | Group size for the timeline, only valid for Metrics queries |
| query.soffset   | integer |       | Offset for the timeline grouping |
| query.limit     | integer |       | Page size |
| query.offset    | integer |       | Page offset |
| query.orderby   | array  |       | Sorting list, `{fieldName:method}` , note that sorting for Measurement queries only supports fieldName=time; method in ["desc", "asc"]; note that sorting for Measurement queries only supports fieldName=time |
| query.sorderby  | array  |       | Sorting list, sorderby's column is an expression, all aggregation functions returning a single value are supported: min max last avg p90 p95 count, `{fieldName:method}`, structure is the same as orderby |
| query.order_by  | array  |       | Sorting list, structure is `[{"column": "field", "order": "DESC"}]`, Doris engine compatible field |
| query.sorder_by | array  |       | Sorting list, structure is `[{"column": "field", "order": "DESC"}]`, Doris engine compatible field |
| query.density   | string |       | Response point density, priority is less than autoDensity and greater than the density set in the DQL statement |
| query.interval  | integer |       | Unit is seconds, time slice interval, used to calculate the number of response points; if the calculated number of points is less than or equal to the number of points when density=high, it is valid, otherwise it is invalid |
| query.search_after | array |       | Pagination query marker. Use the search_after value from the response of the previous request with the same parameters as the parameter for this request. |
| query.maxPointCount | integer |    | Maximum number of points |
| query.workspaceUUID | string |     | UUID of the workspace to be queried |
| query.workspaceUUIDs | array |     | UUIDs of the workspaces to be queried, takes precedence over query.workspaceUUID. |
| query.output_format | string |     | lineprotocol: row protocol output, if not specified, the existing output format remains unchanged by default |
| query.cursor_time | integer |     | Segment query threshold: When performing the first segment query, set cursor_time to end_time; for subsequent segment queries, set cursor_time to next_cursor_time in the response |
| query.disable_sampling | bool |     | Sampling disable switch, default value is false |


3. Explanation of the Response Point Density `density` Parameter Values

| Optional Value | Description |
| :------------ | :---------- |
| lower         | Lower, 60 points |
| low           | Low, 180 points |
| medium        | Medium, 360 points |
| high          | High, 720 points |

* Note the priority of the point density parameter, maximum density `density[high]` </br>
maxPointCount > interval > density > control parameters in the DQL statement  

4. Common Query Descriptions

  - [Unrecovered Event Query](../../../studio-backend/unrecovered-event-query/)

      </br>
Note: When performing data queries via the OpenAPI interface, the default role is Administrator. Be aware that data access may be restricted by data access rules.



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/df/query_data_v1' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"queries":[{"qtype":"dql","query":{"q":"M::`cpu`:(avg(`usage_idle`))","_funcList":[],"funcList":[],"maxPointCount":720,"interval":10,"align_time":true,"sorder_by":[{"column":"`#1`","order":"DESC"}],"slimit":20,"disable_sampling":false,"timeRange":[1708911106000,1708912906999],"tz":"Asia/Shanghai"}}]}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "async_id": "",
                "column_names": [
                    "avg(usage_idle)"
                ],
                "complete": false,
                "cost": "14.815745ms",
                "index_name": "",
                "index_names": "",
                "index_store_type": "",
                "interval": 10000,
                "is_running": false,
                "max_point": 181,
                "next_cursor_time": -1,
                "points": null,
                "query_parse": {
                    "fields": {
                        "avg(usage_idle)": "usage_idle"
                    },
                    "funcs": {
                        "avg(usage_idle)": [
                            "avg"
                        ]
                    },
                    "namespace": "metric",
                    "sources": {
                        "cpu": "exact"
                    }
                },
                "query_type": "guancedb",
                "sample": 1,
                "scan_completed": false,
                "scan_index": "",
                "series": [
                    {
                        "columns": [
                            "time",
                            "avg(usage_idle)"
                        ],
                        "name": "cpu",
                        "units": [
                            null,
                            null
                        ],
                        "values": [
                            [
                                1708912900000,
                                75.68748278863335
                            ],
                            [
                                1708912890000,
                                80.20737341208
                            ],
                            [
                                1708912880000,
                                73.23943236630001
                            ],
                            [
                                1708912870000,
                                71.08465385756001
                            ],
                            [
                                1708912860000,
                                75.12657005472002
                            ],
                            [
                                1708912850000,
                                84.19848645072001
                            ],
                            [
                                1708912840000,
                                81.59161169702
                            ],
                            [
                                1708912830000,
                                77.14274451154
                            ]
                        ]
                    }
                ],
                "window": 10000
            }
        ],
        "declaration": {
            "b": [
                "asfawfgajfasfafgafwba",
                "asfgahjfaf"
            ],
            "business": "aaa",
            "organization": "6540c09e4243b300077a9675"
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "10888927517520616916"
} 
```