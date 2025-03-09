# Data Forwarding
---

<!--
???- quote "Change Log"

    **2023.11.2**:
    
    1. Support for saving data to <<< custom_key.brand_name >>> side OSS, S3, OBS data repositories;
    2. The navigation position of [Data Forwarding] has been moved to the [Manage] module but can still be accessed via secondary menus under [Logs], [RUM], and [APM].

    **2023.9.26**: Data forwarding rule queries now support RUM and APM data.

    **2023.9.21**: Added entry points for querying external storage forwarding rules; support for enabling/disabling forwarding rules.

    **2023.9.7**: The original [Backup Logs] was officially renamed to [Data Forwarding].
-->

<<< custom_key.brand_name >>> supports saving logs, application performance, user access, and event data to its object storage or forwarding it to external storage systems. You can freely choose your storage destination and manage data forwarding flexibly.

After the rules take effect, on the Data Forwarding page, you can set query times and data forwarding rules to quickly retrieve stored data, including <<< custom_key.brand_name >>> backup logs, AWS S3, Huawei Cloud OBS, Alibaba Cloud OSS, and Kafka message queues.


## Prerequisites

Commercial Plan users of <<< custom_key.brand_name >>> can use the data forwarding feature. Free Plan users need to [upgrade to a Commercial Plan](../../plans/trail.md#upgrade-commercial).

## Create Rule

Enter the **Data Forwarding** page and click **Forwarding Rules > Create Rule**.

**Note**: After creating a data forwarding rule, it will be executed every 5 minutes.  

![](../img/back-5.png)

### :material-numeric-1-circle: Input Rule Name

1. Rule Name: The name of the current data forwarding rule, limited to 30 characters.
2. Include Extended Fields: By default, only the `message` field content of logs that meet the conditions is forwarded. If you select "Include Extended Fields," the entire log entry that meets the conditions will be forwarded. Application performance and user access data are forwarded as complete entries by default and are not affected by this option.

**Note**: If multiple data forwarding rules are created, priority is given to rules that include extended fields. If different rules match the same data, the entire log entry will be forwarded according to the rule that includes extended fields.

### :material-numeric-2-circle: Define Filter Conditions

1. Data Source: Includes logs, application performance, user access, and event data.

2. Filter Conditions: Supports custom logic between conditions. You can choose **All Conditions** or **Any Condition**:

    - All Conditions: Only log data matching all filter conditions will be saved for data forwarding.
    - Any Condition: Log data matching any one of the filter conditions will be saved for data forwarding.

**Note**: Not adding filter conditions means saving all log data; you can add multiple filter conditions.

**Condition Operators Table:**

| Condition Operator | Match Type     |
| ------------- | -------------- |
| in, not in      | Exact match, supports multiple values (comma-separated) |
| match, not match | Fuzzy match, supports regular expression syntax |

### :material-numeric-3-circle: Select Archive Type

???+ warning "Note"

    Five archive types are available across the site.

To provide more comprehensive data forwarding storage options, <<< custom_key.brand_name >>> supports five storage paths.

:material-numeric-1-circle-outline: <<< custom_key.brand_name >>>: When choosing <<< custom_key.brand_name >>> as the data forwarding storage object, matched log data will be saved to **<<< custom_key.brand_name >>>'s OSS, S3, OBS object storage**.

:material-numeric-2-circle-outline: [AWS S3](./backup-aws.md);

:material-numeric-3-circle-outline: [Huawei Cloud OBS](./backup-huawei.md);

:material-numeric-4-circle-outline: [Alibaba Cloud OSS](./backup-ali.md);

:material-numeric-5-circle-outline: [Kafka Message Queue](./backup-kafka.md).

**Note**: When selecting <<< custom_key.brand_name >>> as the data forwarding storage object, log data is stored for a minimum of 180 days by default. Once created, the rule cannot be canceled, and daily fees are charged during the storage period. You can modify the data forwarding storage policy at **Manage > Settings > Change Data Storage Policy**.

## View Forwarding Rules

After creating the rule, you automatically enter the forwarding rules list:

1. You can search by entering the rule name;

2. You can enable or disable the current rule;

3. Click the :material-text-search:, edit, :fontawesome-regular-trash-can: buttons on the right side of the rule to perform corresponding actions;

4. You can select multiple rules for batch operations.

**Note**:

- Viewing forwarded data may have a delay of up to 1 hour;

- In edit mode, **Access Type** and **Region** cannot be adjusted; rules selecting **<<< custom_key.brand_name >>>** storage have consistent editing and viewing content;

- Deleting a rule does not delete already forwarded data but stops new data from being forwarded.

### Forwarding Rules Explorer {#explorer}

Returning to the **Data Forwarding** page, you will default to the **Forwarded Data** tab. You can query within a custom time range using the time widget.

![](../img/back_data_explorer.png)

<<< custom_key.brand_name >>> retrieves file search match data in batches based on the selected time, returning 50 entries per batch. If the first query returns fewer than 50 entries or no data, you can manually click **Continue Query** until the scan is complete.

Since the queried data is unordered, you can sort the listed data by time range. This action does not affect the data query results.

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Data Forwarding Billing Logic</font>](../../billing-method/billing-item.md#backup)


</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Best Practices for Forwarding Log Data to OSS</font>](../../best-practices/partner/log-backup-to-oss-by-func.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Explorer</font>](../../getting-started/function-details/explorer-search.md)


</div>

</font>