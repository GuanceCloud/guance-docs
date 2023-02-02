# Authing SSO
---

## Operation Scene
Authing is a provider of identification and access management solutions. Guance supports federated authentication based on SAML 2.0 (Security Assertion Markup Language 2.0), an open standard used by many authentication providers (IdP). You can integrate Authing with Guance through SAML 2.0-based federation authentication, so that the Authing account automatically logs in (single sign-on) to Guance platform to access the corresponding workspace resources, without having to create a separate Guance account for the enterprise/team.

## Operational Steps

### 1、Authing Account Registration/Login
You can create [Authing account](https://www.authing.cn/) through the following steps. If you already have an account in use, you can directly configure it in the next step. Note: Currently, Guance only supports SSO login of email account.

![](../img/1.authing_1.png)

### Create a User

After registering, or having an account, create a user in Authing "User Management"-"User List Page". As shown in the following figure:

Note: User name and mailbox can be created. User name When creating a user, the user name must be a mailbox. If the "username" account is used to realize SSO, the mapping relationship of the username <> mailbox needs to be added at the SAML protocol configuration.

![](../img/03_authing_03.png)

![](../img/03_authing_04.png)



### 3、Create Authing Application

After creating the user, enter the "Authing Application Page" and click "Add Application" to configure the application information. As shown in the following figure:

Note: If you already have an application in use, you can ignore this step and go straight to the next configuration. The application name here, authentication address requires custom configuration.

![](../img/03_authing_06.png)

### 4、Configure SAML2 Identity Provider Information

Go to the application configuration page and drop down to the bottom to find more identity protocols. Configure SAML2 identity provider information. As shown in the following figure:

（1）Fill in the default ACS address (assertion address) and click Save. (This configuration is only used to obtain metadata for the next step, and can be replaced after the correct assertion address is obtained in Guance. Example assertion address: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/)；）

（2）Download the SAML2 metadata document, which will be uploaded and used at the SSO identity provider creation place of Guance;

![](../img/03_authing_07.png)

### Select Authentication Protocol Type

Adjust the default protocol type of Authentication Configuration to SAML2.

![](../img/03_authing_08.png)

### Select Application Access Authorization

Adjust "Access Authorization" and set the default permission: Allow all users to access. As shown in the following figure:

![](../img/03_authing_09.png)

### 7、Enable SSO in Guance

Log in to [Guance](https://console.guance.com) and go to Administration-> SSO Administration-> Enable. To enable sso single sign-on in Guance workspace, refer to the doc [new SSO](../../management/sso/index.md).

- For account security reasons, only one SSO is configured in Guance support workspace. If you have configured SAML 2.0 before, we will regard your last updated SAML 2.0 configuration as the final SSO authentication entry by default.
- When SSO login is enabled, "mailbox domain name" needs to be added for mailbox domain name mapping between Guance and identity provider (user mailbox domain name needs to be consistent with mailbox domain name added in Guance) to realize SSO.

![](../img/03_authing_10.png)

### 8、Update Authing ACS Address and Mapping

After configuring Guance SSO, get the assertion address, update Auhting SAML2 "Default ACS Address Configuration", and add the field mapping setting. As shown in the following figure:

![](../img/03_authing_11.png)

**mapping**

```json
// Authing mailbox maps mailbox configuration, this line does not need to be copied
{
    "mappings": {
        "email": "Email"
    }
}

// Authing user name maps mailbox configuration, this line does not need to be copied

{
    "mappings": {
        "username": "Email"
    }
}
```

### Access Guance through SSO

On the [SSO](https://auth.guance.com/login/sso) page, enter the email address to get the login link. As shown in the following figure:

![](../img/03_authing_12.png)

Click "Link" to log in to Guance. Based on Step 2, enter the user name and password to log in to Guance.

![](../img/03_authing_13.png)

Note: If multiple workspaces are configured with the same identity provider SSO at the same time, users can click the workspace option in the upper left corner of Guance to switch different workspaces to view data after signing on to the workspace through SSO.

![](../img/1.authing_2.png)


---

