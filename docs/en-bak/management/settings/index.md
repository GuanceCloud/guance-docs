# Settings

After joining the workspace and being assigned permissions, you can see a series of settings about the current workspace.

<img src="../img/3.space_management_6.png" width="90%" >

## Basic Information


### Workspace Language {#language}

<img src="../img/space-language.png" width="50%" >

In the workspace, you can modify the workspace language. Currently, there are two options: Chinese and English.

This configuration affects templates such as events, alerting, and SMS within the workspace. After switching, the above templates will default to using the language template that was switched to.

<img src="../img/space-language-correct.png" width="60%" >

**Note**:

- The workspace language here is different from the **display language** of your space page: Guance will use the default display language of the system console based on your local browser history login or the local browser language as the default display language when you log in to the workspace. For example, if your browser is set to use Chinese, the workspace console will default to displaying Chinese.
- Only the workspace Owner and Administrators have permission to modify the workspace language.

### Remarks {#remark}

Guance supports setting remarks for the current workspace to help users obtain clearer information about the workspace name, etc.

In **Management > Settings > Basic Information**, set the remarks to be viewed.

<img src="../img/3.space_management_7.1.png" width="70%" >

After the settings are completed, you can view the remarks in the upper-left corner of the workspace.

<img src="../img/3.space_management_7.png" width="60%" >

Click on the workspace name to view all workspaces and their remarks. Click the **Edit** button next to the remarks to add or modify the content.

<img src="../img/3.space_management_7.2.png" width="70%" >

### Change Token {#token}

Guance supports the Owner and Administrators of the current space to copy/change the Token in the workspace and customize the expiration time of the current Token. Go to **Management > Basic Settings > Change Token**, select the expiration time, and confirm **Change**. Guance will automatically generate a new Token, and the old Token will expire within the specified time.

???+ warning "The effect of change Token"

    - Changing the Token will trigger [**Operation Audit**](../settings/operation-audit.md) and [**Notification**](../system-notification.md);
    
    - After changing the Token, the old Token will expire within the specified time. The expiration time includes: immediate, 10 minutes, 6 hours, 12 hours, 24 hours. Immediate expiration is generally used for Token leaks. After selecting immediate expiration, the old Token will immediately stop data reporting. If anomaly detection is set up, events and alarm notifications cannot be triggered until the old Token in the `datakit.conf` of DataKit collector is modified to the newly generated Token.
    
    > For the storage directory of the `datakit.conf` file, see [Getting Started with DataKit](../datakit/datakit-conf.md).


### Migration {#export-import}

Guance supports Owners and Administrators to import and export JSON configuration files of dashboards, custom explorers, and monitors in the workspace with one click. Go to **Management > Settings**, and choose Export or Import in **Migration**.

During the import process, if there are duplicate names for dashboards, explorers, or monitors in the current workspace, a prompt will appear indicating that the imported file has duplicate names. You can choose whether to **Skip**, **Still Create**, or **Cancel** based on your actual needs.

- Skip: Only create files that are not duplicate names;
- Still Create: Create corresponding dashboards, explorers, and monitors based on the imported file names;
- Cancel: Cancel the file import operation, no files will be imported.

**Note**: JSON configuration files of dashboards, explorers, and monitors in other workspaces can be imported in compressed format.


### Advanced Settings

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: Key Metrics</font>](../settings/key-metrics.md)

<br/>

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: Customized Menu</font>](../settings/customized-menu.md)

<br/>

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: Workspace Time Zone</font>](../index.md#workspace)

<br/>

</div>

## Security

### Invitation Approval

After enabling the switch, after the notification for [inviting members](../invite-member.md) is sent, the invited members need to be approved by the current workspace Owner and Administrators before they can join the workspace. If not enabled, the invited members can directly enter the workspace.

### MFA Security Authentication

After enabling, all members of the workspace must complete [MFA binding and authentication](../mfa-management.md) to enter the workspace.

### IP Whitelist {#ip}

Guance supports configuring an IP whitelist for the workspace to restrict visiting users. After enabling the IP whitelist, only IP sources in the whitelist can log in normally, and other source requests will be denied access.

Only Administrators and Owners can set the IP whitelist, and the **Owner** is not subject to IP whitelist access restrictions.

The IP whitelist is written as follows:

- Multiple IPs need to be separated by line breaks, and only one IP or subnet is allowed per line, with a maximum of 1000 IPs;
- Specify an IP address: 192.168.0.1, which means allowing the IP address 192.168.0.1 to access;
- Specify an IP range: 192.168.0.0/24, which means allowing the IP addresses from 192.168.0.1 to 192.168.0.255 to access;
- All IP addresses: 0.0.0.0/0.

<img src="../img/6.space_ip_1.png" width="60%" >

## Risky Operations

### Change Data Storage Strategy

Guance supports Owners to change the data storage strategy in the workspace. Go to **Management > Settings**, click **Change**, select your desired data storage duration, and click **Confirm** to change the data storage duration in the current workspace.

> For more information, refer to [Data Storage strategy](../../billing/billing-method/data-storage.md).

<img src="../img/strategy-0815.png" width="60%" >

### Delete Measurement

Guance supports Owners and Administrators to delete Measurements in the workspace. Go to **Management > Settings**, click **Delete**, enter the query, and select the Measurement name (supports fuzzy matching). Click **Confirm** to enter the delete queue and wait for deletion.

**Note**:

- Only the workspace Owner and Administrators are allowed to perform this operation;
- Once the Measurement is deleted, it cannot be recovered, so please proceed with caution;
- When deleting a Measurement, system notification events will be generated, such as when a user creates a task to delete a Measurement, when a task to delete a Measurement is executed successfully, and when a task to delete a Measurement fails.

<img src="../img/11.metric_1.png" width="60%" >

### Delete Custom Objects

Guance supports Owners and Administrators to delete specified custom object categories and all custom objects. Go to **Management > Settings**, click **Delete**, and select the method to delete the corresponding object data.

- Specify custom object category: Only delete the data under the selected object category without deleting the index;
- All custom objects: Delete all custom object data and indexes.

<img src="../img/7.custom_cloud_3.png" width="60%" >