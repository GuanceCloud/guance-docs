# Configuration FAQs 
---

:material-chat-question: **What is Guance SSO?** 

Single Sign-On (SSO) is one of the solutions for integrating enterprise systems, used for unified user identity authentication. Users only need to log in once to access all applications that the enterprise trusts mutually. The SSO single sign-on of Guance is based on SAML 2.0 and OIDC/Oauth2.0 protocol joint identity verification.

SAML (Security Assertion Markup Language), is an open-source standard data format based on XML, specifically supporting joint identity verification, securely exchanging identity verification and authorization data between Identity Providers (IdP) and Service Providers (SP).

The basic concepts of SAML are as follows:

| Term | Explanation |
| --- | --- |
| Identity Provider (IdP) | An entity that contains metadata about external IdPs. The IdP can provide identity management services, such as Azure AD, Authing, Okta, Keycloak, etc. |
| Service Provider (SP) | An application that provides specific services to users using the identity management functions of the IdP. The SP uses the user information provided by the IdP, such as Guance. |
| Security Assertion Markup Language (SAML 2.0) | A standard protocol for implementing enterprise-level user identity authentication. It is one of the technical implementation methods for mutual trust between SP and IdP. |
| SAML Assertion | The core element used to describe authentication requests and responses in the SAML protocol. User-specific attributes, such as the email information required for Guance single sign-on configuration, are included in the assertion of the authentication response. |
| Trust | The trust mechanism established between SP and IdP, usually implemented using public and private keys. SP obtains the IdP's SAML metadata in a trusted manner, which contains the public key used by the IdP to sign and verify the integrity of SAML assertions. |

:material-chat-question: **How to obtain the cloud data document in Guance SSO management?**

After configuring the entity ID and reply URL for SAML single sign-on in the IdP, you can download the cloud data document. If there is no entity ID and callback address, you can fill in the following examples to obtain the metadata document.

- Entity ID: https://auth.guance.com/saml/metadata.xml;
- Reply URL (temporary): https://auth.guance.com/saml/assertion.

After enabling SSO in Guance, [obtain the correct entity ID and reply URL](../../management/sso/index.md#obtain) and replace them.


:material-chat-question: **How to obtain the entity ID and reply URL (callback address) for Guance?**

Go to [obtain the Entity ID and Assertion URL](../sso/index.md#obtain).

:material-chat-question: **After configuring the entity ID and reply URL (callback address) for the IdP, I still cannot perform single sign-on in Guance. How to resolve this?**

When configuring the identity provider SAML, you need to configure **email mapping** to associate the IdP's user email (i.e., the IdP maps the login user's email to the associated field in Guance).

In Guance, a mapping field is defined for association mapping. You must fill in **Email** for mapping. For example, in Azure AD, you need to add an attribute declaration in **Attributes&Claims**:

- Name: The field defined by Guance, fill in **Email**;
- Source attribute: Select "user.mail" based on the actual email of the IdP.

![](../img/9.azure_8.1.png)

:material-chat-question: **After configuring the email mapping declaration for the IdP, I still cannot perform single sign-on in Guance. How to resolve this?**

The associated mapping email field defined by Guance uses regular expressions to match the email rules of the IdP. If the configured email rules of the IdP do not match the regular expression supported by Guance, single sign-on cannot be performed. Please [contact us](https://www.guance.one/) for assistance.

![](../img/contact-us.png)

Currently, the regular expression supported by Guance for email is as follows:

```
[\\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?
```

You can use the following website to test the regular expression: `https://c.runoob.com/front-end/854/`

:material-chat-question: **After configuring the entity ID, reply URL, email mapping, and declaration for the IdP, I still cannot perform single sign-on in Guance. How to resolve this?**

If the [role mapping](index.md#saml-mapping) is enabled in Guance, the role of the user account logging in via SSO will be stripped from its current workspace and dynamically assigned roles according to the attribute fields and attribute values provided by the IDP. If the role mapping rules are not matched, the user account will be stripped of all roles and is not allowed to log in to the Guance workspace.

If the above situation is excluded, please contact the account manager for assistance.

:material-chat-question: **Can multiple SSO be configured in Guance?**

Yes. Configuration steps can be found at [User SSO](./index.md#corporate).

:material-chat-question: **Can accounts logged in through SSO be deleted in Guance? Can they log in again after deletion?**

Click on the number in the picture to delete the SSO login member. As long as the IdP is not deleted, the member can still continue to log in to the Guance workspace. If you need to completely delete and prevent the member from logging in through SSO, you need to delete the user accounts of both the Guance and the IdP.

![](../img/12.sso_13.png)