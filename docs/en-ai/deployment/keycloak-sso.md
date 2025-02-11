# Keycloak Single Sign-On (Deployment Plan)
---

## Introduction

The Deployment Plan of Guance supports single sign-on using both OpenID Connect and OAuth 2.0 protocols. This article will use Keycloak login as an example for explanation.

Keycloak is an open-source solution for identity authentication and access control for modern applications and distributed services. The Deployment Plan of Guance, based on the OpenID Connect protocol, enables enterprise Keycloak accounts to single sign-on into the Guance platform to access corresponding workspace resources without creating separate Guance accounts for enterprises/teams.

**Note:** This article applies to users of the OpenID Connect protocol with Keycloak version 18.0.2 or lower.

## Concept Overview

| Term      | Explanation                          |
| ----------- | ------------------------------------ |
| Realm       | A realm, similar to a workspace, used to manage users, credentials, roles, and user groups, with isolation between realms.  |
| Clients       | Applications or services that can request Keycloak to authenticate users. |
| Users    | User accounts that can log in to the system, requiring configuration of login email and Credentials. |
| Credentials      | Credentials used to verify user identity, such as setting up user account login passwords.                          |
| Authentication      | The process of identifying and verifying users.                          |
| Authorization      | The process of granting users access permissions.                          |
| Roles      | Used to identify user types, such as administrators, regular users, etc.                          |
| User Role Mapping      | The mapping relationship between users and roles, allowing one user to be associated with multiple roles.                          |
| Groups      | Managing user groups, supporting role mappings to groups.                          |

## Steps {#steps}

### 1. Create a Keycloak Realm

> Note: Keycloak has a master domain (Master). We need to create a new realm (similar to a workspace).

1) In the Keycloak admin console, click **Master > Add realm**.

![](img/05_keycloak_02.png)

2) On the **Add realm** page, enter the realm name in the **Name** field, such as "gcy", and click **Create** to create a new realm.

![](img/05_keycloak_03.png)

### 2. Create a Client and Configure openid-connect Protocol

> Note: This step involves creating a Keycloak client and configuring the openid-connect protocol to establish a trust relationship between Keycloak and Guance.

1) Under the newly created "gcy" realm, click **Client**, then **Create** on the right side.

![](img/05_keycloak_04.png)

2) On the **Add Client** page, fill in the following details and click **Save**.

![](img/1.keycloak_1.png)

After creating the client, configure it as shown in the screenshot below, then click **Save**.

- Client Protocol: openid-connect
- Access Type: confidential
- Standard Flow Enabled: ON
- Direct Access Grants Enabled: ON
- Service Accounts Enabled: ON
- Valid Redirect URIs: *

![](img/1.keycloak_2.png)

### 3. [Configure Keycloak Users](./keycloak-rule.md#new)

### 4. Guance Launcher Configuration {#config}

1) Configure Keycloak's basic information in the Guance Launcher **namespace: forethought-core > core**.

```

# OIDC client configuration (when wellKnowURL is configured in this item, the KeyCloakPassSet configuration item automatically becomes invalid)
OIDCClientSet:
  # OIDC Endpoints configuration URL, i.e., the complete `https://xxx.xxx.com/xx/.well-known/openid-configuration` URL.
  wellKnowURL:
  # Client ID provided by the authentication service
  clientId:
  # Client Secret key
  clientSecret:
  # Authentication method, currently only supports authorization_code
  grantType: authorization_code
  verify: false
  # Data access scope
  scope: "openid profile email address"
  # Callback URL after successful authentication by the authentication server
  innerUrl: "{}://{}/oidc/callback"
  # URL where DF system redirects after receiving user information from the authentication service
  frontUrl: "{}://{}/tomiddlepage?uuid={}"
  # Mapping configuration between account information obtained from the authentication service and DF system accounts, required fields are: username, email, exterId
  mapping:
    # Username of the login account in the authentication service, required, if not present, defaults to email
    username: preferred_username
    # Email of the login account in the authentication service, required
    email: email
    # Mobile number field name of the login account in the authentication service, optional
    mobile: phone_number
    # Unique identifier of the login account in the authentication service, required
    exterId: sub
