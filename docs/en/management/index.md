---
icon: zy/management
---
# Workspace Management
---

A workspace is the basic operational unit of <<< custom_key.brand_name >>>. Within <<< custom_key.brand_name >>> workspaces, you can use a variety of features provided by <<< custom_key.brand_name >>>. **Workspace management** involves settings, management, and operations for the current workspace. After joining a workspace and being assigned permissions, you can manage the basic information, member permissions, SSO login, data permissions, API Key, notification targets, built-in views, charts, and snapshot sharing.

The following sections introduce how to register and log into an account and enter your workspace, focus on account security, and set up the appearance of your workspace from the **personal account level**.

## Workspace Related

### Create a Workspace {#create}

You can join one or more workspaces by creating or being invited.

Before joining any workspace in any way, you need to [register for a <<< custom_key.brand_name >>> account](https://auth.guance.com/businessRegister). After [registration is complete](../plans/commercial-huaweiyun.md), you can go to the [<<< custom_key.brand_name >>> official website](https://www.guance.com/), click **Login**, select the registration site, enter your login account and password, and log in to the <<< custom_key.brand_name >>> console. The system will create a workspace for you by default and grant you **Owner** permissions.

Within an existing workspace, you can create other workspaces from the following two entry points:

<div class="grid" markdown>

=== "Entry 1"

    Click the lower-left corner **Account > Create Workspace**.

    <img src="img/3.space_management_3.png" width="60%" >

=== "Entry 2"

    Click the upper-left corner **Workspace Name > Create Workspace**.

    ![](img/3.space_management_1.png)

</div>

Enter the Create Workspace window:

1. Enter the workspace name;
2. Select the language for this workspace;
3. Optionally add a description for the workspace;
4. Click **Confirm**.

<img src="img/9.space_management_1.png" width="60%" >


### SSO Account Login {#sso}

In addition to logging in via a <<< custom_key.brand_name >>> account, enterprise users can also log in to <<< custom_key.brand_name >>> using [SSO single sign-on](../management/sso/index.md).

Accounts logging in via SSO use the login session duration configured in SSO by default.

### Quick Search {#quick-entry}

In the left navigation bar > Quick Search, you can quickly view recently visited pages and other function-related pages within the current workspace:

![](img/quick-entry.png)

## Account Security Settings

### MFA Authentication {#mfa}

<<< custom_key.brand_name >>> provides MFA authentication management to add an extra layer of security beyond usernames and passwords. After enabling MFA authentication, you will need to perform a second verification when logging in, thereby enhancing account security.

> For more details, refer to [MFA Management](mfa-management.md).

### Login Session Duration {#login-hold-time}

<<< custom_key.brand_name >>> supports setting session hold times for accounts logged into the workspace, including both registered accounts and SSO single sign-on accounts.

Registered accounts can click the lower-left corner **Account > Account Management** in the workspace, and under login hold time, modify the default login session hold time, including idle login session hold time and maximum login session hold time. After setting, expired login sessions will become invalid.

- Idle login session hold time: Supported range 30 ~ 10080 minutes, default is 10080 minutes;
- Maximum login session hold time: Supported range 1 ~ 30 days, default is 30 days.

<img src="img/6.mfa_2.1.png" width="70%" >

### Data Isolation and Data Authorization

If your company has multiple departments that need data isolation, you can create multiple workspaces and invite relevant departments or individuals to join the corresponding workspaces.

If you need to uniformly view data across different departmental workspaces, you can configure [data authorization](./data-authorization.md) to authorize data from multiple workspaces to the current workspace. You can then query and display data through scenario dashboards and chart components.

### Cancel Account {#cancel}

<font size=2>**Note**: This entry is only visible for local accounts; single sign-on accounts do not have this option.</font>

<img src="img/cancel.png" width="70%" >

:material-numeric-1-circle-outline: Choose any method in the above image for identity verification;

:material-numeric-2-circle-outline: If the current account is the workspace owner, transfer this role permission first;

<img src="img/all-workspaces.png" width="60%" >

<img src="img/de-owner.png" width="70%" >

:material-numeric-3-circle-outline: Proceed to step three if the current account is not an owner. Before confirming cancellation, note the following:

1. The account will no longer be able to log into <<< custom_key.brand_name >>> workspaces;  
2. All associated information within the workspace will be cleared and cannot be recovered;  
3. Any open tickets submitted by the account will be closed within 7 business days.

After reading and agreeing to the relevant agreement, click **Confirm Cancellation** to cancel the current account.

<img src="img/confirm-cancel.png" width="60%" >

???+ warning "After the account is canceled:"

    1. For the standard commercial plan: After cancellation, the email can be registered again. After re-registration, it becomes a new account, and historical account data will not be associated.
    2. For the deployment plan: A new user can be created via [Management Backend > Add User](../deployment/user.md#add).

## Personal Account Settings {#personal}

**Note**: If the avatar is hidden in the management backend, configurations such as automatic refresh of the Explorer and high-performance mode can be modified at **Management > User Settings**.

### User Information

In the workspace, click the left side **Account > Account Management** to modify the avatar, username, email, phone number, and password.

### Time Zone {#zone}

<<< custom_key.brand_name >>> supports members modifying their time zone to switch to the corresponding workspace time zone for viewing data. <<< custom_key.brand_name >>> defaults to "Browser Time," which is the time detected by the local browser.

In the workspace, click the lower-left corner **Account > Account Management > Time Zone** to modify the current time zone. You can also quickly change the time zone using the <<< custom_key.brand_name >>> [Time Widget](../getting-started/function-details/explorer-search.md#time).

**Note**: After setting a new time zone, all workspaces associated with your account will display according to the new time zone, so proceed with caution.

<img src="img/account-zone.png" width="70%" >

#### Workspace Time Zone {#workspace}

Considering that sometimes workspace data is reported based on a specific time zone while members may be located in different countries or regions, to ensure that all members analyze data and troubleshoot issues within the same time zone, you can go to **Workspace Management > Space Settings > Advanced Settings > Workspace Time Zone** to uniformly configure the time zone for members. After configuration, when other members of the workspace select the configured **Workspace Time Zone**, their time zone status will follow the changes in the configured space time zone.

???+ warning

    - Only the Owner and Administrator of the current workspace have the permission to configure the workspace time zone;          
    - Setting the workspace time zone does not automatically change the time zone of members in the workspace; they must manually select it;          
    - If the workspace time zone is deleted after other members have selected it, their time zones will revert to **Browser Time**.


### System Notifications {#system-notice}

You can view abnormal statuses in the current account's workspaces, such as data forwarding rules, cloud account availability, alert rules, and data usage limits, in the navigation bar > **System Notifications**.

<img src="img/system-notice.png" width="70%" >

Click the subscription button above, and <<< custom_key.brand_name >>> will send related emails to your inbox when there are new messages.

![](img/system-notice-1.png)

### High-Performance Mode

<<< custom_key.brand_name >>> supports high-performance chart loading mode, which is disabled by default.

<img src="img/3.customized_1.1.png" width="60%" >

*Example:*

After enabling high-performance mode, all charts are loaded statically and fully loaded upon entering the page. When scrolling down to view charts outside the current page, they are already fully loaded and ready for immediate viewing.

**Note**: Enabling high-performance mode affects only the current user's chart viewing scenarios.

![](img/3.high_performance_2.gif)


### System Theme {#theme}

<<< custom_key.brand_name >>> supports switching theme colors.

If the system theme is set to **Auto**, it will automatically switch based on the computer's appearance.

<img src="img/3.high_performance_1.png" width="60%" >



## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Lock/Unlock/Dissolve Workspace**</font>](../billing-center/workspace-management.md#workspace-lock#lock)

</div>


</font>