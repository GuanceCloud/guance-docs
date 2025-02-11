# Activate Guance Commercial Plan on AWS Marketplace
---

This article will guide you through subscribing to the Guance service on AWS Marketplace and activating the Guance Commercial Plan using your AWS account for billing.

## Step One: Subscribe to Guance {#subscribe}

Log in to the [AWS Marketplace](https://awsmarketplace.amazonaws.cn/marketplace/pp/prodview-duyx7ds3f3cq2) Guance product page and click **Continue Subscription**.

![](img/8.space_4.png)

After successfully subscribing, click **Set Up Your Account**.

![](img/8.space_9.png)


## Step Two: Activate Guance Commercial Plan

Clicking this link will automatically redirect you to the activation page. If your current AWS account is not linked to a Guance billing account, two scenarios may occur:

:material-numeric-1-circle-outline: [No Billing Account](#register): You need to register for a Guance account and a billing account, then link the cloud account for billing;

:material-numeric-2-circle-outline: [Has Billing Account](#bond): You can directly link the billing account to enable cloud account billing.

![](img/10.aliyun_market_2.png)

???+ warning "What is a Billing Account?"

    A billing account is an independent account within the Guance billing platform used to manage Commercial Plan charges. It allows a single account to be associated with multiple workspaces to streamline billing management.

    The overall process is as follows:

    <img src="../img/17.process_1.png" width="60%" >

### No Billing Account {#register}

If you do not have a billing account, click Next to be redirected to the registration page. After completing the registration process, you will obtain both a Guance account and a billing account.

1. Fill out basic information;
2. Enter company information;
3. Choose activation method: input workspace name, select workspace language;
4. Click **Activate** to complete registration.

![](img/aws.png)

### Has Billing Account {#bond}

If you already have a billing account, click Next to go directly to the binding page:

**Note**: The site in the top-right corner of this page is irrelevant to the billing account linking process; it only affects the site selection when creating a workspace and cannot be changed afterward.

![](img/aws-1.png)


#### :material-numeric-1-circle: Link Billing Account

Enter the username of your billing account and verify via email to link it;

![](img/aws-2.png)

#### :material-numeric-2-circle: Link Workspace

##### Create Workspace

If your current billing account does not have any associated workspaces, you need to create one first. Since the Guance console and billing center are separate platforms, you need to confirm whether you have registered for a Guance account.

:material-numeric-1-circle-outline: If you have already registered for a Guance account and need to create a workspace, go to **Create Workspace > Have Guance Account**.

![](img/1-1-commercial-aliyun.png)

1. Enter workspace name;
2. Select workspace language;
3. Input the email used during Guance account registration;
4. Enter verification code;
5. Agree to terms;
6. Click create, and the workspace will be created successfully.

![](img/10.aws_create_space.png)

After successful creation, you will be automatically redirected back to the binding page, showing **Linked**.

![](img/15.aws_market_10.png)


:material-numeric-2-circle-outline: If you have never used Guance services before, please register a Guance account first. Go to **Create Workspace > No Guance Account**.

![](img/1-2-commercial-aliyun.png)

1. Enter workspace name;
2. Select workspace language;
3. Input username;
4. Enter and confirm login password;
5. Input email;
6. Enter verification code;
7. Optionally fill in phone number;
8. Agree to terms;
9. Click Register and Create Workspace.

Click **Register Guance Account**, enter the required information, and verify via email to complete registration.


![](img/10.aws_register.png)



##### Bind Existing Workspace

If you have existing workspaces under your Guance billing account that can be linked, simply click **Bind**.

1. Select the workspace you want to bind and click bind;
2. Confirm on the new page;
3. It will now show as **Linked**.

![](img/15.aws_market_register_11.png)


## Step Three: Activation Complete

After successfully linking the workspace, click Confirm, which will redirect you to the login page. Enter your username and password to access the workspace and start using Guance.

<!--
Redirect to the **Link Guance Workspace** page, indicating it has been linked.

![](img/15.aws_market_register_14.png)

Click **Confirm**, showing activation success.

![](img/15.aws_market_register_15.png)

You can view the activated billing method under **Workspace Management** in the [Guance Billing Center](https://boss.guance.com/#/signin).

![](img/15.aws_market_register_16.png)




<!--
### Register Guance Commercial Plan

If you do not have a Guance account, you can click **Register Guance Commercial Plan Now** to start the registration process.

=== "Step One: Basic Information"

    On the **Basic Information** page, choose either “China Region 2 (Ningxia)” or “International Region 1 (Oregon)” site, input registration details, and click **Next**.

    ![](img/15.aws_market_register_1.png)

=== "Step Two: Company Information"

    On the **Company Information** page, input relevant details and click **Register**.

    ![](img/15.aws_market_register_3.png)

=== "Step Three: Choose Activation Method"

    On the **Choose Activation Method** page, fill in the **Workspace Name**, select the **Workspace Language**, and click **Confirm** to complete registration.

    **Note**: A workspace is a collaboration space for data insights in Guance. The workspace language option affects templates for events, alerts, SMS, etc. If English is chosen, the corresponding templates will default to English and cannot be changed after creation, so choose carefully.
    
    ![](img/15.aws_market_register_5.png)

=== "Step Four: Activation Success"

    After successfully choosing the activation method, it will prompt that the Guance Commercial Plan has been activated.
    
    **Note**: After activation, charges for the linked workspace will be billed directly from the AWS account used to purchase the product.

    ![](img/15.aws_market_register_7.png)

    You can log in to the [Guance Billing Center](https://boss.guance.com/#/signin) with your newly registered account and view the activated billing method under **Workspace Management**.

    ![](img/15.aws_market_register_10.png)

### Link Guance Workspace

If you already have a Guance account, you can click **Already Have Billing Account, Go to Binding** to see instructions on how to quickly link AWS account billing.

![](img/15.aws_market_2.png)

Click **Understood**, and start linking the Guance workspace. Before linking the workspace, you need to link the Guance billing account first.

#### Link Guance Billing Account

- Site: Choose the site for creating the workspace later;
- Username: If you already have a Guance billing account, enter the **Username** and verify via email to link it;
- Registration: If you do not have a Guance billing account, register first.

![](img/10.market_aws_1.png)


#### Link Workspace

=== "Bind Existing Workspace"

    If you have existing workspaces under your Guance billing account that can be linked, simply click **Bind**.

    ![](img/15.aws_market_register_11.png)

    In the confirmation dialog box, click **Confirm**.

    ![](img/15.aws_market_register_13.png)
    
    Redirect to the **Link Guance Workspace** page, indicating it has been linked.

    ![](img/15.aws_market_register_14.png)

    Click **Confirm**, showing activation success.

    ![](img/15.aws_market_register_15.png)

    You can view the activated billing method under **Workspace Management** in the [Guance Billing Center](https://boss.guance.com/#/signin).

    ![](img/15.aws_market_register_16.png)


=== "Create Workspace"

    If you have registered a Guance account but have not created a workspace yet, click **Create Workspace**.

    ![](img/1-1-commercial-aliyun.png)

    Enter the workspace name, select the workspace language, and input the email used during Guance account registration, verifying via email to create it.

    **Note**: A workspace is a collaboration space for data insights in Guance. The workspace language option affects templates for events, alerts, SMS, etc. If English is chosen, the corresponding templates will default to English and cannot be changed after creation, so choose carefully.

    ![](img/10.aws_create_space.png)

    After successful creation, you will be automatically redirected to the **Link Guance Workspace** page.

    ![](img/15.aws_market_10.png)

    Click **Confirm**, redirecting to the **Successfully Linked the Following Guance Workspaces** page.

    ![](img/15.aws_market_11.png)

=== "Register Guance Account"

    If you have never used Guance services before, please register a Guance account and create a workspace.

    ![](img/1-2-commercial-aliyun.png)

    Click **Register Guance Account**, enter the required information, and verify via email to complete registration.

    **Note**: A workspace is a collaboration space for data insights in Guance. The workspace language option affects templates for events, alerts, SMS, etc. If English is chosen, the corresponding templates will default to English and cannot be changed after creation, so choose carefully.

    ![](img/10.aws_register.png)

## Start Using Guance

After registration, you can watch an introductory video about Guance or click **Start by Installing DataKit** to install and configure your first DataKit.

![](img/1-free-start-1109.png)