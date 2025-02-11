# Generate Metrics
---

Guance supports generating new metric data based on existing data within the current workspace, allowing you to design and implement new technical metrics according to your needs.

???+ warning 

    - The role with the **Generate Metrics Configuration Management** [permission list](../management/role-list.md) can create and edit;
    - After metrics generation, the metric data will be stored according to the default [data storage policy](../billing-method/data-storage.md), and charges will be applied based on the generated [time series count](../billing-method/index.md#time-example);
    - If no data is reported during the period after metrics generation, it cannot be queried or analyzed in the workspace, such as in **Metric Analysis**, **Charts**, or **DQL Query Tool**.

## Create/New Clone Rule

Navigate to the **APM > Generate Metrics** page,

- Click **New Rule** to start creating a new generate metrics rule;
- Click the :octicons-copy-24: icon to clone an existing rule to create a new one.

![](img/3.apm_metrics_3.png)

**Step 1**: Data Source. Filter out all or single service data sources available in the current space and generate new data based on this data source.

- Source: Data source, i.e., the service data source that has been enabled for collection; **Note: “ * ” indicates all data sources**

**Step 2:** Data Query. Based on the selected data source, you can add filtering and aggregation expressions to the existing data to request new metric results and data sets.

- Aggregation Methods: See table below

| Aggregation Method | Description |
| --- | --- |
| count | Count occurrences |
| avg | Calculate the average value, requires selecting a field for aggregation |
| max | Find the maximum value, requires selecting a field for aggregation |
| min | Find the minimum value, requires selecting a field for aggregation |
| P75 | Calculate the 75th percentile value of the specified field, requires selecting a field for aggregation |
| P95 | Calculate the 95th percentile value of the specified field, requires selecting a field for aggregation |
| P99 | Calculate the 99th percentile value of the specified field, requires selecting a field for aggregation |

- Dimensions: Aggregate data by the selected objects, generating a statistical value for each selected object in the data request;
- Filters: Support adding one or more filter conditions to the existing label data, and add **AND** (and) or **OR** (or) relationships between conditions in the same row.

**Step 3:** Generate Metrics. Set up the method and results of generating metrics, including the frequency of generation, the name of the new metric's labels, and the Mearsurement set name.

| Field | Description |
| --- | --- |
| Frequency | The execution cycle for generating metrics, default is 1 minute, meaning new metric data is generated every 1 minute; the selected frequency also serves as the aggregation time, so if the frequency is 1 minute, then metrics are aggregated and generated every 1 minute, with each aggregation covering a 1-minute time range. |
| Mearsurement | Set the name of the Mearsurement where the metrics will be stored. |
| Metric | Set the name of the metric, metric names must be unique, multiple metrics can be added. |
| Labels | Automatically generated based on the dimensions selected in the query. |
| Unit | Optional, set the unit of the metric, which can be used in chart queries after setting. |
| Description | Optional, set the description of the metric, which can be used in chart queries after setting.

**Step 4:** After completing the generation rule, click **Confirm** to complete the rule creation and start data collection.

## Operation Instructions

All added rules will be displayed in the **Generate Metrics** interface, where users can perform the following operations:

![](img/3.apm_metrics_1.png)

**Note:**

1. Since the data source, aggregation expression, etc., of the generate metrics rule determine the data type, some rules do not support editing and modification.
2. When a metrics generation rule is disabled, the corresponding data will not be written to the Mearsurement set, and writing will resume upon re-enabling.
3. After a rule is deleted, the Mearsurement set will not be deleted, but data writing will stop.


### View Metrics

#### In Metric Analysis

On the **Generate Metrics** page, click the **Open in Metric Analysis** button on the right side of the rule to navigate to the **Metric Analysis** page for querying and analyzing.

**Note:** Metrics are generated based on the selected frequency and aggregate data within the query time range. If no data is reported during this period, metrics cannot be generated and thus cannot be queried or searched in **Metrics**.

![](img/3.apm_metrics_4.png)
​	

#### In Metric Management

On the **Generate Metrics** page, click the **Open in Metric Management** button on the right side of the rule to navigate to the **Metric Management** page to view metrics and labels, supporting editing of metric units and descriptions.

![](img/3.apm_metrics_5.png)

## Application Scenarios

### Chart Query

After metrics generation, you can go to **Scenes > Dashboard > New Dashboard**, and use [Visual Charts](../scene/visual-chart/chart-query.md) to query and analyze metric data.

![](img/3.apm_metrics_7.png)

### DQL Query Tool

After metrics generation, you can use the [Query Tool](../dql/query.md) in **Shortcuts** to query and analyze metric data.

![](img/3.apm_metrics_6.png)