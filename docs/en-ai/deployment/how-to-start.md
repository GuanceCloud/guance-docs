# How to Get Started
---

After the Guance deployment is complete, it needs to be configured and activated before it can be used.

## Prerequisites

You can refer to the documentation [Cloud Deployment](cloud-deployment-manual.md) or [Offline Environment Deployment](offline-deployment-manual.md) or [Alibaba Cloud Computing Nest Deployment](https://help.aliyun.com/document_detail/416711.html?spm=5176.26884182.J_4028621810.1.3a4b7bbbT89v0m) for online or offline deployment. After deployment is completed, you will receive login information for the following Guance platforms.

- dataflux 【**User Frontend (Guance)**】
- df-management 【**Management Backend**】
- df-openapi 【**OpenAPI**】

## Method Steps

### Step 1: Deploy DataWay

After completing the Guance deployment, you need to deploy DataWay first in order to report data to the Guance workspace via DataWay. During this period, we will have a DataWay data gateway address used to activate the Deployment Plan.

#### Create a New DataWay
Using an administrator account, enter the "Data Gateway" menu of the **Guance Management Backend**, click "Create DataWay", and add a data gateway DataWay.

- **Name**: Custom name
- **Binding Address**: The access address for DataWay, used in DataKit for data ingestion, can use `http://ip+port`

**Note: When configuring the DataWay binding address, ensure that the DataKit host can communicate with this DataWay address and report data through it.**

![](img/12.deployment_1.png)

#### Install DataWay
After adding DataWay, obtain an installation script for DataWay, copy the installation script, and run it on the host where DataWay is deployed.

**Note: Ensure that the host deploying DataWay can access the previously configured kodo address, it's recommended that DataWay connects to kodo via internal network!**

![](img/12.deployment_2.png)

After installation, wait a moment and refresh the "Data Gateway" page. If you see a version number in the "Version Information" column for the newly added data gateway, it indicates that this DataWay has successfully connected to the Guance center, and frontend users can start ingesting data through it.

![](img/12.deployment_3.png)

### Step 2: Activate Deployment Plan

#### Register Deployment Plan Account

Open the registration URL for the Deployment Plan ([https://boss.guance.com/index.html#/signup?type=private](https://boss.guance.com/index.html#/signup?type=private)), and register a Deployment Plan account according to the prompts.

![](img/6.deployment_3.png)

After registration is complete, enter the Deployment Plan fee center of Guance.

<!--
![](img/12.deployment_5.png)
-->
#### Obtain AK/SK

In the "AK Management" section of the Guance Deployment Plan fee center, click "Create AK".

![](img/6.deployment_6.png)

#### Obtain License

In the "License Management" section of the Guance Deployment Plan fee center, click "Create License".

![](img/6.deployment_7.png)

#### Activate Deployment Plan
Open the Guance Launcher, go to settings in the top right corner, and click "License Activation and AK/SK Configuration".

![](img/12.deployment_8.png)

In the "Guance Activation" dialog box of the Guance Launcher, fill in the AK/SK, License, and Data Gateway address to complete the activation of the Deployment Plan.
Note: You can scan the QR code to follow the Guance service account for more official information about Guance.

![](img/12.deployment_9.png)

### Step 3: Start Using Guance
#### Create Users
The Guance Deployment Plan does not provide user registration functionality; you need to log into the **Guance Management Backend**'s "Users" menu and click "Add User" to add users.

![](img/12.deployment_10.png)

#### Create Workspaces
After adding users, go to the "Workspace List" menu in the **Guance Management Backend** and click "Create Workspace" to create a new workspace.
**Note: Do not use the default "System Workspace" for daily business monitoring!**

![](img/12.deployment_11.png)

#### Add Workspace Members
After creating the workspace, click "View Members" to enter the corresponding workspace members page where you can view all member information within the workspace.

![](img/12.deployment_12.png)
In the workspace members list, click "Add User" in the top right corner, select the newly added user and set the appropriate permissions, then click "Confirm" to add a new user to this workspace.

![](img/12.deployment_13.png)
#### Log in to Guance
Open the access URL for the Guance Deployment Plan, and use the created user to log into the corresponding workspace to start using all Guance features. For detailed feature usage instructions, refer to the [Guance Help Manual](https://docs.guance.com/).

![](img/12.deployment_14.png)