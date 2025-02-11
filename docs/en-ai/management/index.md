---
icon: zy/management
---
# Workspace Management

---

A workspace is the fundamental operational unit of Guance. Within a Guance workspace, you can utilize a variety of features provided by Guance. **Workspace management** involves settings, administration, and operations specific to the current workspace. After joining a workspace and being assigned permissions, you can manage the basic information, member permissions, SSO login, data permissions, API Key, notification targets, built-in views, charts, and snapshot sharing.

The following sections will introduce **how to register and log in to an account and enter your workspace, focus on account security, and set up the appearance of your workspace** from the **personal account level**.

## Workspace Related

### Creating a Workspace {#create}

You can join one or more workspaces either by creating them or being invited.

Before joining any workspace, you need to [register a Guance account](https://auth.guance.com/businessRegister). After [registration is complete](../plans/commercial-huaweiyun.md), you can visit the [Guance official website](https://www.guance.com/), click **Login**, select the registration site, enter your login credentials, and log into the Guance console. The system will automatically create a workspace for you and assign you **Owner** permissions.

Within an existing workspace, you can create other workspaces via two entry points:

<div class="grid" markdown>

=== "Entry 1"

    Click the bottom-left corner's **Account > Create Workspace**.

    <img src="img/3.space_management_3.png" width="60%" >

=== "Entry 2"

    Click the top-left corner's **Workspace Name > New Workspace**.

    ![](img/3.space_management_1.png)

</div>

To enter the workspace creation window:

1. Input the workspace name;
2. Select the language for this workspace;
3. Optionally add a description;
4. Click **Confirm**.

<img src="img/9.space_management_1.png" width="60%" >

### SSO Account Login {#sso}

In addition to logging in with a registered Guance account, enterprise users can also log in via [SSO Single Sign-On](../management/sso/index.md).

Accounts logged in through SSO use the default session duration configured in the SSO setup.

### Quick Search {#quick-entry}

In the left navigation bar > Quick Search, you can quickly view recently accessed pages and other relevant functional pages within the current workspace:

![](img/quick-entry.png)

## Account Security Settings

### MFA Authentication {#mfa}

Guance provides MFA (Multi-Factor Authentication) management to add an extra layer of security beyond usernames and passwords. Enabling MFA requires a second verification step during login, enhancing your account's security.

> For more details, refer to [MFA Management](mfa-management.md).

### Login Session Duration {#login-hold-time}

Guance supports setting session hold times for accounts accessing workspaces, including both registered accounts and SSO single sign-on accounts.

Registered accounts can modify the default session hold time by clicking **Account > Account Management** in the lower-left corner of the workspace. Adjustments include idle session hold time and maximum session hold time. After setting, expired sessions will become invalid.

- Idle session hold time: Settable range is 30 ~ 10080 minutes; default is 10080 minutes.
- Maximum session hold time: Settable range is 1 ~ 30 days; default is 30 days.

<img src="img/6.mfa_2.1.png" width="70%" >

### Data Isolation and Data Authorization

If your company has multiple departments that require data isolation, you can create multiple workspaces and invite relevant departments or individuals to join the corresponding workspaces.

If you need to view data from different departmental workspaces uniformly, you can configure [data authorization](./data-authorization.md) to grant data access from multiple workspaces to the current workspace. Use scenario dashboards and chart components to query and display the data.

### Cancel Account {#cancel}

<font size=2>**Note**: This option is only visible for local accounts; SSO accounts do not have this option.</font>

<img src="img/cancel.png" width="70%" >

:material-numeric-1-circle-outline: Choose any method shown above for identity verification;

:material-numeric-2-circle-outline: If the current account is the workspace owner, transfer ownership first;

<img src="img/all-workspaces.png" width="60%" >

<img src="img/de-owner.png" width="70%" >

:material-numeric-3-circle-outline: Proceed to step three if the current account is not an owner. Before confirming cancellation, note:

1. The account will no longer be able to log into the Guance workspace;
2. All associated information within the workspace will be cleared and cannot be recovered;
3. Any open tickets submitted by the account will be closed within 7 working days.

After reading and agreeing to the terms, click **Confirm Cancellation** to delete the current account.

<img src="img/confirm-cancel.png" width="60%" >

???+ warning "After account cancellation:"

    1. For regular Commercial Plan accounts: The canceled email address can be registered again. After re-registration, it will be a new account with no association to historical data.
    2. For Deployment Plan accounts: You can [add users via the admin backend](../deployment/user.md#add).

## Personal Account Settings {#personal}

**Note**: If the avatar is hidden in the admin backend, configurations like auto-refresh for Explorers and high-performance mode can be modified in **Admin > User Settings**.

### User Information

In the workspace, click the left side's **Account > Account Management** to change the avatar, username, email, phone number, and password.

### Time Zone {#zone}

Guance supports members changing their time zone to switch to the corresponding workspace time zone when viewing data. By default, Guance follows the "browser time," which is the time detected by the local browser.

In the workspace, click the bottom-left corner's **Account > Account Management > Time Zone** to modify the current time zone. You can also use the [time control widget](../getting-started/function-details/explorer-search.md#time) provided by Guance to quickly change the time zone.

**Note**: After setting a new time zone, all workspaces associated with your account will display data according to the new time zone. Please proceed with caution.

<img src="img/account-zone.png" width="70%" >

#### Workspace Time Zone {#workspace}

Considering that sometimes workspace data is reported based on a specific time zone, while members may be in different countries or regions, to ensure consistent data analysis and troubleshooting, you can go to **Workspace Management > Space Settings > Advanced Settings > Workspace Time Zone** to configure a unified time zone for members. After configuration, when other workspace members select the configured **Workspace Time Zone**, their time zone status will follow the configured workspace time zone changes.

???+ warning

    - Only Owners and Administrators of the current workspace have the permission to configure the workspace time zone.
    - When the workspace time zone is set, it does not automatically change the time zone of members' workspaces; members must manually select it.
    - If other workspace members select the workspace time zone and it is later deleted, their time zone will revert to **Browser Time**.

### System Notifications {#system-notice}

You can view abnormal statuses of the current account's workspaces, such as data forwarding rules, cloud account availability, alert rules, and data usage limits, under **System Notifications** in the navigation bar.

<img src="img/system-notice.png" width="70%" >

Click the subscription button at the top to receive emails for new notifications.

![](img/system-notice-1.png)

### High-Performance Mode

Guance supports high-performance chart loading mode, which is disabled by default.

<img src="img/3.customized_1.1.png" width="60%" >

*Example:*

After enabling high-performance mode, all charts load statically rather than dynamically. When entering a page, all charts are preloaded, so they are fully loaded and ready to view when scrolling down.

**Note**: Enabling high-performance mode affects only the current user's chart viewing experience.

![](img/3.high_performance_2.gif)

### System Theme {#theme}

Guance supports switching theme colors.

If the system theme is set to **Automatic**, it will switch based on the computer's appearance settings.

<img src="img/3.high_performance_1.png" width="60%" >

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Workspace Lock/Unlock/Dissolve**</font>](../billing-center/workspace-management.md#workspace-lock#lock)

</div>


</font>