---
icon: zy/events
---
# 事件
---


观测云支持一站式查看和审计全部事件数据。您可以对所有来源触发的事件进行实时监控、统一查询；还可以通过聚合相关事件和匹配关联事件，快速定位异常并高效对异常数据进行分析。

![](img/4.event_3.gif)

## 事件来源

- 基于配置的 [监控器](../monitoring/monitor/index.md) 触发的全部告警事件；
- 基于配置的 [智能监控](../monitoring/intelligent-monitoring/index.md) 触发的全部告警事件；
- 基于配置的 [智能巡检](../monitoring/bot-obs/index.md) 触发的全部告警事件；
- 基于配置的 [SLO](../monitoring/slo.md) 触发的全部告警事件；
- 基于系统操作触发的[审计事件](../management/operation-audit.md)；
- 支持通过事件的 [OpenAPI 写入自定义事件](../open-api/keyevent/create.md)。

## 应用场景

- 事件统一管理；
- 事件可视化查询与分析；
- 关联事件查询。

## 功能介绍

|                   <font color=coral size=3>:fontawesome-regular-circle-down: &nbsp;**了解更多**</font>                         |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| [未恢复事件查看器](./event-explorer/unrecovered-events.md){ .md-button .md-button--primary } | [所有事件查看器](./event-explorer/event-list.md){ .md-button .md-button--primary } |
| [智能监控](inte-monitoring-event.md){ .md-button .md-button--primary } | [监控器配置触发事件](../monitoring/monitor/index.md){ .md-button .md-button--primary } |


<!--
- [查看器 > 未恢复事件查看器](unrecovered-events.md)：支持查看工作空间最近 48 小时内持续被触发的全部未恢复事件，包括所有当前状态为不正常（`df_status !=ok`）的事件。您可以基于未恢复事件的详情信息，快速查看和解决故障问题；
- [查看器 > 所有事件查看器](event-list.md)：包括监控器、智能巡检、SLO、审计事件、OpenAPI 写入自定义事件来源下的所有事件，如触发**监控器**检测规则的每一条告警记录即为一个事件数据。您可以通过选择时间范围、搜索与筛选、分组聚合等对事件进行查询和分析；
- [智能监控](inte-monitoring-event.md)：包括所有智能监控触发的所有事件，如触发**智能监控**检测规则的每一条告警记录即为一个事件数据。您可以通过选择时间范围、搜索与筛选、分组聚合等对事件进行查询和分析；
- [监控器配置触发事件](../monitoring/monitor/index.md)：支持基于配置监控器的触发条件产生不同的事件进行管理和分析。
-->

## 字段说明 {#fields}

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
| `df_title`             | 标题                                                         |
| `df_message`           | 描述                                                         |


- 当 `df_source = monitor` 时，额外存在以下字段：

| 字段                           | 说明                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `df_dimension_tags`            | 检测纬度标签，如`{"host":"web01"}`                           |
| `df_monitor_id`                | 告警策略 ID                                                  |
| `df_monitor_name`              | 告警策略名                                                   |
| `df_monitor_type`              | 所属类型：自定义监控事件为 `custom`，SLO 事件为 `slo`，智能巡检事件固定为 `bot_obs` |
| `df_monitor_checker`           | 执行函数名，如：`custom_metric` 等                           |
| `df_monitor_checker_sub`       | 检测阶段：在数据断档检测阶段产生的为 `nodata`，在正常检测阶段产生的为 `check` |
| `df_monitor_checker_id`        | 监控器 ID                                                    |
| `df_monitor_checker_name`      | 监控器名称                                                   |
| `df_monitor_checker_value`     | 事件产生时的异常值                                           |
| `df_monitor_checker_ref`       | 监控器关联，只和检测配置的 DQL 语句关联的字段              |
| `df_monitor_checker_event_ref` | 监控器事件关联，只和 `df_dimension_tags` 和 `df_monitor_checker_id` 关联的字段 |
| `df_monitor_ref_key`           | 自建巡检的关联 Key，用于和自建巡检对应                       |
| `df_event_detail`              | 事件检测详情                                                 |
| `df_user_id`                   | 手工恢复时，操作者用户 ID                                    |
| `df_user_name`                 | 手工恢复时，操作者用户名                                     |
| `df_user_email`                | 手工恢复时，操作者用户邮箱                                   |
| `df_exec_mode`                 | 执行模式，可选值。<br><li>自动触发（即定时执行）`crontab` <br><li> 异步调用（即手工执行）`async` |

- 当 `df_source = audit` 时，额外存在以下字段：

| 字段            | 说明                           |
| :-------------- | :----------------------------- |
| `df_user_id`    | 操作者用户 ID                  |
| `df_user_name`  | 操作者用户名                   |
| `df_user_email` | 操作者用户邮箱                 |
| {其他字段}      | 根据具体审计数据需求的其他字段 |

- 当 `df_source = user` 时，额外存在以下字段：

| 字段            | 说明                             |
| :-------------- | :------------------------------- |
| `df_user_id`    | 创建者用户 ID                    |
| `df_user_name`  | 创建者用户名                     |
| `df_user_email` | 创建者用户邮箱                   |
| {其他字段}      | 根据用户操作而产生事件的其他字段 |

## 存储策略

观测云为事件数据提供 14 天、30 天、60 天三种数据存储时长选择，若您选择 30 天的数据存储时长，不同来源产生的事件统一按照 30 天进行存储。您可以在**管理 > 基本设置 > 变更数据存储策略**中调整。

> 更多数据存储策略，可参考 [数据存储策略](../billing/billing-method/data-storage.md)。
