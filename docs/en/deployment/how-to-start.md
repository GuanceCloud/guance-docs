# How To Start
---

After the deployment of the Guance Community Version is completed, the Community Version needs to be configured and activated before it can be used. 

## Preconditions

You can refer to the doc [cloud deployment](cloud-deployment-manual.md) or [offline environment deployment](offline-deployment-manual.md) or [Alibaba Cloud computing nest deployment](https://help.aliyun.com/document_detail/416711.html?spm=5176.26884182.J_4028621810.1.3a4b7bbbT89v0m) for online or offline deployment. After the deployment is completed, you can get the following login methods for the related platforms of Guance Community Version. 

- dataflux 【**User Foreground (Guance)**】
- df-management 【**Management Background**】
- df-openapi 【**OpenAPI**】

## Method Step

### Step1: Deploy DataWay

After the deployment of Guance Community Version is completed, DataWay needs to be deployed before data can be reported to Guance Community Version workspace through DataWay. In the meantime, we would have a DataWay data gateway address to activate the community version. 

#### New DataWay
Use the administrator account, enter the **Data Gateway** menu of **Guance Cloud Management Background**, and click "New DataWay" to add a data gateway DataWay. 

- **Name**: Custom
- **Binding address**: Access address of DataWay. Access data in DataKit. You can use `http://ip+端口`

**Note: When configuring the DataWay binding address, you must ensure that the DataKit host is connected to the DataWay address through which data can be reported.**

![](img/12.deployment_1.png)

#### Installing DataWay
After the DataWay is added, you can get a DataWay installation script, copy the installation script, and run the installation script on the host where the DataWay is deployed. 

**Note: Here you need to ensure that the host on which DataWay is deployed can access the kodo address configured earlier. It is recommended that DataWay go to kodo through the intranet!**

![](img/12.deployment_2.png)

After installation, wait for a moment to refresh the "Data Gateway" page. If you see the version number in the "Version Information" column of the newly added data gateway, it means that this DataWay has been successfully connected with the Guance center, and foreground users can access data through it. 

![](img/12.deployment_3.png)

### Step2: Activate Community Version

#### Register a Community Account
Open the community version registration website ([https://boss.guance.com/index.html#/signup?type=community](https://boss.guance.com/index.html#/signup?type=community)) and register the community version account according to the prompts. 

![](img/12.deployment_4.png)

After registration, enter the Guance Community Version Expense Center. 

![](img/12.deployment_5.png)

#### Get AK/SK

In the "AK Management" of the Guance Community Expense Center, click "Create AK". 

![](img/12.deployment_6.png)

#### Get License

In the "License Management" section of the Cloud Community Expense Center, click "Create License". 

![](img/12.deployment_7.png)

#### Activate Community Version 
Open the Guance Launcher, set it in the upper right corner, and click "License Activation and AK/SK Configuration". 

![](img/12.deployment_8.png)

In the "Guance Activation" dialog box of Guance Launcher, fill in AK/SK, License and data gateway address to complete the community version activation.
Note: You can scan the code and pay attention to the Guance service number to get more official information of Guance. 

![](img/12.deployment_9.png)

### Start Using Guance
#### Create a User
Guance Deployment Version does not provide user registration function. You need to log in to the **User** menu of **Guance Management Background** and click "Add User" to add users. 

![](img/12.deployment_10.png)

#### Create a Workspace 
After adding users, click **New Workspace** in the **Workspace List** menu of **Guance Management Background** to continue creating a workspace.
**Note: The default "system workspace" should not be used as an observation in daily business!**

![](img/12.deployment_11.png)

#### Add a Workspace Member 
After creating the workspace, click "View Members" to enter the corresponding workspace member page, and you can view the basic information of all members in the space. 

![](img/12.deployment_12.png)
In the workspace member list, click "Add User" in the upper right corner, select the newly added user and set the permissions, and then click "OK" to add a new user in this space. 

![](img/12.deployment_13.png)
#### Login Guance
Open the access address of Guance Cloud Community Edition, and you can log in to the corresponding workspace with the users created above to start using all functions of Guance Cloud. Please refer to the [Guance Help Manual](https://docs.guance.com/) for detailed introduction of functions. 

![](img/12.deployment_14.png)


