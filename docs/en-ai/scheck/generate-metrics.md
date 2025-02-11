# Generate Metrics
---
- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64


Guance supports generating new metrics data based on existing data within the current workspace, allowing you to design and implement new technical metrics as needed.

???+ warning 

    - The role with "Generate Metrics Configuration Management" permissions can create and edit metric generation rules. For more details, refer to [Permission List](../management/role-list.md).
    - After metrics are generated, they will be stored according to the current default [Data Storage Policy](../billing-method/data-storage.md) and charged based on the number of [Time Series](../billing-method/index.md#time-example).
    - If no data is reported during the period after metric generation, it cannot be queried or analyzed in the workspace, such as in "Metric Analysis", "Charts", or the "DQL Query Tool".

## Create/New Clone Rule

Navigate to the **Security Check > Generate Metrics** page,

- Click **Create New Rule** to start creating a new metric generation rule;
- Click the :octicons-copy-24: icon to clone an existing rule to create a new one.

![](img/5.scheck_metrics_1.png)

**Step 1**: Data Source. Filter out all or single category data sources currently available in the workspace.

- Category: After enabling the Security Check collector, categories include `network`, `storage`, `database`, `system`, `webserver`, `Kubernetes`. **Note: “ * ” indicates all.**

**Step 2:** Data Query. Based on the selected category, choose an aggregation method to query and aggregate data across different dimensions.

- Aggregation Method: See the table below

| Aggregation Method | Description |
| --- | --- |
| count | Count occurrences |
| avg | Calculate the average value, requires selecting a field for aggregation |
| max | Find the maximum value, requires selecting a field for aggregation |
| min | Find the minimum value, requires selecting a field for aggregation |
| P75 | Calculate the 75th percentile value of the specified field, requires selecting a field for aggregation |
| P95 | Calculate the 95th percentile value of the specified field, requires selecting a field for aggregation |
| P99 | Calculate the 99th percentile value of the specified field, requires selecting a field for aggregation |

- Dimension: Aggregate data based on the selected objects, generating a statistical value for each selected object in the data request.
- Filters: Support adding one or multiple filter conditions to the existing tag data, and define "AND" (and), "OR" (or) relationships between conditions in the same row.

**Step 3:** Generate Metrics. Set up the method and results of metric generation, including the frequency of generation, the name of the newly generated metric, and the name of the metric set.

- Frequency: Execution cycle for generating metrics, default is 1 minute, i.e., generate new metric data every 1 minute; the selected frequency also serves as the aggregation time. If the frequency is set to 1 minute, then metrics are aggregated every 1 minute, with each aggregation covering a 1-minute time range.
- Time Range: Based on the selected frequency as the time interval, the chart defaults to querying data for 6 hours, i.e., displaying the effect of data statistics within 6 hours; when modifying the [Frequency] >= 1 hour, the query time range is fixed at 7 days.
- Metric Set: Set the name of the metric set where the metrics will be stored.
- Metric: Set the name of the metric, ensuring that the metric names are unique. Multiple metrics can be added.
- Tags: Automatically generated based on the dimensions selected in the query.
- Unit: Optional, set the unit for the metric. Once set, it can be applied in chart queries.
- Description: Optional, set a description for the metric. Once set, it can be applied in chart queries.

**Step 4:** After completing the creation of the metric generation rule, click "Confirm" to complete the rule and start data collection.

## Operation Instructions

All added rules will be displayed on the "Generate Metrics" page, where users can perform actions such as "Enable/Disable", "Open in Metric Analysis", "Open in Metric Management", "Edit", and "Delete".

![](img/5.scheck_metrics_2.png)

### Edit Rules

On the "Generate Metrics" page, you can view all created metric generation rules and edit them.

**Note: Since the data source and aggregation expression of the metric generation rule determine the data type, some rules do not support editing or modification.**

![](img/5.scheck_metrics_3.png)

### Enable/Disable Rules

On the "Generate Metrics" page, you can modify the status of the rules. When a metric generation rule is disabled, the corresponding data will not be written to the metric set. It will resume writing upon re-enabling.

### Delete Rules

On the "Generate Metrics" page, unnecessary rules can be deleted. Deleting a rule stops data from being written to the metric set but does not delete the metric set itself.

### Batch Operations {#batch}

You can perform batch operations on specific rules, including enabling, disabling, and deleting rules.

### View Metrics

#### View in Metric Analysis

On the "Generate Metrics" page, click the "Open in Metric Analysis" button next to the rule to navigate to the "Metric Analysis" page for querying and analyzing the metrics.

![](img/5.scheck_metrics_4.png)

#### View in Metric Management

On the "Generate Metrics" page, click the "Open in Metric Management" button next to the rule to navigate to the "Metric Management" page to view metrics and tags, supporting editing of metric units and descriptions.

![](img/5.scheck_metrics_5.png)

## More Application Scenarios

### Use in Chart Queries

After metrics are generated, they can be used in "Scenes" - "Dashboard" - "New Dashboard" to query and analyze metric data in [Visual Charts](../scene/visual-chart/chart-query.md).

![](img/5.scheck_metrics_7.png)

### Use in DQL Query Tool

After metrics are generated, they can be queried and analyzed in the "Shortcut" - "[DQL Query](../dql/query.md)" tool.

![](img/5.scheck_metrics_6.png)