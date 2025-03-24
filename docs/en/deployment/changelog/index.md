# Version History

## 1.107.194 (March 12, 2025) {#1.107.194}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.107.194:launcher-e747002-1742390108

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.107.194.tar.gz
    - MD5: `03acc2e8d325b7b1be25b5971497cd8c`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.107.194.tar.gz
    - MD5: `f60ae5208194381346fbdc3d22df707b`

### Breaking Changes {#breakingchanges0312}

[Events](../events/index.md) `df_alert_info` field definition adjustment, adding reasons for unmatched alert strategies, still requiring filtering via `isIgnored` to obtain actual notification targets sent externally.

For more product feature updates, please refer to the product feature [Update Log -> March 12, 2025](../../release-notes/index.md#20250312)

## 1.106.193 (March 8, 2025) {#1.106.193}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.106.193:launcher-2ce6b5a-1741359234

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.106.193.tar.gz
    - MD5: `c4d91656b7cdd641beb6094c567e6160`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.106.193.tar.gz
    - MD5: `8e011cfb7d9321f9194ac160aad92067`

### Deployment Plan Updates {#feature0308}

- Fixed some bugs

For more product feature updates, please refer to the product feature [Update Log -> February 27, 2025](../../release-notes/index.md#20250227)

## 1.106.192 (March 5, 2025) {#1.106.192}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.106.192:launcher-d438422-1741176806

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.106.192.tar.gz
    - MD5: `108ade865cc48ddb47e81cc29a101ef1`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.106.192.tar.gz
    - MD5: `26cce1d476048898c261b3a7bbe9a2fc`

### Deployment Plan Updates {#feature0305}

- Fixed some bugs

For more product feature updates, please refer to the product feature [Update Log -> February 27, 2025](../../release-notes/index.md#20250227)

## 1.105.191 (February 27, 2025) {#1.105.191}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.105.191:launcher-b3bee84-1740751379

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.105.191.tar.gz
    - MD5: `0882e8fa58ebdbf6597c0943455b49b1`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.105.191.tar.gz
    - MD5: `bf7acef9f04550d8e199a287b6080445`

For more product feature updates, please refer to the product feature [Update Log -> February 27, 2025](../../release-notes/index.md#20250227)

## 1.104.190 (February 19, 2025) {#1.104.190}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.104.190:launcher-f574b1d-1740401808

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.104.190.tar.gz
    - MD5: `c75a12066300d28f85912128bf5e4b6f`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.104.190.tar.gz
    - MD5: `9fc1d397413d9a49c1f9fc2362a7301c`

???+ attention Important Version Dependency Update Notes

    ### Minimum version requirements for this deployment plan for GuanceDB components

    #### GuanceDB for Logs
    - guance-select: v1.11.4+
    - guance-insert: v1.11.4+

    #### GuanceDB for Metrics
    - guance-select: v1.11.4+
    - guance-insert: v1.11.4+
    - guance-storage: v1.11.4+

### Breaking Changes {#breakingchanges0219}

[Events](../../events/index.md) `df_meta` will no longer retain `alert_info` related information records. Users who previously relied on this information to retrieve notification targets should switch to using the newly added `df_alert_info` (event alert notifications), `df_is_silent` (whether muted), and `df_sent_target_types` (event notification target types) three fields to complete corresponding functions.

Possible affected use cases:

1. Custom use cases where events are retrieved through OpenAPI to interface with external systems.
2. Custom use cases where event notifications are forwarded to external systems through Webhook.

### Deployment Plan Updates {#feature0219}

- Launcher supports one-click pause of all monitors to prevent false alarms during upgrades. Note: This feature requires upgrading to version 1.104.190 for support.

For more product feature updates, please refer to the product feature [Update Log -> February 19, 2025](../../release-notes/index.md#breakingchanges0219)

## 1.103.189 (January 16, 2025) {#1.103.189}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.103.189:launcher-d4a5efc-1737455050

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.103.189.tar.gz
    - MD5: `e3c0d6aa1ca3e063575aeb1c7c6cf2da`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.103.189.tar.gz
    - MD5: `1edf1c249834224b0ee2fa49e2280927`

### Feature Updates {#feature0116}

#### User Access Monitoring

1. Added [Funnel Analysis](../../real-user-monitoring/user_insight_funnel.md) function: users can define conversion steps to create funnels, view data conversions, and perform in-depth analysis;
2. User Insight module integration: Added user insight module, integrating heatmaps and funnel analysis into this module to provide more comprehensive user behavior analysis tools;
3. Added MOBILE SourceMap restoration: Android and iOS applications support uploading SourceMap files on pages and viewing restored data in error viewers.

#### Application Performance Monitoring

APM adds service installation guidance for [HOST automatic injection](../../application-performance-monitoring/explorer/auto_wire/autowire_on_host.md), simplifying the installation process.

#### Integration

1. DataKit (data collection tool): The DataKit installation page has added Docker-based installation guidance, providing more diverse installation options;
2. External data source optimization: In SLS data source queries, added query standard prompts to help users conduct more accurate data queries.

#### Use Cases

[Combined Charts](../../scene/visual-chart/index.md#conbine) Optimization: Combined charts have added view variable configuration, supporting the selection of view variables from the current dashboard to apply to the combined chart, helping to filter and analyze data more flexibly.

#### Monitoring

Spike Detection Monitor: Added support for week-over-week and month-over-month comparisons for query cycles.

#### AI Intelligent Assistant

Added DataFlux Func knowledge base.

#### Pipeline

Automatic Pipeline generation optimization: Supports simultaneous interaction via structured plus natural language to obtain Pipeline parsing.

### Bug Fixes {#bug0116}

1. Fixed display issues in log stacking mode;
2. Fixed misalignment of input boxes in log detection monitors;
3. Fixed incorrect metric calculation;
4. Fixed Volcengine not supporting `having` statements;
5. Fixed errors when selecting "Request Error Rate" and "Average Requests Per Second" in APM metrics detection;
6. Fixed Volcengine's `not in` statement not taking effect;
7. Fixed large data returns in event lists affecting page load speed;
8. Fixed Hangzhou site event one-click recovery not meeting expectations.


## 1.102.188 (January 8, 2025) {#1.102.188}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.102.188:launcher-0bd0be5-1736856269

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.102.188.tar.gz
    - MD5: `07d82df7e9a6ccb4ba747e8cb02d0882`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.102.188.tar.gz
    - MD5: `e5ee7933fd1f46ae9df5d05219b4726d`

### Deployment Plan Updates {#deployment0108}

1. Deployment tool `Launcher` Optimization:
    - Fixed the issue of incorrect CPU core and memory byte units in the "Resource Configuration" section of the "Workload Configuration" feature.
    - Optimized the confirmation popup repetition issue when restarting workloads.
2. Management Backend > Workspace Menu Optimization:
    - Added two filtering options, main storage engine and business, in the workspace list to allow convenient filtering of workspaces.
    - Optimized the pagination return logic on the workspace list page so that when modifying/deleting a workspace or changing its data reporting limit, it stays on the current page to improve the querying experience.
3. Added new parameter for Deployment Plan: `alertPolicyFixedNotifyTypes`, which allows configuring whether the "email" notification method is displayed in alert policies. [Configuration Reference](/deployment/application-configuration-guide/#studio-backend).

### OpenAPI Updates {#openapi0108}

1. Field Management: Supports retrieving field management lists, and supports [Create](../../open-api/field-cfg/add.md)/[Modify](../../open-api/field-cfg/modify.md)/[Delete](../../open-api/field-cfg/delete.md) operations for field management.
2. Synthetic Tests: Supports [Modify](../../open-api/dialing-task/modify.md) dial test tasks.
3. Incident > Notification Schedule: Supports retrieving notification schedule lists, and supports [Create](../../open-api/notification-schedule/add.md)/[Modify](../../open-api/notification-schedule/modify.md)/[Delete](../../open-api/notification-schedule/delete.md) operations for notification schedules.
4. Incident > Configuration Management: Supports retrieving notification policy lists, and supports [Create](../../open-api/issue-notification-policy/add.md)/[Modify](../../open-api/issue-notification-policy/modify.md)/[Delete](../../open-api/issue-notification-policy/delete.md) operations for notification policies; also supports retrieving Issue discovery lists, and supports [Create](../../open-api/issue-auto-discovery/add.md)/[Modify](../../open-api/issue-auto-discovery/modify.md)/[Enable/Disable](../../open-api/issue-auto-discovery/set-disable.md)/[Delete](../../open-api/issue-auto-discovery/delete.md) operations for Issue discovery configurations.

### Feature Updates {#feature0108}

#### Logs

1. Log Index Optimization:
    - When accessing built-in views of access logs and the log context tab, the default selected index will be the index of the current log and the `default` index respectively. Both tabs support multi-selection of indices, and after enabling cross-workspace queries and selecting authorized workspaces from the menu, it is possible to directly query the index data of corresponding workspaces. Ultimately, this helps users view all associated log data on a single page, optimizing the log query interaction.
    - When listing log indices, except for the `default` index being top-priority, the rest are listed in alphabetical order from A-Z.
2. Added Stacking [View Mode](../../logs/manag-explorer.md#mode) in Log Explorer: In stacking mode, fields are consolidated into a single column and presented as rows within cells. This makes log information more compact and clear, facilitating quick browsing and analysis by users.
3. Log Pipeline Optimization: Test samples for log Pipelines now include all fields of the log and must be entered in line protocol format. Manually entered logs by users must also follow the format requirement.

#### Use Cases

1. [Table Chart](../../scene/visual-chart/table-chart.md) Optimization:
    - Multi-Metrics Query Sorting Support: When performing multi-metric queries with a single DQL, table charts now support sorting.
    - Table Pagination Selection: Added table pagination selection functionality, allowing users to choose an appropriate pagination size based on data volume and viewing needs.
2. Combined Charts: Supports adjusting the order of charts.
3. Chart Optimization: Adjusted the function order of the DQL query component, emphasizing the use scenarios of the Rollup function to help users better utilize it for data aggregation and analysis.

#### Management

1. Events Support [Data Forwarding](../../management/backup/index.md) Configuration: Supports configuring data forwarding rules for event types, saving events that meet filtering conditions to <<< custom_key.brand_name >>> object storage and forwarding them to external storage, providing flexible event data management capabilities.

2. Added DataKit [Environment Variables](../../management/env_variable.md) in Workspaces: Workspaces support managing DataKit environment variables, allowing users to easily configure and update environment variables to achieve remote synchronization and updating of DataKit collection configurations.

3. Query [Audit Events](../../management/audit-event.md) Optimization: Added multiple fields to record query information, and supplemented the time range of queries in the event content to facilitate tracking and analyzing query behaviors.

#### Pipeline

Automatic Pipeline Generation Optimization: Changed the way hints appear, improving product experience.

#### AI Intelligent Assistant

AI Intelligent Assistant Added [Chart Generation](../../guance-ai/index.md#chart): The chart generation function automatically analyzes user input text data using large models to intelligently generate appropriate charts, solving problems such as cumbersome manual chart creation and difficulty in choosing charts.

#### Monitoring

[Alert Strategies](../../monitoring/alert-setting.md#member): Supports appending names for purpose descriptions when configuring notification rules by members.

### New Integrations {#inte0108}

1. Added [AWS Gateway Classic ELB](../../integrations/aws_elb.md);
2. Added [Volcengine TOS Object Storage](../../integrations/volcengine_tos.md);
3. Modified AWS Classic Collector Name;
4. Added [MinIO V3](../../integrations/minio_v3.md) Integration;
5. Updated elasticsearch, solr, nacos, influxdb_v2, mongodb integrations (views, documents, monitors);
6. Updated Kubernetes monitoring views.

### Bug Fixes {#bug0108}

1. Resolved the issue of cross-space authorization for event data not taking effect;
2. Resolved the issue where carrying `trace_id` to link to the link viewer failed to query data;
3. Resolved the issue of numerical filling not working in view expression queries;
4. Resolved the issue of no operation audit records generated when changing alert strategies in external event detection monitors;
5. Resolved the issue of column widths in event display lists not being adjustable.