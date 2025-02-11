# Version History

## 1.102.188 (January 8, 2025) {#1.102.188}

pubrepo.guance.com/dataflux/1.102.188:launcher-0bd0be5-1736856269

### Offline Image Package Download

- AMD64 Architecture Download: https://static.guance.com/dataflux/package/guance-amd64-1.102.188.tar.gz
    - MD5: `07d82df7e9a6ccb4ba747e8cb02d0882`

- ARM64 Architecture Download: https://static.guance.com/dataflux/package/guance-arm64-1.102.188.tar.gz
    - MD5: `e5ee7933fd1f46ae9df5d05219b4726d`

### Deployment Plan Update {#deployment0108}

1. Deployment Tool `Launcher` Optimization:
    - Fixed the "Workload Configuration" feature, correcting issues with CPU cores and memory byte units in "Resource Configuration".
    - Optimized the "Restart" workload function to resolve duplicate confirmation pop-up issues.
2. Management Backend > Workspace Menu Optimization:
    - Added two new filters for the workspace list: main storage engine and business, enabling easier workspace filtering.
    - Optimized pagination logic on the workspace list page, ensuring users remain on the current page after modifying or deleting a workspace or changing data reporting limits, enhancing query experience.
3. New Parameter for Deployment Plan: `alertPolicyFixedNotifyTypes`, allowing configuration of whether the "Email" notification method is displayed in alert policies. [Configuration Reference](/deployment/application-configuration-guide/#studio-backend).

### OpenAPI Update {#openapi0108}

1. Field Management: Supports retrieving field management lists, adding, modifying, and deleting field management entries.
2. Synthetic Tests: Supports modifying dial testing tasks.
3. Incident > Schedule: Supports retrieving schedule lists, adding, modifying, and deleting schedules.
4. Incident > Configuration Management: Supports retrieving notification policy lists, adding, modifying, and deleting notification policies; supports retrieving Issue discovery lists, adding, modifying, enabling/disabling, and deleting Issue discovery configurations.

### Feature Updates {#feature0108}

#### Logs

1. Log Index Optimization:
    - When accessing built-in log views and log context tabs, the default selected index will be the current log's index and the `default` index respectively. Both tabs support multi-selection of indexes. After enabling cross-workspace queries and selecting authorized workspaces from the menu, users can directly query corresponding workspace index data. This helps users view associated log data comprehensively on one page, optimizing log query interactions.
    - In addition to the `default` index being displayed at the top, other log indexes are listed alphabetically from A to Z.
2. Explorer Adds Stacked [View Mode](../../logs/manag-explorer.md#mode): In stacked mode, fields are consolidated into a single column and displayed as rows within cells, making log information more compact and clear for quick browsing and analysis.
3. Log Pipeline Optimization: Test samples for log pipelines now include all log fields and require input in line protocol format. User-entered logs must also follow this format.

#### Scenarios

1. [Table Chart](../../scene/visual-chart/table-chart.md) Optimization:
    - Multi-Metric Query Sorting Support: When using a single DQL for multi-metric queries, table charts now support sorting.
    - Table Pagination Selection: Added table pagination selection functionality, allowing users to choose appropriate page sizes based on data volume and viewing needs.
2. Composite Charts: Supports adjusting the order of charts.
3. Chart Optimization: Adjusted the function order in the DQL query component, emphasizing the use cases of the Rollup function to help users better utilize it for data aggregation and analysis.

#### Management

1. Event Data Forwarding Support: Configurable event forwarding rules allow saving filtered event data to Guance object storage or external storage, providing flexible event data management capabilities.
2. Workspace Adds DataKit [Environment Variables](../../management/env_variable.md): Workspaces support managing DataKit environment variables, enabling easy configuration and updates, and remote synchronization of DataKit collection configurations.
3. Query [Audit Events](../../management/audit-event.md) Optimization: Added multiple fields to record query information and included the query time range in event content for better tracking and analysis of query behavior.

#### Pipeline

Auto-generated Pipeline Optimization: Changed the way prompts appear, enhancing product experience.

#### AI Smart Assistant

AI Smart Assistant Adds [Chart Generation](../../guance-ai/index.md#chart): Based on large models, it automatically analyzes user input text data and intelligently generates suitable charts, solving problems related to manual chart creation and chart selection difficulties.

#### Monitoring

[Alert Policies](../../monitoring/alert-setting.md#member): Supports appending names for purpose descriptions when configuring notification rules by members.

### New Integrations {#inte0108}

1. Added [AWS Gateway Classic ELB](../../integrations/aws_elb.md);
2. Added [Volcengine TOS Object Storage](../../integrations/volcengine_tos.md);
3. Modified AWS Classic Collector Name;
4. Added [MinIO V3](../../integrations/minio_v3.md) integration;
5. Updated elasticsearch, solr, nacos, influxdb_v2, mongodb integrations (views, documents, monitors);
6. Updated Kubernetes monitoring views.

### Bug Fixes {#bug0108}

1. Resolved issues with cross-workspace authorization not taking effect for event data;
2. Fixed an issue where jumping to the trace viewer with `trace_id` failed to retrieve data;
3. Resolved an issue where expression queries in views could not perform numerical fills;
4. Fixed an issue where changes to alert policies did not generate operation audit records for external event detectors;
5. Resolved an issue where column widths in event display lists could not be adjusted.