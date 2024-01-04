# Generate Metrics
---

Guance supports generating new metric data based on existing data within the current space, making it easier for you to design and implement new technical metrics according to your needs.

**Note**:

- Roles with the **generating metrics configuration** [permission](../management/role-list.md) can create and edit metric generation.
- After the metrics are generated, they will be stored according to the current default [data storage strategy](../billing/billing-method/data-storage.md) and charged based on the number of [time intervals](../billing/billing-method/index.md#time-example) produced.
- After the metrics are generated, if there is no data reported during the period, they cannot be queried and analyzed in the workspace, such as in **metric Analysis**, **Charts**, and **DQL Query Tool**.

## Setup

Go to **RUM > Generate metrics** page and click on **Create**.

![](img/4.rum_metrics_1.png)

:material-numeric-1-circle: Data Source: Filter out all/single application data sources that already exist in the current workspace and generate new data based on this data source.

- Application: Application data source, which refers to the names of applications with data collection enabled; **" * " represents all data sources**.

:material-numeric-2-circle: Data Query: Based on the selected data source, you can add filtering and aggregation expressions to the existing data to request new metric results and data sets.

- Aggregation Method: See the table below:

| Methods | Description |
| --- | --- |
| count | Count |
| avg | Average; require selecting the field to aggregate |
| max | Maximum value; require selecting the field to aggregate |
| min | Minimum value; require selecting the field to aggregate |
| P75 | 75th percentile value of the specified field; require selecting the field to aggregate |
| P95 | 95th percentile value of the specified field; require selecting the field to aggregate |
| P99 | 99th percentile value of the specified field; require selecting the field to aggregate |

- Dimension: Aggregate the data based on the selected objects, that is, generate a statistical value for each selected object in the data request.

- Filter: Support adding one or multiple filter conditions to the existing tag data and adding **AND** or **OR** relationship to the same row of filter conditions.

:material-numeric-3-circle: Generate metrics: Set the method and results of generating metrics, including the frequency of generating metrics, the name of the newly generated metric label, and the name of the measurement.

| Fields | Description |
| --- | --- |
| Frequency | The execution period of generating metrics, default is 1 minute, which means generating new metric data every 1 minute; the selected frequency is also used as the aggregation time. <br/><br/> *For example, if the frequency is set to 1 minute, metrics will be aggregated and generated every 1 minute, and the time range of each aggregation will also be 1 minute.* |
| Measurement | Set the name of the measurement where the metrics are stored. |
| Metrics| Set the name of the metric and the name must be unique. Multiple metrics can be added. |
| Label | Automatically generated based on the selected dimensions in the query. |
| Unit | Optional. Set the unit of the metric. After the generated metric has a unit set, it can be applied in chart queries. |
| Description | Optional. Set the description of the metric. After the generated metric has a description set, it can be applied in chart queries. |

:material-numeric-4-circle: After completing the filling of the generation rule, click **Confirm** to complete the generation rule and start data collection.

## Options

All added rules will be displayed on the **Generate Metrics** page, and users can perform the following operations:

![](img/4.rum_metrics_2.png)

### Edit

You can view all created generation metric rules and edit them.

**Note**: Since the data source and aggregation expressions of generation metric rules determine the data type, some rules do not support editing and modification.

![](img/4.rum_metrics_3.png)

### Enable/Disable

You can modify the rule status. When an metric generation rule is disabled, the corresponding data will not be written to the measurement. It will resume writing after being enabled.

### Delete

You can delete unnecessary rules. After a rule is deleted, the measurement will not be deleted, but data writing will stop.

### View Metrics

### View in Metric Analysis

Click the **Open in Metric Analysis** button to jump to the corresponding page for querying and analyzing.

![](img/4.rum_metrics_4.png)

### View in Metric Management

Click the **Open in Metric Management** button to jump to the corresponding page to view metrics and labels, and edit the metric unit and description.

![](img/4.rum_metrics_6.png)

## Use Cases

### Apply in Chart Queries

After generating the metrics, you can use them in **Scenes > Dashboards > Create** to query and analyze metric data in [Visual Charts](../scene/visual-chart/chart-query.md).

![](img/4.rum_metrics_7.png)

### Apply in DQL Query Tool

After generating the metrics, you can use them in **Shortcuts > [Query](../dql/query.md)** to query and analyze metric data.

![](img/4.rum_metrics_5.png)