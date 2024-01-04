---
icon: zy/management
---
# Workspace Management
---

The workspace is the basic operational unit for Guance. Within the Guance workspace, you can use the diverse functions provided by the Guance. **Workspace management** refers to the settings, management, and operations performed on the current workspace. After joining a workspace and being assigned permissions, you can manage the basic information of the workspace, member permissions, SSO, data permissions, API Key, notification targets, built-in views, chart and snapshot sharing, etc.

The following sections will guide you from the **personal account level** on how to register and log in to your account, ensure the security of your account, and customize the appearance of your workspace.

## Workspace

### Create Workspace {#create}

You can join one or more workspaces by creating or being invited to them.

Before entering the Guance workspace, be sure that you have [registered a Guance account](https://auth.guance.com/businessRegister). After registration, you can click **Login** through [Guance Official Website](https://www.guance.one/), select the site you registered, enter the login account and password. The system will automatically create a workspace for you and assign Owner permission.

<img src="img/0712-login.png" width="70%" >


You can create one or more workspaces from the following two entrances:


- Entrance 1

Click **Account > Create Workspace** in the lower left corner.

<img src="img/3.space_management_3.png" width="60%" >

- Entrance 2

Click **Workspace Name > Create Workspace** in the upper left corner of the studio page. 

![](img/3.space_management_1.png)


When **Creating Workspace**, enter a workspace name, select the workspace language, and describe the workspace as needed. You can also select different workspace directory style attributes based on roles.

<img src="img/9.space_management_1.png" width="70%" >

- The workspace directories under different roles are displayed by default as follows:

<div class="grid" markdown>

=== "Dev"

    <img src="img/yanfa.png" width="60%" >

=== "Ops"

    <img src="img/yunwei.png" width="60%" >

=== "Test"

    <img src="img/ceshi.png" width="60%" >

=== "Default"

    <img src="img/moren.png" width="60%" >

</div>

If you need to set the menu, you can go to **Management > Advanced Settings > [Function Menu Management](./settings/customized-menu.md)** to modify it.

???- warning "Details Worthy of Attention"

    - Under a single Guance site, only one mobile phone number and one mailbox are supported, and Hong Kong(China), Macao(China) and Taiwan(China) and foreign mobile phone numbers are not supported for the time being.   
    - The accounts of different sites are independent and do not communicate with each other.   
    > For more site descriptions, see [Select Registered Site](../getting-started/necessary-for-beginners/select-site.md).
    - [SSO](../management/sso/index.md) to Guance is supported.


> If you need to create a **SLS workspace of Exclusive Plan**, see [Guance Exclusive Plan in Alibaba Cloud Market](../billing/commercial-aliyun-sls.md).

#### SSO Account {#sso}

In addition to logging in by registering a Guance account, enterprise users are supported to log in to the Guance through [SSO](../management/sso/index.md).

For accounts logged in through SSO, the login session configured by SSO is used by default. After account management is modified, the modified login session is used.



## Security  

Guance has always valued users's account security, here are some related security settings. 

### MFA {#mfa}

Guance provides MFA management, which helps to add an additional layer of security protection to the account user name and password. After MFA is turned on, you need to perform secondary verification when logging in to help you improve the security of your account. 

> See [MFA Management](mfa-management.md).

### Login Session {#login-hold-time}

Guance supports setting login session for accounts logged into the workspace, including accounts registered in the workspace and SSO accounts.

Click your account on the lower-right corner of the stuido and click **Account Management**. In the login session, click to modify the default login session, including the inactive login session and the maximum login session. After setting, the timeout session will be invalid.

- No operation login session: From 30 to 1440 minutes, and the default is 30 minutes;
- Maximum retention time of session: From 0 to 7 days, where 0 means never timeout, and the default is 7 days.
   
<img src="img/6.mfa_2.1.png" width="60%" >

### Data Isolation and Authorization

If your company has multiple departments that need to isolate data, you can create multiple workspaces and invite related departments or stakeholders to join the corresponding workspaces.

If you need to view the data of different workspaces in all departments in a unified way, you can authorize the data of multiple workspaces to the current workspace by configuring [data authorization](data-authorization.md), and query and display them through the scene dashboard and chart components of notes.

## Preferences  

The followings are some personal settings.   

### Profile  

You can modify your avatar, username, email address, phone number and account password; 

### Time Zone {#zone}


Guance supports members to modify time zones in order to switch to the corresponding workspace time zone to view data. Guance defaults to adopt browser time, which is the time detected by your local browser.

In the workspace, click on the bottom left corner **Account > Account Management > Time Zone** to modify the current time zone.

**Note**: After setting a new time zone, all workspaces in which your current account is located will be displayed according to the set time zone. Please proceed with caution.

![](img/account-zone.png)

You can also use the [Time Widget](../getting-started/function-details/explorer-search.md#time) to quickly modify the time zone.


#### Workspace Time Zone {#workspace}

Considering that the data in a workspace is sometimes reported based on a specific time zone, while the members of the current workspace may be located in different countries or regions, it is important to ensure that all members can analyze data and troubleshoot issues in the same time zone. You can go to **Workspace Management > Settings > Advanced Settings > Time Zone** to configure the time zone for all members. Once the configuration is completed, when other members of the workspace select the configured Workspace Time Zone, their time zone will automatically adjust accordingly.

???+ warning

    - Only the Owner and Administrators of the current workspace have the permission to configure the Workspace Time Zone.   
    - When the Workspace Time Zone is set, it will not automatically change the time zone of the members in the workspace. They need to manually select it.            
    - When other members of the workspace have selected the workspace time zone, if the workspace time zone is deleted, the member's time zone will automatically change to browser time.  

<img src="img/zone-1.png" width="60%" >


### System Notification

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Manage your System Notification Settigs</font>](./system-notification.md)


</div>

### High Performance  

Guance supports chart high-performance loading mode, which is closed by default. You can click on the account in the lower-left corner and select **High-performance Mode** to open it.

<img src="img/3.customized_1.1.png" width="60%" >

*Example:*

After the high-performance mode is turned on, all charts are not dynamically loaded, but directly loaded when clicking to enter the page, that is, all charts have been loaded when sliding down beyond the current page, and the display results can be directly viewed.

**Note**: After enabling the high-performance mode, it only affects the current user's viewing of charts.

![](img/3.high_performance_2.gif)

### Theme

You can switch theme colors in Guance, including light color and dark color. Click on the account in the lower-left corner and choose to use it in **Theme**.

<img src="img/3.high_performance_1.png" width="60%" >

<div class="grid" markdown>

=== "Light color effect"
                                                              
    ![](img/08_color_02.png)

=== "Dark color effect"

    ![](img/08_color_03.png)

</div>

## More Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Workspace Lock/Unlock/Dissolve**</font>](../billing/cost-center/workspace-management.md#lock)


</div>