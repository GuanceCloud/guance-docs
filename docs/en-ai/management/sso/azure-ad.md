# AAD Single Sign-On Example
---

Azure Active Directory (AAD) is a cloud-based identity and access management service launched by Microsoft, which helps enterprises manage internal and external resources.


## Steps

### 1. Create an Application

1) Log in to the [Azure Active Directory Admin Center](https://aad.portal.azure.com/), click **Enterprise Applications > All Applications > New Application**.

![](../img/02_azure_01.png)

2) On the **New Application** page, click **Create your own application**, enter the **application name** on the opened page, and select **Non-gallery application**. Click **Create** to create a new application.

![](../img/02_azure_02.png)

### 2. Configure SAML for the Application {#step2}

**Note**: This step maps AAD application attributes to Guance attributes, establishing a trust relationship between AAD and Guance.

1) In the newly created application, click **Single sign-on**, and select **SAML**.

![](../img/02_azure_03.png)

2) In the first part of **Set up SAML single sign-on** under **Basic SAML Configuration**, click **Edit**.

![](../img/02_azure_04.png)

Enter the following assertion URL and entity ID examples.

- Identifier (Entity ID): [https://auth.guance.com/saml/metadata.xml](https://auth.guance.com/saml/metadata.xml)
- Reply URL (Assertion URL), temporary use: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/)

**Note**: This configuration is only for obtaining the metadata document in the next step. After enabling SSO single sign-on in Guance, you need to re-replace with the correct **entity ID** and **assertion URL** obtained from Guance.

![](../img/02_azure_05.png)

3) In the second part **Attributes and Claims**, add a claim that associates the identity provider's user email, and click **Edit**.

![](../img/02_azure_06.png)

On the attribute and claims editing page, click **Add a new claim**.

![](../img/02_azure_07.png)

On the manage claims page, enter the **Name** and **Source Attribute**, and save:

- Name: Must be **Email**, this field is required; if not filled, it will prompt that login is not possible;
- Source Attribute: Select "user.mail" based on the actual email provided by the identity provider.

**Note**: Guance defines a field that must be filled as **Email** to associate the identity provider's user email (i.e., the identity provider maps the login user's email to Email).

![](../img/02_azure_08.png)

### 3. Obtain AAD Metadata Document {#step3}

**Note**: This step retrieves the metadata document required to create an identity provider in Guance.

1) In the third part **SAML Signing Certificate**, click to download the **Federation Metadata XML**.

![](../img/02_azure_09.png)


### 4. Enable Single Sign-On in Guance {#step4}

1) In the Guance workspace **Management > Member Management > SSO Management**, [create a new SSO](../../management/sso/index.md).

![](../img/1.sso_enable.png)

2) Upload the metadata document downloaded in [Step 3](#step3), configure the **domain name (email suffix domain)**, and select the **role**. You can then obtain the identity provider's **entity ID** and **assertion URL**, supporting direct copying of the **login URL** for login.

**Note**: The domain name is used for email domain mapping between Guance and the identity provider to achieve single sign-on, i.e., the suffix domain of the user's email must match the domain added in Guance.

![](../img/1.sso_enable_2.png)


### 5. Replace SAML Assertion URL in AAD

1) Return to AAD and update the **entity ID** and **assertion URL** configured in [Step 2](#step2).

**Note**: When configuring single sign-on in Guance, the assertion URL configured in the identity provider's SAML must match the one in Guance to achieve single sign-on.

![](../img/02_azure_17.png)


### 6. Configure AAD Users

**Note**: This step configures authorized user email accounts for the identity provider created in Guance. Configured AAD user email accounts can log into the Guance platform via single sign-on.

1) In the newly created application, click **Users and Groups**, and click **Add User/Group**.

![](../img/02_azure_10.png)

2) Click **No items selected**, search and select users in the pop-up page, and click **Select**.

![](../img/02_azure_11.png)

3) After selecting the user, return to **Add Assignment** and click **Add Assignment**.

![](../img/02_azure_12.png)

4) After adding users, you can view the list of SSO authorized login users in **Users and Groups**.

![](../img/02_azure_13.png)

**Note**: If there are no users, you can create new users under the **Users** menu.

![](../img/02_azure_14.png)


### 7. Use AAD Account to Single Sign-On to Guance {#step7}

1) After SSO configuration is complete, log in through the [Guance official website](https://www.dataflux.cn/) or [Guance Console](https://auth.dataflux.cn/loginpsw), and select **Single Sign-On** on the login page.

![](../img/02_azure_18.png)

2) Enter the email address used to create the SSO and click **Get Login URL**.

![](../img/02_azure_19.png)

3) Click **Link** to open the enterprise account login page.

![](../img/02_azure_20.png)

4) Enter the enterprise common email (the email address configured in AAD and Guance SSO management) and password.

![](../img/02_azure_21.png)

5) Log in to the corresponding workspace in Guance.