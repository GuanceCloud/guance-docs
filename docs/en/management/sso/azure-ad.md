# AAD Single Sign-On Example
---

Azure Active Directory (AAD) is a cloud-based identity and access management service introduced by Microsoft that helps businesses manage internal and external resources.


## Steps

### 1. Create an Application

1) Log in to the [Azure Active Directory Admin Center](https://aad.portal.azure.com/), click **Enterprise Applications > All Applications > New Application**.

![](../img/02_azure_01.png)

2) On the **New Application** page, click **Create your own application**, enter the **application name** on the opened page, select **Non-gallery application**, and click **Create** to create a new application.

![](../img/02_azure_02.png)

### 2. Configure SAML for the Application {#step2}

**Note**: This step maps the AAD application attributes to <<< custom_key.brand_name >>> attributes, establishing a trust relationship between AAD and <<< custom_key.brand_name >>>.

1) In the newly created application, click **Single Sign-On**, and select **SAML**.

![](../img/02_azure_03.png)

2) In the first part of **Set up SAML single sign-on**, under **Basic SAML Configuration**, click **Edit**.

![](../img/02_azure_04.png)

Enter the following assertion address and entity ID examples.

- Identifier (Entity ID): [https://<<< custom_key.studio_main_site_auth >>>/saml/metadata.xml](https://<<< custom_key.studio_main_site_auth >>>/saml/metadata.xml)
- Reply URL (Assertion URL), temporary: [https://<<< custom_key.studio_main_site_auth >>>/saml/assertion](https://<<< custom_key.studio_main_site_auth >>>/saml/assertion/)

**Note**: This configuration is only used to obtain the metadata document for the next step. After enabling SSO single sign-on in <<< custom_key.brand_name >>>, replace with the correct **Entity ID** and **Assertion URL**.

![](../img/02_azure_05.png)

3) In the second step **Attributes and Claims**, add a claim associated with the identity provider's user email, click **Edit**.

![](../img/02_azure_06.png)

On the attributes and claims editing page, click **Add a new claim**.

![](../img/02_azure_07.png)

On the claim management page, input the **Name** and **Source Attribute**, then save:

- Name: Must be entered as **Email**, this content is mandatory. If not filled in, it will prompt that login is not possible during single sign-on;
- Source Attribute: Select "user.mail" according to the actual email provided by the identity provider.

**Note**: <<< custom_key.brand_name >>> defines a field that must be filled in as **Email** to associate the identity provider's user email (i.e., the identity provider maps the logged-in user's email to Email).

![](../img/02_azure_08.png)

### 3. Obtain AAD Metadata Document {#step3}

**Note**: This step retrieves the metadata document for creating an identity provider in <<< custom_key.brand_name >>>.

1) In the third step **SAML Signing Certificate**, click to download the **Federation Metadata XML**.

![](../img/02_azure_09.png)


### 4. Enable Single Sign-On in <<< custom_key.brand_name >>> {#step4}

1) In the <<< custom_key.brand_name >>> workspace **Management > Member Management > SSO Management**, [create a new SSO](../../management/sso/index.md).


![](../img/1.sso_enable.png)

2) Upload the metadata document downloaded in [Step 3](#step3), configure the **domain (email suffix domain)**, select the **role**, and you can obtain the **Entity ID** and **Assertion URL** of the identity provider, supporting direct copying of the **login URL** for login.

**Note**: The domain is used for email domain mapping between <<< custom_key.brand_name >>> and the identity provider to achieve single sign-on. That is, the suffix domain of the user's email must match the domain added in <<< custom_key.brand_name >>>.

![](../img/1.sso_enable_2.png)


### 5. Replace SAML Assertion Address in AAD

1) Return to AAD and update the **Entity ID** and **Assertion URL** from [Step 2](#step2).

**Note**: When configuring single sign-on in <<< custom_key.brand_name >>>, the assertion URL configured in the identity provider's SAML must be consistent with that in <<< custom_key.brand_name >>> to enable single sign-on.

![](../img/02_azure_17.png)


### 6. Configure AAD Users

**Note**: This step configures authorized user email accounts for the identity provider created in <<< custom_key.brand_name >>>. Configured AAD user email accounts can perform single sign-on to the <<< custom_key.brand_name >>> platform.

1) In the newly created application, click **Users and Groups**, then click **Add User/Group**.

![](../img/02_azure_10.png)

2) Click **No items selected**, search and select users in the pop-up page, then click **Select**.

![](../img/02_azure_11.png)

3) After selecting the users, return to **Add Assignment** and click **Add Assignment**.

![](../img/02_azure_12.png)

4) After adding the users, you can view the list of SSO authorized login users in **Users and Groups**.

![](../img/02_azure_13.png)

**Note**: If there are no users, you can create new users under the **Users** menu.

![](../img/02_azure_14.png)


### 7. Use AAD Account to Single Sign-On to <<< custom_key.brand_name >>> {#step7}

1) After SSO configuration is complete, log in through the [<<< custom_key.brand_name >>> official website](https://www.dataflux.cn/) or the [<<< custom_key.brand_name >>> console](https://auth.dataflux.cn/loginpsw). On the login page, select **Single Sign-On**.

![](../img/02_azure_18.png)

2) Enter the email address created when setting up SSO and click **Get Login URL**.

![](../img/02_azure_19.png)

3) Click **Link** to open the enterprise account login page.

![](../img/02_azure_20.png)

4) Enter the enterprise common email (configured in AAD and <<< custom_key.brand_name >>> SSO management) and password.

![](../img/02_azure_21.png)

5) Log in to the corresponding workspace in <<< custom_key.brand_name >>>.