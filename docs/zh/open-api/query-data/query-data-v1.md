# DQL数据查询

---

<br />**POST /api/v1/df/query_data_v1**

## 概述
DQL数据查询




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| queries | array |  | 多命令查询，其内容为 query 对象组成的列表<br>允许为空: False <br> |
| fieldTagDescNeeded | boolean |  | 是否需要field 或者tag描述信息<br>允许为空: False <br> |

## 参数补充说明

*查询说明*

--------------

1. 参数说明

* 基础字段*

| 参数名  | type  | 必选  | 说明  |
| :------------ | :------------ | :------------ | :------------ |
|  queries | array  |  Y |  多命令查询，其内容为 query 对象组成的列表  |
|  fieldTagDescNeeded  | boolean |   | 是否需要field 或者tag描述信息 |


3. queries[\*]成员参数结构说明

* 基础字段*

| 参数名  | type  | 必选  | 说明  |
| :------------ | :------------ | :------------ | :------------ |
|  qtype | string  |  Y |  查询语句的类型 <br/> dql: 表示dql类型查询语句; <br/> promql: 表示 PromQl类型查询语句   |
|  query | json  |  Y |  查询结构 |
|  query.q  | string |   | 与 qtype 类型保持一致的 查询语句，例如 dql 或者 promql 查询语句|
|  query.highlight  | boolean |   | 是否显示高亮数据 |
|  query.timeRange  | array  |   | 时间范围的时间戳列表 |
|  query.disableMultipleField  | bool  |   | 是否打开单列模式，默认为 `true` |
|  query.showLabel  | bool  |   | 是否显示对象的lables，默认无 |
|  query.funcList  | array  |   | 再次聚合修饰dql返回值，注意 disableMultipleField=Flse时, 当前参数无效 |
|  query.slimit  | integer  |   | 时间线分组大小，只针对指标查询有效 |
|  query.soffset  | integer  |   | 时间线分组偏移量 |
|  query.limit  | integer  |   | 分页大小 |
|  query.offset  | integer  |   | 分页偏移量 |
|  query.orderby  | array  |   | 排序列表，`{fieldName:method}` , 注意指标集查询的排序只支持 fieldName=time; method in ["desc", "asc"];注意指标集查询的排序只支持 fieldName=time|
|  query.density  | string  |   | 响应的点密度, 优先级小于 autoDensity 且大于 dql语句中设置的密度 |
|  query.interval  | integer  |   | 单位是秒，时间分片间隔，用于计算响应点数；计算出的点数小于等于density=high时的点数，则有效，否则无效|
|  query.search_after  | array  |   | 分页查询标记。相同参数上次请求响应结果中的 search_after 值作为本次请求的参数。|
|  query.maxPointCount  | integer  |   | 最大点数 |
|  query.workspaceUUID  | string  |   | 要查询工作空间的uuid |
|  query.output_format  | string  |   | lineprotocol: 行协议输出，默认不填的话，默认保持现有输出格式不变 |
|  query.cursor_time  | integer  |   | 分段查询阀值: 第一次分段查询时，需要把 cursor_time 设置为 end_time；之后的分段查询，需要把 cursor_time 设置为响应中的 next_cursor_time |
|  query.disable_sampling  | bool  |   | 采样禁用开关, 默认值为 false |


4. 响应点密度`density` 参数值说明

| 可选值  | 说明  |
| :------------ | :------------ |
|  lower |  较低，60个点  |
|  low   |  低，180个点 |
|  medium|   中等，360个点 |
|  high  |  低，720个点 |

* 注意点密度参数的优先级，最大密度`density[high]` *
maxPointCount > interval > density > dql语句中的控制参数   




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/df/query_data' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"queries":[{"qtype":"dql","query":{"q":"L::re(`.*`):(`*`){ `index` IN [\'default\'] }","limit":50,"orderby":[{"time":"desc"}],"_funcList":[],"funcList":[],"disableMultipleField":false,"align_time":false,"offset":0,"search_after":[],"cursor_time":1697700766999,"timeRange":[1697699866000,1697700766999],"tz":"Asia/Shanghai"}}]}' \
--compressed
```




## 响应
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



