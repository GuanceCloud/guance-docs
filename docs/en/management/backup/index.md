# Data Forwarding
---


Supports saving log, application performance, user access, and event data to its object storage or forwarding it to an external storage system. You can freely choose the storage destination and flexibly manage data forwarding.

After the rule takes effect, on the data forwarding page, you can quickly search for stored data by setting query times and data forwarding rules, including <<< custom_key.brand_name >>> backup logs, AWS S3, Huawei Cloud OBS, Alibaba Cloud OSS, and Kafka message queues, etc.


## Prerequisites

Commercial Plan only.

## Start Creating

Go to the **Data Forwarding > Forwarding Rules > Create** page.

???+ warning "Note"

    After the data forwarding rule is created, the system will execute the rule validation every 5 minutes.

<img src="../img/create_data_forward_rules.png" width="70%" >


### Input Rule Name

1. Rule Name: The name of the current data forwarding rule.
2. Include Extended Fields: By default, only the `message` field content of logs that meet the conditions will be forwarded. If you select "Include Extended Fields," the entire log data that meets the condition will be forwarded. Application performance and user access data are forwarded as entire records by default and are not affected by this option.

???+ warning "Note"

    When creating multiple data forwarding rules, priority is given to matching rules with extended fields included. If different rules match the same data, the rule with extended fields included will display the full log data.


### Define Filtering Conditions


1. Data Source: Includes logs, application performance, user access, and event data.

2. Filtering Conditions: Supports custom logic between conditions; you can choose **all conditions** or **any condition**:

    - All conditions: Only log data that matches all filtering conditions will be saved for data forwarding;

    - Any condition: Log data meeting any one of the filtering conditions will be saved for data forwarding.

**Condition operators are shown in the table below:**

| Condition Operator      | Match Type     | 
| ------------- | -------------- | 
| in, not in      | Exact match, supports multiple values (comma-separated) | 
| match, not match | Fuzzy match, supports regular expression syntax | 

???+ warning "Note"

    Not adding filtering conditions means saving all log data; supports adding multiple filtering conditions.


### Select Archiving Type

???+ warning "Note"

    All five archiving types are available across the site.


To provide a more comprehensive data forwarding storage method, <<< custom_key.brand_name >>> supports five storage paths.

:material-numeric-1-circle-outline: <<< custom_key.brand_name >>>: When choosing <<< custom_key.brand_name >>> as the data forwarding storage object, matched log data will be saved in the **<<< custom_key.brand_name >>> side's OSS, S3, OBS object storage**.

:material-numeric-2-circle-outline: [AWS S3](./backup-aws.md);

:material-numeric-3-circle-outline: [Huawei Cloud OBS](./backup-huawei.md);

:material-numeric-4-circle-outline: [Alibaba Cloud OSS](./backup-ali.md);

:material-numeric-5-circle-outline: [Kafka Message Queue](./backup-kafka.md).

???+ warning "Note"

    When choosing <<< custom_key.brand_name >>> as the data forwarding storage object, the minimum log data storage is set to 180 days by default. Once the rule is created, it cannot be canceled, and daily charges will apply during the storage period. You can go to **Manage > Settings > Change Data Storage Strategy** to make modifications.

### Define Data View Permissions {#permission}

Setting view permissions for forwarded data can effectively enhance data security.

- No restrictions: All members of the workspace can view forwarded data;
- Custom: Specify member roles who can view forwarded data.


## Manage Forwarding Rules

All created data forwarding rules can be viewed in the forwarding rules list. You can manage the list via the following operations:

- Search by entering the rule name;

- Enable or disable the current rule;

- Click the search, edit, or delete button on the right side of the rule to perform corresponding actions;

- Optionally select multiple rules for batch operations.

???+ warning "Note"

    - Viewing forwarded data may have up to a 1-hour delay;
    - In edit mode, access type and region cannot be adjusted; for rules selecting <<< custom_key.brand_name >>> storage, the editing and viewing content remains consistent;
    - After deleting a rule, already forwarded data will not be deleted, but no new data will be generated.

## Data Viewing {#explorer}

On the data viewing page, you can search for the latest data results based on time range and forwarding rules. Regular expression syntax can also be used here.

<img src="../img/backup_data_explorer.png" width="70%" >

The system retrieves file search matching data in batches according to the selected time, returning 50 entries per batch. If no data is found or fewer than 50 entries are returned on the first query, you can manually click "Continue Query" until the scan is complete.

## Data Forwarding Query Duration {#query_time_change}

After configuring the query duration, when viewing forwarded data, the query time range will be affected by the duration configuration here.

<img src="../img/backup_data_query_time_change.png" width="70%" >

1. Go to Manage > Workspace Settings > Advanced Settings > Configure Query Duration;
2. Select Duration;
3. Confirm.