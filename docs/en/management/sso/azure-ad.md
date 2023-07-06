# Azure AD SSO 
---

## Operation Scene

Azure Active Directory (Azure AD) is Microsoft's cloud-based identity and access management service that helps enterprises manage internal and external resources. Guance supports federated authentication based on SAML 2.0 (Security Assertion Markup Language 2.0), an open standard used by many authentication providers (IdP). You can integrate Azure AD with Guance through SAML 2.0-based federation authentication, enabling Azure AD account automatic logon (single sign-on) to Guance platform to access the corresponding workspace resources, without having to create a separate Guance account for the enterprise/team.


## Operational Steps

### 1.Create Azure AD Application

Note: To create Azure AD, you need to log in to an account first. If you don't have an account, you can create one first.<br />Open [Azure Active Directory administration center](https://aad.portal.azure.com/) and click Enterprise Applications-All Applications-New Application.<br />![](../img/02_azure_01.png)<br />2）On the "New Application" page, click Create Your Own Application, enter "Name of Application" on the open page, select "Non-Library Application" and click Create to create a new application.<br />![](../img/02_azure_02.png)

### 2.Configure SAML for the Azure AD Application

Note: This step maps the Azure AD application attributes to those of Guance, establishing a trust relationship between Azure AD and Guance so that they trust each other.<br />![](../img/02_azure_03.png)<br />2）In the "Basic SAML Configuration" section of the first step of "Setting up SAML SSO", click "Edit".<br />![](../img/02_azure_04.png)<br />Fill in the following example assertion address and entity ID.

- Identifier (Entity ID): [https://auth.guance.com/saml/metadata.xml](https://auth.guance.com/saml/metadata.xml)
- Reply to URL (assertion address), temporarily using: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/)

**Note: This configuration is only used to obtain the metadata document for the next step. After SSO is enabled in Guance, the correct "Entity ID" and "Assertion Address" are obtained and replaced again. Refer to doc **[**New SSO**](../../management/sso/index.md)**. **<br />![](../img/02_azure_05.png)

3）In the second step of "Setting up SAML Single Sign-On" Attributes and Claims" section, add a claim for the associated identity provider user mailbox and click "Edit".<br />![](../img/02_azure_06.png)<br />On the Attributes and Claims Editing page, click "Add New Claim".<br />![](../img/02_azure_07.png)<br />On the Manage Claims page, enter "Name" and "Source Attributes" and save:

- Name: "Email" must be filled in. This part is required. If it is not filled in, SSO will prompt that it cannot log in.
- Source attributes: Select "user.mail" based on the identity provider's actual mailbox.

Note: Guance defines a field that must be filled in with "Email" to associate the identity provider's user mailbox (that is, the identity provider maps the logged-in user's mailbox to Email). <br />![](../img/02_azure_08.png)

### 3.Get the Azure AD Metadata Document

Note: This step obtains the metadata document for creating identity providers in Guance.<br />1）In the "SAML Signing Certificate" section of Step 3 of "Setting up SAML Single Sign-On", click Download "Federated Metadata XML".<br />![](../img/02_azure_09.png)


### 4.Configure Azure AD Users

Note: In this step, the authorized user email account of the identity provider is configured to be created in Guance, and the configured Azure AD user email account can be used to log in to Guance platform at a single point.<br />1）In the newly created application, click "Users and Groups" and click "Add Users/Groups".<br />![](../img/02_azure_10.png)<br />2）Click "No item selected" to search for and select a user on the page that pops up, and click "Select".<br />![](../img/02_azure_11.png)<br />3）After selecting a user, return to "Add Assignment" and click "Assignment".<br />![](../img/02_azure_12.png)<br />4）After adding a user, you can view the list of assigned SSO authorized login users in "Users and Groups".<br />![](../img/02_azure_13.png)<br />Note: If there are no users, you can create a new one under the Users menu.<br />![](../img/02_azure_14.png)


### 5.Enable SSO in Guance and Replace SAML Assertion Address in Azure AD

1）Enable SSO single sign-on, and click Enable in Guance workspace "Management"-"SSO Management". Refer to the doc [new SSO](../../management/sso/index.md) 。<br />**Note: For account security reasons, only one SSO is configured in Guance support workspace. If you have previously configured SAML 2.0, we will regard your last updated SAML 2.0 configuration as the final SSO authentication entry by default.**<br />![](../img/02_azure_15.png)<br />2）Upload the "metadata document" of the identity provider, configure the "mailbox domain name", and select "access role" to obtain the "entity ID" and "assertion address" of the identity provider, and support directly copying the "login address" for login.<br />**Note: When SSO login is enabled, "mailbox domain name" needs to be added for mailbox domain name mapping between Guance and identity provider (user mailbox domain name needs to be consistent with mailbox domain name added in Guance) to realize single sign-on.**<br />![](../img/02_azure_16.png)<br />3）Return Azure AD, update the SAML entity ID and assertion address, see [step 2.2)](../../management/sso/azure-ad.md)。<br />**Note: When configuring single sign-on in Guance, the assertion address configured in the identity provider SAML must be consistent with that in Guance to implement single sign-on.**<br />![](../img/02_azure_17.png)


### 6.SSO to Guance Using Azure AD Account

1）After the SSO configuration is completed, log in through [Guance official website](https://www.dataflux.cn/) or [Guance console](https://auth.dataflux.cn/loginpsw), and select "Single Sign-on" on the login page.<br />![](../img/02_azure_18.png)<br />2）Enter the email address where the SSO is being created and click "Get login address".<br />![](../img/02_azure_19.png)<br />3）Click the link to open the enterprise account login page.<br />![](../img/02_azure_20.png)<br />4）Enter the enterprise common mailbox (the enterprise mailbox address configured in Azure AD and Guance SSO Administration) and password.<br />![](../img/02_azure_21.png)<br />5）Log in to the workspace corresponding to Guance.<br />Note: If multiple workspaces are configured with the same identity provider SSO at the same time, users can click the workspace option in the upper left corner of Guance to switch between different workspaces to view data.<br />![](../img/02_azure_22.png)


---

S