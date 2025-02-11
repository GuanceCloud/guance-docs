# Keycloak Single Sign-On Example
---

Keycloak is an open-source solution for identity and access management tailored for modern applications and distributed services.

This article demonstrates how to use the SAML 2.0 protocol to achieve Keycloak user SSO login to the Guance management console using a configured Keycloak server.

> For using the OpenID Connect protocol to achieve Keycloak user SSO login to the Guance management console, refer to [Keycloak Single Sign-On (Deployment Plan)](../../deployment/keycloak-sso.md).

## Prerequisites

A Keycloak server has been set up, and you can log in to configure it.

If you do not have a Keycloak environment, follow these steps to set it up:

```
sudo yum update         # Update

sudo yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel      # Install JDK

wget https://downloads.jboss.org/keycloak/11.0.2/keycloak-11.0.2.zip   # Download Keycloak

yum install unzip       # Install unzip

unzip keycloak-11.0.2.zip       # Extract Keycloak

cd keycloak-11.0.2/bin         # Navigate to bin directory

./add-user-keycloak.sh -r master -u admin -p admin     # Create server admin credentials

nohup bin/standalone.sh -b 0.0.0.0 &     # Start Keycloak service in the background from bin directory
```

After setting up the Keycloak environment, enter `https://IP address:8443/auth` in your browser, click "Administration Console" to open the Keycloak management console.

![](../img/05_keycloak_01.png)

## Concept Explanation

Below are explanations of basic concepts involved in configuring Keycloak:

| Field | Description |
|-------|-------------|
| Realm | A realm is similar to a workspace used to manage users, credentials, roles, and user groups. Realms are isolated from each other. |
| Clients | Applications or services that request Keycloak to authenticate users. |
| Users | User accounts that can log into the system, requiring configuration of login email and credentials. |
| Credentials | Credentials used to verify user identity, such as setting login passwords. |
| Authentication | The process of identifying and verifying users. |
| Authorization | The process of granting users access permissions. |
| Roles | Identifies user types, such as administrators, regular users, etc. |
| User role mapping | Mapping relationship between users and roles; one user can be associated with multiple roles. |
| Groups | Managing user groups, supporting role mapping to groups. |

## Steps

### 1. Create a Keycloak Realm

**Note**: Keycloak itself has a master realm (Master). We need to create a new realm (similar to a workspace).

1) In the Keycloak management console, click **Master > Add realm**.

![](../img/05_keycloak_02.png)

2) On the **Add realm** page, input the realm name in the **Name** field, e.g., "gcy", then click **Create** to create a new realm.

![](../img/05_keycloak_03.png)

### 2. Create a Client and Configure SAML {#step2}

**Note**: This step will create a Keycloak client and configure SAML to establish trust between Keycloak and Guance.

1) Under the newly created "gcy" realm, click **Client**, then click **Create** on the right side.

![](../img/05_keycloak_04.png)

2) Fill out the **Add Client** form with the following details and click **Save**.

- Client ID (Entity ID): [https://auth.guance.com/saml/metadata.xml](https://auth.guance.com/saml/metadata.xml);
- Client Protocol: Select **SAML**;
- Client SAML Endpoint (Assertion URL), temporarily use: [https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/).

**Note**: This configuration is only for obtaining metadata documents in the next step. After enabling SSO single sign-on in Guance, replace the **Entity ID** and **Assertion URL** with the correct ones obtained from Guance.

![](../img/05_keycloak_05.png)

After creating the client, go to **Settings** to see the entity ID, protocol, and assertion URL filled in the previous step. Set the following parameters and save.

- Sign Assertions: ON (to prevent IdP data transmission tampering and ensure data security from IdP to SP).

![](../img/05_keycloak_06.png)

- IDP Initiated SSO URL Name: Any value, e.g., "gcy"; after filling this, it will generate an SSO single sign-on URL, as shown below;
- Base URL: Enter the SSO single sign-on URL generated in the previous parameter, e.g., `/auth/realms/gcy/protocol/saml/clients/gcy`, which mainly generates a direct access link for single sign-on to Guance in Keycloak Clients.

![](../img/05_keycloak_07.png)

3) In **Clients** under **Mappers**, click **Create** to create an email mapper. This is a required step; without it, SSO single sign-on cannot be achieved.

![](../img/05_keycloak_08.png)

On the **Create Protocol Mapper** page, fill in the following content and save.

