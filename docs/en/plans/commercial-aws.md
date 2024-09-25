# Access to Guance Commercial Plan in Amazon Web Services(AWS)
---

This article will introduce how to open the Commercial Plan of Guance and use AWS account for fee settlement after subscribing to Guance Service in AWS Cloud Market. 

> If you want to register Commercial Plan directly, see [Register Commercial Plan](commercial-register.md).

## Subscribe to Guance in AWS Marketplace {#subscribe}

Enter Guance commercial page in [AWS Marketplace](https://awsmarketplace.amazonaws.cn/marketplace/pp/prodview-4rki5nfjxktmy?locale=en) and click **Continue Subscription**.

![](img/8.space_4.png)

Enter an account, user name and password to log in.

![](img/8.space_5.png)

After logging in, click **Subscribe** on the page to which Guance belongs.

![](img/8.space_8.png)

In the pop-up dialog box, click **Set up your Account**.


## Open Guance Commercial Plan

After clicking **Set up your Account** in AWS Marketplace, jump back to Guance to open. Prompt **Register Guance Commercial Plan Immediately** and **Exist Billing Center account, bind it**.

<font color=coral>**Note:**</font> Billing Center account is an independent account used by the Guance Billing Center to manage the billing related to the Commercial Plan of Guance, and one Billing Center account can be associated with multiple workspace billing.

![](img/15.aws_market_1.png)

The overall process is as follows:

![](img/17.process_1.png)

### Register Guance Commercial Plan

If you don't have a Guance account yet, you can click **Register Guance Commercial Plan Now** to enter the account registration process.

=== "Step 1: Basic Info"

    On the **Basic Info** page, select the "**China 2 (Ningxia)**" or "**Overseas 1 (Oregon)**" site, enter the registration information, and click **Continue**.

    ![](img/15.aws_market_register_1.png)

=== "Step 2: Company Info"

    On the **Company Info** page, enter relevant information and click **Continue**.

    ![](img/11.account_center_4.png)

=== "Step 3: Select the opening method"

    In **Select Opening Method**, fill in **Workspace Name**, select **Workspace Language**, and click **Confirm** to complete the registration.

    <font color=coral>**Note:**</font> Workspace language options affect templates for events, alarms and text messages in the workspace. If you select English, the above corresponding template will be used by default. Once created, the template language of this workspace cannot be modified, so please choose carefully.
    
    ![](img/inter-create-workspace.png)

=== "Step 4: Successful opening"

    After successfully selecting the opening method, it will be prompted to successfully open the Commercial Plan of Guance.
    
    <font color=coral>**Note:**</font> After successful opening, the expenses incurred by the bound workspace will be settled directly from the AWS account where the product was purchased.

    ![](img/inter-1.sls_8.png)

    You can log in to [Guance Billing Center](https://boss.guance.com/#/signin) with the account you just registered, and view the opened settlement methods in **Workspace Management**.

    ![](img/15.aws_market_register_10.png)

### Bind Guance Workspace

If you already have a Guance account, you can click **Exist Billing Center account, bind it** and prompt **How to quickly bind AWS account for settlement**.

Click **Got it** to start binding the Guance workspace. Before binding the workspace, you need to bind the Billing Center account of Guance.

#### Bind Guance Billing Center account

If you already have a Guance Billing Center account, enter the **User Name** of Guance Billing Center account and bind it through email verification.

![](img/15.aws_market_3.png)


#### Bind Workspace

=== "Bind Existing Workspace"

    If you have a workspace that can be bound under the Guance Billing Center account, click **Add** directly.

    ![](img/15.aws_market_register_11.png)

    In the pop-up confirmation dialog box, click **Confirm**.

    ![](img/inter-15.aws_market_register_13.png)
    
    You can check the open billing methods in **[Guance Billing Center](https://boss.guance.com/#/signin) > Workspace Management**.


=== "Create a Workspace"

    If you have registered your Guance account but have not yet created a workspace, please click **Create Workspace** first.

    ![](img/1-1-commercial-aliyun.png)

    Enter the workspace name, select the workspace language, enter the mailbox used when registering the Guance account, and create it through mailbox verification.

    <font color=coral>**Note:**</font> Workspace language options affect templates for events, alarms and text messages in the workspace. If you select English, the above corresponding template will be used by default. Once created, the template language of this workspace cannot be modified, so please choose carefully.

    ![](img/inter-10.aws_create_space.png)

    Fill in all necessary information, click **Create**.


=== "Register Guance Account"

    If you have not used Guance service before, please register Guance account and create a workspace first.

    ![](img/inter-1-2-commercial-aliyun.png)

    Click **Register Guance Account**, enter relevant information, and register through email verification.

    <font color=coral>**Note:**</font> Workspace language options affect templates for events, alarms and text messages in the workspace. If you select English, the above corresponding template will be used by default. Once created, the template language of this workspace cannot be modified, so please choose carefully.

    ![](img/inter-10.aws_register.png)

## Start Using Guance

After registration, get started with the first DataKit.

![](img/1-free-start-1109.png)


