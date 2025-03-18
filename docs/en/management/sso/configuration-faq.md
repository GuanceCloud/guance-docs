# Configuration FAQs
---

:material-chat-question: **What is <<< custom_key.brand_name >>> SSO Single Sign-On?**

Single sign-on (SSO) is one of the solutions for integrating enterprise systems, used to unify user identity authentication. Users only need to log in once to access all enterprise applications that trust each other. <<< custom_key.brand_name >>>'s SSO single sign-on is based on SAML 2.0 (Security Assertion Markup Language 2.0) and OIDC/OAuth2.0 protocols for federated identity verification.

SAML stands for Security Assertion Markup Language, an XML-based open standard data format specifically supporting federated identity verification. It securely exchanges authentication and authorization data between Identity Providers (IdP) and Service Providers (SP).

Basic concepts of SAML are as follows:

| Term      | Explanation                          |
| ----------- | ------------------------------------ |
| Identity Provider (IdP)       | An entity containing metadata about external identity providers that can provide identity management services. Examples include Azure AD, Authing, Okta, Keycloak, etc.  |
| Service Provider (SP)     | An application that leverages IdP's identity management capabilities to provide specific services to users. SP uses user information provided by the IdP. For example, <<< custom_key.brand_name >>>. |
| Security Assertion Markup Language (SAML 2.0)  | A standard protocol for enterprise-level user identity authentication, it is one of the technical implementations enabling mutual trust between SP and IdP. |
| SAML Assertion      | The core element in the SAML protocol used to describe authentication requests and responses. User-specific attributes (such as email information required for <<< custom_key.brand_name >>> SSO) are included in the assertion of the authentication response.                          |
| Trust      | The mutual trust mechanism established between SP and IdP, typically implemented using public and private keys. SP obtains IdP’s SAML metadata through a trusted method; the metadata contains the public key used by the IdP to sign SAML assertions, which SP uses to verify the integrity of the assertion.                          |

:material-chat-question: **How do I obtain the cloud data document needed to create an Identity Provider in <<< custom_key.brand_name >>> SSO Management?**

After configuring the Entity ID and callback URL (assertion URL) for SAML single sign-on in the Identity Provider, you can download the cloud data document. If you do not have an Entity ID or callback URL (assertion URL), you can fill in the following examples to obtain the metadata document.

- Entity ID: [https://<<< custom_key.studio_main_site_auth >>>/saml/metadata.xml](https://<<< custom_key.studio_main_site_auth >>>/saml/metadata.xml);  
- Assertion URL, temporary use: [https://<<< custom_key.studio_main_site_auth >>>/saml/assertion/](https://<<< custom_key.studio_main_site_auth >>>/saml/assertion/).  

After enabling SSO single sign-on in <<< custom_key.brand_name >>>, replace with the correct Entity ID and assertion URL obtained from [here](../../management/sso/index.md#obtain).


:material-chat-question: **Common SAML protocol SSO single sign-on requires configuring the Entity ID and callback URL (assertion URL) for login. How do I get the Entity ID and callback URL (assertion URL) for <<< custom_key.brand_name >>>?**

Go to [Obtain Entity ID and Assertion URL](../sso/index.md#obtain).


:material-chat-question: **After configuring the Entity ID and callback URL (assertion URL) in the Identity Provider, I still cannot perform single sign-on in <<< custom_key.brand_name >>>. How do I resolve this?**

When configuring SAML in the Identity Provider, you need to configure email mapping to associate the Identity Provider's user email (i.e., the Identity Provider maps the login user's email to the associated field in <<< custom_key.brand_name >>>).

<<< custom_key.brand_name >>> defines an associated mapping field that must be filled with **Email** for mapping. For example, in Azure AD, you need to add **Attribute Claims** under **Attributes and Claims**, as shown below:

- Name: <<< custom_key.brand_name >>> defined field, should be filled with **Email**;  
- Source attribute: Select "user.mail" based on the actual email address provided by the Identity Provider.

![](../img/9.azure_8.1.png)

:material-chat-question: **After configuring the email mapping claim in the Identity Provider, I still cannot perform single sign-on in <<< custom_key.brand_name >>>. How do I resolve this?**

The associated email mapping field defined by <<< custom_key.brand_name >>> matches the email rules of the Identity Provider using regular expressions. If the configured Identity Provider email rule does not match the supported email regular expression of <<< custom_key.brand_name >>>, single sign-on will fail. You can [contact <<< custom_key.brand_name >>> support](https://<<< custom_key.brand_main_domain >>>/#home) for assistance.

![](../img/contact-us.png)

Currently, <<< custom_key.brand_name >>> supports the following email regular expression:

```
[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?
```

You can test the regular expression using the following website:

[https://c.runoob.com/front-end/854/](https://c.runoob.com/front-end/854/)

:material-chat-question: **After configuring the Entity ID, callback URL (assertion URL), email mapping, and claims in the Identity Provider, I still cannot perform single sign-on in <<< custom_key.brand_name >>>. How do I resolve this?**

If <<< custom_key.brand_name >>> has enabled [role mapping](index.md#saml-mapping), the roles of SSO login users will be removed from their current workspace and dynamically assigned based on the **attribute fields** and **attribute values** provided by the Identity Provider. If no role mapping rule matches, the user account will lose all roles and will not be allowed to log in to the <<< custom_key.brand_name >>> workspace.

If none of the above applies, please contact your account manager for assistance.


:material-chat-question: **Can <<< custom_key.brand_name >>> configure multiple SSO single sign-ons?**

Yes. Refer to [User SSO](./index.md#corporate) for configuration steps.


:material-chat-question: **What access permissions are supported for accounts logging in via SSO?**

During SSO configuration, role access permissions such as **Standard Member** and **Read-Only Member** can be set. These can be upgraded to "Administrator" in **Member Management**. If the workspace enables the [role mapping](index.md#saml-mapping) feature, members will be assigned roles according to the mapped rules when they log in.

> For more details, refer to [Role Management](../role-management.md).


:material-chat-question: **Can accounts logging in via SSO be deleted from <<< custom_key.brand_name >>>? Can they log in again after deletion?**

Click the number in the image to delete an SSO login member. As long as the Identity Provider has not deleted the user, the member can continue to log into the <<< custom_key.brand_name >>> workspace. To completely remove the member and prevent them from logging in via SSO, you must delete both the <<< custom_key.brand_name >>> and Identity Provider user accounts.

![](../img/12.sso_13.png)