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
        <td><a href="<<< homepage >>>/real-user-monitoring/miniapp/sdk-changelog/" target="_blank">Miniapp</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/android/sdk-changelog/" target="_blank">Android</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/ios/sdk-changelog/" target="_blank">iOS</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/react-native/sdk-changelog/" target="_blank">React Native</a></td>
      </tr>
    </table>

</div>

## March 26, 2025 {#20250326}

### Feature Updates {#feature0326}


#### Incidents

1. [Unrecovered Events](../events/event-explorer/unrecovered-events.md): The time widget now refreshes automatically by default, and a new front-end page prompt is added after manually recovering an event.
2. [Event Details](../events/event-explorer/event-details.md): Improved display of alert notification pages.
3. Export options for events and intelligent monitoring explorers have been updated to include "Notification Status."

#### Management

[Data Forwarding](../management/backup/index.md#permission): Added permission configuration. By setting view permissions for forwarded data, data security can be effectively improved.

#### Monitoring

1. [Infrastructure Liveness Detection V2](../monitoring/monitor/infrastructure-detection.md): Added configurable detection intervals.
2. Alert Policies: Notification matching logic has been adjusted to improve execution efficiency in scenarios where events hit multiple policies or complex alert strategies.
3. Notification Targets: Added Slack and Teams as two new notification targets to meet the needs of more global users.

#### Use Cases

1. View Variables: External data source queries are supported.
2. Charts:
    
    - A new "[Monitor Summary](../scene/visual-chart/monitor_summary.md)" chart has been added, integrating the monitor list to display the latest status for real-time monitoring and anomaly trend perception.
    - Command Panel: Display improvements;
    - Chart Queries: In DQL queries, when using "wildcard" or "regex," new query suggestion prompts have been added.
3. Explorers, Dashboards > Time Widget: Added "Last 1 Minute" and "Last 5 Minutes" options.

#### Billing

1. Added [Monthly Bill](../billing/index.md#monthly_bill) module for intuitive display of monthly consumption totals.
2. Added export bill functionality.

#### Synthetic Tests

Application List > Create Application: Added parameter configurations for "Compressed Upload" and "Custom Hosted Address."

#### Synthetic Testing

Added "South Africa" and "Hong Kong, China" as testing nodes to further expand global coverage.

#### Logs

1. [Log Explorer](../logs/explorer.md)
    - Shortcut filtering operations have been adjusted;
    - Tokenization logic for lists has been optimized;
    - JSON formatted data has added "[JSON Search](../logs/explorer-details.md#json)";
2. Indexes > Key Fields: Added "[One-click Extraction](../logs/multi-index/index.md#extract)."

<!--
#### AI Intelligent Assistant

Optimized [Chart Generation](../guance-ai/index.md#chart) function: Through local Func cache management metrics, generated DQL is closer to semantic descriptions.

-->
### New Integrations {#inte0326}

- Added [Azure Network Interfaces](../integrations/azure_network_interfaces.md);
- Added [Azure Kubernetes](../integrations/azure_kubernetes.md);
- Added [Azure Virtual Network Gateway](../integrations/azure_virtual_network_gateway.md);
- Improved English integration translations.

### Bug Fixes {#bug0326}

1. Fixed low utilization issue on log page display.
2. Fixed metric unit display issues on Service Maps.
3. Fixed inability to select units for multiple columns in table charts.
4. Fixed errors when exporting log stream charts to CSV with selections other than 1,000.
5. Fixed inconsistencies between P75 results on popular pages and DQL query results.
6. Fixed issue where the time filter still showed today after clicking the `<<` button.
7. Fixed unexpected behavior in menu management.
8. Fixed abnormal search space ID filtering in the admin backend.
9. Fixed missing test sample issues in Pipeline interfaces.
10. Fixed excessive duration of configuration migration export functionality.
11. Fixed numerous empty items in quick filters on the event details interface after upgrades.
12. Fixed duplicate entries in the official template library for monitors and inability to search other monitors once a template was selected.

## March 12, 2025 {#20250312}

### Breaking Changes {#breakingchanges0312}

[Events](../events/index.md) `df_alert_info` field definition adjustment: Added explanations for unmatched alert policy reasons. Filtering judgments to obtain actual external notifications still require the use of `isIgnored`.

### Feature Updates {#feature0312}

#### Incident Management

1. Added [Incident Management](../management/index.md#personal_incidents) entry. Logged-in users can view and manage all incident tracking statuses for workspaces they have joined.
2. Optimized [Channel List](../exception/channel.md#list) display for incidents to improve querying efficiency when there are too many channels.

#### Management

1. [Cloud Account Management](../management/cloud-account-manag.md#alibaba): Added Alibaba Cloud account authorization type.
2. [API Key Management](../management/api-key/index.md): Added permission control functionality for API Keys, supporting role-based authorization. Through role-based authorization, API Keys only possess operation permissions within the scope of the role, thereby effectively reducing security risks.
3. Data Forwarding: Default interaction changed to unselected rules.

#### AI Error Analysis

The following detail pages have added [AI Error Analysis](../logs/explorer-details.md#ai) capabilities:

- error logs
- APM > Trace/Error Tracking

#### Use Cases

1. Scheduled Reports:

    - Added Webhook as a notification method;
    - Supported sharing dashboard images to WeCom/DingTalk.

2. Time Series Charts: After selecting area chart as the chart type, added [Stack Mode](../scene/visual-chart/timeseries-chart.md#style) style for easier observation of overall data accumulation effects.

#### APM

Traces: Supports batch export of JSONL format.

#### RUM

User Analysis > [Funnel Analysis](../real-user-monitoring/user_insight_funnel.md): Session lists queried support session replay functionality.


#### Logs

1. Explorer:    
    - Log Explorer > Index Quick Filter optimization in the search bar; 
    - Log Details > Extended Fields: Added "Dimension Analysis" mode;         
2. Indexes: Supports setting exclusive [Key Fields](../logs/multi-index/index.md#key_key) under index dimensions.

#### Explorer Time Widget

Left-side time range selection and right-side refresh frequency are independent. Only two situations affect refresh frequency:  

- Selected time range exceeds 1h       
- Selected time is absolute time     


#### Infrastructure

HOST: Explorer supports adjusting time ranges.
   
#### Pipelines

1. Configuration page display optimization;
2. Pipeline processing types added "Incident";
3. Test samples support JSON format acquisition.
4. Filtering Conditions > Synthetic Tests: Supports multi-step synthetic tests.

### Deployment Edition Update {#deployment0312}

[Template Management](../deployment/integration.md): Supports uploading all explorer templates.

### New Integrations {#inte0312}

- Added [Azure Load Balancer](../integrations/azure_load_balancer.md);
- Rewritten [K8S Server API](../integrations/kubernetes-api-server.md);
- Updated [GitLab CI](../integrations/gitlab.md);
- Translated Volcengine-related views;
- Translated AWS-related views.

### Bug Fixes {#bug0312}

1. Fixed no response issue when exporting log flowcharts to CSV.
2. Fixed the issue where no data appeared in time series charts after adding related filters when using `ddtrace` collected JVM metrics with `runtime-id` as the variable.
3. Fixed the issue with gradient color scale interface display.
4. Fixed the issue where the filter condition shows empty after saving when editing DQL queries in time series charts.
5. Fixed the abnormal display of infrastructure table charts in application performance monitoring.
6. Fixed the issue where the forwarding rule does not support storage durations set to 1,800 days in the management backend.
7. Fixed the error message "kodo service API request error: Service Unavailable" when executing quick queries with `show_object_field(HOST)`.
8. Fixed bugs in quick access.
9. Fixed the issue where `session` and `view` have no data while other `resources` and actions have data in RUM.
10. Fixed the issue where required fields were immediately validated during multi-step synthetic test creation.
11. Fixed the issue where filtering conditions did not take effect when setting role authorizations for data access.

## February 27, 2025 {#20250227}

### OpenAPI Updates {#openapi0227}

Metrics: Added [Metric Set and Label Information Retrieval](../open-api/metric/metric-info-get.md).

### Feature Updates {#feature0227}

#### Synthetic Testing

1. HTTP Synthetic Tests: Added [Script Mode](../usability-monitoring/request-task/http.md#script). Customizable judgment conditions and data processing logic for synthetic test tasks via Pipeline scripts.
2. Added [Multi-step Synthetic Tests](../usability-monitoring/request-task/multistep_test.md): Allows creating tests using response data from multiple connected APIs and linking multiple task requests through local variable transmission.

#### Use Cases

1. Dashboard > Visibility Scope: Added "Custom" configuration, allowing configuration of "Operation" and "View" permissions for this dashboard. This configuration also includes a new "All Members" option.
2. Charts:
    - Added AI-based automatic generation of chart titles and descriptions;
    - Log Flow Chart added "Rule Mapping" function;
    - Table Chart column display optimization;
    - Grouped Table Chart: Expression results support sorting;
    - Time Series Chart, Pie Chart, and multiple tables support data export to CSV files.

#### Metrics

1. [Metrics Analysis > Table Chart](../metrics/explorer.md#table): When query results exceed 2,000 entries, three modes add "Query Result Count" display.
2. [Metric Management](../metrics/dictionary.md): Supports one-click jump to Metric Analysis.
3. [Generated Metrics](../metrics/generate-metrics.md#manage): Supports import creation methods, supports batch export.

#### Infrastructure

Container/Pod Explorer: Object data added four new fields: `cpu_usage_by_limit`, `cpu_usage_by_request`, `mem_used_percent_base_limit`, `mem_used_percent_base_request`.

#### APM

1. Profiling > Flame Graph Interaction Optimization: Selecting a single search method name allows direct focus positioning.
2. ServiceMap Interaction Optimization: Supports searching nodes on the current canvas in upstream/downstream pages.

### New Integrations {#inte0227}

- Added [AWS Cloud Billing](../integrations/aws_billing.md);
- Added [Kube Scheduler](../integrations/kube_scheduler.md);
- Added [MQTT](../integrations/mqtt.md);
- Rewritten [APISIX](../integrations/apisix.md);
- Updated [TiDB](../integrations/tidb.md) English documentation and views;
- Updated [Zookeeper](../integrations/zookeeper.md) views, added integration icons;
- Fixed English translation of some component mainfest.yaml files.

### Bug Fixes {#bug0227}

1. Fixed the issue where tab pages in application performance monitoring > trace details displayed incorrectly;
2. Fixed the issue where `@member` in exception tracking > Issue replies was incorrect;
3. Fixed the issue where temperature units in charts were incorrect.


## February 19, 2025

### Breaking Changes {#breakingchanges0219}

[Events](../events/index.md) `df_meta` will no longer retain `alert_info` related information records. Users previously relying on this information to obtain notification targets should switch to using the newly added `df_alert_info` (event alert notifications), `df_is_silent` (whether muted), and `df_sent_target_types` (event notification object types) fields to complete corresponding functions.

Potentially affected functional scenarios:

1. Custom usage scenarios for obtaining events via OpenAPI to connect to external systems
2. Custom usage scenarios for forwarding notification targets via Webhooks to external systems

### Feature Updates {#feature0116}

#### PromQL Query

Added query type: Instant Query, which performs queries for a single time point.

#### Monitoring

Monitor configuration page:

1. Added `not between` option in the logical match of trigger conditions;
2. Supports directly modifying monitor status ("Enable" or "Disable").

#### APM

Trace: Added [Service Context](../application-performance-monitoring/explorer/explorer-analysis.md#context) tab page in detail pages.

#### Events

Event Details Page: Added support for binding [Built-in Views](../events/event-explorer/event-details.md#inner_view);

#### Exception Tracking

1. Issues added [`working`, `closed` statuses](../exception/issue.md#concepts);
2. For timeouts staying in `open` status without specified responsible persons and handling timeouts, [Issue Upgrade](../exception/config-manag/strategy.md#upgrade) added repeated notification configuration;
3. Adjusted UI display for Issue system comments and channel notifications;
4. Analytical Dashboard: Added time widget.

#### Use Cases

1. [Chart Links](../scene/visual-chart/chart-link.md): Added "View Host Monitoring View", default off.
2. Explorer: Supports deleting fixed `name` columns, users can customize list displays.
3. Cloud Billing Analysis View: Supports viewing billing details.

#### Management

[Role Management](../management/role-list.md): Session Replay view, audit events added custom addition of view permission capability.

#### Metrics

Generated Metrics: Metric name input no longer supports hyphens `-`.

#### Integration

Integration Cards added descriptive information.

### Deployment Edition Update {#deployment0219}

1. Template Management: Supports uploading infrastructure explorer templates;
2. Index Configuration: Deprecated "Backup Logs" item; Configurable storage strategy available at "Edit Workspace > Data Storage Policy > Data Forwarding - Default Storage".

### New Integrations {#inte0219}

1. Added [Milvus](../integrations/milvus.md);
2. Added [Volcengine Public IP](../integrations/volcengine_eip.md);
3. Added [opentelemetry-python](../integrations/opentelemetry-python.md);
4. Added [OpenLIT Integration](../integrations/openlit.md);
5. Updated k8s/es/mongodb/rabbitmq/oracle/coredns/sqlserver English monitors & views.

### Bug Fixes {#bug0219}

1. Fixed special character issues causing abnormal results in AI aggregated notifications;
2. Fixed compatibility issues for Servicemap deployment edition;
3. Fixed hidden view variables being unconfigurable in composite charts;
4. Fixed disordered display of "Unrecovered Problem List" in Exception Tracking > Analytical Dashboard;
5. Fixed inconsistent P75 results and DQL query results in User Access Monitoring Analytical Dashboard;
6. Fixed viewer search box anomalies in User Access Monitoring;
7. Fixed partial effectiveness of same fields in Scene > Object Mapping boards;
8. Fixed UI display issues for Monitor > Event Content;
9. Fixed unsatisfactory quick filter results for unrecovered events in Event Viewer.

## January 16, 2025

### Feature Updates {#feature0116}

#### User Analysis

1. Added [Funnel Analysis](../real-user-monitoring/user_insight_funnel.md) feature: Users can define conversion steps to create funnels, view data conversions, and conduct in-depth analysis;
2. Integrated User Insights Module: Added User Insights module, combining heatmaps and funnel analysis for more comprehensive user behavior analysis tools;
3. Added Mobile SourceMap Restoration: Android and iOS applications support uploading SourceMap files on pages and viewing restored data in error viewers.

#### APM

When adding services in APM, added [Automatic Host Injection](../application-performance-monitoring/explorer/auto_wire/autowire_on_host.md) installation guide to simplify the installation process.

#### Integration

1. DataKit (Data Collection Tool): Added Docker installation guidance on the DataKit installation page, providing more diversified installation options;
2. External Data Source Optimization: Added query standard tips when querying SLS data sources to help users perform data queries more accurately.

#### Use Cases

[Composite Charts](../scene/visual-chart/index.md#conbine) Optimization: Composite charts added view variable configuration, supporting the selection of view variables from the current dashboard for this composite chart, enabling more flexible data filtering and analysis.

#### Monitoring

Mutational Detection Monitors: Added support for week-over-week and month-over-month comparisons for query cycles.

#### AI Intelligent Assistant

Added DataFlux Func knowledge base.

#### Pipelines

Automatic Pipeline Generation Optimization: Supports simultaneous structural and natural language interaction to obtain Pipeline parsing.

### Bug Fixes {#bug0116}

1. Fixed display issues in log stacking mode;
2. Fixed misalignment of input boxes in log detection monitors;
3. Fixed erroneous metric calculations;
4. Fixed lack of `having` statement support in Volcengine;
5. Fixed errors when selecting "Request Error Rate" and "Average Requests Per Second" metrics in application performance metric detection;
6. Fixed ineffective `not in` statements in Volcengine base;
7. Fixed slow page loading due to large data returns in event lists;
8. Fixed non-compliance with expectations for one-click event recovery in Hangzhou site.

## January 8, 2025

### OpenAPI Updates {#openapi0108}

1. Field Management: Supports obtaining field management lists, supports [Adding](../open-api/field-cfg/add.md)/[Modifying](../open-api/field-cfg/modify.md)/[Deleting](../open-api/field-cfg/delete.md) field management.
2. Synthetic Tests: Supports [Modifying](../open-api/dialing-task/modify.md) dialing tasks.
3. Exception Tracking > Schedules: Supports obtaining schedule lists, supports [Creating](../open-api/notification-schedule/add.md)/[Modifying](../open-api/notification-schedule/modify.md)/[Deleting](../open-api/notification-schedule/delete.md) schedules.
4. Exception Tracking > Configuration Management: Supports obtaining notification policy lists, supports [Creating](../open-api/issue-notification-policy/add.md)/[Modifying](../open-api/issue-notification-policy/modify.md)/[Deleting](../open-api/issue-notification-policy/delete.md) notification policies; Supports obtaining Issue discovery lists, supports [Creating](../open-api/issue-auto-discovery/add.md)/[Modifying](../open-api/issue-auto-discovery/modify.md)/[Enabling/Disabling](../open-api/issue-auto-discovery/set-disable.md)/[Deleting](../open-api/issue-auto-discovery/delete.md) Issue discovery configurations.


### Feature Updates {#feature0108}

#### Logs

1. Log Index Optimization:
    - When accessing built-in log views and log context tabs, the respective currently active log index and `default` index will be pre-selected by default. Both tabs support multi-selection of indexes. Additionally, when cross-workspace queries are enabled and authorized workspaces are selected from the menu, it is possible to directly query the index data of corresponding workspaces here. This ultimately helps users fully view associated log data on one page, optimizing log query interactions.
    - When listing log indexes, apart from `default` being displayed at the top, the remaining log indexes are listed in alphabetical order A-Z.
2. Log Explorer Added Stacking [View Mode](../logs/manag-explorer.md#mode): Under stacking mode, fields will be consolidated into a single column and presented in rows within cells. Log information is displayed more compactly and clearly, facilitating quick browsing and analysis by users.
3. Log Pipeline Optimization: Log Pipeline test samples are adjusted to acquire all fields of logs and must be filled in row protocol format. Additionally, user-entered logs must adhere to format requirements.

#### Use Cases

1. [Table Charts](../scene/visual-chart/table-chart.md) Optimization:
    - Multi-Metric Query Sorting Support: When performing multi-metric queries with a single DQL, table charts now support sorting.
    - Table Pagination Selection: Added table pagination selection functionality, allowing users to choose appropriate pagination sizes based on data volume and viewing needs.
2. Composite Charts: Supports adjusting the order of charts.
3. Chart Optimization: Adjusted the function order of DQL query components, emphasizing the use cases of the Rollup function to help users better utilize it for data aggregation and analysis.

#### Management

1. Events Support Configuring [Data Forwarding](../management/backup/index.md): Supports configuring data forwarding rules for event types, saving filtered event data to <<< custom_key.brand_name >>>'s object storage and forwarding it to external storage, providing flexible event data management capabilities.

2. Workspace Added DataKit [Environment Variables](../management/env_variable.md): Workspaces support managing DataKit environment variables, allowing users to easily configure and update environment variables for remote synchronized updates to DataKit collection configurations.

3. Query [Audit Events](../management/audit-event.md) Optimization: Added multiple fields for recording query information, and supplemented the query time range in the event content, facilitating tracking and analyzing query behaviors.

#### Pipelines

Automatic Pipeline Generation Optimization: Changed the way hints appear, improving product experience.

#### AI Intelligent Assistant

AI Intelligent Assistant Added [Chart Generation](../guance-ai/index.md#chart): Based on large models, the chart generation function automatically analyzes user input text data and intelligently generates suitable charts, solving problems such as cumbersome manual chart creation and difficulty in choosing charts.

#### Monitoring

[Alert Policies](../monitoring/alert-setting.md#member): Member-configured notification rules support appending names for purpose descriptions.

### Deployment Edition Update {#deployment0108}

1. Admin Backend > Workspace Menu Optimization:
    - Added main storage engine and business as two filtering options for workspace lists, supporting convenient workspace filtering;
    - Optimized workspace list page return logic. When modifying/deleting a workspace or changing the data reporting limit for a workspace, it remains on the current page to optimize query experience.
2. Deployment Edition Added Parameter: `alertPolicyFixedNotifyTypes`, supports configuring whether the "email" notification method is displayed in alert policies [Configuration Reference](/deployment/application-configuration-guide/#studio-backend).

### New Integrations {#inte0108}

1. Added [AWS Gateway Classic ELB](../integrations/aws_elb.md);
2. Added [Volcengine TOS Object Storage](../integrations/volcengine_tos.md);
3. Modified AWS Classic Collector Name;
4. Added [MinIO V3](../integrations/minio_v3.md) Integration;
5. Updated Elasticsearch, Solr, Nacos, InfluxDB V2, MongoDB integrations (views, documentation, monitors);
6. Updated Kubernetes monitoring views.

### Bug Fixes {#bug0108}

1. Resolved unauthorized cross-space event data issues;
2. Resolved inability to query data when jumping to the trace explorer with `trace_id`;
3. Resolved inability to fill numerical values in view expression queries;
4. Resolved absence of operation audit records when changing alert policies in external event detection monitors;
5. Resolved inability to adjust column widths in event display lists.