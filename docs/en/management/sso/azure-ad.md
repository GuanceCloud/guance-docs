# Azure Active Directory
---

Azure Active Directory (AAD) is a cloud-based identity and access management service launched by Microsoft, which can help enterprises manage internal and external resources.


## Setup

### 1. Create an Application

Log in to the [Azure Active Directory administration center](https://aad.portal.azure.com/) and click **Enterprise applications > All applications > New application**.

![](../img/02_azure_01.png)

On the creating page, click **Create your own application**, enter the name, select Non-gallery application and click Create.

![](../img/02_azure_02.png)

### 2. Configure SAML {#step2}

**Note**: This step will map AAD application attributes to Guance attributes, establishing a trust relationship between AAD and Guance.

:material-numeric-1-circle-outline: Click into the newly created application page, select **Single Sign-On**, select **SAML**.

![](../img/02_azure_03.png)

:material-numeric-2-circle-outline: In the first step > the **Basic SAML Configuration** section, click **Edit**.

![](../img/02_azure_04.png)

Fill in the following Reply URL and entity ID examples.

- Identifier (Entity ID): [https://auth.guance.com/saml/metadata.xml](https://auth.guance.com/saml/metadata.xml)
- Reply URL (Assertion Consumer Service URL), temporarily use: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/)

**Note**: This configuration is only for obtaining the metadata document in the next step. After enabling SSO single sign-on in Guance, you need to replace it again after getting the correct Entity ID and Reply URL.


![](../img/02_azure_05.png)

:material-numeric-3-circle-outline: In the second step  > the **Attributes&Claims** section, add a claim associated with the identity provider user email, click **Edit**.

![](../img/02_azure_06.png)


On the edit page, click **Add new claim**.

![](../img/02_azure_07.png)

Enter the **Name** and **Source attribute**, and click save:

- Name: required, this part of the content is mandatory, if not filled, SSO will prompt that you cannot log in;
- Source Attribute: Choose "user.mail" according to the actual email of the identity provider.

**Note**: Guance has defined a field that must be filled with **Email** to associate the user's email from the identity provider (i.e., the identity provider maps the login user's email to Email).

![](../img/02_azure_08.png)


### 3. Obtain AAD Metadata Document {#step3}

**Note**: This step can get the metadata document for creating an identity provider in Guance.

In the third step > **SAML Certificates**, click to download **Federation Metadata XML**.

![](../img/02_azure_09.png)

### 4. Enable SSO in Guance {#step4}

:material-numeric-1-circle-outline: In the Guance workspace **Management > Members > SSO Management**, create a new SSO.

![](../img/1.sso_enable.png)

:material-numeric-2-circle-outline: Upload the metadata document downloaded in [Step 3](#step3), configure the domain (suffix of the email), select the role, and you can get the **Entity ID** and **Reply URL** of this Identity Provider. You can directly copy the **Login Address** for login.

**Note**: The domain is used for SSO by mapping the email domain between Guance and the Identity Provider, i.e., the suffix of the user's email must be consistent with the domain added in Guance.

![](../img/1.sso_enable_2.png)


### 5. Replace SAML Reply URL in AAD

Return to AAD, update the Entity ID and Reply URL in [Step 2](#step2).

**Note**: When configuring SSO in Guance, the Reply URL configured in the identity provider's SAML must be consistent with that in Guance to implement SSO.


![](../img/02_azure_17.png)

### 6. Configure AAD Users

???- warning "Warning"

    - This step configures the authorized user email account of the identity provider created in Guance. Through the configured AAD user email account, you can single sign-on to the Guance platform.

    - If there are no users, you need create new users.

    ![](../img/02_azure_14.png)

:material-numeric-1-circle-outline: In the newly created application, click **Users and groups**, click **Add user/group**.

![](../img/02_azure_10.png)

:material-numeric-2-circle-outline: Click **None Selected**, search and select users in the pop-up page, click **Select**.

![](../img/02_azure_11.png)

:material-numeric-3-circle-outline: After selecting the user, return to **Add Assignment**, click **Assign**.

![](../img/02_azure_12.png)

:material-numeric-4-circle-outline: After adding the user, you can view the list of SSO authorized login users assigned in **Users and groups**.

![](../img/02_azure_13.png)

### 7. Single Sign-On to Guance {#step7}

:material-numeric-1-circle-outline: After the SSO configuration is completed, log in through the [Guance official website](https://www.guance.one/) or [the Console](https://auth.guance.com/en/login/pwd), and select **SSO** on the login page.

<img src="../../img/02_azure_18.png" width="60%" >

:material-numeric-2-circle-outline: Enter the email address, click **Get login address**.

<img src="../../img/02_azure_19.png" width="60%" >

Choose your target workspace, hover on the corresponding workspace name and click **Login**. 

![](../img/azure_workspace.png)

:material-numeric-3-circle-outline: Enter the corporate common email (the corporate email address configured in AAD and Guance SSO Management) and password.
