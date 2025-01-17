# 服务数据源定义及 DQL 查询

## 服务性能数据源定义 {#tm-definitions}

`TM` 索引空间中保存了服务列表及性能指标相关数据，页面 [应用性能监测 - 性能指标](https://console.guance.com/tracing/service/performance){:target="_blank"} 上的数据即主要查询于该索引空间，TM` 对每个服务按照分钟、小时和天三个不同粒度对服务指标数据进行了聚合，以提升数据的查询效率。

比如查询 `2024-03-19 15:00:00` ～ `2024-03-19 15:15:00` 15分钟内的所有服务指标数据，可以使用 DQL：

```dql
TM::`*`:(){source="service_list_1m"} [1710831600000:1710832500000]
```

将返回类似如下的结果：

<!-- markdownlint-disable MD046 -->
???- note "返回示例"(单击以展开)

    ```json
    [
      {
        "time": 1710835681000,
        "time_us": 1710835681000000,
        "__docid": "T_cnskg71jdosvib6m44s0",
        "__source": "service_list_1m",
        "source": "service_list_1m",
        "__namespace": "tracing",
        "r_env": "demo",
        "r_error_count": 0,
        "r_max_duration": 2293857,
        "r_psketch": "Av1KgVq/UvA/AAAAAAAAAAAJAbgL",
        "r_request_count": 1,
        "r_resp_time": 2293857,
        "r_service": "go-profiling-demo-1",
        "r_service_sub": "go-profiling-demo-1:demo:v0.8.888",
        "r_type": "custom",
        "r_version": "v0.8.888",
        "create_time": 1710835740447,
        "date": 1710835681000,
        "date_ns": 0
      },
      {
        "time": 1710835201000,
        "time_us": 1710835201000000,
        "__docid": "T_cnskcf9jdosvib6jl4kg",
        "__source": "service_list_1m",
        "source": "service_list_1m",
        "__namespace": "tracing",
        "r_env": "demo",
        "r_error_count": 0,
        "r_max_duration": 2370648,
        "r_psketch": "Av1KgVq/UvA/AAAAAAAAAAAJAboL",
        "r_request_count": 1,
        "r_resp_time": 2370648,
        "r_service": "go-profiling-demo-1",
        "r_service_sub": "go-profiling-demo-1:demo:v0.8.888",
        "r_type": "custom",
        "r_version": "v0.8.888",
        "create_time": 1710835261477,
        "date": 1710835201000,
        "date_ns": 0
      }
    ]
    ```
<!-- markdownlint-enable -->

其中主要的字段说明如下：

| 字段              | 类型     | 说明                                                                                                                                        |
|-----------------|--------|-------------------------------------------------------------------------------------------------------------------------------------------|
| source          | string | 数据聚合的粒度，分为每分钟（source="service_list_1m")，每小时（source="service_list_1h"） 和每天（source="service_list_1d"）                                       |
| r_env           | string | 服务部署的环境                                                                                                                                   |
| r_error_count   | int    | 服务出错次数                                                                                                                                    |
| r_max_duration  | int    | 时间粒度内的最大响应时间，单位：微秒                                                                                                                        |
| r_request_count | int    | 请求次数                                                                                                                                      |
| r_resp_time     | int    | 时间粒度内汇总的响应时间总和                                                                                                                            |
| r_service       | string | 服务名称                                                                                                                                      |
| r_service_sub   | string | <服务名称>:<部署环境>:<服务版本>                                                                                                                      |
| r_type          | string | 服务类型，http/web/db/gateway...                                                                                                               |
| r_version       | string | 服务版本                                                                                                                                      |
| date            | int    | 毫秒时间戳，对应每分钟的零秒(hh:mm:00，当source="service_list_1m"时)，每小时的零分（hh:00， 当source="service_list_1h"时），每天的零点（00:00:00， 当source="service_list_1d"时） |

同理，查询 `2024-03-19 15:00:00` ～ `2024-03-19 17:00:00` 两个小时的数据，可以使用 DQL：

```dql
TM::`*`:(){source="service_list_1h"} [1710831600000:1710838800000]
```

