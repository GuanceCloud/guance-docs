---
icon: zy/management
---
# Workspace Management
---
Guance will introduce you to this path **at the personal account level**: registering, logging into your account and entering your workspace > focusing on your account security > setting up your workspace apperance.
## Join Workspace

### Create Workspace
Before entering the Guance workspace, be sure that you have [registered a Guance account](https://auth.guance.com/businessRegister).  

After registration, you can click **Login** through [Guance Official Website](https://www.guance.com/), select the site you registered, enter the login account and password. For more registration details, please refer to the document [Register Commercial Plan](../billing/commercial-register.md).

???+ attention

    - Under a single Guance site, only one mobile phone number and one mailbox are supported, and Hong Kong, Macao and Taiwan and foreign mobile phone numbers are not supported for the time being.
    - The accounts of different sites are independent and do not communicate with each other. For more site descriptions, please refer to the document [select registered site](../getting-started/necessary-for-beginners/select-site.md).
    - [SSO](../management/sso/index.md) to Guance is supported.

After finishing steps above, you will join a workspace the system created by default, in which you obtain the **Owner** permission. 


You can create one or more workspaces from the following two entrances.

<div class="grid" markdown>

=== "Entrance 1"

    Click **Account > Create Workspace** in the lower left corner.

    ![](img/3.space_management_3.png)

=== "Entrance 2"

    Click **Workspace Name > Create Workspace** in the upper left corner of the studio page. 
    
    > Here you can switch to another workspace by clicking on the workspace.

    ![](img/3.space_management_1.png)

</div>


The following dialog box will pop out once you click **Create**. If you need to create a **SLS workspace of Exclusive Plan**, please refer to the doc [Guance Exclusive Plan in Alibaba Cloud Market](../billing/commercial-aliyun-sls.md).

> Workspace language options affect templates for events, alarms and text messages in the workspace. If you select English, the above corresponding template will be used by default. Once created, the template language of this workspace **cannot** be modified, so please choose carefully.

![](img/3.space_management_4.png)

#### SSO Account {#sso}

In addition to logging in by registering a Guance account, enterprise users are supported to log in to the Guance through SSO. After entering the workspace, click **Account** > **Account Management** on the left to modify the SSO account. Here you can:    
- modify avatar and user name;  
- modify [login retention time](#login-hold-time).

> Note: For accounts logged in through SSO, the login retention time configured by SSO is used by default. After account management is modified, the modified login retention time is used. For more details, please refer to the document [SSO Management](../management/sso/index.md).

### Switch Workspace   
If you belong to multiple Guance workspaces, you can jump to the page by clicking the upper-left workspace name of the studio to toggle between them.  

![](img/1-workspaceinfo.png)

## Security  
Guance has always valued users's account security, here are some related security settings. 

### MFA {#mfa}

Guance provides MFA management, which helps to add an additional layer of security protection to the account user name and password. After MFA is turned on, you need to perform secondary verification when logging in to help you improve the security of your account. See the documentation [MFA Management](mfa-management.md).

### Session Retention Time {#login-hold-time}

Guance supports setting session retention time for accounts logged into the workspace, including accounts registered in the workspace and SSO accounts.

Click your account on the lower-right corner of the stuido and click **Account Management**. In the session retention time, click to modify the default session retention time, including the inactive session retention time and the maximum session retention time. After setting, the timeout session will be invalid.

- No operation session retention time: From 30 to 1440 minutes, and the default is 30 minutes;
- Maximum retention time of session: From 0 to 7 days, where 0 means never timeout, and the default is 7 days.
   
![](img/6.mfa_2.1.png)

### Data Isolation and Authorization

If your company has multiple departments that need to isolate data, you can create multiple workspaces and invite related departments or stakeholders to join the corresponding workspaces.

If you need to view the data of different workspaces in all departments in a unified way, you can authorize the data of multiple workspaces to the current workspace by configuring [data authorization](data-authorization.md), and query and display them through the scene dashboard and chart components of notes.
## Preferences  
The followings are some personal settings.   
### Profile  
You can modify your avatar, username, email address, phone number and account password; 

### Time Zone

Time zone in Guance is `(UTC+08: 00) Beijing` by default. You can modify it according to your current time zone. After modification, all time displays in the platform will be affected. Please be careful.

> You can also quickly modify the time zone according to [time widget](../getting-started/function-details/explorer-search.md#time).

Note: If you select **Follow Browser Time** when modifying the time zone, it means that the time zone display of Guance can be automatically adjusted.

### System Notification

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Manage your System Notification Settigs</font>](./system-notification.md)

<br/>

</div>

### High Performance  
Guance supports chart high-performance loading mode, which is closed by default. You can click on the account in the lower-left corner and select **High-performance Mode** to open it.

![](img/3.customized_1.1.png)

<u>Example effect</u>

After the high-performance mode is turned on, all charts are not dynamically loaded, but directly loaded when clicking to enter the page, that is, all charts have been loaded when sliding down beyond the current page, and the display results can be directly viewed.

Note: When high performance mode is turned on, view the chart only for the current user.

![](img/3.high_performance_2.png)

### Theme

You can switch theme colors in Guance, including light color and dark color. Click on the account in the lower-left corner and choose to use it in **Theme**.

Note: The system theme selects **Automatic**, and the theme color can be automatically switched according to the computer appearance setting.<br />![](img/3.high_performance_1.png)

- Light color effect

![](img/08_color_02.png)

- Dark color effect

![](img/08_color_03.png)



## More Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Workspace Lock/Unlock/Dissolve</font>](../billing/cost-center/workspace-management.md#lock)

<br/>

</div>