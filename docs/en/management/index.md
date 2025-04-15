---
icon: zy/management
---
# Workspace Management
---

A workspace is the basic operation unit of <<< custom_key.brand_name >>>. Within <<< custom_key.brand_name >>> workspaces, you can use a variety of features provided by <<< custom_key.brand_name >>>. **Workspace Management** refers to the settings, management, and operations targeted at the current workspace. After joining a workspace and being assigned permissions, you can manage the basic information of the space, member permissions, SSO login, data permissions, API Key, notification targets, built-in views, charts, and snapshot sharing.

The following will introduce from the **personal account level** how to register and log in to an account and enter your workspace, focus on your account security, and set the appearance of your workspace.

## Workspace Related

### Create a Workspace {#create}

You can join one or more workspaces either by creating them or by invitation.

Before joining any workspace in any way, you need to [register for a <<< custom_key.brand_name >>> account](https://<<< custom_key.studio_main_site_auth >>>/businessRegister). After [registration is complete](../plans/commercial-huaweiyun.md), you can go through [<<< custom_key.brand_name >>> official website](https://<<< custom_key.brand_main_domain >>>/), click **Login**, select the registered site, input the login account and password, and log into the <<< custom_key.brand_name >>> console. The system will automatically create a workspace for you and assign **Owner** permissions.


Within an existing workspace, you can create other workspaces from the following two entry points:

<div class="grid" markdown>

=== "Entry 1"

    Click the bottom-left corner **Account > Create Workspace**.

    <img src="img/3.space_management_3.png" width="60%" >

=== "Entry 2"

    Click the top-left corner **Workspace Name > Create Workspace**.

    ![](img/3.space_management_1.png)

</div>

Enter the create workspace window:

1. Input the workspace name;
2. Select the language for this workspace;
3. Optionally add a description for the workspace;
4. Click **Confirm**.

<img src="img/9.space_management_1.png" width="60%" >


### SSO Account Login {#sso}

In addition to logging in via a <<< custom_key.brand_name >>> account registration, enterprise users can also log in to <<< custom_key.brand_name >>> through [SSO Single Sign-On](../management/sso/index.md).

Accounts that log in via SSO default to using the login retention time configured in SSO.

### Quick Search {#quick-entry}

In the left navigation bar > Quick Search, you can quickly view recently accessed pages within the current workspace as well as other feature-related pages:

![](img/quick-entry.png)

## Account Security Settings

### MFA Authentication {#mfa}

<<< custom_key.brand_name >>> provides MFA authentication management, helping to add an extra layer of security protection beyond just account username and password. After enabling MFA authentication, you will need to perform a second verification during login, thereby enhancing the security of your account.

> For more details, refer to [MFA Management](mfa-management.md).

### Login Hold Time {#login-hold-time}

<<< custom_key.brand_name >>> supports setting session hold times for accounts logging into workspaces, including both workspace-registered accounts and SSO single sign-on accounts.

Registered accounts can, within the workspace, click the bottom-left **Account > Account Management**, and under login hold time, modify the default login session hold time, including inactive login session hold time and maximum login session hold time. After setting, expired login sessions will become invalid.

- Inactive login session hold time: Supported range 30 ~ 10080 minutes, default is 10080 minutes;
- Maximum login session hold time: Supported range 1 ~ 30 days, default is 30 days.

<img src="img/6.mfa_2.1.png" width="70%" >

### Data Isolation and Data Authorization

If your company has multiple departments that need isolated data, you can create multiple workspaces and invite relevant departments or contacts to join the corresponding workspaces.

If you need to uniformly view data from different workspaces across all departments, you can authorize data from multiple workspaces to the current workspace through [data authorization](./data-authorization.md) configuration. You can query and display the data through scenario dashboards and chart components in notes.

### Cancel Account {#cancel}

???+ warning "Note"

    This entry is visible only for local accounts; single sign-on accounts do not have this entry.</font>

<img src="img/cancel.png" width="70%" >

:material-numeric-1-circle-outline: Choose any method shown above to verify your identity;

:material-numeric-2-circle-outline: If the current account is the owner of the workspace, please transfer this role permission first;

<img src="img/all-workspaces.png" width="60%" >

<img src="img/de-owner.png" width="70%" >

:material-numeric-3-circle-outline: Under the premise that the current account is not the owner, proceed to step three. Before confirming cancellation, note the following:

1. The account will be unable to log into <<< custom_key.brand_name >>> workspaces;  
2. All associated information of the account within the workspace will be cleared and cannot be recovered;  
3. Any submitted but unresolved tickets by the account will be closed within 7 working days.

After reading and agreeing to the related agreements, click **Confirm Cancellation** to cancel the current account.

<img src="img/confirm-cancel.png" width="60%" >

???+ warning "After the account is canceled:"

    1. For regular commercial versions: After the account is canceled, the email can still be re-registered. After re-registration, it becomes a completely new account, and historical account data will not be associated or displayed.
    2. For deployment versions: A new user can be created through [Management Backend > Add User](../deployment/user.md#add).

## Personal Account Settings {#personal}

???+ warning "Note"

    If the avatar is hidden in the management backend, configurations such as automatic refresh of the explorer and high-performance mode can be modified under **Management > User Settings**.

### User Information

In the workspace, click the left side **Account > Account Management**, where you can modify the avatar, username, email, phone, and password.

### Time Zone {#zone}

<<< custom_key.brand_name >>> supports members modifying their time zone, thus switching to the corresponding workspace time zone to view data. <<< custom_key.brand_name >>> defaults to following "Browser Time," i.e., the time detected by the local browser.

In the workspace, click the bottom-left **Account > Account Management > Time Zone** to modify the current time zone.
You can also use the [Time Widget](../getting-started/function-details/explorer-search.md#time) provided by <<< custom_key.brand_name >>> to quickly modify the time zone.

???+ warning "Note"

    After setting a new time zone, all workspaces associated with your current account will display according to the newly set time zone. Please operate with caution.

<img src="img/account-zone.png" width="70%" >


#### Workspace Time Zone {#workspace}

Considering that sometimes workspace data is reported based on one time zone, while members of the current workspace may be located in different countries or regions, to ensure all members analyze data and troubleshoot issues within the same time zone, you can go to **Workspace Management > Space Settings > Advanced Settings > Workspace Time Zone** to uniformly configure the time zone for members. After configuration, when other members of the workspace select the configured **Workspace Time Zone**, their time zone status will change accordingly.

???+ warning

    - Only the Owner and Administrator of the current workspace have the permission to configure the workspace time zone;          
    - When the workspace time zone is set, it will not automatically change the time zone of the members' workspaces, requiring manual selection by members;          
    - If the workspace time zone is deleted after other members of the workspace have selected the workspace time zone, the members' time zones will automatically revert to **Browser Time**.

### Incident Management {#personal_incidents}

Through this entry, the currently logged-in user can view and manage the status of all incident tracking in joined workspaces.

- Filtering by workspace and channel allows quick classification and location of generated Issues;
- You can directly search for workspace and channel names;
- In the upper right corner of the page, you can directly select "Only Show Mine" to view all incidents you are responsible for.

> For more settings, refer to [Manage Issues](../exception/channel.md#manag).

### System Notifications {#system-notice}

You can view unified system notifications for abnormal statuses in workspaces under the current account in the navigation bar > **System Notifications**, such as: data forwarding rules, cloud account availability status, alert rules, data usage limits, etc.

<img src="img/system-notice.png" width="70%" >

Click the subscription button above, and <<< custom_key.brand_name >>> will send relevant emails to your mailbox when there are new messages.

![](img/system-notice-1.png)

### High-Performance Mode

<<< custom_key.brand_name >>> supports high-performance chart loading mode, which is off by default.

<img src="img/3.customized_1.1.png" width="60%" >

*Example:*

After enabling high-performance mode, all charts will load statically instead of dynamically. When entering a page, all charts will be loaded directly, meaning that when scrolling down to view content beyond the current page, all charts have already been fully loaded, allowing direct viewing of the results.

???+ warning "Note"

    Enabling high-performance mode affects only the current user's chart-viewing scenarios.

![](img/3.high_performance_2.gif)


### System Theme {#theme}

<<< custom_key.brand_name >>> supports switching theme colors.

If the system theme is set to ["Auto"], it will automatically switch theme colors based on the computer's appearance.

<img src="img/3.high_performance_1.png" width="60%" >


## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Workspace Lock/Unlock/Dissolve**</font>](../billing-center/workspace-management.md#workspace-lock#lock)

</div>


</font>