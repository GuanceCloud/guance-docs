# DQL Data Query

---

<br />**POST /api/v1/df/query_data_v1**

## Overview
DQL data query



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| queries | array |  | Multi-command query, its content is a list composed of query objects<br>Allow null: False <br> |
| fieldTagDescNeeded | boolean |  | Whether field or tag description information is needed<br>Allow null: False <br> |

## Additional Parameter Explanation

*Query Description*

--------------

1. Parameter Explanation

| Parameter Name  | Type  | Required  | Description  |
| :------------ | :------------ | :------------ | :------------ |
|  queries | array  |  Y |  Multi-command query, its content is a list composed of query objects  |
|  fieldTagDescNeeded  | boolean |   | Whether field or tag description information is needed |


2. Structure Explanation for `queries[*]` Member Parameters

| Parameter Name  | Type  | Required  | Description  |
| :------------ | :------------ | :------------ | :------------ |
|  qtype | string  |  Y |  Query statement type <br/> dql: indicates a DQL type query statement; <br/> promql: indicates a PromQl type query statement   |
|  query | json  |  Y |  Query structure |
|  query.q  | string |   | Query statement consistent with the `qtype`, e.g., DQL or PromQL query statement |
|  query.promqlType  | enum |   | Effective when `qtype=promql`, PromQL query type, optional values `instantQuery` and `rangeQuery`, default value is `rangeQuery` |
|  query.highlight  | boolean |   | Whether to display highlighted data |
|  query.timeRange  | array  |   | List of timestamps for time range |
|  query.disableMultipleField  | bool  |   | Whether single-column mode is enabled, default is `true` |
|  query.showLabel  | bool  |   | Whether to show object labels, default is none |
|  query.funcList  | array  |   | Re-aggregates DQL return values, note that this parameter is invalid when `disableMultipleField=False` |
|  query.slimit  | integer  |   | Group size for time series, only effective for metrics queries |
|  query.soffset  | integer  |   | Offset for time series groups |
|  query.limit  | integer  |   | Page size |
|  query.offset  | integer  |   | Page offset |
|  query.orderby  | array  |   | Sorting list, `{fieldName:method}`, note that sorting for Measurement queries only supports `fieldName=time`; method in ["desc", "asc"]; note that sorting for Measurement queries only supports `fieldName=time` |
|  query.sorderby  | array  |   | Sorting list, `sorderby` column is an expression supporting all single-value aggregation functions min max last avg p90 p95 count, `{fieldName:method}`, structure is consistent with orderby |
|  query.order_by  | array  |   | Sorting list, structure is `[{"column": "field", "order": "DESC"}]`, compatible field for Doris engine |
|  query.sorder_by  | array  |   | Sorting list, structure is `[{"column": "field", "order": "DESC"}]`, compatible field for Doris engine |
|  query.density  | string  |   | Response point density, lower priority than `autoDensity` but higher than density set in DQL statement |
|  query.interval  | integer  |   | Unit is seconds, time slice interval used to calculate response points; if calculated point count is less than or equal to point count when `density=high`, it is valid, otherwise invalid |
|  query.search_after  | array  |   | Pagination query marker. Use the `search_after` value from the previous response as the parameter for the current request. |
|  query.maxPointCount  | integer  |   | Maximum number of points |
|  query.workspaceUUID  | string  |   | UUID of the workspace to be queried |
|  query.workspaceUUIDs  | array  |   | UUIDs of workspaces to be queried, higher priority than `query.workspaceUUID`. |
|  query.output_format  | string  |   | lineprotocol: row protocol output, default is existing output format unchanged if not specified |
|  query.cursor_time  | integer  |   | Segment query threshold: For the first segment query, set `cursor_time` to `end_time`; for subsequent segment queries, set `cursor_time` to `next_cursor_time` from the response |
|  query.disable_sampling  | bool  |   | Sampling disable switch, default value is false |


3. Explanation of Response Point Density `density` Parameter Values

| Optional Value  | Description  |
| :------------ | :------------ |
|  lower |  Low, 60 points  |
|  low   |  Low, 180 points |
|  medium|   Medium, 360 points |
|  high  |  High, 720 points |

* Note the priority of the point density parameter, maximum density `density[high]` * </br>
maxPointCount > interval > density > control parameters in DQL statement   

4. Common Query Explanations

  - [Unrecovered Event Query](../../../studio-backend/unrecovered-event-query/)

      </br>
Note: When performing data queries via openapi interface, the default role is Administrator. Be aware that it may be subject to data access rule restrictions.


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