# Data Storage Strategy
---

As the number of applications used increases and the range of data observation requirements expands, the requirements for data storage time will adjust accordingly. Guance provides a variety of data storage strategies, and you can customize your data storage time according to your needs to effectively control your data storage costs.


## Data Storage Duration

| **Data Storage Type** | **Data Storage Duration** |
| --- | --- |
| Metrics | 3 days / 7 days (by default) / 14 days / 30 days / 180 days / 360 days |
| Log / CI Visibility / Synthetic Tests / Security Check| 3 days / 7 days / 14 days (by default) / 30 days / 60 days |
| Backup log | 180 days (by default) / 360 days / 720 days |
| Event | 14 days (by default) / 30 days / 60 days |
| APM / RUM (Trace, Profile) | 3 days / 7 days (by default) / 14 days |

## Change Data Storage Duration

The owner of the commercial workspace can adjust the Data Storage Strategy several times on the same day. Except for the first modification, it will take effect immediately, and other modification operations will take effect the next day according to the last adjustment record.

The data storage duration change steps are as follows:

:material-numeric-1-circle: In **Management > Settings** in the Guance workspace, click **Change** in **Change Data Storage Strategy**;  
:material-numeric-2-circle: Select the data type to modify the data storage strategy, click **Edit**, select the time to be modified in the pop-up dialog box, and click **Confirm**;  
:material-numeric-3-circle: You can modify the storage time of other data types according to the second step. After all the modifications are completed, click **Confirm** to change the data storage time in the current workspace.

![](../img/2.data_storage_2.png)

???+ warning "Notes You Must Know"

    1. Only commercial workspace owners are allowed to do this.
    2. After the metric Data Storage Strategy is changed, the data in the old storage policy will be deleted. Please choose carefully. You can [set custom](../../metrics/dictionary.md#storage) data storage policies for measurements.
    3. After the storage policy is changed, the new storage policy will take effect immediately, and the data in the old storage policy will not be deleted immediately. This part of billing still exists before the old data is deleted by the policy scrolling.
   
        - Shortening of data storage time: assuming that the application performance data is adjusted from 14 days to 7 days, taking the time when days are adjusted as the dividing line, the data before this is still calculated according to the 14 days storage strategy, and the data after this will generate a new index and calculate the cost according to the new 7 days storage strategy;
        - Lengthening of data storage time: assuming that the application performance data is adjusted from 7 days to 14 days, taking the time when days are adjusted as the dividing line, the data before this will still be charged according to the 7 days storage strategy, and the data after this will generate a new index and calculate the cost according to the new 14 days storage strategy.
    
        > For more information on Data Storage Strategy changes, see [Guance ES multi-Tenant lifecycle management practices](../../billing/billing-method/es-life-cycle.md).


## Data Storage Methods {#options}

Guance provides two data storage schemes: **Default Storage** and **SLS Storage**.

- Default storage: Elasticsearch / OpenSearch is used to store log data, and GuanceDB is used to store metric data; 

    > Please refer to [Opening Guance Commercial Plan in the Alibaba Cloud Market](../../billing/commercial-aliyun.md).

- SLS storage: Using Alibaba Cloud Log Service SLS to store data; Log Store is used to store log class data, and Metric Store is used to store metric class data; 

    > Please refer to [Opening Guance Exclusive Plan in the Alibaba Cloud Market](../../billing/commercial-aliyun-sls.md).

## Data Storage Strategy of Experience Plan {#free}

Guance supports the charging methods of free start, on-demand purchase and pay-per-use, providing you with a cloud platform that can be used out of the box and realize comprehensive observation. Guance Experience Plan provides users with a 7 days Data Storage Strategy. 

If you need to change the Data Storage Strategy, you can make changes by [upgrading to Guance Commercial Plan](../../billing/commercial-plan.md).

| **Billing Item**             | <div style="width: 120px">**Experience Quota**</div>  | <div style="width: 140px">**Data Storage Strategy**</div> | **Notes**                                                     |
| ---------------------- | ------------- | ---------------- | ------------------------------------------------------------ |
| Quantity of timeseries             | 3000 articles     | 7  days             |                                                              |
| Quantity of log data         | 1 million articles per day | 7  days             | Log class data range: Events, security check, logs (excluding log data for availability monitoring) |
| Quantity of backup log data       | /             | /                | Experience Plan does not support backing up log data                                     |
| Application performance Trace number    | 8,000 per day  | 7  days             |                                                              |
| Quantity of PVs accessed by users       | 2,000 per day  | 7  days             |  
| Quantity of session replay       | 1,000 per day  | 7  days             |                                                             |
| Quantity of synthetic tests dialing tasks | 200,000 times per day  | 7  days             |                                                              |
| Quantity of task calls           | 100,000 times per day  | /                |                                                              |
| Quantity of short messages sent           | /             | /                | Experience Plan does not support SMS notification                                         |

???+ warning "Notes You Must Know"

    - If the data quota is fully used for different billing items in the Experience Plan, the data will stop being reported and updated; Infrastructure and event data still support reporting and updating, and you can still see infrastructure list data and event data.
    - The Experience Plan supports online upgrade to the Commercial Plan, and there is no charge if it is not upgraded. Once it is upgraded to the paid plan, it cannot be refunded.
    - After the Experience Plan is upgraded to the Commercial Plan, the collected data will continue to be reported to Guance workspace, but the data collected during the Experience Plan will not be viewed.
    - Timeseries and backup log statistics are full data, and other billing items are incremental data; Incremental data statistics reset the free quota at 0 points every day when days are valid.

