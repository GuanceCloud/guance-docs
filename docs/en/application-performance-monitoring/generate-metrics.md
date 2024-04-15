# Generate Metrics
---

Guance supports generating new metric data based on the existing data in the current space, enabling you to design and implement new technical metrics according to your needs.

???+ warning

    - The role with **Generate Metrics Configuration Management** [Permission](../management/role-list.md) can create and edit the generation of metrics;
    - After the metric is generated, it will be stored according to the current default [Data Storage Policy](../billing/billing-method/data-storage.md), and charged according to the number of [Timeline](../billing/billing-method/index.md#time-example);
    - After the metric is generated, if there is no data reported in the meantime, it cannot be queried and analyzed in the workspace, such as in **Metric Analysis**, **Charts**, **DQL Query Tool**.

## Create/Clone Rules

Enter the **APM > Generate Metrics** page,

- Click **Create** to start creating a new generated metric rule;
- Click the :octicons-copy-24: icon to clone an existing rule to create a new rule.

![](img/3.apm_metrics_3.png)

**Step 1**: Data Source. Filter out the entire/single service data source already available in the current space, and start generating new data based on this data source.

- Source: Data source, that is, the service data source that has been enabled for collection. **Note: "*" means all data sources.**

**Step 2:** Data Query. Based on the selected data source, you can add filtering and aggregation expressions to the existing data, and request the generation of new metric results and data sets.

- Aggregation method: see the table below:

| Method | Description |
| --- | --- |
| count | Count |
| avg | Average, need to choose the field to aggregate |
| max | Maximum, need to choose the field to aggregate |
| min | Minimum, need to choose the field to aggregate |
| P75 | 75% of the specified field, need to choose the field to aggregate |
| P95 | 95% of the specified field, need to choose the field to aggregate |
| P99 | 99% of the specified field, need to choose the field to aggregate |

- Dimension: Aggregate data according to the selected object, that is, generate a statistical value for each selected object in the data request;
- Filter: Support adding one/multiple filter conditions to the existing label data, and adding **and** & **or** relationships to the same row of filter conditions.

**Step 3:** Generate Metrics. Set the method and result of generating metrics, including the cycle of generating metrics, the label name of the newly generated metric, and the name of the measurement.

| Field | Description |
| --- | --- |
| Frequency | The execution cycle of generating metrics, default is 1 minute, that is, generate new metric data every 1 minute; the frequency selected time also serves as the aggregation time. If the frequency is 1 minute, it means that an metric is generated every 1 minute, and the time range of each aggregation is also 1 minute. |
| Measurement | Set the name of the measurement where the metric is stored. |
| Metric | Set the name of the metric, where the name of the metric is not allowed to repeat, multiple metrics can be added. |
| Label | Generated automatically based on the dimensions selected in the query. |
| Unit | Optional, set the unit of the metric, after setting the unit of the generated metric, it can be applied in the chart query. |
| Description | Optional, set the description of the metric, after setting the description of the generated metric, it can be applied in the chart query. |

**Step 4:** After completing the rule, click **Confirm** to complete the rule for generating metrics and start data collection.

## Options

All added rules will be displayed on the **Generate Metrics** interface, and users can perform the following options:

![](img/3.apm_metrics_1.gif)


**Notes:**

1. Since the data source, aggregation expressions, etc., of the rule for generating metrics determine the data type, some rules do not support editing and modification.
    
2. After the rule for generating metrics is disabled, the corresponding data will not be written into the measurement, and writing will resume after it is enabled.

3. After the rule is deleted, the measurement will not be deleted, but data writing will stop.


### View Metrics

#### View in Metric Analysis

On the **Generate Metrics** page, click the **Open in Metric Analysis** button on the right side of the rule to jump to the **Metric Analysis** page for query and analysis.

**Note:** The generation of metrics is based on the frequency you choose, and the data within the query time range is aggregated to generate metrics. If there is no data reported during this period, metrics cannot be generated and cannot be queried or searched in **Metrics**.

![](img/3.apm_metrics_4.png)

#### View in Metric Management

On the **Generate Metrics** page, click the **Open in Metric Management** button on the right side of the rule to jump to the **Metric Management** page to view metrics and labels, and to edit the unit and description of the metric.

![](img/3.apm_metrics_5.png)

## Use Cases

### Chart Query

After the metric is generated, you can go to **Scenes > Dashboard > Create**, and query and analyze metric data in [Visual Charts](../scene/visual-chart/chart-query.md).

![](img/3.apm_metrics_7.png)

### DQL Query Tool

After the metric is generated, you can query and analyze metric data in **Quick Entry > [Query Tool](../dql/query.md)**.

![](img/3.apm_metrics_6.png)

