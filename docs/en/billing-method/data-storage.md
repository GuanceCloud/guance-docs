# Data Storage Strategy
---


As the number of business applications increases, the scope of data observation needs continues to expand, and the demand for storage duration of different types of data will also adjust accordingly. <<< custom_key.brand_name >>> provides multiple data storage strategies, allowing you to customize your data storage duration based on your needs, thereby effectively controlling data storage costs and saving expenses.

## Data Storage Duration

| <div style="width: 200px">Type</div> | Duration |
| --- | --- |
| Metrics | This is the global data retention strategy for metrics. If you have specific data retention duration requirements for certain metric sets, you can make custom modifications via [Configure Storage Strategy](../metrics/dictionary.md).<br /><br />3 days / 7 days (default) / 14 days / 30 days / 180 days / 360 days |
| Logs | 3 days / 7 days / 14 days (default) / 30 days / 60 days |
| Data Forwarding - <<< custom_key.brand_name >>> | 180 days (default) / 360 days / 720 days |
| Events | 14 days (default) / 30 days / 60 days |
| Application Performance - APM / Profile | 3 days / 7 days / 14 days (default) |
| RUM PV | 3 days / 7 days / 14 days (default) |
| Security Check | 3 days / 7 days / 14 days (default) / 30 days / 60 days |

### Changing Storage Duration

The owner of a Commercial Plan workspace can adjust the data storage strategy multiple times in a day. Except for the first modification which takes effect immediately, other modification operations will take effect the next day according to the last adjustment record. After the strategy change, the data will be evaluated for expiration based on the latest configuration and cleared at 0 o'clock the next day.

Steps to change:

1. Go to [**Manage > Workspace Settings > Change Data Storage Strategy**](../management/settings/index.md#change);
2. Click **Replace**;
3. Select the type of data storage strategy you want to modify, click **Edit**;
4. Choose the required duration;
5. After completing the modification, click **Confirm**, which will change the data storage duration within the current workspace.

<img src="../img/2.data_storage_2.1.png" width="60%" >

### Notes on Changes

1. Only the owner of a Commercial Plan workspace can perform this operation;  
2. After changing the storage strategy for metric data, the old data inside the old storage strategy will be deleted, please choose carefully.
3. For changes in the storage strategy of other data types except metric data, the new retention strategy takes effect immediately, but the old data under the old storage strategy will not be deleted immediately and will still incur charges until the strategy rolls over and deletes the old data.

    - Shortened data retention: Suppose application performance data changes from 14 days to 7 days, with the adjustment time as the boundary line, the data before that time will continue to be charged according to the 14-day storage strategy, while the data after that time will generate new indices and be charged according to the new 7-day storage strategy;
    - Extended data retention: Suppose application performance data changes from 7 days to 14 days, with the adjustment time as the boundary line, the data before that time will continue to be charged according to the 7-day storage strategy, while the data after that time will generate new indices and be charged according to the new 14-day storage strategy.
        
> For more details, refer to [<<< custom_key.brand_name >>> ES Multi-tenant Lifecycle Management Practice](../billing-method/es-life-cycle.md).


## Data Storage Methods {#options}

<<< custom_key.brand_name >>> offers two data storage solutions: **Default Storage** and **SLS Storage**:

- Default Storage: Using <<< custom_key.brand_name >>>'s proprietary storage for metric-type data, Elasticsearch / OpenSearch for log-type data;
- SLS Storage: Using Alibaba Cloud Log Service SLS to store data, storing log-type data in LogStore and metric-type data in MetricStore.


### Regarding Free Plan {#free}

#### Billing Notes

1. If different billing items in the Free Plan reach their data quota, data updates will stop being reported; infrastructure and event data will still support reporting updates, and you can still see infrastructure list data and event data;     
2. The Free Plan supports online upgrades to the Commercial Plan. Without upgrading, there are no charges, but once upgraded to a paid version, it cannot be reverted;        
3. After upgrading the Free Plan to the Commercial Plan, collected data will continue to be reported to the <<< custom_key.brand_name >>> workspace, but data collected during the Free Plan period will no longer be viewable;   
4. Time Series and data forwarding statistics account for all data, other billing items are incremental data; incremental data statistics reset the free quota at 0 o'clock every day and are valid for the day.   

<<< custom_key.brand_name >>> supports a free start, pay-as-you-go billing method, providing you with an out-of-the-box cloud platform that enables comprehensive observability. The Free Plan of <<< custom_key.brand_name >>> provides a 7-day data storage strategy. If you need to change the data storage strategy, you must [upgrade to the Commercial Plan of <<< custom_key.brand_name >>>](../plans/trail.md#upgrade-commercial) to make the change.

| <div style="width: 160px">**Billing Items**</div>             | **Free Quota**  | <div style="width: 160px">**Data Storage Strategy**</div> | **Notes**                                                     |
| ---------------------- | ------------- | ---------------- | ------------------------------------------------------------ |
| Time Series Quantity   | 3000 entries | 7 days          |                                                              |
| Log Data Quantity      | 1 million per day | 7 days          | Data Scope: Events, Security Check, Logs (excluding logs from Synthetic Tests) |
| Data Forwarding Quantity | /            | /               | ❌                                     |
| APM Trace Quantity     | 8000 per day  | 7 days          |                                                              |
| APM Profile Quantity    | 60 per day    | 7 days          |                                                              |
| RUM PV Quantity        | 2000 per day  | 7 days          |                                                              |
| SESSION REPLAY Session Quantity | 1000 per day | 7 days          |                                                              |
| Synthetic Testing Task Runs | 200k per day | 7 days          |                                                              |
| Trigger Runs           | 100k per day  | /               |                                                              |
| SMS Sending Runs       | /            | /               | ❌                                         |