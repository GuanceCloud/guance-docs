# Okta Single Sign-On Example
---

Okta is a provider of identity and access management solutions.

## Procedure

### 1. Create an Okta Application

**Note**: Before creating the application, you need to register an account and create your organization on the [Okta website](https://www.okta.com/).

1) Open the Okta website and log in. Click on the user icon in the top-right corner and select **Your Org** from the dropdown menu.

![](../img/04_okta_01.png)

2) On the Okta organization page, click **Application** in the right-hand menu. On the opened page, click **Create App Integration**.

![](../img/04_okta_02.png)

3) Select **SAML 2.0** to create a new application.

![](../img/04_okta_03.png)


### 2. Configure SAML for the Okta Application {#step2}

**Note**: This step maps the attributes of the Okta application to <<< custom_key.brand_name >>> properties, establishing a trust relationship between Okta and <<< custom_key.brand_name >>> so they can trust each other.

1) In the **General Settings** of the newly created application, enter the application name, such as "okta", and then click **Next**.

![](../img/04_okta_04.png)

2) In the **Configure SAML** section under **SAML Settings**, enter the assertion URL and Entity ID.

- Single sign-on URL: Assertion URL, example: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/);
- Audience URI (SP Entity ID): Entity ID, example: [https://auth.guance.com/saml/metadata.xml](https://auth.guance.com/saml/metadata.xml).

**Note**: This configuration is only for obtaining the metadata document in the next step. After enabling SSO single sign-on in <<< custom_key.brand_name >>>, you will need to replace these with the correct **Entity ID** and **Assertion URL**.

![](../img/04_okta_05.png)

3) In the **Attribute Statements (optional)** section of **Configure SAML**, enter the Name and Value.

- Name: The field defined by <<< custom_key.brand_name >>>, enter **Email** to associate the user's email from the identity provider (i.e., the identity provider maps the login user's email to Email);
- Value: Enter based on the actual email format provided by the identity provider. For Okta, enter **user.email**.

**Note**: This part is mandatory. If not filled out, SSO single sign-on will fail with a login error.

![](../img/04_okta_06.png)

4) In the **Feedback** section, select the following options and click **Finish** to complete the SAML configuration.

![](../img/04_okta_07.png)

### 3. Obtain the Okta Metadata Document {#step3}

**Note**: This step retrieves the metadata document required to create an identity provider in <<< custom_key.brand_name >>>.

1) Under **Sign On**, click **Identity Provider metadata** to view the identity provider metadata.

![](../img/04_okta_08.png)

2) Right-click on the view page to save it locally.

**Note**: The metadata document is an XML file, such as “metadata.xml”.

![](../img/04_okta_09.png)


### 4. Enable SSO Single Sign-On in <<< custom_key.brand_name >>>

1) Enable SSO single sign-on in <<< custom_key.brand_name >>> workspace **Management > Member Management > SSO Management**, and click **Enable**.

> Refer to the documentation [Create SSO](../../management/sso/index.md).

**Note**: For account security, <<< custom_key.brand_name >>> supports configuring only one SSO per workspace. If you have previously configured SAML 2.0, the last updated SAML 2.0 configuration will be considered the final single sign-on authentication entry.

![](../img/1.sso_enable.png)

2) Upload the **metadata document** downloaded in [Step 3](#step3), configure the **domain (email suffix domain)**, and select the **role** to obtain the **Entity ID** and **Assertion URL** of the identity provider. You can also directly copy the **login URL** to log in.

**Note**: The domain is used to map the email domain between <<< custom_key.brand_name >>> and the identity provider to achieve single sign-on. The email suffix domain must match the domain added in <<< custom_key.brand_name >>>.

![](../img/1.sso_enable_2.png)

### 5. Replace the SAML Assertion URL in Okta

1) Return to Okta and update the **Entity ID** and **Assertion URL** from [Step 2](#step2).

**Note**: When configuring single sign-on in <<< custom_key.brand_name >>>, the assertion URL configured in the identity provider's SAML must match the one in <<< custom_key.brand_name >>> to enable single sign-on.

### 6. Configure Okta Users

**Note**: This step configures authorized user email accounts for the identity provider created in <<< custom_key.brand_name >>>. Configured Okta user email accounts can log into the <<< custom_key.brand_name >>> platform via single sign-on.

1) Under **Assignments > Assign**, select **Assign to People**.

![](../img/04_okta_10.png)

2) Select users who need to log into <<< custom_key.brand_name >>> via single sign-on, such as “jd@qq.com”, and click **Assign**.

![](../img/04_okta_11.png)

3) Click **Save and Go Back** to complete the user configuration.

![](../img/04_okta_12.png)

4) Return to **Assignments** to view the configured Okta users.

![](../img/04_okta_13.png)


### 7. Log in to <<< custom_key.brand_name >>> Using Okta Credentials

1) After SSO configuration is complete, log in via [<<< custom_key.brand_name >>> official website](https://www.dataflux.cn/) or [<<< custom_key.brand_name >>> console](https://auth.dataflux.cn/loginpsw). On the login page, select **Single Sign-On**.

![](../img/04_okta_16.png)

2) Enter the email address used to create the SSO and click **Get Login URL**.

![](../img/04_okta_17.png)

3) Click the **Link** to open the enterprise account login page.

![](../img/04_okta_18.png)

4) Enter the enterprise common email and password.

![](../img/04_okta_19.png)

5) Log in to the corresponding workspace in <<< custom_key.brand_name >>>.

**Note**: If multiple workspaces are configured with the same identity provider SSO single sign-on, after logging in via SSO, users can switch between different workspaces by clicking the workspace option in the top-left corner of <<< custom_key.brand_name >>> to view data.

![](../img/04_okta_20.png)