- Name: Any value, e.g., "mail mapper";
- Mapper Type: Select "User Property";
- Property: Fill in **Email** according to the rules supported by the identity provider;
- SAML Attribute Name: Must fill in **Email**.

**Note**: Guance defines a mapping field that must be filled in with **Email** to associate the identity provider's user email (i.e., the identity provider maps the logged-in user's email to Email).

![](../img/05_keycloak_09.png)

### 3. Obtain Keycloak Metadata Document {#step3}

**Note**: This step retrieves the metadata document needed to create an identity provider in Guance.

1) In **Clients** under **Installation**, select **Mod Auth Mellon files**, then click **Download** to download the metadata document.

![](../img/05_keycloak_10.png)

2) In the downloaded folder, select **idp-metadata.xml**.

![](../img/05_keycloak_11.png)

3) Since Keycloak’s cloud data document is **realm**-level, add the client parameter `/clients/<IDP Initiated SSO URL Name>` to the access URL in the metadata document **idp-metadata.xml**. Since `IDP Initiated SSO URL Name: gcy` was set, fill in `/clients/gcy` in the xml file, as shown below. Save the xml file after adding.

![](../img/05_keycloak_12.png)

### 4. Enable SSO Single Sign-On in Guance

1) Enable SSO single sign-on in the Guance workspace **Management > Member Management > SSO Management**, click **Enable**.

> Refer to the documentation [Create SSO](../../management/sso/index.md).

**Note**: For account security reasons, Guance supports only one SSO configuration per workspace. If you have previously configured SAML 2.0, the last updated SAML 2.0 configuration will be considered the final single sign-on authentication entry.

![](../img/1.sso_enable.png)

2) Upload the **metadata document** downloaded in [Step 3](#step3), configure the **domain (email domain)**, choose the **role**, and obtain the **entity ID** and **assertion URL** of the identity provider, allowing direct copying of the **login URL** for login.

**Note**: The domain is used for email domain mapping between Guance and the identity provider to achieve single sign-on, i.e., the email domain suffix of the user must match the domain added in Guance.

![](../img/1.sso_enable_2.png)

### 5. Replace SAML Assertion URL in Keycloak

1) Return to Keycloak and update the **entity ID** and **assertion URL** in [Step 2](#step2).

**Note**: The assertion URL configured in the identity provider SAML in Guance must match the one in Keycloak to enable single sign-on.

![](../img/05_keycloak_18.png)

### 6. Configure Keycloak Users

**Note**: This step configures authorized user email accounts for the identity provider created in Guance. By configuring Keycloak user email accounts, you can single sign-on to the Guance platform.

1) In the created "gcy" realm, click **User**, then click **Add user**.

![](../img/05_keycloak_13.png)

2) Input **Username** and **Email**. Email is a required field and must match the email domain configured in the Guance identity provider, used to map emails for logging into Guance.

![](../img/05_keycloak_14.png)

3) After creating the user, set the password in **Credentials**.

![](../img/05_keycloak_15.png)

### 7. Single Sign-On to Guance Using Keycloak Account

After all configurations are completed, there are two ways to single sign-on to Guance.

#### Method One: Login to Guance via Keycloak

1) In Keycloak's Clients, click the **Base URL** on the right side.

![](../img/05_keycloak_19.png)

2) Enter the configured user email and password.

![](../img/05_keycloak_20.png)

3) Log in to the corresponding workspace in Guance.

**Note**: If multiple workspaces are configured with the same identity provider SSO single sign-on, users can switch between different workspaces after logging in via SSO by clicking the workspace option in the top-left corner of Guance.

![](../img/1.sso_okta_23.png)

#### Method Two: Single Sign-On to Guance Using Keycloak Account

1) After SSO configuration is complete, log in through the [Guance website](https://www.dataflux.cn/) or the [Guance console](https://auth.dataflux.cn/loginpsw) and select **Single Sign-On** on the login page.

![](../img/9.sso_2.png)

2) Enter the email address configured during SSO creation and click **Get Login URL**.

![](../img/9.sso_3.png)

3) Click the **Link** to open the enterprise account login page.

![](../img/03_authing_13.png)

4) Enter the enterprise-wide email (configured email address in Keycloak and Guance SSO management) and password.

![](../img/4.keycloak_9.1.png)

5) Log in to the corresponding workspace in Guance.

**Note**: If multiple workspaces are configured with the same identity provider SSO single sign-on, users can switch between different workspaces after logging in via SSO by clicking the workspace option in the top-left corner of Guance.

![](../img/1.sso_okta_23.png)