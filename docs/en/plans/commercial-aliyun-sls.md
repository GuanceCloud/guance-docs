# Access to Exclusive Plan in Alibaba Cloud Market
---

This article will introduce how to use the exclusiven plan of Guance after purchasing it in Alibaba Cloud Market. Refer to the doc [Register Commercial Plan](../billing/commercial-register.md).

## Perchase Guance Exclusive Plan

Open [Guance Exclusive Plan in Alibaba Cloud market](https://market.aliyun.com/products/56838014/cmgj00060481.html) and click **Getting Started**.

![](img/7.aliyun_sls.png)

### Log in to Alibaba Cloud

If you are not logged in to Alibaba Cloud, prompt your account to log in.

![](img/6.aliyun_7.png)

### Open Guance Pay-per-use Service

After logging in to Alibaba Cloud, return to Alibaba Cloud Selection, click **Getting Started** again, and prompt **Open Pay-per-use Service**. After agreeing to the agreement, click **Open**.

![](img/6.aliyun_9.png)

At the prompt **Open Application Submitted** dialog box, click **Confirm**.

![](img/6.aliyun_10.png)

## Drop-free Guance Exclusive Plan

After confirming the opening application, jump directly to the list of services purchased by Alibaba Cloud to view the purchased instance of the Exclusive Plan of Guance.

<font color=coral>**Note:**</font> Alibaba Cloud account needs real-name authentication to purchase Guance service.

![](img/7.aliyun_sls_1.png)

Click No Login on the right side of the instance. In the pop-up dialog box, click OK.

![](img/7.aliyun_sls_2.png)

Prompt **Register Guance Commercial Plan Immediately** and **Existing Billing Center account**, bind it.

![](img/10.aliyun_market_2.png)

### Register Guance Commercial Plan

If you have never had a Guance account, you can click **Register Guance Commercial Plan** to register.

#### Enter Basic Information

On the basic information page, select the site, enter the registration information, and click next.

???+ warning

    - The joint solution of Guance and SLS only supports China-Hangzhou and China-Zhangjiakou sites, and cannot be changed once the SLS data storage scheme is selected;
    - The entered user name is also used to register the account of the Guance Billing Center. The user name account of the Billing Center will check its uniqueness and cannot be modified once registered;

![](img/7.aliyun_sls_3.png)

#### Enter Enterprise Information

On the Enterprise Information page, enter enterprise information and click **Register**.

![](img/11.account_center_4.png)

#### Select Opening Method

In **Select Opening Method**, fill in **Workspace Name**, and Guance will automatically obtain **Alibaba User ID** and **Commodity Instance ID**.

![](img/10.aliyun_market_4.png)



Click OK, view and agree to Guance platform user service agreement, and click Next.

![](img/1.sls_7.png)

On the page of **Bind Alibaba Cloud Account**, download and obtain SLS authorization file, create Alibaba Cloud RAM account in [Alibaba Cloud studio](https://www.aliyun.com/), and obtain AccessKey ID and AccessKey Secret information of this account. Refer to the doc [RAM Account Authorization](../billing/billing-method/sls-grant.md).

![](img/1.sls_4.jpeg)

Fill in AccessKey ID and AccessKey Secret and verify them. If the verification passes, you can proceed to the next step; If the verification fails, **This AK is invalid, please fill it in again** will be prompted.

![](img/1.sls_6.jpeg)

#### Opening Successfully

After the verification is passed, click **Confirm Opening** and prompt **Successfully Open the Commercial Plan of Guance**.

![](img/1.sls_8.png)

### Bind Guance Workspace

After registering the Guance account, you can return to the bound Guance workspace. Click **Existing Billing Center account, bind it**.

![](img/10.aliyun_market_2.png)

Prompt **How to quickly bind Alibaba Cloud account for settlement**.

![](img/12.aliyun_4.png)

Click OK to start binding the Guance workspace. Before binding the workspace, you need to bind the Billing Center account of Guance.

#### Bind Guance Billing Center account

##### Existing Billing Center account

Enter the user name of the Guance Billing Center account and bind it through email verification.

![](img/7.aliyun_sls_4.png)

##### No Billing Center account yet

If you don't have a Guance Billing Center account yet, you can click **Register** to register a new Guance Billing Center account.

![](img/12.aliyun_6.png)

#### Bind Guance Workspace

After successful binding, enter the binding Guance workspace page. If there is a workspace stored by SLS under your account, the system will automatically obtain and list it.

![](img/7.aliyun_sls_5.png)

##### Bind Existing Workspace

You can select the workspace to bind, click Bind on the right, and enter the email address and verification code in the pop-up dialog box.

> Note: All listed here are SLS storage spaces. If your account has not created a workspace for SLS storage, you can select **Create Workspace**.

![](img/1-aliyun-1109.png)

After clicking **Confirm**, it will be prompted that it is bound.

![](img/2-aliyun-sls.png)



Click OK to prompt that the binding is successful.

![](img/3-aliyun-1109.png)

Click OK to return to the login Guance.

![](img/7.aliyun_sls_9.png)

##### Create a Workspace

If you have not created a workspace, you can click **Create Workspace**, enter the name of the workspace and the email address used when registering the Guance account, and create it.

> Workspace language options affect templates for events, alarms and text messages in the workspace. If you select English, the above corresponding template will be used by default. Once created, the template language of this workspace cannot be modified, so please choose carefully.

![](img/4.register_language_11.png)

##### Register Guance Account

If the Guance account is not registered, you can click Register Guance Account, enter relevant information, and register through mobile phone number verification.

> - Workspace language options affect templates for events, alarms and text messages in the workspace. If you select English, the above corresponding template will be used by default. Once created, the template language of this workspace cannot be modified, so please choose carefully.
> - User name: used to register [Guance studio account](https://auth.guance.com/businessRegister), and will automatically register [Guance Billing Center account](https://boss.guance.com/) with the same user name for you, thus carrying out the subsequent expense settlement process. The user name account of the Billing Center will check its uniqueness and cannot be modified once registered; it is supported to bind the user name and account of the Billing Center. After the binding is completed, the user name cannot be modified. Please operate carefully.

![](img/4.register_language_10.png)

### Start Using Guance

After registration, you can watch the introduction video of Guance, or you can click **Start installing DataKit and configure the first DataKit**.

![](img/1-free-start-1109.png)

#### Synchronize SLS Data

Guance enables you to view other sls data under Alibaba Cloud account synchronously through binding log index. For more details, please refer to the doc [Binding Index](../logs/multi-index.md#sls).

## FAQ on Guance Exclusive Plan 

### Open Guance Exclusive Plan

**1.How to open Exclusive Plan of Guance (SLS storage)?**

You can open the Guance Exclusive Plan according to this document. The Guance Exclusive Plan only supports SLS storage mode. For more storage modes, please refer to the doc [Data Storage Strategy](../billing/billing-method/data-storage.md#options).

**2.If the workspace that has used the Commercial Plan of Guance has been opened, can the Exclusive Plan of Guance be opened again?**

Yes, open the exclusive product entrance of **Alibaba Cloud Market > Guance**, and build a new SLS workspace.

**3.If the workspace of the Commercial Plan of Guance has been opened, can it be switched to the Exclusive Plan of Guance?**

No, the biggest difference between Commercial Plan and SLS Exclusive Plan lies in the location of data storage at the back end. Once the workspace is opened, the index storage ownership cannot be changed. Therefore, no matter what settlement method is the successful Commercial Plan opened before, it cannot be converted into the Exclusive Plan workspace of SLS.

**4.Can the free workspace created when registering be upgraded to the Exclusive Plan of Guance?**

No, at present, it only supports opening SLS Exclusive Plan workspace through Alibaba Cloud Market-Guance Exclusive Plan product portal, and the normal upgrade process does not support opening SLS Exclusive Plan workspace.

### Data viewing problem after opening Exclusive Plan of Guance

**1.Why does SLS have logs, but they can't be displayed in Guance?**

The Default index must have logs, that is, logs collected by Guance DataKit, before Guance log explorer can see the logs of SLS.

**2.Why does the SLS log input appear empty when it is reported?**

As the SLS content field is content, Guance uses message, which needs to be solved by field mapping.

**3.How can the data of SLS console be judged as the user himself or the access data of Guance?**

You can judge by the name of the project. If the name of the project is in the format of `guance-wksp-workspace ID`, it can be considered as the resource and data index created when the Exclusive Plan of Guance SLS is opened. If there is a viewing requirement, you can get <workspace ID> from the workspace-management-basic settings page and find the corresponding data viewing in the SLS studio.

**4.Can the free workspace created when registering be upgraded to the Exclusive Plan of Guance?**

The user's own SLS stored data can be viewed and analyzed in the workspace of Guance. At present, it only supports viewing and analyzing the bound index data, and does not support association analysis with other functional module data for the time being. Refer to the doc [Binding Index](../logs/multi-index.md#sls) for information on how to bind indexes.

### Guance Exclusive Plan Data Storage

**1.How does the Guance Exclusive Plan store data?**

Data such as metrics, logs, backup logs, availability monitoring, CI, security check and events of the Exclusive Plan of Guance are stored in SLS. Besides the above data, infrastructure, application performance monitoring and user access monitoring data are currently ES clusters with Guance.

- Metrics: Metricstore for SLS
- Logs, Availability Monitor, CI, Scheck, Events: Logstore of SLS Standard type
- Backup log: Logstore of type SLS Query

> Note: Because the SLS data expiration policy only supports TTL expiration custom cleanup, Guance's practice of reducing the number of timeseries by adjusting the data preservation policy of measurement does not take effect in the SLS exclusive workspace.

**2.Can I change the data storage area of the Exclusive Plan of Guance?**

No, Guance will create Project and Metricstore and Logstore data indexes in the same Region of SLS according to the Region where the user currently selects the open site. Unless you re-create a new SLS Exclusive Edition workspace, the data storage Region cannot be changed. At present, the Exclusive Plan of Guance only supports China 1 (Hangzhou) site and China 3 (Zhangjiakou) site.

- China 1 (Hangzhou) site opens SLS Exclusive Plan, and the data will be saved in SLS cn-hangzhou Region;
- China 3 (Zhangjiakou) site opens SLS Exclusive Plan, and the data will be saved in SLS cn-zhangjiakou Region;

### Guance Exclusive Plan Billing

**1.After opening the Exclusive Plan of guance, how to charge the log data collected by using Guance collector DataKit?**

The log data collected through DataKit is charged according to Guance log charging logic, which can be found in the doc [billing method](../billing/billing-method/index.md).

**2.If the log data in SLS, how to charge the log data viewed, searched and filtered in Guance studio through the binding log index function provided by Guance?**

SLS log data obtained through index binding, the cost is still charged according to sls. For how to bind indexes, please refer to the doc [Binding Index](../logs/multi-index.md#sls).

If you want to perform data processing, delivery and streaming reading operations from external network access points, the log service charges processing calculation fees, data delivery fees and external network reading traffic fees. For details, please refer to the doc [Billing Items](https://help.aliyun.com/document_detail/107745.htm?spm=a2c4g.11186623.0.0.1d086860NWfUQP#concept-xzl-hjg-vgb).

**3.If the stored-value card in the Billing Center can be used for bill payment of the Exclusive Plan of Guance? How to pay for the Exclusive Plan of Guance?**

Yes, the prerequisite for the Exclusive Plan of Guance is to use Alibaba Cloud account for settlement. For cloud account settlement, the deduction order of Guance pay-by-volume bills is: ordinary vouchers, full reduction vouchers, stored-value cards and cash balance of cloud accounts. SMS and dial-up consumption can only be paid by using stored-value cards and cash balances of cloud accounts.

### Guance Exclusive Plan Function Query

**1.Why can't some query functions be used?**

The language of SLS storage is promql, and some functions cannot be used. For more information about sls functions, refer to the doc [DQL Functions](../dql/funcs.md#sls).

**2. Show Function Tag Related**

The four functions, `show_tag_key`, `show_tag_value`, `show_tag_key_cardinality`, and `show_tag_value_cardinality`, only support querying data for the last 5 minutes, that is, if there is no data for the last 5 minutes, the result of these show functions is 0. The following scenarios exist in the current Guance workspace using the show tag function:

- Functions such as `show_tag_key`, `show_tag_value` are used in view variables
- Metric management page sideslip details page displays label data
- Drop-down list after `group by` when all charts configure metric data query, or filter criteria are added

**3. Does SLS metric query support one DQL to query multiple metric data?**

Not supported and queries are not supported `*`.

**4.If there is a large log in the log data, why may there be incomplete data display?**

At present, only the complete message can be returned according to the query of docid and default list page, and the message will be truncated under other complex filtering conditions, which is determined by the internal implementation of SLS.

### Guance Exclusive Plan Field Filter

**1.Why can't you filter fields after opening the Exclusive Plan of Guance?**

Guance will automatically create a field index for log data containing the same fields for field filtering, but if the amount of data is small, automatic creation will not be triggered. In this case, you cannot query data through field filtering in Guance, and you can solve this problem by reporting more log data containing the same fields.

> Note: If the time interval between the data reported when the field index is not created and the data reported when the field index is created is too long, It may cause the data reported when the field index is not created to be unable to pass the field filtering query. For example, two pieces of data of the same field were reported yesterday, and the field index was not created. Today, 100 pieces of data of the same field as yesterday were reported, and the field index was automatically created. During the field filtering, the two pieces of data reported yesterday may not be found.

### Difference between Exclusive Plan and Commercial Plan of Guance

**1. Why is SLS Exclusive Log Search not highlighted?**

As the SLS log search highlighting function is temporarily closed to the public and only supports the SLS studio, there will be no highlighting effect when some keywords are matched to the log on the current Guance.

**2. Does the SLS Exclusive Workspace support deleting a single measurement?**

Not supported, only deleting all measurements is supported at present.

**3. Why can't the newly reported field data in SLS exclusive workspace support filtering and sorting?**

The current SLS field index will have a delay time of 1 minute. For example, it takes 1 minute to cut out a new field through Pipeline before searching for a new field, and the data within that 1 minute delay still cannot be filtered and searched; ES cuts out new fields that can be searched immediately. This problem also affects the use of functions such as Generate Metrics and other chart queries.

**4. Does the SLS Exclusive Workspace support index merging?**

Not supported. SLS Exclusive Workspace has multiple indexes on by default. For multiple indexes, refer to the doc [Log Index](../logs/multi-index.md). By default, index merging is turned on in the commercial workspace to reduce the generation of indexes.

**5. Why is the SLS Exclusive Workspace Log Time Sequence out of order?**

As the SLS date field is accurate to the second level, and the log data time of Guance is to the millisecond level, the log sorting in the SLS workspace may have abnormal ascending and descending order. By default, only the data in a single page can be ordered, and the global order across pages is not guaranteed.

**6. Why do SLS time series data write duplicates?**

SLS time series data will be written repeatedly in the same timestamp data, which is caused by the characteristic problem of SLS.
