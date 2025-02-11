# Detection Rules
---

Currently, Guance supports over a dozen monitoring detection rules, each covering different data ranges.

## Rule Types {#type}

<font size=3>

| <div style="width: 170px">Rule Name</div> | <div style="width: 120px">Data Scope</div> | Basic Description |
| --- | --- | --- |
| [Threshold Detection](./threshold-detection.md) | All | Abnormal detection of Metrics data based on set thresholds. |
| [Mutation Detection](./mutation-detection.md) | Metrics (M) | Abnormal detection of sudden anomalies in Metrics based on historical data, suitable for business data and short time windows. |
| [Interval Detection](./interval-detection.md) | Metrics (M) | Abnormal data point detection in Metrics based on dynamic threshold ranges, suitable for stable trend Time Series. |
| [Interval Detection V2](./interval-detection-v2.md) | Metrics (M) | Abnormal data point detection in Metrics based on dynamic threshold ranges, suitable for stable trend Time Series. |
| [Outlier Detection](./outlier-detection.md) | Metrics (M) | Detection of outlier deviations in Metrics/statistics within specific groups. |
| [Log Detection](./log-detection.md) | Logs (L) | Abnormal detection of business applications based on log data. |
| [Process Anomaly Detection](./processes-detection.md) | Process Objects (O::`host_processes`) | Periodic detection of process data to understand process anomalies. |
| [Infrastructure Survival Detection V2](./infrastructure-detection.md) | Objects (O) | Monitoring infrastructure stability by setting survival conditions based on infrastructure object data. |
| [Application Performance Metrics Detection](./application-performance-detection.md) | Traces (T) | Abnormal detection based on APM data, setting threshold rules. |
| [User Access Metrics Detection](./real-user-detection.md) | User Access Data (R) | Abnormal detection based on RUM data, setting threshold rules. |
| [Composite Detection](./composite-detection.md) | All | Combining multiple monitors' results into one monitor through expressions for alerting based on the combined result. |
| [Security Check Anomaly Detection](./security_checker.md) | Security Checks (S) | Abnormal detection based on Security Check data, effectively sensing host health status. |
| [Synthetic Testing Anomaly Detection](./usability-detection.md) | Synthetic Tests Data (L::`type`) | Abnormal detection based on Synthetic Tests data, setting threshold rules. |
| [Network Data Detection](./network-detection.md) | Network (N) | Setting threshold rules based on network data to detect network performance stability. |
| [External Event Detection](./third-party-event-detection.md) | Other | Sending third-party system anomaly events or records as POST requests to an HTTP server via specified URLs to generate event data in Guance. |

</font>

## Start Configuration

### Detection Configuration {detection-config}

