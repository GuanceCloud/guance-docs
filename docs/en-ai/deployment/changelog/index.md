# Version History

## 1.106.192 (March 5, 2025) {#1.106.192}

pubrepo.guance.com/dataflux/1.106.192:launcher-d438422-1741176806

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.106.192.tar.gz
    - MD5: `108ade865cc48ddb47e81cc29a101ef1`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.106.192.tar.gz
    - MD5: `26cce1d476048898c261b3a7bbe9a2fc`

### Deployment Plan Update {#feature0305}

- Fixed some bugs

For more product feature updates, please refer to the [Change Log -> February 27, 2025](../../release-notes/index.md#20250227)

## 1.105.191 (February 27, 2025) {#1.105.191}

pubrepo.guance.com/dataflux/1.105.191:launcher-b3bee84-1740751379

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.105.191.tar.gz
    - MD5: `0882e8fa58ebdbf6597c0943455b49b1`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.105.191.tar.gz
    - MD5: `bf7acef9f04550d8e199a287b6080445`

For more product feature updates, please refer to the [Change Log -> February 27, 2025](../../release-notes/index.md#20250227)

## 1.104.190 (February 19, 2025) {#1.104.190}

pubrepo.guance.com/dataflux/1.104.190:launcher-f574b1d-1740401808

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.104.190.tar.gz
    - MD5: `c75a12066300d28f85912128bf5e4b6f`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.104.190.tar.gz
    - MD5: `9fc1d397413d9a49c1f9fc2362a7301c`

???+ attention Important Version Dependency Update Notice

    ### Minimum Version Requirements for GuanceDB Components in This Deployment Plan

    #### GuanceDB for Logs
    - guance-select: v1.11.4+
    - guance-insert: v1.11.4+

    #### GuanceDB for Metrics
    - guance-select: v1.11.4+
    - guance-insert: v1.11.4+
    - guance-storage: v1.11.4+

### Breaking Changes {#breakingchanges0219}

The `df_meta` event will no longer retain `alert_info` related information. Users who previously relied on this information to retrieve notification targets should switch to using the newly added fields `df_alert_info` (incident alert notifications), `df_is_silent` (whether muted), and `df_sent_target_types` (incident notification target types) to achieve the corresponding functionality.

Potential affected use cases:

1. Custom use cases of obtaining events via OpenAPI to integrate with external systems.
2. Custom use cases of forwarding events to external systems via Webhook notifications.

### Deployment Plan Update {#feature0219}

- Launcher now supports one-click pause for all monitors to prevent false alarms during upgrades. Note: This feature is supported after upgrading to version 1.104.190.

For more product feature updates, please refer to the [Change Log -> February 19, 2025](../../release-notes/index.md#breakingchanges0219)

## 1.103.189 (January 16, 2025) {#1.103.189}

pubrepo.guance.com/dataflux/1.103.189:launcher-d4a5efc-1737455050

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.103.189.tar.gz
    - MD5: `e3c0d6aa1ca3e063575aeb1c7c6cf2da`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.103.189.tar.gz
    - MD5: `1edf1c249834224b0ee2fa49e2280927`

### Feature Updates {#feature0116}

#### User Access Monitoring

1. Added [Funnel Analysis](../../real-user-monitoring/user_insight_funnel.md) function: Users can create funnels by defining conversion steps, view data conversion, and perform in-depth analysis.
2. Integrated User Insight Module: Added a user insight module that consolidates heatmaps and funnel analysis, providing comprehensive user behavior analysis tools.
3. Added Mobile SourceMap Restoration: Android and iOS applications support uploading SourceMap files on pages and viewing restored data in error viewers.

#### Application Performance Monitoring

APM adds service installation guide for [automatic host injection](../../application-performance-monitoring/explorer/auto_wire/autowire_on_host.md), simplifying the installation process.

#### Integration

1. DataKit (Data Collection Tool): The DataKit installation page now includes Docker installation guidance, offering more diverse installation options.
2. External Data Source Optimization: Added query specification prompts when querying SLS data sources, helping users perform more accurate data queries.

#### Use Cases

[Combined Charts](../../scene/visual-chart/index.md#conbine) Optimization: Combined charts now support view variable configuration, allowing selection of dashboard view variables to be applied to these combined charts, enabling more flexible data filtering and analysis.

#### Monitoring

Spike Detection Monitor: Added support for week-over-week and month-over-month comparison of query cycles.

#### AI Intelligent Assistant

Added DataFlux Func knowledge base.

#### Pipeline

Optimized auto-generated Pipeline: Supports interactive parsing of Pipelines using both structured and natural language.

### Bug Fixes {#bug0116}

1. Fixed display issues in log stacking mode.
2. Fixed misalignment of input boxes in log detection monitors.
3. Fixed errors in metric calculations.
4. Fixed the issue where Volcengine did not support `having` statements.
5. Fixed errors when selecting "Request Error Rate" and "Average Requests per Second" metrics in APM.
6. Fixed the issue where the `not in` statement was ineffective in Volcengine's underlying platform.
7. Fixed performance issues caused by large event list data affecting page load speed.
8. Fixed unexpected behavior of one-click recovery for Hangzhou site events.


## 1.102.188 (January 8, 2025) {#1.102.188}

pubrepo.guance.com/dataflux/1.102.188:launcher-0bd0be5-1736856269

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.102.188.tar.gz
    - MD5: `07d82df7e9a6ccb4ba747e8cb02d0882`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.102.188.tar.gz
    - MD5: `e5ee7933fd1f46ae9df5d05219b4726d`

### Deployment Plan Update {#deployment0108}

1. Deployment tool `Launcher` Optimization:
    - Fixed unit errors in CPU cores and memory bytes in the "Resource Configuration" section of the "Workload Configuration" function.
    - Optimized the confirmation dialog repetition issue when restarting workloads.
2. Management Backend > Workspace Menu Optimization:
    - Added main storage engine and business filters in the workspace list for easier workspace filtering.
    - Optimized pagination logic on the workspace list page to stay on the current page after modifying or deleting a workspace or changing its data reporting limits, improving query experience.
3. Added new parameter `alertPolicyFixedNotifyTypes` in Deployment Plan, supporting configuration of whether to display the "Email" notification option in alert policies. [Configuration Reference](/deployment/application-configuration-guide/#studio-backend).

### OpenAPI Updates {#openapi0108}

1. Field Management: Supports retrieving field management lists, and [adding](../../open-api/field-cfg/add.md)/[modifying](../../open-api/field-cfg/modify.md)/[deleting](../../open-api/field-cfg/delete.md) fields.
2. Synthetic Tests: Supports [modifying](../../open-api/dialing-task/modify.md) synthetic test tasks.
3. Incident > Schedule: Supports retrieving schedule lists, and [creating](../../open-api/notification-schedule/add.md)/[modifying](../../open-api/notification-schedule/modify.md)/[deleting](../../open-api/notification-schedule/delete.md) schedules.
4. Incident > Configuration Management: Supports retrieving notification policy lists, and [creating](../../open-api/issue-notification-policy/add.md)/[modifying](../../open-api/issue-notification-policy/modify.md)/[deleting](../../open-api/issue-notification-policy/delete.md) notification policies; supports retrieving Issue discovery lists, and [creating](../../open-api/issue-auto-discovery/add.md)/[modifying](../../open-api/issue-auto-discovery/modify.md)/[enabling/disabling](../../open-api/issue-auto-discovery/set-disable.md)/[deleting](../../open-api/issue-auto-discovery/delete.md) Issue discovery configurations.

### Feature Updates {#feature0108}

#### Logs

1. Log Index Optimization:
    - When accessing built-in views and log context tabs, the default selected index will be the current log index and `default` index respectively. Both tabs support multi-selection of indices. Additionally, after enabling cross-workspace queries and selecting authorized workspaces from the menu, you can directly query index data from the corresponding workspaces. This helps users view associated log data on a single page, optimizing log query interactions.
    - In addition to the top-pinned `default` index, other log indices are listed alphabetically from A-Z.
2. Added Stack [View Mode](../../logs/manag-explorer.md#mode) to Log Viewer: In stack mode, fields are consolidated into a single column and displayed as rows within cells. This makes log information more compact and clear, facilitating quick browsing and analysis.
3. Log Pipeline Optimization: Test samples for log pipelines now include all fields of the log, and must be entered in line protocol format. User-entered logs must also follow the required format.

#### Use Cases

1. [Table Chart](../../scene/visual-chart/table-chart.md) Optimization:
    - Multi-metric Query Sorting Support: When performing multi-metric queries using a single DQL, table charts now support sorting.
    - Table Pagination Selection: Added pagination selection for tables, allowing users to choose appropriate page sizes based on data volume and viewing needs.
2. Combined Charts: Supports adjusting the order of charts.
3. Chart Optimization: Adjusted the function order in the DQL query component, emphasizing the usage scenarios of Rollup functions to help users better utilize them for data aggregation and analysis.

#### Management

1. Events support configuring [data forwarding](../../management/backup/index.md): Configure data forwarding rules for specific event types, saving filtered event data to <<< custom_key.brand_name >>> object storage or forwarding it to external storage, providing flexible event data management capabilities.
2. Added DataKit [Environment Variables](../../management/env_variable.md) in Workspaces: Workspaces now support managing DataKit environment variables, allowing easy configuration and updates for remote synchronization of DataKit collection settings.
3. Query [Audit Events](../../management/audit-event.md) Optimization: Added multiple fields to record query information, including time ranges, enhancing tracking and analysis of query behaviors.

#### Pipeline

Optimized auto-generated Pipeline: Changed the way hints appear, improving product experience.

#### AI Intelligent Assistant

AI Intelligent Assistant added [Chart Generation](../../guance-ai/index.md#chart): Based on large models, it automatically analyzes user input text data and intelligently generates appropriate charts, solving problems like cumbersome manual chart creation and difficulty in choosing the right chart type.

#### Monitoring

[Alert Policies](../../monitoring/alert-setting.md#member): Supports adding names to member-configured notification rules for descriptive purposes.

### New Integrations {#inte0108}

1. Added [AWS Gateway Classic ELB](../../integrations/aws_elb.md);
2. Added [Volcengine TOS Object Storage](../../integrations/volcengine_tos.md);
3. Modified AWS Classic Collector Name;
4. Added [MinIO V3](../../integrations/minio_v3.md) integration;
5. Updated Elasticsearch, Solr, Nacos, InfluxDB V2, MongoDB integrations (views, documents, monitors);
6. Updated Kubernetes monitoring views.

### Bug Fixes {#bug0108}

1. Resolved the issue where cross-space authorization for event data was not effective.
2. Resolved the issue where clicking on a link to trace details with `trace_id` failed to retrieve data.
3. Resolved the issue where value filling was not possible in expression queries.
4. Resolved the issue where changes to alert policies in external event detection monitors did not generate audit records.
5. Resolved the issue where column widths in the event display list could not be adjusted.