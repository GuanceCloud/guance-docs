# Generate Metrics
---

This involves generating new metric data based on existing data within the current workspace, enabling the design and implementation of new technical metrics according to actual business needs.

**Note**:

1. Creating metrics requires a role with **Metric Configuration Management** [permissions](../management/role-list.md);
2. After metric generation, metrics will be stored according to the default [data retention policy](../billing-method/data-storage.md) and charged based on the number of generated [time series](../billing-method/billing-item.md#timeline);
3. If no data is reported during the period after metric generation, it will not be possible to query or analyze the metrics within the workspace.

## Application Scope

Logs, APM, RUM, Metrics, and Security Check.

## Start Building

1. Select data source;
2. Configure [query conditions](#query);
3. Define [metric generation content](#content), setting up the method and results for generating metrics, including the frequency of metric generation, label names for newly generated metrics, and measurement set names.

### Data Query {#query}

Metric data supports PromQL queries in addition to simple and DQL queries.

> For more details, refer to [Chart Queries](../scene/visual-chart/chart-query.md).

:material-numeric-1-circle: Data Source


| Source | Description |
| --- | --- |
| Logs | All indexed data currently available in the workspace. Based on selected index data, filter all/specific log data sources within the current workspace to generate new data by adding filtering and aggregation expressions to existing data, resulting in new metric results and data sets. `*` indicates all data sources. |
| APM | Data sources from services that have enabled collection. `*` indicates all data sources. |
| RUM | Application data sources within the current workspace, i.e., applications that have enabled collection. `*` indicates all data sources. |
| Metrics | All metric data within the current workspace. |
| Security Check | All/single category data sources within the current workspace. After enabling the security check collector, categories include `network`, `storage`, `database`, `system`, `webserver`, `Kubernetes`. `*` indicates all data sources. |

:material-numeric-2-circle: Aggregation Functions

| Function | Description |
| --- | --- |
| `count` | Count the number of items |
| `avg` | Calculate the average value of a specified field |
| `max` | Find the maximum value of a specified field |
| `min` | Find the minimum value of a specified field |
| `P75` | Calculate the 75th percentile value of a specified field |
| `P95` | Calculate the 95th percentile value of a specified field |
| `P99` | Calculate the 99th percentile value of a specified field |

:material-numeric-3-circle: Dimensions: Aggregate data based on the selected objects, generating a statistical value for each selected object in the data request.

### Metric Generation Content {#content}

1. Frequency: The execution cycle for generating metrics. The selected time also serves as the aggregation time. Choosing a frequency of 1 minute means aggregating and generating metrics every 1 minute, with each aggregation covering a 1-minute time range.

    - 1 minute (default), i.e., generating new metric data every 1 minute;
    - 5 minutes
    - 15 minutes

2. Measurement Set: Set the name of the measurement set where the metrics will be stored.

3. Metric: Set the name of the metric, which must be unique. Multiple metrics can be added.

4. Tags: Automatically generated based on the dimensions selected in the query.

5. Unit: Optional, set the unit for the metric. After setting a unit, it can be applied in chart queries.

6. Description: Optional, set a description for the metric. After setting a description, it can be applied in chart queries.

After completing the generation rules, click **Confirm** to save the metric generation rule and start data collection.

**Note**: If data is delayed by more than 1 minute, it will not be included in the statistics once it is stored in the database.

<!--

2. Time Range: Based on the selected frequency as the time interval, the default chart query is 6 hours, showing the effect of data statistics within 6 hours; when modifying the frequency >= 1 hour, the query time range is fixed at 7 days.
-->

## List Management

1. Edit: View and edit all created metric generation rules.

    **Note**: Since the data source and aggregation expressions determine the data type, some configurations cannot be edited or modified.

2. Enable/Disable: Modify the status of the rule. When a metric generation rule is disabled, corresponding data will not be written to the measurement set until it is re-enabled.

3. Delete: Remove unnecessary rules. Deleting a rule stops data writing but does not delete the measurement set.

4. Batch Operations: Perform batch operations on specific rules, including enabling, disabling, and deleting rules.

5. View Metrics

- View in Metric Analysis: Navigate to the **Metric Analysis** page for querying and analyzing metrics.

- View in Metric Management: Navigate to the **Metric Management** page to view metrics and tags, where you can edit metric units and descriptions.

**Note**: Generated metrics are based on the selected frequency and data aggregated within the query time range. If no data is reported during this period, metrics will not be generated and thus not available for querying or searching in **Metrics**.

## Use Cases

### Apply in Chart Queries

Perform metric data queries and analysis in [Visual Charts](../scene/visual-chart/chart-query.md).

![](img/generate_metrics.png)

### Apply in Query Tools

Perform metric data queries and analysis in **Shortcut > [Query Tool](../dql/query.md) > DQL Query**.

![](img/generate_metrics_1.png)