---
icon: zy/release-notes
---

# Release Notes (2025)

---

This document records the update content of each release of Guance.

<div class="grid cards" markdown>

- :fontawesome-regular-clipboard:{ .lg .middle }

    ***

    <table>
      <tr>
        <th><a href="https://docs.guance.com/datakit/changelog/" target="_blank">DK</a></th>
      </tr>
    </table>

    ***

    <table>
      <tr>
        <th colspan="5">SDK</th>
      </tr>
      <tr>
        <td><a href="https://docs.guance.com/real-user-monitoring/web/sdk-changelog/" target="_blank">Web</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/miniapp/sdk-changelog/" target="_blank">Miniapp</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/android/sdk-changelog/" target="_blank">Android</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/ios/sdk-changelog/" target="_blank">iOS</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/react-native/sdk-changelog/" target="_blank">React Native</a></td>
      </tr>
    </table>

</div>


## January 16, 2025

### Feature Updates {#feature0116}

#### RUM

1. Added [Funnel Analysis](../real-user-monitoring/user_insight_funnel.md) feature: Users can create funnels by defining conversion steps, view data conversion, and perform in-depth analysis;
2. User Analysis module integration: Added a new User Analysis module that integrates heatmaps and funnel analysis to provide more comprehensive user behavior analysis tools;
3. Added mobile SourceMap restoration: Android and iOS applications now support uploading SourceMap files on pages and viewing restored data in the error Explorer.

#### APM

When adding services in APM, a new installation guide for [automatic host injection](../application-performance-monitoring/explorer/auto_wire/autowire_on_host.md) has been added to simplify the installation process.

#### Integrations

1. DataKit (data collection tool): The DataKit installation page now includes a Docker installation guide, offering more diverse installation options;
2. External data source optimization: When querying SLS data sources, a query specification prompt has been added to help users perform more accurate data queries.

#### Scenarios

[Combined Chart](../scene/visual-chart/index.md#conbine) optimization: Combined charts now support view variable configuration, allowing users to select view variables from the current dashboard to be applied to the combined chart, facilitating more flexible data filtering and analysis.

#### Monitoring

Anomaly detection monitor: Added support for week-over-week and month-over-month comparisons in query periods.

#### AI Intelligent Assistant

Added a knowledge base related to DataFlux Func.

#### Pipeline

Optimized auto-generated Pipeline: Supports obtaining Pipeline parsing through both structured and natural language interaction simultaneously.

### Bug Fixes {#bug0116}

1. Fixed display issues in log stacking mode;
2. Fixed misalignment of function input boxes in log monitoring monitors;
3. Fixed errors in metric calculations;
4. Fixed issues with unsupported `having` statements in Volcengine;
5. Fixed errors when selecting "Request Error Rate" and "Average Requests per Second" metrics in APM metrics monitoring;
6. Fixed ineffective `not in` statements in Volcengine;
7. Fixed slow page loading due to large event list returns;
8. Fixed unexpected behavior of one-click recovery for events in Hangzhou region.

## January 8, 2025

### OpenAPI Updates {#openapi0108}

1. Field management: Supports retrieving field management lists, adding/modifying/deleting fields.
2. Synthetic Tests: Supports modifying dial testing tasks.
3. Incident > Schedule: Supports retrieving schedule lists, adding/modifying/deleting schedules.
4. Incident > Configuration Management: Supports retrieving notification policy lists, adding/modifying/deleting notification policies; supports retrieving Issue discovery lists, adding/modifying/enabling/disabling/deleting Issue discovery configurations.

### Feature Updates {#feature0108}

#### Logs

1. Log index optimization:
    - When accessing built-in views of access logs or log context tab pages, the current log's index and `default` index will be selected by default. Both tabs support multi-selection of indexes. Additionally, cross-workspace queries are supported, allowing direct querying of corresponding workspace index data after selecting authorized workspaces in the menu. This helps users view associated log data on a single page, optimizing log query interactions.
    - When listing log indexes, except for the `default` index which is displayed at the top, other log indexes are listed alphabetically.
2. Added stack [view mode](../logs/manag-explorer.md#mode) to log Explorer: In stack mode, fields are consolidated into a single column and displayed as rows within cells. This makes log information more compact and clear, facilitating quick browsing and analysis.
3. Log Pipeline optimization: Test samples for log Pipelines now include all log fields and must be entered in line protocol format. Manually entered logs must also follow this format.

#### Scenarios

1. [Table Chart](../scene/visual-chart/table-chart.md) optimization:
    - Multi-metric query sorting support: When using a single DQL for multi-metric queries, table charts now support sorting.
    - Table pagination selection: Added pagination selection for tables, allowing users to choose appropriate pagination sizes based on data volume and viewing needs.
2. Combined charts: Support adjusting the order of charts.
3. Chart optimization: Adjusted the function order in DQL query components and emphasized the use scenarios of the Rollup function to help users better utilize it for data aggregation and analysis.

#### Management

1. Event support for [data forwarding](../management/backup/index.md): Supports configuring data forwarding rules for event types, saving filtered event data to Guance object storage or external storage, providing flexible event data management.
2. Added DataKit [environment variables](../management/env_variable.md) to workspaces: Workspaces now support managing DataKit environment variables, allowing easy configuration and updates of environment variables for remote synchronization of DataKit collection configurations.
3. Optimized [audit event](../management/audit-event.md) queries: Added multiple fields to record query information, and included time ranges in event content for better tracking and analysis of query behavior.

#### Pipeline

Optimized auto-generated Pipeline: Changed the way prompts appear to enhance product experience.

#### AI Intelligent Assistant

AI Intelligent Assistant added [chart generation](../guance-ai/index.md#chart): Based on large models, it automatically analyzes user input text data and intelligently generates appropriate charts, solving issues of manual chart creation being cumbersome and difficult chart selection.

#### Monitoring

[Alert Policies](../monitoring/alert-setting.md#member): Notification rules configured by members now support adding names for purpose descriptions.

### Deployment Plan Updates {#deployment0108}

1. Admin backend > Workspace menu optimization:
    - Added main storage engine and business filters to the workspace list for easier filtering;
    - Optimized workspace list pagination logic so that when modifying/deleting a workspace or changing data reporting limits, the current page remains unchanged to optimize query experience.
2. Added new parameter: `alertPolicyFixedNotifyTypes`, supporting configuration of whether the "email" notification method is displayed in alert policies [configuration reference](/deployment/application-configuration-guide/#studio-backend).

### New Integrations {#inte0108}

1. Added [AWS Gateway Classic ELB](../integrations/aws_elb.md);
2. Added [Volcengine TOS Object Storage](../integrations/volcengine_tos.md);
3. Modified AWS Classic collector name;
4. Added [MinIO V3](../integrations/minio_v3.md) integration;
5. Updated elasticsearch, solr, nacos, influxdb_v2, mongodb integrations (views, documents, monitors);
6. Updated kubernetes monitoring views.

### Bug Fixes {#bug0108}

1. Resolved issues with cross-space authorization of event data not taking effect;
2. Resolved issues with trace ID not querying data when jumping from log association links to link Explorer;
3. Resolved issues with value filling in view expression queries;
4. Resolved issues with no operation audit records generated when changing alert policies in external event monitoring monitors;
5. Resolved issues with non-adjustable column widths in event display lists.