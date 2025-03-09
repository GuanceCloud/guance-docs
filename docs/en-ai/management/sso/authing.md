# Authing Single Sign-On Example
---

Authing is a provider of identity and access management solutions.

## Steps

### 1. Register / Log in to Authing Account

You can create an [Authing account](https://www.authing.cn/) by following these steps. If you already have an active account, proceed directly to the next configuration step.

**Note**: Currently <<< custom_key.brand_name >>> only supports single sign-on (SSO) login with email accounts.

![](../img/1.authing_1.png)

### 2. Create Users

Create users on the **Authing User Management > User List** page. As shown below:

**Note**: You can create users using either usernames or emails. When creating users with usernames, the username must be an email address. If you use a username for SSO, you need to add a mapping between the username and email during the SAML configuration.

![](../img/03_authing_03.png)

![](../img/03_authing_04.png)

### 3. Create Authing Application

After creating users, go to the **Authing Application Page**, click **Add Application**, and configure the application information as shown below:

**Note**: If you already have an active application, you can skip this step and proceed directly to the next configuration. The application name and authentication URL need to be customized.

![](../img/03_authing_06.png)

### 4. Configure SAML2 Identity Provider Information {#step4}

Enter the application configuration page, scroll down to find more identity protocols, and configure the SAML2 identity provider information as shown below:

1. Enter the default ACS URL (assertion consumer service URL) and click Save. (This configuration is only for obtaining metadata for the next step. After getting the correct assertion URL from <<< custom_key.brand_name >>>, you can replace it. Assertion URL example: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/);)
   
2. Download the SAML2 metadata document, which will be uploaded when creating the SSO identity provider in <<< custom_key.brand_name >>>;

![](../img/03_authing_07.png)

### 5. Select Authentication Protocol Type

Change the default protocol type in **Authentication Configuration** to SAML2.

![](../img/03_authing_08.png)

### 6. Select Application Access Authorization

Adjust **Access Authorization** settings to allow all users access by default, as shown below:

![](../img/03_authing_09.png)

### 7. [Enable SSO Single Sign-On in <<< custom_key.brand_name >>>](./azure-ad.md#step4)

### 8. Update Authing ACS URL and Mapping

After configuring <<< custom_key.brand_name >>> SSO single sign-on, obtain the assertion URL and update the **default ACS URL** in Authing SAML2. Add field mappings as shown below:

![](../img/03_authing_11.png)

**Mapping**

```json
// Email mapping configuration for Authing, do not copy this line
{
    "mappings": {
        "email": "Email"
    }
}

// Username mapping configuration for Authing, do not copy this line

{
    "mappings": {
        "username": "Email"
    }
}
```

### 9. [Access <<< custom_key.brand_name >>> via Single Sign-On](./azure-ad.md#step7)