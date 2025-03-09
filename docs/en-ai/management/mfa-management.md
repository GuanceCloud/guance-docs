# MFA Management
---

<<< custom_key.brand_name >>> provides mandatory two-factor MFA security authentication, adding an extra layer of security protection beyond account usernames and passwords. After enabling MFA authentication, all workspace members must complete MFA binding and verification; otherwise, they will not be able to access the workspace.

## Binding MFA

In <<< custom_key.brand_name >>> workspace, click **Your Account > Account Management > Security Settings** under **MFA Authentication**, and click **Bind** on the right side.

<img src="../img/6.mfa_1.png" width="80%" >

Binding MFA authentication supports verification via email. Click to get the verification code, enter it, and then click **Confirm**.

<img src="../img/1.mfa_2.1.png" width="50%" >

On your mobile device, download and install Google Authenticator or identity verification apps like Alibaba Cloud, scan the QR code, and obtain the MFA security code.

![](img/1.mfa_4.1.png)

Enter the 6-digit dynamic security code you obtained and click **Confirm**.

<img src="../img/1.mfa_11.1.png" width="40%" >

After clicking **Confirm**, a prompt will indicate that MFA binding was successful, and you will return to the **Account Management** page. Under **MFA Authentication**, it will show "Bound".

![](img/6.mfa_1.1.png)

## Logging into MFA-Authenticated Accounts

When MFA mandatory authentication is enabled, if a workspace member has not bound MFA before logging in, they need to complete identity verification as follows:

![](img/mfa-1.png)

If the current account has already bound MFA, when logging into <<< custom_key.brand_name >>>, you need to enter the 6-digit dynamic security code to log in:

![](img/mfa-2.png)

<!--
A dialog box will appear prompting you to enter the 6-digit dynamic security code obtained from Google Authenticator and click **Confirm** to log in.

![](img/1.mfa_6.1.png)
-->

## Unbinding MFA

### Method One

If you no longer need MFA authentication, you can unbind MFA for your account. In <<< custom_key.brand_name >>> workspace, click **Account > Account Management**, under **Security Settings** for **MFA Authentication**, click **Unbind** on the right side, enter the dynamic code, and click **Confirm**.

![](img/1.mfa_8.png)

After unbinding, you will see that **MFA Authentication** shows "Not Bound".

![](img/6.mfa_1.png)

<!--
At the same time, you will receive an email notification from <<< custom_key.brand_name >>> regarding the unbinding.

![](img/1.mfa_10.png)
-->

### Method Two

If you do not have the device installed with MFA verification at login time and cannot generate the security code to log in, you can contact <<< custom_key.brand_name >>> customer service to request unbinding. On the login page, click **Unbind MFA**, select the ticket type as **Unbind MFA**, fill in the ticket title, description, and email verification code, and submit the ticket.

<<< custom_key.brand_name >>> customer service will process your request as soon as possible.

> For more details, refer to [Ticket Management](work-order-management.md).

<img src="../img/1.work_order_2.png" width="60%" >