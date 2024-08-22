# Public Cloud Experience Plan
---

## Difference Between Experience Plan and Commercial Plan {#trail-vs-commercial}

The experience versplanion and Commercial Plan provided by the public cloud all adopt the billing method of <font color=coral>**pay-per-use**</font>.

There are limitations on the amount of data that can be accessed in the Experience Plan. After [upgrading to Commercial Plan](commercial-version.md), a larger amount of data can be accessed, and the data storage time can be customized more flexibly.

???+ warning "Instructions for Using Experience Plan"

    - There is no charge if the Experience Plan is not upgraded. <u>Once upgraded to the Commercial Plan, it cannot be refunded</u>;
    - If the Experience Plan is upgraded to the Commercial Plan, the collected data will continue to be reported to the observation cloud workspace, but the data collected during the <u>Experience Plan will not be viewed</u>;
    - The upgraded Commercial Plan only supports the current workspace owner to view and operate;
    - Timeseries and backup log statistics are full data, and other billing items are incremental data; Incremental data statistics reset the free quota at 0 o'clock every day, which is valid on the same day;
    - If the data quota is fully used for different billing items in the Experience Plan, the data will stop being reported and updated; Infrastructure and event data still support reporting updates, and you can still see infrastructure list data and event data.
    - The experience workspace <u>does not support the use of Snapshot Sharing</u> function because of data content security issues.

The following is the difference between the scope of services supported by **Experience Plan** and **Commercial Plan**.

| **Differences** | **Project**  | **Experience Plan**    | **Commercial Plan**   |
| -------- | ---------------- | ---------- | --------- |
| Data  | <div style="width: 150px"> DataKit number </div>   | <div style="width: 240px"> not limited </div>    | not limited    |
|          | Daily data reporting limit | Limited data is reported and excess data is no longer reported       | not limited |
|          | Data storage policty     | 7-day cycle        |Customize the storage policy, please refer to [Data Storage Policty](../billing/billing-method/data-storage.md) |
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
|          | Account permissions         | Read-only, standard permissions are promoted to administrators without auditing | Read-only, standard permissions are promoted to administrators, and need to be approved by Billing Center administrators           |
| Service     | Basic service         | Community, phone, Billing Center support (5 x 8 hours)     | Community, phone, work order support (5 x 8 hours)     |
|          | Training services         | Regular training on observability              | Regular training on observability      |
|          | Expert services         | /     | Professional product technical expert support       |
|          | Value-added services         | /     | Internet professional operation and maintenance service         |
|          | Monitoring digital combat screen   | /     | Customizable   |


## Open Experience Plan

In [Guance official site](https://www.guance.com/), click **[Getting Started](https://auth.guance.com/businessRegister)** and fill in relevant information to become a Guance user.

Step 1: Fill in **Basic Info** and **Company Info**

<font color=coral>**Note:**</font> In **Basic Setting**, the choice of **[site instructions](../getting-started/necessary-for-beginners/select-site.md)** is important, please choose carefully.

![](img/commercial-register-1.png)

Step 2: Click the upper right corner to switch to **Open Experience Plan Workspace**, enter **Workspace Name**, select **Workspace Language** and Workspace Style. Check the buttom **Synchronize creation of Billing Center account** and click **Register** to open the public cloud Experience Plan of Guance.

![](img/8.register_5.png)


## Quota Inquiry

Owners and administrators of the Guance workspace can view the daily experience quota and usage of each billing item in the **Studio > Billing** module.

If you need to [upgrade to Commercial Plan](commercial-version.md), you can click the **Upgrade** button.

![](img/9.upgrade_1.png)

## Upgrade to Commercial Plan {#upgrade-commercial}

???+ warning "Upgrade Instructions"

    - After the Experience Plan is successfully upgraded to Commercial Plan, <u>it cannot be retreated</u>;
    - The collected data will continue to be reported to the Guance workspace, but <u>the data collected during the experience version will not be viewed</u>.

### Preconditions

- Register [Guance](https://console.guance.com/) account and have an experience workspace;
- Create the account number of [Guance Billing Center](https://boss.guance.com/) synchronously, and connect with the subsequent expense settlement function.

### Go to the Upgrade Page

Enetr **Billing > Package Upgrad**:

![](img/9.upgrade_1.png)

On the Package Upgrade page, click **Upgrade**. Guance supports to <u>buy on demand and pay per use</u>.

> For more plans of billing logic, please refer to the doc [Billing Methods](../billing/billing-method/index.md).

![](img/9.upgrade_2.png)

### Bind Billing Center Account

Enter the account registered in the [Guance Billing Center](https://bill.guance.one/#/signin) for binding, and the **User Name** will be verified here. <u>Please enter the user name of the account opened in the Guance Billing Center</u>.

![](img/9.upgrade_3.png)


If the Billing Center account has not been registered, please click **Register a new account**. Fill in the relevant information and check the opening agreement.

### Successful Upgrade

After agreeing to the Agreement, the workspace was successfully upgraded to the Commercial Plan.

![](img/9.upgrade_5.png)

### Select Settlement Methods

After successfully upgrading to the Commercial Plan, the Guance Billing Center account will be used for settlement by default.

If you need to change other settlement methods, you can click the **Bind Settlement Cloud Account** button above. Currently, Guance supports [three settlement methods](./billing-account/index.md).

![](img/1.upgrade_account.png)

If you have not registered a cloud account, you can select **Alibaba Cloud Account** or **AWS Cloud Account**, and select the settlement method in the pop-up dialog box. 

> Please refer to the specific steps for [Alibaba Cloud Account Settlement](../billing/billing-account/aliyun-account.md), [AWS Account Settlement](../billing/billing-account/aws-account.md) and [Huawei Cloud Account Settlement](../billing/billing-account/huaweicloud-account.md)

![](img/9.upgrade_7.png)

If you choose to use the Guance account for settlement, you can directly close the **Change Settlement Methods** dialog box. If necessary, you can manage and change the settlement method in the **Guance Billing Center > Workspace Management**.

![](img/9.upgrade_9.png)


Returning to **Guance Studio > Billing**, you can see that the current workspace has been upgraded to Commercial Plan.

Click **Billing Center** in the upper right corner to automatically jump to the Guance Billing Center.

![](img/9.upgrade_10.png)





## More Reading


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Get started to Guance products and services**</font>](../getting-started/index.md)

</div>







