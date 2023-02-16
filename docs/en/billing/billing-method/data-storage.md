# Data Storage Strategy
---

As the number of applications used increases and the range of data observation requirements expands, the requirements for data storage time will adjust accordingly. Guance provides a variety of data storage strategies, and you can customize your data storage time according to your needs to effectively control your data storage costs.

Guance supports the commercial plan owner to change the data storage strategy in the space. In Guance workspace "Management"-"Basic Settings", click "Change", select the required data storage time, and click "OK" to change the data storage time in the current workspace.

| Data Storage Type | **Commercial Plan** |
| --- | --- |
| Metrics | 3 days / 7 days (by default)/ 14 days / 30 days / 180 days / 360 days |
| Log | 7 days / 14 days (by default)/ 30 days / 60 days |
| Backup log | 180 days (by default)/ 360 days / 720 days |
| Event | 14 days (by default)/ 30 days / 60 days |
| Scheck | 90 days (by default)/ 180 days / 360 days |
| Application performance Trace | 3 da y s / 7 days (by default)/ 14 days |
| User access PV | 3 days / 7 days (by default)/ 14 days |

???+ attention

    1. Only commercial workspace owners are allowed to do this.
    2. The owner of the commercial plan can change the data storage time of metrics, logs, backup logs, events, application performance, user access, security check. according to the requirements.
    3. After the storage policy is changed, the new storage policy will take effect immediately, and the data in the old storage policy will not be deleted immediately. This part of billing still exists before the old data is deleted by the policy scrolling..
        - Shortening of data storage time: assuming that the application performance data is adjusted from 14 days to 7 days, taking the time when days are adjusted as the dividing line, the data before this is still calculated according to the 14 days storage strategy, and the data after this will generate a new index and calculate the cost according to the new 7 days storage strategy;
        - The data storage time becomes longer: assuming that the application performance data is adjusted from 7 days to 14 days, taking the time when days are adjusted as the dividing line, the data before this will still be charged according to the 7 days storage strategy, and the data after this will generate a new index and calculate the cost according to the new 14 days storage strategy.
    
    For more information on data storage policy changes, refer to the doc [Guance ES multi-Tenant lifecycle management practices](../../billing/billing-method/es-life-cycle.md).

![](../img/1.data_storage_1.png)

## Data Storage {#options}

When you register for the Commercial Plan of Guance, if you use Alibaba Cloud account settlement method, you can adopt two data storage schemes: "Default Storage" and "SLS Storage".

- Default storage: ElasticSearch is used to store log class data, and InfluxDB/TDengine is used to store metric class data; For the opening method, please refer to the doc [Alibaba Cloud market opening Guance Commercial Plan](../../billing/commercial-aliyun.md)
- SLS storage: Log Store is used to store log class data, and Metric Store is used to store metric class data; For the opening method, please refer to the doc [Alibaba Cloud market opening Guance Exclusive Plan](../../billing/commercial-aliyun-sls.md)



## Experience Data Storage Policy {#free}

Guance supports the charging methods of free start, on-demand purchase and pay-as-you-go, providing you with a cloud platform that can be used out of the box and realize comprehensive observation. Guance Experience Plan provides users with a 7 days data storage policy. If you need to change the data storage policy, you can make changes by [upgrading to Guance Commercial Plan](../../billing/commercial-plan.md).

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

