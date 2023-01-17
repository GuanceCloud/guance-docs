---
icon: zy/events
---
# Events
---

## Overview

Guance Cloud supports one-stop viewing and auditing of all event data, and supports real-time monitoring, unified query, unrecovered event statistics and data export of events triggered by all sources. You can quickly locate exceptions and efficiently analyze exception data by aggregating related events and matching related events.

![](img/4.event_3.gif)

## Event Source

- All alarm events triggered based on the configured [Monitor](../monitor/monitor/index.md)
- All Alarm events triggered based on the configured [Auto Detection](../monitoring/bot-obs/index.md)
- All alarm events triggered based on configured [SLO](../monitoring/slo.md)
- Audit events based on system operations. For more details, refer to [Operational Audit](../management/operation-audit.md)
- Support for writing custom events through the OpenAPI of events. For more details, please refer to [Creating Event API](../open-api/keyevent/create.md)

## Usage Scenarios

- Unified event management
- Event visualization query and analysis
- Associated event query

## Function Introduction

- [Unrecovered event explorer](unrecovered-events.md)：Support to view all unrecovered events that have been continuously triggered in the workspace in the last 48 hours, including all events with abnormal current status (df_status! = ok). You can quickly view and solve fault problems based on the details of unrecovered events;
- [Event explorer](event-list.md)：Including all events triggered by all event sources, for example, each alarm record that triggers the "monitor" detection rule is an event data. You can query and analyze events by selecting time range, searching and filtering, grouping aggregation, etc.;
- [Export event JSON file](event-details.md)：Support exporting the JSON file of the current event in the event details page to obtain all the key data corresponding to the current event;
- [Monitor configuration trigger event](../monitoring/monitor/index.md)：Support to generate different events for management and analysis based on the trigger conditions of configuration monitors.


## Field Description
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


- When df_source = monitor, the following additional fields exist:

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

- When df_source = audit, the following additional fields exist:

| 字段            | 说明                           |
| :-------------- | :----------------------------- |
| `df_user_id`    | 操作者用户 ID                  |
| `df_user_name`  | 操作者用户名                   |
| `df_user_email` | 操作者用户邮箱                 |
| {其他字段}      | 根据具体审计数据需求的其他字段 |

- When df_source = user, the following additional fields exist:

| 字段            | 说明                             |
| :-------------- | :------------------------------- |
| `df_user_id`    | 创建者用户 ID                    |
| `df_user_name`  | 创建者用户名                     |
| `df_user_email` | 创建者用户邮箱                   |
| {其他字段}      | 根据用户操作而产生事件的其他字段 |

## Event Storage Policy

Guance Cloud provides three data storage time choices for event data: 14 days, 30 days and 60 days. If you choose the data storage time of 30 days, events generated from different sources will be stored in 30 days. You can adjust as required in "Administration"-"Basic Settings"-"Change Data Storage Policy". See the document [Data Storage Policy](../billing/billing-method/data-storage.md) for more data storage policies.
