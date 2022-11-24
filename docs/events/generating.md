# 事件产生
---

## 简介

观测云支持收集基于监控器触发的全部告警事件。通过在「监控器」添加异常检测规则，所有触发检测规则的告警数据都会自动保存到「事件」中。

通过「事件」查看器，您可以查看类事件数据，包括事件数据和未恢复事件数据。

- 事件数据：触发「监控器」检测规则的每一条告警记录即为一个事件数据。
- 未恢复事件数据：基于「监控器」检测规则持续被触发的，且当前状态仍为不正常（status !=ok）的事件数据为未恢复事件数据。

## 事件来源

- 基于配置的 [监控器](../monitoring/index.md) 触发的全部告警事件
- 基于配置的 [智能巡检](../monitoring/bot-obs/index.md) 触发的全部告警事件
- 基于系统操作触发的审计事件，更多详情可参考 [操作审计](../management/operation-audit.md)
- 支持通过事件的 OpenAPI 写入自定义事件。更多详情可参考 [创建事件 API](../open-api/keyevent/create.md)

## 字段说明
| 字段                   | 说明                                                         |
| :--------------------- | :----------------------------------------------------------- |
| `date` / `timestamp`   | 产生时间。单位秒                                             |
| `df_date_range`        | 时间范围。单位秒                                             |
| `df_check_range_start` | 检测范围开始时间。单位秒                                     |
| `df_check_range_end`   | 检测范围结束时间。单位秒                                     |
| `df_issue_start_time`  | 本轮首次故障发生的时间。单位秒                               |
| `df_issue_duration`    | 本轮故障的持续时间，单位秒 （从`df_issue_start_time`开始到本事件） |
| `df_source`            | 事件来源。包括 monitor, user, system, custom, audit          |
| `df_status`            | 事件状态。包括 ok, info, warning, error, critical, nodata, nodata_ok, nodata_as_ok, manual_ok |
| `df_sub_status`        | 事件细节状态（作为`df_status`的补充）                        |
| `df_event_id`          | 事件唯一 ID                                                  |
| `df_event_url`         | 事件跳转 URL                                                 |
| `df_title`             | 标题                                                         |
| `df_message`           | 描述                                                         |


- 当 df_source = monitor 时，额外存在以下字段：

| 字段                           | 说明                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `df_dimension_tags`            | 检测纬度标签，如`{"host":"web01"}`                           |
| `df_monitor_id`                | 告警策略 ID                                                  |
| `df_monitor_name`              | 告警策略名                                                   |
| `df_monitor_type`              | 所属类型：自定义监控事件为`custom` ，SLO 事件为`slo` ， 智能巡检事件固定为`bot_obs` |
| `df_monitor_checker`           | 执行函数名，如：`custom_metric` 等                           |
| `df_monitor_checker_sub`       | 检测阶段：在无数据检测阶段产生的为 `nodata` ，在正常检测阶段产生的为 `check` |
| `df_monitor_checker_id`        | 监控器 ID                                                    |
| `df_monitor_checker_name`      | 监控器名称                                                   |
| `df_monitor_checker_value`     | 事件产生时的异常值                                           |
| `df_monitor_checker_ref`       | 监控器关联，只和「检测配置的DQL语句」关联的字段              |
| `df_monitor_checker_event_ref` | 监控器事件关联，只和 「`df_dimension_tags` 和 `df_monitor_checker_id` 」关联的字段 |
| `df_monitor_ref_key`           | 自建巡检的关联 Key，用于和自建巡检对应                       |
| `df_event_detail`              | 事件检测详情                                                 |
| `df_user_id`                   | 手工恢复时，操作者用户 ID                                    |
| `df_user_name`                 | 手工恢复时，操作者用户名                                     |
| `df_user_email`                | 手工恢复时，操作者用户邮箱                                   |
| `df_exec_mode`                 | 执行模式，可选值。<br><li>自动触发（即定时执行）`crontab` <br><li> 异步调用（即手工执行）`async` |

- 当 df_source = audit 时，额外存在以下字段：

| 字段            | 说明                           |
| :-------------- | :----------------------------- |
| `df_user_id`    | 操作者用户 ID                  |
| `df_user_name`  | 操作者用户名                   |
| `df_user_email` | 操作者用户邮箱                 |
| {其他字段}      | 根据具体审计数据需求的其他字段 |

- 当 df_source = user 时，额外存在以下字段：

| 字段            | 说明                             |
| :-------------- | :------------------------------- |
| `df_user_id`    | 创建者用户 ID                    |
| `df_user_name`  | 创建者用户名                     |
| `df_user_email` | 创建者用户邮箱                   |
| {其他字段}      | 根据用户操作而产生事件的其他字段 |

