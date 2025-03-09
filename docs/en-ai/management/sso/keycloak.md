# Keycloak Single Sign-On Example
---

Keycloak is an open-source solution for identity and access management for modern applications and distributed services.

This article uses a built Keycloak server to demonstrate how to achieve Keycloak user SSO login to the <<< custom_key.brand_name >>> management console using the SAML 2.0 protocol.

> For instructions on achieving Keycloak user SSO login to the <<< custom_key.brand_name >>> management console using the OpenID Connect protocol, refer to [Keycloak Single Sign-On (Deployment Plan)](../../deployment/keycloak-sso.md).

## Prerequisites

A Keycloak server has been set up, and you can log in to the Keycloak server to perform configurations.

If you do not have a Keycloak environment, follow these steps to set it up:

```
sudo yum update         # Update

sudo yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel      # Install JDK

wget https://downloads.jboss.org/keycloak/11.0.2/keycloak-11.0.2.zip   # Download Keycloak

yum install unzip       # Install unzip

unzip keycloak-11.0.2.zip       # Extract Keycloak

cd keycloak-11.0.2/bin         # Enter the bin directory

./add-user-keycloak.sh -r master -u admin -p admin     # Create server administrator credentials

nohup bin/standalone.sh -b 0.0.0.0 &     # Return to the bin directory and start Keycloak service in the background
```

After setting up the Keycloak environment, enter `https://IP Address:8443/auth` in your browser, click “Administration Console” to open the Keycloak management console.

![](../img/05_keycloak_01.png)

## Concepts

Below are explanations of basic concepts involved in the Keycloak configuration process:

| Field      | Description                          |
| ----------- | ------------------------------------ |
| Realm      | A realm, similar to a workspace, used to manage users, credentials, roles, and user groups; realms are isolated from each other.                          |
| Clients | Clients are applications or services that can request Keycloak to authenticate users. |
| Users      | User accounts that can log into the system, requiring configuration of email and Credentials.                          |
| Credentials | Credentials used to verify user identity, such as setting the login password for user accounts. |
| Authentication      | The process of identifying and verifying users.                          |
| Authorization | The process of granting users access permissions. |
| Roles      | Used to identify types of user identities, such as administrator, regular user, etc.                          |
| User Role Mapping | The mapping relationship between users and roles, allowing one user to be associated with multiple roles. |
| Groups | Management of user groups, supporting role mapping to groups. |

## Configuration Steps

### 1. Create a Keycloak Realm

**Note**: Keycloak itself has a master realm (Master), and we need to create a new realm (similar to a workspace).

1) In the Keycloak management console, click **Master > Add realm**.

![](../img/05_keycloak_02.png)

2) On the **Add realm** page, input the realm name in the **Name** field, such as "gcy", and click **Create** to create a new realm.

![](../img/05_keycloak_03.png)


### 2. Create Client and Configure SAML {#step2}

**Note**: This step will create a Keycloak client and configure SAML to establish a trust relationship between Keycloak and <<< custom_key.brand_name >>> so they trust each other.

1) Under the newly created "gcy" realm, click **Client**, and on the right side, click **Create**.

![](../img/05_keycloak_04.png)

2) On the **Add Client** page, fill in the following details and click **Save**.

- Client ID (Entity ID): [https://auth.guance.com/saml/metadata.xml](https://auth.guance.com/saml/metadata.xml);  
- Client Protocol: Select **SAML**;   
- Client SAML Endpoint (Assertion URL), temporarily use: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/).   

**Note**: This configuration is only for obtaining metadata documents in the next step. After enabling SSO single sign-on in <<< custom_key.brand_name >>>, obtain the correct **Entity ID** and **Assertion URL** and replace them accordingly.

![](../img/05_keycloak_05.png)

After creating the client, under **Settings**, you can see the Entity ID, protocol, and Assertion URL filled in the previous step. Set the following parameters and save.

- Sign Assertions: ON (to prevent data tampering during transmission from IdP to SP, ensuring data security).

![](../img/05_keycloak_06.png)

- IDP Initiated SSO URL Name: Can be any name, e.g., "gcy". After filling this, an SSO single sign-on URL will be generated, as shown below;
- Base URL: Enter the SSO single sign-on URL generated in the previous parameter, such as `/auth/realms/gcy/protocol/saml/clients/gcy`. This is mainly used to generate a direct access link for single sign-on to <<< custom_key.brand_name >>> from Keycloak Clients.

![](../img/05_keycloak_07.png)

3) Under **Clients**'s **Mappers**, click **Create** to create an email mapper. This content is mandatory and must be filled out; otherwise, SSO single sign-on cannot be achieved.

![](../img/05_keycloak_08.png)

On the **Create Protocol Mapper** page, input the following and save.

- Name: Can be any name, e.g., "mail mapper";
- Mapper Type: Select "User Property";
- Property: Fill in **Email** according to the rules supported by the identity provider;
- SAML Attribute Name: Must be **Email**.

