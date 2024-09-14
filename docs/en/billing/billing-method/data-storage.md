# Data Storage Strategy
---

???- quote "Release Notes"

    **August 21, 2024**:

    1. The original **Data Forwarding** has been renamed to **Data Forwarding-Guance** in the standard Commercial Plan; and to **Data Forwarding-Default Storage** in the Deployment Plan.
    2. The original **Application Performance** has been split into **Application Performance-Trace** and **Application Performance-Profile**.

    **November 2, 2023**: The default strategy for **User Access / Application Performance (Trace, Profile)** in the commercial version has been adjusted to 14 days.


As the number of applications used increases and the range of data observation requirements expands, the requirements for data storage time will adjust accordingly. Guance provides a variety of data storage strategies, and you can customize your data storage time according to your needs to effectively control your data storage costs.


## Data Storage Duration

| <div style="width: 200px">Type</div> | Duration |
| --- | --- |
| Metrics | Namely the global data retention strategy for metrics. If you have specific data retention duration requirements for certain measurements, you can make customized modifications through [configuring storage strategies](../../metrics/dictionary.md#storage).<br /><br />3 days / 7 days (default) / 14 days / 30 days / 180 days / 360 days |
| Logs | 3 days / 7 days / 14 days (default) / 30 days / 60 days |
| Data Forwarding-Guance | 180 days (default) / 360 days / 720 days |
| Events | 14 days (default) / 30 days / 60 days |
| APM-Trace/Profile | 3 days / 7 days / 14 days (default) |
| RUM | 3 days / 7 days / 14 days (default) |
| Security Check | 3 days / 7 days / 14 days (default) / 30 days / 60 days |


### Change Duration

The owner of the Commercial Plan workspace can adjust the strategy several times on the same day. Except for the first modification, it will take effect immediately, and other modification operations will take effect the next day according to the last adjustment record.

The data storage duration change steps are as follows:

1. In **Management > Settings** in the Guance workspace, click **Change** in **Change Data Storage Strategy**;  
2. Select the data type to modify the data storage strategy, click **Edit**, select the time to be modified in the pop-up dialog box;  
3. You can modify the storage time of other data types according to the second step. After all the modifications are completed, click **Confirm** to change the data storage time in the current workspace.



???+ warning "Notes"

    1. Only the owner of a Commercial Plan workspace is allowed to perform this operation.
    2. After changing the metric data storage strategy, data under the old strategy will be deleted; please make choices carefully. Support [custom settings](../../metrics/dictionary.md#storage) for measurement data storage policies.
    3. Changes to data storage policies, excluding metric data, take effect immediately, and data under the old strategy will not be deleted immediately; it remains until the strategy's rolling deletion of old data, and billing continues for this part.

        - Shortening data retention: For example, if application performance data is adjusted from 14 days to 7 days, data before the adjustment time will still be billed according to the 14-day strategy, while data after will be indexed anew and billed according to the new 7-day strategy.
        - Extending data retention: For example, if application performance data is adjusted from 7 days to 14 days, data before the adjustment time will still be billed according to the 7-day strategy, while data after will be indexed anew and billed according to the new 14-day strategy.

        > For more details, refer to [Guance ES Multi-tenant Lifecycle Management Practices](../../billing/billing-method/es-life-cycle.md).



## Storage Methods {#options}

Guance provides two data storage schemes: **Default Storage** and **SLS Storage**.

- Default storage: Elasticsearch/OpenSearch is used to store log data, and GuanceDB is used to store metric data; 

    > See [Commercial Plan in the Alibaba Cloud Market](../../plans/commercial-register.md).

- SLS storage: Using Alibaba Cloud Log Service SLS to store data; LogStore is used to store log class data, and Metric Store is used to store metric class data; 

    > See [Exclusive Plan in the Alibaba Cloud Market](../../plans/commercial-register.md).

## For Experience Plan {#free}

Guance Experience Plan provides users with a 7 days Data Storage Strategy. 

If you need a longer storage duration, you can make changes by [upgrading to Guance Commercial Plan](../../billing/commercial-plan.md).

| <div style="width: 180px">**Billing Item**</div>             | <div style="width: 120px">**Quota**</div>  | Duration | Notes                                                     |
| ---------------------- | ------------- | ---------------- | ------------------------------------------------------------ |
| Timeseries	             | 3,000     | 7  days             |                                                              |
| Log data	         | 1 million/day | 7  days             | Data range include: Events, security check, logs (excluding log data for synthetic tests) |
| Data forwarding      | /             | /                | ❌                                      |
| APM Trace    | 8,000/day  | 7  days             |                                       |
| APM Profile    | 60/day  | 7  days             |                                       |
| RUM PVs      | 2,000/day  | 7  days             |  
| Session replay       | 1,000/day  | 7  days             |                                                             |
| Synthetic tests tasks | 200,000 times/day  | 7  days             |                                                              |
| Triggers           | 100,000 times/day  | /                |                                                              |
| SMS sent           | /             | /                |  ❌                                      |

???+ warning "Notes"

    1. In the Experience Plan, data reporting stops when usage limits are reached, except for Infrastructure and Events.
    2. The Experience Plan can be upgraded to the Commercial Plan online; this upgrade is irreversible.
    3. Post-upgrade to the Commercial Plan, data collection continues in Guance, but pre-upgrade data is not accessible.
    4. Timeline and data forwarding cover total data volume; other billing items are based on incremental data, with daily free quotas resetting at midnight.


