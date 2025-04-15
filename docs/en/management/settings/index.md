# Workspace Settings

After joining a workspace and being assigned permissions, you can see a series of settings for the **current workspace** under **Management > Workspace Settings**.


## Basic Information

### Workspace Language {#language}

In the workspace, you can modify the workspace language. Currently, it supports selecting between Chinese and English.

<img src="../img/space-language.png" width="70%" >

This configuration affects event, alert, SMS, and other templates within the workspace. After switching, the aforementioned templates will default to using the language template after the switch.

???+ warning "Note"

    - The workspace language here is different from the **display language** on your space page: <<< custom_key.brand_name >>> will use either the default display language set in your local browser's historical login system console or the local browser language as your default display language when logging into the workspace. For example, if your browser uses Chinese, the workspace control panel will default to displaying in Chinese.
    - Only workspace owners and administrators have the permission to modify the workspace language.


### Remarks {#remark}

<<< custom_key.brand_name >>> supports setting remarks for the current workspace. Remarks are only visible to yourself and will be displayed alongside the workspace name, helping to more clearly identify workspace information.

After setting, you can view the remark information in the top-left corner of the workspace.

<img src="../img/3.space_management_7.1.png" width="70%" >

Click the edit button on the right side to modify the remarks. Or click the workspace name in the top-left corner to view all workspaces and their remarks. You can add or modify remarks for different workspaces at the **Set Remark** button.

<img src="../img/3.space_management_7.2.png" width="70%" >

### Description {#descrip}

This allows adding a description to the current workspace. After successful addition, it can be viewed directly in the top-left corner of the workspace for easier identification.

<img src="../img/input_descrip.png" width="60%" >

### Replace Token {#token}

<<< custom_key.brand_name >>> supports the workspace owner and administrator copying/changing the Token within the workspace and customizing the expiration time of the current Token. Go to **Management > Workspace Settings > Replace Token**, select the expiration time, confirm the replacement, and <<< custom_key.brand_name >>> will automatically generate a new Token. The old Token will expire within the specified time.

???+ warning "Note after Replacement"

    - Replacing the Token will trigger **[Operation Audit](../operation-audit.md)** and **[Notifications](../index.md#system-notice)**;
    - After replacing the Token, the original Token will expire within the specified time. Expiration times include: immediate expiration, 10 minutes, 6 hours, 12 hours, 24 hours. Immediate expiration is generally used for Token leaks. After choosing immediate expiration, the original Token will immediately stop data reporting. If anomaly detection is set up, events and alert notifications cannot be triggered until the original Token in DataKit's `datakit.conf` is changed to the newly generated Token.
    > For the storage directory of the `datakit.conf` file, refer to [DataKit Getting Started](../../datakit/datakit-conf.md).

### Configuration Migration {#export-import}

<<< custom_key.brand_name >>> supports owners and administrators importing and exporting JSON configuration files for dashboards, custom Explorers, and monitors within the workspace. Go to **Management > Settings**, and choose export or import operations under **Configuration Migration**.

When importing, if there are dashboards, explorers, or monitors with the same name in the current workspace, a prompt will indicate that the imported file has duplicate names. Users can choose whether to **skip**, **still create**, or **cancel** based on actual needs.

- Skip: Indicates that only files with non-duplicate names will be created;
- Still Create: Creates corresponding dashboards, explorers, and monitors according to the imported filenames;
- Cancel: Cancels the current file import operation, meaning no files will be imported.

???+ warning "Note"

    Supports importing JSON configuration files for dashboards, explorers, and monitors from other workspaces in a compressed package format.


### Advanced Settings

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Key Metrics</font>](../settings/key-metrics.md)

<br/>

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Feature Menus</font>](../settings/customized-menu.md)

<br/>

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Workspace Time Zone</font>](../index.md#workspace)

<br/>

</div>

</font>

## Security Related

### Invitation Approval

After enabling the switch, members invited via [Invite Members](../invite-member.md) must be approved by workspace owners and administrators before they can join the workspace. If not enabled, invited members can directly enter the workspace.

### MFA Security Authentication

After enabling this feature, all workspace members must complete [MFA binding and authentication](../mfa-management.md), otherwise, they will not be able to enter the workspace.

### IP Whitelist {#ip}

<<< custom_key.brand_name >>> supports configuring an IP whitelist for the workspace to restrict visiting users. After enabling the IP whitelist, only IPs listed in the whitelist can log in normally, and all other requests will be denied access.

Only administrators and owners can set the IP whitelist, and the **Owner** is not restricted by the IP whitelist access.

The IP whitelist writing standards are as follows:

- Multiple IPs should be separated by line breaks, allowing one IP or subnet per line, with a maximum of 1000 entries allowed;
- Specific IP address: 192.168.0.1, indicating that the IP address 192.168.0.1 is allowed to access;
- Specific IP range: 192.168.0.0/24, indicating that IP addresses from 192.168.0.1 to 192.168.0.255 are allowed to access;
- All IP addresses: 0.0.0.0/0.

<img src="../img/6.space_ip_1.png" width="60%" >

## Risky Operations

### Change Data Storage Policy {#change}

<<< custom_key.brand_name >>> supports owners changing the [data storage policy](../../billing-method/data-storage.md) within the workspace.

1. Enter **Management > Workspace Settings**;
2. Click Replace;
3. Select the required data storage duration;
4. Click **Confirm** to change the storage duration.

<img src="../img/data-strategy.png" width="60%" >

### Delete Measurement

<<< custom_key.brand_name >>> supports owners and administrators deleting Measurements within the workspace.

1. Enter **Management > Workspace Settings**;
2. Click **Delete Specified Measurement**;
3. Drop-down to select the Measurement name (fuzzy matching supported);
4. Click **Confirm**, and it will enter the deletion queue waiting for deletion.

???+ warning "Note"

    - Only workspace owners and administrators can perform this operation;

    - Once deleted, Measurements cannot be recovered, so proceed with caution;

    - Deleting Measurements will generate system notification events, such as users creating delete Measurement tasks, delete Measurement task execution success, delete Measurement task execution failure, etc.


### Delete Resource Catalog

<<< custom_key.brand_name >>> supports owners and administrators deleting specific resource catalog classifications and all resource catalogs.

1. Enter **Management > Workspace Settings**;
2. Click **Delete Resource Catalog**;
3. Choose the method of deleting the resource catalog;
4. Click **Confirm** to delete the corresponding object data.

- Specific Resource Catalog Classification: Only deletes data under the selected object classification without deleting the index;
- All Resource Catalogs: Deletes all resource catalog data and indexes.