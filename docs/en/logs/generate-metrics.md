# Generate Metrics
---

<<< custom_key.brand_name >>> supports generating new metric data based on existing data within the current workspace, allowing you to design and implement new technical metrics according to your needs.

???+ warning 

    - Roles with **Generate Metrics Configuration Management** [permissions](../management/role-list.md) can create and edit **Generate Metrics**;  
    - After metrics are generated, they will be stored according to the current default [data storage policy](../billing-method/data-storage.md), and charges will be applied based on the number of [time series](../billing-method/billing-item.md#exapmle);  
    - After metrics are generated, if no data is reported during this period, they cannot be queried or analyzed in the workspace, such as in **Metrics Analysis**, **Charts**, or **Query Tools**.

## Create/Clone Rule {#new}

Navigate to the **Logs > Generate Metrics** page,

- Click the **Create Rule** button to start creating a new generate metrics rule;

- Click the :octicons-copy-24: icon to clone an existing rule and create a new rule.

![](img/2.log_metrics_1.1.png)

**Step 1**: Data Source: Filter all [indices](./multi-index/index.md) data available in the current workspace;  

**Step 2:** Data Query: Based on the selected index data, you can filter all or individual log data sources in the current workspace to generate new data by adding filters and aggregation expressions to the existing data, resulting in new metric results and data sets;

- Log Source: Refers to log data sources that have enabled collection.

    - **Note**: “ * ” indicates all data sources;

- Search: Supports filtering log data using keywords;

- Filters: Supports adding one or more filter conditions to existing tag data and adding "AND" or "OR" relationships to the same row of filter conditions;

- Aggregation Methods: See table below:

| Aggregation Method | Description |
| --- | --- |
| count | Count occurrences |
| avg | Calculate average value, requires selecting a field for aggregation |
| max | Find maximum value, requires selecting a field for aggregation |
| min | Find minimum value, requires selecting a field for aggregation |
| P75 | Calculate the 75th percentile value of the specified field, requires selecting a field for aggregation |
| P95 | Calculate the 95th percentile value of the specified field, requires selecting a field for aggregation |
| P99 | Calculate the 99th percentile value of the specified field, requires selecting a field for aggregation |

- Dimensions: Aggregate data based on the selected objects, i.e., generate a statistical value for each selected object in the data request

**Step 3:** Generate Metrics: Set up the method and results for generating metrics, including the frequency of generation, the label name for newly generated metrics, and the measurement set name;

| Field | Description |
| --- | --- |
| Frequency | The execution interval for generating metrics, <u>default is 1 minute</u>, i.e., new metric data is generated every 1 minute;<br/><u>options include 5 minutes, 15 minutes</u>;<br/>The selected frequency also serves as the aggregation time, choosing a frequency of 1 minute means aggregating and generating metrics every 1 minute, with each aggregation covering a 1-minute time range.<br/>:warning: If data has a delay of more than 1 minute, it will not be counted after being written to the database. |
| Time Range | Based on the selected frequency as the time interval, the chart defaults to querying 6 hours, i.e., displaying the effect of data statistics within 6 hours; when the frequency is modified to >= 1 hour, the query time range is fixed at 7 days. |
| Measurement Set | Set the name of the measurement set where the metrics will be stored. |
| Metric | Set the name of the metric, metric names must be unique, multiple metrics can be added. |
| Tags | Automatically generated based on dimensions selected in the query. |
| Unit | Optional, set the unit for the metric, which can then be used in chart queries. |
| Description | Optional, set a description for the metric, which can then be used in chart queries. |


**Step 4:** After completing the generation rule form, click **Confirm** to complete the creation of the metric generation rule and start data collection.

## Operation Instructions

All added rules are displayed on the **Generate Metrics** page, where users can perform the following operations:

![](img/2.log_metrics_2.png)

### Edit Rule

On the **Generate Metrics** page, you can view all created metric generation rules and edit them.

**Note**: Since the data source and aggregation expressions of the metric generation rules determine the data type, some rules do not support editing or modification.

![](img/2.log_metrics_3.1.png)

### Enable/Disable Rule

On the **Generate Metrics** page, you can modify the status of the rules. When a metric generation rule is disabled, corresponding data will not be written to the measurement set until it is re-enabled.

### Delete Rule

On the **Generate Metrics** page, unnecessary rules can be deleted. Deleting a rule stops data from being written to the measurement set but does not delete the measurement set itself.

### Batch Operations {#batch}

You can perform batch operations on specific rules, including enabling, disabling, and deleting rules.

### View Metrics

#### View in Metrics Analysis

On the **Generate Metrics** page, click the **Open in Metrics Analysis** button next to the rule to navigate to the **Metrics Analysis** page for querying and analyzing the metrics.

**Note**: Metrics are generated based on the selected frequency and the data aggregated within the query time range. If no data is reported during this period, metrics cannot be generated and will not appear in **Metrics** queries or searches.

![](img/2.log_metrics_4.png)


#### View in Metrics Management

On the **Generate Metrics** page, click the **Open in Metrics Management** button next to the rule to navigate to the **Metrics Management** page to view metrics and tags. You can edit the units and descriptions of the metrics here.

![](img/2.log_metrics_5.png)

## More Use Cases

### Apply in Chart Queries

After metrics are generated, you can use them in **Scenes > Dashboard > Create Dashboard**, in [Visual Charts](../scene/visual-chart/chart-query.md) for querying and analyzing metric data.

![](img/2.log_metrics_7.png)

### Apply in DQL Query Tool

After metrics are generated, you can use them in **Shortcuts > [Query Tool](../dql/query.md) > DQL Query** for querying and analyzing metric data.

![](img/2.log_metrics_6.png)