# Public Cloud Experience Plan
---

## Open Experience Plan

In [Guance official site](https://www.guance.com/), click **[Getting Started](https://auth.guance.com/businessRegister)** and fill in relevant information to become a Guance user.

Step 1: **choosing register site** in **Basic Setting** is important, see [<site instructions>](../getting-started/necessary-for-beginners/select-site.md), please choose carefully.

![](img/commercial-register-1.png)

Step 3: Select the opening method, click the upper right corner to switch to **Open Experience Plan Workspace**, enter **Workspace Name**, and click **OK** to open the public cloud experience plan of Guance.

![](img/8.register_5.png)


## Difference Between Experience Plan and Commercial Plan {#trail-vs-commercial}

The experience versplanion and Commercial Plan provided by the public cloud all adopt the billing method of **pay-per-use**.

There are limitations on the amount of data that can be accessed in the experience plan. After [upgrade to Commercial Plan](commercial-version.md), a larger amount of data can be accessed, and the data storage time can be customized more flexibly.

???+ attention

    - There is no charge if the experience plan is not upgraded. **Once upgraded to the Commercial Plan, it cannot be refunded**;
    - If the experience plan is upgraded to the Commercial Plan, the collected data will continue to be reported to the observation cloud workspace, but the data collected during the **experience plan will not be viewed**;
    - The upgraded Commercial Plan only supports the current workspace owner to view and operate;
    - Timeseries and backup log statistics are full data, and other billing items are incremental data; Incremental data statistics reset the free quota at 0 o'clock every day, which is valid on the same day;
    - If the data quota is fully used for different billing items in the experience plan, the data will stop being reported and updated; Infrastructure and event data still support reporting updates, and you can still see infrastructure list data and event data.
    - The experience workspace does not support the use of **Snapshot Sharing** function because of data content security issues.

The following is the difference between the scope of services supported by **Experience Plan** and **Commercial Plan**.

| **Differences** | **Project**  | **Experience Plan**    | **Commercial Plan**   |
| -------- | ---------------- | ---------- | --------- |
| Data  | <div style="width: 150px"> DataKit number </div>   | <div style="width: 240px"> not limited </div>    | not limited    |
|          | Daily data reporting limit | Limited data is reported and excess data is no longer reported       | not limited |
|          | Data storage policty     | 7-day cycle        |Customize the storage policy, please refer to [data storage policty](../billing/billing-method/data-storage.md) |
|          | Quantity of timeline | 3000 | not limited    |
|          | Number of log data | 1 million<br/>Log class data range: events, security check, log<br/>(Log data without synthetic test) | not limited    |
|          | Quantity of application performance Trace |8,000 per day | not limited    |
|          | Quantity of user access PV | 2,000 per day | not limited    |
|          | Number of task calls | 100,000 per day  |not limited    |
| Function      | infrastructure         | :white_check_mark: | :white_check_mark:    |
|          | Log            | :white_check_mark:| :white_check_mark: | 
|          | Backup log         | /     | :white_check_mark: | 
|          | APM     | :white_check_mark: | :white_check_mark: | 
|          | RUM     | :white_check_mark: | :white_check_mark: | 
|          | CI visibility    | :white_check_mark: | :white_check_mark: | 
|          | Security check         | :white_check_mark: | :white_check_mark: | 
|          | Montoring      | :white_check_mark: | :white_check_mark: | 
|          | Synthetic tests       | Dial test in China (200,000 times a day)      |Global dialing       |
|          | SMS alarm notification     | /     | :white_check_mark: | 
|          | DataFlux Func    | :white_check_mark: | :white_check_mark: | 
|          | Account permissions         | Read-only, standard permissions are promoted to administrators without auditing | Read-only, standard permissions are promoted to administrators, and need to be approved by Expense Center administrators           |
| Service     | Basic service         | Community, phone, work order support (5 x 8 hours)     | Community, phone, work order support (5 x 8 hours)     |
|          | Training services         | Regular training on observability              | Regular training on observability      |
|          | Expert services         | /     | Professional product technical expert support       |
|          | Value-added services         | /     | Internet professional operation and maintenance service         |
|          | Monitoring digital combat screen   | /     | Customizable   |


## Experience Quota Inquiry

Owners and administrators of the Guance workspace can view the daily experience quota and usage of each billing item in the **Studio > Billing** module.<br/>
If you need to [upgrade to Commercial Plan](commercial-version.md), you can click the **Upgrade** button.

![](img/9.upgrade_1.png)

## More Reading

<[Getting started](https://docs.guance.com/getting-started/)>

<[Upgrade to Commercial Plan](commercial-version.md)>







