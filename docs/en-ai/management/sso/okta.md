# Okta Single Sign-On Example
---

Okta is a provider of identity and access management solutions.

## Steps

### 1. Create an Okta Application

**Note**: Before creating the application, you need to register an account and create your organization on the [Okta website](https://www.okta.com/).

1) Open the Okta website and log in. Click on the user icon in the top right corner and select **Your Org** from the dropdown menu.

![](../img/04_okta_01.png)

2) On the Okta organization page, click **Application** in the right-hand menu. On the opened page, click **Create App Integration**.

![](../img/04_okta_02.png)

3) Select **SAML 2.0** to create a new application.

![](../img/04_okta_03.png)


### 2. Configure SAML for the Okta Application {#step2}

**Note**: This step maps the Okta application attributes to Guance's attributes, establishing a trust relationship between Okta and Guance.

1) In the **General Settings** of the newly created application, enter the application name, such as "okta", and then click **Next**.

![](../img/04_okta_04.png)

2) In the **Configure SAML** section under **SAML Settings**, fill in the Assertion URL and Entity ID.

- Single sign-on URL: Assertion URL, example: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/)
- Audience URI (SP Entity ID): Entity ID, example: [https://auth.guance.com/saml/metadata.xml](https://auth.guance.com/saml/metadata.xml)

**Note**: This configuration is only for obtaining the metadata document in the next step. After enabling SSO single sign-on in Guance, replace these with the correct **Entity ID** and **Assertion URL** obtained from Guance.

![](../img/04_okta_05.png)

3) In the **Attribute Statements (optional)** section under **Configure SAML**, fill in the Name and Value.

- Name: The field defined by Guance, should be set to **Email** to associate the identity provider's user email (i.e., the identity provider maps the login user's email to Email).
- Value: Fill in according to the actual email format provided by the identity provider; here Okta can use **user.email**.

**Note**: This section is mandatory. If not filled, SSO single sign-on will fail with a login error.

![](../img/04_okta_06.png)

4) In the **Feedback** section, select the options below and click **Finish** to complete the SAML configuration.

![](../img/04_okta_07.png)

### 3. Obtain Okta Metadata Document {#step3}

**Note**: This step retrieves the metadata document required to create an identity provider in Guance.

1) Under **Sign On**, click **Identity Provider metadata** to view the identity provider metadata.

![](../img/04_okta_08.png)

2) Right-click to save the metadata document locally.

**Note**: The metadata document is an XML file, such as “metadata.xml”.

![](../img/04_okta_09.png)


### 4. Enable SSO Single Sign-On in Guance

1) Enable SSO single sign-on in Guance under **Workspace Management > Member Management > SSO Management**, and click **Enable**.

> Refer to the documentation [Create SSO](../../management/sso/index.md).

**Note**: For security reasons, Guance supports configuring only one SSO per workspace. If you have previously configured SAML 2.0, the last updated SAML 2.0 configuration will be considered the final single sign-on authentication entry.

![](../img/1.sso_enable.png)

2) Upload the **metadata document** downloaded in [Step 3](#step3), configure the **domain (email suffix domain)**, and select the **role**. You can then obtain the **Entity ID** and **Assertion URL** for this identity provider, and directly copy the **login URL** to log in.

**Note**: The domain is used by Guance and the identity provider to map email domains for single sign-on. Ensure that the email suffix domain matches the domain added in Guance.

![](../img/1.sso_enable_2.png)

### 5. Replace SAML Assertion URL in Okta

1) Return to Okta and update the **Entity ID** and **Assertion URL** from [Step 2](#step2).

**Note**: The Assertion URL configured in the identity provider SAML must match the one in Guance to enable single sign-on.

### 6. Configure Okta Users

**Note**: This step configures authorized user email accounts in Guance via the configured Okta users. Configured Okta user email accounts can log in to the Guance platform using SSO.

1) Under **Assignments > Assign**, select **Assign to People**.

![](../img/04_okta_10.png)

2) Select the users who need to log in to Guance via SSO, such as "jd@qq.com", and click **Assign**.

![](../img/04_okta_11.png)

3) Click **Save and Go Back** to complete the user configuration.

![](../img/04_okta_12.png)

4) Return to **Assignments** to view the configured Okta users.

![](../img/04_okta_13.png)


### 7. Log in to Guance Using Okta Account

1) After completing SSO configuration, log in through the [Guance website](https://www.dataflux.cn/) or the [Guance Console](https://auth.dataflux.cn/loginpsw). On the login page, select **Single Sign-On**.

![](../img/04_okta_16.png)

2) Enter the email address used to create the SSO and click **Get Login URL**.

![](../img/04_okta_17.png)

3) Click the **Link** to open the enterprise account login page.

![](../img/04_okta_18.png)

4) Enter the enterprise common email and password.

![](../img/04_okta_19.png)

5) Log in to the corresponding workspace in Guance.

**Note**: If multiple workspaces are configured with the same identity provider SSO single sign-on, users can switch between different workspaces after logging in via SSO by clicking the workspace option in the top left corner of Guance.

![](../img/04_okta_20.png)