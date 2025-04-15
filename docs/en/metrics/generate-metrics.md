# Generate Metrics
---

This involves generating new metric data from existing data within the current workspace, thereby designing and implementing new technical metrics according to actual business needs.

???+ warning "Note"

    - Only roles with "Generate Metric Configuration Management Permissions" can create and edit metrics;
    - After metrics are generated, they will be stored according to the current default data storage strategy, and charges will apply based on the number of generated time series;
    - If no data is reported after generating the metric, it cannot be queried or analyzed within the workspace.

## Use Cases

LOG, APM, RUM, Metrics, Security Check.

## Create

1. Select data source;
2. Configure [data query](#query) conditions;
3. Define [generate metric content](#content), set up the method and results for generating metrics, including the period of metric generation, the label names of newly generated metrics, and the name of the metric set.

### Data Query {#query}

Metric data additionally supports PromQL queries. Besides that, both simple queries and DQL queries are supported.

> For more details, refer to [Chart Query](../scene/visual-chart/chart-query.md).

#### Data Source


| Source | Description |
| --- | --- |
| LOG | That is, all index data already present in the current workspace. Based on these index data, you can select all or a single log data source in the current space to generate a new data collection. By adding filtering conditions and aggregation expressions to existing data, request the generation of new metric results and data collections. Here, `*` indicates selecting all data sources. |
| APM | Refers to service data sources where collection has been enabled. Here, `*` indicates selecting all data sources. |
| RUM | Application data sources in the current workspace, i.e., application names for which collection has been enabled. Here, `*` indicates selecting all data sources. |
| Metrics | All metric data in the current workspace. |
| Security Check | All/specific category data sources already present in the current workspace. After enabling the security check collector, categories include `network`, `storage`, `database`, `system`, `webserver`, `Kubernetes`. Here, `*` indicates selecting all data sources. |

#### Aggregation Functions

| Function | Description |
| --- | --- |
| `count` | Count statistics |
| `avg` | Average value statistics, requires selecting an aggregated field |
| `max` | Maximum value statistics, requires selecting an aggregated field |
| `min` | Minimum value statistics, requires selecting an aggregated field |
| `P75` | Statistics for 75% of the specified field values, requires selecting an aggregated field |
| `P95` | Statistics for 95% of the specified field values, requires selecting an aggregated field |
| `P99` | Statistics for 99% of the specified field values, requires selecting an aggregated field |

#### Dimensions

Aggregate data based on selected objects, meaning a statistical value is generated for each selected object in the data request.

### Generate Metric Content {#content}

1. Frequency: The execution cycle for generating metrics. The selected frequency also serves as the aggregation time; selecting a frequency of 1 minute means aggregating and generating metrics every 1 minute, with each aggregation covering a time range of 1 minute.

    - 1 minute (default), i.e., generating new metric data every 1 minute;
    - 5 minutes
    - 15 minutes

2. Metric Set: Set the name of the metric set where the metric will be stored.

3. Metrics: Set the name of the metric, where metric names must not repeat, and multiple metrics can be added.

4. Tags: Automatically generated based on dimensions selected in the query.

5. Unit: Optional, set the unit of the metric. After setting the unit for the generated metric, it can be applied in chart queries.

6. Description: Optional, set the description of the metric. After setting the description for the generated metric, it can be applied in chart queries.

After completing the fields, click **Confirm** to complete the generation of the metric rule and start data collection.

???+ warning "Note"

    If there is a delay of over 1 minute in the data, then the data will not be included in the statistics once it is written into the database.



## Manage Rules {#manage}

- Edit: View all created metric generation rules and edit them.

- Enable/Disable: Modify the status of the rule. When a metric generation rule is disabled, the corresponding data will not be written into the metric set, resuming writes upon re-enabling.

- Delete: Delete unnecessary rules. After deleting a rule, the metric set will not be deleted, but data writing will stop.

- Batch Operations: Perform batch operations on specific rules, including enabling, disabling, deleting, and exporting rules.

- Import: Import generated metric data.

- View Metrics

    - View in Metric Analysis: Navigate to the **Metric Analysis** page for querying and analyzing.
    
    - View in Metric Management: Navigate to the **Metric Management** page to view metrics and tags. You can edit the units and descriptions of metrics.

???+ warning "Note"

    - Since the data source, aggregation expression, etc., of generated metric rules determine the data type, some configurations do not support editing and modification;
    - Generated metrics are based on data aggregated at the selected frequency and query time range. If no data is reported during this period, metrics cannot be generated, nor can they be queried or searched within the metrics.

## Use Cases

### Chart Query

Perform metric data queries and analysis in [Visual Charts](../scene/visual-chart/chart-query.md).

![](img/generate_metrics.png)

### Query Tool

Perform metric data queries and analysis in **Shortcut > [Query Tool](../dql/query.md) > DQL Query**.

![](img/generate_metrics_1.png)