# Generate Metrics
---

Guance supports generating new metrics data based on existing data within the current workspace, allowing you to design and implement new technical metrics according to your needs.

???+ warning 

    - Roles with **Generate Metrics Configuration Management** [permissions](../management/role-list.md) can create and edit **Generate Metrics**;
    - After metrics are generated, they will be stored according to the default [data storage policy](../billing-method/data-storage.md), and charges will be applied based on the number of [Time Series](../billing-method/billing-item.md#exapmle);
    - If no data is reported during the period after metrics generation, it will not be queryable or analyzable in the workspace, such as in **Metrics Analysis**, **Charts**, or **Query Tools**.

## Create/New Clone Rule {#new}

Navigate to the **Logs > Generate Metrics** page,

- Click the **New Rule** button to start creating a new generate metrics rule;

- Click the :octicons-copy-24: icon to clone an existing rule and create a new one.

![](img/2.log_metrics_1.1.png)

**Step 1**: Data Source: Filter all [index](./multi-index/index.md) data available in the current space;

**Step 2:** Data Query: Based on the selected index data, you can filter all/single log data sources available in the current space to generate new data by adding filtering and aggregation expressions to the existing data, thereby generating new metric results and data sets;

- Log Source: This refers to the log data source that has been enabled for collection.

    - **Note**: “ * ” indicates all data sources;

- Search: Supports filtering log data using keywords;

- Filtering: Supports adding one/multiple filtering conditions to existing tag data and adding "AND" or "OR" relationships to the same row of filtering conditions;

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

- Dimensions: Aggregate data according to the selected objects, i.e., generate a statistical value for each selected object in the data request

**Step 3:** Generate Metrics: Set up the method and results of generating metrics, including the frequency of generation, the label name of the newly generated metrics, and the Mearsurement name;

| Field | Description |
| --- | --- |
| Frequency | The execution cycle for generating metrics, <u>default 1 minute</u>, i.e., new metrics data is generated every 1 minute;<br/><u>options include 5 minutes, 15 minutes</u>;<br/>The selected frequency also serves as the aggregation time; if you choose a frequency of 1 minute, then metrics are aggregated and generated every 1 minute, with each aggregation covering a 1-minute time range.<br/>:warning: If there is more than 1 minute of data delay, the data will not be counted once it is stored in the database. |
| Time Range | Based on the selected frequency as the time interval, the chart's default query is 6 hours, i.e., the effect displayed is the statistics of data within 6 hours; when the frequency is modified to >= 1 hour, the query time range is fixed at 7 days. |
| Mearsurement | Set the name of the Mearsurement where the metrics will be stored. |
| Metrics | Set the name of the metrics, which cannot be duplicated, and multiple metrics can be added. |
| Labels | Automatically generated based on the dimensions selected in the query. |
| Unit | Optional, set the unit of the metrics; setting units for generated metrics allows them to be applied in chart queries. |
| Description | Optional, set the description of the metrics; setting descriptions for generated metrics allows them to be applied in chart queries. |


**Step 4:** After completing the creation of the rule, click **Confirm** to complete the generation of the metrics rule and start data collection.

## Operation Instructions

All added rules are displayed on the **Generate Metrics** interface, where users can perform the following operations:

![](img/2.log_metrics_2.png)

### Edit Rule

On the **Generate Metrics** page, you can view all created generate metrics rules and edit the generate metrics rules.

**Note**: Since the data source and aggregation expressions of the generate metrics rules determine the data type, some rules do not support editing and modification.

![](img/2.log_metrics_3.1.png)

### Enable/Disable Rule

On the **Generate Metrics** page, you can modify the status of the rules. When a metrics generation rule is disabled, the corresponding data will not be written into the Mearsurement, and it will resume writing upon re-enabling.

### Delete Rule

On the **Generate Metrics** page, unnecessary rules can be deleted. After deletion, the Mearsurement will not be deleted, but data writing will stop.

### Batch Operations {#batch}

You can perform batch operations on specific rules, including enabling, disabling, and deleting rules.

### View Metrics

#### View in Metrics Analysis

On the **Generate Metrics** page, click the **Open in Metrics Analysis** button next to the rule to navigate to the **Metrics Analysis** page for querying and analysis.

**Note**: Metrics are generated based on the frequency you select and the data within the query time range. If no data is reported during this period, metrics cannot be generated and cannot be queried or searched in **Metrics**.

![](img/2.log_metrics_4.png)


#### View in Metrics Management

On the **Generate Metrics** page, click the **Open in Metrics Management** button next to the rule to navigate to the **Metrics Management** page to view metrics and labels. You can edit the unit and description of the metrics.

![](img/2.log_metrics_5.png)

## More Use Cases

### Application in Chart Queries

After metrics are generated, you can use them in **Scenes > Dashboards > New Dashboard**, performing metrics data queries and analysis in [Visual Charts](../scene/visual-chart/chart-query.md).

![](img/2.log_metrics_7.png)

### Application in DQL Query Tool

After metrics are generated, you can use them in **Shortcuts > [Query Tool](../dql/query.md) > DQL Query** for metrics data queries and analysis.

![](img/2.log_metrics_6.png)