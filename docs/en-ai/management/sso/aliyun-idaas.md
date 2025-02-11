# Alibaba Cloud IDaaS Single Sign-On Example
---

## Operation Scenario

Alibaba Cloud IDaaS (Yundun) is an identity recognition and access management solution provider. Guance supports federated identity authentication based on SAML 2.0 (Security Assertion Markup Language 2.0), which is an open standard used by many identity providers (Identity Provider, IdP). You can integrate Yundun with Guance via SAML 2.0 federated identity authentication to achieve automatic login (single sign-on) into the Guance platform for accessing corresponding workspace resources without needing to create separate Guance accounts for enterprises/teams.

## Operation Steps {#step1}

1. Create an Application in Alibaba Cloud IDaaS

**Note**: Before creating an application, you need to register an account and create your organization on the [IDaaS Platform (Yundun)](https://yundun.console.aliyun.com/).

1) Open the IDaaS console, go to **Add Application > Standard Protocol**, and select to create a SAML 2.0 SSO application. (This example uses the Guance application.)

![](../img/06_aliyun_01.png)

![](../img/06_aliyun_02.png)

2) After creating the application, click **Manage** to enter the application configuration interface. Before configuring single sign-on, you can configure application accounts and authorization first.

① Add application accounts

![](../img/06_aliyun_03.png)

![](../img/06_aliyun_04.png)

② In this example, default authorization allows all members to access. If special authorization is required, you can click **Authorization** to change the permission settings.

![](../img/06_aliyun_05.png)

3) After configuring application accounts and authorization, click into the **Single Sign-On** page, locate the **Application Configuration Information** module, and click **Download** to obtain the IdP metadata file.

![](../img/06_aliyun_06.png)

2. Enable SSO Single Sign-On in Guance and Update Configuration in IDaaS Platform

1) Enable SSO single sign-on in the Guance workspace **Management > Member Management > SSO Management**, and click **Enable**.

> Refer to [Create SSO](../../management/sso/index.md).

**Note**: For account security reasons, Guance supports configuring only one SSO per workspace. If you have already configured SAML 2.0 before, we will consider the last updated SAML 2.0 configuration as the final single sign-on entry point.

![](../img/1.sso_enable.png)

2) Upload the **Metadata Document** downloaded in [Step 1](#step1), configure the **domain name (email suffix domain)**, and select the **role** to obtain the **entity ID** and **assertion address** of the identity provider. Download the service provider's Metadata data (you can save it by right-clicking after visiting the link in the browser).

**Note**: The domain name is used for email domain mapping between Guance and the identity provider to achieve single sign-on, i.e., the suffix domain of the user's email must match the domain added in Guance.

![](../img/1.sso_enable_2.png)

3) Update the single sign-on configuration on the IDaaS side

① Import the SP Metadata file obtained in Step 2

② Click **Parse** after importing the Metadata to automatically import the ACS URL and Entity ID parameters below

③ Change the configuration under **Application Account** to **IDaaS Account / Email**

④ Expand [Advanced Configuration]. (In SaaS environments, assertion signing is enabled by default; in Deployment Plan (PaaS) environments, this parameter is disabled by default and needs to be manually enabled after configuring the application information.)

⑤ Add a new **Assertion Attribute**, Key = “Email”, Value = “user.email”

⑥ Click to save the configuration

![](../img/06_aliyun_09.png)

![](../img/06_aliyun_10.png)

3. Obtain the Single Sign-On URL

1) Access Guance via [**Single Sign-On**](https://auth.guance.com/login/sso) and enter the email address to get the login link. As shown in the following figure:

![](../img/06_aliyun_11.png)

![](../img/06_aliyun_12.png)

2) Click the **Login URL** provided on the SSO login configuration details page to visit. As shown in the following figure:

![](../img/06_aliyun_13.png)

4. Click the link to redirect to the IDaaS login page, input the username and password, and log in to Guance after verification. After logging in, as shown in the following figures:

1) Input the username and password on the IDaaS platform to log in.

![](../img/06_aliyun_14.png)

2) After successful login, the Guance page is displayed.

**Note**: If multiple workspaces are configured with the same identity provider SSO single sign-on, users can switch between different workspaces to view data by clicking the workspace option in the top-left corner of Guance after logging in via SSO.

![](../img/06_aliyun_15.png)