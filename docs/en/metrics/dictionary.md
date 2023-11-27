# Metric Management
---


After completing the metric data collection, you can view all reported measurements and related metrics, labels, timeseries numbers and data storage policies in the **Metric Management** of Guance workspace.

## Measurements

A measurement is a set of metrics of the same type, and a measurement can contain multiple metrics and labels. Click Measurement, and you can view all available metrics and labels under the measurement on the details page. Fuzzy search is supported to query measurements.

![](img/11.metrics_3.png)



### Metrics

Metrics can help you understand the overall availability of the system, such as server CPU usage, Web site load time and remaining disk space.

Metrics are divided into two parts: metric name and metric value. Metric name refers to an alias that identifies the metrics, and metric value refers to the specific value of the metrics when collecting. In **Metric Management** of the Guance workspace, click **Measurement Name** to view the corresponding metric list, including metric name, metric field type, unit, etc.

- By :octicons-search-24:, search for related metrics based on keywords.
- By :material-export-variant:, export metric list as CSV file to local.

<img src="../img/1.metrics_2.png" width="70%" >

#### Editing

In **Metric Management**, you can view all metrics reported to Guance, including metric name, field type, company and description, and customize the **Unit** and **Description** of metrics. After saving, you can apply them in chart query.

![](img/1.metrics_3.png)

???+ warning

    - Metric details can only be edited by standard members and above.
    - The priority of **Unit** and **Description** added in **Metric Management** is higher than the data collected by default. For example, **Unit** is changed from `B` to `GB`, and the unit on the chart would be converted to `GB` for data display when the scene is queried for charts.

#### Use Case

When you query metrics, you can query and analyze data more conveniently by viewing the metric name, field type, unit and description. For example, when you query charts in scenes, you can view the detailed information of metrics in real time when you detect metrics in monitors.

<img src="../img/11.metrics_6.png" width="70%" >

### Label

Label can help you associate data, and Guance supports reporting all metrics, logs and link data to the workspace in a unified way. By labeling the collected data with the same labels for association analysis, it can help you quickly discover and solve potential risks.

Labels refer to the collection of attributes that identify the collection object of a data point. Labels are divided into tag name and tag value, and a data point can have multiple tags. In the **Metric Management** of the Guance workspace, click **Measurement Name** to view the corresponding tag list, including tag name, tag value statistics, description, etc.

- By :octicons-search-24:, search for related metrics based on keywords.
- By :material-export-variant:, export metric list as CSV file to local.

<img src="../img/1.tag_1.png" width="70%" >

#### Use Case

In the metric query, you can quickly understand the meaning of the tag by viewing the description of the tag. For example, in the part of the chart query in the scene and the metric detection in the monitor, you can view the description information of the tag in real time. Guance provides system field/tag descriptions by default, and you can replace system field or tag descriptions in [field management](../management/field-management.md).

<img src="../img/11.metrics_7.png" width="70%" >

## Timeseries

The number of all combinations that can be combined based on tags in the reported metric data in the current workspace. In Guance, the timeseries is composed of metrics, tags (fields) and data storage duration, and the combination of metrics and tags (fields) is the primary key of data storage. Relevant nouns are explained as follows:

| Nouns      | Description                          |
| ----------- | ------------------------------------ |
| Database       | database  |
| Measurement      | data table, which can be understood as table and measurement in mysql |
| Field    | key-value pairs that record real data in Influxdb (required in Influxdb and not indexed), metrics |
| Field Set      | a collection of Field key-value pairs                       |
| Field Key      | the keys that make up the Field Key-value pair                       |
| Field Value      | the value (real data) that makes up the Field key-value pair                          |
| Tag      | key-value pair used to describe Field (optional in Influxdb and indexed); tag                          |
| Tag Set      | a collection of Tag key-value pairs                          |
| Tag Key      | the key that makes up the Tag Key-value pair                      |
| Tag Value      | the value that makes up the Tag key-value pair                       |
| TimeStamp      | the date and time associated with the data point                          |
| Retention Policy      | data storage time (data preservation policy)                         |
| Series      | the timeseries consists of Retention Policy, Measurement and Tag Set                         |


## Metric Storage Policy {#storage}

There are two kinds of metric storage policies, one is the big-picture setting for metric workspace level, and the other is the custom setting for metrics set.

???+ warning

    - The priority of the user-defined setting of the measurement is higher than the big-picture setting of the measurement. That is, after the user-defined setting of the data storage policy of the measurement, the big-picture setting of the metric is changed without affecting the data storage policy of the metrics set.

    - Once the measurement data saving policy is modified in Metric Management, the corresponding measurement data saved in the workspace big-picture policy would be deleted and cannot be recovered, so please operate carefully; If you modify the measurement data saving policy again in Metric Management, the measurement data under the previous policy would also be deleted.
    - After the measurement data storage policy is modified in Metric Management, the data of measurement would be stored separately. If the measurement data saving polic duration is modified in the Workspace Management, the storage policy duration of measurement would not be changed.
    - After the measurement data storage policy is modified in Metric Management, the measurement is changed back to the big-picture default index data storage policy duration and is re-stored in the whole database. At this time, if the big-picture data storage policy duration of the workspace metric is modified again, the measurement storage policy duration is changed at the same time.
    - After the measurement data storage policy is modified in Metric Management, the duration of modifying the global data storage policy of the workspace metric is the same as that of the measurement, and the measurement data would still be saved separately instead of being stored in the global database.

### Metric Global Setting

In the **Management > Settings > Risky Operations** of the Guance workspace, you can view the global data storage policy of the metric workspace. The default metric data is 7 days, including 3 days, 7 days, 14 days, 30 days, 180 days and 360 days.

> For more details, see [Data Storage Policy](../billing/billing-method/data-storage.md)。

<img src="../img/2.data_storage_3.png" width="70%" >

### Custom Settings of Measurement

In **Metric Management**, you can view and customize data storage policies for measurements.

**Note**: Measurement storage policy can only be configured by the owner, and the free plan does not support measurement custom data storage policy.


Click the button under **Operate** to customize the data saving policy of the measurement, including 3 days, 7 days, 14 days, 30 days, 180 days and 360 days, which is consistent with the global data saving policy of the metrics by default.

![](img/19.metrics_6.png)

After modifying the duration of the measurement data saving policy, the measurement data under the previous policy would also be deleted and cannot be recovered.

![](img/19.metrics_7.png)

