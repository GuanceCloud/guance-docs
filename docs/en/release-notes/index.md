---
icon: zy/release-notes
---

# Release Notes (2025)

---

This document records the update content descriptions for each <<< custom_key.brand_name >>> release.

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
        <td><a href="<<< homepage >>>/real-user-monitoring/miniapp/sdk-changelog/" target="_blank">Miniapp</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/android/sdk-changelog/" target="_blank">Android</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/ios/sdk-changelog/" target="_blank">iOS</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/react-native/sdk-changelog/" target="_blank">React Native</a></td>
      </tr>
    </table>

</div>

## March 26, 2025 {#20250326}

### Feature Updates {#feature0326}


#### Events

1. [Unrecovered Events](../events/event-explorer/unrecovered-events.md): The time widget is set to auto-refresh by default, and a new frontend page notification is added after manually recovering an event.
2. [Event Details](../events/event-explorer/event-details.md): Optimization of the alert notification page display.
3. Export options for events and intelligent monitoring explorers have been updated to include "whether notified" information.

#### Management

[Data Forwarding](../management/backup/index.md#permission): Added permission configuration. By setting view permissions for forwarded data, data security can be effectively improved.

#### Monitoring

1. [Infrastructure Survival Detection V2](../monitoring/monitor/infrastructure-detection.md): Added configurable detection intervals.
2. Alert Strategies: Adjusted notification matching logic to improve execution efficiency in scenarios where events hit multiple groups of strategies or complex alert strategies.
3. Notification Targets Management: Added [Slack](../monitoring/notify-target-slack.md) and [Teams](../monitoring/notify-target-teams.md) as two new notification targets to meet the needs of more global users.

#### Scenarios

1. View Variables: Support for querying external data sources.
2. Charts:
    
    - Added "[Monitor Summary](../scene/visual-chart/monitor_summary.md)" chart, integrating monitor lists to display the latest status for real-time monitoring and anomaly awareness.
    - Command Panel: Display optimization;
    - Chart Queries: In DQL queries, when using "wildcard" or "regex", new query suggestion prompts are added.
3. Explorers, Dashboards > Time Widget: Added "Last 1 minute" and "Last 5 minutes" options.

#### Billing Plans & Bills

1. Added [Monthly Bill](../billing/index.md#monthly_bill) module to visually display total monthly consumption.
2. Added bill export function.

#### User Analysis

Application List > Create Application: Added parameter configurations for "Compressed Upload" and "Custom Host Address".

#### Synthetic Tests

Added "South Africa" and "Hong Kong, China" as testing nodes, further expanding global coverage.

#### Logs

1. [Log Explorer](../logs/explorer.md)
    - Shortcut filtering operation adjustments;
    - Optimized list tokenization logic;
    - JSON formatted data added "[JSON Search](../logs/explorer-details.md#json)";
2. Indexes > Key Fields: Added "[One-click Extraction](../logs/multi-index/index.md#extract)".

<!--
#### AI Intelligent Assistant

Optimized [Chart Generation](../guance-ai/index.md#chart) feature: Through local Func cache metric management data, the generated DQL becomes more semantically descriptive.

-->

### New Integrations {#inte0326}

- Added [Azure Network Interfaces](../integrations/azure_network_interfaces.md);
- Added [Azure Kubernetes](../integrations/azure_kubernetes.md);
- Added [Azure Virtual Network Gateway](../integrations/azure_virtual_network_gateway.md);
- Improved English integration translations.

### Bug Fixes {#bug0326}

1. Fixed the issue of low utilization in log page displays.
2. Fixed the unit display issue for Service Maps.
3. Fixed the problem with tables not being able to select units for multiple columns.
4. Fixed the error when exporting dashboard > Log Flow charts to CSV with export row counts other than 1,000.
5. Fixed the inconsistency between the P75 results of the most popular pages and DQL query results.
6. Fixed the issue where the time filter still showed today after clicking the `<<` button.
7. Fixed menu management issues that did not meet expectations.
8. Fixed the abnormal search space ID filtering issue in the management backend.
9. Fixed the issue of lost test samples in the Pipeline interface.
10. Fixed the long processing time for configuration migration exports.
11. Fixed the issue of numerous empty items in quick filter tags on the event details interface after upgrading.
12. Fixed the issue of duplicate official template libraries in monitors and inability to search for other monitors once a library was selected.

## March 12, 2025 {#20250312}

### Breaking Changes {#breakingchanges0312}

[Events](../events/index.md) `df_alert_info` field definition adjustment: Added reasons for unmatched alert strategies. It is still necessary to use `isIgnored` to filter and obtain actual external notification targets.


### Feature Updates {#feature0312}

#### Incident Tracking

1. Added [Incident Tracking Management](../management/index.md#personal_incidents) entry point, allowing current logged-in users to view and manage the status of all incident tracking within joined workspaces.
2. Optimized [Channel List](../exception/channel.md#list) display on the incident tracking page, improving query efficiency when there are many channels.

#### Management

1. [Cloud Account Management](../management/cloud-account-manag.md#alibaba): Added Alibaba Cloud account authorization type.
2. [API Key Management](../management/api-key/index.md): Added permission control functionality for API Keys, supporting role-based authorization. Through role-based authorization, API Keys only have operational permissions within the scope of the role, thereby effectively reducing security risks.
3. Data Forwarding: Default interaction changed to unselected rules.

#### AI Error Analysis

The following detail pages added [AI Error Analysis](../logs/explorer-details.md#ai) capabilities:

- Error logs
- APM > Trace/Error Tracking

#### Scenarios

1. Scheduled Reports:

    - Added Webhook sending as a notification method;
    - Supported sharing dashboard images to WeCom/DingTalk.

2. Time Series Chart: After selecting area chart as the chart type, added [Stacked Mode](../scene/visual-chart/timeseries-chart.md#style) style to facilitate observing the cumulative effect of overall data.

#### APM

Trace: Supported batch export of JSONL format for trace lists.

#### RUM

User Insights > [Funnel Analysis](../real-user-monitoring/user_insight_funnel.md): For queried session lists, supported Session Replay functionality.

#### Logs

1. Explorer:    
    - Log Explorer > Index Quick Filter optimized display in the search bar; 
    - Log Details > Extended Fields: Added "Dimension Analysis" mode;         
2. Indexes: Supported setting exclusive [Key Fields](../logs/multi-index/index.md#key_key) under index dimensions.

#### Explorer Time Widget

Left-side selection of time range independent from right-side refresh frequency. Only two cases affect refresh frequency:  

- Selected time range exceeds 1h       
- Selected time is absolute time     


#### Infrastructure

Hosts: Explorer supports adjusting time ranges.

   
#### Pipeline

1. Configuration page display optimization;
2. Pipeline Processing Types added "Events";
3. Test Samples support JSON format retrieval.
4. Filtering Conditions > Synthetic Tests: Supported selecting multi-step tests.

### Deployment Plan Update {#deployment0312}

[Template Management](../deployment/integration.md): Supported uploading all explorer templates.

### New Integrations {#inte0312}

- Added [Azure Load Balancer](../integrations/azure_load_balancer.md);
- Rewrote [K8S Server API](../integrations/kubernetes-api-server.md);
- Updated [Gitlab CI](../integrations/gitlab.md);
- Translated Volcengine-related views;
- Translated AWS-related views.

### Bug Fixes {#bug0312}

1. Fixed the issue of no response when exporting log flow diagrams to CSV.
2. Fixed the issue of no data in time series charts after adding relevant filters when using `runtime-id` fields for SLA view variables in `ddtrace` collected JVM metrics.
3. Fixed the display issue of custom gradient interval color scales.
4. Fixed the issue where filter conditions >0 were blank after saving and re-editing DQL queries in time series chart editing.
5. Fixed the abnormal display of infrastructure table charts in application performance monitoring.
6. Fixed the issue where forwarding rules in the frontend did not support setting storage duration to 1,800 days in the management backend.
7. Fixed the error "kodo service API request error: Service Unavailable" when executing show_object_field(`HOST`) in quick queries.
8. Fixed bugs in shortcuts.
9. Fixed the issue of no data for `session` and `view` in RUM while other `resources` and actions had data.
10. Fixed the issue of immediate validation of required fields when creating multi-step tests.
11. Fixed the issue where filter conditions did not take effect when setting role authorizations for data access.


## February 27, 2025 {#20250227}

### OpenAPI Update {#openapi0227}

Metrics: Added [Metric Set and Label Information Retrieval](../open-api/metric/metric-info-get.md).

### Feature Updates {#feature0227}

#### Synthetic Tests

1. HTTP Tests: Supported [Script Mode](../usability-monitoring/request-task/http.md#script). By writing Pipeline scripts, flexibly customize judgment conditions and data processing logic for test tasks.
2. Added [Multi-step Tests](../usability-monitoring/request-task/multistep_test.md): Allowed creation of tests using response data from multiple connected APIs and passing values through local variables to link multiple task requests.


#### Scenarios

1. Dashboard > Visibility Scope: Added "Custom" configuration, which allows configuring "Operation" and "View" permissions for this dashboard. This configuration also added the option of "All Members".
2. Charts:
    - Added AI-generated chart title and description capability;
    - Log Flow Diagram added "Rule Mapping" function;
    - Table Chart column display optimized;
    - Grouped Table Charts: Expression results support sorting;
    - Time Series Chart, Pie Chart, and multiple charts support data export as CSV files.

#### Metrics

1. [Metric Analysis > Table Chart](../metrics/explorer.md#table): When query results exceed 2,000 entries, three modes added "Query Result Count" display.
2. [Metric Management](../metrics/dictionary.md): Supported one-click jump to Metric Analysis.
3. [Generated Metrics](../metrics/generate-metrics.md#manage): Supported import creation method and batch export.

#### Infrastructure

Container/Pod Explorer: Object data added four new fields: `cpu_usage_by_limit`, `cpu_usage_by_request`, `mem_used_percent_base_limit`, `mem_used_percent_base_request`.

#### APM

1. Profiling > Flame Graph Interaction Optimization: Selecting a single search method name directly focuses and locates.
2. ServiceMap Interaction Optimization: Supported searching nodes in the current canvas on upstream/downstream pages.

### New Integrations {#inte0227}

- Added [AWS Cloud Billing](../integrations/aws_billing.md);
- Added [Kube Scheduler](../integrations/kube_scheduler.md);
- Added [MQTT](../integrations/mqtt.md);
- Rewrote [APISIX](../integrations/apisix.md);
- Updated [TiDB](../integrations/tidb.md) English documentation and views;
- Updated [Zookeeper](../integrations/zookeeper.md) views and added integration icons;
- Fixed partial component mainfest.yaml English translations.

### Bug Fixes {#bug0227}

1. Fixed the issue of incorrect display when clicking on the link tab in Application Performance Monitoring > Trace Details;
2. Fixed the issue of incorrect `@member` in Issue replies in Exception Tracking;
3. Fixed the issue of incorrect temperature units in charts.


## February 19, 2025

### Breaking Changes {#breakingchanges0219}

[Events](../events/index.md) `df_meta` will no longer retain `alert_info` related information records. Users previously relying on this information to retrieve notification targets should switch to using the newly added `df_alert_info` (event alert notifications), `df_is_silent` (whether muted), and `df_sent_target_types` (event notification target types) fields to complete corresponding functions.

Potentially affected functional scenarios:

1. Custom usage scenarios for obtaining events via OpenAPI to connect with external systems
2. Custom usage scenarios for forwarding notification targets via Webhook to external systems

### Feature Updates {#feature0116}


#### PromQL Query

Added Instant Query type: querying for a single time point.

#### Monitoring

Monitor Configuration Page:

1. Added `not between` option in trigger condition logical matching;
2. Supported directly modifying monitor status ("Enable" or "Disable").

#### APM

Trace: Added [Service Context](../application-performance-monitoring/explorer/explorer-analysis.md#context) tab page in the details page.


#### Events

Event Details Page: Added support for binding [Built-in Views](../events/event-explorer/event-details.md#inner_view);

#### Incident Tracking

1. Issues added [`working`, `closed` states](../exception/issue.md#concepts);
2. For timeouts in `open` state and no responsible person assigned or processing timeout, [Issue Upgrade](../exception/config-manag/strategy.md#upgrade) added repeated notification configuration;
3. Adjusted UI display of system comments and channel notifications for Issues;
4. Analysis Dashboard: Added time widget.


#### Scenarios

1. [Chart Links](../scene/visual-chart/chart-link.md): Added "View Host Monitoring View," defaulted to off.
2. Explorer: Supported deleting fixed `name` columns, allowing users to customize list displays.
3. Cloud Billing Analysis View: Supported viewing detailed billing information.

#### Management

[Role Management](../management/role-list.md): Session Replay view, audit events added custom add view permission capability.

#### Metrics

Generated Metrics: Metric name input no longer supports `-` hyphens.

#### Integration

Integration Cards added description information.

### Deployment Plan Update {#deployment0219}

1. Template Management: Supported uploading infrastructure explorer templates;
2. Index Configuration: Deprecated "Backup Logs" item; Configurable storage strategy available in "Edit Workspace > Data Storage Policy > Data Forwarding - Default Storage."

### New Integrations {#inte0219}

1. Added [Milvus](../integrations/milvus.md);
2. Added [Volcengine Public IP](../integrations/volcengine_eip.md);
3. Added [opentelemetry-python](../integrations/opentelemetry-python.md);
4. Added [OpenLIT Integration](../integrations/openlit.md);
5. Updated k8s/es/mongodb/rabbitmq/oracle/coredns/sqlserver English monitors & views.

### Bug Fixes {#bug0219}

1. Fixed the issue of special characters causing abnormal results in AI aggregated notifications;
2. Fixed the compatibility issue of Servicemap in the deployment version;
3. Fixed the issue of hidden view variables not being configurable in composite charts;
4. Fixed the layout issue in "Unresolved Problem List" in Exception Tracking > Analysis Dashboard;
5. Fixed the inconsistency between the P75 result of the most popular pages in User Access Monitoring analysis dashboard and the DQL query result;
6. Fixed the abnormal behavior of the search box in User Access Monitoring > Explorer;
7. Fixed the issue where only some parts of the same field took effect in Scene > Object Mapping when using Resource Catalog for field mapping;
8. Fixed the UI display issue of Event Content in Monitors;
9. Fixed the issue where the quick filter results of unrecovered events in the Event Explorer did not meet expectations.

## January 16, 2025

### Feature Updates {#feature0116}

#### User Analysis

1. Added [Funnel Analysis](../real-user-monitoring/user_insight_funnel.md) feature: Users can define conversion steps to create funnels, view data conversion, and conduct in-depth analysis;
2. Integrated User Insights Module: Added a User Insights module, consolidating heatmaps and funnel analysis in this module, providing comprehensive user behavior analysis tools;
3. Added Mobile SourceMap Restoration: Android and iOS applications support uploading SourceMap files on pages and support viewing restored data in error explorers.

#### APM

When adding services in APM, added [Automatic Host Injection](../application-performance-monitoring/explorer/auto_wire/autowire_on_host.md) installation guidance, simplifying the installation process.

#### Integration

1. DataKit (Data Collection Tool): Added Docker installation guidance on the DataKit installation page, providing more diversified installation options;
2. External Data Source Optimization: Added query standard prompts when querying SLS data sources, helping users accurately query data.

#### Scenarios

[Composite Charts](../scene/visual-chart/index.md#conbine) Optimization: Composite charts added view variable configuration, supporting selection of view variables from the current dashboard to apply to this composite chart, helping more flexibly filter and analyze data.

#### Monitoring

Mutational Detection Monitor: Added support for week-on-week and month-on-month comparisons for query cycles.

#### AI Intelligent Assistant

Added DataFlux Func knowledge base.

#### Pipeline

Optimized automatic generation of Pipelines: Supported simultaneous acquisition of structured and natural language interaction to parse Pipelines.

### Bug Fixes {#bug0116}

1. Fixed the display issue in log stacking mode;
2. Fixed the misalignment of the input box in log detection monitors;
3. Fixed the issue with incorrect metric calculations;
4. Fixed the unsupported `having` statement in Volcengine;
5. Fixed the error when selecting "Request Error Rate" and "Average Requests per Second" in application performance metric detection;
6. Fixed the issue where the `not in` statement in the Volcengine platform was ineffective;
7. Fixed the issue where large amounts of returned event list data affected page loading speed;
8. Fixed the issue where the one-click recovery of Hangzhou site events did not meet expectations.

## January 8, 2025

### OpenAPI Updates {#openapi0108}

1. Field Management: Supported getting field management lists, supported [Adding](../open-api/field-cfg/add.md)/[Modifying](../open-api/field-cfg/modify.md)/[Deleting](../open-api/field-cfg/delete.md) field management.
2. Synthetic Tests: Supported [Modifying](../open-api/dialing-task/modify.md) dialing tasks.
3. Incident Tracking > Schedules: Supported getting schedule lists, supported [Creating](../open-api/notification-schedule/add.md)/[Modifying](../open-api/notification-schedule/modify.md)/[Deleting](../open-api/notification-schedule/delete.md) schedules.
4. Incident Tracking > Configuration Management: Supported getting notification policy lists, supported [Creating](../open-api/issue-notification-policy/add.md)/[Modifying](../open-api/issue-notification-policy/modify.md)/[Deleting](../open-api/issue-notification-policy/delete.md) notification policies; Supported getting Issue discovery lists, supported [Creating](../open-api/issue-auto-discovery/add.md)/[Modifying](../open-api/issue-auto-discovery/modify.md)/[Enabling/Disabling](../open-api/issue-auto-discovery/set-disable.md)/[Deleting](../open-api/issue-auto-discovery/delete.md) Issue discovery configurations.

### Feature Updates {#feature0108}

#### Logs

1. Log Index Optimization:
    - When accessing built-in log views or log context tabs, they will respectively default-select the index containing the current log and the `default` index. Both tabs support multi-selection of indexes. Additionally, when cross-workspace queries are enabled and authorized workspaces are selected from the menu, it supports directly querying corresponding workspace index data here. This helps users comprehensively view associated log data on one page, optimizing log query interactions.
    - When listing log indexes, apart from the `default` index being displayed at the top, other log indexes are listed alphabetically from A-Z.
2. Log Explorer Added Stacked [View Mode](../logs/manag-explorer.md#mode): Under stacked mode, fields will be consolidated into one column, and these fields will be presented as rows within cells. Log information is displayed more compactly and clearly, facilitating quick browsing and analysis by users.
3. Log Pipeline Optimization: Test samples for log pipelines have been adjusted to obtain all fields of logs and must be filled in line protocol format. At the same time, user-entered logs must also follow the formatting requirements.

#### Scenarios

1. [Table Charts](../scene/visual-chart/table-chart.md) Optimization:
    - Multi-Metric Query Sorting Support: When performing multi-metric queries using one DQL, table charts now support sorting.
    - Table Pagination Selection: Added table pagination selection functionality, allowing users to choose appropriate pagination sizes based on data volume and viewing needs.
2. Composite Charts: Supported adjusting the order of charts.
3. Chart Optimization: Adjusted the function order of the DQL query component, particularly emphasizing the use scenarios of the Rollup function, helping users better utilize the Rollup function for data aggregation and analysis.

#### Management

1. Events Supported Configuring [Data Forwarding](../management/backup/index.md): Supported configuring data forwarding rules for event types, saving event data meeting filtering conditions to <<< custom_key.brand_name >>> object storage and forwarding it to external storage, providing flexible event data management capabilities.

2. Workspaces Added DataKit [Environment Variables](../management/env_variable.md): Workspaces support managing DataKit environment variables, allowing users to easily configure and update environment variables to achieve remote synchronization updates of DataKit collection configurations.

3. Query [Audit Events](../management/audit-event.md) Optimization: Added multiple fields to record query information, and supplemented the query time range in the event content, facilitating tracking and analyzing query behaviors.

#### Pipeline

Optimized Automatic Pipeline Generation: Changed the way hints appear, improving product experience.

#### AI Intelligent Assistant

AI Intelligent Assistant Added [Chart Generation](../guance-ai/index.md#chart): Based on large models automatically analyzing user-input text data, the chart generation function intelligently generates appropriate charts, solving problems such as tedious manual chart creation and difficulty in choosing charts.

#### Monitoring

[Alert Policies](../monitoring/alert-setting.md#member): Supports appending names used for purpose descriptions when configuring notification rules according to members.

### Deployment Plan Update {#deployment0108}

1. Management Backend > Workspace Menu Optimization:
    - Added primary storage engine and business as two filter options in the workspace list, supporting convenient workspace filtering;
    - Optimized the pagination return logic of the workspace list page. When modifying/deleting a workspace or changing the data reporting limits of a workspace, it stays on the current page to optimize the query experience.
2. Deployment Edition Added Parameter: `alertPolicyFixedNotifyTypes`, supports configuring whether the "email" notification method is displayed in alert policies [Configuration Reference](/deployment/application-configuration-guide/#studio-backend).

### New Integrations {#inte0108}

1. Added [AWS Gateway Classic ELB](../integrations/aws_elb.md);
2. Added [Volcengine TOS Object Storage](../integrations/volcengine_tos.md);
3. Modified AWS Classic collector name;
4. Added [MinIO V3](../integrations/minio_v3.md) integration;
5. Updated elasticsearch, solr, nacos, influxdb_v2, mongodb integrations (views, documentation, monitors);
6. Updated kubernetes monitoring views.

### Bug Fixes {#bug0108}

1. Resolved the issue of cross-space authorization for event data not taking effect;
2. Resolved the issue where carrying `trace_id` in links to trace explorers failed to query data;
3. Resolved the issue where numerical filling could not be performed in view expression queries;
4. Resolved the issue where no operational audit records were generated when changing alert policies for external event detectors;
5. Resolved the issue where column widths in event display lists could not be adjusted.