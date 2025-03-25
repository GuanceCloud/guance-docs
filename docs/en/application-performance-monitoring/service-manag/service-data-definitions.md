# Definition of Service Data Sources and DQL Queries

## Definition of Service Performance Data Source {#tm-definitions}

The `TM` index space stores data related to service lists and performance metrics. The data on the [APM - Performance Metrics](https://<<< custom_key.studio_main_site >>>/tracing/service/performance){:target="_blank"} page is primarily queried from this index space. TM aggregates service metric data at three different granularities: minutes, hours, and days, to improve query efficiency.

For example, to query all service metric data within a 15-minute period from `2024-03-19 15:00:00` to `2024-03-19 15:15:00`, you can use DQL:

```dql
TM::`*`:(){source="service_list_1m"} [1710831600000:1710832500000]
```

This will return results similar to the following:

<!-- markdownlint-disable MD046 -->
???- note "Example of Query Results (Click to Expand)"
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

Below are explanations for the main fields:

| Field              | Type     | Description                                                                                                                                        |
|-----------------|--------|-------------------------------------------------------------------------------------------------------------------------------------------|
| source          | string | Aggregation granularity of the data, divided into every minute (source="service_list_1m"), every hour (source="service_list_1h") and every day (source="service_list_1d").                                       |
| r_env           | string | Deployment environment of the service                                                                                                                                   |
| r_error_count   | int    | Number of service errors                                                                                                                                    |
| r_max_duration  | int    | Maximum response time within the time granularity, unit: microseconds                                                                                                                        |
| r_request_count | int    | Number of requests                                                                                                                                      |
| r_resp_time     | int    | Total aggregated response time within the time granularity                                                                                                                            |
| r_service       | string | Service name                                                                                                                                      |
| r_service_sub   | string | <Service Name>:<Deployment Environment>:<Service Version>                                                                                                                      |
| r_type          | string | Service type, http/web/db/gateway...                                                                                                               |
| r_version       | string | Service version                                                                                                                                      |
| date            | int    | Milliseconds timestamp, corresponding to zero seconds (hh:mm:00 when source="service_list_1m"), zero minutes (hh:00 when source="service_list_1h"), and midnight (00:00:00 when source="service_list_1d"). |

Similarly, to query data for two hours from `2024-03-19 15:00:00` to `2024-03-19 17:00:00`, you can use DQL:

```dql
TM::`*`:(){source="service_list_1h"} [1710831600000:1710838800000]
```

To query data for two days from `2024-03-19 00:00:00` to `2024-03-21 00:00:00`, you can use DQL:

```dql
TM::`*`:(){source="service_list_1d"} [1710777600000:1710950400000]
```

Different time granularities can be combined, for example, to query data for two and a half hours from `2024-03-19 15:00:00` to `2024-03-19 17:30:00`, you can use DQL:

```dql
TM::`*`:(){ (source="service_list_1h" and date >= 1710831600000 and date < 1710838800000) or (source="service_list_1m" and date >= 1710838800000 and date <= 1710840600000) }
```

<!-- markdownlint-disable MD046 -->
???+ note

    Of course, it is also possible to only use the minute-level granularity source="service_list_1m" to query data across entire hours or days, such as from `2024-03-19 15:00:00` to `2024-03-19 17:30:00`. However, this would greatly reduce query efficiency and exponentially increase the amount of returned data, so it is not recommended.
<!-- markdownlint-enable -->

Further processing of the query results allows for the calculation of relevant service-level metrics, for example:

```
total_count = SUM(r_request_count)
error_count = SUM(r_error_count)
error_rate = SUM(r_error_count) / SUM(r_request_count)
max_duration = MAX(r_max_duration)
sum_resp_time = SUM(r_resp_time)
avg_per_second = SUM(r_request_count) / <query time range>
avg_resp_time = SUM(r_resp_time) / SUM(r_request_count)
p50: Create an array [(r_resp_time1/r_request_count1)...{repeat r_request_count1 times}, (r_resp_time2/r_request_count2)...{repeat r_request_count2 times}, (r_resp_time3/r_request_count3)...{repeat r_request_count3 times}, ...], sort the array and take the index SUM(r_request_count)*0.5
```

For example, to query QPS (queries per second) for each service over a certain time range, you can use:

```dql
TM::`*`:(r_service, sum(r_request_count) / (1737099000000 - 1737093600000) * 1000 as QPS){ (source="service_list_1h" and date >= 1737093600000 and date < 1737097200000) or (source="service_list_1m" and date >= 1737097200000 and date <= 1737099000000) } by r_service
```

## Definition of Service Topology Data Source {#tsm-definitions}

The `TSM` index space mainly stores service call topology relationship data, pre-aggregating the data at the minute level. For example, to query all service call relationships within a 15-minute range from `2024-03-19 15:00:00` to `2024-03-19 15:15:00`, you can use DQL:

```
TSM::`*`:(){} [1710831600000:1710832500000]
```

This returns query results similar to the following:

<!-- markdownlint-disable MD046 -->
???- note "Example of Query Results (Click to Expand)"
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

Main field descriptions are as follows:

| Field                    | Type     | Description                             |
|-----------------------|--------|--------------------------------|
| time                  | int    | Milliseconds timestamp, time when the service call occurred                |
| time_us               | int    | Time when the service call occurred, in microseconds                 |
| source_service        | string | Name of the calling service                         |
| source_wsuuid         | string | ID of the reporting space for the calling service                     |
| source_env            | string | Deployment environment of the calling service                       |
| source_project        | string | Project name of the calling service                       |
| source_version        | string | Version of the calling service                         |
| source_type           | string | Type of the calling service                         |
| source_organization   | string | Organization where the reporting space of the calling service is located                  |
| source_status         | string | Status of the calling service, ok/error                |
| source_start          | int    | Start time of the calling service span, in microseconds             |
| source_duration       | int    | Aggregated duration of the calling service span within each minute, unit: microseconds       |
| target_service        | string | Name of the called service                         |
| target_wsuuid         | string | ID of the reporting space for the called service                     |
| target_env            | string | Deployment environment of the called service                       |
| target_project        | string | Project name of the called service                       |
| target_version        | string | Version of the called service                         |
| target_type           | string | Type of the called service                         |
| target_organization   | string | Organization where the reporting space of the called service is located                   |
| target_status         | string | Status of the called service, ok/error                |
| target_start          | int    | Start time of the called service span (when the service call occurred), in microseconds  |
| target_duration       | int    | Aggregated duration of the called service span within each minute, unit: microseconds     |
| count                 | int    | Number of calls within each minute                     |
| unique_id             | string | Unique ID generated only by the names of the calling service and the called service         |
| unique_id_env_version | int    | Unique ID generated to distinguish the calling service, environment, version, and the called service, environment, version |
| error_count           | int    | Number of failed calls within each minute                   |

For service call relationships and service call-level metrics, you can use the following DQL to query relationships between services:

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