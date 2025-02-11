# Configuration FAQs
---

:material-chat-question: **What is Guance SSO Single Sign-On?**

Single Sign-On (SSO) is one of the solutions for integrating enterprise systems, used to unify user identity authentication. Users only need to log in once to access all enterprise applications that trust each other. Guance's SSO Single Sign-On is based on SAML 2.0 (Security Assertion Markup Language 2.0) and OIDC/OAuth2.0 protocols for federated identity verification.

SAML stands for Security Assertion Markup Language, an XML-based open standard data format specifically supporting federated identity verification. It securely exchanges authentication and authorization data between Identity Providers (IdP) and Service Providers (SP).

Basic concepts of SAML are as follows:

| Term | Explanation |
| ---- | ----------- |
| Identity Provider (IdP) | An entity containing metadata about external identity providers, providing identity management services. Examples include Azure AD, Authing, Okta, Keycloak, etc. |
| Service Provider (SP) | An application that leverages IdP's identity management capabilities to provide specific services to users. SP uses user information provided by the IdP. For example, Guance. |
| Security Assertion Markup Language (SAML 2.0) | A standard protocol for enterprise-level user identity authentication, it is one of the technical implementations enabling mutual trust between SP and IdP. |
| SAML Assertion | The core element in the SAML protocol used to describe authentication requests and responses. Specific user attributes (e.g., email information required for Guance SSO configuration) are included in the assertion of the authentication response. |
| Trust | A mutual trust mechanism established between SP and IdP, typically implemented using public and private keys. SP obtains IdP's SAML metadata in a trusted manner, which contains the public key used by IdP to sign SAML assertions. SP then uses this public key to verify the integrity of the assertion. |

:material-chat-question: **How do I obtain the cloud data document for creating an Identity Provider in Guance SSO Management?**

After configuring the Entity ID and callback URL (assertion address) in the Identity Provider for SAML Single Sign-On, you can download the cloud data document. If there is no Entity ID or callback URL (assertion address), you can use the following examples to get the metadata document.

- Entity ID: [https://auth.guance.com/saml/metadata.xml](https://auth.guance.com/saml/metadata.xml);
- Assertion URL, temporary use: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/).

After enabling SSO Single Sign-On in Guance, replace with the correct Entity ID and assertion URL obtained from [here](../../management/sso/index.md#obtain).


:material-chat-question: **For common SAML protocol SSO Single Sign-On, how do I obtain Guance's Entity ID and callback URL (assertion address)?**

Go to [Obtain Entity ID and Assertion Address](../sso/index.md#obtain).


:material-chat-question: **After configuring the Entity ID and callback URL (assertion address) in the Identity Provider, I still cannot perform single sign-on in Guance. How can I resolve this?**

When configuring SAML in the Identity Provider, you need to configure email mapping to associate the Identity Provider's user email (i.e., the Identity Provider maps the login user's email to the associated field in Guance).

Guance defines an associated mapping field that must be set to **Email** for mapping. For example, in Azure AD, you need to add an **Attribute Claim** in **Attributes and Claims**, as shown in the figure below:

- Name: The field defined by Guance, enter **Email**;
- Source Attribute: Select "user.mail" based on the actual email attribute of the Identity Provider.

![](../img/9.azure_8.1.png)

:material-chat-question: **After configuring the email mapping claim in the Identity Provider, I still cannot perform single sign-on in Guance. How can I resolve this?**

The associated mapping email field defined by Guance matches the email rules of the Identity Provider using regular expressions. If the configured Identity Provider email rule does not match the supported email regular expression of Guance, single sign-on will fail. Please [contact Guance support](https://www.guance.com/#home) for assistance.

![](../img/contact-us.png)

The current email regular expression supported by Guance is as follows:

```
[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?
```

You can test the regular expression using the following website:

[https://c.runoob.com/front-end/854/](https://c.runoob.com/front-end/854/)

:material-chat-question: **After configuring the Entity ID, callback URL (assertion address), email mapping, and claims in the Identity Provider, I still cannot perform single sign-on in Guance. How can I resolve this?**

If [Role Mapping](index.md#saml-mapping) is enabled in Guance, the roles of SSO login users will be revoked from their current workspace and dynamically assigned based on the **attribute fields** and **attribute values** provided by the Identity Provider according to the role mapping rules. If no role mapping rule is matched, the user account will be stripped of all roles and will not be allowed to log in to the Guance workspace.

If none of the above situations apply, please contact your account manager for assistance.


:material-chat-question: **Can multiple SSO Single Sign-On configurations be set up in Guance?**

Yes. Refer to [User SSO](./index.md#corporate) for configuration steps.


:material-chat-question: **What access permissions are supported for accounts logging in via SSO?**

During SSO configuration, role access permissions can be set to include **Standard Member** and **Read-Only Member**. These can be upgraded to "Administrator" in **Member Management**. If the [Role Mapping](index.md#saml-mapping) feature is enabled within the workspace, members will be assigned roles based on the mapping rules when they log in.

> Refer to [Role Management](../role-management.md) for more details.


:material-chat-question: **Can SSO login accounts be deleted in Guance? Can they log in again after deletion?**

Click the number in the image to delete an SSO login member. As long as the Identity Provider has not been deleted, the member can continue to log into the Guance workspace. To completely delete and prevent the member from logging in via SSO, both the Guance and Identity Provider user accounts must be deleted.

![](../img/12.sso_13.png)