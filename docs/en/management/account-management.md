# Account Management
---

Guance supports registered users to enter the workspace and enjoy related services through multi-site login. If you need to manage and set the current account, you can use **Account** > **Personal Settings** > **Basic Settings**.


## Register an account

You can go to [Guance official website](https://www.guance.com/) and **[Register](https://auth.guance.com/businessRegister)** as a Guance user. For more registration details, please refer to the document [register commercial plan](../billing/commercial-register.md).

## Login in

After registration, you can click **Login** through [Guance official website](https://www.guance.com/), select the site you registered, enter the login account and password and log in to the Guance studio.

???+ attention

    - Under a single Guance site, only one mobile phone number and one mailbox are supported, and Hong Kong, Macao and Taiwan and foreign mobile phone numbers are not supported for the time being.
    - The accounts of different sites are independent and do not communicate with each other. For more site descriptions, please refer to the document [select registered site](../getting-started/necessary-for-beginners/select-site.md).
    - Support for selecting [SSO](../management/sso/index.md) to Guance.

## Beginner Guide

After logging in to the Guance console, Guance provides a series of guidance services for new users. You can quickly understand Guance through the small videos of **Guance Product Introduction** and **Guance Product Architecture**; Or you can install and configure the first DataKit by clicking [Start with Installing DataKit](../datakit/datakit-install.md).

![](img/1-free-start-1109.png)


## Modify Account User Info


After the account registration is completed, click **Account** > **Settings** > **Basic Settings** on the left side to modify the account. Modifying account name, email address, mobile phone and password is supported here.<br />![](img/1-space-1130.png)


## SSO Account

In addition to logging in by registering the Guance account, enterprise users are supported to log in to the Guance through SSO. For more details, please refer to the document [SSO management](../management/sso/index.md).

## Account Security Settings

### MFA Authentication

Guance provides MFA authentication management, which helps to add an additional layer of security protection to the account user name and password. After MFA authentication is turned on, you need to perform secondary verification when logging in to help you improve the security of your account. See the documentation [MFA management](mfa-management.md).

### Login Retention Time {#login-hold-time}

Guance supports setting session retention time for accounts logged into the workspace, including accounts registered in the workspace and SSO accounts.

To register an account, click **Account** > **Account Management** in the lower left corner of the workspace. In the login retention time, click to modify the default login session retention time, including the inactive login session retention time and the maximum login session retention time. After setting, the timeout login session will be invalid.

- No operation login session retention time: the supporting setting range is from 30 to 1440 minutes, and the default is 30 minutes;
- Maximum hold time of login session: the supporting setting range is from 0 to 7 days, where 0 means never timeout, and the default is 7 days.

SSO login account uses SSO configured login retention time by default. For more details, refer to the documentation [SSO setting login session retention time](../management/sso/index.md#login-hold-time).

![](img/6.mfa_2.1.png)



---

