# Generate Metrics
---


Guance supports the generation of new metric data based on existing data in the current space, so that you can design and implement new technical metrics according to your needs.

???+ warning 

    - Roles with the generate metrics configuration operation [permission](../management/role-list.md) can create and edit generated metrics;  
    - After metrics are generated, they will be stored according to the current default [data storage strategy](../billing/billing-method/data-storage.md), and charges will be based on the generated [timeline count](../billing/billing-method/billing-item.md#exapmle);   
    - If no data is reported during the period after metrics are generated, it will not be possible to query and analyze the metrics in the workspace, such as in **Metrics Analysis**, **Charts**, and **Query Tools**.	

## Create Rules

Enter the **Log > Generate Metrics** page, and click **Create** to start creating a new generation metric rule.

![](img/log-metrics-en-1.png)

**Step 1**: Data Source: Filter all existing [index](./multi-index.md) data in the current space.

**Step 2**: Data query. Based on the selected data source, you can add filter and aggregate expressions to existing data, requesting new metric results and data sets.

- Source: Data source, that is, the log data source that has been collected. 

    - **Note**: "*" denotes all data sources.

- Filter: Support adding one or multiple filtering conditions to the existing tag data, and adding "AND" or "OR" relationships to the same line of filtering conditions.

- Aggregation method: See the table below:

| Aggregation Method | Description |
| --- | --- |
| count | Number of statistics |
| avg | Average statistics, you need to select aggregated fields. |
| max | To count the maximum value, you need to select the aggregated fields. |
| min | To count the minimum value, you need to select the aggregated field. |
| P75 | Count 75% of the values of the specified fields, and the aggregated fields need to be selected. |
| P95 | Count 95% of the values of the specified fields, and the aggregated fields need to be selected. |
| P99 | Count 799% of the values of the specified fields, and the aggregated fields need to be selected. |

- Dimensions: Data aggregation by selected objects, that is, a statistical value is generated for each selected object in the data request

**Step 3:** Generate metrics. Set the way and result of generating metrics, including the period of generating metrics, the label name of newly generated metrics and the measurement name.

| Fields | Description |
| --- | --- |
| Frequency | The execution cycle for generating metrics is <u>defaulted to 1 minute</u>, meaning that new metric data is generated every 1 minute.<br/><u>Optional choices are 5 minutes and 15 minutes</u>.<br/>The selected frequency is also used as the aggregation time. If the frequency is set to 1 minute, metrics will be aggregated and generated every 1 minute, and the time range for each aggregation will also be 1 minute.<br/>:warning: If there is a delay of more than 1 minute in the data, it will not be included in the statistics after being stored in the database. |
| Time range | Based on the selected frequency as the time interval, the default query of the chart is 6 hours, that is, the statistical display effect of a certain data within 6 hours; When the modification frequency is more than 1 hour, the query time range is fixed at 7 days. |
| Measurement | Set the name of the measurement where the metric is stored. |
| Metric | Set the name of the metric. Metric names cannot be duplicated. Multiple metrics can be added. |
| Label | Automatically generated based on the selected dimensions in the query. |
| Unit | Optional, set the unit of measurement for the metric. Once the unit is set for the generated metrics, it can be applied in chart queries. |
| Description | Optional, set the description of the metric. Once the description of the metric is set, it can be applied in chart queries. |


**Step 4:** After completing the generation rule, click **Confirm** to complete the generation of metric rules and start data collection.


![](img/log-metrics-en-2.png)

## Operation Instructions

All added rules are displayed in the **Generated Metrics** page, and users can perform the following operations:

![](img/2.log_metrics_2.png)

### Edit Rules

On the **Generate Metric** page, you can view all generated metric rules that have been created and edit them.

**Note**: As the data source and aggregate expression of generating metric rules determine the data type, some rules do not support editing and modification.

![](img/log-metrics-en-3.png)

### Enable/Disable Rules

On the **Generate Metric** page, you can modify the rule status. After the metric generation rule is disabled, the corresponding data will not be written to the measurement, and the writing will resume after it is enabled.

### Delete Rule

On the **Generate Metric** page, unnecessary rules can be deleted. After the rules are deleted, the measurement will not be deleted, but data writing will stop.

### View Metrics

#### View in Metric Analysis

On the **Generate Metric** page, click the **Open in Metrics Analysis** button on the right side of the rule to jump to the Metrics Analysis page for query and analysis.

**Note**: Metrics generation is based on data aggregation within the selected frequency and query time range. If no data is submitted during the period, metrics cannot be generated, and query or search in metric cannot be performed.

![](img/log-metrics-en-4.png)

​	

#### View in Metric Management

On the **Generate Metric** page, click the **Open in Metric Management** button on the right side of the rule to jump to the **Metric Management** page to view metrics and tags, and support editing metric units and descriptions.

![](img/log-metrics-en-5.png)
