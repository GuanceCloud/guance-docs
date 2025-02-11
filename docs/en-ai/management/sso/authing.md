# Authing Single Sign-On Example
---

Authing is a provider of identity and access management solutions.

## Procedure

### 1. Register / Log in to Authing Account

You can create an [Authing account](https://www.authing.cn/) by following these steps. If you already have an active account, proceed to the next configuration step.

**Note**: Currently, Guance only supports SSO login via email accounts.

![](../img/1.authing_1.png)

### 2. Create Users

On the **Authing User Management > User List** page, create users as shown below:

**Note**: Both username and email creation methods are supported. When creating users with usernames, the username must be an email address. If using a username for single sign-on, you will need to add a mapping between the username and email during the SAML protocol configuration.

![](../img/03_authing_03.png)

![](../img/03_authing_04.png)

### 3. Create Authing Application

After creating users, go to the **Authing Application Page**, click **Add Application**, and configure the application information as shown below:

**Note**: If you already have an active application, you can skip this step and proceed to the next configuration. The application name and authentication URL need to be customized.

![](../img/03_authing_06.png)

### 4. Configure SAML2 Identity Provider Information {#step4}

In the application configuration page, scroll to the bottom and find more identity protocols. Configure the SAML2 identity provider information as shown below:

(1) Enter the default ACS URL (assertion consumer service URL) and click Save. This configuration is used to obtain metadata for the next step. You can replace it later with the correct assertion URL from Guance (example: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/)).

(2) Download the SAML2 metadata document, which will be uploaded when creating the SSO identity provider in Guance;

![](../img/03_authing_07.png)

### 5. Select Authentication Protocol Type

Change the **Authentication Configuration** default protocol type to SAML2.

![](../img/03_authing_08.png)

### 6. Set Application Access Authorization

Adjust the **Access Authorization** settings to allow all users access by default, as shown below:

![](../img/03_authing_09.png)

### 7. [Enable SSO Single Sign-On in Guance](./azure-ad.md#step4)

### 8. Update Authing ACS URL and Mapping

After configuring the SSO single sign-on in Guance, obtain the assertion URL and update the Authing SAML2 **default ACS URL**. Add field mappings as shown below:

![](../img/03_authing_11.png)

**Mapping**

```json
// Email mapping configuration for Authing email, do not copy this line
{
    "mappings": {
        "email": "Email"
    }
}

// Username mapping configuration for Authing email, do not copy this line

{
    "mappings": {
        "username": "Email"
    }
}
```

### 9. [Access Guance via Single Sign-On](./azure-ad.md#step7)