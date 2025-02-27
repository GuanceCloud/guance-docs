## 概述

当数据被写入特定空间时，<<< custom_key.brand_name >>>将实时监控并统计这些数据的写入量。它按照预设的时间周期，将统计信息记录并存储在数据库中。

通过结合 DQL 查询语句，用户可以轻松构建一个使用量分析仪表板。这个仪表板能够提供直观的数据使用情况分析，帮助用户洞察数据流量趋势，优化资源分配和监控数据使用情况。

## 数据结构

```json
{
    "time": 1720584000000,
    "__docid": "fb4d3b817fdc08a266bfefe85049d279",
    "count": "0",
    "create_time": "1720591166343",
    "date": "1720584000000",
    "hour_count": "0",
    "project": "logging",
    "sub_project": "default",
    "workspaceUUID": "wksp_3c5cc6626cb64550b401347931fcf467"
}
```

### 字段说明

| 字段  | 类型   | 说明| 示例  |
| -------- | ------- | ------ | ----------- |
|time|int64|计量项时间，单位为 ms,例如: 1720584000000 等价于 2024-07-10 12:00:00， 表示该计量项时间范围为  2024-07-10 12:00:00 ～ 2024-07-10 13:00:00 （左闭右开）|1720584000000|
|date|int64|同 time||
|__docid|string| 唯一标识一条数据库记录|fb4d3b817fdc08a266bfefe85049d279|
|workspaceUUID|string|工作空间 ID|wksp_3c5cc6626cb64550b401347931fcf467|
|project|string|计量项目，具体说明见下文|logging|
|sub_project|string|计量子项目，具体说明见下文|default|
|count|int64|全量计量|2345|
|hour_count|int64|每小时计量数据|1234|
|create_time|int64|实际写入数据库时间，单位 ms|1720591166343|

### 计量项目(project) 说明

注意⚠️: 全量统计方式，使用 `count`计数，增量统计方式，使用`hour_count` 计数

| 统计项  | project   | sub_project| 统计周期  |统计方式|说明|
| -------- | ------- | ------ | ----------- |------ | ----------- |
|datakit数量|datakit||每小时统计一次|全量|具体空间的datakit 使用量|
|整个站点 datakit 数量|cluster_datakit||每小时统计一次|全量|表示整个站点的 datakit 使用量，和具体的工作空间没有关系|
|http api 数量|api_test||每小时统计一次|增量||
|pv 数量|rum_pv||每小时统计一次|增量||
|rum 写入流量计费项|rum_bytes||每小时执行一次|增量||
|trace 数量|tracing||每小时统计一次|增量||
|tracing 写入流量计费项|tracing_bytes||每小时执行一次|增量||
|事件数量|keyevent||每小时执行一次|全量||
|备份数据到客户s3对象存储|backup_log_s3_bytes|可选值为 logging/tracing/rum，分别表示对应数据类型的备份信息|每小时执行一次|增量||
|备份数据到客户消息引擎|backup_log_kafka_bytes|可选值为 logging/tracing/rum，分别表示对应数据类型的备份信息|每小时执行一次|增量||
|备份数据到客户oss对象存储|backup_log_oss_bytes|可选值为 logging/tracing/rum，分别表示对应数据类型的备份信息|每小时执行一次|增量||
|备份数据到客户obs对象存储|backup_log_obs_bytes|可选值为 logging/tracing/rum，分别表示对应数据类型的备份信息|每小时执行一次|增量||
|备份数据到guance对象存储|backup_log_guance_bytes|可选值为 logging/tracing/rum，分别表示对应数据类型的备份信息|每小时执行一次| 全量||
|安全巡检|security||每小时执行一次|增量||
|定时报告|report||每5分钟执行一次|增量||
|对象数量|object||每小时执行一次|全量||
|Pipeline 字节数处理量|pipeline_processed_bytes||每小时执行一次|增量||
|敏感数据扫描流量计费项|privacy_scan_bytes||每小时执行一次|增量||
|日志写入流量计费项|logging_bytes|可选值为日志多索引的索引名称|每小时执行一次|增量||
|日志数量|logging|可选值为日志多索引的索引名称|每小时执行一次|增量||
|时间线|ts||每小时统计一次|全量||
|pipeline 流量统计|pipeline_processed_bytes||每小时统计一次|增量||

## 计量数据查询

```
# 通过 dql 语句，可以查看具体空间一天内的日志写入量

metering::`*`:(sum(hour_count)) {project="logging", workspaceUUID="wksp_xxx"}
```