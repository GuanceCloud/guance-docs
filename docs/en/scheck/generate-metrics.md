# Generate Metrics
---
- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

<<< custom_key.brand_name >>> supports generating new metric data based on existing data within the current workspace to help you design and implement new technical metrics according to your needs.

???+ warning 

    - Creating metrics requires roles with "Metric Generation Configuration Management" permissions. For more details, refer to [Permission List](../management/role-list.md).
    - After metrics are generated, they will be stored according to the default [Data Storage Policy](../billing-method/data-storage.md) and charged based on the number of [Time Series](../billing-method/index.md#time-example).
    - If no data is reported during the period after metric generation, it cannot be queried or analyzed in the workspace, such as in "Metric Analysis," "Charts," or the "DQL Query Tool."

## Create/Clone Rules

Navigate to the **Security Check > Generate Metrics** page,

- Click **Create Rule** to start creating a new metric generation rule;
- Click the :octicons-copy-24: icon to clone an existing rule and create a new one.

![](img/5.scheck_metrics_1.png)

**Step 1**: Data Source. Filter out all or single categories of existing data sources within the current workspace.

- Category: After the Security Check collector is enabled, categories include `network`, `storage`, `database`, `system`, `webserver`, `Kubernetes`. **Note: “ * ” indicates all.**

**Step 2:** Data Query. Based on the selected category, choose an aggregation method to query and aggregate data across different dimensions.

- Aggregation Method: See table below

| Aggregation Method | Description |
| --- | --- |
| count | Count the number of occurrences |
| avg | Calculate the average value; requires selecting a field for aggregation |
| max | Find the maximum value; requires selecting a field for aggregation |
| min | Find the minimum value; requires selecting a field for aggregation |
| P75 | Calculate the 75th percentile value of the specified field; requires selecting a field for aggregation |
| P95 | Calculate the 95th percentile value of the specified field; requires selecting a field for aggregation |
| P99 | Calculate the 99th percentile value of the specified field; requires selecting a field for aggregation |

- Dimension: Aggregate data based on the selected objects, generating a statistical value for each selected object in the data request.
- Filters: Add one or more filter conditions to existing tag data, and add "AND" (and) or "OR" (or) relationships to the same row filter conditions.

**Step 3:** Generate Metrics. Set up the method and results for generating metrics, including the frequency of generation, the name of the newly generated metric, and the name of the metric set.

- Frequency: The execution cycle for generating metrics. Default is 1 minute, meaning new metric data is generated every 1 minute; the selected frequency also serves as the aggregation time. If the frequency is set to 1 minute, then metrics are aggregated and generated every 1 minute, with each aggregation covering a 1-minute time range.
- Time Range: Based on the selected frequency as the time interval, the chart defaults to querying 6 hours, i.e., the effect of statistical data display within 6 hours; when modifying the [Frequency] >= 1 hour, the query time range is fixed at 7 days.
- Metric Set: Set the name of the metric set where the metrics will be stored.
- Metric: Set the name of the metric, which must be unique. Multiple metrics can be added.
- Tags: Automatically generated based on the dimensions selected in the query.
- Unit: Optional, set the unit for the metric. Once set, it can be applied in chart queries.
- Description: Optional, set a description for the metric. Once set, it can be applied in chart queries.

**Step 4:** After completing the generation rule form, click "Confirm" to complete the creation of the metric generation rule and start data collection.

## Operation Instructions

All added rules will be displayed on the "Generate Metrics" interface, where users can perform operations such as "Enable/Disable," "Open in Metric Analysis," "Open in Metric Management," "Edit," and "Delete."

![](img/5.scheck_metrics_2.png)

### Edit Rules

On the "Generate Metrics" page, you can view all created metric generation rules and edit them.

**Note: Since the data source and aggregation expression of the metric generation rules determine the data type, some rules do not support editing or modification.**

![](img/5.scheck_metrics_3.png)

### Enable/Disable Rules

On the "Generate Metrics" page, you can modify the status of the rules. When a metric generation rule is disabled, the corresponding data will not be written to the metric set until it is re-enabled.

### Delete Rules

On the "Generate Metrics" page, you can delete unnecessary rules. After a rule is "Deleted," the metric set will not be deleted, but data writing will stop.

### Batch Operations {#batch}

You can perform batch operations on specific rules, including enabling, disabling, and deleting rules.

### View Metrics

#### View in Metric Analysis

On the "Generate Metrics" page, click the "Open in Metric Analysis" button next to the rule to navigate to the "Metric Analysis" page for querying and analyzing the metrics.

![](img/5.scheck_metrics_4.png)

#### View in Metric Management

On the "Generate Metrics" page, click the "Open in Metric Management" button next to the rule to navigate to the "Metric Management" page to view metrics and tags, supporting editing of metric units and descriptions.

![](img/5.scheck_metrics_5.png)

## More Use Cases

### Apply in Chart Queries

After metrics are generated, they can be used in "Scenarios" - "Dashboard" - "Create Dashboard," where you can query and analyze metric data in [Visual Charts](../scene/visual-chart/chart-query.md).

![](img/5.scheck_metrics_7.png)

### Apply in DQL Query Tool

After metrics are generated, they can be queried and analyzed in the "Shortcut" - "[DQL Query](../dql/query.md)" tool.

![](img/5.scheck_metrics_6.png)