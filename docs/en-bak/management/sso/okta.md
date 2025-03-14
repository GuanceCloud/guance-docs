# Okta
---

Okta is a provider of identity recognition and access management solutions.

## Setup

### 1、Create an Okta Application

**Note**: Before creating an application, you need to register an account on the [Okta website](https://www.okta.com/) and create your organization.

1）Open the Okta website and log in, click on the user in the top right corner, and select **Your Org** from the dropdown list.

![](../img/04_okta_01.png)

2）On the Okta organization page, click **Application** in the right menu, then click **Create App Integration** on the page that opens.

![](../img/04_okta_02.png)

3）Select **SAML 2.0** and create a new application.

![](../img/04_okta_03.png)

### 2、Configure SAML for Okta Application {#step2}

**Note**: This step maps the Okta application attributes to the attributes of the Guance Cloud, establishing a trust relationship between Okta and Guance Cloud.

1）In the **General Settings** of the newly created application, enter the application name, such as “okta”, then click **Next**.

![](../img/04_okta_04.png)

2）In the **SAML Settings** section of **Configure SAML**, fill in the Assertion Address and Entity ID.

- Single sign on URL: Assertion address, e.g., https://auth.guance.com/saml/assertion;
- Audience URI (SP Entity ID): Entity ID, e.g., https://auth.guance.com/saml/metadata.xml.

**Note**: This configuration is only for obtaining the metadata document in the next step. You need to replace it with the correct **Entity ID** and **Assertion Address** after enabling SSO single sign-on in Guance Cloud.

![](../img/04_okta_05.png)

3）In the **Attribute Statements (optional)** section of **Configure SAML**, fill in Name and Value.

- Name: The field defined by Guance Cloud, fill in **Email** to associate the user's email with the identity provider (i.e., the identity provider maps the user's email to Email);
- Value: Fill in according to the actual email format of the identity provider. Here, Okta can fill in **user.email**.

**Note**: This section is mandatory. If not filled in, you will be prompted that you cannot log in when using SSO single sign-on.

![](../img/04_okta_06.png)

4）In **Feedback**, select the following options, click **Finish** to complete the SAML configuration.

![](../img/04_okta_07.png)

### 3、Obtain Okta Metadata Document {#step3}

**Note**: This step can obtain the metadata document of the identity provider created in Guance Cloud.

1）In **Sign On**, click **Identity Provider metadata** to view the identity provider metadata.

![](../img/04_okta_08.png)

2）Right-click on the view page and save it locally.

**Note**: The metadata document is an xml file, such as "metadata.xml".

![](../img/04_okta_09.png)

### 4、Enable SSO Single Sign-On in Guance Cloud

1）Enable SSO single sign-on, go to Guance Cloud workspace **Management > Member Management > SSO Management**, click **Enable**.

> Refer to the document Create SSO.
> 

**Note**: For account security considerations, Guance Cloud supports configuring only one SSO for a workspace. If you have previously configured SAML 2.0, we will by default consider your last updated SAML 2.0 configuration as the final single sign-on verification entrance.

![](../img/1.sso_enable.png)

2）Upload the **metadata document** downloaded in [Step 3](https://www.notion.so/cafafe07ff0a4249ae0eacab241cb504?pvs=21), configure the **domain (the suffix domain of the email)**, select the **role**, and you can obtain the **Entity ID** and **Assertion Address** of this identity provider. Supports directly copying the **login address** to log in.

**Note**: The domain name is used for email domain mapping between Guance Cloud and the identity provider to achieve single sign-on, that is, the suffix domain of the user's email must be consistent with the domain name added in Guance Cloud.

![](../img/1.sso_enable_2.png)

### 5、Replace SAML Assertion Address in Okta

1）Return to Okta and update the **Entity ID** and **Assertion Address** in [Step 2](https://www.notion.so/cafafe07ff0a4249ae0eacab241cb504?pvs=21).

**Note**: When configuring single sign-on in Guance Cloud, the Assertion Address configured in the identity provider's SAML must be consistent with that in Guance Cloud in order to achieve single sign-on.

### 6. Configure Okta Users

**Note**: This step configures the authorized user email accounts of the identity provider created in Guance Cloud. You can log in to the Guance Cloud platform with the configured Okta user email account.

1）In **Assignments > Assign**, select **Assign to People**.

![](../img/04_okta_10.png)

2）Select the user who needs to single sign-on to Guance Cloud, such as “jd@qq.com”, and click **Assign**.

![../img/04_okta_11.png](../img/04_okta_11.png)

3）Click **Save and Go Back** to complete user configuration.

![../img/04_okta_12.png](../img/04_okta_12.png)

4）Return to **Assignments**, you can view the configured Okta users.

![../img/04_okta_13.png](../img/04_okta_13.png)

### 7、Use Okta Account to Single Sign-On to Guance Cloud

1）After the SSO configuration is completed, log in through the [Guance Cloud official website](https://www.dataflux.cn/) or the [Guance Cloud console](https://auth.dataflux.cn/loginpsw), and select **Single Sign-On** on the login page.

![../img/04_okta_16.png](../img/04_okta_16.png)

2）Enter the email address used to create the SSO and click **Get Login Address**.

![../img/04_okta_17.png](../img/04_okta_17.png)

3）Click the **link** to open the corporate account login page.

![../img/04_okta_18.png](../img/04_okta_18.png)

4）Enter the corporate common email and password.

![../img/04_okta_19.png](../img/04_okta_19.png)

5）Log in to the corresponding workspace of Guance Cloud.

**Note**: If multiple workspaces are configured with the same identity provider's SSO single sign-on at the same time, the user can click on the workspace option in the upper left corner of Guance Cloud to switch different workspaces to view data after single sign-on to the workspace through SSO.

![../img/04_okta_20.png](../img/04_okta_20.png)