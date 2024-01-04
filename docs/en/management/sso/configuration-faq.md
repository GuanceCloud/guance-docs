# FAQ 
---

### Question 1: What is Guance SSO? {#saml}

Single Sign-On (SSO) is one of the solutions to integrate enterprise systems, used for unified user identity authentication. Users only need to log in once to access all mutually trusted enterprise application systems. Guance's SSO is based on the SAML 2.0 (Security Assertion Markup Language 2.0) and OIDC/OAuth2.0 protocols for federated identity verification.

The basic concepts of SAML are as follows:

| Term | Explanation |
| --- | --- |
| Identity Provider (IdP) | An entity that contains metadata about external identity providers. The identity provider can provide identity management services, such as Azure AD, Authing, Okta, Keycloak, etc. |
| Service Provider (SP) | An application that provides specific services to users using the identity management functions of the IdP. The SP uses the user information provided by the IdP, such as Guance. |
| Security Assertion Markup Language (SAML 2.0) | A standard protocol for implementing enterprise-level user identity authentication. It is one of the technical implementation methods for mutual trust between SP and IdP. |
| SAML Assertion | The core element used to describe authentication requests and responses in the SAML protocol. User-specific attributes, such as the email information required for Guance single sign-on configuration, are included in the assertion of the authentication response. |
| Trust | The trust mechanism established between SP and IdP, usually implemented using public and private keys. SP obtains the IdP's SAML metadata in a trusted manner, which contains the public key used by the IdP to sign and verify the integrity of SAML assertions. |

### Question 2: How to obtain the cloud data document used for creating an identity provider in Guance SSO management?

After configuring the entity ID and callback address (assertion address) for SAML single sign-on in the identity provider, you can download the cloud data document. If there is no entity ID and callback address, you can fill in the following examples to obtain the metadata document.

- Entity ID: https://auth.guance.com/saml/metadata.xml;
- Assertion address (temporary): https://auth.guance.com/saml/assertion.

After enabling SSO in Guance, [obtain the correct entity ID and assertion address](../../management/sso/index.md) and replace them.


### Question 3: How to obtain the entity ID and assertion address (callback address) for Guance in the common SSO configuration using the SAML protocol?

Go to [obtain the Entity ID and Assertion URL](../sso/index.md#obtain).

### Question 4: After configuring the entity ID and assertion address (callback address) for the identity provider, I still cannot perform single sign-on in Guance. How to resolve this?

When configuring the identity provider SAML, you need to configure email mapping to associate the identity provider's user email (i.e., the identity provider maps the login user's email to the associated field in Guance).

In Guance, a mapping field is defined for association mapping. You must fill in **Email** for mapping. For example, in Azure AD, you need to add an attribute declaration in **Attributes and Claims**, as shown in the following figure:

- Name: The field defined by Guance, fill in **Email**;
- Source attribute: Select "user.mail" based on the actual email of the identity provider.

![](../img/9.azure_8.1.png)

### Question 5: After configuring the email mapping declaration for the identity provider, I still cannot perform single sign-on in Guance. How to resolve this?

The associated mapping email field defined by Guance uses regular expressions to match the email rules of the identity provider. If the configured email rules of the identity provider do not match the regular expression supported by Guance, single sign-on cannot be performed. Please contact Guance customer support for assistance.

Currently, the regular expression supported by Guance for email is as follows:

```
[\\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?
```

You can use the following website to test the regular expression:

https://c.runoob.com/front-end/854/

### Question 6: After configuring the entity ID, assertion address (callback address), email mapping, and declaration for the identity provider, I still cannot perform single sign-on in Guance. How to resolve this?

Guance supports role mapping based on configuration to provide more precise single sign-on solutions for enterprises. If role mapping is enabled, users who log in to Guance account using SAML will have their current roles revoked and new roles will be assigned based on the detailed information in the SAML assertion passed by the identity provider and the mapping listed. Users who log in using SAML without being mapped to an Guance role will have all their roles revoked and will not be allowed to log in to Guance console.

You can configure attribute fields, attribute values, and roles in Guance [role mapping](../sso/index.md#saml-mapping)) based on the attribute fields and attribute values of the IdP. After configuration, you can log in to Guance console using SAML.

### Question 7: Can multiple SSO be configured in Guance?

For account security considerations, Guance supports only one SSO configuration per workspace. If you have previously configured SAML 2.0, we will consider the last updated SAML 2.0 configuration as the final single sign-on verification entrance.

If multiple workspaces are configured with the same identity provider SSO, after users log in to the workspace using SSO, they can click the workspace option in the upper-left corner of Guance to switch to different workspaces and view data.

### Question 8: What are the access permissions supported by accounts logged in through SSO?

When configuring SSO, you can set role access permissions, including **Standard** and **Read-only**. You can upgrade to Administrator in **Member Management**, and if role mapping is enabled in the workspace, members will be assigned roles based on the mapping rules when logging in.

> For more details, see [Roles](../role-management.md).

### Question 9: Can accounts logged in through SSO be deleted in Guance? Can they log in again after deletion?

In SSO management, you can click the number of a member to jump to **Member Management** and view the list of authorized SSO login members. You can delete SSO login members. After a member is deleted from Guance, as long as the identity provider is not deleted, the member can still log in to Guance workspace. If you need to completely delete the member and prevent them from logging in through SSO, you need to delete the user accounts in both Guance and the identity provider.

![](../img/12.sso_13.png)