# Space Settings

After joining a workspace and being assigned permissions, you can view a series of settings for the **current workspace** under **Management > Space Settings**.
 

## Basic Information

### Workspace Language {#language}

In the workspace, you can modify the workspace language. Currently, Chinese and English are supported.

<img src="../img/space-language.png" width="70%" >

This configuration affects templates for events, alerts, SMS, etc., within the workspace. After switching, the above templates will default to using the switched language template.

**Note**:

- The workspace language here is different from the **display language** on your space page: Guance will use the default display language or local browser language of the system console based on your browser's historical login, as the default display language when logging into the workspace. If your browser uses Chinese, then logging into the workspace console will default to displaying Chinese.
- Only workspace owners and administrators have permission to modify the workspace language.


### Remarks {#remark}

Guance supports setting remarks for the current workspace. Remarks are visible only to you and will be displayed alongside the workspace name to help identify workspace information more clearly.

After setting, you can view the remarks information in the top-left corner of the workspace.

<img src="../img/3.space_management_7.1.png" width="70%" >

Click the edit button on the right to modify the remarks. Or click the workspace name in the top-left corner to view all workspaces and their remarks. You can add or modify remarks for different workspaces by clicking the **Set Remarks** button.

<img src="../img/3.space_management_7.2.png" width="70%" >

### Description {#descrip}

This involves adding a description to the current workspace. After successful addition, it can be viewed directly in the top-left corner of the workspace to facilitate identification.

<img src="../img/input_descrip.png" width="60%" >

### Replace Token {#token}

Guance supports owners and administrators of the current space to copy/change the Token within the space and customize the expiration time of the current Token. Go to **Management > Space Settings > Replace Token**, select the expiration time and confirm **Replace**. Guance will automatically generate a new Token, and the old Token will expire at the specified time.

???+ warning "Post-replacement Notes"

    - Replacing the Token will trigger **[Operation Audit](../operation-audit.md)** and **[Notifications](../index.md#system-notice)**;
    - After replacing the Token, the original Token will expire within the specified time. Expiration times include: immediate expiration, 10 minutes, 6 hours, 12 hours, 24 hours. Immediate expiration is generally used when the Token is leaked. After choosing immediate expiration, the original Token will immediately stop reporting data. If anomaly detection is set up, events and alert notifications cannot be triggered until the original Token in the DataKit collector's `datakit.conf` is changed to the newly generated Token.
    > For information on the storage directory of the `datakit.conf` file, refer to [Getting Started with DataKit](../../datakit/datakit-conf.md).

### Configuration Migration {#export-import}

Guance supports owners and administrators to import/export JSON configuration files of dashboards, custom Explorers, and monitors within the workspace. Go to **Management > Settings**, and choose export or import operations under **Configuration Migration**.

When importing, if there are dashboards, Explorers, or monitors with the same name in the current workspace, a prompt will appear indicating that the imported file has duplicate names. Users can choose to **skip**, **still create**, or **cancel** based on actual needs.

- Skip: Only create files that do not have duplicate names;  
- Still Create: Create corresponding dashboards, Explorers, and monitors based on the imported filenames;            
- Cancel: Cancel this file import operation, meaning no files will be imported.       

**Note**: Supports importing JSON configuration files of dashboards, Explorers, and monitors from other workspaces in compressed format.

### Advanced Settings

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Key Metrics</font>](../settings/key-metrics.md)

<br/>

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Feature Menu</font>](../settings/customized-menu.md)

<br/>

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Workspace Timezone</font>](../index.md#workspace)

<br/>

</div>

</font>

## Security Related

### Invitation Approval

After enabling the switch, after sending an invitation notification in [Invite Members](../invite-member.md), approval from members with owner and administrator permissions of the current workspace is required before they can join the workspace. If not enabled, invited members can directly enter the workspace.

### MFA Security Authentication

After enabling, all members of the workspace must complete [MFA binding and authentication](../mfa-management.md), otherwise, they will not be able to enter the workspace.

### IP Whitelist {#ip}

Guance supports configuring an IP whitelist for the workspace to restrict visiting users. After enabling the IP whitelist, only IPs from the whitelist can log in normally, and requests from other sources will be denied access.

The IP whitelist can only be set by administrators and owners. At the same time, **Owner** is not subject to IP whitelist access restrictions.

IP whitelist writing standards are as follows:

- Multiple IPs need to be on separate lines, each line allowing only one IP or subnet, with a maximum of 1000 entries allowed; 
- Specified IP address: 192.168.0.1, which allows access from the IP address 192.168.0.1;             
- Specified IP segment: 192.168.0.0/24, which allows access from IP addresses 192.168.0.1 to 192.168.0.255;        
- All IP addresses: 0.0.0.0/0.

<img src="../img/6.space_ip_1.png" width="60%" >

## Risky Operations

### Change Data Storage Policy {#change}

Guance supports owners changing the [data storage policy](../../billing-method/data-storage.md) within the workspace.

1. Go to **Management > Space Settings**;
2. Click Replace;
3. Select the required data storage duration;
4. Click **Confirm** to change the storage duration.

<img src="../img/data-strategy.png" width="60%" >

### Delete Mearsurement

Guance supports owners and administrators deleting Measurement sets within the space.

1. Go to **Management > Space Settings**;
2. Click **Delete Specified Mearsurement**;
3. Select the Measurement set name (supports fuzzy matching);
4. Click **Confirm** to enter the deletion queue and wait for deletion.

**Note**:

- Only space owners and administrators can perform this operation;     

- Once a Measurement set is deleted, it cannot be recovered, so please proceed with caution;    

- Deleting a Measurement set will trigger system notification events, such as user creation of a delete Measurement task, successful execution of a delete Measurement task, failed execution of a delete Measurement task, etc.



### Delete Resource Catalog

Guance supports owners and administrators deleting specific resource catalog classifications and all resource catalogs.

1. Go to **Management > Space Settings**;
2. Click **Delete Resource Catalog**;
3. Choose the method to delete the resource catalog;
4. Click **Confirm** to delete the corresponding object data.

- Specific Resource Catalog Classification: Only deletes data under the selected object classification without deleting indexes;           
- All Resource Catalogs: Deletes all resource catalog data and indexes.