**Note**: <<< custom_key.brand_name >>> defines a mapped field that must be filled with **Email** to associate the identity provider's user email (i.e., the identity provider maps the logged-in user's email to Email).

![](../img/05_keycloak_09.png)

### 3. Obtain Keycloak Metadata Document {#step3}

**Note**: This step allows you to obtain the metadata document required to create an identity provider in <<< custom_key.brand_name >>>.

1) Under **Clients**'s **Installation**, select **Mod Auth Mellon files**, and click **Download** to download the metadata document.

![](../img/05_keycloak_10.png)

2) In the downloaded folder, select **idp-metadata.xml**.

![](../img/05_keycloak_11.png)

3) Since Keycloak’s cloud metadata document is at the **realm** level, add the client parameter `/clients/<IDP Initiated SSO URL Name>` to the access URL in the metadata document **idp-metadata.xml**. As this document sets `IDP Initiated SSO URL Name: gcy`, add `/clients/gcy` in the XML file as shown below. Save the XML file after completing the addition.

![](../img/05_keycloak_12.png)

### 4. Enable SSO Single Sign-On in <<< custom_key.brand_name >>>

1) Enable SSO single sign-on in <<< custom_key.brand_name >>> workspace **Management > Member Management > SSO Management**, and click **Enable**.

> Refer to the documentation [Create SSO](../../management/sso/index.md).

**Note**: Considering account security, <<< custom_key.brand_name >>> supports configuring only one SSO per workspace. If you have previously configured SAML 2.0, the last updated SAML 2.0 configuration will be considered the final single sign-on authentication entry.

![](../img/1.sso_enable.png)

2) Upload the **metadata document** downloaded in [Step 3](#step3), configure the **domain name (email suffix domain)**, and select the **role** to obtain the identity provider's **Entity ID** and **Assertion URL**, which support directly copying the **login URL** for login.

**Note**: The domain name is used for email domain mapping between <<< custom_key.brand_name >>> and the identity provider to achieve single sign-on, i.e., the email suffix domain of the user must match the domain added in <<< custom_key.brand_name >>>.

![](../img/1.sso_enable_2.png)

### 5. Replace SAML Assertion URL in Keycloak

1) Return to Keycloak and update the **Entity ID** and **Assertion URL** from [Step 2](#step2).

**Note**: When configuring single sign-on in <<< custom_key.brand_name >>>, the Assertion URL configured in the identity provider SAML must match the one in <<< custom_key.brand_name >>> to achieve single sign-on.

![](../img/05_keycloak_18.png)

### 6. Configure Keycloak Users

**Note**: This step configures authorized user email accounts in <<< custom_key.brand_name >>> via the identity provider. By configuring the Keycloak user email accounts, users can log in to <<< custom_key.brand_name >>> through single sign-on.

1) In the created gcy realm, click **User**, and then click **Add user**.

![](../img/05_keycloak_13.png)

2) Input **Username** and **Email**. Email is a required field and must match the user whitelist email configured in <<< custom_key.brand_name >>> for matching email mapping to log in to <<< custom_key.brand_name >>>.

![](../img/05_keycloak_14.png)

3) After creating the user, set the password for the user under **Credentials**.

![](../img/05_keycloak_15.png)

### 7. Use Keycloak Account to Log in to <<< custom_key.brand_name >>> via SSO

After all configurations are completed, there are two ways to log in to <<< custom_key.brand_name >>> via single sign-on.

#### Method One: Log in to <<< custom_key.brand_name >>> from Keycloak

1) In Keycloak's Clients, click the **Base URL** on the right side.

![](../img/05_keycloak_19.png)

2) Enter the configured user email and password.

![](../img/05_keycloak_20.png)

3) Log in to the corresponding workspace in <<< custom_key.brand_name >>>.

**Note**: If multiple workspaces have configured the same identity provider SSO single sign-on, users can switch between different workspaces to view data after logging in via SSO.

![](../img/1.sso_okta_23.png)

#### Method Two: Log in to <<< custom_key.brand_name >>> Using Keycloak Account

1) After SSO configuration is complete, log in via [<<< custom_key.brand_name >>> website](https://www.dataflux.cn/) or [<<< custom_key.brand_name >>> console](https://auth.dataflux.cn/loginpsw) and select **Single Sign-On** on the login page.

![](../img/9.sso_2.png)

2) Enter the email address configured for SSO creation and click **Get Login URL**.

![](../img/9.sso_3.png)

3) Click **Link** to open the enterprise account login page.

![](../img/03_authing_13.png)

4) Enter the enterprise common email (configured in Keycloak and <<< custom_key.brand_name >>> SSO management) and password.

![](../img/4.keycloak_9.1.png)

5) Log in to the corresponding workspace in <<< custom_key.brand_name >>>.

**Note**: If multiple workspaces have configured the same identity provider SSO single sign-on, users can switch between different workspaces to view data after logging in via SSO.

![](../img/1.sso_okta_23.png)