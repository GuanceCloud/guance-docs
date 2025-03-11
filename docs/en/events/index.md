---
icon: zy/events
---
# Events
---

<<< custom_key.brand_name >>> provides a comprehensive event management and auditing platform, allowing real-time monitoring and unified querying of event data from various sources. By aggregating and correlating events, you can quickly pinpoint anomalies and perform efficient data analysis.

Under the **Events** feature module, you can monitor system anomalies and service quality degradation issues through modules such as monitors, intelligent inspections, SLOs, etc. **All monitoring activities result in event records**, which are then aggregated into the event analysis module for in-depth analysis and processing. This one-stop approach ensures that you have a full understanding of the system's health and can respond promptly to any potential issues.


## Where Do Events Come From?

- Alerts triggered by [Monitors](../monitoring/monitor/monitor-rule.md#content) and [Intelligent Monitoring](../monitoring/intelligent-monitoring/index.md) based on configuration rules;
- All alert events triggered by configured [Intelligent Inspections](../monitoring/bot-obs/index.md);
- All alert events triggered by configured [SLOs](../monitoring/slo.md);
- [Audit Events](../management/operation-audit.md) triggered by system operations;
- Custom events written via [OpenAPI](../open-api/keyevent/create.md).


## Viewing Event Records

- [Explorer > Unrecovered Events Explorer](./event-explorer/unrecovered-events.md): All unrecovered events within the last 48 hours in the current workspace, i.e., events with a status of not normal (`df_status != ok`).
- [Explorer > All Events Explorer](./event-explorer/event-list.md): Includes all events from sources such as monitors, intelligent inspections, SLOs, audit events, and OpenAPI custom events. Each alert record triggered by a **Monitor** detection rule is an event.
- [Intelligent Monitoring](./inte-monitoring-event.md): Includes all events triggered by intelligent monitoring configurations. Each alert record generated after triggering is an event.


## Event Content

Taking events triggered by configured monitor rules as an example, the final event content mainly includes the information entered at [Create Rule > Event Notification](../monitoring/monitor/monitor-rule.md#notice).

As shown in the figure below, the event title is defined as `Log Detection - Multi Index`, and the DQL query statement and variables are filled in the event content. <<< custom_key.brand_name >>> will automatically generate and display the final event record based on the actual monitored data.

![](img/event-monitor.png)

When this rule detects an anomaly, you can view the relevant event content by navigating to Events > Event Details.

![](img/event-monitor-1.png)


### Event Field Descriptions {#fields}

The final event record will include the following fields:

| <div style="width: 210px">Field</div>                   | Description                                                         |
| :--------------------- | :----------------------------------------------------------- |
| `date` / `timestamp`   | Generation time. Unit: seconds                                             |
| `df_date_range`        | Time range. Unit: seconds                                             |
| `df_check_range_start` | Start time of the check range. Unit: seconds                                     |
| `df_check_range_end`   | End time of the check range. Unit: seconds                                     |
| `df_issue_start_time`  | The first occurrence time of the issue in this round. Unit: seconds                               |
| `df_issue_duration`    | Duration of the issue in this round, unit: seconds (from `df_issue_start_time` to this event) |
| `df_source`            | Event source. Including monitor, user, system, custom, audit          |
| `df_status`            | Event status. Including ok, info, warning, error, critical, nodata, nodata_ok, nodata_as_ok, manual_ok |
| `df_sub_status`        | Detailed event status (supplement to `df_status`)                        |
| `df_event_id`          | Unique event ID                                                  |
| `df_title`             | Title                            |
| `df_message`           | Description                                 |


- When `df_source = monitor`, additional fields exist:

| <div style="width: 210px">Field</div>                           | Description                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `df_dimension_tags`            | Detection dimension tags, e.g., `{"host":"web01"}`                           |
| `df_monitor_id`                | Alert strategy ID                                                  |
| `df_monitor_name`              | Alert strategy name                                                   |
| `df_monitor_type`              | Type: custom monitoring events are `custom`, SLO events are `slo`, intelligent inspection events are fixed as `bot_obs` |
| `df_monitor_checker`           | Execution function name, e.g., `custom_metric`                           |
| `df_monitor_checker_sub`       | Detection phase: `nodata` if during data gap detection, `check` if during normal detection |
| `df_monitor_checker_id`        | Monitor ID                                                    |
| `df_monitor_checker_name`      | Monitor name                                                   |
| `df_monitor_checker_value`     | Abnormal value when the event occurred                                           |
| `df_monitor_checker_value_dumps`     | Abnormal value when the event occurred (JSON serialized)<br />Convenient for deserialization to obtain the original value                                           |
| `df_monitor_checker_value_with_unit`     | Abnormal value when the event occurred (optimal unit)            |
| `df_monitor_checker_ref`       | Monitor association, only associated with fields related to the DQL statement configured for detection              |
| `df_monitor_checker_event_ref` | Monitor event association, only associated with fields related to `df_dimension_tags` and `df_monitor_checker_id` |
| `df_monitor_ref_key`           | Self-built inspection association key, used to correspond with self-built inspections                       |
| `df_fault_id`     | Fault ID for this round, taken from the `df_event_id` of the first fault event                      |
| `df_fault_status`     | Fault status for this round, redundant fields of `df_status` and `df_sub_status`, indicating whether it is OK, values:<br />ok: Normal<br />fault: Fault          |
| `df_fault_start_time`     | Start time of the fault in this round.               |
| `df_fault_duration`     | Duration of the fault in this round, unit: seconds (from `df_issue_start_time` to this event)          |
| `df_event_detail`              | Event detection details                                                 |
| `df_event_report`              | Intelligent monitoring report data                                       |
| `df_user_id`                   | User ID of the operator when manually recovered                                    |
| `df_user_name`                 | Username of the operator when manually recovered                                     |
| `df_user_email`                | Email of the operator when manually recovered                                   |
| `df_crontab_exec_mode`                 | Execution mode, options.<br><li>Automatic trigger (i.e., scheduled execution) `crontab` <br><li> Asynchronous call (i.e., manual execution) `manual` |
| `df_site_name`                | Current <<< custom_key.brand_name >>> site name                                   |
| `df_workspace_name`                | Workspace name                                   |
| `df_workspace_uuid`                | Workspace UUID                             |
| `df_label`                | Monitor label, labels specified in the monitor are stored in this field UUID                             |
| `df_alert_policy_ids`                | Alert policy IDs (list)                            |
| `df_alert_policy_names`                | Alert policy names (list)                             |
| `df_matched_alert_policy_rules`                | Alert policy names and all matched rule names (list)                             |
| `df_channels`                | List of incident channels associated with the event                             |
| `df_at_accounts`                | @account information                             |
| `df_at_accounts_nodata`                | @account information (data gap)                             |
| `df_message_at_accounts`                | Detailed information list of `@users` in the fault alert message                             |
| `df_nodata_message_at_accounts`                | Detailed information list of `@users` in the data gap alert message       |
| `df_workspace_declaration`                | Attribute claims of the workspace       |
| `df_matched_alert_members`                | List of all matching alert notification members when sending alerts by member       |
| `df_matched_alert_upgrade_members`                | List of all matching alert upgrade notification members when sending alerts by member       |
| `df_matched_alert_member_groups`                | List of all matching member group names when sending alerts by member       |
| `df_charts`                | Chart information appended when charts are added in the monitor configuration and this alert event requires sending a message       |
| `df_alert_info`                | Alert notification information       |
| `df_is_silent`                | Whether the event is muted, value is string `"true"` / `"false"`       |
| `df_sent_target_types`                | List of unique alert notification object types sent for this event       |

- When `df_source = audit`, additional fields exist:

| Field            | Description                           |
| :-------------- | :----------------------------- |
| `df_user_id`    | Operator user ID                  |
| `df_user_name`  | Operator username                   |
| `df_user_email` | Operator user email                 |
| {Other Fields}      | Other fields based on specific audit data requirements |

- When `df_source = user`, additional fields exist:

| Field            | Description                             |
| :-------------- | :------------------------------- |
| `df_user_id`    | Creator user ID                    |
| `df_user_name`  | Creator username                     |
| `df_user_email` | Creator user email                   |
| {Other Fields}      | Other fields based on user actions that generate events |


## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Event Data Sharding Practice: Implementation Based on Dataway Sink**</font>](./event_data_sharding.md)

</div>

</font>