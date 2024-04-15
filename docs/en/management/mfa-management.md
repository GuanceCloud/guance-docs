# MFA Management
---


Guance provides mandatory two-factor MFA security authentication, adding an additional layer of security protection beyond the account username and password. After enabling MFA, all members of the workspaces must complete MFA binding and authentication, otherwise they will not be able to access the workspace.

## Bind

In the Guance workspace, click on **Your Account > Account Management > Security Settings > MFA**, and click **Bind** on the right side.

<img src="../img/6.mfa_1.png" width="90%" >

MFA binding supports authentication through email. Click on Get Verification Code and enter the code, then click **Confirm**.

<img src="../img/1.mfa_2.1.png" width="50%" >

Download and install the Google Authenticator, Alibaba Cloud Identity Verification and other authentication apps on your mobile device, and scan to obtain the MFA security code.

![](img/1.mfa_4.1.png)

Enter the 6-digit dynamic security code obtained and click **Confirm**.

After clicking **Confirm**, a prompt will appear indicating successful MFA binding, and you will be returned to the **Account Management** page with the MFA status showing Bound.

![](img/6.mfa_1.1.png)

## Log in with MFA

When MFA mandatory authentication is enabled, if a member of the workspace has not bound MFA before logging in, they will need to complete the following steps for identity authentication.

![](../img/mfa-1.png)

If the current account has bound MFA, when logging into Guance, you must enter the 6-digit dynamic security code to log in:

![](../img/mfa-2.png)

## Unbind

### Method 1

If you no longer need to use MFA, you can unbind MFA from your account. In the Guance workspace, click on **Account Management > Security Settings > MFA**, click **Unbind** on the right side. Enter the dynamic code and click **Confirm**.

<img src="../img/1.mfa_8.png" width="60%" >

After unbinding, you will see that the MFA status is Unbound.

![](../img/6.mfa_1.png)

### Method 2

If you are unable to generate a security code for login because the device with MFA is not available, you can contact Guance customer service to request unbinding. On the login page, click on **Unbind MFA**, select the ticket type as **Unbind MFA**, fill in the ticket title, description and email verification code, then submit the ticket.

Once the Guance customer service receives the request, they will process it as soon as possible. 

> For more details, see [Tickets](work-order-management.md).

<img src="../img/1.work_order_2.png" width="60%" >