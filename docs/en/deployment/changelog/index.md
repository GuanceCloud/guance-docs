# Version History

## 1.108.195 (March 26, 2025) {#1.108.195}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.108.195:launcher-aead114-1743399725

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.108.195.tar.gz
    - MD5: `03acc2e8d325b7b1be25b5971497cd8c`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.108.195.tar.gz
    - MD5: `f60ae5208194381346fbdc3d22df707b`

???+ attention Important version dependency update information

    ### For this Deployment Plan, the minimum version requirements for GuanceDB components

    #### GuanceDB for Logs
    - guance-select: v1.13.5+
    - guance-insert: v1.13.5+

    #### GuanceDB for Metrics
    - guance-select: v1.13.5+
    - guance-insert: v1.13.5+
    - guance-storage: v1.13.5+

### Deployment Plan Update

- Data storage structure adjustment
    - Migrate Synthetic Tests data from the original log table to a separate table; this version uses dual-write mechanisms to write into both old and new tables but still queries data from the old table in terms of functionality.
    - Split RUM data table structures; originally unified Session and View data will be separated into independent tables, ensuring compatibility through dual writing, but still querying data from the old table in terms of functionality.

For more product feature updates, please refer to [Release Notes -> March 26, 2025](../../release-notes/index.md#20250326)

## 1.107.194 (March 12, 2025) {#1.107.194}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.107.194:launcher-e747002-1742390108

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.107.194.tar.gz
    - MD5: `03acc2e8d325b7b1be25b5971497cd8c`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.107.194.tar.gz
    - MD5: `f60ae5208194381346fbdc3d22df707b`

### Breaking Changes {#breakingchanges0312}

[Events](../events/index.md) field definition adjustment for `df_alert_info`, adding unmatched alert strategy reason explanations; filtering is still required using `isIgnored` to obtain actual notification targets sent externally.

For more product feature updates, please refer to [Release Notes -> March 12, 2025](../../release-notes/index.md#20250312)

## 1.106.193 (March 8, 2025) {#1.106.193}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.106.193:launcher-2ce6b5a-1741359234

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.106.193.tar.gz
    - MD5: `c4d91656b7cdd641beb6094c567e6160`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.106.193.tar.gz
    - MD5: `8e011cfb7d9321f9194ac160aad92067`

### Deployment Plan Update {#feature0308}

- Fixed some bugs

For more product feature updates, please refer to [Release Notes -> February 27, 2025](../../release-notes/index.md#20250227)

## 1.106.192 (March 5, 2025) {#1.106.192}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.106.192:launcher-d438422-1741176806

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.106.192.tar.gz
    - MD5: `108ade865cc48ddb47e81cc29a101ef1`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.106.192.tar.gz
    - MD5: `26cce1d476048898c261b3a7bbe9a2fc`

### Deployment Plan Update {#feature0305}

- Fixed some bugs

For more product feature updates, please refer to [Release Notes -> February 27, 2025](../../release-notes/index.md#20250227)

## 1.105.191 (February 27, 2025) {#1.105.191}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.105.191:launcher-b3bee84-1740751379

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.105.191.tar.gz
    - MD5: `0882e8fa58ebdbf6597c0943455b49b1`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.105.191.tar.gz
    - MD5: `bf7acef9f04550d8e199a287b6080445`

For more product feature updates, please refer to [Release Notes -> February 27, 2025](../../release-notes/index.md#20250227)

## 1.104.190 (February 19, 2025) {#1.104.190}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.104.190:launcher-f574b1d-1740401808

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.104.190.tar.gz
    - MD5: `c75a12066300d28f85912128bf5e4b6f`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.104.190.tar.gz
    - MD5: `9fc1d397413d9a49c1f9fc2362a7301c`

???+ attention Important version dependency update information

    ### For this Deployment Plan, the minimum version requirements for GuanceDB components

    #### GuanceDB for Logs
    - guance-select: v1.11.4+
    - guance-insert: v1.11.4+

    #### GuanceDB for Metrics
    - guance-select: v1.11.4+
    - guance-insert: v1.11.4+
    - guance-storage: v1.11.4+

### Breaking Changes {#breakingchanges0219}

[Events](../../events/index.md) `df_meta` will no longer retain `alert_info` related records. Users who previously relied on this information to retrieve notification targets should switch to use the newly added `df_alert_info` (event alert notifications), `df_is_silent` (whether silent), `df_sent_target_types` (event notification target types) three fields to complete the corresponding functions.

Possible affected functional scenarios:

1. Custom use cases obtaining events via OpenAPI to interface with external systems.
2. Custom use cases forwarding event notification targets to external systems via Webhook.

### Deployment Plan Update {#feature0219}

- Launcher supports pausing all monitors with one click to prevent false alarms during upgrades. Note: This feature requires upgrading to version 1.104.190 or later.

For more product feature updates, please refer to [Release Notes -> February 19, 2025](../../release-notes/index.md#breakingchanges0219)

## 1.103.189 (January 16, 2025) {#1.103.189}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.103.189:launcher-d4a5efc-1737455050

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.103.189.tar.gz
    - MD5: `e3c0d6aa1ca3e063575aeb1c7c6cf2da`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.103.189.tar.gz
    - MD5: `1edf1c249834224b0ee2fa49e2280927`

### Feature Updates {#feature0116}

#### User Access Monitoring

1. Added [Funnel Analysis](../../real-user-monitoring/user_insight_funnel.md) function: users can create funnels by defining conversion steps, view data conversion, and perform in-depth analysis;
2. Integrated user insight module: added user insight module, integrating heatmap and funnel analysis in this module, providing more comprehensive user behavior analysis tools;
3. Added mobile SourceMap restoration: Android and iOS applications support uploading SourceMap files on pages and viewing restored data in error Explorer.

#### Application Performance Monitoring

APM adds installation guidance for [automatic host injection](../../application-performance-monitoring/explorer/auto_wire/autowire_on_host.md) when adding services, simplifying the installation process.

#### Integration

1. DataKit (data collection tool): The DataKit installation page added Docker-based installation guidance, providing more diverse installation options;
2. External data source optimization: Added query standard prompts when querying SLS data sources, helping users query data more accurately.


#### Scenarios

[Combined Charts](../../scene/visual-chart/index.md#conbine) Optimization: Combined charts added view variable configuration, supporting the selection of view variables from the current dashboard to apply to this combined chart, helping filter and analyze data more flexibly.

#### Monitoring

Spike detection monitor: Added week-over-week and month-over-month support for query periods.

#### AI Intelligent Assistant

Added DataFlux Func knowledge base.

#### Pipeline

Optimized automatic generation of Pipelines: Supports interactive acquisition of Pipeline parsing simultaneously in structured and natural language formats.

### Bug Fixes {#bug0116}

1. Fixed display issues in log stacking mode;
2. Fixed misalignment of input boxes for log detection monitors;
3. Fixed incorrect metric calculations;
4. Fixed Volcengine not supporting `having` statements;
5. Fixed errors when selecting "request error rate" and "average requests per second" metrics in application performance metric detection;
6. Fixed `not in` statements not working in Volcengine foundation;
7. Fixed large amounts of data returned in event lists affecting page loading speed;
8. Fixed Hangzhou site's one-click event recovery not meeting expectations.


## 1.102.188 (January 8, 2025) {#1.102.188}

pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/1.102.188:launcher-0bd0be5-1736856269

### Offline Image Package Download

- AMD64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-1.102.188.tar.gz
    - MD5: `07d82df7e9a6ccb4ba747e8cb02d0882`

- ARM64 Architecture Download: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-1.102.188.tar.gz
    - MD5: `e5ee7933fd1f46ae9df5d05219b4726d`

### Deployment Plan Update {#deployment0108}

1. Optimized deployment tool `Launcher`:
    - Fixed unit errors in "resource allocation" for CPU cores and memory bytes in the "workload configuration" function.
    - Optimized repeated confirmation pop-up windows when restarting workloads.
2. Management backend > Workspace menu optimization:
    - Added two filters for main storage engine and business in the workspace list, allowing convenient filtering of workspaces.
    - Optimized pagination return logic for the workspace list page; when modifying/deleting a workspace or changing the data reporting limit for a workspace, it remains on the current page to optimize the query experience.
3. Added new parameter to Deployment Plan: `alertPolicyFixedNotifyTypes`, supporting configuration for whether the "email" notification method is displayed in alert strategies [Configuration reference](/deployment/application-configuration-guide/#studio-backend).

### OpenAPI Update {#openapi0108}

1. Field management: Supports retrieving field management lists, supporting [adding](../../open-api/field-cfg/add.md)/[modifying](../../open-api/field-cfg/modify.md)/[deleting](../../open-api/field-cfg/delete.md) field management.
2. Synthetic Tests: Supports [modifying](../../open-api/dialing-task/modify.md) dialing tasks.
3. Incident > Schedule: Supports retrieving schedule lists, supporting [creating](../../open-api/notification-schedule/add.md)/[modifying](../../open-api/notification-schedule/modify.md)/[deleting](../../open-api/notification-schedule/delete.md) schedules.
4. Incident > Configuration Management: Supports retrieving notification policy lists, supporting [adding](../../open-api/issue-notification-policy/add.md)/[modifying](../../open-api/issue-notification-policy/modify.md)/[deleting](../../open-api/issue-notification-policy/delete.md) notification policies; supports retrieving Issue discovery lists, supporting [adding](../../open-api/issue-auto-discovery/add.md)/[modifying](../../open-api/issue-auto-discovery/modify.md)/[enabling/disabling](../../open-api/issue-auto-discovery/set-disable.md)/[deleting](../../open-api/issue-auto-discovery/delete.md) Issue discovery configurations.

### Feature Updates {#feature0108}

#### Logs

1. Log index optimization:
    - When accessing built-in views of logs and the log context tab page, the currently selected index of the log and the `default` index will be selected by default respectively. Both tabs support multi-selection of indexes. Additionally, after enabling cross-workspace queries and selecting authorized workspaces in the relevant menu, it supports directly querying index data for the corresponding workspace here. Ultimately, this helps users comprehensively view associated log data on one page, optimizing log query interaction.
    - When listing log indexes, except for `default` which is displayed at the top, the remaining log indexes are listed in A-Z order.
2. Log Explorer added stacking [view mode](../../logs/manag-explorer.md#mode): In stacking mode, fields will be consolidated into the same column, and these fields will be presented as rows within cells. The display of log information becomes more compact and clear, making it easier for users to quickly browse and analyze.
3. Log Pipeline optimization: Test samples for log Pipelines now include all log fields, and need to be entered in line protocol format. Logs manually entered by users must also follow the formatting requirements.

#### Scenarios

1. [Table Chart](../../scene/visual-chart/table-chart.md) optimization:
    - Multi-metric query sorting support: When performing a multi-metric query with one DQL, the table chart now supports sorting.
    - Table pagination selection: Added table pagination selection functionality, allowing users to choose appropriate pagination sizes based on data volume and viewing needs.
2. Combined charts: Supports adjusting the order of charts.
3. Chart optimization: Adjusted the function order of the DQL query component, emphasizing the use case of the Rollup function, helping users better utilize the Rollup function for data aggregation and analysis.

#### Management

1. Events support configuring [data forwarding](../../management/backup/index.md): Configuring event type data forwarding rules allows storing events that meet filtering conditions in <<< custom_key.brand_name >>> object storage and forwarding them to external storage, providing flexible management capabilities for event data.

2. Workspaces added DataKit [environment variables](../../management/env_variable.md): Workspaces support managing DataKit environment variables, allowing users to easily configure and update environment variables to achieve remote synchronized updates of DataKit collection configurations.

3. Query [audit events](../../management/audit-event.md) optimization: Added multiple fields to record query information, and supplemented the time range of queries in the event content, facilitating tracking and analyzing query behaviors.

#### Pipeline

Optimized automatic generation of Pipelines: Changed the way tips appear, improving product experience.

#### AI Intelligent Assistant

AI Intelligent Assistant added [chart generation](../../guance-ai/index.md#chart): Based on large models automatically analyzing user-entered text data, intelligently generating appropriate charts, solving problems such as tedious manual chart creation and difficulty in choosing charts.

#### Monitoring

[Alert Strategies](../../monitoring/alert-setting.md#member): Support appending names for purpose descriptions when configuring notification rules by member.

### New Integrations {#inte0108}

1. Added [AWS Gateway Classic ELB](../../integrations/aws_elb.md);
2. Added [Volcengine TOS Object Storage](../../integrations/volcengine_tos.md);
3. Modified AWS Classic collector name;
4. Added [MinIO V3](../../integrations/minio_v3.md) integration;
5. Updated elasticsearch, solr, nacos, influxdb_v2, mongodb integrations (views, documents, monitors);
6. Updated Kubernetes monitoring views.

### Bug Fixes {#bug0108}

1. Resolved the issue where event data cross-space authorization was not effective;
2. Resolved the issue where carrying `trace_id` when jumping from log association links to trace Explorer could not query data;
3. Resolved the issue where value filling could not be performed for expression queries in views;
4. Resolved the issue where operation audit records were not generated when changing alert strategies for external event detection monitors;
5. Resolved the issue where column widths in event display lists could not be adjusted.