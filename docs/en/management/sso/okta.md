# Okta SSO
---

## Operation Scene

Okta is a provider of identification and access management solutions. Guance supports federated identity based on SAML 2.0 (Security Assertion Markup Language 2.0), an open standard used by many identity providers (IdP). You can integrate Okta with Guance through SAML 2.0-based federation identity, enabling Okta accounts to automatically log on (single sign on) to Guance platform to access corresponding workspace resources, without having to create a separate Guance account for the enterprise/team.

## Operational Steps

### 1.Create an Okta Application
Note: Before creating an application, you need to register your account and create your organization at [Okta website](https://www.okta.com/)<br />1）Open the Okta Web site and log in, click the user in the upper right corner, and select "Your Org" in the drop-down list.<br />![](../img/04_okta_01.png)<br />2）On the Okta organization page, click "Application" in the right menu, and click "Create App Integration" on the open page.<br />![](../img/04_okta_02.png)<br />3）Select "SAML 2.0" to create a new Application.<br />![](../img/04_okta_03.png)


### 2.Configure SAML for Okta Application
Note: This step maps the Okta application attributes to those of Guance, and establishes a trust relationship between Okta and Guance so that they trust each other. <br />1）In the "General Settings" of the newly created application, enter the application name, such as "okta", and then click "next". <br />![](../img/04_okta_04.png)<br />2）In the "SAML Settings" section of the "Configure SAML", fill in the assertion address and Entity ID.

- Single sign on URL: assertion address, for example: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/)
- Audience URI (SP Entity ID)：Entity ID, for example: [https://auth.guance.com/saml/metadata.xml](https://auth.guance.com/saml/metadata.xml)

**Note: This configuration is only used to obtain the metadata document for the next step. After SSO is enabled in Guance, the correct "Entity ID" and "Assertion Address" are obtained and replaced again.** Refer to doc [**new SSO**](../../management/sso/index.md)**.**<br />![](../img/04_okta_05.png)<br />3）In the "Attribute Statements (optional)" section of "Configure SAML", fill in Name and Value.

- Name: the field defined by Guance, which needs to be filled with "Email" for associating the user mailbox of the identity provider (that is, the identity provider maps the mailbox of the logged-in user to Email);
- Value: Fill in according to the actual email format of the identity provider, where Okta can fill in "user.email".

Note: This section is required. If you do not fill it, you will be prompted that you cannot log in when SSO. <br />![](../img/04_okta_06.png)<br />4）In "Feedback", select the following options and click "Finish" to complete the SAML configuration.<br />![](../img/04_okta_07.png)

### 3.Get the Okta Metadata Document
Note: This step obtains the metadata document for creating identity providers in Guance.<br />1）On "Sign On", click "Identity Provider metadata" to view Identity Provider metadata.<br />![](../img/04_okta_08.png)<br />2）Right-click on the view page to save to local.<br />Note: The metadata document is an xml file, such as "metadata.xml". <br />![](../img/04_okta_09.png)

### 4.Configure the Okta User
Note: In this step, the authorized user email account of the identity provider is configured to be created in Guance, and the configured Okta user email account can be used to log in to Guance platform.<br />1）In "Assignments"-"Assign", select "Assign to People".<br />![](../img/04_okta_10.png)<br />2）Select the user who needs a single sign-on to Guance, such as "jd@qq.com", and click "Assign".<br />![](../img/04_okta_11.png)<br />3）Click "Save and Go Back" to complete the user configuration.<br />![](../img/04_okta_12.png)<br />4）Return to "Assignments" to view the Okta users who are configured to authorize.<br />![](../img/04_okta_13.png)


### 5.Enable SSO in Guance and replace SAML Assertion Address in Okta

1） Enable SSO and click Enable in Guance workspace "Management"-"SSO Management". Refer to the doc [new SSO](../../management/sso/index.md).<br />**Note: For account security reasons, only one SSO is configured in Guance support workspace. If you have previously configured SAML 2.0, we will regard your last updated SAML 2.0 configuration as the final single sign-on authentication entry by default.**<br />![](../img/04_okta_14.png)<br />2）Upload the "metadata document" of the identity provider, configure the "mailbox domain name", and select "access role" to obtain the "entity ID" and "assertion address" of the identity provider, and support directly copying the "login address" for login. <br />**Note: When SSO login is enabled, "mailbox domain name" needs to be added for mailbox domain name mapping between Guance and identity provider (user mailbox domain name needs to be consistent with mailbox domain name added in Guance) to realize single sign-on.**<br />![](../img/04_okta_15.png)<br />3）Return the SAML assertion address and Entity ID for updating Okta, see [step 2.2)](#j217u)。<br />**Note: When configuring single sign-on in Guance, the assertion address configured in the identity provider SAML must be consistent with that in Guance to implement single sign-on.**


### 6.SSO to Guance Using Okta Account

1）After the SSO configuration is completed, log in through [Guance official website](https://www.dataflux.cn/) or [Guance studio](https://auth.dataflux.cn/loginpsw), and select "Single Sign-on" on the login page.<br />![](../img/04_okta_16.png)<br />2）Enter the email address where the SSO is being created and click "Get login address". <br />![](../img/04_okta_17.png)<br />3）Click the link to open the enterprise account login page.<br />![](../img/04_okta_18.png)<br />4）Enter the enterprise common mailbox and password. <br />![](../img/04_okta_19.png)<br />5）Log in to the workspace corresponding to Guance.<br />Note: If multiple workspaces are configured with the same identity provider SSO at the same time, users can click the workspace option in the upper left corner of Guance to switch between different workspaces to view data.<br />![](../img/04_okta_20.png)


---

