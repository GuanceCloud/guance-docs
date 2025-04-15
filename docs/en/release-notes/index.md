---
icon: zy/release-notes
---

# Release Notes (2025)

---

This document records the update content descriptions for each release of <<< custom_key.brand_name >>>.

<div class="grid cards" markdown>

- :fontawesome-regular-clipboard:{ .lg .middle }

    ***

    <table>
      <tr>
        <th><a href="<<< homepage >>>/datakit/changelog-2025/" target="_blank">DataKit</a></th>
      </tr>
    </table>

    ***

    <table>
      <tr>
        <th colspan="5">SDK</th>
      </tr>
      <tr>
        <td><a href="<<< homepage >>>/real-user-monitoring/web/sdk-changelog/" target="_blank">Web</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/miniapp/sdk-changelog/" target="_blank">Mini Programs</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/android/sdk-changelog/" target="_blank">Android</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/ios/sdk-changelog/" target="_blank">iOS</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/react-native/sdk-changelog/" target="_blank">React Native</a></td>
      </tr>
    </table>

</div>

## April 9, 2025 {#20250409}

### OpenAPI Update {#openapi0409}

1. Support for creating, editing, and deleting multi-step test tasks;
2. Support for configuring workspace quantity upper limit restrictions.

### Feature Updates {#feature0409}

#### Use Cases

