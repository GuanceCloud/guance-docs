---
icon: zy/management
---
# Workspace Management
---

Workspace is the basic operation unit of Guance. In the workspace of Guance, you can use the basic functions provided by Guance, such as scenes, events, indicators, infrastructure, logs, application performance monitoring, user access monitoring, availability monitoring, CI, security inspection, monitoring and workspace management.

## Create a Workspace

You can join one or more workspaces by creating or being invited. Before joining the workspace, you need to [register Guance account](https://auth.guance.com/businessRegister). After the registration is completed, the system will create a workspace for you by default and give the "owner" permission.

After entering the workspace, you can create a new workspace by clicking "Account"-"Create Workspace" in the lower left corner.

![](img/3.space_management_3.png)

Or you can create a new workspace by clicking "Workspace Name"-"New Workspace" in the upper left corner. You can also switch to another workspace by clicking on the workspace.

![](img/3.space_management_1.png)



In the following dialog box, enter a workspace name and description, and click OK to create a new workspace. If you need to create an SLS-only workspace, you can open Guance exclusive plan in Alibaba Cloud Market. For more details, please refer to the doc [Guance exclusive plan in Alibaba Cloud Market](../billing/commercial-aliyun-sls.md).

![](img/3.space_management_4.png)

## Workspace Management

Workspace management is the setting, management and operation of the current workspace. After joining the workspace and being assigned permissions, you can manage the basic information, member permissions, SSO login, data permissions, API Key, notification objects, inner views, charts and snapshot sharing of the space through "administration".

In Guance workspace, Enter "Management"-"Settings", In Settings, you can view the current Guance plan, security operation audit and other information. If you are the owner or administrator of the current workspace, you can modify the space name and remarks, change the space Token, modify the description, configure the migration, set the key indicators of the war room, set the IP white list, change the data storage policy, delete the indicator set and delete the custom object.
![](img/3.space_management_6.png)

### Notes

Guance supports setting comments for the current workspace, which helps users get information such as workspace name more clearly.

In "Administration"-"Settings"-"Basic Information", set the comments information to be viewed.

![](img/3.space_management_7.1.png)

After setting up, you can view the comments information in the upper left workspace.

![](img/3.space_management_7.png)

Click on the workspace name to view all workspaces and their notes, and click the "Edit" button to add or modify the notes.

![](img/3.space_management_7.2.png)

### Replace Token

Guance supports the current space owner and administrator to copy/change the Token in the space, and customize the expiration time of the current Token. Enter "Management"-"Basic Settings"-"Replace Token", select the expiration time and confirm "Replace", and Guance  ` will automatically generate a new Token, and the old Token will expire within the specified time.

Note:

- Changing Token triggers "Action Events" and "Notifications", for details, refer to「[audition](../management/operation-audit.md)」「[notification](../management/system-notification.md)」
- After replacing the Token, the original Token will expire within the specified time. The failure time includes: immediate failure, 10 minutes, 6 hours, 12 hours and 24 hours. Immediate invalidation is generally used for Token leakage. After immediate invalidation is selected, the original Token will stop data reporting immediately. If anomaly detection is set, events and alarm notifications cannot be triggered until the original Token is modified into a newly generated Token in `datakit.conf` of DataKit collector. Refer to the doc [getting started with DataKit](../datakit/datakit-conf.md).

![](/Users/wendy/dataflux-doc/docs/zh/management/img/datakit.png)

### Configure Migration {#export-import}

Guance supports owners and administrators to import and export configuration files of dashboards, custom explorers and monitors in the current workspace with one click, enter "Management"-"Basic Settings", and select export or import operations in "Configuration Migration".

![](/Users/wendy/dataflux-doc/docs/zh/management/img/1-space-management-2.png)

> **Note**: The current workspace supports importing JSON configurations for dashboards, custom explorers and monitors from other workspaces.

### IP White List

Guance supports configuring IP whitelist for workspace to restrict visiting users. After opening the IP whitelist, only the IP sources in the whitelist can log in normally, and requests from other sources will be denied access.

IP whitelist can only be set by administrators and owners, and "owners" are not restricted by IP whitelist access.

IP white list writing specification is as follows:

- Multiple IP lines need to be broken. Only one IP or network segment can be filled in each line, and up to 1000 IP lines can be added
- Specify IP address: 192.168.0.1, indicating that access to the IP address of 192.168.0.1 is allowed
- Specifies the IP segment: 192.168.0.0/24, indicating that IP address access from 192.168.0.1 to 192.168.0.255 is allowed.
- All IP addresses: 0.0.0.0/0

![](/Users/wendy/dataflux-doc/docs/zh/management/img/6.space_ip_1.png)

### Change Data Storage Policy

Guance supports owners and administrators to change the data storage strategy in the space, enter "Management"-"Basic Settings", click "Change", select the required data storage time, and click "OK" to change the data storage time in the current workspace. Refer to the doc [data storage policy](../billing/billing-method/data-storage.md).

### Delete Measurement

Guance supports the owner and administrator to delete the measurement in the space, enter "Management"-"Basic Settings", click "Delete Measurement", enter the query and select the measurement name (fuzzy matching is supported), and click "OK" to enter the deletion queue to wait for deletion.
**Note:**

1. Only space owners and administrators are allowed to do this;

1. Once the measurement is deleted, it cannot be restored. Please operate carefully

1. When deleting a measurement, a system notification event will be generated, such as the user created the task of deleting a measurement, the task of deleting a measurement was successfully executed, and the task of deleting a measurement failed.

  

![](/Users/wendy/dataflux-doc/docs/zh/management/img/11.metric_1.png)

### Delete Custom Object

Guance supports owners and administrators to delete specified custom object categories and all custom objects, enter "Management"-"Basic Settings", click "Delete Custom Objects", and select the method of deleting custom objects to delete corresponding object data.

● Specify Custom Object Classification: Only the data under the selected object classification will be deleted, and the index will not be deleted
● All custom objects: Delete all custom object data and indexes

![](/Users/wendy/dataflux-doc/docs/zh/management/img/7.custom_cloud_3.png)



## Data Isolation and Data Authorization

If your company has multiple departments that need to isolate data, you can create multiple workspaces and invite related departments or stakeholders to join the corresponding workspaces.

If you need to view the data of different workspaces in all departments in a unified way, you can authorize the data of multiple workspaces to the current workspace by configuring data authorization, and query and display them through the scene dashboard and chart components of notes. For more configuration details, please refer to the doc [data authorization](https://preprod-docs.cloudcare.cn/management/data-authorization/).
