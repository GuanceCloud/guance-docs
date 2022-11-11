# 事件来源
---

## 简介

“观测云” 支持收集基于监控器触发的全部告警事件。通过在「监控器」添加异常检测规则，所有触发检测规则的告警数据都会自动保存到「事件」中。

通过「事件」查看器，您可以查看类事件数据，包括事件数据和未恢复事件数据。

- 事件数据：触发「监控器」检测规则的每一条告警记录即为一个事件数据。
- 未恢复事件数据：基于「监控器」检测规则持续被触发的，且当前状态仍为不正常（status !=ok）的事件数据为未恢复事件数据。

## 事件来源

- 基于 [监控器](../monitoring/index.md) 触发的全部告警事件
- 基于 [智能巡检](../monitoring/bot-obs.md) 触发的全部告警事件
- 系统事件，更多详情可以参考[操作审计](../management/operation-audit.md)

## 字段说明
| 字段名 | 说明 |
| --- | --- |
| `date`/`timestamp` | 产生时间。单位 s |
| `df_date_range` | 时间范围。单位 s |
| `df_check_range_start` | 检测范围开始时间。单位 s |
| `df_check_range_end` | 检测范围结束时间。单位 s |
| `df_event_start_time` | 本轮首次故障发生的时间。单位 s |
| `df_event_duration` | 本轮故障的持续时间。单位 s （从`df_event_start_time`开始到本事件）|
| `df_source` | 数据来源。取值 monitor , user，system |
| `df_status` | 状态。取值 ok , info , warning , error , critical，nodata |
| `df_sub_status` | 事件细节状态。（作为`df_status`的补充） |
| `df_event_id` | 事件 ID |
| `df_event_url` | 事件跳转 URL |
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
| `df_monitor_checker_sub` | 检测阶段。在无数据检测阶段产生的为`nodata`，在正常检测阶段产生的为`check` |
| `df_monitor_checker_id` | 检测项 ID |
| `df_monitor_checker_name` | 检测项名称 |
| `df_monitor_checker_value` | 检测触发事件时的值 |
| `df_monitor_checker_ref` | 只和「检测配置的DQL语句」关联的字段 |
| `df_monitor_checker_event_ref` | 只和「检测项ID + 检测维度标签」关联的字段 |
| `df_monitor_ref_key` | 自建巡检的关联 Key，用于和自建巡检对应 |
| `df_bot_obs_detail` | 智能检测详情 |
| `df_event_detail` | 事件检测详情 |
| `df_user_id` | 手动恢复时，操作者用户 ID |
| `df_user_name` | 手动恢复时，操作者用户名 |
| `df_user_email` | 手动恢复时，操作者用户邮箱 |
| `df_exec_mode` | 执行模式，可选值。<br />自动触发（即定时执行）：`crontab` <br />异步调用（即手动执行）`async` |
