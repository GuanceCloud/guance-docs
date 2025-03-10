---
icon: zy/release-notes
---

# Release Notes (2025)

---

This document records the update content of <<< custom_key.brand_name >>> for each release.

<div class="grid cards" markdown>

- :fontawesome-regular-clipboard:{ .lg .middle }

    ***

    <table>
      <tr>
        <th><a href="https://docs.guance.com/datakit/changelog/" target="_blank">DataKit</a></th>
      </tr>
    </table>

    ***

    <table>
      <tr>
        <th colspan="5">SDK</th>
      </tr>
      <tr>
        <td><a href="https://docs.guance.com/real-user-monitoring/web/sdk-changelog/" target="_blank">Web</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/miniapp/sdk-changelog/" target="_blank">Mini Program</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/android/sdk-changelog/" target="_blank">Android</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/ios/sdk-changelog/" target="_blank">iOS</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/react-native/sdk-changelog/" target="_blank">React Native</a></td>
      </tr>
    </table>

</div>

## February 27, 2025 {#20250227}

### OpenAPI Update {#openapi0227}

Metrics: Added [Measurement and Tag Information Retrieval](../open-api/metric/metric-info-get.md).

### Feature Updates {#feature0227}

#### Synthetic Tests

1. HTTP Test: Supports [Script Mode](../usability-monitoring/request-task/http.md#script). By writing Pipeline scripts, you can flexibly customize the judgment conditions and data processing logic of the test tasks.
2. Added [Multi-step Test](../usability-monitoring/request-task/multistep_test.md): Allows using multiple API connection response data to create tests and link multiple task requests through local variable passing.

#### Use Cases

1. Dashboard > Visibility Scope: Added "Custom" configuration, allowing configuration of "Operation" and "View" permissions for this dashboard. A new option "All Members" has also been added under this configuration.
2. Charts:
    - Added AI-generated chart titles and descriptions;
    - Log Stream Chart added "Rule Mapping" feature;
    - Optimized column display in Table Chart;
    - Grouped Table Chart: Expression results support sorting;
    - Time Series Chart, Pie Chart, and other tables support exporting data as CSV files.

#### Metrics

1. [Metric Analysis > Table Chart](../metrics/explorer.md#table): When query results exceed 2,000 entries, three modes add a "Query Result Count" display.
2. [Metric Management](../metrics/dictionary.md): Supports one-click navigation to metric analysis.
3. [Generate Metrics](../metrics/generate-metrics.md#manage): Supports import creation method and batch export.

#### Infrastructure

Container/Pod Explorer: Object data added four new fields `cpu_usage_by_limit`, `cpu_usage_by_request`, `mem_used_percent_base_limit`, `mem_used_percent_base_request`.

#### APM

1. Profiling > Flame Graph Interaction Optimization: Selecting a single search method name can directly focus and locate.
2. ServiceMap Interaction Optimization: In upstream/downstream pages, supports searching nodes on the current canvas.

### New Integrations {#inte0227}

- Added [AWS Cloud Billing](../integrations/aws_billing.md);
- Added [Kube Scheduler](../integrations/kube_scheduler.md);
- Added [MQTT](../integrations/mqtt.md);
- Rewrote [APISIX](../integrations/apisix.md);
- Updated [TiDB](../integrations/tidb.md) English documentation and views;
- Updated [Zookeeper](../integrations/zookeeper.md) views, added integration icons;
- Fixed English translation issues in some component mainfest.yaml files.

### Bug Fixes {#bug0227}

1. Fixed an issue where clicking on the APM > Trace Details tab page displayed incorrectly;
2. Fixed an issue with @mentioning members incorrectly in Incident replies;
3. Fixed incorrect temperature unit display in charts.


## February 19, 2025

### Breaking Changes {#breakingchanges0219}

The `df_meta` within [Events](../events/index.md) will no longer retain `alert_info` related information. Users who previously relied on this information to obtain notification targets should switch to using the newly added `df_alert_info` (event alert notifications), `df_is_silent` (whether muted), and `df_sent_target_types` (event notification object types) fields to achieve the corresponding functionality.

Possible affected scenarios:

1. Custom use cases for interfacing events with external systems via OpenAPI
2. Custom use cases for forwarding events to external systems via Webhook notifications

### Feature Updates {#feature0116}

#### PromQL Query

Added query type: Instant Query, which queries a single time point.

#### Monitoring

Monitor Configuration Page:

1. Added `not between` option in logical match conditions for trigger criteria;
2. Supports directly modifying monitor status ("Enabled" or "Disabled").

#### APM

Trace: Added [Service Context](../application-performance-monitoring/explorer/explorer-analysis.md#context) tab page in detail view.

#### Events

Event Detail Page: Added support for binding [Built-in Views](../events/event-explorer/event-details.md#inner_view);

#### Incident

1. Issue added [`working`, `closed` states](../exception/issue.md#concepts);  
2. For timeouts in `open` state and unassigned responsible parties and handling timeouts, [Issue Escalation](../exception/config-manag/strategy.md#upgrade) added repeat notification configurations;  
3. Adjusted UI display of system comments and channel notifications for Issues;
4. Analysis Dashboard: Added Time Widget.

#### Use Cases

1. [Chart Links](../scene/visual-chart/chart-link.md): Added "View Host Monitoring View", default off.
2. Explorer: Supports deleting fixed `name` column, users can customize list display.
3. Cloud Billing Analysis View: Supports viewing detailed billing information.

#### Management

[Role Management](../management/role-list.md): Session Replay viewing, audit events added custom permission addition capabilities.

#### Metrics

Generate Metrics: Metric names no longer support hyphens `-`.

#### Integrations

Integration Cards added description information.

### Deployment Plan Updates {#deployment0219}

1. Template Management: Supports uploading infrastructure explorer templates;
2. Index Configuration: Deprecated "Backup Logs" item; configure corresponding storage policies at "Edit Workspace > Data Storage Policy > Data Forwarding - Default Storage".

### New Integrations {#inte0219}

1. Added [Milvus](../integrations/milvus.md);
2. Added [Volcengine Public IP](../integrations/volcengine_eip.md);
3. Added [opentelemetry-python](../integrations/opentelemetry-python.md);
4. Added [OpenLIT Integration](../integrations/openlit.md);
5. Updated k8s/es/mongodb/rabbitmq/oracle/coredns/sqlserver monitors & views in English and Chinese.

### Bug Fixes {#bug0219}

1. Fixed special characters causing abnormal results in AI aggregated notification messages;
2. Fixed compatibility issues for Servicemap deployment version;
3. Fixed issues with hidden view variables not configurable in composite charts;
4. Fixed display issues in the "Unresolved Issues List" in the Incident Analysis Dashboard;
5. Fixed inconsistencies between P75 results in RUM PV analysis dashboard and DQL query results;
6. Fixed issues with the search box in the RUM Explorer;
7. Fixed partial effectiveness of field mapping using Resource Catalog in dashboards;
8. Fixed UI display issues in Monitor > Event Content;
9. Fixed unsatisfactory quick filter results for unresolved events in the Event Viewer.

## January 16, 2025

### Feature Updates {#feature0116}

#### RUM

1. Added [Funnel Analysis](../real-user-monitoring/user_insight_funnel.md) function: Users can define conversion steps to create funnels, view conversion data, and perform in-depth analysis;
2. Integrated User Analysis module: Added User Analysis module, integrating heatmaps and funnel analysis for comprehensive user behavior analysis tools;
3. Added mobile SourceMap restoration: Android and iOS applications support uploading SourceMap files and viewing restored data in error viewers.

#### APM

When adding services in APM, added [Automatic Host Injection](../application-performance-monitoring/explorer/auto_wire/autowire_on_host.md) installation guide, simplifying the installation process.

#### Integrations

1. DataKit (data collection tool): DataKit installation page added Docker installation guidance, providing more diverse installation options;
2. External Data Source Optimization: Added query specification prompts when querying SLS data sources, helping users query data more accurately.

#### Use Cases

[Composite Charts](../scene/visual-chart/index.md#conbine) Optimization: Composite charts now support view variable configuration, allowing selection of view variables from the current dashboard to apply to the composite chart, enhancing flexible data filtering and analysis.

#### Monitoring

Anomaly Detection Monitors: Added support for week-over-week and month-over-month comparisons in query periods.

#### AI Assistant

Added DataFlux Func knowledge base.

#### Pipeline

Optimized Auto-generated Pipeline: Supports interactive retrieval of Pipeline parsing using structured and natural language simultaneously.

### Bug Fixes {#bug0116}

1. Fixed display issues in log stacking mode;
2. Fixed input box misalignment in log monitoring monitors;
3. Fixed metric calculation errors;
4. Fixed unsupported `having` statement in Volcengine;
5. Fixed errors selecting "Request Error Rate" and "Average Requests per Second" metrics in APM metrics monitoring;
6. Fixed ineffective `not in` statement in Volcengine base;
7. Fixed large event list data affecting page load speed;
8. Fixed unexpected behavior of one-click recovery in Hangzhou site events.

## January 8, 2025

### OpenAPI Updates {#openapi0108}

1. Field Management: Supports retrieving field management lists, and supports [adding](../open-api/field-cfg/add.md)/[modifying](../open-api/field-cfg/modify.md)/[deleting](../open-api/field-cfg/delete.md) field management.
2. Synthetic Tests: Supports [modifying](../open-api/dialing-task/modify.md) dial testing tasks.
3. Incident > Schedule: Supports retrieving schedule lists, and supports [creating](../open-api/notification-schedule/add.md)/[modifying](../open-api/notification-schedule/modify.md)/[deleting](../open-api/notification-schedule/delete.md) schedules.
4. Incident > Configuration Management: Supports retrieving notification policy lists, and supports [adding](../open-api/issue-notification-policy/add.md)/[modifying](../open-api/issue-notification-policy/modify.md)/[deleting](../open-api/issue-notification-policy/delete.md) notification policies; supports retrieving Issue discovery lists, and supports [adding](../open-api/issue-auto-discovery/add.md)/[modifying](../open-api/issue-auto-discovery/modify.md)/[enabling/disabling](../open-api/issue-auto-discovery/set-disable.md)/[deleting](../open-api/issue-auto-discovery/delete.md) Issue discovery configurations.

### Feature Updates {#feature0108}

#### Logs

1. Log Index Optimization:
    - When accessing built-in log views or the log context tab page, it will default to selecting the index containing the current log and the `default` index respectively. Both tabs support multi-selection of indices. Additionally, after enabling cross-workspace queries and selecting authorized workspaces in the menu, it supports directly querying index data from the corresponding workspace. This helps users view associated log data on a single page, optimizing log query interaction.
    - When listing log indices, except for `default` being top-priority, the rest are listed alphabetically from A-Z.
2. Log Viewer added Stacking [View Mode](../logs/manag-explorer.md#mode): Fields are consolidated into a single column and presented as rows within cells. Log information is displayed more compactly and clearly, facilitating quick browsing and analysis.
3. Log Pipeline Optimization: Test samples for log pipelines now retrieve all log fields and must be entered in line protocol format. Manually entered logs must also follow this format.

#### Use Cases

1. [Table Chart](../scene/visual-chart/table-chart.md) Optimization:
    - Multi-metric query sorting support: When using a single DQL for multi-metric queries, table charts now support sorting.
    - Table Pagination Selection: Added pagination selection for users to choose appropriate page sizes based on data volume and viewing needs.
2. Composite Charts: Supports adjusting the order of charts.
3. Chart Optimization: Adjusted the function order in DQL query components, emphasizing Rollup function usage scenarios to help users better utilize Rollup functions for data aggregation and analysis.

#### Management

1. Events support configuring [Data Forwarding](../management/backup/index.md): Supports configuring data forwarding rules for event types, saving filtered event data to <<< custom_key.brand_name >>> object storage and forwarding to external storage, providing flexible event data management.
2. Workspace added DataKit [Environment Variables](../management/env_variable.md): Workspaces support managing DataKit environment variables, allowing easy configuration and updates for remote synchronization of DataKit collection settings.
3. Query [Audit Events](../management/audit-event.md) Optimization: Added multiple fields to record query information, including query time ranges in event content for better tracking and analysis of query behavior.

#### Pipeline

Optimized Auto-generated Pipeline: Changed the way hints appear, improving product experience.

#### AI Assistant

AI Assistant added [Chart Generation](../guance-ai/index.md#chart): Automatically analyzes user input text data using large models to generate appropriate charts, solving issues with manual chart creation and difficulty in chart selection.

#### Monitoring

[Alert Policies](../monitoring/alert-setting.md#member): Supports appending names for purpose descriptions when configuring notification rules by member.

### Deployment Plan Updates {#deployment0108}

1. Management Backend > Workspace Menu Optimization:
    - Workspace list added primary storage engine and business filtering options for easier workspace selection;
    - Optimized workspace list pagination return logic, staying on the current page when modifying/deleting workspaces or changing data reporting limits to enhance query experience.
2. Deployment Plan added parameter: `alertPolicyFixedNotifyTypes`, supporting configuration of whether to display "Email" notification methods in alert policies [Configuration Reference](/deployment/application-configuration-guide/#studio-backend).

### New Integrations {#inte0108}

1. Added [AWS Gateway Classic ELB](../integrations/aws_elb.md);
2. Added [Volcengine TOS Object Storage](../integrations/volcengine_tos.md);
3. Modified AWS Classic collector name;
4. Added [MinIO V3](../integrations/minio_v3.md) integration;
5. Updated elasticsearch, solr, nacos, influxdb_v2, mongodb integrations (views, documents, monitors);
6. Updated kubernetes monitoring views.

### Bug Fixes {#bug0108}

1. Resolved unauthorized cross-space event data access issues;
2. Resolved trace_id carrying issues when jumping from log association to trace viewer unable to query data;
3. Resolved value filling issues in view expression queries;
4. Resolved lack of operation audit records when changing alert policies in external event detection monitors;
5. Resolved non-adjustable column widths in event display lists.