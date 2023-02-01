
# DataKit 自身指标
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

self 采集器用于 DataKit 自身基本信息的采集，包括运行环境信息、CPU、内存占用情况等。

## 前置条件 {#reqirement}

暂无

## 配置 {#config}

self 采集器会自动运行，无需配置，且无法关闭。

## 指标 {#measurements}





### `datakit`



- 标签


| Tag | Descrition |
|  ----  | --------|
|`arch`|Architecture of the DataKit|
|`host`|Hostname of the DataKit|
|`namespace`|Election namespace(datakit.conf/namespace) of DataKit, may be not set|
|`os`|Operation System of the DataKit, such as linux/mac/windows|
|`os_version_detail`|Operation System release of the DataKit, such as Ubuntu 20.04.2 LTS, macOS 10.15 Catalina|
|`uuid`|**Deprecated**, currently use `hostname` as DataKit's UUID|
|`version`|DataKit version|

- 字段列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_usage`|CPU usage of the datakit|float|percent|
|`cpu_usage_top`|CPU usage(command `top`) of the datakit|float|percent|
|`dropped_point_total`|Total dropped points due to cache clean|int|count|
|`dropped_points`|Current dropped points due to cache clean|int|count|
|`elected`|Elected duration, if not elected, the value is 0|int|s|
|`heap_alloc`|Bytes of allocated heap objects|int|B|
|`heap_objects`|Number of allocated heap objects|int|count|
|`heap_sys`|Bytes of heap memory obtained from OS(Estimates the largest size of the heap has had)|int|B|
|`incumbency`|**Deprecated**. same as `elected`|int|s|
|`max_heap_alloc`|Max bytes of allocated heap objects since DataKit start|int|B|
|`max_heap_objects`|Max number of allocated heap objects since DataKit start|int|count|
|`max_heap_sys`|Max bytes of heap memory obtained from OS since DataKit start|int|B|
|`max_num_goroutines`|Max number of goroutines since DataKit start|int|count|
|`min_heap_alloc`|Minimal bytes of allocated heap objects since DataKit start|int|B|
|`min_heap_objects`|Minimal number of allocated heap objects since DataKit start|int|count|
|`min_heap_sys`|Minimal bytes of heap memory obtained from OS since DataKit start|int|B|
|`min_num_goroutines`|Minimal number of goroutines since DataKit start|int|count|
|`num_goroutines`|Number of goroutines that currently exitst|int|count|
|`open_files`|open files of DataKit(Only Linux support, others are -1)|int|count|
|`pid`|DataKit process ID|int|-|
|`uptime`|Uptime of DataKit|int|s|






### `datakit_http`



- 标签


| Tag | Descrition |
|  ----  | --------|
|`api`|API router of the DataKit HTTP|

- 字段列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`2XX`|HTTP status code 2xx count|int|count|
|`3XX`|HTTP status code 3xx count|int|count|
|`4XX`|HTTP status code 4xx count|int|count|
|`5XX`|HTTP status code 5xx count|int|count|
|`avg_latency`|HTTP average latency|int|ns|
|`limited`|HTTP limited|int|count|
|`max_latency`|HTTP max latency|int|ns|
|`total_request_count`|HTTP total request count|int|count|






### `datakit_goroutine`



- 标签


| Tag | Descrition |
|  ----  | --------|
|`group`|The group name of the goroutine.|

- 字段列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`failed_num`|The number of the goroutine which has failed|int|count|
|`finished_goroutine_num`|The number of the finished goroutine|int|count|
|`max_cost_time`|Maximum cost time in nanosecond|int|ns|
|`min_cost_time`|Minimum cost time in nanosecond|int|ns|
|`running_goroutine_num`|The number of the running goroutine|int|count|
|`total_cost_time`|Total cost time in nanosecond|int|ns|




## 延申阅读 {#more-reading}

- [主机采集器](hostobject.md)
