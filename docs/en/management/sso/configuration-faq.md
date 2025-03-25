# Configuration FAQs
---

:material-chat-question: **What is <<< custom_key.brand_name >>> SSO Single Sign-On?**

Single sign-on (SSO) is one of the solutions for integrating enterprise systems, used to unify user identity authentication. Users only need to log in once to access all mutually trusted application systems within the enterprise. <<< custom_key.brand_name >>>'s SSO single sign-on is based on SAML 2.0 (Security Assertion Markup Language 2.0) and OIDC/Oauth2.0 federated identity verification.

The full English name of SAML is Security Assertion Markup Language, which is an open-source standard data format based on XML specifically supporting federated identity verification. It securely exchanges authentication and authorization data between the Identity Provider (IdP) and the Service Provider (SP).

Basic SAML concepts are as follows:

| Term      | Explanation                          |
| ----------- | ------------------------------------ |
| Identity Provider (IdP)       | An entity that contains metadata about external identity providers. The identity provider can provide identity management services, such as Azure AD, Authing, Okta, Keycloak, etc.  |
| Service Provider (SP)     | An application that utilizes the identity management functions of the IdP to provide specific services to users. SP will use the user information provided by the IdP, such as <<< custom_key.brand_name >>>. |
| Security Assertion Markup Language (SAML 2.0)  | A standard protocol for implementing enterprise-level user identity authentication. It is one of the technical implementations that enable mutual trust between SP and IdP. |
| SAML Assertion (SAML assertion)      | The core element in the SAML protocol used to describe authentication requests and authentication responses. For example, the specific attributes of a user (such as the email information configured for <<< custom_key.brand_name >>> single sign-on) are included in the assertion of the authentication response.                          |
| Trust      | A mutual trust mechanism established between SP and IdP, usually implemented by public keys and private keys. SP obtains the SAML metadata of the IdP in a trustworthy manner. The metadata contains the signature verification public key issued by the IdP for signing SAML assertions, and SP uses the public key to verify the integrity of the assertion.                          |


:material-chat-question: **How to obtain the cloud data document used for creating an identity provider in <<< custom_key.brand_name >>> SSO Management?**

After configuring the entity ID and callback address (assertion address) of the SAML single sign-on in the identity provider, you can download the cloud data document. If there is no entity ID and callback address (assertion address), you can fill in the following example to obtain the metadata document.

- Entity ID: [https://<<< custom_key.studio_main_site_auth >>>/saml/metadata.xml](https://<<< custom_key.studio_main_site_auth >>>/saml/metadata.xml);
- Assertion address, temporary use: [https://<<< custom_key.studio_main_site_auth >>>/saml/assertion](https://<<< custom_key.studio_main_site_auth >>>/saml/assertion/).

After enabling SSO single sign-on in <<< custom_key.brand_name >>>, replace it with the [correct entity ID and assertion address obtained](../../management/sso/index.md#obtain).


:material-chat-question: **For common SAML protocol SSO single sign-on, login requires configuring the entity ID and callback address (assertion address). How to obtain the entity ID and callback address (assertion address) for <<< custom_key.brand_name >>>?**

Go to [Obtain Entity ID and Assertion Address](../sso/index.md#obtain).


:material-chat-question: **After configuring the entity ID and callback address (assertion address) in the identity provider, I still cannot perform single sign-on in <<< custom_key.brand_name >>>. How to resolve this?**

When configuring SAML in the identity provider, you need to configure email mapping, which is used to associate the user's email address from the identity provider (i.e., the identity provider maps the logged-in user's email to the associated field in <<< custom_key.brand_name >>>).

In <<< custom_key.brand_name >>>, a mapping field is defined, and **Email** must be entered for the mapping. For example, in Azure AD, you need to add an **attribute claim** in **Attributes and Claims**, see the figure below:

- Name: The field defined by <<< custom_key.brand_name >>>, enter **Email**;
- Source Attribute: Select "user.mail" according to the actual email address provided by the identity provider.

![](../img/9.azure_8.1.png)

:material-chat-question: **After configuring the email mapping statement in the identity provider, I still cannot perform single sign-on in <<< custom_key.brand_name >>>. How to resolve this?**

The email mapping field defined by <<< custom_key.brand_name >>> matches the email rules of the identity provider through regular expressions. If the email rule configured by the identity provider does not conform to the email regular expression supported by <<< custom_key.brand_name >>>, single sign-on cannot be performed. Please [contact <<< custom_key.brand_name >>> after-sales service](https://<<< custom_key.brand_main_domain >>>/#home) for handling.

![](../img/contact-us.png)

Currently, the email regular expressions supported by <<< custom_key.brand_name >>> are as follows:

```
[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?
```

You can test the regular expression using the following website:

[https://c.runoob.com/front-end/854/](https://c.runoob.com/front-end/854/)


:material-chat-question: **After completing the configuration of the entity ID, callback address (assertion address), email mapping, and statement in the identity provider, I still cannot perform single sign-on in <<< custom_key.brand_name >>>. How to resolve this?**

If the [role mapping](index.md#saml-mapping) is enabled in <<< custom_key.brand_name >>>, the role of the SSO login user account will be removed from its current workspace and dynamically assigned roles based on the **attribute fields** and **attribute values** provided by the identity provider. If no role mapping rule is matched, the user account will lose all roles and will not be allowed to log in and access the <<< custom_key.brand_name >>> workspace.

If the above situation is excluded, please contact your account manager for assistance.


:material-chat-question: **Can multiple SSO single sign-ons be configured in <<< custom_key.brand_name >>>?**

Yes. Refer to the configuration steps in [User SSO](./index.md#corporate).


:material-chat-question: **What access permissions are supported for accounts logging in via SSO?**

When configuring SSO single sign-on, the supported role access permissions include **standard members** and **read-only members**. These can be upgraded to "Administrator" in **Member Management**. If the [role mapping](index.md#saml-mapping) feature is enabled within the workspace, members will be prioritized to be assigned roles based on the mapping rules.

> For more details, refer to [Role Management](../role-management.md).


:material-chat-question: **Can accounts logging in via SSO be deleted in <<< custom_key.brand_name >>>? Can they log in again after deletion?**

Click the number in the figure to delete the SSO login member. As long as the identity provider has not been deleted, the member can continue to log into the <<< custom_key.brand_name >>> workspace. If you need to completely delete the member and prevent them from logging in via SSO, you must simultaneously delete the user account in both <<< custom_key.brand_name >>> and the identity provider.

![](../img/12.sso_13.png)