查询 `2024-03-19 00:00:00` ～ `2024-03-21 00:00:00` 两天的数据，可以使用 DQL：

```dql
TM::`*`:(){source="service_list_1d"} [1710777600000:1710950400000]
```

不同时间粒度可以组合使用，比如查询 `2024-03-19 15:00:00` ～ `2024-03-19 17:30:00` 两个半小时内的数据，可以使用 DQL：

```dql
TM::`*`:(){ (source="service_list_1h" and date >= 1710831600000 and date < 1710838800000) or (source="service_list_1m" and date >= 1710838800000 and date <= 1710840600000) }
```

<!-- markdownlint-disable MD046 -->
???+ note

    当然这里也可以仅使用分钟纬度 source="service_list_1m" 来查询类似 `2024-03-19 15:00:00` ～ `2024-03-19 17:30:00` 整个跨小时或跨天的时间范围内数据，但查询效率会大大降低，返回的数据量也会成倍增长，所以非常不建议这样查询。
<!-- markdownlint-enable -->

对查询结果再进行二次加工便可以计算出相关服务级别的指标，例如：

```
total_count = SUM(r_request_count)
error_count = SUM(r_error_count)
error_rate = SUM(r_error_count) / SUM(r_request_count)
max_duration = MAX(r_max_duration)
sum_resp_time = SUM(r_resp_time)
avg_per_second = SUM(r_request_count) / <查询的时间范围>
avg_resp_time = SUM(r_resp_time) / SUM(r_request_count)
p50: 生成数组 [(r_resp_time1/r_request_count1)...{重复r_request_count1次}, (r_resp_time2/r_request_count2)...{重复r_request_count2次}, (r_resp_time3/r_request_count3)...{重复r_request_count3次}, ...]，数组排序后取索引 SUM(r_request_count)*0.5
```

例如查询各服务一段时间范围内的 QPS（每秒请求数） 可以使用：

```dql
TM::`*`:(r_service, sum(r_request_count) / (1737099000000 - 1737093600000) * 1000 as QPS){ (source="service_list_1h" and date >= 1737093600000 and date < 1737097200000) or (source="service_list_1m" and date >= 1737097200000 and date <= 1737099000000) } by r_service
```

## 服务拓扑数据源定义 {#tsm-definitions}

`TSM` 索引空间中主要保存了服务之间的调用拓扑关系数据，以分钟为纬度进行了数据的预聚合，比如查询 `2024-03-19 15:00:00` ～ `2024-03-19 15:15:00` 15分钟范围内的所有服务调用关系，可以使用 DQL：

```
TSM::`*`:(){} [1710831600000:1710832500000]
```

返回类似如下的查询结果：

