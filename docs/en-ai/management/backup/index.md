# Data Forwarding
---

<!--
???- quote "Change Log"

    **2023.11.2**:
    
    1. Support saving data to Guance's OSS, S3, and OBS data repositories;
    2. The navigation position of [Data Forwarding] has been moved to the [Management] module, but it can still be accessed through the secondary menu under [Logs], [RUM], and [APM].

    **2023.9.26**: Data forwarding rule queries now support RUM and APM data.

    **2023.9.21**: Added a new entry for querying external storage forwarding rules; supports enabling/disabling forwarding rules.

    **2023.9.7**: The original [Backup Logs] has officially been renamed to [Data Forwarding].
-->

Guance supports saving logs, application performance, user access, and event data to its object storage or forwarding it to external storage systems. You can freely choose the storage destination and manage data forwarding flexibly.

After the rules take effect, on the Data Forwarding page, you can quickly search stored data by setting query times and data forwarding rules, including backup logs in Guance, AWS S3, Huawei Cloud OBS, Alibaba Cloud OSS, and Kafka message queues.


## Prerequisites

Users of the Commercial Plan can use the data forwarding feature. Free Plan users need to [upgrade to the Commercial Plan](../../plans/trail.md#upgrade-commercial).

## Create New Rule

Enter the **Data Forwarding** page, click **Forwarding Rules > Create New Rule**.

**Note**: After creating a data forwarding rule, the rule is checked every 5 minutes.

![](../img/back-5.png)

### :material-numeric-1-circle: Enter Rule Name

1. Rule Name: The name of the current data forwarding rule, limited to 30 characters.
2. Include Extended Fields: By default, only the `message` field content of logs that meet the criteria is forwarded. If you check "Include Extended Fields," the entire log data that meets the criteria will be forwarded. Application performance and user access data are forwarded as complete data by default, unaffected by this option.

**Note**: If multiple data forwarding rules are created, rules with extended fields enabled have priority. If different rules match the same data, the rule with extended fields included takes precedence.

### :material-numeric-2-circle: Define Filtering Conditions

1. Data Source: Includes logs, application performance, user access, and event data.
2. Filtering Conditions: Supports custom logic between conditions. You can choose **All Conditions** or **Any Condition**:

    - All Conditions: Only logs that match all filtering conditions will be saved for data forwarding.
    - Any Condition: Logs that match any one condition will be saved for data forwarding.

**Note**: Not adding filtering conditions means saving all log data; you can add multiple filtering conditions.

**Condition Operators (see table below):**

| Condition Operator | Match Type          |
| ------------------ | ------------------- |
| in, not in         | Exact match, supports multiple values (comma-separated) |
| match, not match   | Fuzzy match, supports regular expression syntax |

### :material-numeric-3-circle: Select Archive Type

???+ warning "Note"

    All five archive types are available site-wide.

To provide more comprehensive data forwarding storage options, Guance supports five storage paths.

:material-numeric-1-circle-outline: Guance: When selecting Guance as the data forwarding storage object, matching log data will be saved to **Guance's OSS, S3, OBS object storage**.

:material-numeric-2-circle-outline: [AWS S3](./backup-aws.md);

:material-numeric-3-circle-outline: [Huawei Cloud OBS](./backup-huawei.md);

:material-numeric-4-circle-outline: [Alibaba Cloud OSS](./backup-ali.md);

:material-numeric-5-circle-outline: [Kafka Message Queue](./backup-kafka.md).

**Note**: When choosing Guance as the data forwarding storage object, the minimum retention period for log data is 180 days by default. Once the rule is created, it cannot be canceled, and daily charges will apply during the retention period. You can modify the data forwarding storage policy at **Management > Settings > Change Data Storage Policy**.

## View Forwarding Rules

After creating the rule, you automatically enter the forwarding rule list:

1. You can search by entering the rule name;
2. You can enable or disable the current rule;
3. Click the :material-text-search:, edit, :fontawesome-regular-trash-can: buttons on the right side of the rule to perform corresponding actions.
4. You can select multiple rules for batch operations.

**Note**:

- Viewing forwarded data may have up to a 1-hour delay.
- In edit mode, **Access Type** and **Region** cannot be adjusted; rules choosing **Guance** storage have consistent viewing and editing content.
- Deleting a rule does not delete already forwarded data, but no new forwarded data will be generated.

### Forwarding Rule Explorer {#explorer}

Returning to the **Data Forwarding** page, the default tab is **Forwarded Data**. You can customize the time range query using the time control widget.

![](../img/back_data_explorer.png)

Guance retrieves file search match data in batches based on the selected time, returning 50 entries per batch. **If no data is found on the first query or if fewer than 50 entries are returned**, you can manually click **Continue Query** until the scan is complete.

Since the queried data is unordered, you can sort the listed data by time range. This action does not affect the query results.

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