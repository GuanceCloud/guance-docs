---
icon: zy/release-notes
---
# Release Notes (2024)
---

This document records the update content description released by Guance each time.

## September 4, 2024

### New Features

#### Logs

1. New interactive log explorer: Holding the Ctrl key allows for "Add to Query," "Exclude from Query," and "Copy" operations on the text tokens in the explorer list, facilitating quick search and addition of target data. Similarly, the log details page content area also supports this interaction.
2. Support for binding [Volcengine TLS External Index](../logs/multi-index/tls.md): External indexes can be bound to view and analyze Volcengine log data directly on the Guance platform.
3. Logs > [Data Access](../logs/logdata-access.md) optimization:
   - A new data access navigation page is added, with a help document link in the upper right corner of the page;
   - The data access rule adds a "Name" field as a unique ID, and a new rule "Description" field, allowing custom names and descriptions to differentiate rule usage cases.
4. Log explorer filter optimization: The "Log Index" filter in the log explorer list supports search, allowing keyword search of indexes and selection.
5. Log [Status Customization](../logs/explorer.md#status-color): Support for customizing log status values and setting colors for each status value in the console, adapting to different log access scenes, while making the log status display more personalized and intuitive.

#### Scenes

1. New chart type [Heatmap](../scene/visual-chart/heatmap_scene.md): Users can intuitively view the distribution and trends of data through color shades, helping to better understand the data.
2. [Chart Link Redirection](https://www.guance.com/learn/articles/Chart-Links): Link redirection in conjunction with dashboard data using Function.
3. [Alert Statistics Chart](../scene/visual-chart/alert-statistics.md) component upgrade: The listing logic is changed, and the listing effect of the new version of the alert statistics chart is consistent with the unresolved event explorer, unifying the user viewing experience.
   - Note: The "Create Issue" and "Manual Recovery" operations are not supported when listing across workspaces.
4. Custom display columns in grouped table charts: In grouped table charts, a new feature is added to customize display columns, supporting the display or hiding of returned columns, providing a more flexible data presentation method.
5. Optimization of chart cross-space authorization query interaction: After enabling the space authorization feature, you can directly select the authorized space list above the query, making the operation more intuitive and convenient.

#### Incidents

Issue and monitor events: If the content contains `@ member` configuration, the Issue or event will synchronize and carry the account attribute information of `@ member` when delivered externally through Webhook.

#### Monitoring

1. External event detection: Support for custom event occurrence time and tag attribute addition. Note:
   - Field values are uniformly used as string types;
   - Field names do not support starting with an underscore `_` or prefix `df_` and cannot have the same name as the current event default fields;
   - Custom tag field names cannot have the same name as the fields defined in `dimension_tags`.
2. Terminology adjustment: "No Data" is officially updated to "Data Gap" to ensure a unified page configuration and viewing experience.

#### Pipeline

Separate processing of probe data and log data, and add a new "Synthetic Tests" data type. Avoid mutual interference during data processing to ensure the accuracy and efficiency of data processing.

Note: Only the central Pipeline supports the "Synthetic Tests" data type, and the DataKit version of the test node must be >= 1.28.0.

#### Others

1. Workspace list display optimization: For the list operation bar, a new display of the creator's avatar is added, with mouse hover tips for the creator, creation time, updater, and update time; at the same time, the overall display of the operation items is optimized.
2. New audit event jump link in the list: A new audit event jump link is added to the list operation bar, and you can click to view the corresponding audit event.
3. Account management display adjustment: The password item is not displayed under the single sign-on user's "Account Management" menu.

### Bug Fixes {#bugs0904}

1. Resolved the issue where the local Function as a data source did not link the time range to the time widget when querying.
2. Resolved the issue where the display order of the PromQL data query results was incorrect.
3. Resolved the issue where the filter components for monitor and chart queries were not unified.
4. Resolved the issue where clicking on the smart monitoring-related events from the incidents entry would display them in the non-smart monitoring event list, resulting in no query results.
5. Resolved the issue where the Lark incidents Webhook integration had no data and no callback.
6. Resolved the issue of the decimal unit display number.
7. Resolved the issue where the explorer analysis mode could not search for fields when adding filter conditions.
8. Resolved the issue where creating an Issue from a monitoring event had no source link.
9. Resolved the issue of log export to CSV failure.
10. Resolved the issue of not receiving high consumption warning email notifications.
11. Resolved the issue where switching channels in incidents did not change the Issue list.
12. Resolved the issue where the log explorer would report an error when selecting indexes a and b with the same field names (case insensitive) in the log index.

### Deployment Plan Updates

1. Customizable return quantity for charts: Time series charts, pie charts, table charts, toplists, tree maps, and China/World maps support customizable return data quantities, with no maximum limit, to meet different data presentation needs.
2. Management backend > Datakit management: support for exporting Datakit inventory.

## August 21, 2024

### Breaking Changes {#breakingchanges0821}

- OpenAPI / Global API: The data source for "Events" unresolved events has been changed from `UE` to `E`.

### New Features {#new0821}

- Management: A new [Client Token](../management/client-token.md) management portal has been added, allowing users to replace the system's default-generated Token with a custom-created Token when using the public DataWay to access RUM applications.

![](img/overall-token.png)

### Continuous Optimization {#consistent0821}

- Incidents:
    - A new [Issue Discovery](../exception/config-manag.md#auto-issue) page has been added. With this feature, you can customize the specific rules for Issue discovery, manage and filter the exceptions detected by the monitor rules and related data. Treat a series of events as caused by a single reason, set filter conditions for these events, and then select aggregation dimensions to further refine the data. After refinement, the data will be aggregated according to the detection frequency you set. Finally, the system will automatically push this information to the specified channel based on the preset Issue title and description, ensuring that all relevant parties can receive and effectively handle these Issues in a timely manner.
    - Configuration > Strategy: The strategy list now displays creation/update information.

### Regular Updates {#usual0821}

- Data Retention Policy:
    - The original "Application Performance" item is split into "Application Performance-Trace" and "Application Performance-Profile", allowing users to configure the retention policy for Trace data and Profile data separately;
    - The original "Data Forwarding" name is changed to "Data Forwarding-Guance".

- [Unrecovered Event Explorer](../events/event-explorer/unrecovered-events.md):
    - The data source is changed to query event data, aggregated by `df_fault_id` as the unique identifier, and the latest data result is returned for display.
    - Overall UI transformation of the page.
- Application Performance Monitoring (APM) > Trace: [Service Map](../application-performance-monitoring/explorer/explorer-analysis.md#call) adds the ability to bind built-in views, and by clicking on the service card, you can quickly view the related user views associated with the service.
- Management:
    - New "Workspace Description" added;
    - In edit mode, the interaction changes to open a new window;
    - The workspace list now supports searching for and locating workspaces by name or description.
- Logs > BPF Logs > Layer 7 BPF Network Logs: The UI of the network request topology diagram is optimized, highlighting the distinction between the server and client sides.
- Synthetic Tests > HTTP Monitoring > Advanced Settings > Request Settings now include `Accept-Encoding: identity` by default.

### Deployment Plan Updates

- A new [Test Node Management](../deployment/task.md) portal has been added, supporting the creation of platform-level test nodes and unified management of all nodes through the node list. Test nodes created through this portal support configuring both Chinese and English node names, adapting to the display and reporting data results of domestic and foreign sites of Guance.

![](img/task.png)

- Data Retention Policy:

    - Considering users' storage cost factors, they may need to customize the retention duration of this data. The deployment plan management backend now includes a new "Session Replay" configuration item.
    - The original "Data Forwarding" name is changed to "Data Forwarding-Default Storage";
    - The original "Application Performance" item is split into "Application Performance-Trace" and "Application Performance-Profile",

## August 7, 2024

### New Features {#new0807}

- Real User Monitoring (RUM): Added [Heatmap](../real-user-monitoring/heatmap.md). Visually present the interaction between visitors and the website, capturing click data and positions on page elements to understand user focus points.

- Application Performance Monitoring (APM) > Traces: Added a [Setup Guide](../application-performance-monitoring/explorer/index.md) page.

- Monitoring: Added a new detection type — [Interval Detection V2](../monitoring/monitor/interval-detection-v2.md), which uses the historical data of monitoring metrics to establish a confidence interval for predicting the normal fluctuation range.

### Continuous Optimization {#consistent0807}

- Incidents:
    - Configuration > Strategy: Added an [Audit and Execution Log](../exception/config-manag.md#check-events) viewing portal. When receiving Issue notifications, if there are issues with notifications not being sent properly or doubts about the notification policy, you can check the current notification policy's operation audit events and execution log data for judgment.
    - APM / RUM > [Issue Auto Discovery](../application-performance-monitoring/error.md#issue) supports adding filter conditions;
    - For the deployment plan, added a [Unified Management of Incidents Levels](../deployment/setting.md#global-settings) portal;
    - Schedule:
        - On the schedule editing page, different notification targets will automatically generate colors;
        - In schedule management: Added statistical counts for My Schedule and All Schedules.

### Regular Updates {#usual0807}

- Monitoring > [SLO](../monitoring/slo.md#slo):
    - Added tag configuration, which ultimately affects the event data information generated;
    - Configuration optimization: By setting the range of the 7-day achievement rate for Target and Minimum Target, determine the generation of warning or emergency events;
    - Support sending alarm notifications through associated Alerting Policies.
- Synthetic Tests:
    - Added tag configuration for probe tasks;
    - Optimized the [Test Module](../usability-monitoring/request-task/http.md#test) on the probe task configuration page;
    - Added a [Quick Filter](../usability-monitoring/request-task/index.md#manag) module to the list;
- Explorer: Support exporting CSV files in analysis mode.
- Infrastructure > Containers: Added a process association page display.

### Bug Fixes {#bugs0807}

- Resolved the issue where the billing count for "Task Call" was not displayed;
- Resolved the "Left * Match" issue during chart queries;
- Resolved the issue where BPF network log data did not include container-related information;
- Resolved the central Pipeline failure issue.

### Breaking Changes {#breakingchanges0807}

- OpenAPI:
    - The SLO creation/modification interface adds `tags`, `alertPolicyUUIDs`, and deprecates the `alertOpt` parameter;
    - The SLO detail and list interface return results, adding `tagInfo`, `alertPolicyInfos` fields, discarding the `alertOpt` field.

## July 24, 2024

### Guance Updates

- Incidents:
    - Added an [Analysis Dashboard](../exception/issue-view.md): Visually display different metrics data.
    - Added [Schedule](../exception/calendar.md) management and [Strategy](../exception/config-manag.md#notify-strategy): Further allocate notifications based on the content scope of Issues.
- Scenes:
    - Charts: Added a [Time Offset](../scene/visual-chart/timeseries-chart.md#advanced-setting) setting. After enabling the time offset, when querying a relative time range, the actual query time range is shifted forward by 1 minute to prevent data retrieval gaps due to delays in data warehousing.
    - Dashboards: Added a [Historical Snapshot](../scene/dashboard.md#historial-snapshot) entry.
    - Snapshots: When saving snapshots, automatically capture the selected time range on the current page; when sharing snapshots, you can choose to allow explorers to change the time range.

- Monitoring:
    - Infrastructure Uptime Detection V2: Added [Additional Information](../monitoring/monitor/infrastructure-detection.md#config). After selecting fields, the system will perform additional queries, but they will not be used for triggering condition judgments.
    - Notification Targets: Added an "Operation Permission" option configuration, controlled by a switch to manage the operations (edit, delete) of notification targets.

## July 10, 2024

### Guance Updates

- Scenes:
    - [View Variables](../scene/view-variable.md#add):
        - Added a configuration item switch: Including `*` options.
        - When hiding view variables, the list adds a hidden identifier.
    - Dashboards: [Grouping](../scene/dashboard.md#group) components support color configuration.
    - Charts: Alias functionality covers leaderboards, tree maps and Sankey diagrams.
    - Dashboards/Explorers/Built-in Views: Added [Card Metadata](../scene/dashboard.md#metadata) information, optimizing editing configuration.
- Monitoring:
    - Notification Targets: Configure [Webhook Notification targets](../monitoring/notify-object.md#custom-webhook), supporting the addition of member information.
    - Application Intelligent Detection: Added tracking of historical changes, filtering periodic abnormal data mutations; added the number of users affected by abnormal service associations.
- Events > [Event List Explorer](../events/event-explorer/event-list.md): Added alert notification status identifiers to the display columns.
- Logs:
    - Indexes: When binding [SLS External Indexes](../logs/multi-index.md#sls), added access type selection, supporting custom public or internal network access;
    - Log Explorers: [Cluster Analysis](../logs/explorer.md#cluster) mode supports exporting displayed column data and associated log page data.

### Guance Deployment Plan Updates

- Added a global [Function Menu](../deployment/menu.md), supporting custom console display menu scope, and synchronization to the workspace function menu bar.
- [Templates](../deployment/integration.md): Optimized the upload logic of custom template management.

## June 26, 2024

### Guance Updates

- [Pipelines](../pipeline/index.md): Support selecting the central Pipeline to execute scripts.
- Billing: Added a [Central Pipeline Billing Item](../billing/billing-method/index.md#pipeline), tallying the data size of all raw logs processed by the central Pipeline.
- Monitoring:
    - Notification Targets: Added [Permission Control](../monitoring/notify-object.md#permission). After configuring operational permissions, only targets with granted permissions can edit or delete this notification target.
    - Intelligent Monitoring > Log Intelligent Detection: Added tracking of historical changes, filtering periodic abnormal data mutations.
- Logs:
    - [Data Access](../logs/logdata-access.md#config): Added access permission configuration for logs indexes authorized for viewing.
    - Log Explorers: Display column expansion, supporting [adding JSON object field content](../logs/explorer.md#json-content) to the first-level return display.
    - [BPF Network Logs](../logs/bpf-log.md):
        - Optimized connection display effects;
        - Support direct jumping to the detail page;
        - Support custom adding of display columns.
- Scenes:
    - Time Series Charts: Line charts and area charts added [Breakpoint Connection](../scene/visual-chart/timeseries-chart.md#breakpoint) settings, bar charts added a [Show Return Value] button.
- [Synthetic Tests](../usability-monitoring/request-task/index.md#manag): Added column header sorting to the task list.
- DataFlux Func: Support the integration of Guance incidents scripts with [DingTalk Applications](https://func.guance.com/doc/script-market-guance-issue-dingtalk-integration/).

### Guance Deployment Plan Updates

- Profile: Through configuration parameters, supports two types of storage: file storage and object storage.

## June 13, 2024

### Guance Updates

- [BPF Network Logs](../logs/bpf-log.md): Enhanced BPF networking capabilities, strengthening L4/L7 network interconnectivity.
- APM/RUM: Introduced the new feature [Issue Auto Discovery](../application-performance-monitoring/error.md#issue). Once this configuration is enabled, Guance will automatically create Issues for error data records that meet the specified rules.
- Monitoring:
    - Intelligent Monitoring: Added [Kubernetes Intelligent Detection](../monitoring/intelligent-monitoring/k8s.md): Automatically detect anomalies in Kubernetes through intelligent algorithms, with detection metrics including total number of Pods, Pod restarts, APIServer QPS, etc.
    - Alert Strategies:
        - Added new [Filtering](../monitoring/alert-setting.md#filter) capabilities. When configuring alert rules, this feature allows for more granular filtering conditions on top of the existing severity levels, ensuring that only events matching both the severity level and filter conditions are sent to the corresponding notification targets.
        - Support for selecting external email addresses as notification targets.
    - Monitors > Event Content: Support custom input of external email addresses.
- Scenes:
    - Topology Diagrams: Added new link configurations.
    - Sankey Diagrams: Increased the number of supported node configurations from a maximum of 4 to 6.
- Pipelines: Added display of filtering conditions in lists.
- Logs > Indexes: Optimized list display.

### Guance Deployment Plan Updates

- Profile: File size has been changed from a fixed 5MB to support custom sizes. See [How to Configure](../deployment/application-configuration-guide.md#studio-front).

## June 3, 2024

### Guance Updates

- Management > [Cross-Workspace Authorization](../management/data-authorization.md#site): Added a new Data Scope section in the addition page, supporting multi-select data types.
- Logs > Log Explorer: Support [Cross-Workspace Index Queries](../logs/cross-workspace-index.md), enabling quick access to log data from other spaces, thereby breaking through the limitations of log data storage locations and significantly enhancing the efficiency of data analysis and fault localization.

## May 29, 2024

### Guance Updates

- [DCA](../dca/index.md)
    - Support private deployment, with direct access to the DCA console via the workspace page button.
    - Support batch management capabilities.
- Incidents:
    - Webhook Reception Channel: Support new and modified notifications for Issue replies.
    - Support selecting teams or adding external email addresses as Issue handlers.
- Logs > [Contextual Logs](../logs/explorer.md#up-down): Modified query logic; support further query management of related data through the contextual log details page.
- Scenes:
    - View Variables: Group titles/chart titles support configuration to display `#{View Variable}`.
    - Time Series Charts > Analysis Mode: Support adjusting the time interval.
    - Dashboards/Custom Explorers: Display a search box when there are more than 20 tags; display colors before tag names.
- Monitoring:
    - Monitors/Intelligent Monitoring/Mute Management > Quick Filters: A search box appears when there are more than 20 values, supporting search and location.
    - Monitors: For PromQL query detection, automatically list available template variables in event notifications.
- Infrastructure > Networking: Network detail pages > Network analysis supports displaying statistics in two dimensions: `ip:port` and `ip`.
- Application Performance Monitoring > Services > Create/Modify Service Inventory: Increased format validation when filling in repository links and documentation links.

#### Breaking Changes

- Management > Attribute Declaration: Custom attribute field values are adjusted to be stored as string types.

### Guance Deployment Plan Updates

- [Templates](../deployment/integration.md): Added an import template entry, with template scope including view templates, monitor templates, custom explorer templates, and Pipelines. Support deployment users to change custom templates to platform-level templates for use by other workspaces.
- Users: Optimized batch operation interactions.

## May 15, 2024

### Guance Updates

- Monitoring:
    - Monitors > [Mutation Detection](../monitoring/monitor/mutation-detection.md) > Detection Metrics: Support for the "compared to the previous period" option, enabling final comparison of data within a fixed time frame.
    - [Mute Management](../monitoring/silent-management.md): Added "Additional Information" feature, supporting the addition of explanatory notes for silent rules, thereby identifying the reasons or sources of silence, etc.
    - Intelligent Monitoring > Host Intelligent Monitoring: Added two new detection dimensions: network traffic and disk IO.
- Scenes > Dashboards:
    - [View Variables](../scene/view-variable.md): Optimized editing page styles, supporting the definition of drop-down single-select and multi-select.
    - Grouped Table Charts, Metric Analysis > Table Charts support multi-column query result display adaptation, such as
    ```
    L::RE(`.*`):(count(*),message,host) {index = 'default' and status = 'error'} BY source,service
    ```
- Explorers:
    - Log Explorers > [Contextual Logs](../logs/explorer.md#up-down) support microsecond-level data query filtering, solving the issue of multiple data entries at the same moment (milliseconds), preventing accurate positioning and display of a specific log context.
    - All explorers support selecting to [export](../getting-started/function-details/explorer-search.md#csv) data quantities as CSV files.
    - Added explorer search query audit events, i.e., manually initiated query operations by users are recorded in audit event logs.
- Services: Moved from the original path [Scenes] to "Application Performance Monitoring", optimizing the user experience.
- Metric Generation: Support configuring multiple by groupings without quantity restrictions.
- DQL Queries: Expression queries support specified value filling, supporting result filling for sub-queries and final value filling.
- Real User Monitoring > Android: Optimized application configuration display.
- Events: Added a new associated view jump entry on the detail page. In cases where there is no detection dimension data, you can jump to the explorer from the detail page for review.

### Guance Deployment Plan Updates

- Added a [DataKit Inventory Management](../deployment/setting.md#datakit) page.
- When configuring single sign-on for deployment, support customizing login [display titles, descriptions and logos](../deployment/azure-ad-pass.md#config).
- Users: Added extended attribute configuration.
    - Support for local users to directly configure attributes on the edit page.
    - Support for automatically appending third-party user attribute configurations to Guance via the userinfo interface during single sign-on.

## April 24, 2024

### Guance Updates

- Management:
    - Introduced [Cloud Account Management](../management/cloud-account-manag.md): Centralize all enterprise cloud service accounts for unified management, distinguished by the uniqueness of certain configurations under the accounts. By configuring integrated collectors, each cloud service under the account can be managed independently, achieving refined control over business data.
    - Account Management: Adjusted the [Account Login Expiry Time](../management/index.md#login-hold-time).
- Added a [Quick Search](../management/index.md#quick-entry) pop-up, allowing for quick viewing of recently visited pages within the current workspace and pages related to various features.
- Infrastructure > Containers: Added two new object explorers: Statefulset and Persistent Volumes.
- Incidents:
    - Added Issue owner configuration, with Guance sending email notifications to the owner.
    - Channels: Support [Upgrade Configuration](../exception/channel.md#upgrade). That is, if a new Issue remains unassigned for a specific number of minutes, an upgrade notification is sent to the corresponding notification target.
- Monitoring:
    - Monitors: Detection configuration: Support triggering event generation again after multiple consecutive trigger conditions are met.
    - [Mute Management](../monitoring/silent-management.md):
        - Optimized display of silent rule list pages: Support listing all silent rules in the current workspace, with quick filtering to display target rules.
        - Event attribute matching supports inverse selection, with selection formats as follows: `attribute:value`, `attribute:*value*`, `‑attribute:value`, `‑attribute:*value*`, where different field combinations relate as AND, and multiple values for the same field relate as OR.
- The meaning of the DQL `match` function has been changed to `exact match`. This change only applies to the new engine, used in both the explorer and monitor scenes.
    - Explorer scenario example: `host:~cn_hangzhou`.
    - Monitor scenario example:
    ```
    window("M::`cpu`:(avg(`load5s`)) { `host` = match('cn-hangzhou.172.16.*') } BY `host`", '1m')
    ```
- Scenes > Dashboards [Charts](../scene/visual-chart/index.md#download) can now be directly downloaded as PNG images, and table charts can also be exported as CSV files.
- Logs > Index Binding: The Field Mapping has been changed to an optional field.
- Integrated/Built-in Views: New tag management added to templates.
- Service Map Cross-Workspace Node [Style Display Adjustment](../application-performance-monitoring/service-manag.md#servicemap).

### Guance Deployment Plan Updates

- Management > Basic Information > License Information: DataKit quantity limits support adjustment according to data statistics scope, changed to the number of hosts or DKs with a survival time >= 12 hours.
- Support for configuring a blacklist, customizing the selection of imported Guance integrations, view templates, and monitor templates.

### OpenAPI Updates

- Pipelines [Add](../open-api/pipeline/add.md)/[Modify](../open-api/pipeline/modify.md): Added profiling type;
- User Views [Add](../open-api/inner-dashboard/add.md)/[Modify](../open-api/inner-dashboard/modify.md): Support binding to dashboard configurations.

## April 10, 2024

### Guance Updates

- Monitoring > Monitor > New: Added Data Gap and Information Generation configuration areas to better distinguish between abnormal data and data gaps.
- Management: Added a System Notifications page, which displays abnormal status messages for all configurations in the current workspace under the current account.
- Scenes:
    - Chart Queries: Added Rollup Function, which is also applicable to Metric Analysis and Query Tools;
    - Dashboards/User Views: Added Pin feature. Under the premise that the current workspace is authorized to view data from several other workspaces, it supports setting the query of other workspace data as the default option.
    - System Views: Support cloning to create dashboards or user views;
    - Custom Explorers: Optimized search mode; when not in edit mode, hovering over Data Range displays all filter conditions.
- Explorers > [Quick Filters](../getting-started/function-details/explorer-search.md#quick-filter):
    - Added Dimension Analysis button, which quickly switches to the explorer analysis mode upon clicking;
    - Support directly adding the current field to the display column or removing it from the display column by clicking external buttons.
- [Experience Plan](../plans/trail.md#upgrade-entry): Added an Upgrade Now button.
- Infrastructure > Containers > Honeycomb Chart: Added two new metric filling methods: CPU Usage Rate (standardized) and MEM Usage Rate (standardized).

### Guance Deployment Plan Updates

- Workspace Management: Added Data Reporting Restrictions to help stakeholders save on resource usage costs.

## March 27, 2024

### Guance Updates

- Monitoring:
    - Alert Strategies: Each notification rule (including default and custom notifications) configuration adds Support for Upgrade Notification Conditions.
    - Monitors > Event Content: Added Custom Advanced Configuration, supporting the addition of associated logs and error stacks;
    - Host Intelligent Monitoring: Changed the current mutation display to a predictive method based on cycles for abnormal alerts, with trend charts showing current metrics and confidence interval boundaries, highlighting abnormalities exceeding the confidence interval in red.
- Scenes > Charts: Added Topology Maps.
- APM > Trace Detail Page > [Service Call Relationship](../application-performance-monitoring/explorer/explorer-analysis.md#call): Adjusted to service topology display, showing the number of calls between services.
- Data Retention Policy: The data retention policy for Session Replay is linked with the RUM policy, meaning if RUM data is saved for 3 days, Session Replay data is also saved for 3 days.
- Explorers:
    - Event Explorer > Basic Properties: Added configuration for whether to display detection metrics, cached locally for global adaptation;
    - APM > Error Tracking > Cluster Analysis > Detail Page: Support creating incidents Issues;
    - RUM > Error > Cluster Analysis > Detail Page: Support creating incidents Issues;
    - RUM > View > Detail Page:
        - Performance: Added an All Entries option, listing all associated data under the current View;
        - Fetch/XHR: Clicking on a data row supports opening the corresponding trace detail page or Resource detail page.
    - Time Widget: When obtaining the "current time," it is accurate to milliseconds.
- Management > [Tickets](../management/work-order-management.md):
    - Added star ratings and reviews;
    - Adjusted feedback tickets to automatically close if there is no customer feedback within 7 days;
    - Support for exporting ticket lists;
    - Tickets in Completed or Revoked status can be restarted;
    - After account deactivation, tickets submitted under it that are still open will be automatically closed.
- Optimized the overall process for cloud market access.

### Guance Deployment Plan Updates

- Data Retention Policy: Support configuration of data retention policies by workspace owners, including custom input of retention durations. Use cases include:
    - Metric Management > Measurements;
    - Logs > Indexes > New.
- Users: Support inviting members via email account.



## March 13, 2024

### Guance Updates

- Monitoring > Monitors: Monitor type [Composite Detection](../monitoring/monitor/composite-detection.md) was launched. It supported combining the results of multiple monitors into one through expressions, and finally alerting based on the combined results.
- Service > Service Map: [Cross-workspace Servicemap query](../scene/service-manag.md#servicemap) was supported.

### Deployment Plan Updates

- Management > Basic Information: "Used DK Quantity" display was added;
- Management > Users: The page [Group](../deployment/user.md#team) was added, based on group can configure associated workspace and role, users can get access to corresponding workspace through group.

## March 6, 2024

### Guance Updates

- Monitoring
    - Monitor > Detection Frequency: [Crontab Custom Input](../monitoring/monitor/detection-frequency.md) was enabled, meeting the need for detection only at specific times;
    - Mutation Detection: "Last 1 Minute" and "Last 5 Minutes" detection intervals were added;
    - Mute Management: When selecting a mute range, "Event attributes" was not required, and users could configure more granular matching rules as needed.
- DataFlux Func: [External Functions](../dql/dql-out-func.md) were added. Allowed third-party users to fully utilize Function's local cache and local file management service interface to write functions, and execute data analysis queries within the workspace.
- APM > [Traces](../application-performance-monitoring/explorer.md):
    - Title area UI display was optimized;
    - For flame graphs, waterfall charts, and Span lists with more than 10,000 Span results, users could view unshown Spans through Offset settings;
    - Error Span filtering entry was added; support for entering the resource name or Span ID corresponding to Span for search matching was supported.
- Scene
    - Charts: [Sankey diagram](../scene/visual-chart/sankey.md) was launched;
    - View Variables: Selected button was added, checked by default to select all current values, can be unchecked as needed.
- Account Management: [Account Deletion](../management/index.md#cancel) entry was added.
- Explorers:
    - UI display was optimized;
    - Regular match / reverse regular match mode were added in the filter function;
    - Wildcard filter and search supported Left * match.
- Events > Detail Page: "Alert Notification" tab page UI display was optimized.

### Guance Deployment Plan Updates

- [Login method selection](../deployment/setting.md#login-method) for unified management of login methods was added;
- [Delete](../deployment/user.md#delete) operation for local accounts and single sign-on accounts was added.

## January 31, 2024

### Guance Update

- Monitoring:
    - [Intelligent Monitoring](../monitoring/intelligent-monitoring/index.md):
        - The intelligent detection frequency of hosts, logs, and applications was adjusted to once every 10 minutes, and each detection calculation counted as 10 call costs;
        - To improve the accuracy of the algorithm, logs and application intelligent detections used the method of data rollover. After an intelligent monitor was turned on, the corresponding measurement and metric data were generated. This adjustment generated additional timelines, the specific number was the number of detection dimensions (service, source) * detection metric number filtered by the current monitor configuration. Since there was no storage of the monitor's filter conditions, if the monitor filter condition configuration was modified, an equal amount of new timelines was generated, so there was a situation of duplicate timeline billing on the day of modifying the monitor filter condition configuration, and it returned to normal the next day.
    - Alert Strategies:
        - Added [custom notification time configuration](../monitoring/alert-setting.md#custom), refine alert notification configuration by cycle, time interval;
        - Added new event option "Permanent" in Renotification.
    - Monitors
        - Alert Configuration: multiple alert strategies was supported; if multiple were configured, `df_monitor_name` and `df_monitor_id` were presented in multiple forms, separated by `;`;
        - Related issues: Added "Synchronously create Issue" switch, when an exception event recovers, it synchronously recovers the incidents issue;
        - Added [Clone Button](../monitoring/monitor/index.md#options) in Monitor List.
    - Notification Targets: Added [Simple HTTP Notification Type](../monitoring/notify-object.md#http), directly receive alert notifications through the Webhook address;
- Scenes:
    - Charts: Added Currency option; Advanced Configuration > Same Period Comparison changed to `YoY`;
    - Service Management > Resource Call: Added TOP / Bottom quantity selection in the ranking.
- Explorers: Added "Time Column" switch in Display Column > Settings.
- Billing:
    - Added [New Workspace](../billing/cost-center/workspace-management.md#lock) Entry in Workspace Lock popup page;
    - Optimized AWS Registration Process.

### Guance Deployment Plan Updates

- Supported [LDAP Single Sign-On](../deployment/ldap.md);
- Workspace Management > Data Storage Strategy: Added Custom Option, with its range less than 1800 Days (5 Years); Among them, the metric added optional items 720 days, 1080 days and other storage durations;
- Users: Supported one-click configuration assignment of workspace and role for user accounts;
- Added Audit Event Viewing Entry, enabling to view all workspace related operation audits;
- Added Management Background MFA Authentication.

## January 11, 2024

### Guance Updates

- Logs:
    - Added BPF Network Log Collection and Log Detail Page; JSON Format conversion was supported; Readable Display Mode was enabled in details page;
    - You could bind "Related Network Log";
    - Data Access: Batch Operation was added.
- Regular Reports: Added optional sharing method "Public Sharing" or "Encrypted Sharing".
- Dashboards:
    - View Variable: Added "All Variable Values" parameter option was added;
    - Time Series Chart: Added sorting logic (new engine only); support sorting returned results.
- Generate Metrics: Supported Batch Operation; standard and above permissions members supported cloning.
- Monitors:
    - Notification Targets: adapt New DingTalk Robot; "secret" option was not required when creating, quickly associating DingTalk Robot.
    - Optimized SLO deduction logic was optimized.
- RUM: Public network Dataway supports IP conversion to geographic location information.