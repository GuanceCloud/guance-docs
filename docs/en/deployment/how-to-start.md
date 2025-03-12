# How to Get Started
---

<<< custom_key.brand_name >>> needs to be configured and activated after deployment to start using it.

## Prerequisites

You can refer to the documentation [Cloud Deployment](cloud-deployment-manual.md) or [On-premises Environment Deployment](offline-deployment-manual.md) or [Alibaba Cloud ROS Deployment](https://help.aliyun.com/document_detail/416711.html?spm=5176.26884182.J_4028621810.1.3a4b7bbbT89v0m) for online or on-premises deployment. After deployment is completed, you will receive login credentials for the following <<< custom_key.brand_name >>> platforms.

- dataflux 【**User Frontend (<<< custom_key.brand_name >>>)**】
- df-management 【**Management Backend**】
- df-openapi 【**OpenAPI**】

## Method Steps

### Step 1: Deploy DataWay

After <<< custom_key.brand_name >>> deployment is complete, you need to deploy DataWay first to report data to the <<< custom_key.brand_name >>> workspace via DataWay. During this period, we will have a DataWay data gateway address used to activate the Deployment Plan.

#### Create DataWay
Using an admin account, go to the "Data Gateway" menu in the **<<< custom_key.brand_name >>> Management Backend**, click "Create DataWay" to add a data gateway DataWay.

- **Name**: Custom name
- **Binding Address**: The access address for DataWay, used by DataKit to ingest data, can use `http://ip+port`

**Note: When configuring the DataWay binding address, ensure that the DataKit host can connect to this DataWay address and report data through this DataWay address.**

![](img/12.deployment_1.png)

#### Install DataWay
After adding DataWay, you can obtain an installation script for DataWay. Copy the installation script and run it on the host where DataWay is deployed.

**Note: Ensure that the host deploying DataWay can access the previously configured kodo address. It is recommended that DataWay connects to kodo via the internal network!**

![](img/12.deployment_2.png)

After installation is complete, wait a moment and refresh the "Data Gateway" page. If you see a version number in the "Version Information" column of the newly added data gateway, it indicates that this DataWay has successfully connected to the <<< custom_key.brand_name >>> center, and frontend users can start ingesting data through it.

![](img/12.deployment_3.png)

### Step 2: Activate Deployment Plan

#### Register Deployment Plan Account

Open the registration URL for the Deployment Plan ([https://boss.guance.com/index.html#/signup?type=private](https://boss.guance.com/index.html#/signup?type=private)) and follow the prompts to register a Deployment Plan account.

![](img/6.deployment_3.png)

After registration is complete, enter the <<< custom_key.brand_name >>> Deployment Plan Billing Center.

<!--
![](img/12.deployment_5.png)
-->
#### Obtain AK/SK

In the "AK Management" section of the <<< custom_key.brand_name >>> Deployment Plan Billing Center, click "Create AK".

![](img/6.deployment_6.png)

#### Obtain License

In the "License Management" section of the <<< custom_key.brand_name >>> Deployment Plan Billing Center, click "Create License".

![](img/6.deployment_7.png)

#### Activate Deployment Plan
Open <<< custom_key.brand_name >>> Launcher, go to settings in the top-right corner, and click "License Activation and AK/SK Configuration".

![](img/12.deployment_8.png)

In the "<<< custom_key.brand_name >>> Activation" dialog box of <<< custom_key.brand_name >>> Launcher, fill in the AK/SK, License, and Data Gateway address to complete the activation of the Deployment Plan.
Note: You can scan the QR code to follow the <<< custom_key.brand_name >>> service account to get more official information about <<< custom_key.brand_name >>>.

![](img/12.deployment_9.png)

### Step 3: Start Using <<< custom_key.brand_name >>>
#### Create Users
The <<< custom_key.brand_name >>> Deployment Plan does not provide user registration functionality. You need to log into the **<<< custom_key.brand_name >>> Management Backend**'s "Users" menu and click "Add User" to add users.

![](img/12.deployment_10.png)

#### Create Workspaces
After adding users, go to the "Workspace List" menu in the **<<< custom_key.brand_name >>> Management Backend** and click "Create Workspace" to create a workspace.
**Note: Do not use the default "System Workspace" for daily business monitoring!**

![](img/12.deployment_11.png)

#### Add Workspace Members
After creating the workspace, click "View Members" to enter the corresponding workspace members page and view all member basic information in that space.

![](img/12.deployment_12.png)
In the workspace members list, click "Add User" in the top-right corner, select the newly added user, set the permissions, and click "Confirm" to add a new user to this space.

![](img/12.deployment_13.png)
#### Log in to <<< custom_key.brand_name >>>
Open the <<< custom_key.brand_name >>> Deployment Plan access URL, and you can log in with the created user to start using all <<< custom_key.brand_name >>> features. For detailed feature usage, refer to the [<<< custom_key.brand_name >>> Help Manual](<<< homepage >>>/).

![](img/12.deployment_14.png)