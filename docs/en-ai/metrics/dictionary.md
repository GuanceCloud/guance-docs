# Metrics Management
---

After completing the collection of metrics data, you can view all reported Mearsurement and related Metrics, labels, Time Series quantities, data storage policies, etc., in the **Metrics Management** section of the Guance workspace.

## Mearsurement

Mearsurement refers to <u>a collection of metrics of the same type; a Mearsurement can contain multiple Metrics and labels</u>. By clicking on a Mearsurement, you can view all available Metrics and labels under that Mearsurement on the details page. It supports fuzzy search for querying Mearsurement.

![](img/11.metrics_3.png)

### Metrics

Metrics help you understand the overall availability of the system, such as server CPU usage, website loading time, remaining disk space, etc.

Metrics consist of two parts: <u>Metric names and Metric values</u>. A Metric name is an alias for the Metric, while the Metric value is the specific numerical value collected at the time of collection. In the **Metrics Management** of the Guance workspace, by clicking on the **Mearsurement name**, you can view the corresponding list of Metrics, including Metric names, field types, units, etc.

- Use :octicons-search-24: to search for related Metrics based on keywords;
- Use :material-export-variant: to export the Metrics list as a CSV file to your local machine.

<img src="../img/1.metrics_2.png" width="70%" >

#### Editing Metrics

In **Metrics Management**, you can view all Metrics reported to Guance, including Metric names, field types, units, and descriptions, and customize edit the **units** and **descriptions** of Metrics. After saving, these changes will be applied in chart queries.

![](img/1.metrics_3.png)

???+ warning "Permissions and Priority"

    - Only standard members and above have permission to edit Metric details;
    - Custom-added **units** and **descriptions** in **Metrics Management** have higher priority than default collected data. For example, if the **unit** is changed from `B` to `GB`, the unit on the chart will display as `GB` during chart queries.

#### Application Scenarios

When querying Metrics, you can more easily perform data queries and analysis by viewing the Metric names, field types, units, and descriptions. For example, when performing chart queries or detecting Metrics in monitors, you can view detailed information about Metrics in real-time.

<img src="../img/11.metrics_6.png" width="70%" >

### Labels

Labels help you correlate data. Guance supports unifying all Metrics, logs, and trace data reported to the workspace and associating them through common labels for analysis, helping you quickly identify and resolve potential risks.

Labels are a collection of attributes describing the object from which data points are collected. Labels consist of label names and label values, and a data point can have multiple labels. In the **Metrics Management** of the Guance workspace, by clicking on the **Mearsurement name**, you can view the corresponding list of labels, including label names, statistical counts of label values, descriptions, etc.

- Use :octicons-search-24: to search for related labels based on keywords;
- Use :material-export-variant: to export the label list as a CSV file to your local machine.

<img src="../img/1.tag_1.png" width="70%" >

#### Application Scenarios

When querying Metrics, you can quickly understand the meaning of labels by viewing their descriptions. For example, when performing chart queries or detecting Metrics in monitors, you can view label description information in real-time. Guance provides default system fields/label explanations, which you can replace in [Field Management](../management/field-management.md).

<img src="../img/11.metrics_7.png" width="70%" >

## Time Series

The number of all possible combinations based on labels in the current workspace's reported Metrics data. In Guance, Time Series are composed of Metrics, tags (fields), and data retention periods, with "Metrics" and "tags (fields)" forming the primary key for data storage.

Definitions of related terms:

| Term          | Description                                      |
| --------------- | ---------------------------------------------------- |
| Database       | Database.  |
| Measurement      | Mearsurement, which can be understood as a table in MySQL. |
| Field    | Metric, a key-value pair recording actual data in InfluxDB (required in InfluxDB and not indexed).|
| Field Set      | Collection of Field key-value pairs.                          |
| Field Key      | The key in the Field key-value pair.                          |
| Field Value      | The value in the Field key-value pair (the actual data).                          |
| Tag      | Label, a key-value pair describing the Field (optional in InfluxDB and indexed).                          |
| Tag Set      | Collection of Tag key-value pairs.                          |
| Tag Key      | The key in the Tag key-value pair.                          |
| Tag Value      | The value in the Tag key-value pair.                          |
| TimeStamp      | Date and time associated with the data point.                          |
| Retention Policy      | Data retention period (data retention policy).                          |
| Series      | Time Series composed of Retention Policy, Measurement, and Tag Set.                          |

## Metrics Storage Policies {#storage}

Metrics storage policies are divided into two types: one is a <u>global setting at the Metrics workspace level</u>, and the other is a <u>custom setting for individual Mearsurements</u>.

???+ warning "Precautions after Modification"

    - Custom settings for Mearsurements take precedence over global settings. Changing the global settings does not affect the data retention policy of Mearsurements with custom settings;
    - Once the data retention policy of a Mearsurement is modified in Metrics Management, the corresponding data in the workspace's global policy will be deleted and cannot be recovered. Please proceed with caution; modifying the data retention policy of a Mearsurement again will also delete previously stored data under the previous policy;
    - After modifying the data retention policy of a Mearsurement in Metrics Management, the data of that Mearsurement will be stored separately. Changing the global data retention policy duration in Workspace Management will not change the storage policy duration of that Mearsurement;
    - After modifying the data retention policy of a Mearsurement in Metrics Management and reverting it to the global default data retention policy duration, the Mearsurement will be re-stored in the global database. Changing the global data retention policy duration in Workspace Management will simultaneously change the storage policy duration of that Mearsurement;
    - After modifying the data retention policy of a Mearsurement in Metrics Management, even if the global data retention policy duration and the Mearsurement's storage policy duration are consistent, the data of that Mearsurement will still be stored separately and will not be re-stored in the global database.

### Global Settings for Metrics

In the Guance workspace **Management > Settings > Risky Operations**, you can view the global data retention policy for the Metrics workspace. The default data retention period for Metrics is 7 days, including options for 3 days, 7 days, 14 days, 30 days, 180 days, and 360 days.

> For more details, refer to [Data Storage Policies](../billing-method/data-storage.md).

<img src="../img/2.data_storage_3.png" width="70%" >

### Custom Settings for Mearsurements

In Metrics Management, you can view and customize the data retention policy for individual Mearsurements.

**Note**: Only owners can configure the storage policy for Mearsurements, and the Free Plan does not support custom data retention policies for Mearsurements.

Click the settings button under **Action** to customize the data retention policy for a Mearsurement, including options for 3 days, 7 days, 14 days, 30 days, 180 days, and 360 days. By default, it aligns with the global data retention policy for Metrics.

![](img/19.metrics_6.png)

???+ abstract "For Deployment Plan"

    Workspace owners can configure the data retention policy for Mearsurements and support custom input for retention periods (range: 1~1800).

    <img src="../img/deploy-metric.png" width="60%" >

After modifying the data retention policy duration for a Mearsurement, previously stored data under the old policy will also be deleted and cannot be recovered.

![](img/19.metrics_7.png)