# 事件产生
---

## 简介

“观测云” 支持收集基于监控器触发的全部告警事件。通过在「监控器」添加异常检测规则，所有触发检测规则的告警数据都会自动保存到「事件」中。

通过「事件」查看器，您可以查看类事件数据，包括事件数据和未恢复事件数据。

- 事件数据：触发「监控器」检测规则的每一条告警记录即为一个事件数据。
- 未恢复事件数据：基于「监控器」检测规则持续被触发的，且当前状态仍为不正常（status !=ok）的事件数据为未恢复事件数据。

## 事件采集

您需要通过在「监控器」配置异常检测规则，以完成事件数据的采集。在观测云[监控器](../monitoring/index.md)，支持通过手动配置自定义监控器或者直接通过[监控器模版](../monitoring/template.md)一键创建，只需为主机 [安装 DataKit](../datakit/datakit-install.md) 即可使用。

## 字段说明
| 字段名 | 说明 |
| --- | --- |
| `date` | 产生时间。单位 ms |
| `df_date_range` | 时间范围。单位 s |
| `df_source` | 数据来源。取值 monitor , user，system |
| `df_status` | 状态。取值 ok , info , warning , error , critical，nodata |
| `df_event_id` | 事件 ID |
| `df_title` | 标题 |
| `df_message` | 详细描述 |


- 当 df_source = monitor 时，额外存在以下字段：

| 额外字段名 | 说明 |
| --- | --- |
| `df_dimension_tag` | 检测维度标签，如`{"host":"web01"}` |
| `df_monitor_id` | 检测库 ID  |
| `df_monitor_name` | 检测库名称。内置检测库与 monitor_type 相同；自定义检测库由用户填写 |
| `df_monitor_type` | 检测库类型。如`custom`，`host` |
| `df_monitor_checker` | 检测项函数名。如`custom_metric`，`custom_log` |
| `df_monitor_checker_id` | 检测项 ID |
| `df_monitor_checker_name` | 检测项名称 |
| `df_monitor_checker_value` | 检测触发事件时的值 |
| `df_monitor_checker_ref` | 只和「检测配置的DQL语句」关联的字段 |
| `df_monitor_checker_event_ref` | 只和「检测项ID + 检测维度标签」关联的字段 |
