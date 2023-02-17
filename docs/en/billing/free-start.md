# Free Start
---

Guance supports the charging methods of free start, on-demand purchase and pay-as-you-go, providing you with a cloud platform that can be used out of the box and realize comprehensive observation.

## Experience Plan Strategy
The strategy for Guance experience plan is as follows. For the billing method of the paid plan, please refer to the doc [billing method](../billing/billing-method/index.md).

| **Billing Item** | **Free Quota** | **Data Storage Strategy** | **Note** |
| --- | --- | --- | --- |
| Datakit number | not limited | / |  |
| timeseries number | 3000 | 7 days |  |
| Number of log data | 1 million per day | 7 days | Log class data range: Events, security check, logs (excluding log data for synthetic tests) |
| Number of backup log data | / | / | Experience Edition does not support backing up log data |
| AP Trace number | 8000 per day | 7 days |  |
| user access PV number | 2,000 per day | 7 days |  |
| Number of usability monitoring dialing tasks | 200,000 times per day | 7 days |  |
| Number of task calls | 100,000 times per day | / |  |
| Number of short messages sent | / | / | Experience plan does not support SMS notification |


### Notes

- If the data quota is fully used for different billing items in the experience plan, the data will stop being reported and updated; Infrastructure and event data still support reporting and updating, and you can still see infrastructure list data and event data;
- There is no charge if the experience plan is not upgraded. Once upgraded to the paid plan, it cannot be refunded;
- Timeseries and backup log statistics are full data, and other billing items are incremental data; Incremental data statistics reset the free quota at 0:00 every day, which is valid on the same day.


## Experience Plan Registration

You can provide experience plan and commercial plan registration options for Guance users a [Guance official website](https://www.guance.com/) and 「[register now](https://auth.guance.com/businessRegister)」.

In the upper right corner of "Select Opening Method", click to switch to "Open Experience Workspace", enter "Workspace Name", and click "OK" to complete the registration. If you need to upgrade to the commercial plan after the experience plan is launched, you can refer to the doc [upgrade commercial plan](commercial-plan.md).

Note:

- Guance provides multiple registration and login sites, and you can choose the appropriate site to register and log in according to the use of resources.
- If the experience plan is upgraded to the commercial plan, the collected data will continue to be reported to the Guance workspace, but the data collected during the experience plan will not be viewed.

![](img/8.register_5.png)

After registration, you can watch the introduction video of Guance, or you can click "Start Installing DataKit" to install and configure the first DataKit.

![](img/1-free-start-1109.png)







