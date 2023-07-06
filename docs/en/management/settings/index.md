# Settings

After joining the workspace and being assigned permissions, you can see a series of settings **about the current workspace**.
 
![](img/3.space_management_6.png)

## Remark

In **Management > Settings > Basic Information**, set the remark information to be viewed.

![](img/3.space_management_7.1.png)

After setting up, you can view the remark in the upper left workspace.

![](img/3.space_management_7.png)

Click on the workspace name to view all workspaces and their remarks, and click **Edit** to add or modify the notes.

![](img/3.space_management_7.2.png)

## Replace Token

Guance supports the current workspace owner and administrator to copy/change the Token in the space, and customize the expiration time of the current Token. 

Enter **Replace Token**, select the expiration time and confirm **Replace**. Then Guance will automatically generate a new Token and the old Token will expire within the specified time.

Note:

- Changing Token triggers **Action Events** and **Notifications**. See [Audit](../../management/operation-audit.md) and [System Notification](../../management/system-notification.md) for more information.  
- After replaced, the original Token will expire within the specified time. The failure time includes: immediate failure, 10 minutes, 6 hours, 12 hours and 24 hours.<br/>
> Immediate invalidation is generally used for Token leakage. After it is selected, the original Token will stop data reporting immediately. If anomaly detection is set, events and alarm notifications cannot be triggered until the original Token is modified into a newly generated Token in `datakit.conf` of DataKit collector. See [Getting Started with DataKit](../../datakit/datakit-conf.md) for more information.

![](img/datakit.png)

## Configure Migration {#export-import}

Owners and administrators can import and export configuration files of dashboards, custom explorers and monitors in the current workspace.   
Enter **Configuration Migration** and select **Export** or **Import**.

When importing, if there are dashboards, explorers and monitors with duplicate names in the current workspace, the user can choose whether to **Skip**, **Still Create** and **Cancel** according to your actual needs.

- Skip: **only create files with non-duplicate name**.  
- Still Create: Create the corresponding dashboard, explorers and monitor according to the imported file name.  
- Cancel: Cancel this file import operation, that is, no file import.

> **Note**: The current workspace supports importing JSON configurations for dashboards, custom explorers and monitors from other workspaces.

![](img/5.input_rename_1.png)

### Advanced Settings

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Key Metrics</font>](key-metrics.md#)

<br/>

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Feature Menu</font>](customized-menu.md#)

<br/>

</div>

### IP White List

IP whitelist is used to restrict visiting users. After opening the IP whitelist, only the IP sources in the whitelist can log in normally, and requests from other sources will be denied access.

> IP whitelist can only be set by administrators and owners, and owners are not restricted by IP whitelist access.

IP white list writing specification is as follows:

- Multiple IP lines need to be broken. Only one IP or network segment can be filled in each line, and up to 1000 IP lines can be added
- Specified IP address: **192.168.0.1**, indicating that access to the IP address of 192.168.0.1 is allowed.
- Specified IP segment: **192.168.0.0/24**, indicating that IP address access from 192.168.0.1 to 192.168.0.255 is allowed.
- All IP addresses: **0.0.0.0/0**.

![](img/6.space_ip_1.png)

### Change Data Storage Policy

Guance supports **Owners only** to change the data storage policy in the space, enter **Management > Basic Settings**, click **Change**, select the required data storage time, and click **Confirm** to change the data storage time in the current workspace. See [Data Storage Policy](../../billing/billing-method/data-storage.md) for more information.

### Delete Measurement

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Delete Metric Data</font>](../../metrics/collection.md#delete)

<br/>

</div>

### Delete Custom Object

Owners and administrators can delete specified custom object categories and all custom objects, click **Delete** and select the method of deleting custom objects to delete corresponding object data.

- Specify custom object classification: Only the data under the selected object classification will be deleted, and the index will not be deleted.  
- All custom objects: Delete all custom object data and indexes.

![](img/7.custom_cloud_3.png)