1. Chart Optimization    
    - Bar Chart:
        - Adjusted [alias](../scene/visual-chart/chart-config.md#alias) position to support listing all Metrics and groupings;
        - Added X-axis configuration options.
    - Grouped [Table Chart](../scene/visual-chart/table-chart.md):
        - Supports sorting based on grouping selections;
        - Added a 200 option in the dropdown return quantity, supporting manual input to adjust the maximum number to 1,000.
    - Time Series Chart > [Line Chart](../scene/visual-chart/timeseries-chart.md#line-chart): Added line "style" settings, including linear, smooth, pre-step, post-step.
2. Snapshot: Added permission prompts for sharing [dashboard snapshots](../getting-started/function-details/share-snapshot.md#sharing-method) with configuration permissions.
3. Explorer, Dashboard > Time Widget: Added "Last 1 Minute" and "Last 5 Minutes," with the latter selected by default.

#### Management

- [Cross-workspace Authorization](../management/data-authorization.md): Supports cross-site data authorization to achieve extended data sharing.
- Data Forwarding:
    - Added "Audit Events" as a new data type.
    - Adjusted Explorer query time logic:
        - Changed to daily queries, not supporting cross-day queries;
        - When viewing forwarded data, the system automatically queries and continuously loads until fully displayed without user manual clicks;
        - Management > Space Settings > Advanced Settings: Added ["Data Forwarding Query Duration"](../management/backup/index.md#query_time_change) configuration.
- Data access, Pipeline, blacklist permission split, adjusted "Management" permission to "Create, Edit" and "Delete."

#### Monitoring

1. System Notifications: Added jump links associated with logs, allowing navigation to the log explorer and filtering out logs where notification objects failed to send.
2. Monitors:
    - From template creation > Official Template Library: Added search functionality;
    - Configuration Page > [Event Content](../monitoring/monitor/monitor-rule.md#content): Updated attention prompt. The `@ member` configuration only takes effect and sends event content to specified members when correlation anomaly tracking is enabled.
    - Threshold Detection: Added [Recovery Condition](../monitoring/monitor/threshold-detection.md#recover-conditions) switch, configure recovery conditions and severity levels. When query results contain multiple values, any value meeting trigger conditions will generate a recovery event.

#### Incident Tracking

Issue email notifications changed the "Source" to a hyperlink, allowing users to directly access it upon clicking.

#### RUM

SourceMap:

- Page interaction adjusted from pop-up to a separate page;
- List page added search and export functions.


#### AI Intelligent Assistant

Optimized [Chart Generation](../guance-ai/index.md#chart) function: Managed indicator data via local Func cache, making generated DQL closer to semantic descriptions.

#### [AI Error Analysis](../logs/explorer-details.md#ai)

Added context support for root cause analysis, helping users understand errors faster and more comprehensively, improving diagnostic efficiency.


#### Integration > Extension

DataFlux Func (Automata)/RUM Headless: Added email reminders and system notifications for application fee deductions.

#### Infrastructure

HOST > Detail Page: Disk capacity statistics distinguish between local disks and remote disks for display.

### Deployment Plan Update {#deployment0409}

Template Management:

- Page interaction optimized, including adding a "Template Type" column;
- Top filter items added "Template Type";
- Supports batch export of templates;
- When importing templates, supports previewing template details;
- Built-in views, Pipelines, monitor templates upload support name-overwrite logic.

### New Integrations {#inte0409}

1. Added [GCP Compute Engine](../integrations/gcp_ce.md);
2. Added [Azure Storage](../integrations/azure_storage.md);
3. Added [Azure Redis Cache](../integrations/azure_redis_cache.md);
4. Added [Azure Kubernetes](../integrations/azure_kubernetes.md);
5. Added [Azure PostgreSQL](../integrations/azure_postgresql.md);
6. Added Alibaba Cloud Rds MYSQL Automata integration;
7. Added [Druid](../integrations/druid.md) integration;
8. Updated [Trino](../integrations/trino.md);
9. Adjusted AWS/Alibaba Cloud Automata integration documentation: Added `Managed Version Activation Script` steps.

### Bug Fixes {#bug0409}

1. Fixed issues with calling OpenAPI to retrieve unrecovered events that did not match actual results.
2. Fixed an error occurring during searches in the Event Viewer.
3. Fixed abnormal data querying for external data sources.
4. Fixed related issues with email notifications for incident tracking.
5. Fixed slow loading issues for the incident tracking analysis dashboard.
6. Fixed incorrect color display issues for bar charts.
7. Fixed issues with external event prompts missing AK.
8. Fixed incorrect display issues for status distribution charts and log volumes.



## March 26, 2025 {#20250326}



### Feature Updates {#feature0326}


#### Events

1. [Unrecovered Events](../events/event-explorer/unrecovered-events.md): Time Widget defaults to auto-refresh; after manually recovering events, a front-end page prompt is added when recovery succeeds.
2. [Event Details](../events/event-explorer/event-details.md): Optimized alert notification page display.
3. Exported Events and Intelligent Monitoring Viewers add "Notification Status" display.

#### Management

[Data Forwarding](../management/backup/index.md#permission): Added permission configuration. By setting view permissions for forwarded data, data security is effectively improved.

#### Monitoring

1. [Infrastructure Survival Detection V2](../monitoring/monitor/infrastructure-detection.md): Added configurable detection intervals.
2. Alert Strategies: Notification matching logic adjusted to improve execution efficiency in scenarios where events hit multiple strategies or complex alert strategies.
3. Notification Targets Management: Added [Slack](../monitoring/notify-target-slack.md) and [Teams](../monitoring/notify-target-teams.md) two notification targets to meet the needs of more global users.

#### Use Cases

1. View Variables: Support external data source queries.
2. Charts:
    
    - Added "[Monitor Summary](../scene/visual-chart/monitor_summary.md)" chart, integrating the monitor list to display the latest status, achieving instant monitoring and anomaly trend awareness.
    - Command Panel: Display optimization;
    - Chart Queries: When using "wildcard" or "regex" in DQL queries, added query suggestion prompts.
3. Explorer, Dashboard > Time Widget: Added "Last 1 Minute" and "Last 5 Minutes" options.

#### Billing

1. Added [Monthly Bill](../billing/index.md#monthly_bill) module to intuitively display monthly consumption totals.
2. Added bill export function.

#### User Access Monitoring

Application List > Create Application: Added "Compressed Upload" and "Custom Host Address" parameter configurations.

#### Synthetic Tests

Added "South Africa" and "Hong Kong, China" as test nodes, further expanding global coverage.

#### Logs

1. [Log Explorer](../logs/explorer.md)
    - Quick filter operation adjustments;
    - Optimized list tokenization logic;
    - JSON format data added "[JSON Search](../logs/explorer-details.md#json)";
2. Index > Key Fields: Added "[One-click Obtain](../logs/multi-index/index.md#extract)". 


### New Integrations {#inte0326}

- Added [Azure Network Interfaces](../integrations/azure_network_interfaces.md);
- Added [Azure Kubernetes](../integrations/azure_kubernetes.md);
- Added [Azure Virtual Network Gateway](../integrations/azure_virtual_network_gateway.md);
- Improved English integration translations.

### Bug Fixes {#bug0326}

1. Fixed low utilization issue on the log page display.
2. Fixed Service Map metric unit display issues.
3. Fixed inability to select units for multiple columns in table charts.
4. Fixed CSV export issues for Dashboard > Log Flow Graph when selecting export quantities other than 1,000.
5. Fixed inconsistency between P75 results for most popular pages and DQL query results.
6. Fixed issue where the time frame still showed today after clicking the `<<` button in the time selector.
7. Fixed menu management not functioning as expected.
8. Fixed abnormal space ID filtering in the management backend search.
9. Fixed lost test samples in the Pipeline interface.
10. Fixed long response times for configuration migration exports.
11. Fixed large empty items in quick selection tags on the event details interface after upgrades.
12. Fixed duplicate official monitor template libraries, which prevented searching other monitors once a library was selected.

## March 12, 2025 {#20250312}

### Breaking Changes {#breakingchanges0312}

[Events](../events/index.md) `df_alert_info` field definition adjustment: Added reasons for unmatched alert strategies. Filtering for actual externally sent notification objects still requires `isIgnored`.


### Feature Updates {#feature0312}

#### Incident Tracking

1. Added [Incident Tracking Management](../management/index.md#personal_incidents) entry point. Through this entry point, the currently logged-in user can view and manage the status of all incident tracking in joined workspaces.
2. Optimized [Channel List](../exception/channel.md#list) display for incident tracking pages, enhancing query efficiency when there are many channels.

#### Management

1. [Cloud Account Management](../management/cloud-account-manag.md#alibaba): Added Alibaba Cloud account authorization types.
2. [API Key Management](../management/api-key/index.md): Added API Key permission control functions, supporting role-based authorization. Through role-based authorization, API Keys only have operational permissions within the scope of the role, thereby effectively reducing security risks.
3. Data Forwarding: Default interaction changed to unselected rules.

#### AI Error Analysis

The following detail pages added [AI Error Analysis](../logs/explorer-details.md#ai) capabilities:

- error logs
- APM > Trace/Error Tracking

#### Use Cases

1. Scheduled Reports:

    - Added Webhook sending as a notification method;
    - Supported sharing dashboard images to WeCom/DingTalk.

2. Time Series Chart: After selecting area chart as the chart type, added [Stack Mode](../scene/visual-chart/timeseries-chart.md#style) style to facilitate observing cumulative effects of overall data.

#### APM

Trace: Supports batch exporting in JSONL format.

#### RUM

User Analysis > [Funnel Analysis](../real-user-monitoring/user_insight_funnel.md): For queried Session lists, supports session replay functionality.


#### Logs

1. Explorer:    
    - Log Explorer > Index Quick Filter optimized display in the search bar; 
    - Log Details > Extended Fields: Added "Dimension Analysis" mode;         
2. Index: Supports setting exclusive [Key Fields](../logs/multi-index/index.md#key_key) under index dimensions.

#### Explorer Time Widget

Left-side selected time range and right-side refresh frequency operate independently. Only two cases affect refresh frequency:  

- Selected time range exceeds 1h       
- Selected time is absolute time     


#### Infrastructure

HOST: Explorer supports adjusting time range.
   
#### Pipeline

1. Configuration page display optimization;
2. Pipeline processing type added "Events";
3. Test sample supports obtaining JSON format.
4. Filter Conditions > Synthetic Tests: Supports selecting multi-step tests.

### Deployment Plan Update {#deployment0312}

[Template Management](../deployment/integration.md): Supports uploading all explorer templates.

### New Integrations {#inte0312}

1. Added [azure_load_balancer](../integrations/azure_load_balancer.md);
2. Rewrote [K8S server api](../integrations/kubernetes-api-server.md);
3. Updated [Gitlab CI](../integrations/gitlab.md);
4. Translated Volcengine-related views;
5. Translated AWS-related views.

### Bug Fixes {#bug0312}

1. Fixed the issue where exporting log flow graphs to CSV had no response.
2. Fixed the issue where JVM metrics collected by `ddtrace` with `runtime-id` field as a view variable had no data after adding relevant filters in the time series graph.
3. Fixed the custom gradient interval color scale interface display problem.
4. Fixed the issue where, after editing the DQL query in the time series graph, saving after selecting >0 filter conditions showed an empty result when re-editing.
5. Fixed the abnormal display of infrastructure tables in application performance monitoring.
6. Fixed the issue where setting data forwarding storage duration to 1,800 days in the management backend did not support the forwarding rule in the frontend.
7. Fixed the error message "kodo service API request error: Service Unavailable" when executing quick query show_object_field(`HOST`).
8. Fixed existing bugs in quick entries.
9. Fixed the issue where RUM had no data for `session` and `view`, but had data for other `resource` and actions.
10. Fixed the issue where required fields were immediately validated when creating multistep test requests.
11. Fixed the issue where filter conditions did not take effect when setting role authorization for data access.


## February 27, 2025 {#20250227}

### OpenAPI Updates {#openapi0227}

Metrics: Added [Metric Set and Tag Information Retrieval](../open-api/metric/metric-info-get.md).

### Feature Updates {#feature0227}

#### Synthetic Tests

1. HTTP Testing: Supports [Script Mode](../usability-monitoring/request-task/http.md#script). By writing Pipeline scripts, flexibly customize judgment conditions and data processing logic for testing tasks.
2. Added [Multistep Testing](../usability-monitoring/request-task/multistep_test.md): Allows creating tests using response data from multiple APIs and linking multiple task requests through local variable passing.

#### Use Cases

1. Dashboard > Visibility Scope: Added "Custom" configuration, allowing configuration of "Action" and "View" permissions for this dashboard. This configuration also adds the "All Members" option.
2. Charts:
    - Added AI-generated chart title and description capability;
    - Log Flow Chart added "Rule Mapping" feature;
    - Table Chart display column optimization;
    - Grouped Table Chart: Expression results support sorting;
    - Time Series Chart, Pie Chart, and multiple charts support data export to CSV files.

#### Metrics

1. [Metric Analysis > Table Chart](../metrics/explorer.md#table): When query results exceed 2,000 records, three modes added "Query Result Count" display.
2. [Metric Management](../metrics/dictionary.md): Supports one-click jump to Metric Analysis.
3. [Generate Metrics](../metrics/generate-metrics.md#manage): Supports import creation methods and batch export.

#### Infrastructure

Container/Pod Explorer: Object data added 4 new fields: `cpu_usage_by_limit`, `cpu_usage_by_request`, `mem_used_percent_base_limit`, `mem_used_percent_base_request`.

#### Application Performance Monitoring

1. Profiling > Flamegraph Interaction Optimization: Selecting a single search method name focuses directly.
2. ServiceMap Interaction Optimization: In upstream/downstream pages, supports searching for nodes currently on the canvas.

### New Integrations {#inte0227}

1. Added [AWS Cloud Billing](../integrations/aws_billing.md);
2. Added [Kube Scheduler](../integrations/kube_scheduler.md);
3. Added [MQTT](../integrations/mqtt.md);
4. Rewrote [APISIX](../integrations/apisix.md);
5. Updated [TiDB](../integrations/tidb.md) English documentation and views;
6. Updated [Zookeeper](../integrations/zookeeper.md) views, supplemented integration icons;
7. Fixed partial component mainfest.yaml English translations.

### Bug Fixes {#bug0227}

1. Fixed the issue where clicking on Application Performance Monitoring > Trace Details tab displayed incorrectly;
2. Fixed the issue where Issue replies in Exception Tracking had incorrect `@member`;
3. Fixed the issue where temperature units in charts were incorrect.


## February 19, 2025

### Breaking Changes {#breakingchanges0219}

[Events](../events/index.md) `df_meta` will no longer retain `alert_info` related information records. Users previously relying on this information to obtain notification targets should switch to using the newly added `df_alert_info` (event alert notification), `df_is_silent` (whether muted), `df_sent_target_types` (event notification object types) three fields to complete corresponding functions.

Potentially affected use cases:

1. Custom use cases for interfacing events with external systems via OpenAPI
2. Custom use cases for forwarding events to external systems via Webhook notifications

### Feature Updates {#feature0116}


#### PromQL Query

Added Instant Query type: Querying against a single timestamp.


#### Monitoring

Monitor Configuration Page:

1. Added `not between` option in trigger condition logic matching;
2. Supports directly modifying monitor status ("Enabled" or "Disabled").


#### Application Performance Monitoring

Trace: Added [Service Context](../application-performance-monitoring/explorer/explorer-analysis.md#context) tab page in details.


#### Events

Event Details Page: Added support for binding [Built-in Views](../events/event-explorer/event-details.md#inner_view);


#### Exception Tracking

1. Issues added [`working`, `closed` statuses](../exception/issue.md#concepts);  
2. For cases where `open` status remains overdue and no responsible person is assigned or handling is overdue, [Issue Upgrade](../exception/config-manag/strategy.md#upgrade) added repeat notification configuration;  
3. Adjusted UI display for Issue system comments and channel notifications;
4. Analytical Dashboard: Added Time Widget.


#### Use Cases

1. [Chart Link](../scene/visual-chart/chart-link.md): Added "View Host Monitoring View", disabled by default.
2. Explorer: Supports deleting fixed `name` columns, allowing users to customize list displays.
3. Cloud Billing Analysis View: Supports viewing billing details.

#### Management

[Role Management](../management/role-list.md): Session Replay viewing, audit events added custom view permission capability.

#### Metrics

Generate Metrics: Metric name input no longer supports `-` hyphens.

#### Integration

Integration Cards added description information.

### Deployment Plan Update {#deployment0219}

1. Template Management: Supports uploading infrastructure explorer templates;
2. Index Configuration: Deprecated "Backup Logs" item; Configurable storage strategy available at "Edit Workspace > Data Storage Policy > Data Forwarding - Default Storage".

### New Integrations {#inte0219}

1. Added [Milvus](../integrations/milvus.md);
2. Added [Volcengine Public IP](../integrations/volcengine_eip.md);
3. Added [opentelemetry-python](../integrations/opentelemetry-python.md);
4. Added [openLIT Integration](../integrations/openlit.md);
5. Updated k8s\es\mongodb\rabbitmq\oracle\coredns\sqlserver English monitors & views.

### Bug Fixes {#bug0219}

1. Fixed special character issues causing anomalies in AI aggregated notification messages;
2. Fixed Servicemap deployment version compatibility issues;
3. Fixed hidden view variable configuration issues for combined charts;
4. Fixed disordered display issues in "Unresolved Problem List" on Exception Tracking > Analytical Dashboard;
5. Fixed inconsistent P75 results and DQL query results for most popular pages in User Access Monitoring Analytical Dashboard;
6. Fixed search box anomalies in User Access Monitoring > Explorer;
7. Fixed partial effectiveness issues for field mapping using resource catalogs in Scene > Object Mapping dashboards;
8. Fixed UI display issues for Monitor > Event Content;
9. Fixed unsatisfactory quick filter results for unresolved events in Event Explorer.

## January 16, 2025

### Feature Updates {#feature0116}

#### User Access Monitoring

1. Added [Funnel Analysis](../real-user-monitoring/user_insight_funnel.md) function: Users can define conversion steps to create funnels, view data conversions, and perform in-depth analysis;
2. Integrated User Insight Module: Added a User Insight Module, consolidating heatmaps and funnel analysis for comprehensive user behavior analysis tools;
3. Added mobile SourceMap restoration: Android and iOS applications support uploading SourceMap files on pages and viewing restored data in error explorers.

#### Application Performance Monitoring

APM added [automatic host injection](../application-performance-monitoring/explorer/auto_wire/autowire_on_host.md) installation guidance when adding services, simplifying the installation process.

#### Integration

1. DataKit (data collection tool): Added Docker installation guidance on the DataKit installation page, providing more diverse installation options;
2. External Data Source Optimization: Added query standard prompts when querying SLS data sources, helping users perform data queries more accurately.


#### Use Cases

[Combined Charts](../scene/visual-chart/index.md#conbine) Optimization: Combined charts added view variable configuration, supporting selection of current dashboard view variables for this combined chart, facilitating flexible data filtering and analysis.

#### Monitoring

Mutation Detection Monitor: Added support for weekly and monthly comparisons for query cycles.

#### AI Intelligent Assistant

Added DataFlux Func related knowledge base.

#### Pipeline

Auto-generated Pipeline Optimization: Supports simultaneous acquisition of Pipeline parsing via structured and natural language interaction.

### Bug Fixes {#bug0116}

1. Fixed display issues in log stacking mode;
2. Fixed misalignment issues in the log detection monitor function input box;
3. Fixed inaccurate metric calculation issues;
4. Fixed unsupported `having` statements in Volcengine;
5. Fixed errors when choosing "Request Error Rate" and "Average Requests Per Second" in application performance metric detection;
6. Fixed ineffective `not in` statements in Volcengine foundation;
7. Fixed excessive data returned in event lists affecting page load speed;
8. Fixed Hangzhou site's one-click event recovery not meeting expectations.

## January 8, 2025

### OpenAPI Updates {#openapi0108}

1. Field Management: Supports retrieving field management lists, supports [adding](../open-api/field-cfg/add.md)/[modifying](../open-api/field-cfg/modify.md)/[deleting](../open-api/field-cfg/delete.md) field management.
2. Usability Monitoring: Supports [modifying](../open-api/dialing-task/modify.md) dialing tasks.
3. Exception Tracking > Schedule: Supports retrieving schedule lists, supports [creating](../open-api/notification-schedule/add.md)/[modifying](../open-api/notification-schedule/modify.md)/[deleting](../open-api/notification-schedule/delete.md) schedules.
4. Exception Tracking > Configuration Management: Supports retrieving notification policy lists, supports [adding](../open-api/issue-notification-policy/add.md)/[modifying](../open-api/issue-notification-policy/modify.md)/[deleting](../open-api/issue-notification-policy/delete.md) notification policies; supports retrieving Issue discovery lists, supports [creating](../open-api/issue-auto-discovery/add.md)/[modifying](../open-api/issue-auto-discovery/modify.md)/[enabling/disabling](../open-api/issue-auto-discovery/set-disable.md)/[deleting](../open-api/issue-auto-discovery/delete.md) Issue discovery configurations.


### Feature Updates {#feature0108}

#### Logs

1. Log Index Optimization:
    - When accessing built-in log views and log context tabs, the current log’s index and `default` index will be selected by default respectively. Both tabs support multi-selection of indexes. Additionally, when cross-workspace querying is enabled and authorized workspaces are selected in the relevant menus, direct querying of index data from the corresponding workspaces is supported. Ultimately, this helps users comprehensively view associated log data on a single page, optimizing log query interactions.  
    - When listing log indexes, apart from `default` being displayed at the top, the remaining log indexes are listed in alphabetical order A-Z.
2. Log Explorer Added Stacking [View Mode](../logs/manag-explorer.md#mode): In stacking mode, fields will be consolidated into a single column, with these fields presented row-wise within cells. Log information display becomes more compact and clear, facilitating quick browsing and analysis by users.
3. Log Pipeline Optimization: Log Pipeline test samples now include all log fields and must be filled in line protocol format. User-entered logs must also adhere to the format requirements.

#### Use Cases

1. [Table Chart](../scene/visual-chart/table-chart.md) Optimization:
    - Multi-Metrics Query Sorting Support: When performing multi-metrics queries with a single DQL, the table chart now supports sorting.
    - Table Pagination Selection: Added table pagination selection functionality, allowing users to choose appropriate pagination sizes based on data volume and viewing needs.
2. Combined Charts: Supports adjusting the order of charts.
3. Chart Optimization: Adjusted the function order of the DQL query component, emphasizing the use scenario of the Rollup function to help users better utilize the Rollup function for data aggregation and analysis.

#### Management

1. Events Support Configuring [Data Forwarding](../management/backup/index.md): Supports configuring data forwarding rules for event types, saving event data that meets filter conditions to <<< custom_key.brand_name >>> object storage and forwarding it to external storage, providing flexible event data management capabilities.

2. Workspace Added DataKit [Environment Variables](../management/env_variable.md): Workspaces support managing DataKit environment variables, enabling users to easily configure and update environment variables for remote synchronization updates to DataKit collection configurations.

3. Query [Audit Events](../management/audit-event.md) Optimization: Added multiple fields for recording query information, while the event content supplements the query time range, facilitating tracking and analyzing query behaviors.

#### Pipeline

Auto-generated Pipeline Optimization: Changed the way tips appear, optimizing product experience.

#### AI Intelligent Assistant

AI Intelligent Assistant Added [Chart Generation](../guance-ai/index.md#chart): Based on large models automatically analyzing user input text data, intelligently generating suitable charts, solving problems such as cumbersome manual chart creation and difficulty in chart selection.

#### Monitoring

[Alert Policies](../monitoring/alert-setting.md#member): Member-configured notification rules support appending names for purpose descriptions.

### Deployment Plan Update {#deployment0108}

1. Management Backend > Workspace Menu Optimization:
    - Added primary storage engine and business two filter items to the workspace list, supporting convenient workspace filtering;
    - Optimized workspace list page return logic, when modifying/deleting a workspace or changing the data reporting limit for a workspace, remain on the current page to optimize the query experience.
2. Deployment Edition Added Parameter: `alertPolicyFixedNotifyTypes`, supports configuring whether the "Email" notification method is displayed in alert policies [Configuration Reference](/deployment/application-configuration-guide/#studio-backend).

### New Integrations {#inte0108}

1. Added [AWS Gateway Classic ELB](../integrations/aws_elb.md);
2. Added [Volcengine TOS Object Storage](../integrations/volcengine_tos.md);
3. Modified AWS Classic Collector Name;
4. Added [MinIO V3](../integrations/minio_v3.md) Integration;
5. Updated Elasticsearch, Solr, Nacos, InfluxDB V2, MongoDB Integrations (Views, Documentation, Monitors);
6. Updated Kubernetes Monitoring Views.

### Bug Fixes {#bug0108}

1. Resolved the issue of cross-space authorization for event data not taking effect;
2. Resolved the issue where carrying `trace_id` in log association link to trace explorer could not query data;
3. Resolved the issue where view expression queries could not fill in numerical values;
4. Resolved the issue where changing alert policies for external event detection monitors did not generate operation audit records;
5. Resolved the issue where column widths in event display lists could not be adjusted.