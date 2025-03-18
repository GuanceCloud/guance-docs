# Workspace Management 
---

## Introduction 

The workspace is based on multi-user design, which can isolate different unit data. At the same time, it supports selecting data storage strategy of workspace, viewing, adding and deleting workspace members. 

## Create a New Workspace

In "Workspace List", click "New Workspace" in the upper right corner. 

![](img/16.deployment_1.png)

In the pop-up dialog box, fill in "Name", select whether to turn on "Index Merge", select "Data Retention Duration", "Space Owner" and "Space Administrator", and click "OK" to create a new workspace. 

- **Space Owner:** With the highest operation authority of workspace, the role can specify the current space "administrator" and carry out any space configuration management, including upgrading the space payment plan and dissolving the current space. 
- **Space Administrator:** The manager of the current workspace, who can set the user rights as "read-only member" or "standard member" and have the rights of space configuration management, including: accessing the payment plan and list of the current workspace; Operate the basic settings of workspace, member management and notification object management; Manage data collection, disabling/enabling, editing and deleting; Exclude the upgrade space payment plan, dissolve the current space. 
- **Index merge:** Different indexes would be created according to different data types. The more indexes, the larger the data storage capacity. In order to save data storage space, index merge in workspace can be started. 
   - Index merge is started, and the workspace creates corresponding data indexes according to metrics, logs/CI monitoring/availability monitoring/security inspection, backup logs, events, user access/application performance (trace, profile); 
   - Index merge is closed, and the workspace creates corresponding data indexes according to metrics, logs, backup logs, events, application performance, user access and security inspection; 
   - **Adjust the index merge, the corresponding old index and historical data of the workspace would be deleted soon, and the data would not be recovered after deletion.**

Note: When adding a workspace, you may not specify a space administrator for the time being. Later, you can click "View Members"-"Add Users" on the "Workspace List" page to set it up. 

- Add workspace with index merge on 

![](img/16.deployment_2.png)

- Add a workspace with index merge off 

![](img/16.deployment_3.png)

## Manage Workspace

### Search

The Workspace List page views basic information for all workspaces. Support search by space name keyword. 

### Index Configuration 

Click "Index Configuration" to enter the corresponding index configuration page, which supports the adjustment of "Main Slicing", "Slicing Size" and "Copy Slicing" for all index templates in the current workspace. 

![](img/16.deployment_4.png)

Click the "Configure" button on the right side of the data type to support user-defined configuration of the "Main Segment" and "Segment Size" of the data type, and support whether to "Open Copy". 
Note: When the copy is opened, a redundant copy would be created for the index fragment by default. 

![](img/16.deployment_5.png)

### View Members

Click "View Members" to enter the corresponding workspace member page, and you can view the basic information of all members in this space. Support search by email account or name. 

![](img/16.deployment_6.png)

#### Add Members

In the workspace member list, click "Add User" in the upper right corner, select members and set permissions, and then click "OK" to add a new member in this space. 

**Note: A member can be added here as an existing member in the system. If it is a new member, you need to go to the "User"-"Add User" page and then return here for operation.**

![](img/16.deployment_7.png)


#### Edit and Delete Members

-  Click "Modify Permissions" to modify the permissions of members. 
-  Click Delete to delete this member from the workspace.

Note: A workspace can only have one "owner". Change other members to "owner", and the original "owner" would be downgraded to "administrator" 

![](img/16.deployment_8.png)

#### Bulk Editing and Deleting Members

After selecting multiple members, click the "Set" or "Delete" icon in the upper right corner to modify member permissions uniformly and delete selected members in batches. 

![](img/16.deployment_9.png)

### Modify

In Workspace List, click Modify on the right side of the workspace to edit the name and index merge of the workspace. 

![](img/16.deployment_10.png)
### Delete 

Enter the "Workspace List" and click "Delete" on the right side of the workspace to delete the corresponding workspace. 


