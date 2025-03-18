# Alibaba Cloud IDaaS Single Sign-On Example
---

## Use Case

Alibaba Cloud IDaaS (Yundun) is an identity recognition and access management solution provider. <<< custom_key.brand_name >>> supports SAML 2.0 (Security Assertion Markup Language 2.0) federated identity authentication, which is an open standard used by many identity providers (Identity Provider, IdP). You can integrate Yundun with <<< custom_key.brand_name >>> through SAML 2.0 federated identity authentication to achieve automatic login (single sign-on) into the <<< custom_key.brand_name >>> platform for accessing corresponding workspace resources without creating separate <<< custom_key.brand_name >>> accounts for enterprises/teams.

## Steps {#step1}

1. Create an Application in Alibaba Cloud IDaaS

**Note**: Before creating the application, you need to register an account and create your organization on the [IDaaS Platform (Yundun)](https://yundun.console.aliyun.com/).

1) Open the IDaaS console, go to **Add Application > Standard Protocol**, and select to create a SAML 2.0 SSO application. (This example uses the <<< custom_key.brand_name >>> application.)

![](../img/06_aliyun_01.png)

![](../img/06_aliyun_02.png)

2) After creating the application, click **Manage** to enter the application configuration interface. Before configuring single sign-on, you can configure application accounts and authorization first.

① Add application accounts

![](../img/06_aliyun_03.png)

![](../img/06_aliyun_04.png)

② In this example, default authorization allows all members to access. If special authorization is required, click **Authorization** to change the permission settings.

![](../img/06_aliyun_05.png)

3) After configuring the application accounts and authorization, click to enter the **Single Sign-On** page, locate the **Application Configuration Information** section, and click **Download** to obtain the IdP metadata file.

![](../img/06_aliyun_06.png)

2. Enable SSO Single Sign-On in <<< custom_key.brand_name >>> and Update Configuration on IDaaS Platform

1) Enable SSO single sign-on in the <<< custom_key.brand_name >>> workspace under **Management > Member Management > SSO Management** by clicking **Enable**.

> Refer to [Create SSO](../../management/sso/index.md).

**Note**: For account security reasons, <<< custom_key.brand_name >>> supports only one SSO configuration per workspace. If you have previously configured SAML 2.0, we will consider the last updated SAML 2.0 configuration as the final single sign-on verification entry.

![](../img/1.sso_enable.png)

2) Upload the **metadata document** downloaded from [Step 1](#step1), configure the **domain (email suffix domain)**, and select the **role** to obtain the identity provider's **entity ID** and **assertion URL**. Download the service provider's Metadata data (you can right-click to save after visiting the link information via browser).

**Note**: The domain is used for email domain mapping between <<< custom_key.brand_name >>> and the identity provider to achieve single sign-on. The email suffix domain must match the domain added in <<< custom_key.brand_name >>>.

![](../img/1.sso_enable_2.png)

3. Update the Single Sign-On Configuration on the IDaaS Side

① Import the SP Metadata file obtained in Step 2.

② Click **Parse** to automatically import the ACS URL and Entity ID parameters below.

③ Change the **application account** configuration to **IDaaS account / email**.

④ Expand [Advanced Configuration]. (In SaaS environments, assertion signing is enabled by default; in Deployment Plan (PaaS) environments, this parameter is disabled by default and needs to be manually enabled after configuring the application information.)

⑤ Add a new **Assertion Attribute**, Key = “Email”, Value = “user.email”.

⑥ Click to save the configuration.

![](../img/06_aliyun_09.png)

![](../img/06_aliyun_10.png)

4. Obtain the Single Sign-On URL

1) Visit <<< custom_key.brand_name >>> through [**Single Sign-On**](https://<<< custom_key.studio_main_site_auth >>>/login/sso), input the email address to get the login link. As shown in the following image:

![](../img/06_aliyun_11.png)

![](../img/06_aliyun_12.png)

2) Access the **login URL** provided on the SSO login configuration details page. As shown in the following image:

![](../img/06_aliyun_13.png)

5. Click the link to redirect to the IDaaS platform, input the username and password, and log in to <<< custom_key.brand_name >>> after successful verification. After logging in, as shown in the following images:

1) Input username and password on the IDaaS platform.

![](../img/06_aliyun_14.png)

2) After successful login, the <<< custom_key.brand_name >>> page will display.

**Note**: If multiple workspaces are configured with the same identity provider SSO single sign-on, users can switch between different workspaces by clicking the workspace options in the top-left corner of <<< custom_key.brand_name >>> after logging in via SSO.

![](../img/06_aliyun_15.png)