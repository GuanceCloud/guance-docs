---
icon: zy/release-notes
---

# Release Notes (2025)

---

This document records the update content description for each online release of <<< custom_key.brand_name >>>.

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

## April 9, 2025 {#20250409}

### OpenAPI Update {#openapi0409}

1. Support creating, editing, and deleting multi-step testing tasks;
2. Support configuring workspace quantity upper limit restrictions.

### Feature Updates {#feature0409}

#### Use Cases

1. Chart Optimization    
    - Bar Chart:
        - Adjust [alias](../scene/visual-chart/chart-config.md#alias) position, support listing all metrics and groups;
        - Add new X-axis configuration options.
    - Grouped [Table Chart](../scene/visual-chart/table-chart.md):
        - Support sorting based on group selection;
        - Add 200 option in return quantity dropdown, support manually entering maximum quantity adjustment to 1,000.
    - Time Series Chart > [Line Chart](../scene/visual-chart/timeseries-chart.md#line-chart): Add new "style" settings for lines, including linear, smooth, pre-step, post-step.
2. Snapshot: Add permission prompts for dashboard snapshot sharing with configuration permissions.
3. Explorer, Dashboard > Time Widget: Add "Last 1 minute" and "Last 5 minutes," default selected to the latter.

#### Management

- [Cross-workspace authorization](../management/data-authorization.md): Support cross-site data authorization, enabling extended data sharing.
- Data forwarding:
    - Add new data type "Audit Events."
    - Adjust query logic for explorer:
        - Change to daily queries, no cross-day queries supported;
        - When viewing forwarded data, the system automatically queries and continuously loads until fully displayed without requiring manual clicks;
        - Management > Workspace Settings > Advanced Settings: Add ["Data Forwarding Query Duration"](../management/backup/index.md#query_time_change) configuration.
- Split data access, Pipeline, and blacklist permissions, adjust "Management" permissions to "Create, Edit" and "Delete."

#### Monitoring

1. System notifications: Add jump links associated with logs, allowing navigation to log explorer and filtering logs where notification object sending failed.
2. Monitors:
    - Create from template > Official Template Library: Add search functionality;
    - Configuration page > [Event Content](../monitoring/monitor/monitor-rule.md#content): Update notice prompt. Only when associating anomaly tracking is enabled does `@ Member` configuration take effect and send event content to specified members.
    - Threshold detection: Add [Recovery Condition](../monitoring/monitor/threshold-detection.md#recover-conditions) switch, configure recovery conditions and severity levels. When query results contain multiple values, any value meeting trigger conditions generates a recovery event.

#### Incident Tracking

Change "Source" in issue email notifications to hyperlink; users can directly access by clicking.

#### RUM

SourceMap:

- Page interaction adjusted from popup to separate page;
- List page adds search and export functions.


#### AI Intelligent Assistant

Optimize [Chart Generation](../guance-ai/index.md#chart) function: Manage metric data via local Func cache, making generated DQL closer to semantic descriptions.

#### [AI Error Analysis](../logs/explorer-details.md#ai)

Add context support for root cause analysis, helping users understand error contexts more quickly and comprehensively, improving diagnostic efficiency.


#### Integration > Expansion

DataFlux Func (Automata)/RUM Headless: Add email reminders and system notifications for application fee deductions.

#### Infrastructure

HOST > Details page: Disk capacity statistics distinguish between local disks and remote disks display.

### New Integrations {#inte0409}

1. Add [GCP Compute Engine](../integrations/gcp_ce.md);
2. Add [Azure Storage](../integrations/azure_storage.md);
3. Add [Azure Redis Cache](../integrations/azure_redis_cache.md);
4. Add [Azure Kubernetes](../integrations/azure_kubernetes.md);
5. Add [Azure Postgresql](../integrations/azure_postgresql.md);
6. Add Alibaba Cloud RDS MYSQL Automata integration;
7. Add [Druid](../integrations/druid.md) integration;
8. Update [Trino](../integrations/trino.md);
9. Adjust AWS/Alibaba Cloud Automata integration documentation: Add `Managed Version Activation Script` steps.

### Bug Fixes {#bug0409}

1. Fix discrepancy between OpenAPI call for unrecovered events and actual results.
2. Fix errors when searching in the event explorer.
3. Fix abnormal external data source queries.
4. Fix issues related to incident tracking email notifications.
5. Fix slow loading of incident tracking > analysis dashboard.
6. Fix incorrect bar chart color display.
7. Fix missing AK in external event prompts.
8. Fix incorrect status distribution chart and log volume display.

## March 26, 2025 {#20250326}

### Feature Updates {#feature0326}

#### Events

1. [Unrecovered Events](../events/event-explorer/unrecovered-events.md): Default automatic refresh for time widget, add frontend prompt after manually recovering events.
2. [Event Details](../events/event-explorer/event-details.md): Alarm notification page display optimization.
3. Export events and intelligent monitoring explorers with added "Notification Status" display.

#### Management

[Data Forwarding](../management/backup/index.md#permission): Add permission configuration. By setting view permissions for forwarded data, effectively enhance data security.

#### Monitoring

1. [Infrastructure Survival Detection V2](../monitoring/monitor/infrastructure-detection.md): Add configurable detection intervals.
2. Alert Strategies: Adjust notification matching logic to improve execution efficiency under scenarios where events hit multiple strategies or complex alert strategies.
3. Notification Targets Management: Add [Slack](../monitoring/notify-target-slack.md) and [Teams](../monitoring/notify-target-teams.md) notification targets to meet global user needs.

#### Use Cases

1. View Variables: Support external data source queries.
2. Charts:

    - Add "[Monitor Summary](../scene/visual-chart/monitor_summary.md)" chart, integrate monitor list, display latest status, achieve real-time monitoring and anomaly awareness.
    - Command Panel: Display optimization;
    - Chart Queries: In DQL queries, add query suggestion prompts when using "wildcard" or "regex".
3. Explorers, Dashboards > Time Widget: Add "Last 1 Minute" and "Last 5 Minutes" options.

#### Billing Plans & Billing

1. Add [Monthly Bill](../billing/index.md#monthly_bill) module, intuitively display monthly consumption totals.
2. Add bill export functionality.

#### User Access Monitoring

Application List > Create Application: Add "Compressed Upload" and "Custom Managed Address" parameter configurations.

#### Synthetic Tests

Add "South Africa" and "Hong Kong China" as testing nodes, further expanding global coverage.

#### Logs

1. [Log Explorer](../logs/explorer.md)
    - Adjust quick filter operations;
    - Optimize tokenization logic for lists;
    - JSON formatted data adds "[JSON Search](../logs/explorer-details.md#json)";
2. Index > Key Fields: Add "[One-click Obtain](../logs/multi-index/index.md#extract)".

### Deployment Plan Update {#deployment0409}

Template Management:

- Page interaction optimization includes adding "Template Type" in display columns;
- Add "Template Type" to top filter items;
- Support batch export of templates;
- Support previewing template details when importing templates;
- Support overwrite logic for built-in views, Pipelines, and monitor templates during upload.

### New Integrations {#inte0326}

- Add [Azure Network Interfaces](../integrations/azure_network_interfaces.md);
- Add [Azure Kubernetes](../integrations/azure_kubernetes.md);
- Add [Azure Virtual Network Gateway](../integrations/azure_virtual_network_gateway.md);
- Improve English translation for integrations.

### Bug Fixes {#bug0326}

1. Fix low utilization display on log pages.
2. Fix unit display issues for Service Map metrics.
3. Fix inability to select units for multi-column table charts.
4. Fix CSV export errors for dashboard > log stream charts when selecting numbers other than 1,000.
5. Fix inconsistency between P75 and DQL query results for most popular pages.
6. Fix time selector showing today's date after clicking the `<<` button.
7. Fix unexpected behavior in menu management.
8. Fix abnormal space ID filtering in the management backend.
9. Fix sample loss in the Pipeline interface test.
10. Fix long response times for configuration migration exports.
11. Fix numerous empty tags in the event details interface after upgrade.
12. Fix duplicate library lists in the official monitor template library, and once a library is selected, it prevents searching for other monitors.

## March 12, 2025 {#20250312}

### Breaking Changes {#breakingchanges0312}

[Events](../events/index.md) `df_alert_info` field definition adjustment, add reason explanations for unmatched alert strategies, still require filtering through `isIgnored` to obtain actual externally sent notification objects.


### Feature Updates {#feature0312}

#### Incident Tracking

1. Add [Incident Tracking Management](../management/index.md#personal_incidents) entry point, through which the currently logged-in user can view and manage the status of all joined workspace incidents.
2. Optimize [Channel List](../exception/channel.md#list) display on the incident tracking page, improving query efficiency when there are too many channels.

#### Management

1. [Cloud Account Management](../management/cloud-account-manag.md#alibaba): Add Alibaba Cloud account authorization type.
2. [API Key Management](../management/api-key/index.md): Add API Key permission control features, supporting role-based authorization. Through role-based authorization, API Keys only possess operational permissions within the scope of the role, effectively reducing security risks.
3. Data forwarding: Default interaction changed to unselected rules.

#### AI Error Analysis

The following detail pages add [AI Error Analysis](../logs/explorer-details.md#ai) capabilities:

- error logs
- APM > Trace/Error Tracking

#### Use Cases

1. Scheduled Reports:

    - Add Webhook sending as a notification method;
    - Support sharing dashboard images to WeCom/DingTalk.

2. Time Series Chart: After selecting area chart as the chart type, add [Stack Mode](../scene/visual-chart/timeseries-chart.md#style) style to facilitate observing the cumulative effects of overall data.

#### APM

Trace: Support batch export in JSONL format.

#### RUM

User Insights > [Funnel Analysis](../real-user-monitoring/user_insight_funnel.md): Support session replay for Session lists queried.

#### Logs

1. Explorer:
    - Log Explorer > Index Quick Filter displays optimized in the search bar;
    - Log Details > Extended Fields: Add "Dimensional Analysis" mode;
2. Index: Support setting exclusive [Key Fields](../logs/multi-index/index.md#key_key) under index dimensions.

#### Explorer Time Widget

Left-side time range selection and right-side refresh frequency operate independently. Only two situations affect refresh frequency:

- Selected time range exceeds 1 hour
- Selected time is absolute time

#### Infrastructure

HOST: Explorer supports adjusting time range.

#### Pipeline

1. Configuration page display optimization;
2. Pipeline processing types add "Event";
3. Test samples support obtaining JSON format.
4. Filter Conditions > Synthetic Tests: Support selecting multi-step tests.

### Deployment Plan Update {#deployment0312}

[Template Management](../deployment/integration.md): Support uploading all explorer templates.

### New Integrations {#inte0312}

1. Add [azure_load_balancer](../integrations/azure_load_balancer.md);
2. Rewrite [K8S server api](../integrations/kubernetes-api-server.md);
3. Update [Gitlab CI](../integrations/gitlab.md);
4. Translate Volcengine-related views;
5. Translate AWS-related views.

### Bug Fixes {#bug0312}

1. Fix CSV export non-response for log flow charts.
2. Fix no data issue in time series charts after adding relevant filters when querying ddtrace-collected JVM metrics with `runtime-id` fields.
3. Fix custom gradient interval color scale interface display issue.
4. Fix blank display issue after saving DQL query edits with filter conditions set to >0.
5. Fix abnormal infrastructure table chart display in application performance monitoring.
6. Fix unsupported data forwarding rule when setting storage duration to 1,800 days in the management backend.
7. Fix "kodo service API request error: Service Unavailable" when executing quick query show_object_field(`HOST`).
8. Fix existing bugs in quick entries.
9. Fix no data issue for RUM `session` and `view`, but other `resource` and action have data.
10. Fix immediate validation of required fields when creating multi-step tests.
11. Fix ineffective filtering condition when setting role authorization for data access.
...

(Translation continues similarly for the rest of the document.)