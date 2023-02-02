# FAQ about SSO Configuration
---

#### Question 1: What is SSO of Guance?

Single sign-on (SSO) is one of the solutions to integrate enterprise systems, which is used for unified user authentication. Users only need to log in once to access all the application systems that enterprises trust each other. SSO single sign-on of Guance adopts SAML configuration. The basic concepts of SAML are as follows:

- Identity Provider(IdP): An entity that contains metadata about an external identity provider that can provide identity management services. Such as Azure AD, Authing, Okta and Keycloak;
- Service Provider(SP): Applications that use IdP's identity management function to provide users with specific services, and SP will use the user information provided by IdP. Such as Guance;
- Security Assertion Markup Language(SAML 2.0): a standard protocol for enterprise-level user authentication, which is one of the technical implementations of mutual trust between SP and IdP;
- SAML assertion: The core element of the SAML protocol used to describe authentication requests and authentication responses. For example, the specific attributes of the user (such as the mailbox information that needs to be configured to Guance single sign-on) are included in the assertion of the authentication response;
- Trust: A mutual Trust mechanism established between SP and IdP, which is usually realized by public key and private key. SP obtains the SAML metadata of IdP in a trusted way. The metadata contains the signature verification public key of SAML assertion issued by IdP, and SP uses the public key to verify the integrity of assertion.


#### Question 2: How to obtain cloud data documents for creating identity providers in Guance SSO management?

After the identity provider has configured the "Entity ID" and "Callback Address (Assertion Address)" for SAML single sign-on, the cloud data document can be downloaded. If there is no Entity ID and Callback Address (Assertion Address), you can fill in the following example to get the metadata document.

- Entity ID: [https://auth.guance.com/saml/metadata.xml](https://auth.guance.com/saml/metadata.xml)
- Assertion address, temporary use: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/)

**Note: After SSO is enabled in Guance, get the correct Entity ID and Assertion Address and replace them again. Refer to doc **[new SSO](../../management/sso/index.md)**.**


#### Question 3: SSO of common SAML protocol needs to log in by configuring "Entity ID" and "Callback Address (Assertion Address)". How to obtain the "Entity ID" and "Callback Address (Assertion Address)" of Guance?

1）To enable sso, click Enable in Guance Workspace Administration-sso Administration. Refer to the doc [new SSO](../../management/sso/index.md).<br />![](../img/12.sso_4.png)

2）Upload the "metadata document" of the identity provider, configure the "mailbox domain name" and select "access role" to obtain the "entity ID" and "assertion address" of the identity provider. It supports directly copying the "login address" to log in.<br />![](../img/12.sso_8.png)


#### Question 4: After the identity provider has configured the "entity ID" and "callback address (assertion address)", it is still impossible to perform single sign-on in Guance. How to solve it?

When configuring the identity provider SAML, you need to configure a mailbox mapping to associate the identity provider's user mailbox (that is, the identity provider maps the logged-in user's mailbox to the associated field of Guance).

An association mapping field is defined in Guance, which must be mapped by filling in "Email". For example, in Azure AD, you need to add "attribute declaration" to "attributes and claims", as shown in the following figure:

- Name: the field defined by Guance, and "Email" should be filled in
- Source attributes: Select "user.mail" based on the identity provider's actual mailbox.

![](../img/9.azure_8.1.png)

#### Question 5: After the identity provider configures the mailbox mapping declaration, it is still impossible to perform single sign-on in Guance. How to solve it?

The associated mapping mailbox field defined by Guance matches the mailbox rules of the identity provider through regular expressions. If the configured mailbox rules of the identity provider do not conform to the mailbox regular expressions supported by Guance, single sign-on cannot be performed, and Guance can be contacted for after-sales processing.

The current Guance supports the following mailbox regular expressions: <br />`[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?`

You can do regular tests via the test site as follows: <br />[https://c.runoob.com/front-end/854/](https://c.runoob.com/front-end/854/)


#### Question 6: Can you configure multiple SSO in Guance?

For account security reasons, only one SSO is configured in Guance support workspace. If you have previously configured SAML 2.0, we will regard your last updated SAML 2.0 configuration as the final single sign-on authentication entry by default.

If multiple workspaces are configured with the same identity provider SSO at the same time, users can click on the workspace option in the upper left corner of Guance to switch different workspaces to view data after signing on to the workspace through SSO.


#### Question 7: What access rights are supported for an account logged in through SSO?

SSO configuration supports setting role access permissions including "standard member" and "read-only member", and can be upgraded to "administrator" in "member management" setting. For details, please refer to the doc [permission management](../../management/access-management.md).


#### Question 8: Can the account logged in through SSO be deleted in Guance? Can I log in again after deletion?

In SSO management, it is supported to click "Number" of "Member" and jump to "Member Management" to view the specific list of authorized single sign-on members, and it is supported to delete SSO login members. After Guance is deleted, as long as the identity provider is not deleted, the members can continue to log in to Guance workspace. If it is necessary to completely delete and prevent the member from logging in through SSO, it is necessary to delete the user accounts of Guance and the identity provider at the same time.<br />![](../img/12.sso_13.png)


---


