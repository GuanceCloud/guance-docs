# Activate Guance Exclusive Plan on Alibaba Cloud Marketplace

---

This article will guide you through purchasing and activating the Guance Exclusive Plan on Alibaba Cloud Marketplace.

## Step 1: Purchase Guance Exclusive Plan

1. Log in to Alibaba Cloud, go to [Guance Exclusive Plan on Alibaba Cloud Marketplace](https://market.aliyun.com/products/56838014/cmgj00060481.html), and click **Activate Now**.

![](img/7.aliyun_sls.png)

2. Confirm the activation of pay-as-you-go services, agree to the terms, and click **Activate**.

<img src="../img/6.aliyun_9.png" width="45%" >

3. After activation, proceed to the console.

<img src="../img/6.aliyun_10.png" width="45%" >

## Step 2: Direct Login to Guance

After confirming the activation request, you will be redirected to the list of purchased services on Alibaba Cloud to view the instance of the Guance Exclusive Plan.

![](img/7.aliyun_sls_1.png)

Click **Direct Login** on the right side of the instance. In the pop-up dialog, click **Confirm**.

![](img/7.aliyun_sls_2.png)

On the Guance side, if the current Alibaba Cloud account ID is not linked to a Guance billing center account, two scenarios may occur:

:material-numeric-1-circle-outline: [No Billing Center Account](#method): You need to register for a Guance account and billing center account to link and settle cloud accounts;

:material-numeric-2-circle-outline: [Has Billing Center Account](#bond): You can directly link the billing center account to settle cloud accounts.

![](img/10.aliyun_market_2.png)

???+ warning "What is a Billing Center Account?"

    A billing center account is an independent account within the Guance billing platform used to manage Commercial Plan billing. It allows a single account to associate multiple workspaces for unified billing management.

    The overall process is as follows:

    <img src="../img/17.process_1.png" width="60%" >


### Register Guance Commercial Plan {#method}

If you do not have a billing center account, click Next to automatically redirect to the registration page. Complete the registration process to obtain a Guance account and billing center account.

1. Fill in basic information;
2. Fill in company information;
3. Choose activation method: Enter workspace name, select workspace language, input [Account ID](#uid), [Product Instance ID](#entity-id);
4. Click **Confirm**;
5. Review and agree to the Guance platform user service agreement, then click **Next**.

![](img/4.register_language_1.png)

???+ warning

    - The joint solution of Guance and SLS only supports "China Region - Hangzhou" and "China Region - Zhangjiakou" sites. Once SLS data storage is selected, it cannot be changed;
    - The entered **username** is also used to register the Guance billing center account. The billing center username must be unique and cannot be modified once registered.


#### Binding Alibaba Cloud Account

On the **Bind Alibaba Cloud Account** page, Guance provides two authorization methods to ensure your data security: **RAM Account Authorization** and **Third-party Quick Authorization**.

![](img/billing-6.png)

##### RAM Account Authorization

Select **RAM Account Authorization**, download the SLS authorization file, and create an Alibaba Cloud RAM account on the [Alibaba Cloud Console](https://www.aliyun.com/) to get the AccessKey ID and AccessKey Secret information.

> For detailed instructions on authorizing RAM accounts using the SLS authorization file, refer to [RAM Account Authorization](../plans/sls-grant.md).

![](img/1.sls_4.jpeg)

Enter the AccessKey ID and AccessKey Secret and verify them. If verification is successful, you can proceed to the next step.

![](img/1.sls_6.jpeg)

##### Third-party Quick Authorization

Select **Third-party Quick Authorization** and click **Go to Authorization**. This will redirect you to Alibaba Cloud to log in and authorize.

![](img/billing-auth.png)

Click **Agree Authorization**, and a **Service Provider UID Verification** window will appear. To get the UID, click **Service Provider Permissions Page**.

![](img/index-2.png)

Enter the UID and click Confirm. You will be automatically redirected to **Alibaba Cloud Marketplace > Purchased Services**, indicating that authorization is complete.

Return to the Guance **Bind Alibaba Cloud Account** page and click **Verify**. After successful verification, click **Confirm Activation**.

???+ warning "Issues You May Encounter"

    - The Guance Exclusive Plan uses SLS storage. If your cloud account has **not activated Alibaba Cloud Log Service SLS**, you will not be able to use the log storage service normally;
  
    - Cross-account role authorization requires the use of an **Alibaba Cloud main account** or a sub-account with **RAM access control permissions (GetRole, GetPolicy, CreatePolicy, CreatePolicyVersion, CreateRole, UpdateRole, AttachPolicyToRole)**;

    - During verification, if the verified sub-account is authorized, it will automatically locate to the main account, pulling projects and Logstores under the main account;  
    
    - If verification fails, check if cloud resource access authorization is completed. Go to **Alibaba Cloud RAM Console > RAM Access Control > Roles/Authorization** to review;

    ![](img/ex.png)

    ![](img/ex-1.png)


Step 4: Activation Successful

After successful verification, click **Confirm Activation**, and you will see a message indicating **Successful Activation of Guance Commercial Plan**.

![](img/1.sls_8.png)

### Bind Guance Workspace

If you already have a Guance account, click **Existing Billing Center Account, Bind Now** to prompt how to quickly bind the Alibaba Cloud account for billing.

![](img/15.aliyun_register_1.png)

Click **Understood**, start binding the Guance workspace. Before binding the workspace, you need to first bind the Guance billing center account.

#### Bind Guance Billing Center Account

- Site: Select the site for creating subsequent workspaces;  
- Username: If you already have a Guance billing center account, enter the **username** of the Guance billing center account and verify via email to bind;
- Registration: If you do not yet have a Guance billing center account, register first.

![](img/10.market_aliyun_1.png)

#### Bind Guance Workspace

=== "Bind Existing Workspace"

    If you have existing workspaces under the Guance billing center account, click **Bind** and confirm in the pop-up dialog.

    **Note**: The listed items are all SLS storage spaces. If your account has not created SLS storage workspaces, you can choose to create a workspace.

    ![](img/15.aliyun_register_6.1.png)

    Redirect to the **Bind Guance Workspace** page, indicating binding is complete.

    ![](img/15.aliyun_register_6.png)

    Click **Confirm**, showing activation success.

    ![](img/15.aliyun_register_7.png)

=== "Create Workspace"

    If you have registered a Guance account but have not created a workspace, click **Create Workspace** first.

    ![](img/1-1-commercial-aliyun.png)

    Enter workspace name, select workspace language, and input the email used during Guance account registration, verifying via email to create.

    **Note**: Workspaces are collaboration spaces for Guance data insights. The workspace language option affects event, alert, SMS templates within the workspace. If English is chosen, the corresponding templates will default to English. Once created, the workspace template language cannot be modified, so please choose carefully.

    ![](img/15.aliyun_register_5.png)

    After successfully creating the workspace, bind the Alibaba Cloud account. Download the SLS authorization file from the Alibaba Cloud console to create AK/AKS and authorize, then fill in the AK/AKS information in the dialog box for verification.

    ![](img/15.aliyun_register_sls_2.png)

    After successful verification and confirmation, you will be redirected to the **Bind Guance Workspace** page, indicating the workspace is **Bound**.

    ![](img/15.aliyun_register_6.png)

    Click **Confirm**, redirecting to the **Successfully Bound Guance Workspace** page.

    ![](img/15.aliyun_register_7.png)

=== "Register Guance Account"

    If you have never used Guance services before, register a Guance account and create a workspace.

    ![](img/1-2-commercial-aliyun.png)

    Click **Register Guance Account**, enter relevant information, and verify via email to register.

    **Note**: Workspaces are collaboration spaces for Guance data insights. The workspace language option affects event, alert, SMS templates within the workspace. If English is chosen, the corresponding templates will default to English. Once created, the workspace template language cannot be modified, so please choose carefully.

    ![](img/15.aliyun_register_3.png)


### Start Using Guance

After registration, you can start using the Guance Exclusive Plan.

#### Sync SLS Data

Guance supports synchronizing and viewing other SLS data under your Alibaba Cloud account through [binding log indexes](../logs/multi-index.md#sls).

## How to Obtain Account ID {#uid}

### Alibaba Cloud Main Account

Log in to [Alibaba Cloud](https://www.aliyun.com) with the main account, enter the Alibaba Cloud console, click the account avatar in the top-right corner to find the Account ID.

![](../img/6.aliyun_2.png)

<!--

### Alibaba Cloud RAM Sub-Account

Log in to [Alibaba Cloud](https://www.aliyun.com) via RAM, enter the Alibaba Cloud console, click the account avatar in the top-right corner to find the main account UID after the @ in the RAM account.

![](../img/20.aliyun_3.png)
-->

## How to Obtain Product Instance ID {#entity-id}

After confirming the activation request on Alibaba Cloud, you will be redirected to the list of purchased services. Below the purchased Guance service, you can view the **Instance ID**. Copy this **Instance ID** and enter it into the **Product Instance ID** field in the settlement change dialog box.

![](../img/10.aliyun_market_5.png)


## FAQ

### Version

:material-chat-question: Can I activate the Guance Exclusive Plan if I have already activated the Guance Commercial Plan workspace?

Yes, you can activate the Guance Exclusive Plan through the **Alibaba Cloud Marketplace > Guance Exclusive Plan** product entry and create a new SLS workspace.

:material-chat-question: Can an already activated Guance Commercial Plan workspace be switched to the Guance Exclusive Plan?

No, the main difference between the Commercial Plan and the SLS Exclusive Plan lies in the backend data storage location. Once a workspace is activated, the index storage location cannot be changed. Therefore, regardless of the billing method used for the previously activated Commercial Plan, it cannot be converted into an SLS Exclusive Plan workspace.

:material-chat-question: Can a Free Plan workspace created during registration be upgraded to the Guance Exclusive Plan?

No, currently, only the Guance Exclusive Plan workspace can be activated through the Alibaba Cloud Marketplace - Guance Exclusive Plan product entry. The normal upgrade process does not support activating the SLS Exclusive Plan workspace.

### Data Viewing

:material-chat-question: Why are there logs in SLS but not visible in Guance?

The Default index must contain logs collected by the Guance DataKit for the Guance log viewer to display SLS logs.

:material-chat-question: Why does the content appear empty after reporting SLS logs?

Since the content field in SLS is `content`, while Guance uses `message`, a field mapping is required to resolve this.

:material-chat-question: How can you determine whether the data in the SLS console is from the user or Guance's integration?

You can judge by the project name. If the project name is in the format `guance-wksp-WorkspaceID`, it indicates resources and data indexes created when activating the Guance SLS Exclusive Plan. For viewing needs, you can obtain the **Workspace ID** from the **Workspace > Management > Basic Settings** page and find the corresponding data in the SLS console.

:material-chat-question: Can users' own SLS stored data be viewed in Guance?

Users' own SLS stored data can be viewed and analyzed in the Guance workspace. Currently, only bound index data can be viewed and analyzed, and it does not support association analysis with other functional module data.

> Refer to [Binding Indexes](../logs/multi-index.md#sls) for more details.

### Data Storage

:material-chat-question: How does the Guance Exclusive Plan store data?

Data such as metrics, logs, backup logs, Synthetic Tests, CI, Security Check, and events in the Guance Exclusive Plan are stored in SLS. Infrastructure, APM, and RUM data are stored in the Guance ES cluster.

- Metrics: SLS Metricstore;
- Logs, Synthetic Tests, CI visualization, Security Check, Events: SLS Standard Logstore;
- Backup logs: SLS Query Logstore.

**Note**: Since SLS's data expiration policy only supports TTL-based automatic deletion, reducing Time Series quantity by adjusting measurement retention policies does not apply to the SLS Exclusive Plan workspace.

:material-chat-question: Can the region for data storage in the Guance Exclusive Plan be changed?

No, Guance creates Projects and Metricstores and Logstores in the same Region based on the selected site during activation. Unless creating a new SLS Exclusive Plan workspace, the data storage Region cannot be changed. Currently, the Guance Exclusive Plan only supports "China Region 1 (Hangzhou)" and "China Region 3 (Zhangjiakou)" sites.

- China Region 1 (Hangzhou) site activates SLS Exclusive Plan, data is stored in the "cn-hangzhou" Region of SLS;
- China Region 3 (Zhangjiakou) site activates SLS Exclusive Plan, data is stored in the "cn-zhangjiakou" Region of SLS;

### Billing

:material-chat-question: How is data collected by the Guance DataKit billed after activating the Guance Exclusive Plan?

Logs collected by DataKit are charged according to the Guance log [billing method](../billing-method/index.md).

:material-chat-question: How are logs viewed, searched, and filtered on the Guance console through the SLS log index binding feature billed?

SLS log data obtained through [index binding](../logs/multi-index.md#sls) is still billed by SLS.

If you perform data processing, delivery, or stream reading from external network endpoints, the Log Service charges processing fees, delivery fees, and external network read traffic fees.

> Refer to [Billing Items](https://help.aliyun.com/document_detail/107745.htm?spm=a2c4g.11186623.0.0.1d086860NWfUQP#concept-xzl-hjg-vgb) for more details.

:material-chat-question: Can pre-purchased cards in the billing center be used for Guance Exclusive Plan billing? How is payment made for the Guance Exclusive Plan?

Yes, the prerequisite for the Guance Exclusive Plan is using the Alibaba Cloud account for settlement. For cloud account settlement, the deduction order for pay-as-you-go bills is: regular coupons, discount coupons, pre-purchased cards, and cloud account cash balance. SMS and dial testing pay-as-you-go consumption can only be paid using pre-purchased cards and cloud account cash balance.

### Function Queries

:material-chat-question: Why are some query functions unavailable?

SLS storage uses promql, which does not support certain functions.

> Refer to [DQL Functions](../dql/funcs.md#sls) for more details about SLS functions.

:material-chat-question: Show function tag-related issues

`show_tag_key`, `show_tag_value`, `show_tag_key_cardinality`, `show_tag_value_cardinality` only support querying data from the last 5 minutes. If no data exists within the last 5 minutes, these show functions return 0. The following scenarios in the current Guance workspace use show tag functions:

- View variables using `show_tag_key`, `show_tag_value`, etc.;
- Display label data on the metric management page detail pane;
- When configuring charts, the drop-down list after `group by` or adding filter conditions.

:material-chat-question: Does SLS metric queries support querying multiple metric data in one DQL query?

No, it does not support querying `*`.

:material-chat-question: Why might large logs result in incomplete data display?

Currently, only complete messages are guaranteed based on docid and default list page queries. Other complex filtering conditions may truncate the message, determined by the internal implementation of SLS.

### Field Filtering

:material-chat-question: Why can't I filter fields after activating the Guance Exclusive Plan?

Guance automatically creates field indexes for logs containing the same fields to enable field filtering. However, if the data volume is small, automatic creation will not be triggered, preventing field filtering in Guance. Reporting more logs with the same fields can resolve this issue.

**Note**: If the time interval between data reported before and after creating field indexes is too long, data reported before creating field indexes may not be queryable using field filters. For example, if 2 logs with the same fields were reported yesterday without creating field indexes, and 100 logs with the same fields were reported today, automatically creating field indexes today might prevent querying the 2 logs from yesterday.

### Exclusive Plan vs Commercial Plan

:material-chat-question: Why is log search in the SLS Exclusive Plan not highlighted?

Because the SLS log search highlight feature is temporarily not open to the public and only supported in the SLS console, currently, log searches on Guance do not have highlighting effects.

:material-chat-question: Does the SLS Exclusive Plan workspace support deleting individual Mearsurement sets?

No, currently only supports deleting all Mearsurement sets.

:material-chat-question: Why can newly reported fields in the SLS Exclusive Plan workspace not be filtered or sorted?

SLS field indexes have a 1-minute delay. For example, new fields extracted via Pipeline require 1 minute before they can be searched. Data within this 1-minute delay remains unsearchable and unsortable. ES-extracted new fields can be immediately searched. This issue also affects the use of "Generate Metrics" and other chart query features.

:material-chat-question: Does the SLS Exclusive Plan workspace support index merging?

No, the SLS Exclusive Plan workspace defaults to multi-index. The Commercial Plan workspace defaults to index merging to reduce index generation.

> Refer to [Log Indexes](../logs/multi-index/index.md) for more details.

:material-chat-question: Why is the log time sequence in the SLS Exclusive Plan workspace out of order?

Since the SLS date field is precise to the second level, while Guance log timestamps are to the millisecond level, sorting in the SLS workspace may result in abnormal ascending/descending orders. By default, only data within a single page is ordered, not globally across pages.

:material-chat-question: Why does SLS time series data write duplicates?

SLS time series data may write duplicates at the same timestamp due to SLS characteristics.