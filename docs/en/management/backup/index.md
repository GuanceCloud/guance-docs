# Data Forwarding
---


<<< custom_key.brand_name >>> supports saving logs, application performance, user access, and event data to its object storage or forwarding it to external storage systems. You can freely choose the storage destination and flexibly manage data forwarding.

After the rule takes effect, on the data forwarding page, you can quickly search for stored data by setting query times and data forwarding rules, including <<< custom_key.brand_name >>> backup logs, AWS S3, Huawei Cloud OBS, Alibaba Cloud OSS, and Kafka MESSAGE QUEUES, etc.


## Prerequisites

Commercial Plan only.

## Start Creating

Enter the **Data Forwarding > Forwarding Rules > Create** page.

???+ warning "Note"

    After creating a data forwarding rule, the system will execute the rule validation every 5 minutes.  

<img src="../img/create_data_forward_rules.png" width="70%" >



### Enter Rule Name

1. Rule Name: The name of the current data forwarding rule.   
2. Include Extended Fields: By default, only the `message` field content of logs that meet the conditions will be forwarded. If you check "Include Extended Fields," then the entire log data that meets the conditions will be forwarded. APM and RUM data are forwarded as entire data by default, unaffected by this option.

???+ warning "Note"

    When creating multiple data forwarding rules, priority is given to matching rules with extended fields included. If different rules match the same data, the entire log data will be displayed according to the logic of including extended fields.     


### Define Filtering Conditions


1. Data Source: Includes LOGS, APM, RUM, and EVENT DATA.

2. Filtering Conditions: Supports customizing the logical operations between conditions; you can select **All Conditions** or **Any Condition**:

    - All Conditions: Only logs that match all filtering conditions will be saved for data forwarding;

    - Any Condition: Logs that satisfy any one of the filtering conditions will be saved for data forwarding.

**Condition operators are listed in the table below:**

| Condition Operator      | Match Type     | 
| ------------- | -------------- | 
| in, not in      | Exact match, supports multiple values (comma-separated) | 
| match, not match | Fuzzy match, supports regular expression syntax | 

???+ warning "Note"

    Not adding filtering conditions means saving all log data; supports adding multiple filtering conditions.


### Select Archiving Type

???+ warning "Note"

    All five archiving types are available across the site.


To provide more comprehensive data forwarding storage methods, <<< custom_key.brand_name >>> supports five storage paths.

:material-numeric-1-circle-outline: <<< custom_key.brand_name >>>: When selecting <<< custom_key.brand_name >>> as the data forwarding storage object, matched log data will be saved in **<<< custom_key.brand_name >>>'s OSS, S3, OBS object storage**.

:material-numeric-2-circle-outline: [AWS S3](./backup-aws.md);

:material-numeric-3-circle-outline: [Huawei Cloud OBS](./backup-huawei.md);

:material-numeric-4-circle-outline: [Alibaba Cloud OSS](./backup-ali.md);

:material-numeric-5-circle-outline: [Kafka MESSAGE QUEUES](./backup-kafka.md).

???+ warning "Note"

    When selecting <<< custom_key.brand_name >>> as the data forwarding storage object, the minimum log data retention period is 180 days by default. Once the rule is created, it cannot be canceled, and fees will be charged daily during the retention period; you can go to **Manage > Settings > Change Data Storage Policy** to modify.

### Define Data Viewing Permissions {#permission}

Setting viewing permissions for forwarded data can effectively enhance data security.

- No Restrictions: All members of the workspace can view forwarded data;
- Custom: Specify the roles of members who can view forwarded data.


## Manage Forwarding Rules

All created data forwarding rules can be viewed in the forwarding rule list. You can manage the list through the following operations:

- Search by entering the rule name;

- Enable or disable the current rule;

- Click the search, edit, or delete button on the right side of the rule to perform corresponding actions;

- Optionally select multiple rules for batch operations.

???+ warning "Note"

    - There may be up to a 1-hour delay when viewing forwarded data;          
    - In edit mode, access type and region cannot be adjusted; for rules choosing <<< custom_key.brand_name >>> storage, editing and viewing content are consistent;           
    - After deleting a rule, the already forwarded data will not be deleted, but no new data will be generated.

## Data Viewing {#explorer}

On the data viewing page, you can search and query the latest data results based on time range and forwarding rules. Regular expression syntax can also be used here for searching.

<img src="../img/backup_data_explorer.png" width="70%" >

The system will retrieve files in batches according to the selected time to search for matching data, returning 50 entries per batch. If no data is found on the first query or fewer than 50 entries are returned, you can manually click "Continue Query" until the scan is complete.