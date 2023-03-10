# Data Storage Strategy
---

As the number of applications used increases and the range of data observation requirements expands, the requirements for data storage time will adjust accordingly. Guance provides a variety of data storage strategies, and you can customize your data storage time according to your needs to effectively control your data storage costs.


## Data Storage Duration

| Data Storage Type | **Data Storage Duration** |
| --- | --- |
| Metrics | 3 days / 7 days (by default)/ 14 days / 30 days / 180 days / 360 days |
| Log | 7 days / 14 days (by default)/ 30 days / 60 days |
| Backup log | 180 days (by default)/ 360 days / 720 days |
| Event | 14 days (by default)/ 30 days / 60 days |
| User access PV | 3 days / 7 days (by default)/ 14 days |

## Change Data Storage Duration

The owner of the commercial workspace can adjust the data storage policy several times on the same day. Except for the first modification, it will take effect immediately, and other modification operations will take effect the next day according to the last adjustment record.

The data storage duration change steps are as follows:

-Step 1: In **Management > Settings** in the Guance workspace, and click **Change** in **Change Data Storage Policy**;
-Step 2: Select the data type to modify the data storage strategy, click **Edit**, select the time to be modified in the pop-up dialog box, and click **Confirm**;
-Step 3: You can modify the storage time of other data types according to the second step. After all the modifications are completed, click **Confirm** to change the data storage time in the current workspace.

![](../img/2.data_storage_2.png)

???+ attention

    1. Only commercial workspace owners are allowed to do this.
    2. After the metric data storage policy is changed, the data in the old storage policy will be deleted. Please choose carefully. You can [set custom](../../metrics/dictionary.md#storage) data storage policies for measurements.
    3. After the storage policy is changed, the new storage policy will take effect immediately, and the data in the old storage policy will not be deleted immediately. This part of billing still exists before the old data is deleted by the policy scrolling.
   
        - Shortening of data storage time: assuming that the application performance data is adjusted from 14 days to 7 days, taking the time when days are adjusted as the dividing line, the data before this is still calculated according to the 14 days storage strategy, and the data after this will generate a new index and calculate the cost according to the new 7 days storage strategy;
        - Lengthening of data storage time: assuming that the application performance data is adjusted from 7 days to 14 days, taking the time when days are adjusted as the dividing line, the data before this will still be charged according to the 7 days storage strategy, and the data after this will generate a new index and calculate the cost according to the new 14 days storage strategy.
    
    For more information on data storage policy changes, see [Guance ES multi-Tenant lifecycle management practices](../../billing/billing-method/es-life-cycle.md).


## Data Storage Methods {#options}

Guance provides two data storage schemes: **Default Storage** and **SLS Storage**.

- Default storage: ElasticSearch is used to store log class data, and InfluxDB/TDengine is used to store metric class data; please refer to the doc on [opening Guance Commercial Plan in the Alibaba Cloud market](../../billing/commercial-aliyun.md).
- SLS storage: Log Store is used to store log class data, and Metric Store is used to store metric class data; please refer to the doc on [opening Guance Exclusive Plan in the Alibaba Cloud market](../../billing/commercial-aliyun-sls.md).

## Data Storage Policy of Experience Plan {#free}

Guance supports the charging methods of free start, on-demand purchase and pay-per-use, providing you with a cloud platform that can be used out of the box and realize comprehensive observation. Guance Experience Plan provides users with a 7 days data storage policy. If you need to change the data storage policy, you can make changes by [upgrading to Guance Commercial Plan](../../billing/commercial-plan.md).

| **Billing Item**             | **Experience Quota**  | **Data Storage Strategy** | **Notes**                                                     |
| ---------------------- | ------------- | ---------------- | ------------------------------------------------------------ |
| Datakit number           | Unlimited          | /                |                                                              |
| Quantity of timeseries             | 3000      | 7  days             |                                                              |
| Number of log data         | 1 million articles per day | 7  days             | Log class data range: Events, security check, logs (excluding log data for availability monitoring) |
| Number of backup log data       | /             | /                | Experience plan does not support backing up log data                                     |
| Application performance Trace number    | 8,000 per day  | 7  days             |                                                              |
| Number of PVs accessed by users       | 2,000 per day  | 7  days             |                                                              |
| Number of usability monitoring dialing tasks | 200,000 times per day  | 7  days             |                                                              |
| Number of task calls           | 100,000 times per day  | /                |                                                              |
| Number of short messages sent           | /             | /                | Experience plan does not support SMS notification                                         |

???+ attention

    - If the data quota is fully used for different billing items in the experience plan, the data will stop being reported and updated; Infrastructure and event data still support reporting and updating, and you can still see infrastructure list data and event data;
    - The experience plan supports online upgrade to the commercial plan, and there is no charge if it is not upgraded. Once it is upgraded to the paid plan, it cannot be refunded;
    - After the experience plan is upgraded to the commercial plan, the collected data will continue to be reported to Guance workspace, but the data collected during the experience plan will not be viewed;
    - Timeseries and backup log statistics are full data, and other billing items are incremental data; Incremental data statistics reset the free quota at 0 points every day when days are valid.

