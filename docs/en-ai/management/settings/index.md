# Space Settings

After joining a workspace and being assigned permissions, you can view a series of settings for the **current workspace** under **Manage > Space Settings**.
 

## Basic Information

### Workspace Language {#language}

In the workspace, you can modify the workspace language. Currently, Chinese and English are supported.

<img src="../img/space-language.png" width="70%" >

This configuration affects templates for events, alerts, SMS messages, etc., within the workspace. After switching, the above templates will default to using the switched language template.

**Note**:

- The workspace language here is different from the **display language** on your space page: <<< custom_key.brand_name >>> will use the default display language or local browser language set in your browser's history when logging into the system console as your default display language for logging into the workspace. For example, if your browser uses Chinese, then logging into the workspace console will default to displaying Chinese.
- Only workspace owners and administrators have permission to modify the workspace language.


### Remarks {#remark}

<<< custom_key.brand_name >>> supports setting remarks for the current workspace. Remarks are only visible to you and will be displayed alongside the workspace name to help identify workspace information more clearly.

After setting up, you can view the remark information at the top-left corner of the workspace.

<img src="../img/3.space_management_7.1.png" width="70%" >

Click the edit button on the right to modify the remarks. Or click the workspace name at the top-left corner to view all workspaces and their remarks. You can add or modify remarks for different workspaces by clicking the **Set Remark** button.

<img src="../img/3.space_management_7.2.png" width="70%" >

### Description {#descrip}

This involves adding descriptive information to the current workspace. After successful addition, it can be viewed directly at the top-left corner of the workspace, making it easier to identify.

<img src="../img/input_descrip.png" width="60%" >

### Replace Token {#token}

<<< custom_key.brand_name >>> supports workspace owners and administrators to copy/change the Token within the workspace and customize the expiration time of the current Token. Enter **Manage > Space Settings > Replace Token**, select the expiration time and confirm **Replace**, <<< custom_key.brand_name >>> will automatically generate a new Token, and the old Token will expire within the specified time.

???+ warning "Post-replacement Notes"

    - Replacing the Token will trigger **[Operation Audit](../operation-audit.md)** and **[Notifications](../index.md#system-notice)**;
    - After replacing the Token, the original Token will expire within the specified time. Expiration times include: immediate expiration, 10 minutes, 6 hours, 12 hours, 24 hours. Immediate expiration is generally used when the Token is leaked; after selecting immediate expiration, the original Token will immediately stop data reporting. If anomaly detection is set up, events and alert notifications cannot be triggered until the original Token in the `datakit.conf` of DataKit collector is changed to the newly generated Token.
    > For the storage directory of the `datakit.conf` file, refer to [DataKit Getting Started](../../datakit/datakit-conf.md).

### Configuration Migration {#export-import}

<<< custom_key.brand_name >>> supports owners and administrators to import/export JSON configuration files of dashboards, custom Explorers, monitors within the workspace. Go to **Manage > Settings**, and choose export or import operations under **Configuration Migration**.

When importing, if there are dashboards, Explorers, or monitors with the same name in the current workspace, a prompt will indicate that the imported file has duplicate names. Users can choose to **skip**, **still create**, or **cancel** based on actual needs.

- Skip: indicates creating only non-duplicate files;
- Still Create: creates corresponding dashboards, Explorers, monitors according to the imported filenames;
- Cancel: cancels this file import operation, i.e., no files are imported.

**Note**: Importing JSON configuration files of dashboards, Explorers, monitors from other workspaces in compressed package format is supported.


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

After enabling the switch, following an invitation notification sent via [Invite Members](../invite-member.md), members need approval from workspace owners and administrators to join the workspace. If not enabled, invited members can directly enter the workspace.

### MFA Security Authentication

After enabling, all workspace members must complete [MFA Binding and Authentication](../mfa-management.md), otherwise they will not be able to enter the workspace.

### IP Whitelist {#ip}

<<< custom_key.brand_name >>> supports configuring an IP whitelist to restrict visitors for the workspace. After enabling the IP whitelist, only IPs listed in the whitelist can log in normally, while requests from other sources will be denied access.

Only administrators and owners can set the IP whitelist, and **Owner** is not subject to IP whitelist access restrictions.

The IP whitelist writing rules are as follows:

- Multiple IPs should be entered on separate lines, with one IP or subnet per line, up to a maximum of 1000 entries;
- Specified IP address: 192.168.0.1, indicating that the IP address 192.168.0.1 is allowed to access;
- Specified IP segment: 192.168.0.0/24, indicating that IP addresses from 192.168.0.1 to 192.168.0.255 are allowed to access;
- All IP addresses: 0.0.0.0/0.

<img src="../img/6.space_ip_1.png" width="60%" >

## Risky Operations

### Change Data Storage Policy {#change}

<<< custom_key.brand_name >>> supports owners changing the [data storage policy](../../billing-method/data-storage.md) within the workspace.

1. Go to **Manage > Space Settings**;
2. Click Replace;
3. Select the desired data storage duration;
4. Click **Confirm** to change the storage duration.

<img src="../img/data-strategy.png" width="60%" >

### Delete Measurement Set

<<< custom_key.brand_name >>> supports owners and administrators deleting measurement sets within the workspace.

1. Go to **Manage > Space Settings**;
2. Click **Delete Specified Measurement Set**;
3. Drop-down to select the measurement set name (supports fuzzy matching);
4. Click **Confirm** to enter the deletion queue awaiting deletion.

**Note**:

- Only workspace owners and administrators can perform this operation;

- Once deleted, the measurement set cannot be recovered; please proceed with caution;

- Deleting a measurement set will generate system notification events, such as user creation of a delete measurement set task, successful execution of the delete measurement set task, failed execution of the delete measurement set task, etc.


### Delete Resource Catalog

<<< custom_key.brand_name >>> supports owners and administrators deleting specific resource catalog classifications and all resource catalogs.

1. Go to **Manage > Space Settings**;
2. Click **Delete Resource Catalog**;
3. Choose the method of deleting the resource catalog;
4. Click **Confirm** to delete the corresponding object data.

- Specific Resource Catalog Classification: deletes data under the selected classification without deleting indexes;
- All Resource Catalogs: deletes all resource catalog data and indexes.