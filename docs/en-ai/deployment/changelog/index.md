# Version History

## 1.105.191 (February 27, 2025) {#1.105.191}

pubrepo.guance.com/dataflux/1.105.191:launcher-b3bee84-1740751379

### Offline Image Package Download

- AMD64 Architecture Download: https://<<< custom_key.static_domain >>>/dataflux/package/guance-amd64-1.105.191.tar.gz
    - MD5: `0882e8fa58ebdbf6597c0943455b49b1`

- ARM64 Architecture Download: https://<<< custom_key.static_domain >>>/dataflux/package/guance-arm64-1.105.191.tar.gz
    - MD5: `bf7acef9f04550d8e199a287b6080445`

For more product feature update information, please refer to the [Changelog -> February 27, 2025](../../release-notes/index.md#20250227)

## 1.104.190 (February 19, 2025) {#1.104.190}

pubrepo.guance.com/dataflux/1.104.190:launcher-f574b1d-1740401808

### Offline Image Package Download

- AMD64 Architecture Download: https://<<< custom_key.static_domain >>>/dataflux/package/guance-amd64-1.104.190.tar.gz
    - MD5: `c75a12066300d28f85912128bf5e4b6f`

- ARM64 Architecture Download: https://<<< custom_key.static_domain >>>/dataflux/package/guance-arm64-1.104.190.tar.gz
    - MD5: `9fc1d397413d9a49c1f9fc2362a7301c`

???+ attention Important Version Dependency Update Notes

    ### Minimum Version Requirements for GuanceDB Components in This Deployment Plan

    #### GuanceDB for Logs
    - guance-select: v1.11.4+
    - guance-insert: v1.11.4+

    #### GuanceDB for Metrics
    - guance-select: v1.11.4+
    - guance-insert: v1.11.4+
    - guance-storage: v1.11.4+

### Breaking Changes {#breakingchanges0219}

The `df_meta` event will no longer retain `alert_info` related records. Users who previously relied on this information to obtain notification targets should switch to using the new fields `df_alert_info` (event alert notification), `df_is_silent` (whether muted), and `df_sent_target_types` (event notification target types) to achieve the corresponding functionality.

Potentially affected use cases:

1. Custom scenarios of obtaining events via OpenAPI to interface with external systems.
2. Custom scenarios of forwarding events to external systems via Webhook notifications.

### Deployment Plan Updates {#feature0219}

- Launcher now supports pausing all monitors with one click to prevent false alerts during upgrades. Note: This feature is supported after upgrading to version 1.104.190.

For more product feature update information, please refer to the [Changelog -> February 19, 2025](../../release-notes/index.md#breakingchanges0219)

## 1.103.189 (January 16, 2025) {#1.103.189}

pubrepo.guance.com/dataflux/1.103.189:launcher-d4a5efc-1737455050

### Offline Image Package Download

- AMD64 Architecture Download: https://<<< custom_key.static_domain >>>/dataflux/package/guance-amd64-1.103.189.tar.gz
    - MD5: `e3c0d6aa1ca3e063575aeb1c7c6cf2da`

- ARM64 Architecture Download: https://<<< custom_key.static_domain >>>/dataflux/package/guance-arm64-1.103.189.tar.gz
    - MD5: `1edf1c249834224b0ee2fa49e2280927`

### Feature Updates {#feature0116}

#### User Access Monitoring (RUM)

1. Added [Funnel Analysis](../../real-user-monitoring/user_insight_funnel.md) feature: Users can define conversion steps to create funnels, view data conversion, and perform in-depth analysis.
2. User Analysis Module Integration: A new user analysis module has been added, integrating heatmaps and funnel analysis to provide a comprehensive toolset for user behavior analysis.
3. Added mobile SourceMap restoration: Android and iOS applications support uploading SourceMap files on pages and viewing restored data in the error viewer.

#### Application Performance Monitoring (APM)

When adding services in APM, a new installation guide for [automatic host injection](../../application-performance-monitoring/explorer/auto_wire/autowire_on_host.md) has been added to simplify the installation process.

#### Integrations

1. DataKit (Data Collection Tool): The DataKit installation page now includes a Docker installation guide, providing more diverse installation options.
2. External Data Source Optimization: When querying SLS data sources, query specification hints have been added to help users perform data queries more accurately.

#### Use Cases

[Combined Charts](../../scene/visual-chart/index.md#conbine) optimization: Combined charts now support view variable configuration, allowing users to select view variables from the current dashboard to apply to the combined chart, helping to filter and analyze data more flexibly.

#### Monitoring

Anomaly detection monitor: Added support for week-over-week and month-over-month comparisons in query periods.

#### AI Intelligent Assistant

Added DataFlux Func knowledge base.

#### Pipeline

Auto-generated Pipeline optimization: Supports interaction through both structured and natural language to obtain Pipeline parsing.

### Bug Fixes {#bug0116}

1. Fixed display issues in log stacking mode.
2. Fixed misalignment of the input box in log monitoring monitors.
3. Fixed incorrect metric calculations.
4. Fixed the issue where Volcano Engine did not support the `having` statement.
5. Fixed an error when selecting "request error rate" and "average requests per second" metrics in application performance metrics monitoring.
6. Fixed the issue where the `not in` statement was ineffective in Volcano Engine.
7. Fixed the issue where large event list returns impacted page loading speed.
8. Fixed the issue where the one-click recovery of Hangzhou site events did not meet expectations.


## 1.102.188 (January 8, 2025) {#1.102.188}

pubrepo.guance.com/dataflux/1.102.188:launcher-0bd0be5-1736856269

### Offline Image Package Download

- AMD64 Architecture Download: https://<<< custom_key.static_domain >>>/dataflux/package/guance-amd64-1.102.188.tar.gz
    - MD5: `07d82df7e9a6ccb4ba747e8cb02d0882`

- ARM64 Architecture Download: https://<<< custom_key.static_domain >>>/dataflux/package/guance-arm64-1.102.188.tar.gz
    - MD5: `e5ee7933fd1f46ae9df5d05219b4726d`

### Deployment Plan Updates {#deployment0108}

1. Deployment Tool `Launcher` Optimization:
    - Fixed the unit errors in "Resource Configuration" for CPU cores and memory bytes in the "Workload Configuration" function.
    - Optimized the confirmation dialog repetition issue when restarting workloads.
2. Management Backend > Workspace Menu Optimization:
    - Added main storage engine and business filters to the workspace list for easier filtering.
    - Optimized pagination logic on the workspace list page to stay on the current page when modifying or deleting workspaces or changing data reporting limits.
3. Added new parameter `alertPolicyFixedNotifyTypes` in deployment plan, supporting configuration of whether to show the "email" notification method in alert policies. [Configuration Reference](/deployment/application-configuration-guide/#studio-backend).

### OpenAPI Updates {#openapi0108}

1. Field Management: Supports retrieving field management lists, and supports [adding](../../open-api/field-cfg/add.md)/[modifying](../../open-api/field-cfg/modify.md)/[deleting](../../open-api/field-cfg/delete.md) field management entries.
2. Synthetic Tests: Supports [modifying](../../open-api/dialing-task/modify.md) dial test tasks.
3. Incident > Schedule: Supports retrieving schedule lists, and supports [creating](../../open-api/notification-schedule/add.md)/[modifying](../../open-api/notification-schedule/modify.md)/[deleting](../../open-api/notification-schedule/delete.md) schedules.
4. Incident > Configuration Management: Supports retrieving notification policy lists, and supports [creating](../../open-api/issue-notification-policy/add.md)/[modifying](../../open-api/issue-notification-policy/modify.md)/[deleting](../../open-api/issue-notification-policy/delete.md) notification policies; supports retrieving Issue discovery lists, and supports [creating](../../open-api/issue-auto-discovery/add.md)/[modifying](../../open-api/issue-auto-discovery/modify.md)/[enabling/disabling](../../open-api/issue-auto-discovery/set-disable.md)/[deleting](../../open-api/issue-auto-discovery/delete.md) Issue discovery configurations.

### Feature Updates {#feature0108}

#### Logs

1. Log Index Optimization:
    - When accessing built-in views of access logs and the log context tab, the default selected index will be the current log's index and `default` index respectively. Both tabs support multi-selection of indices, and after enabling cross-workspace queries and selecting authorized workspaces in the menu, you can directly query the index data of the corresponding workspaces. This helps users view associated log data comprehensively within one page, optimizing log query interactions.
    - In the log index list, except for `default` being displayed at the top, other log indices are listed alphabetically from A-Z.
2. Log Viewer Added Stacking [View Mode](../../logs/manag-explorer.md#mode): In stacking mode, fields are consolidated into a single column and presented as rows within cells. This makes log information more compact and clear, facilitating quick browsing and analysis.
3. Log Pipeline Optimization: Test samples for log pipelines now retrieve all fields of logs and require line protocol format input. Manually entered logs must also follow this format requirement.

#### Use Cases

1. [Table Chart](../../scene/visual-chart/table-chart.md) Optimization:
    - Multi-metric Query Sorting Support: When performing multi-metric queries using a single DQL, table charts now support sorting.
    - Table Pagination Selection: Added table pagination selection functionality, allowing users to choose appropriate pagination sizes based on data volume and viewing needs.
2. Combined Charts: Supports adjusting the order of charts.
3. Chart Optimization: Adjusted the function order in the DQL query component, emphasizing the usage scenarios of the Rollup function to better assist users in aggregating and analyzing data.

#### Management

1. Event Data Forwarding Configuration Support: Supports configuring event type data forwarding rules to save filtered event data to <<< custom_key.brand_name >>> object storage and forward it to external storage, providing flexible event data management capabilities.
2. Workspace Added DataKit [Environment Variables](../../management/env_variable.md): Workspaces support managing DataKit environment variables, allowing users to easily configure and update environment variables for remote synchronization and updating of DataKit collection configurations.
3. Audit Event Query Optimization: Added multiple fields to record query information, and supplemented the time range in event content for better tracking and analysis of query behaviors.

#### Pipeline

Auto-generated Pipeline Optimization: Changed the way prompts appear to enhance product experience.

#### AI Intelligent Assistant

AI Intelligent Assistant Added [Chart Generation](../../guance-ai/index.md#chart): Based on large models, it automatically analyzes user input text data and intelligently generates appropriate charts, solving problems like manual chart creation complexity and difficulty in choosing the right chart.

#### Monitoring

[Alert Strategies](../../monitoring/alert-setting.md#member): Member-based notification rule configuration now supports appending names for purpose descriptions.

### New Integrations {#inte0108}

1. Added [AWS Gateway Classic ELB](../../integrations/aws_elb.md);
2. Added [Volcano Engine TOS Object Storage](../../integrations/volcengine_tos.md);
3. Modified AWS Classic Collector Name;
4. Added [MinIO V3](../../integrations/minio_v3.md) integration;
5. Updated elasticsearch, solr, nacos, influxdb_v2, mongodb integrations (views, documents, monitors);
6. Updated kubernetes monitoring views.

### Bug Fixes {#bug0108}

1. Resolved the issue where cross-space authorization for event data was not effective.
2. Resolved the issue where clicking on a linked trace ID in log correlation links failed to query data.
3. Resolved the issue where view expression queries could not fill numerical values.
4. Resolved the issue where external event detection monitors did not generate operation audit records when changing alert strategies.
5. Resolved the issue where column widths in event display lists could not be adjusted.