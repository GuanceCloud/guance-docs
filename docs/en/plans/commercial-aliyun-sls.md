# Alibaba Cloud Market开通 <<< custom_key.brand_name >>> Exclusive Plan
---

This document will introduce the relevant activation and usage operations for purchasing the <<< custom_key.brand_name >>> Exclusive Plan on Alibaba Cloud Market.


## Step One: Purchase <<< custom_key.brand_name >>> Exclusive Plan

1. Log in to Alibaba Cloud, enter [Alibaba Cloud Market <<< custom_key.brand_name >>> Exclusive Plan](https://market.aliyun.com/products/56838014/cmgj00060481.html), and click **Activate Now**.

![](img/7.aliyun_sls.png)


2. A prompt appears saying **Activate Pay-As-You-Go Service**. After agreeing to the agreement, click **Activate**.

<img src="../img/6.aliyun_9.png" width="45%" >

3. Go to the console after activation.

<img src="../img/6.aliyun_10.png" width="45%" >

## Step Two: Direct Login to <<< custom_key.brand_name >>>

After confirming the activation request, you will be redirected to the list of purchased services on Alibaba Cloud to view the purchased <<< custom_key.brand_name >>> Exclusive Plan instance.

![](img/7.aliyun_sls_1.png)

Click **Direct Login** on the right side of the instance. In the pop-up dialog box, click **Confirm**.

![](img/7.aliyun_sls_2.png)

On the <<< custom_key.brand_name >>> side, if the current Alibaba Cloud account ID is not bound to a <<< custom_key.brand_name >>> Billing Center account, two scenarios may occur:

:material-numeric-1-circle-outline: [No Billing Center Account](#method): You need to register a <<< custom_key.brand_name >>> account and a Billing Center account to achieve cloud account binding for settlement;

:material-numeric-2-circle-outline: [Has Billing Center Account](#bond): You can directly bind the Billing Center account to achieve cloud account settlement.

![](img/10.aliyun_market_2.png)


???+ warning "What is a Billing Center Account?"

    The Billing Center account is an independent account within the <<< custom_key.brand_name >>> Billing Center platform used for managing Commercial Plan billing. It allows a single account to be associated with multiple workspaces for unified billing processing.

    Refer to the overall process as follows:

    <img src="../img/17.process_1.png" width="60%" >


### Register <<< custom_key.brand_name >>> Commercial Plan {#method}

If you do not have a Billing Center account, click Next to automatically redirect to the registration page. Complete the registration process to obtain a <<< custom_key.brand_name >>> account and a Billing Center account.

1. Fill in basic information;
2. Fill in company information;
3. Choose activation method: Enter workspace name, select workspace language, input [Account ID](#uid), [Product Instance ID](#entity-id);
4. Click **Confirm**;
5. Review and agree to the <<< custom_key.brand_name >>> Platform User Service Agreement, then click **Next**.

![](img/4.register_language_1.png)

???+ warning

    - <<< custom_key.brand_name >>>, SLS joint solution only supports “China Region-Hangzhou”, “China Region-Zhangjiakou” sites. Once you choose the SLS data storage solution, it cannot be changed;
    - The entered **username** is also used to register the <<< custom_key.brand_name >>> Billing Center account. The Billing Center username will check for uniqueness and cannot be modified once registered;


#### Bind Alibaba Cloud Account

On the **Bind Alibaba Cloud Account** page, <<< custom_key.brand_name >>> provides two authorization methods to ensure your data security: **RAM Account Authorization**, **Third-party Quick Authorization**.

![](img/billing-6.png)

##### RAM Account Authorization

Choose **RAM Account Authorization**, download the SLS authorization file, and create an Alibaba Cloud RAM account on the [Alibaba Cloud Console](https://www.aliyun.com/) to get the AccessKey ID, AccessKey Secret information.

> For detailed operations on authorizing a RAM account using the SLS authorization file, refer to [RAM Account Authorization](../plans/sls-grant.md).

![](img/1.sls_4.jpeg)

Fill in the AccessKey ID, AccessKey Secret, and verify. If verification passes, proceed to the next step.

![](img/1.sls_6.jpeg)

##### Third-party Quick Authorization

Choose **Third-party Quick Authorization**, click **Proceed to Authorization**. You will be redirected to Alibaba Cloud, log in, and perform the authorization operation;   

![](img/billing-auth.png)

Click **Agree to Authorization**, a **Service Provider UID Verification** window pops up. UID can be obtained by clicking **Service Provider Permissions Page**.

![](img/index-2.png)

Enter the UID and click Confirm. Automatically redirect to **Alibaba Cloud Market > Purchased Services**, at this point authorization is complete.

Return to the <<< custom_key.brand_name >>> **Bind Alibaba Cloud Account** page, click **Verify**. After successful verification, click **Confirm Activation**.

???+ warning "Some Issues You May Encounter"
    
    - <<< custom_key.brand_name >>> Exclusive Plan uses SLS storage. If your cloud account<u>has not activated Alibaba Cloud Log Service SLS</u>, it will not be able to use the log storage service normally；
  
    - Cross-account role authorization operations require<u>Alibaba Cloud main account</u> or<u>sub-account authorized with RAM Access Control GetRole, GetPolicy, CreatePolicy, CreatePolicyVersion, CreateRole, UpdateRole, AttachPolicyToRole permissions</u>;

    - During verification, if verifying a sub-account, it will automatically locate to the main account of that sub-account and fetch the project and Logstore under the main account;  
    
    - If verification fails, check if cloud resource access authorization has been completed. Go to **Alibaba Cloud RAM Console > RAM Access Control > Roles/Authorization** to view;

    ![](img/ex.png)

    ![](img/ex-1.png)


Step Four: Successful Activation

After successful verification, click **Confirm Activation**, a prompt will appear indicating **<<< custom_key.brand_name >>> Commercial Plan Activated Successfully**.

![](img/1.sls_8.png)

### Binding <<< custom_key.brand_name >>> Workspace

If you already have a <<< custom_key.brand_name >>> account, you can click **Already Have Billing Center Account, Bind Now** to see how to quickly bind the Alibaba Cloud account for settlement.

![](img/15.aliyun_register_1.png)

Click **Understood**, start binding <<< custom_key.brand_name >>> workspace. Before binding the workspace, you need to bind the <<< custom_key.brand_name >>> Billing Center account first.

#### Bind <<< custom_key.brand_name >>> Billing Center Account

- Site: Choose the site for creating subsequent workspaces;
- Username: If you already have a <<< custom_key.brand_name >>> Billing Center account, you can directly input the <<< custom_key.brand_name >>> Billing Center account **Username**, verify via email for binding;
- Registration: If you do not yet have a <<< custom_key.brand_name >>> Billing Center account, you can register first.

![](img/10.market_aliyun_1.png)

#### Bind <<< custom_key.brand_name >>> Workspace

=== "Bind Existing Workspace"

    If there are existing bindable workspaces under your <<< custom_key.brand_name >>> Billing Center account, click **Bind** and confirm binding in the pop-up dialog box.

    **Note**: All listed here are SLS storage spaces. If your account has not created an SLS storage workspace, you can choose to create a workspace.

    ![](img/15.aliyun_register_6.1.png)

    Redirect to the **Bind <<< custom_key.brand_name >>> Workspace** page, showing binding success.

    ![](img/15.aliyun_register_6.png)

    Click **Confirm**, showing activation success.

    ![](img/15.aliyun_register_7.png)

=== "Create Workspace"

    If you have registered a <<< custom_key.brand_name >>> account but have not yet created a workspace, click **Create Workspace** first.

    ![](img/1-1-commercial-aliyun.png)

    Input workspace name, select workspace language, input the email used during <<< custom_key.brand_name >>> account registration, and verify via email to create.

    **Note**: The workspace is a collaboration space for <<< custom_key.brand_name >>> data insights. The workspace language option affects templates for events, alerts, SMS, etc., within the workspace. If English is chosen, the corresponding templates will default to English templates. Once created, the template language of this workspace cannot be modified, please choose carefully.

    ![](img/15.aliyun_register_5.png)

    After successfully creating the workspace, you need to bind the Alibaba Cloud account. You can download the SLS authorization file to create AK/AKS in the Alibaba Cloud console and authorize, then fill in the AK/AKS information in the following dialog box for verification.

    ![](img/15.aliyun_register_sls_2.png)

    After successful AK/AKS information verification and confirmation of activation, it will automatically redirect to the **Bind <<< custom_key.brand_name >>> Workspace** page, showing the workspace **Bound**.

    ![](img/15.aliyun_register_6.png)

    Click **Confirm**, redirecting to the **Successfully Bound <<< custom_key.brand_name >>> Workspace** page.

    ![](img/15.aliyun_register_7.png)

=== "Register <<< custom_key.brand_name >>> Account"

    If you have never used <<< custom_key.brand_name >>> services before, please register a <<< custom_key.brand_name >>> account and create a workspace first.

    ![](img/1-2-commercial-aliyun.png)

    Click **Register <<< custom_key.brand_name >>> Account**, input relevant information, and register via email verification.

    **Note**: The workspace is a collaboration space for <<< custom_key.brand_name >>> data insights. The workspace language option affects templates for events, alerts, SMS, etc., within the workspace. If English is chosen, the corresponding templates will default to English templates. Once created, the template language of this workspace cannot be modified, please choose carefully.

    ![](img/15.aliyun_register_3.png)


### Start Using <<< custom_key.brand_name >>>

After completing the registration, you can start using <<< custom_key.brand_name >>> Exclusive Plan.

#### Sync SLS Data

<<< custom_key.brand_name >>> supports you to synchronize and view other SLS data under your Alibaba Cloud account through [binding log indexes](../logs/multi-index.md#sls).

## How to Obtain Account ID {#uid}

### Alibaba Cloud Main Account

Log in to [Alibaba Cloud](https://www.aliyun.com) with the main account, enter the Alibaba Cloud console, click the account avatar in the upper-right corner to find the account ID.

![](../img/6.aliyun_2.png)

<!--

### Alibaba Cloud RAM Sub-Account

Log in to [Alibaba Cloud](https://www.aliyun.com) via RAM, enter the Alibaba Cloud console, click the account avatar in the upper-right corner to find the main account UID after @ in the RAM account.

![](../img/20.aliyun_3.png)
-->

## How to Obtain Product Instance ID {#entity-id}

After <<< custom_key.brand_name >>> confirms the activation request on Alibaba Cloud Heart Selection, it directly redirects to the list of purchased services on Alibaba Cloud. Under the purchased <<< custom_key.brand_name >>> service, you can view the **Instance ID** of the product. Copy this **Instance ID** and fill it into the **Product Instance ID** field in the change settlement method dialog box.

![](../img/10.aliyun_market_5.png)


## FAQ

### Version

:material-chat-question: Can a workspace already opened with <<< custom_key.brand_name >>> Commercial Plan be reopened with <<< custom_key.brand_name >>> Exclusive Plan?

Yes, you can activate it through the **Alibaba Cloud Market > <<< custom_key.brand_name >>> Exclusive Plan** product entry, creating a new SLS workspace.

:material-chat-question: Can a workspace already opened with <<< custom_key.brand_name >>> Commercial Plan be switched to <<< custom_key.brand_name >>> Exclusive Plan?

No, the main difference between Commercial Plan and SLS Exclusive Plan lies in the backend data storage location. Once a workspace is opened, the index storage location cannot be changed. Therefore, regardless of the previous settlement method of the successfully opened Commercial Plan, it cannot be converted into an SLS Exclusive Plan workspace.

:material-chat-question: Can a Free Plan workspace created during registration be upgraded to <<< custom_key.brand_name >>> Exclusive Plan?

No, currently only support opening an SLS Exclusive Plan workspace through the Alibaba Cloud Market - <<< custom_key.brand_name >>> Exclusive Plan product entry. Normal upgrade procedures do not support opening an SLS Exclusive Plan workspace.

### Data Viewing

:material-chat-question: Why does SLS have logs, but they are not displayed in <<< custom_key.brand_name >>>?

The Default index must contain logs, i.e., logs collected by <<< custom_key.brand_name >>> DataKit. Only then can <<< custom_key.brand_name >>> Log Viewer display SLS logs.

:material-chat-question: Why does the content show as empty after reporting SLS logs?

Since the content field in SLS is `content` while <<< custom_key.brand_name >>> uses `message`, you need to resolve this through field mapping.

:material-chat-question: How can I determine whether the data in the SLS console is from the user or <<< custom_key.brand_name >>> integration?

You can judge by the project name. If the project name is in the format `guance-wksp-WorkspaceID`, it can be considered as resources and data indexes created by <<< custom_key.brand_name >>> when activating the SLS Exclusive Plan. If you need to view, you can get the **Workspace ID** from the **Workspace > Management > Basic Settings** page and find the corresponding data in the SLS console.

:material-chat-question: Can users' own SLS stored data be viewed using <<< custom_key.brand_name >>>?

Users' own SLS stored data can be viewed and analyzed in <<< custom_key.brand_name >>>'s workspace. Currently, it only supports viewing and analyzing bound index data and does not support correlation analysis with data from other feature modules.

> For details on how to bind indexes, refer to [Binding Indexes](../logs/multi-index.md#sls).

### Data Storage

:material-chat-question: How does <<< custom_key.brand_name >>> Exclusive Plan store data?

<<< custom_key.brand_name >>> Exclusive Plan stores metrics, logs, backup logs, Synthetic Tests, CI, Security Check, incidents, etc., in SLS. Infrastructure, APM, RUM data currently reside in <<< custom_key.brand_name >>> ES cluster except for the above data.

- Metrics: SLS's Metricstore;
- Logs, Synthetic Tests, CI visualization, Security Check, incidents: SLS Standard type Logstore;
- Backup logs: SLS Query type Logstore.

**Note**: Since SLS's data expiration policy only supports TTL-based automatic deletion, <<< custom_key.brand_name >>>'s approach of reducing Time Series counts by adjusting measurement retention policies does not apply to SLS Exclusive Plan workspaces.

:material-chat-question: Can the region for <<< custom_key.brand_name >>> Exclusive Plan data storage be changed?

No, <<< custom_key.brand_name >>> synchronizes Project and Metricstore creation in the same Region as the selected site when opening the SLS Exclusive Plan. Unless creating a new SLS Exclusive Plan workspace, the data storage Region cannot be changed. Currently, <<< custom_key.brand_name >>> Exclusive Plan only supports “China Region 1 (Hangzhou)” and “China Region 3 (Zhangjiakou)” sites.

- Opening SLS Exclusive Plan in China Region 1 (Hangzhou) site stores data in SLS “cn-hangzhou” Region;
- Opening SLS Exclusive Plan in China Region 3 (Zhangjiakou) site stores data in SLS “cn-zhangjiakou” Region;

### Billing

:material-chat-question: After activating <<< custom_key.brand_name >>> Exclusive Plan, how are logs collected by <<< custom_key.brand_name >>> DataKit billed?

Logs collected by DataKit are charged according to <<< custom_key.brand_name >>> log [billing method](../billing-method/index.md).

:material-chat-question: If logs in SLS are viewed, searched, and filtered through <<< custom_key.brand_name >>> provided index binding function in the <<< custom_key.brand_name >>> console, how are these logs billed?

Logs obtained through [index binding](../logs/multi-index.md#sls) from SLS are still billed according to SLS.

If you perform data processing, delivery, or stream reading from external internet endpoints, Log Service charges for processing computation, data delivery fees, and external internet read traffic fees.

> For more details, refer to [Billing Items](https://help.aliyun.com/document_detail/107745.htm?spm=a2c4g.11186623.0.0.1d086860NWfUQP#concept-xzl-hjg-vgb).

:material-chat-question: Can prepaid cards previously purchased in the Billing Center be used to pay <<< custom_key.brand_name >>> Exclusive Plan bills? How does <<< custom_key.brand_name >>> Exclusive Plan payment work?

Yes, the prerequisite for <<< custom_key.brand_name >>> Exclusive Plan is using Alibaba Cloud account settlement. For cloud account settlement, <<< custom_key.brand_name >>> charges in pay-as-you-go order: general coupons, discount coupons, prepaid cards, cloud account balance. SMS and dial testing pay-as-you-go consumption can only be paid using prepaid cards and cloud account balance.

### Function Queries

:material-chat-question: Why are some query functions unavailable?

SLS storage uses promql language, which results in some functions being unavailable.

> For more about SLS function information, refer to [DQL Functions](../dql/funcs.md#sls).

:material-chat-question: Show function tag related

`show_tag_key`, `show_tag_value`, `show_tag_key_cardinality`, `show_tag_value_cardinality` these four functions only support querying data from the last 5 minutes. If no data was generated in the last 5 minutes, these show functions will return 0. The following scenarios in the current <<< custom_key.brand_name >>> workspace use show tag functions:

- View variables using `show_tag_key`, `show_tag_value` functions;
- Display tag data on the metric management page slide-out detail page;
- When configuring chart metrics queries, the drop-down list after `group by` or adding filter conditions.

:material-chat-question: Does SLS metric query support querying multiple metric data with one DQL query?

No, it does not support querying `*`.

:material-chat-question: Why might large log data result in incomplete data display?

Currently, only the complete message can be guaranteed based on docid and default list page queries. Other complex filtering conditions will truncate the message, determined by the internal implementation of SLS.

### Field Filtering

:material-chat-question: Why can't field filtering be performed after activating <<< custom_key.brand_name >>> Exclusive Plan?

<<< custom_key.brand_name >>> automatically creates field indexes for log data containing the same fields for field filtering, but if the data volume is small, it won't trigger automatic creation. In such cases, you cannot query data using field filtering in <<< custom_key.brand_name >>>. You can solve this by submitting more log data containing the same fields.

**Note**: If the time interval between data submission before and after field index creation is too long, it may lead to data submitted before field index creation not being queryable via field filtering. For example, if you submitted 2 log entries with the same fields yesterday without creating field indexes and today submitted 100 log entries with the same fields, automatically creating field indexes, during field filtering, you might not find the 2 log entries submitted yesterday.

### Exclusive Plan VS Commercial Plan

:material-chat-question: Why does SLS Exclusive Plan log search lack highlighting?

Because the SLS log search highlighting feature is temporarily not open to the public and only available in the SLS console, currently <<< custom_key.brand_name >>> does not have the highlighting effect when searching for logs matching certain keywords.

:material-chat-question: Does SLS Exclusive Plan workspace support deleting individual measurement sets?

No, currently only supports deleting all measurement sets.

:material-chat-question: Why does newly reported field data in SLS Exclusive Plan workspace not support filtering and sorting?

Currently, SLS field indexes have a 1-minute delay. For example, if you extract new fields via Pipeline, you need to wait 1 minute before searching for the new fields, and data within that 1-minute delay remains unsearchable and unsortable. This issue also affects the use of "Generate Metrics" and other chart query features.

:material-chat-question: Does SLS Exclusive Plan workspace support index merging?

No, SLS Exclusive Plan workspace defaults to multi-index. Commercial Plan workspace defaults to index merging to reduce index generation.

> For details on multi-index, refer to [Log Index](../logs/multi-index/index.md).

:material-chat-question: Why is the log time sequence disordered in SLS Exclusive Plan workspace?

Due to SLS date fields being precise to the second level, while <<< custom_key.brand_name >>> log data times are precise to the millisecond level, log sorting within the SLS workspace may appear abnormal in ascending/descending order. By default, only data within a single page can be ordered, not across pages globally.

:material-chat-question: Why does SLS time series data write duplicates?

SLS time series data can duplicate writes at the same timestamp, caused by SLS characteristics.