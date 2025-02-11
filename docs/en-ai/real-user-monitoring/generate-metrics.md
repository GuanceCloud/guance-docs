# Generate Metrics
---

Guance supports generating new metric data based on existing data within the current workspace, allowing you to design and implement new technical metrics according to your needs.

**Note**:

- To generate metrics, a role with **Metric Generation Configuration Management** [permission list](../management/role-list.md) is required to create and edit;
- After metric generation, the data will be stored according to the current default [data storage policy](../billing-method/data-storage.md), and charges will be applied based on the generated [Time Series count](../billing-method/index.md#time-example);
- If no data is reported during the period after metric generation, it cannot be queried or analyzed in the workspace, such as in **Metric Analysis**, **Charts**, or **DQL Query Tool**.

## Create/New Rule

Navigate to the **RUM > Generate Metrics** page,

- Click **Create New Rule** to start creating a new metric generation rule;

- Click the :octicons-copy-24: icon to clone an existing rule to create a new one.

![](img/4.rum_metrics_1.png)

**Step 1**: Data Source. Select all or individual application data sources currently available in the workspace and begin generating new data based on this source.

- Application: The data source of the application, i.e., the name of the application that has enabled data collection; **“ * ” indicates all data sources**.

**Note**: The listing of applications here is affected by the [Data Access Rules](./rumdata_access.md).

**Step 2:** Data Query: Based on the selected data source, you can add filtering and aggregation expressions to the existing data to request new metric results and data sets.

- Aggregation Method: Refer to the table below:

| Aggregation Method | Description |
| --- | --- |
| count | Count the number of items |
| avg | Calculate the average value of the selected field |
| max | Find the maximum value of the selected field |
| min | Find the minimum value of the selected field |
| P75 | Calculate the 75th percentile value of the specified field |
| P95 | Calculate the 95th percentile value of the specified field |
| P99 | Calculate the 99th percentile value of the specified field |

- Dimensions: Aggregate data according to the selected objects, generating a statistical value for each selected object in the data request;
- Filters: Support adding one or multiple filter conditions to the existing tag data, and you can add **AND** (and) or **OR** (or) relationships between conditions on the same line.

**Step 3:** Generate Metrics: Set up the method and results for generating metrics, including the frequency of metric generation, the label names, and the Mearsurement set name for newly generated metrics.

| Field | Description |
| --- | --- |
| Frequency | The execution cycle for generating metrics, default is 1 minute, i.e., new metric data is generated every 1 minute; the selected time also serves as the aggregation time. If the frequency is set to 1 minute, then metrics are aggregated and generated every 1 minute, with each aggregation covering a 1-minute time range. |
| Mearsurement | Set the name of the Mearsurement where the metrics will be stored. |
| Metric | Set the name of the metric; metric names must be unique, and multiple metrics can be added. |
| Labels | Automatically generated based on the dimensions selected in the query. |
| Unit | Optional, set the unit for the metric, which can be applied in chart queries after setting. |
| Description | Optional, set a description for the metric, which can be applied in chart queries after setting. |

**Step 4:** After completing the creation of the metric generation rule, click **Confirm** to complete the rule setup and start data collection.

## Operation Instructions

All added rules will be displayed on the **Generate Metrics** interface, where users can perform the following operations:

![](img/4.rum_metrics_2.png)

### Edit Rule

On the **Generate Metrics** page, you can view all created metric generation rules and edit them.

**Note**: Since the data source and aggregation expressions of the metric generation rules determine the data type, some rules do not support editing or modification.

![](img/4.rum_metrics_3.png)

### Enable/Disable Rule

On the **Generate Metrics** page, you can modify the status of the rules. When a metric generation rule is disabled, the corresponding data will not be written into the Mearsurement until it is re-enabled.

### Delete Rule

On the **Generate Metrics** page, unnecessary rules can be deleted. After deletion, the Mearsurement will not be deleted, but data writing will stop.

### Batch Operations {#batch}

You can perform batch operations on specific rules, including enabling, disabling, and deleting rules.

### View Metrics

#### View in Metric Analysis

On the **Generate Metrics** page, click the **Open in Metric Analysis** button on the right side of the rule to navigate to the **Metric Analysis** page for querying and analyzing the metrics.

![](img/4.rum_metrics_4.png)

#### View in Metric Management

On the **Generate Metrics** page, click the **Open in Metric Management** button on the right side of the rule to navigate to the **Metric Management** page to view metrics and labels, supporting editing of metric units and descriptions.

![](img/4.rum_metrics_6.png)

## More Application Scenarios

### Apply in Chart Queries

After generating metrics, you can use them in **Scenarios > Dashboards > Create Dashboard**, performing metric data queries and analysis in [Visual Charts](../scene/visual-chart/chart-query.md).

![](img/4.rum_metrics_7.png)

### Apply in DQL Query Tool

After generating metrics, you can query and analyze the metric data in the **Shortcut > [Query Tool](../dql/query.md)**.

![](img/4.rum_metrics_5.png)