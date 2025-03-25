# Okta Single Sign-On Example
---

Okta is a provider of identity and access management solutions.

## Steps

### 1. Create an Okta Application

**Note**: Before creating the application, you need to register an account on the [Okta website](https://www.okta.com/) and create your organization.

1) Open the Okta website and log in. Click on the user in the top-right corner, then select **Your Org** from the dropdown menu.

![](../img/04_okta_01.png)

2) On the Okta organization page, click **Application** in the right-hand menu. In the opened page, click **Create App Integration**.

![](../img/04_okta_02.png)

3) Select **SAML 2.0** to create a new application.

![](../img/04_okta_03.png)


### 2. Configure SAML for the Okta Application {#step2}

**Note**: This step maps the attributes of the Okta application to the <<< custom_key.brand_name >>> attributes, establishing a trust relationship between Okta and <<< custom_key.brand_name >>> so they can trust each other.

1) In the **General Settings** of the newly created application, input the application name, such as "okta", and then click **Next**.

![](../img/04_okta_04.png)

2) In the **SAML Settings** section of **Configure SAML**, enter the assertion address and Entity ID.

- Single sign-on URL: Assertion address, example: [https://<<< custom_key.studio_main_site_auth >>>/saml/assertion](https://<<< custom_key.studio_main_site_auth >>>/saml/assertion/);  
- Audience URI (SP Entity ID): Entity ID, example: [https://<<< custom_key.studio_main_site_auth >>>/saml/metadata.xml](https://<<< custom_key.studio_main_site_auth >>>/saml/metadata.xml).

**Note**: This configuration is only used to obtain the metadata document for the next step. After enabling SSO single sign-on in <<< custom_key.brand_name >>>, replace with the correct **Entity ID** and **Assertion Address**.

![](../img/04_okta_05.png)

3) In the **Attribute Statements (optional)** section of **Configure SAML**, fill in the Name and Value.

- Name: The field defined by <<< custom_key.brand_name >>>, must be filled with **Email**, which associates the email of the identity provider's user (i.e., the identity provider maps the login user's email to Email);
- Value: Fill according to the actual email format of the identity provider. Here, Okta can use **user.email**.

**Note**: This content is mandatory. If it is not filled, SSO single sign-on will prompt that login is not possible.

![](../img/04_okta_06.png)

4) In **Feedback**, select the following options and click **Finish** to complete the SAML configuration.

![](../img/04_okta_07.png)

### 3. Obtain the Okta Metadata Document {#step3}

**Note**: This step retrieves the metadata document for creating an identity provider in <<< custom_key.brand_name >>>.

1) Under **Sign On**, click **Identity Provider metadata** to view the identity provider metadata.

![](../img/04_okta_08.png)

2) Right-click on the viewing page and save it locally.

**Note**: The metadata document is an XML file, such as “metadata.xml”.

![](../img/04_okta_09.png)


### 4. Enable SSO Single Sign-On in <<< custom_key.brand_name >>>

1) To enable SSO single sign-on, go to <<< custom_key.brand_name >>> workspace **Management > Member Management > SSO Management**, and click **Enable**.

> Refer to the documentation [Create SSO](../../management/sso/index.md).

**Note**: For account security reasons, <<< custom_key.brand_name >>> supports configuring only one SSO per workspace. If you have already configured SAML 2.0 previously, we will consider the last updated SAML2.0 configuration as the final single sign-on authentication entry.

![](../img/1.sso_enable.png)

2) Upload the **Metadata Document** downloaded in [Step 3](#step3), configure the **domain (email suffix domain)**, select the **role**, and obtain the **Entity ID** and **Assertion Address** of the identity provider. You can directly copy the **Login Address** to log in.

**Note**: The domain is used for email domain mapping between <<< custom_key.brand_name >>> and the identity provider to achieve single sign-on. That is, the suffix domain of the user's email must match the domain added in <<< custom_key.brand_name >>>.

![](../img/1.sso_enable_2.png)

### 5. Replace the SAML Assertion Address in Okta

1) Return to Okta and update the **Entity ID** and **Assertion Address** in [Step 2](#step2).

**Note**: When configuring single sign-on in <<< custom_key.brand_name >>>, the assertion address configured in the SAML of the identity provider must be consistent with that in <<< custom_key.brand_name >>> to achieve single sign-on.

### 6. Configure Okta Users

**Note**: This step configures authorized user email accounts for the identity provider created in <<< custom_key.brand_name >>>. Configured Okta user email accounts can log in to the <<< custom_key.brand_name >>> platform via single sign-on.

1) Under **Assignments > Assign**, select **Assign to People**.

![](../img/04_okta_10.png)

2) Select users who need to log in to <<< custom_key.brand_name >>> via single sign-on, such as "jd@qq.com", and click **Assign**.

![](../img/04_okta_11.png)

3) Click **Save and Go Back** to complete the user configuration.

![](../img/04_okta_12.png)

4) Return to **Assignments** to view the configured authorized Okta users.

![](../img/04_okta_13.png)


### 7. Log in to <<< custom_key.brand_name >>> using an Okta Account

1) After completing SSO configuration, log in through the [<<< custom_key.brand_name >>> official website](https://www.dataflux.cn/) or the [<<< custom_key.brand_name >>> console](https://auth.dataflux.cn/loginpsw). On the login page, select **Single Sign-On**.

![](../img/04_okta_16.png)

2) Enter the email address used to create the SSO and click **Get Login Address**.

![](../img/04_okta_17.png)

3) Click **Link** to open the enterprise account login page.

![](../img/04_okta_18.png)

4) Enter the enterprise general email and password.

![](../img/04_okta_19.png)

5) Log in to the corresponding workspace in <<< custom_key.brand_name >>>.

**Note**: If multiple workspaces are configured with the same identity provider SSO single sign-on, after logging into the workspace via SSO, you can click the workspace option in the top-left corner of <<< custom_key.brand_name >>> to switch between different workspaces to view data.

![](../img/04_okta_20.png)