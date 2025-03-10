# Generate Metrics
---

<<< custom_key.brand_name >>> supports generating new metric data based on existing data within the current workspace, allowing you to design and implement new technical metrics according to your needs.

**Note**:

- The role with **Metric Generation Configuration Management** [permission list](../management/role-list.md) can create and edit generated metrics;
- After metrics are generated, they will be stored according to the current default [data retention policy](../billing-method/data-storage.md), and charges will be applied based on the number of [time series](../billing-method/index.md#time-example);
- If no data is reported during the generation period, the metrics cannot be queried or analyzed in the workspace, such as in **Metric Analysis**, **Charts**, or the **DQL Query Tool**.

## Create/Clone Rules

Navigate to the **User Access Detection > Generate Metrics** page,

- Click **Create Rule** to start creating a new metric generation rule;

- Click the :octicons-copy-24: icon to clone an existing rule to create a new one.

![](img/4.rum_metrics_1.png)

**Step 1**: Data Source. Select all or individual application data sources available in the current workspace and generate new data based on this data source.

- Application: The data source of the application, i.e., the name of the application that has enabled data collection; **“ * ” indicates all data sources**.

**Note**: The listing of applications here is influenced by [data access rules](./rumdata_access.md).

**Step 2:** Data Query: Based on the selected data source, you can add filtering and aggregation expressions to the existing data to generate new metric results and data sets.

- Aggregation Method: See the table below:

| Aggregation Method | Description |
| --- | --- |
| count | Count the number of items |
| avg | Calculate the average value, requires selecting a field for aggregation |
| max | Find the maximum value, requires selecting a field for aggregation |
| min | Find the minimum value, requires selecting a field for aggregation |
| P75 | Calculate the 75th percentile value of the specified field, requires selecting a field for aggregation |
| P95 | Calculate the 95th percentile value of the specified field, requires selecting a field for aggregation |
| P99 | Calculate the 99th percentile value of the specified field, requires selecting a field for aggregation |

- Dimensions: Aggregate data based on the selected objects, generating a statistical value for each selected object in the data request;
- Filtering: Supports adding one or more filter conditions to the existing tag data, and adding **AND** (and) or **OR** (or) relationships to the same row of filter conditions.

**Step 3:** Generate Metrics: Set up the method and results for generating metrics, including the frequency of generation, the name of the new metric tags, and the name of the metric set.

| Field | Description |
| --- | --- |
| Frequency | The execution cycle for generating metrics, default is 1 minute, i.e., new metric data is generated every 1 minute; the selected frequency also serves as the aggregation time, so if the frequency is 1 minute, then metrics are aggregated and generated every 1 minute, with each aggregation covering a 1-minute time range. |
| Measurement | Set the name of the metric set where the metrics will be stored. |
| Metric | Set the name of the metric, which must be unique, multiple metrics can be added. |
| Tags | Automatically generated based on the dimensions selected in the query. |
| Unit | Optional, set the unit for the metric, which can be used in chart queries after setting. |
| Description | Optional, set a description for the metric, which can be used in chart queries after setting.

**Step 4:** After completing the generation rule form, click **Confirm** to complete the metric generation rule and start data collection.

## Operation Instructions

All added rules will be displayed on the **Generate Metrics** page, where users can perform the following operations:

![](img/4.rum_metrics_2.png)

### Edit Rules

On the **Generate Metrics** page, you can view all created metric generation rules and edit them.

**Note**: Since the data source and aggregation expressions of the metric generation rules determine the data type, some rules do not support editing or modification.

![](img/4.rum_metrics_3.png)

### Enable/Disable Rules

On the **Generate Metrics** page, you can modify the status of the rules. When a metric generation rule is disabled, the corresponding data will not be written to the metric set until it is re-enabled.

### Delete Rules

On the **Generate Metrics** page, unnecessary rules can be deleted. Deleting a rule stops data from being written to the metric set but does not delete the metric set itself.

### Batch Operations {#batch}

You can perform batch operations on specific rules, including enabling, disabling, and deleting rules.

### View Metrics

#### View in Metric Analysis

On the **Generate Metrics** page, click the **Open in Metric Analysis** button next to the rule to navigate to the **Metric Analysis** page for querying and analyzing the metrics.

![](img/4.rum_metrics_4.png)

#### View in Metric Management

On the **Generate Metrics** page, click the **Open in Metric Management** button next to the rule to navigate to the **Metric Management** page to view metrics and tags, supporting editing of metric units and descriptions.

![](img/4.rum_metrics_6.png)

## More Use Cases

### Apply in Chart Queries

After metrics are generated, you can create a new dashboard under **Scenarios > Dashboard > Create Dashboard** and use [Visual Charts](../scene/visual-chart/chart-query.md) to query and analyze metric data.

![](img/4.rum_metrics_7.png)

### Apply in DQL Query Tool

After metrics are generated, you can use the **Shortcut > [Query Tool](../dql/query.md)** to query and analyze metric data.

![](img/4.rum_metrics_5.png)