# Data Storage Policy
---

As business applications increase, the scope of data observability requirements continues to expand, and the storage duration needs for different types of data will also adjust accordingly. <<< custom_key.brand_name >>> provides multiple data storage policies. You can customize your data retention period based on your needs, effectively controlling data storage costs and saving expenses.

## Data Retention Period

| <div style="width: 200px">Type</div> | Duration |
| --- | --- |
| Metrics | This is the global data retention policy for metrics. If you have special retention requirements for certain metric sets, you can customize them via [Configure Storage Policy](../metrics/dictionary.md).<br /><br />3 days / 7 days (default) / 14 days / 30 days / 180 days / 360 days |
| Logs | 3 days / 7 days / 14 days (default) / 30 days / 60 days |
| Data Forwarding - <<< custom_key.brand_name >>> | 180 days (default) / 360 days / 720 days |
| Events | 14 days (default) / 30 days / 60 days |
| APM - Traces / Profiles | 3 days / 7 days / 14 days (default) |
| RUM PV | 3 days / 7 days / 14 days (default) |
| Security Check | 3 days / 7 days / 14 days (default) / 30 days / 60 days |

### Changing Retention Period

Owners of Commercial Plan workspaces can adjust data storage policies multiple times in a day. The first change takes effect immediately, while subsequent changes within the same day will take effect the next day according to the last adjustment record. After changing the policy, data will be evaluated for expiration based on the latest configuration and cleared at midnight the next day.

Steps to change:

1. Go to [**Manage > Workspace Settings > Change Data Storage Policy**](../management/settings/index.md#change);
2. Click **Replace**;
3. Select the data type whose storage policy you want to modify and click **Edit**;
4. Choose the desired retention period;
5. After making changes, click **Confirm** to update the data retention period for the current workspace.

<img src="../img/2.data_storage_2.1.png" width="60%" >

### Important Notes

1. Only owners of Commercial Plan workspaces can perform this operation;  
2. After changing the Metrics data retention policy, old data under the previous policy will be deleted. Please choose carefully.
3. For changes in retention policies for data types other than Metrics, the new policy takes effect immediately, but old data under the previous policy will not be immediately deleted and will still incur charges until it is deleted according to the rolling deletion schedule.

    - Shorter retention period: Suppose APM data changes from 14 days to 7 days. Before the change date, data is charged based on the 14-day policy; after the change date, new data will be indexed and charged based on the new 7-day policy.
    - Longer retention period: Suppose APM data changes from 7 days to 14 days. Before the change date, data is charged based on the 7-day policy; after the change date, new data will be indexed and charged based on the new 14-day policy.
        
> For more details, refer to [<<< custom_key.brand_name >>> ES Multi-Tenant Lifecycle Management Practice](../billing-method/es-life-cycle.md).


## Data Storage Methods {#options}

<<< custom_key.brand_name >>> offers two data storage solutions: **Default Storage** and **SLS Storage**:

- Default Storage: Uses <<< custom_key.brand_name >>> [GuanceDB](./gauncedb.md) to store metrics data, and Elasticsearch / OpenSearch to store log data;
- SLS Storage: Uses Alibaba Cloud Log Service SLS to store data, with LogStore storing log data and MetricStore storing metrics data.


### For Free Plan {#free}

#### Billing Information

1. If any billing items in the Free Plan reach their data quota, data reporting will stop updating; infrastructure and event data will continue to report updates, so you can still see infrastructure list data and event data;
2. The Free Plan supports online upgrades to the Commercial Plan. No charges are incurred unless upgraded. Once upgraded to a paid plan, rollback is not possible;
3. After upgrading to the Commercial Plan, collected data will continue to report to the <<< custom_key.brand_name >>> workspace, but data collected during the Free Plan period will no longer be viewable;
4. Time Series and data forwarding statistics are for all data, while other billing items are incremental data. Incremental data statistics reset the free quota at midnight each day and are valid for that day.

<<< custom_key.brand_name >>> supports a free start, pay-as-you-go billing method, providing an out-of-the-box cloud platform for comprehensive observability. The Free Plan offers a 7-day data retention policy. If you need to change the data retention policy, you must [upgrade to the <<< custom_key.brand_name >>> Commercial Plan](../plans/trail.md#upgrade-commercial).

| <div style="width: 160px">**Billing Item**</div>             | **Free Quota**  | <div style="width: 160px">**Data Retention Policy**</div> | **Notes**                                                     |
| ---------------------- | ------------- | ---------------- | ------------------------------------------------------------ |
| Time Series Count      | 3000 entries  | 7 days           |                                                              |
| Log Data Count         | 1 million/day | 7 days           | Data Scope: Events, Security Check, Logs (excluding Synthetic Tests logs) |
| Data Forwarding Count  | /             | /                | ❌                                     |
| APM Trace Count        | 8000/day      | 7 days           |                                                              |
| APM Profile Count      | 60/day        | 7 days           |                                                              |
| RUM PV Count           | 2000/day      | 7 days           |                                                              |
| Session Replay Count   | 1000/day      | 7 days           |                                                              |
| Synthetic Tests Count  | 200k/day      | 7 days           |                                                              |
| Trigger Call Count     | 100k/day      | /                |                                                              |
| SMS Sending Count      | /             | /                | ❌                                         |