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
        <td><a href="<<< homepage >>>/real-user-monitoring/miniapp/sdk-changelog/" target="_blank">Mini Program</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/android/sdk-changelog/" target="_blank">Android</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/ios/sdk-changelog/" target="_blank">iOS</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/react-native/sdk-changelog/" target="_blank">React Native</a></td>
      </tr>
    </table>

</div>

## March 12, 2025 {#20250312}

### Breaking Changes {#breakingchanges0312}

The definition of the `df_alert_info` field in [Events](../events/index.md) has been adjusted. A new reason for unmatched alert strategies has been added. It is still necessary to filter and determine the actual notification targets for external sending through `isIgnored`.

### Feature Updates {#feature0312}

#### Incident Management

1. Added an [Incident Management](../management/index.md#personal_incidents) entry point. Through this entry, the currently logged-in user can view and manage the status of all joined workspace incidents.
2. Optimized the display of the [Channel List](../exception/channel.md#list) on the Incident page, improving query efficiency when there are too many channels.

#### Management

1. [Cloud Account Management](../management/cloud-account-manag.md#alibaba): Added a new Alibaba Cloud account authorization type.
2. [API Key Management](../management/api-key/index.md): Added permission control functionality for API Keys, supporting role-based authorization. Through role-based authorization, API Keys have operational permissions only within the scope of the role, effectively reducing security risks.
3. Data Forwarding: The default interaction has been changed to unselected rules.

#### AI Error Analysis

The following detail pages have added [AI Error Analysis](../logs/explorer-details.md#ai) capabilities:

- error logs
- APM > Trace/Error Tracking

#### Use Cases

1. Scheduled Reports:
   - Added Webhook as a notification method;
   - Supported sharing dashboard images to WeCom/DingTalk.

2. Time Series Graphs: After selecting Area Chart as the chart type, a new [Stacked Mode](../scene/visual-chart/timeseries-chart.md#style) style has been added, facilitating observation of cumulative overall data effects.

#### APM

Traces: Support batch export in JSONL format.

#### RUM

User Analysis > [Funnel Analysis](../real-user-monitoring/user_insight_funnel.md): Session lists queried support the session replay function.

#### Logs

1. Explorer:
   - Log Explorer > Index Quick Filter: Improved display effect in the search bar;
   - Log Details > Extended Fields: Added "Dimensional Analysis" mode.
2. Index: Supports setting exclusive [Key Fields](../logs/multi-index/index.md#key_key) under index dimensions.

#### Explorer Time Widget

Left-side time range selection and right-side refresh frequency are independent. Only two scenarios affect the refresh frequency:

- Selected time range exceeds 1h
- Selected time is absolute time

#### Infrastructure

HOST: Explorer supports adjusting the time range.

#### Pipeline

1. Configuration page display optimization;
2. Added "Event" as a Pipeline processing type;
3. Test samples support obtaining JSON format.
4. Filtering Conditions > Synthetic Tests: Support selecting multi-step tests.

### Deployment Plan Update {#deployment0312}

[Template Management](../deployment/integration.md): Supports uploading all explorer templates.

### New Integrations {#inte0312}

- Added [azure_load_balancer](../integrations/azure_load_balancer.md);
- Rewrote [K8S server api](../integrations/kubernetes-api-server.md);
- Updated [Gitlab CI](../integrations/gitlab.md);
- Translated Volcengine-related views;
- Translated AWS-related views.

### Bug Fixes {#bug0312}

1. Fixed the issue where exporting log stream diagrams to CSV had no response.
2. Fixed the issue where after adding relevant filters to time series graphs with `ddtrace`-collected JVM metrics (`runtime-id` field), no data was displayed.
3. Fixed the issue with the custom gradient interval color scale interface.
4. Fixed the issue where after editing DQL queries and selecting >0 for filtering conditions, the display would be empty upon saving and re-editing.
5. Fixed the issue where infrastructure table graphs in Application Performance Monitoring displayed abnormally.
6. Fixed the issue where after setting data forwarding storage duration to 1,800 days in the management backend, front-end forwarding rules were unsupported.
7. Fixed the issue where executing quick queries `show_object_field('HOST')` resulted in the error "kodo service API request error: Service Unavailable".
8. Fixed existing bugs in quick entries.
9. Fixed the issue where `session` and `view` had no data while other `resources` and actions had data in RUM.
10. Fixed the issue where creating multi-step test requests immediately validated required fields.
11. Fixed the issue where filtering conditions did not take effect when setting role authorizations for data access.


## February 27, 2025 {#20250227}

### OpenAPI Update {#openapi0227}

Metrics: Added [Metric Set and Tag Information Retrieval](../open-api/metric/metric-info-get.md).

### Feature Updates {#feature0227}

#### Synthetic Tests

1. HTTP Testing: Supports [Script Mode](../usability-monitoring/request-task/http.md#script). By writing Pipeline scripts, you can flexibly customize judgment conditions and data processing logic for testing tasks.
2. Added [Multi-step Testing](../usability-monitoring/request-task/multistep_test.md): Allows creating tests using response data from multiple APIs and linking multiple task requests via local variable passing.

#### Use Cases

1. Dashboard > Visibility Scope: Added "Custom" configuration, allowing configuration of "Operation" and "View" permissions for this dashboard. This configuration also includes a new "All Members" option.
2. Charts:
   - Added AI-generated chart title and description capability;
   - Log Stream Diagrams added "Rule Mapping" functionality;
   - Table chart column display optimized;
   - Grouped Table charts: Expression results support sorting;
   - Multiple charts including Time Series and Pie Charts support exporting data as CSV files.

#### Metrics

1. [Metric Analysis > Table Chart](../metrics/explorer.md#table): When query results exceed 2,000 items, three modes add "Query Result Count" display.
2. [Metric Management](../metrics/dictionary.md): Supports one-click navigation to Metric Analysis.
3. [Generated Metrics](../metrics/generate-metrics.md#manage): Supports import creation method and batch export.

#### Infrastructure

Container/Pod Explorer: Object data added four new fields: `cpu_usage_by_limit`, `cpu_usage_by_request`, `mem_used_percent_base_limit`, `mem_used_percent_base_request`.

#### APM

1. Profiling > Flamegraph Interaction Optimization: Selecting a single search method name directly focuses and locates.
2. ServiceMap Interaction Optimization: Supports searching nodes in the current canvas on upstream/downstream pages.

### New Integrations {#inte0227}

- Added [AWS Cloud Billing](../integrations/aws_billing.md);
- Added [Kube Scheduler](../integrations/kube_scheduler.md);
- Added [MQTT](../integrations/mqtt.md);
- Rewrote [APISIX](../integrations/apisix.md);
- Updated [tidb](../integrations/tidb.md) English documentation and views;
- Updated [Zookeeper](../integrations/zookeeper.md) views, added integration icons;
- Fixed English translations for some components' mainfest.yaml.

### Bug Fixes {#bug0227}

1. Fixed the issue where clicking on Application Performance Monitoring > Trace Detail tab page showed errors;
2. Fixed the issue where `@members` in Exception Tracking > Issue replies were incorrect;
3. Fixed the issue where temperature units in charts were incorrect.


## February 19, 2025

### Breaking Changes {#breakingchanges0219}

In [Events](../events/index.md), `df_meta` will no longer retain `alert_info` related information records. Users who previously relied on this information to obtain notification targets should switch to using the newly added `df_alert_info` (event alarm notifications), `df_is_silent` (whether muted), and `df_sent_target_types` (event notification object types) three fields to complete corresponding functions.

Possible affected use cases:

1. Custom use cases for obtaining events via OpenAPI and integrating with external systems.
2. Custom use cases for forwarding notification targets via Webhooks to external systems.

### Feature Updates {#feature0116}


#### PromQL Query

Added Instant Query type: Queries for a single time point.


#### Monitoring

Monitor Configuration Page:

1. Added `not between` option in trigger condition logical matching;
2. Supports directly modifying monitor status ("Enabled" or "Disabled").


#### APM

Trace: Added [Service Context](../application-performance-monitoring/explorer/explorer-analysis.md#context) tab page in the details page.


#### Events

Event Details Page: Added support for binding [Built-in Views](../events/event-explorer/event-details.md#inner_view);


#### Incident Management

1. Issues Added [`working`, `closed` Statuses](../exception/issue.md#concepts);
2. For timeouts staying in `open` status, and issues without assigned responsible parties and processing timeouts, [Issue Upgrade](../exception/config-manag/strategy.md#upgrade) added repeated notification configurations;
3. Adjusted UI display of system comments and channel notifications for Issues;
4. Analytical Dashboards: Added time widgets.


#### Use Cases

1. [Chart Links](../scene/visual-chart/chart-link.md): Added "View Host Monitoring View", default disabled.
2. Explorer: Supports deleting fixed `name` columns, users can customize list displays.
3. Cloud Billing Analysis View: Supports viewing billing details.

#### Management

[Role Management](../management/role-list.md): Session Replay viewing, audit events added custom addition of view permission capabilities.

#### Metrics

Generated Metrics: Metric name input no longer supports `-` hyphen usage.

#### Integrations

Integration Cards Added Description Information.

### Deployment Plan Update {#deployment0219}

1. Template Management: Supports uploading infrastructure explorer templates;
2. Index Configuration: Deprecated "Backup Logs"; Configurable storage strategy available at "Edit Workspace > Data Storage Policy > Data Forwarding - Default Storage".

### New Integrations {#inte0219}

1. Added [Milvus](../integrations/milvus.md);
2. Added [Volcengine Public IP](../integrations/volcengine_eip.md);
3. Added [opentelemetry-python](../integrations/opentelemetry-python.md);
4. Added [openLIT Integration](../integrations/openlit.md);
5. Updated k8s/es/mongodb/rabbitmq/oracle/coredns/sqlserver English & Chinese monitors & views.

### Bug Fixes {#bug0219}

1. Fixed special character issues causing abnormal results in AI aggregation notification messages;
2. Fixed Servicemap deployment version compatibility issues;
3. Fixed hidden view variables unable to configure combined charts;
4. Fixed disorderly display of "Unresolved Issues List" on the analysis dashboard in Exception Tracking;
5. Fixed inconsistency between P75 results on the User Behavior Monitoring analysis dashboard and DQL query results;
6. Fixed abnormal behavior of the search box in User Behavior Monitoring > Explorer;
7. Fixed partial effectiveness of the same field on the dashboard when using resource directories for field mapping in Objects Mapping;
8. Fixed UI display issues for monitor > event content;
9. Fixed unsatisfactory results for unresolved events in the Event Explorer quick filter.

## January 16, 2025

### Feature Updates {#feature0116}

#### Real User Monitoring

1. Added [Funnel Analysis](../real-user-monitoring/user_insight_funnel.md) feature: Users can define conversion steps to create funnels, view data conversions, and perform deeper analyses;
2. User Insight Module Integration: Added a User Insight module, integrating heatmaps and funnel analysis into this module, providing more comprehensive tools for user behavior analysis;
3. Added mobile SourceMap restoration: Android and iOS applications support uploading SourceMap files on pages and viewing restored data in the error explorer.

#### APM

When adding services in APM, added [Automatic HOST Injection](../application-performance-monitoring/explorer/auto_wire/autowire_on_host.md) installation guidance, simplifying the installation process.

#### Integrations

1. DataKit (Data Collection Tool): The DataKit installation page added Docker installation guidance, providing more diversified installation options;
2. External Data Source Optimization: Added query standard prompts during SLS data source queries, helping users conduct more accurate data queries.

#### Use Cases

[Combined Charts](../scene/visual-chart/index.md#conbine) Optimization: Combined charts added view variable configuration, supporting the selection of view variables from the current dashboard to apply to the combined chart, enabling more flexible data filtering and analysis.

#### Monitoring

Anomaly Detection Monitor: Added week-over-week and month-over-month support for query cycles.

#### AI Smart Assistant

Added DataFlux Func knowledge base.

#### Pipeline

Optimized auto-generated Pipelines: Supports interactive acquisition of Pipeline parsing using structured plus natural language simultaneously.

### Bug Fixes {#bug0116}

1. Fixed display issues in log stacking mode;
2. Fixed misalignment of the input box in log detection monitors;
3. Fixed metric calculation errors;
4. Fixed the lack of support for `having` statements in Volcengine;
5. Fixed errors when selecting "Request Error Rate" and "Average Requests Per Second" metrics in application performance metric detection;
6. Fixed the non-effectiveness of `not in` statements in the Volcengine base;
7. Fixed the issue where large amounts of data returned by the event list affected page loading speed;
8. Fixed the unexpected behavior of one-click recovery of Hangzhou site events.

## January 8, 2025

### OpenAPI Updates {#openapi0108}

1. Field Management: Supports retrieving field management lists, supports [Adding](../open-api/field-cfg/add.md)/[Modifying](../open-api/field-cfg/modify.md)/[Deleting](../open-api/field-cfg/delete.md) field management.
2. Usability Monitoring: Supports [Modifying](../open-api/dialing-task/modify.md) dialing tasks.
3. Incident Tracking > Schedule: Supports retrieving schedule lists, supports [Creating](../open-api/notification-schedule/add.md)/[Modifying](../open-api/notification-schedule/modify.md)/[Deleting](../open-api/notification-schedule/delete.md) schedules.
4. Incident Tracking > Configuration Management: Supports retrieving notification policy lists, supports [Creating](../open-api/issue-notification-policy/add.md)/[Modifying](../open-api/issue-notification-policy/modify.md)/[Deleting](../open-api/issue-notification-policy/delete.md) notification policies; Supports retrieving Issue discovery lists, supports [Creating](../open-api/issue-auto-discovery/add.md)/[Modifying](../open-api/issue-auto-discovery/modify.md)/[Enabling/Disabling](../open-api/issue-auto-discovery/set-disable.md)/[Deleting](../open-api/issue-auto-discovery/delete.md) Issue discovery configurations.

### Feature Updates {#feature0108}

#### Logs

1. Log Index Optimization:
   - When accessing built-in log views and the log context tab, the index of the current log and the `default` index will be selected by default respectively. Both tabs support multi-selection of indices. Additionally, when cross-workspace querying is enabled and authorized workspaces are selected in the menu, it is possible to directly query index data from the corresponding workspace here. Ultimately, this helps users fully view associated log data on one page, optimizing log query interactions.
   - When listing log indices, except for `default` being displayed at the top, the remaining log indices are listed in alphabetical order from A-Z.
2. Log Explorer Added Stacked [View Mode](../logs/manag-explorer.md#mode): In stacked mode, fields will be consolidated in the same column and presented in rows within cells. Log information is displayed more compactly and clearly, making it easier for users to quickly browse and analyze.
3. Log Pipeline Optimization: Test samples for log Pipelines now retrieve all log fields and require line protocol format input. Manually entered logs by users must also follow format requirements.

#### Use Cases

1. [Table Chart](../scene/visual-chart/table-chart.md) Optimization:
   - Multi-Metric Query Sorting Support: When using one DQL for multi-metric queries, the table chart now supports sorting.
   - Table Pagination Selection: Added table pagination selection functionality, allowing users to choose appropriate pagination sizes based on data volume and viewing needs.
2. Combined Charts: Supports adjusting chart order.
3. Chart Optimization: Adjusted the function order of the DQL query component, emphasizing the use scenarios of the Rollup function to help users better aggregate and analyze data using the Rollup function.

#### Management

1. Events Support Configuring [Data Forwarding](../management/backup/index.md): Supports configuring data forwarding rules for event types, saving filtered event data to <<< custom_key.brand_name >>> object storage and forwarding it to external storage, providing flexible event data management capabilities.

2. Workspace Added DataKit [Environment Variables](../management/env_variable.md): Workspaces support managing DataKit environment variables, allowing users to easily configure and update environment variables to achieve remote synchronized updates for DataKit collection configurations.

3. Query [Audit Events](../management/audit-event.md) Optimization: Added multiple fields to record query information, supplementing the query time range in the event content to facilitate tracking and analyzing query behaviors.

#### Pipeline

Auto-Generated Pipeline Optimization: Changed the way hints appear, enhancing product experience.

#### AI Smart Assistant

AI Smart Assistant Added [Generating Charts](../guance-ai/index.md#chart): Based on large models automatically analyzing user-entered text data, intelligently generating appropriate charts, solving problems such as cumbersome manual chart creation and difficulty in choosing charts.

#### Monitoring

[Alert Policies](../monitoring/alert-setting.md#member): Member-configured notification rules support appending names for purpose descriptions.

### Deployment Plan Update {#deployment0108}

1. Management Backend > Workspace Menu Optimization:
   - Added main storage engine and business two filtering options to the workspace list, supporting convenient workspace filtering;
   - Optimized the pagination return logic of the workspace list. When modifying/deleting a workspace or changing the data reporting limit of a workspace, stay on the current page to optimize the query experience.
2. Deployment Version Added Parameter: `alertPolicyFixedNotifyTypes`, supports configuring whether the "Email" notification method is displayed in the alert policy [Configuration Reference](/deployment/application-configuration-guide/#studio-backend).

### New Integrations {#inte0108}

1. Added [AWS Gateway Classic ELB](../integrations/aws_elb.md);
2. Added [Volcengine TOS Object Storage](../integrations/volcengine_tos.md);
3. Modified AWS Classic Collector Name;
4. Added [MinIO V3](../integrations/minio_v3.md) Integration;
5. Updated elasticsearch, solr, nacos, influxdb_v2, mongodb integrations (views, documentation, monitors);
6. Updated Kubernetes monitoring views.

### Bug Fixes {#bug0108}

1. Resolved the issue where event data cross-space authorization was ineffective;
2. Resolved the issue where carrying `trace_id` to the trace explorer from log correlation failed to query data;
3. Resolved the issue where expression queries could not fill numerical values;
4. Resolved the issue where changes to alert policies in external event detection monitors did not generate operation audit records;
5. Resolved the issue where column widths in the event display list could not be adjusted.