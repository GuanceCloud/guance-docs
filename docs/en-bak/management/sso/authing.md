# Authing
---


## Setup

### 1. Authing Account Registration/Login

You can create an [Authing account](https://www.authing.cn/) through the following steps. If you already have an account in use, you can directly configure it in the next step. 

**Note**: Currently, Guance only supports SSO login of email account.

<img src="../../img/1.authing_1.png" width="60%" >

### 2. Create a User

Create a user in **Organization > Employees > Create**. 

![](../img/03_authing_03.png)

**Note**: Both **Username** and **Email** can be used to create accounts. When creating a user with a username, the username must be an email. If single sign-on is implemented using a username account, a mapping relationship between the username and email needs to be added later in the SAML protocol configuration.


![](../img/03_authing_04.png)



### 3. Create an Application


<font size=3>**Note**: If you already have an application in use, you can ignore this step and go straight to the next configuration. The application name and authentication address here requires custom configuration.</font>

After creating the user, go to **Applications > Self-built App > Create** to configure the application information. 


![](../img/03_authing_06.png)

### 4. Configure SAML 2.0 Identity Provider Information

Go to your application configuration page > **Protocal Configuration** and drop down to the bottom to find more identity protocols. Configure SAML2 identity provider information. 

:material-numeric-1-circle-outline: Adjust the default protocol type of Authentication Configuration to SAML2.

:material-numeric-2-circle-outline: Fill in the default ACS address (assertion address). *(This configuration is only used to obtain metadata for the next step, and can be replaced after the correct assertion address is obtained in Guance. Example assertion address: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/))*

:material-numeric-3-circle-outline: Download the SAML2 metadata document, which will be uploaded and used at the SSO identity provider creation place of Guance;

![](../img/03_authing_07.png)

### 5. Select Application Access Authorization

Go to the tab **Access Authorization** and check the permission **Add to Single Sign On**. 

![](../img/03_authing_09.png)

### 6. [Enable SSO in Guance](./azure-ad.md#step4)


### 7. Update Authing ACS Address and Mapping

After configuring Guance SSO, get the assertion address, update Auhting SAML2 > **Default ACS Address**, and add the field mapping setting. 

![](../img/03_authing_11.png)

**mapping**

```json
// Authing email maps Guance email; no need to copy
{
    "mappings": {
        "email": "Email"
    }
}

// Authing username maps Guance email; no need to copy

{
    "mappings": {
        "username": "Email"
    }
}
```

### 8. [Access Guance through SSO](./azure-ad.md#step7)

