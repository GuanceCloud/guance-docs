# Generate Metrics
---

This involves generating new metric data from existing data within the current workspace, thereby designing and implementing new technical metrics according to actual business needs.

**Note**:

- Only users with "Generate Metrics Configuration Management Permissions" can create and edit metrics;
- After metrics are generated, they will be stored according to the current default data retention policy, and charges will be based on the number of generated time series;
- If no data is reported after generating metrics, it cannot be queried or analyzed within the workspace.

## Use Cases

Logs, APM, RUM, Metrics, and Security Check.

## Create

1. Select data source;
2. Configure [data query](#query) conditions;
3. Define [generated metric content](#content), setting up how and what results the generated metrics should have, including the generation frequency, label names for newly generated metrics, and measurement set names.

### Data Query {#query}

Metric data supports PromQL queries in addition to simple and DQL queries.

> For more details, refer to [Chart Query](../scene/visual-chart/chart-query.md).

:material-numeric-1-circle: Data Source


| Source | Description |
| --- | --- |
| Logs | All indexed data in the current workspace. Based on these indexes, you can select all or specific log data sources within the current space to generate new data sets. By adding filtering conditions and aggregation expressions to existing data, request the generation of new metric results and data sets. The `*` indicates selecting all data sources. |
| APM | Service data sources that have enabled collection. The `*` indicates selecting all data sources. |
| RUM | Application data sources within the current workspace, i.e., applications that have enabled collection. The `*` indicates selecting all data sources. |
| Metrics | All metric data in the current workspace. |
| Security Check | All or specific categories of data sources within the current workspace. After enabling the security check collector, categories include `network`, `storage`, `database`, `system`, `webserver`, `Kubernetes`. The `*` indicates selecting all data sources. |

:material-numeric-2-circle: Aggregation Functions

| Function | Description |
| --- | --- |
| `count` | Count the number of items |
| `avg` | Calculate the average value of a selected field |
| `max` | Find the maximum value of a selected field |
| `min` | Find the minimum value of a selected field |
| `P75` | Calculate the 75th percentile value of a specified field |
| `P95` | Calculate the 95th percentile value of a specified field |
| `P99` | Calculate the 99th percentile value of a specified field |

:material-numeric-3-circle: Dimensions: Aggregate data by the selected objects, generating a statistical value for each selected object in the data request.

### Generated Metric Content {#content}

1. Frequency: The execution cycle for generating metrics. The selected frequency also serves as the aggregation time. Selecting a frequency of 1 minute means aggregating and generating metrics every 1 minute, with each aggregation covering a 1-minute time range.

    - 1 minute (default), i.e., generate new metric data every 1 minute;
    - 5 minutes
    - 15 minutes

2. Measurement Set: Set the name of the measurement set where the metrics will be stored.

3. Metrics: Set the name of the metric, ensuring the metric name is unique. Multiple metrics can be added.

4. Tags: Automatically generated based on the dimensions selected in the query.

5. Unit: Optional, set the unit for the metric. Setting a unit allows its application in chart queries.

6. Description: Optional, set a description for the metric. Setting a description allows its application in chart queries.

After completing the form, click **Confirm** to finalize the metric generation rule and start data collection.

**Note**: If data has a delay of more than 1 minute, it will not be included in the statistics once it is stored in the database.



## Manage Rules {#manage}

- Edit: View and edit all created metric generation rules.

    - **Note**: Since the data source and aggregation expression determine the data type, some configurations cannot be edited or modified.

- Enable/Disable: Modify the rule's status. When a metric generation rule is disabled, corresponding data will not be written to the measurement set until re-enabled.

- Delete: Remove unnecessary rules. Deleting a rule stops data writing but does not delete the measurement set.

- Batch Operations: Perform batch operations on specific rules, including enabling, disabling, deleting, and exporting rules.

- Import: Import generated metric data.

- View Metrics

    - In Metric Analysis: Navigate to the **Metric Analysis** page for querying and analyzing.
    
    - In Metric Management: Navigate to the **Metric Management** page to view metrics and tags. You can edit the metric unit and description here.

    - **Note**: Generated metrics are based on the selected frequency and query time range. If no data is reported within that time frame, metrics will not be generated and cannot be queried or searched.

## Use Cases

### Chart Query

Perform metric data queries and analysis in [Visual Charts](../scene/visual-chart/chart-query.md).

![](img/generate_metrics.png)

### Query Tool

Perform metric data queries and analysis in **Shortcut > [Query Tool](../dql/query.md) > DQL Query**.

![](img/generate_metrics_1.png)