Set up detection frequency, detection intervals, detection metrics, etc., for different [detection rules](#type).

### Event Notification {#notice}

#### Event Title

Define the event name for the alert trigger condition; you can use preset [template variables](../event-template.md).

**Note**: In the latest version, the monitor name will be automatically generated after entering the event title. In older monitors, there may be inconsistencies between the monitor name and the event title. For a better user experience, please synchronize to the latest version as soon as possible.

#### Event Content {#content}

Write the content of the event notification, which will be sent externally when the trigger condition is met. You can input Markdown formatted text and preview the effect; you can also use [related links](#links), [template variables](../event-template.md).

#### Custom Notification Content {#custom}

By default, Guance uses the [event content](#content) as the alert notification content. If you need to customize the actual notification sent externally, you can enable this switch here and fill in the notification information.

<img src="../../img/custom-enable.png" width="70%" >

**Note**: Different alert notification targets support different Markdown syntax. For example, WeCom does not support unordered lists.

##### Related Links {links}

Monitors will automatically generate jump links based on the detection metrics in the [detection configuration](#detection-config). You can adjust filter conditions and time ranges after inserting the link. Generally, it's a fixed URL prefix that includes the current domain and workspace ID; you can also choose to customize the jump link.

For instance, if you need to insert a link to a dashboard, based on the above logic, you would need to add the dashboard ID and name, and adjust view variables and time ranges as needed.

<img src="../../img/monitor-link.png" width="70%" >

##### Custom Advanced Settings {#advanced-settings}

You can add associated logs or error stacks in the event content through advanced settings to view contextual data when an anomaly occurs:

<img src="../../img/advanced-settings.png" width="70%" >

- Add Associated Logs:

Query:

For example, to get a log `message` with an index of `default`:

```
{% set dql_data = DQL("L::RE(`.*`):(`message`) { `index` = 'default' } LIMIT 1") %}
```

Associated Log:

```
{{ dql_data.message | limit_lines(10) }}
```

- Add Associated Error Stack

Query:

```
{% set dql_data = DQL("T::re(`.*`):(`error_message`,`error_stack`){ (`source` NOT IN ['service_map', 'tracing_stat', 'service_list_1m', 'service_list_1d', 'service_list_1h', 'profile']) AND (`error_stack` = exists()) } LIMIT 1") %}
```

Associated Error Stack:

```
{{ dql_data.error_message | limit_lines(10) }}

{{ dql_data.error_stack | limit_lines(10) }}
```


#### Data Gap Events

Customize the notification content for data gaps. You can configure the title and content of the notification sent externally for such events.

If not configured here, the official default notification template will be used when sending notifications externally.

<img src="../../img/8.monitor_2.png" width="80%" >

#### Associated Incident {#issue}

When enabled, if an anomaly event occurs under this monitor, an Issue will be created synchronously. You can choose to create Issues based on different event levels.

1. Select the event level;
2. Define the final Issue level;
3. Choose the responsible person for this type of Issue;
4. Select the delivery channel;
5. Optionally choose whether to close the Issue when the event is resolved.

Issues created here can be viewed in [Incident](../../exception/index.md) > [Channel](../../exception/channel.md).

### Alert Configuration {#alert}

<img src="../../img/strategy-create.png" width="60%" >

Once the monitoring conditions are met, immediately send [alerts](../alert-setting.md) to the specified notification targets. The alert strategy includes the event levels to notify, notification targets, and alert silence periods.

Alert strategies support single or multiple selections. Click on the strategy name to expand the details page. To modify the strategy, click **Edit Alert Strategy**.

### Association

**Associate Dashboard**: Each monitor can be associated with a dashboard for quick navigation.

### Permissions {#permission}

After setting the operation permissions for the monitor, users in your current workspace, including role members and space users, will have corresponding permissions to operate the monitor according to the assigned permissions. This ensures that different users perform operations consistent with their roles and permission levels.

- Not enabling this configuration: Follow the [default permissions](../management/role-list.md) for "Monitor Configuration Management";
- Enabling this configuration and selecting custom permission objects: Only the creator and those granted permissions can enable/disable, edit, or delete the monitor's rules;
- Enabling this configuration but not selecting custom permission objects: Only the creator has the permissions to enable/disable, edit, or delete the monitor.

**Note**: The Owner role in the current workspace is not affected by this operational permission configuration.

## Recover Monitor {#recover}

Guance supports viewing the status, last update time, creation time, and creator of existing monitors. You can recover monitors to view historical configurations, facilitating quick communication and collaboration with team members to update monitors.

*<u>Operation Example:</u>*

In **Monitoring > Monitors**, select an existing monitor to edit. On the monitor configuration page, click the :fontawesome-brands-creative-commons-nd: button in the top-right corner to view the monitor's status, last update time, creation time, and creator.

![](../img/8.monitor_recover_1.png)

Click the :material-text-search: view button next to the **Update Time** to open a new browser window to view the previous version of the monitor configuration;

![](../img/8.monitor_recover_1.1.png)

Click the **Restore This Version** button in the top-right corner of the previous version of the monitor. In the pop-up dialog, confirm the restoration to restore the previous version of the monitor configuration for editing and saving.

<img src="../../img/8.monitor_recover_1.2.png" width="60%" >