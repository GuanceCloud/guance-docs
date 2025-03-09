# Metrics Management
---

After completing the collection of metrics data, you can view all reported Mearsurement and related Metrics, labels, Time Series quantity, and data storage policies in **Workspace > Metrics Management**.

## Mearsurement

Mearsurement refers to a collection of metrics of the same type. A Mearsurement can contain multiple Metrics and labels. Clicking on a Mearsurement allows you to view all available [Metrics](#metrics) and [labels](#labels) under that Mearsurement on the details page, and you can quickly locate the required content using fuzzy search.

![](img/11.metrics_3.png)

### Metrics {#metrics}

Metrics help you quickly understand the overall operation status of the system, such as server CPU usage, website loading time, remaining disk space, etc.

Metrics consist of **Metric names** and **Metric values**, where the Metric name is an alias for the metric, and the Metric value is the specific numerical value collected. In Workspace > Metrics Management, clicking on the Mearsurement name will display the corresponding list of Metrics, including Metric names, field types, units, and other detailed information.

- Use :octicons-search-24: to search for related Metrics based on keywords;
- Use :material-export-variant: to export the Metrics list as a CSV file to your local machine.
- Click the icon under Actions to perform one-click Metric analysis;
- Click to expand Metric data to edit the Metric configuration.

<img src="../img/1.metrics_2.png" width="70%" >

#### Editing Metrics

In **Metrics Management**, you can view all Metrics reported to <<< custom_key.brand_name >>>, including Metric names, field types, units, and descriptions, and customize the editing of **units** and **descriptions**. After saving, these changes will be applied in chart queries.

![](img/1.metrics_3.png)

???+ warning "Permissions and Priority"

    - Only standard members and above can edit Metric details;
    - Custom-added **units** and **descriptions** in **Metrics Management** have higher priority than default collected data. For example, if the **unit** is changed from `B` to `GB`, the unit displayed in charts during scene queries will be converted to `GB`.

#### Use Cases

When querying Metrics, you can more easily perform data queries and analysis by viewing the Metric names, field types, units, and descriptions. For instance, when performing chart queries or Metric detection in monitors, you can view the detailed information of Metrics in real-time.

<img src="../img/11.metrics_6.png" width="70%" >

### Labels {#labels}

Labels help you correlate data from different sources. <<< custom_key.brand_name >>> supports unified reporting of all Metrics, logs, and trace data to the workspace. By tagging collected data with the same labels, you can perform correlation analysis to quickly identify and resolve potential risks.

Labels are collections of attributes used to identify the properties of data points, consisting of **label names** and **label values**. A data point can have multiple labels. In Workspace > Metrics Management, clicking on the Mearsurement name will display the corresponding list of labels, including label names, statistics of label values, and descriptions.

- Click :octicons-search-24: to search for related labels based on keywords;
- Click :material-export-variant: to export the label list as a CSV file to your local machine;

<img src="../img/1.tag_1.png" width="70%" >

#### Use Cases

When querying Metrics, you can quickly understand the meaning of labels by viewing their descriptions. For example, when performing chart queries or Metric detection in monitors, you can view the description information of labels in real-time. <<< custom_key.brand_name >>> provides default system fields/label descriptions, which you can replace according to your needs in [Field Management](../management/field-management.md).

<img src="../img/11.metrics_7.png" width="70%" >

## Time Series

In the current workspace, the number of combinations of Metrics data based on labels is dynamically calculated. In <<< custom_key.brand_name >>>, Time Series are composed of Metrics, tags (fields), and data storage duration. Among them, the combination of "Metrics" and "tags (fields)" serves as the primary key for data storage.

| Term           | Description                                               |
| --------------- | ----------------------------------------------------------- |
| Database       | The database.  |
| Measurement    | Refers to Mearsurement, similar to tables in MySQL.        |
| Field          | Refers to Metrics, key-value pairs recording actual data in InfluxDB (mandatory in InfluxDB, not indexed). |
| Field Set      | A set of Field key-value pairs.                             |
| Field Key      | The key in the Field key-value pair.                        |
| Field Value    | The value in the Field key-value pair (actual data).        |
| Tag            | Refers to labels, key-value pairs describing Fields (optional in InfluxDB, indexed). |
| Tag Set        | A set of Tag key-value pairs.                               |
| Tag Key        | The key in the Tag key-value pair.                          |
| Tag Value      | The value in the Tag key-value pair.                        |
| TimeStamp      | The date and time associated with the data point.           |
| Retention Policy | Data storage duration (data retention policy).            |
| Series         | Time Series composed of Retention Policy, Measurement, and Tag Set. |

## Metrics Storage Policies {#storage}

Metrics storage policies are divided into two types:

- Global settings at the Metrics workspace level;
- Custom settings for specific Mearsurements.

### Modify Policies

Custom settings for Mearsurements take precedence over global settings. That is, after setting custom data retention policies for a Mearsurement, changing the global settings does not affect the data retention policy for that Mearsurement.

**Note**:

- After modifying the data retention policy for a Mearsurement in Metrics Management, the corresponding Mearsurement data stored in the global workspace policy will be deleted and cannot be recovered. Be cautious when performing this operation. If you modify the data retention policy for a Mearsurement again, the data under the previous policy will also be deleted.
- After modifying the data retention policy for a Mearsurement, its data will be stored separately. At this point, changing the global data retention policy for workspace Metrics will not alter the retention policy for that Mearsurement.
- After modifying the data retention policy for a Mearsurement, if you revert it to the global default retention policy, the Mearsurement will be re-stored in the global database. At this point, modifying the global data retention policy for workspace Metrics will synchronize the retention policy for that Mearsurement.
- After modifying the data retention policy for a Mearsurement, even if the global and Mearsurement retention policies are set to the same duration, the Mearsurement data will still be stored separately and will not be stored in the global database.

#### Global Settings for Metrics

In **Manage > Settings > Risky Operations**, you can view the global data retention policy for the Metrics workspace. The default data retention period is 7 days, including options for 3 days, 7 days, 14 days, 30 days, 180 days, and 360 days.

> For more details, refer to [Data Storage Policy](../billing-method/data-storage.md).

<img src="../img/2.data_storage_3.png" width="70%" >

#### Custom Settings for Mearsurements

In Metrics Management, you can view and customize the data retention policy for Mearsurements.

Click the :octicons-gear-24: button in the action bar to customize the data retention policy for a Mearsurement. Options include: 3 days, 7 days, 14 days, 30 days, 180 days, and 360 days. If no custom settings are applied, it defaults to the global data retention policy for Metrics.

![](img/19.metrics_6.png)

**Note**:

- Only workspace owners can configure data retention policies for Mearsurements, and the Free Plan does not support custom data retention policies;
- After modifying the data retention period for a Mearsurement, the data under the previous policy will also be deleted and cannot be recovered.

???+ abstract "For Deployment Plan"

    Workspace owners can configure data retention policies for Mearsurements, supporting custom input of retention periods ranging from 1 to 1800 days.

    <img src="../img/deploy-metric.png" width="60%" >