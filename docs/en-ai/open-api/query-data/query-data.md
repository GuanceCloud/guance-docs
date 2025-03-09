# DQL Data Query (Legacy)

---

<br />**POST /api/v1/df/query_data**

## Overview
DQL data query



## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| body | string |  | DQL query structure<br>Allow empty: False <br> |
| queries_body | string |  | DQL query structure (deprecated on 2023-08-11)<br>Allow empty: False <br> |
| search_after | string |  | Pagination query parameter (deprecated on 2023-08-11)<br>Allow empty: False <br> |

## Additional Parameter Notes

*Query Description*

--------------

1. Query String Element Field Description

| Parameter Name        | Type  | Required | Description          |
|---------------|----------|----|------------------------|
| body    | string  | Y | Query request body |
| queries_body[\*]    | string  |   | (Deprecated parameter, removed on 2023-08-10) Query list |
| search_after    | string  |   | (Deprecated parameter, moved to the query structure in the new version on 2023-08-10) Query pagination data. Default is [], for subsequent pagination data, add the `search_after` field from the previous query results to query more data |

2. JSON Structure Parameter Description in `body`

| Parameter Name  | Type  | Required  | Description  |
| :------------ | :------------ | :------------ | :------------ |
| queries | array  | Y | Multi-command query, its content is a list of query objects |
| fieldTagDescNeeded  | boolean |   | Whether to include field or tag description information |

3. Member Parameter Structure Description of `queries[\*]`

| Parameter Name  | Type  | Required  | Description  |
| :------------ | :------------ | :------------ | :------------ |
| qtype | string  | Y | Query statement type <br/> dql: Indicates a DQL type query statement; <br/> promql: Indicates a PromQL type query statement |
| query | json  | Y | Query structure |
| query.q  | string |   | Query statement consistent with `qtype`, e.g., DQL or PromQL query statement |
| query.promqlType  | enum |   | Effective when `qtype=promql`, PromQL query type, optional values `instantQuery` and `rangeQuery`, default value `rangeQuery` |
| query.highlight  | boolean |   | Whether to show highlighted data |
| query.timeRange  | array  |   | List of timestamps for time range |
| query.disableMultipleField  | bool  |   | Whether to enable single column mode, default `true` |
| query.showLabel  | bool  |   | Whether to show object labels, default no label |
| query.funcList  | array  |   | Re-aggregates DQL return values, note this parameter is invalid when `disableMultipleField=False` |
| query.slimit  | integer  |   | Time series group size, only effective for metrics queries |
| query.soffset  | integer  |   | Time series group offset |
| query.limit  | integer  |   | Page size |
| query.offset  | integer  |   | Page offset |
| query.orderby  | array  |   | Sorting list, `{fieldName:method}`, note that sorting for measurements only supports `fieldName=time`; methods are ["desc", "asc"]; note that sorting for measurements only supports `fieldName=time` |
| query.density  | string  |   | Response point density, lower priority than `autoDensity` and higher than the density set in the DQL statement |
| query.interval  | integer  |   | Unit is seconds, time slice interval used to calculate response points; if calculated points are less than or equal to the number of points when `density=high`, it is valid, otherwise invalid |
| query.search_after  | array  |   | Pagination marker, returned by the current interface, used for the next request |
| query.maxPointCount  | integer  |   | Maximum number of points |
| query.workspaceUUID  | string  |   | UUID of the workspace to query |
| query.workspaceUUIDs  | array  |   | UUIDs of workspaces to query, higher priority than `query.workspaceUUID` |
| query.output_format  | string  |   | lineprotocol: Line protocol output, defaults to existing output format if not specified |
| query.cursor_time  | integer  |   | Segment query threshold: For the first segment query, set `cursor_time` to `end_time`; for subsequent segment queries, set `cursor_time` to the `next_cursor_time` in the response |
| query.disable_sampling  | bool  |   | Sampling disable switch, default `false` |

4. Explanation of Response Point Density `density` Parameter Values

