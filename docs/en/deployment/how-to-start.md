# How to Get Started
---

After the <<< custom_key.brand_name >>> deployment is completed, it needs to be configured and activated before it can be used.

## Prerequisites

You can refer to the documents [Cloud Deployment](cloud-deployment-manual.md) or [Offline Environment Deployment](offline-deployment-manual.md) or [Alibaba Cloud Computing Nest Deployment](https://help.aliyun.com/document_detail/416711.html?spm=5176.26884182.J_4028621810.1.3a4b7bbbT89v0m) for online or offline deployment. After the deployment is completed, you will obtain login methods for the following <<< custom_key.brand_name >>> related platforms.

- dataflux 【**User Frontend (<<< custom_key.brand_name >>>)**】
- df-management 【**Management Backend**】
- df-openapi 【**OpenAPI**】

## Methods and Steps

### Step1: Deploy DataWay

After <<< custom_key.brand_name >>> deployment is completed, DataWay must be deployed first so that data can be reported to the <<< custom_key.brand_name >>> workspace via DataWay. During this time, we will have a DataWay data gateway address which is used to activate the Deployment Plan.

#### Create DataWay
Using an administrator account, go to the "Data Gateway" menu in the "**<<< custom_key.brand_name >>> Management Backend**" and click "Create DataWay" to add a data gateway DataWay.

- **Name**: You can use a custom name.
- **Binding Address**: The access address of DataWay, used for data integration in DataKit. You can use `http://ip+port`.

**Note: When configuring the binding address for DataWay, ensure that the DataKit host has connectivity with this DataWay address, and can report data through this DataWay address.**

![](img/12.deployment_1.png)

#### Install DataWay
After adding DataWay, you can obtain an installation script for DataWay, copy the installation script, and run it on the host where DataWay is deployed.

**Note: Ensure that the host where DataWay is deployed can access the previously configured kodo address. It is recommended that DataWay connects to kodo via an internal network!**

![](img/12.deployment_2.png)

After the installation is complete, wait a moment and refresh the "Data Gateway" page. If you see a version number in the "Version Information" column of the newly added data gateway, it means that this DataWay has successfully connected with the <<< custom_key.brand_name >>> center, and frontend users can start integrating data through it.

![](img/12.deployment_3.png)

### Step2: Activate Deployment Plan

#### Register Deployment Plan Account

Open the registration URL for the Deployment Plan ([https://<<< custom_key.boss_domain >>>/index.html#/signup?type=private](https://<<< custom_key.boss_domain >>>/index.html#/signup?type=private)) and register a Deployment Plan account according to the prompts.

![](img/6.deployment_3.png)

After registration is completed, enter the <<< custom_key.brand_name >>> Deployment Plan Billing Center.

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
Open <<< custom_key.brand_name >>> Launcher, go to the settings in the upper-right corner, and click "License Activation and AK/SK Configuration".

![](img/12.deployment_8.png)

In the "<<< custom_key.brand_name >>> Activation" dialog box of <<< custom_key.brand_name >>> Launcher, fill in the AK/SK, License, and Data Gateway address to complete the activation of the Deployment Plan.
Note: You can scan the QR code to follow the <<< custom_key.brand_name >>> service account to get more official information about <<< custom_key.brand_name >>>.

![](img/12.deployment_9.png)

### Step3: Start Using <<< custom_key.brand_name >>>
#### Create Users
The <<< custom_key.brand_name >>> Deployment Plan does not provide user registration functionality. You need to log into the "**<<< custom_key.brand_name >>> Management Backend**" under the "Users" menu, and click "Add User" to add users.

![](img/12.deployment_10.png)

#### Create Workspaces
After adding users, go to the "Workspace List" menu in the "**<<< custom_key.brand_name >>> Management Backend**", click "Create Workspace", and continue to create a workspace.
**Note: Do not use the default "System Workspace" for regular business monitoring!**

![](img/12.deployment_11.png)

#### Add Workspace Members
After creating the workspace, click "View Members", enter the corresponding workspace member page, and you can view basic information about all members within the space.

![](img/12.deployment_12.png)
In the workspace member list, click "Add User" in the upper-right corner, select the newly added user and set their permissions, then click "Confirm" to add a new user to this space.

![](img/12.deployment_13.png)
#### Log In to <<< custom_key.brand_name >>>
Open the <<< custom_key.brand_name >>> Deployment Plan access address, and you can log in with the users created above to start using all <<< custom_key.brand_name >>> features in the corresponding workspace. For detailed feature usage instructions, refer to the [<<< custom_key.brand_name >>> Help Manual](<<< homepage >>>/).

![](img/12.deployment_14.png)