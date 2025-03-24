---
icon: zy/management
---
# Workspace Management
---

A workspace is the basic operational unit of <<< custom_key.brand_name >>>. Within the <<< custom_key.brand_name >>> workspace, you can use the diverse functionalities provided by <<< custom_key.brand_name >>>. **Workspace management** involves settings, administration, and operations specific to the current workspace. After joining a workspace and being assigned permissions, you can manage the basic information, member permissions, SSO login, data permissions, API Key, notification targets, built-in views, charts, and snapshot sharing.

The following section will introduce from the **personal account level** how to register and log into your account to enter your workspace, focus on account security, and set up the appearance of your workspace.

## Workspace Related

### Create a Workspace {#create}

You can join one or more workspaces either by creating one or being invited.

Before joining any workspace in any way, you need to first [register for a <<< custom_key.brand_name >>> account](https://<<< custom_key.studio_main_site_auth >>>/businessRegister). After [registration is completed](../plans/commercial-huaweiyun.md), you can go to the [<<< custom_key.brand_name >>> official website](https://<<< custom_key.brand_main_domain >>>/), click **Login**, select the registration site, input your login account and password, and log into the <<< custom_key.brand_name >>> console. The system will default create a workspace for you and assign **Owner** permissions.


Within an existing workspace, you can create other workspaces from the following two entry points:

<div class="grid" markdown>

=== "Entry 1"

    Click the lower-left corner **Account > Create Workspace**.

    <img src="img/3.space_management_3.png" width="60%" >

=== "Entry 2"

    Click the upper-left corner **Workspace Name > Create Workspace**.

    ![](img/3.space_management_1.png)

</div>

Enter the create workspace window:

1. Input the workspace name;
2. Select the language for this workspace;
3. Optionally add a description for this workspace;
4. Click **Confirm**.

<img src="img/9.space_management_1.png" width="60%" >


### SSO Account Login {#sso}

In addition to logging in via a <<< custom_key.brand_name >>> account registration, enterprise users can also log in through [SSO single sign-on](../management/sso/index.md) to <<< custom_key.brand_name >>>.

Accounts logging in via SSO will default to the session retention time configured in SSO.

### Quick Search {#quick-entry}

In the left navigation bar > Quick Search, you can quickly view recently accessed pages within the current workspace as well as other function-related pages:

![](img/quick-entry.png)

## Account Security Settings

### MFA Authentication {#mfa}

<<< custom_key.brand_name >>> provides MFA authentication management to help add an extra layer of security protection beyond account usernames and passwords. After enabling MFA authentication, you will need to perform a second verification during login, thereby enhancing the security of your account.

> For more details, refer to [MFA Management](mfa-management.md).

### Login Session Hold Time {#login-hold-time}

<<< custom_key.brand_name >>> supports setting session hold times for accounts logging into workspaces, including accounts registered with the workspace and those using SSO single sign-on.

Registered accounts can, within the workspace, click the lower-left corner **Account > Account Management**, and under login session hold time, modify the default login session hold time, including inactive session hold time and maximum session hold time. After setting, timed-out login sessions will become invalid.

- Inactive session hold time: Supported range 30 ~ 10080 minutes, default is 10080 minutes;
- Maximum session hold time: Supported range 1 ~ 30 days, default is 30 days.

<img src="img/6.mfa_2.1.png" width="70%" >

### Data Isolation and Data Authorization

If your company has multiple departments that require data isolation, you can create multiple workspaces and invite relevant departments or contacts to join corresponding workspaces.

If you need to uniformly view data across different departmental workspaces, you can authorize data from multiple workspaces to the current workspace through [data authorization](./data-authorization.md) configuration, and query and display it using scenario dashboards and chart components.

### Cancel Account {#cancel}

<font size=2>**Note**: This entry point is visible only for local accounts; single sign-on accounts do not have this entry.</font>

<img src="img/cancel.png" width="70%" >

:material-numeric-1-circle-outline: Choose any method from the image above for identity verification;

:material-numeric-2-circle-outline: If the current account is the owner of the workspace, please transfer this role permission first;

<img src="img/all-workspaces.png" width="60%" >

<img src="img/de-owner.png" width="70%" >

:material-numeric-3-circle-outline: Under the premise that the current account is not the owner, proceed to step three. Before confirming cancellation, note the following:

1. The account will no longer be able to log into <<< custom_key.brand_name >>> workspaces;  
2. All associated information of the account within the workspace will be cleared and cannot be recovered;  
3. Any submitted unresolved tickets will be closed within 7 working days.

After reading and agreeing to the relevant agreements, click **Confirm Cancellation** to cancel the current account.

<img src="img/confirm-cancel.png" width="60%" >

???+ warning "After account cancellation:"

    1. For standard Commercial Plans: After account cancellation, the email can be re-registered. After re-registration, it will be a completely new account, and historical account data will not be associated or displayed.
    2. For Deployment Plans: You can create an account through [Management Console > Add User](../deployment/user.md#add).

## Personal Account Settings {#personal}

**Note**: If the avatar is hidden in the management console, configurations such as automatic refresh of Explorers and high-performance mode can be modified under **Management > User Settings**.

### User Information

In the workspace, click the left side **Account > Account Management**, where you can modify the avatar, username, email, phone number, and password.

### Time Zone {#zone}

<<< custom_key.brand_name >>> supports members modifying their time zone to switch to the corresponding workspace time zone to view data. <<< custom_key.brand_name >>> defaults to follow "Browser Time," which is the time detected by the local browser.

In the workspace, click the lower-left corner **Account > Account Management > Time Zone** to modify the current time zone.
You can also quickly modify the time zone via the [Time Widget](../getting-started/function-details/explorer-search.md#time) provided by <<< custom_key.brand_name >>>.

**Note**: After setting a new time zone, all workspaces associated with your current account will display according to the newly set time zone. Please operate carefully.

<img src="img/account-zone.png" width="70%" >



#### Workspace Time Zone {#workspace}

Considering that sometimes workspace data is reported based on a specific time zone, while members of the current workspace may be located in different countries or regions, to ensure that all members can analyze data and troubleshoot issues within the same time zone, you can navigate to **Workspace Management > Space Settings > Advanced Settings > Workspace Time Zone** to configure a unified time zone for members. After configuration, when other members of the workspace select the configured **Workspace Time Zone**, their time zone status will change accordingly.

???+ warning

    - Only the Owner and Administrator of the current workspace have the permission to configure the workspace time zone;          
    - When the workspace time zone is set, it will not automatically change the time zone of the members' workspaces; they must manually select it;          
    - If other members of the workspace have selected the workspace time zone, and the workspace time zone is deleted, the members' time zones will automatically revert to **Browser Time**.    

### Incident Management {#personal_incidents}

Through this entry, the currently logged-in user can view and manage the status of all anomaly tracking incidents in joined workspaces.

- Filtering by space and channel can quickly categorize and locate generated Issues;
- You can directly search for workspace or channel names;
- In the upper-right corner of the page, you can choose to view only the anomalies you are responsible for.

> For more settings, refer to [Manage Issues](../exception/channel.md#manag).

### System Notifications {#system-notice}


You can view unified system notifications for abnormal statuses in the current account's workspaces in the navigation bar > **System Notifications**, such as: data forwarding rules, cloud account availability, alert rules, data usage limits, etc.

<img src="img/system-notice.png" width="70%" >

Click the subscription button at the top, and <<< custom_key.brand_name >>> will send related emails to your mailbox when there are new messages.

![](img/system-notice-1.png)

### High-Performance Mode

<<< custom_key.brand_name >>> supports high-performance chart loading mode, which is off by default.

<img src="img/3.customized_1.1.png" width="60%" >

*Example:*

After enabling high-performance mode, all charts will not load dynamically but will be fully loaded upon entering the page. That is, when scrolling down to view beyond the current page, all charts will already be fully loaded and ready for immediate viewing.

**Note**: Enabling high-performance mode will only affect the chart-viewing scenarios for the current user.

![](img/3.high_performance_2.gif)


### System Theme {#theme}

<<< custom_key.brand_name >>> supports switching theme colors.

If the system theme is set to ["Auto"], it will automatically switch theme colors based on the computer's appearance.

<img src="img/3.high_performance_1.png" width="60%" >




## More Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Workspace Lock/Unlock/Dissolve**</font>](../billing-center/workspace-management.md#workspace-lock#lock)

</div>


</font>