```

Refer to the example image:

![](img/1.keycloak_3_2_3.png)

The "wellKnowURL:" in the above example image can be obtained from **Realm Settings > General > Endpoints**.

![](img/1.keycloak_3_2_0.png)
or 
![](img/1.keycloak_3_2_1.png)

The "clientSecret:" in the example image can be obtained from **Client > Client ID (e.g., Guance) > Credentials**.

![](img/1.keycloak_3.2.png)

2) Configure redirect information in the Guance Launcher **namespace: forethought-webclient > frontNginx**.

```
        # =========OIDC protocol related redirect configurations start=========
        # Request directly redirected to Inner API interface =========start=========
        # This URL is used for third-party login access; you can change it as needed, but the proxy_pass route URL must remain unchanged
        location /oidc/login {
            proxy_connect_timeout 5;
            proxy_send_timeout 5;
            proxy_read_timeout 300;
            proxy_http_version 1.1;
            proxy_set_header Connection "keep-alive";
            add_header Access-Control-Allow-Origin *;
            add_header Access-Control-Allow-Headers X-Requested-With;
            add_header Access-Control-Allow-Methods GET,POST,OPTIONS;
            proxy_pass http://inner.forethought-core:5000/api/v1/inner/oidc/login;
        }
         
        # This URL is used for callback after successful OIDC protocol authentication by third-party services; this URL should be synchronized with the innerUrl configuration under OIDCClientSet in section 【3.2.1】; the proxy_pass value cannot be changed
        location /oidc/callback {
            proxy_connect_timeout 5;
            proxy_send_timeout 5;
            proxy_read_timeout 300;
            proxy_http_version 1.1;
            proxy_set_header Connection "keep-alive";
            add_header Access-Control-Allow-Origin *;
            add_header Access-Control-Allow-Headers X-Requested-With;
            add_header Access-Control-Allow-Methods GET,POST,OPTIONS;
            proxy_pass http://inner.forethought-core:5000/api/v1/inner/oidc/callback;
       }
       # =========OIDC protocol related redirect configurations end=========
```

Refer to the example image:

![](img/1.keycloak_4.1.png)

3) Configure the entry URL for Keycloak users logging into the Guance Deployment Plan in the Guance Launcher **namespace: forethought-webclient > frontWeb**.

```
window.DEPLOYCONFIG = {
 
    ......

    paasCustomLoginInfo:[
        {url:"http://<Guance deployment domain>/oidc/login",label:"Keycloak Login"}
    ],
    paasCustomLoginUrl: "https://<customer-provided logout URL>?redirect_url=https://<Guance Web login domain>/oidc/login"
     
     
    ......
 
};
```

Refer to the example image:

![](img/1.keycloak_5.1.png)

4) After completing the configuration, check the updated **Modify Configuration** and confirm the restart.

![](img/1.keycloak_6.png)

### 5. Using Keycloak Accounts to Single Sign-On into Guance

After all configurations are completed, you can use single sign-on to access Guance.

1) Open the login URL of the Guance Deployment Plan and select **Keycloak Single Sign-On** on the login page.

![](img/1.keycloak_10.png)

2) Enter the email address configured in Keycloak.

![](img/1.keycloak_11.png)

3) Update the login password.

![](img/1.keycloak_12.png)

4) Log in to the corresponding workspace in Guance.

???+ warning

    - If prompted with "This account is not part of any workspace, please go to the management backend to add this account to a workspace.", you need to log in to the Guance management backend to add the user to a workspace.

    > For more details, refer to the [Deployment Plan Workspace Management](space.md) documentation.
 
    ![](img/1.keycloak_15.png)

    After adding the user to a workspace in the Guance management backend, the user can start using Guance.

![](img/1.keycloak_14.png)