| Option  | Description  |
| :------------ | :------------ |
| lower | Low, 60 points |
| low   | Low, 180 points |
| medium| Medium, 360 points |
| high  | High, 720 points |

* Note the priority of the point density parameter, the highest density `density[high]` </br>
maxPointCount > interval > density > control parameters in the DQL statement   

5. Common Query Descriptions

  - [Unresolved Event Query](../../../studio-backend/unrecovered-event-query/)

</br>
Note: When performing data queries using the openapi interface, the default role is Administrator. Be aware that data access may be restricted by data access rules.

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/df/query_data?body=\{%22queries%22:\[\{%22uuid%22:%2205ea25f0-2fa3-11ee-aa03-57233270ef0c%22,%22qtype%22:%22dql%22,%22query%22:\{%22q%22:%22L::re(`.*`):(`*`)\{+`index`+IN+\[%27default%27\]+\}%22,%22highlight%22:true,%22limit%22:50,%22orderby%22:\[\{%22time%22:%22desc%22\}\],%22_funcList%22:\[\],%22funcList%22:\[\],%22disableMultipleField%22:false,%22align_time%22:false,%22is_optimized%22:true,%22offset%22:0,%22search_after%22:\[1690808645037,538070,%22L_1690808645037_cj3r2itnel8fnfu5tlag%22\],%22timeRange%22:\[1690807857000,1690808757999\],%22tz%22:%22Asia/Shanghai%22\}\}\],%22expensiveQueryCheck%22:true\}' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```

## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "AsyncTaskPayload": null,
                "async_id": "",
                "column_names": [
                    "container_id",
                    "source",
                    "filepath",
                    "image",
                    "index",
                    "df_metering_size",
                    "__namespace",
                    "host",
                    "log_read_offset",
                    "__docid",
                    "filename",
                    "service",
                    "image_name",
                    "image_short_name",
                    "image_tag",
                    "log_read_lines",
                    "message",
                    "log_read_time",
                    "container_name",
                    "container_type",
                    "message_length",
                    "create_time",
                    "container_runtime_name",
                    "date_ns",
                    "status"
                ],
                "complete": false,
                "cost": "19ms",
                "index_name": "",
                "index_names": "",
                "index_store_type": "es",
                "is_running": false,
                "points": null,
                "query_type": "",
                "raw_query": "{\\\"aggs\\\":{},\\\"_source\\\":{\\\"excludes\\\":[\\\"message@json\\\"],\\\"includes\\\":[]},\\\"query\\\":{\\\"bool\\\":{\\\"filter\\\":[{\\\"term\\\":{\\\"__namespace\\\":\\\"logging\\\"}},{\\\"range\\\":{\\\"date\\\":{\\\"gte\\\":\\\"1680187562081\\\",\\\"lte\\\":\\\"1680230762081\\\"}}},{\\\"bool\\\":{\\\"should\\\":[{\\\"terms\\\":{\\\"index\\\":[\\\"default\\\"]}}]}}]}},\\\"size\\\":50,\\\"sort\\\":[{\\\"date\\\":{\\\"missing\\\":\\\"_last\\\",\\\"order\\\":\\\"desc\\\",\\\"unmapped_type\\\":\\\"long\\\"}},{\\\"date_ns\\\":{\\\"missing\\\":\\\"_last\\\",\\\"order\\\":\\\"desc\\\",\\\"unmapped_type\\\":\\\"long\\\"}},{\\\"__docid\\\":{\\\"missing\\\":\\\"_first\\\",\\\"order\\\":\\\"desc\\\",\\\"unmapped_type\\\":\\\"string\\\"}}],\\\"search_after\\\":[1680226330509,8572,\\\"L_1680226330509_cgj4hqbrhi85kl1m6os0\\\"],\\\"timeout\\\":\\\"54s\\\"}",
                "search_after": [
                    1680226330508,
                    82936,
                    "L_1680226330508_cgj4hbdepb7fcn07sf60"
                ],
                "series": [
                    {
                        "columns": [
                            "container_id",
                            "time",
                            "source",
                            "filepath",
                            "image",
                            "index",
                            "df_metering_size",
                            "__namespace",
                            "host",
                            "log_read_offset",
                            "__docid",
                            "filename",
                            "service",
                            "image_name",
                            "image_short_name",
                            "image_tag",
                            "log_read_lines",
                            "message",
                            "log_read_time",
                            "container_name",
                            "container_type",
                            "message_length",
                            "create_time",
                            "container_runtime_name",
                            "date_ns",
                            "status"
                        ],
                        "values": [
                            [
                                "2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380",
                                1680226330509,
                                "test",
                                "/var/lib/docker/containers/2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380/2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380-json.log",
                                "test:test",
                                "default",
                                1,
                                "logging",
                                "izbp152ke14timzud0du15z",
                                149232879,
                                "L_1680226330509_cgj4hqbrhi85kl1m6org",
                                "2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380-json.log",
                                "test",
                                "test",
                                "test",
                                "test",
                                147890,
                                "ddtrace.profiling.exporter.http.UploadFailed: [Errno 101] Network is unreachable",
                                1680226330508872700,
                                "compose_python_ddtrace_web_b_1",
                                "docker",
                                80,
                                1680230633485,
                                "compose_python_ddtrace_web_b_1",
                                8571,
                                "unknown"
                            ],
                            [
                                "2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380",
                                1680226330509,
                                "test",
                                "/var/lib/docker/containers/2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380/2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380-json.log",
                                "test:test",
                                "default",
                                1,
                                "logging",
                                "izbp152ke14timzud0du15z",
                                149232879,
                                "L_1680226330509_cgj4hqbrhi85kl1m6or0",
                                "2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380-json.log",
                                "test",
                                "test",
                                "test",
                                "test",
                                147889,
                                "    raise retry_exc from fut.exception()",
                                1680226330508872700,
                                "compose_python_ddtrace_web_b_1",
                                "docker",
                                40,
                                1680230633485,
                                "compose_python_ddtrace_web_b_1",
                                8570,
                                "unknown"
                            ],
                            [
                                "2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380",
                                1680226330509,
                                "test",
                                "/var/lib/docker/containers/2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380/2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380-json.log",
                                "test:test",
                                "default",
                                1,
                                "logging",
                                "izbp152ke14timzud0du15z",
                                149232879,
                                "L_1680226330509_cgj4hqbrhi85kl1m6oqg",
                                "2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380-json.log",
                                "test",
                                "test",
                                "test",
                                "test",
                                147888,
                                "  File \\\"/usr/local/lib/python3.7/site-packages/tenacity/__init__.py\\\", line 361, in iter",
                                1680226330508872700,
                                "compose_python_ddtrace_web_b_1",
                                "docker",
                                87,
                                1680230633485,
                                "compose_python_ddtrace_web_b_1",
                                8569,
                                "unknown"
                            ],
                            [
                                "2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380",
                                1680226330508,
                                "test",
                                "/var/lib/docker/containers/2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380/2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380-json.log",
                                "test:test",
                                "default",
                                1,
                                "logging",
                                "izbp152ke14timzud0du15z",
                                149228783,
                                "L_1680226330508_cgj4hbdepb7fcn07sf60",
                                "2fef685801c80b5cb7d04b7b5e859007de94752aadbe801df812a058acf5e380-json.log",
                                "test",
                                "test",
                                "test",
                                "test",
                                147841,
                                "KeyError: 'dd.service'",
                                1680226330507918000,
                                "compose_python_ddtrace_web_b_1",
                                "docker",
                                22,
                                1680230573234,
                                "compose_python_ddtrace_web_b_1",
                                82936,
                                "unknown"
                            ]
                        ]
                    }
                ],
                "total_hits": 10000
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-CD50CBBD-E29B-4F58-BD6B-618EED50920A"
}
```