<!-- markdownlint-disable MD046 -->
???- note "返回示例"(单击以展开)
    ```json
    [
        {
            "time": 1710835700438,
            "time_us": 1710835700438064,
            "__docid": "6340252d-331c-6e1dd9338-0ed04e818c4d",
            "__source": "relationship",
            "source_service": "go-profiling-demo-1",
            "source_wsuuid": "wksp_8d351d83bdf14b8b8270ab75fe29a990",
            "source_env": "demo",
            "source_project": "",
            "source_version": "v0.8.888",
            "source_type": "custom",
            "source_organization": "",
            "source_status": "ok",
            "source_start": 1710835700059433,
            "source_duration": 220210272,
            "target_service": "go-profiling-demo-2",
            "target_wsuuid": "wksp_8d351d83bdf14b8b8270ab75fe29a990",
            "target_env": "demo",
            "target_project": "",
            "target_version": "v0.8.888",
            "target_type": "custom",
            "target_organization": "",
            "target_status": "ok",
            "target_start": 1710835700438064,
            "target_duration": 886040,
            "count": 96,
            "unique_id": "XTzHH-jScNjXgBSXNIdFcSOVpHwWKyAZroh71ttyPnXK9nl3jW0re0hlKOeHj6PYgo-profiling-demo-1go-profiling-demo-2",
            "unique_id_env_version": "Zp-9KKvEb4m9aU0OeUMon8MiH2isxqXU742YFlVtokgL2Vy73NwtykkG3vA3X0z1go-profiling-demo-1go-profiling-demo-2",
            "error_count": 0
        },
        {
            "time": 1710835243699,
            "time_us": 1710835243699376,
            "__docid": "f4c7de67-ca1b-6e17fd78e-e8bcb4d1d64d",
            "__source": "relationship",
            "source_service": "go-profiling-demo-1",
            "source_wsuuid": "wksp_8d351d83bdf14b8b8270ab75fe29a990",
            "source_env": "demo",
            "source_project": "",
            "source_version": "v0.8.888",
            "source_type": "custom",
            "source_organization": "",
            "source_status": "ok",
            "source_start": 1710835243379392,
            "source_duration": 227582208,
            "target_service": "go-profiling-demo-2",
            "target_wsuuid": "wksp_8d351d83bdf14b8b8270ab75fe29a990",
            "target_env": "demo",
            "target_project": "",
            "target_version": "v0.8.888",
            "target_type": "custom",
            "target_organization": "",
            "target_status": "ok",
            "target_start": 1710835243699376,
            "target_duration": 856217,
            "count": 96,
            "unique_id": "XTzHH-jScNjXgBSXNIdFcSOVpHwWKyAZroh71ttyPnXK9nl3jW0re0hlKOeHj6PYgo-profiling-demo-1go-profiling-demo-2",
            "unique_id_env_version": "Zp-9KKvEb4m9aU0OeUMon8MiH2isxqXU742YFlVtokgL2Vy73NwtykkG3vA3X0z1go-profiling-demo-1go-profiling-demo-2",
            "error_count": 0
        }
    ]
    ```
<!-- markdownlint-enable -->

主要字段说明如下：

| 字段                    | 类型     | 说明                             |
|-----------------------|--------|--------------------------------|
| time                  | int    | 毫秒时间戳，服务调用产生的时间                |
| time_us               | int    | 服务调用产生的时间，微秒级别                 |
| source_service        | string | 主调服务名称                         |
| source_wsuuid         | string | 主调服务上报空间ID                     |
| source_env            | string | 主调服务部署环境                       |
| source_project        | string | 主调服务项目名称                       |
| source_version        | string | 主调服务版本                         |
| source_type           | string | 主调服务类型                         |
| source_organization   | string | 主调服务上报空间所在的组织                  |
| source_status         | string | 主调服务状态，ok/error                |
| source_start          | int    | 主调服务span开始时间，微秒时间戳             |
| source_duration       | int    | 每分钟内主调服务span持续时间汇总，单位：微秒       |
| target_service        | string | 被调服务名称                         |
| target_wsuuid         | string | 被调服务上报空间ID                     |
| target_env            | string | 被调服务部署环境                       |
| target_project        | string | 被调服务项目名称                       |
| target_version        | string | 被调服务版本                         |
| target_type           | string | 被调服务类型                         |
| target_organization   | string | 被调服务上报空间所在组织                   |
| target_status         | string | 被调服务状态，ok/error                |
| target_start          | int    | 被调服务span开始时间（服务调用产生的时间），微秒时间戳  |
| target_duration       | int    | 每分钟粒度内被调服务span持续时间汇总，单位：微秒     |
| count                 | int    | 每分钟粒度内调用次数                     |
| unique_id             | string | 仅由主调服务名称和被调服务名称生成的唯一ID         |
| unique_id_env_version | int    | 区分主调服务、环境、版本和被调服务、环境、版本生成的唯一ID |
| error_count           | int    | 每分钟粒度内调用失败次数                   |

对于服务调用关系以及服务调用级别的指标，比如可以使用如下 DQL 来查询服务之间的调用关系：

```dql
TSM::`*`:(first(source_service) as source_service,
first(source_wsuuid) as source_wsuuid,
first(target_service) as target_service,
first(target_wsuuid) as target_wsuuid,
sum(count) as total_count,
sum(error_count) as total_error_count,
sum(target_duration) as total_duration
){} by unique_id
```
