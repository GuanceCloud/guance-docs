# Keycloak Single Sign-On (Deployment Plan)
---

## Introduction

<<< custom_key.brand_name >>> Deployment Plan supports single sign-on methods based on the OpenID Connect and OAuth 2.0 protocols. This article will use Keycloak login as an example for explanation.

Keycloak is an open-source solution for identity authentication and access control for modern applications and distributed services. <<< custom_key.brand_name >>> Deployment Plan, based on the OpenID Connect protocol, enables enterprise Keycloak accounts to log into the <<< custom_key.brand_name >>> platform to access corresponding workspace resources without needing to create separate <<< custom_key.brand_name >>> accounts for enterprises/teams.

**Note:** This article applies to users of the OpenID Connect protocol and Keycloak version 18.0.2 or lower.

## Concepts

| Term      | Explanation                          |
| ----------- | ------------------------------------ |
| Realm       | A domain similar to a workspace used to manage users, credentials, roles, and user groups. Realms are isolated from each other.  |
| Clients       | Applications or services that can request Keycloak to authenticate users. |
| Users    | User accounts that can log into the system, requiring configuration of login email and credentials. |
| Credentials      | Credentials used to verify user identity, such as setting up login passwords for user accounts.                          |
| Authentication      | The process of identifying and verifying users.                          |
| Authorization      | The process of granting users access permissions.                          |
| Roles      | Used to identify user types, such as administrators, regular users, etc.                          |
| User role mapping      | The mapping relationship between users and roles, allowing one user to be associated with multiple roles.                          |
| Groups      | Managing user groups, supporting role mappings to groups.                          |

## Configuration Steps {#steps}

### 1. Create a Keycloak Realm

> **Note:** Keycloak has a master realm (Master). We need to create a new realm (similar to a workspace).

1) In the Keycloak admin console, click **Master > Add realm**.

![](img/05_keycloak_02.png)

2) On the **Add realm** page, enter a realm name in the **Name** field, such as “gcy”, and click **Create** to create a new realm.

![](img/05_keycloak_03.png)

### 2. Create a Client and Configure openid-connect Protocol

> **Note:** This step will create a Keycloak client and configure the openid-connect protocol to establish a trust relationship between Keycloak and <<< custom_key.brand_name >>>.

1) Under the newly created “gcy” realm, click **Client**, then click **Create** on the right side.

![](img/05_keycloak_04.png)

2) Fill out the **Add Client** form with the following details and click **Save**.

![](img/1.keycloak_1.png)

After creating the client, configure it according to the screenshot below and click **Save**:

- Client Protocol: openid-connect
- Access Type: confidential
- Standard Flow Enabled: ON
- Direct Access Grants Enabled: ON
- Service Accounts Enabled: ON
- Valid Redirect URIs: *

![](img/1.keycloak_2.png)

### 3. [Configure Keycloak Users](./keycloak-rule.md#new)

### 4. <<< custom_key.brand_name >>> Launcher Configuration {#config}

1) In the <<< custom_key.brand_name >>> Launcher **namespace: forethought-core > core**, configure the basic information of Keycloak.

```

# OIDC client configuration (if wellKnownURL is configured in this item, the KeyCloakPassSet configuration item automatically becomes invalid)
OIDCClientSet:
  # OIDC Endpoints configuration URL, i.e., the complete `https://xxx.xxx.com/xx/.well-known/openid-configuration` URL.
  wellKnowURL:
  # Client ID provided by the authentication service
  clientId:
  # Client's Secret key
  clientSecret:
  # Authentication method, currently only supports authorization_code
  grantType: authorization_code
  verify: false
  # Data access scope
  scope: "openid profile email address"
  # Callback URL after successful authentication by the authentication server
  innerUrl: "{}://{}/oidc/callback"
  # URL where the DF system redirects the user after obtaining user information from the authentication service
  frontUrl: "{}://{}/tomiddlepage?uuid={}"
  # Mapping configuration between account information obtained from the authentication service and DF system accounts, required fields include: username, email, exterId
  mapping:
    # Username of the login account from the authentication service, required; if not present, it defaults to email
    username: preferred_username
    # Email of the login account from the authentication service, required
    email: email
    # Phone number field name of the login account from the authentication service, optional
    mobile: phone_number
    # Unique identifier of the login account from the authentication service, required
    exterId: sub
```

Refer to the example image:

![](img/1.keycloak_3_2_3.png)

The “wellKnowURL:” in the above example image can be obtained from **Realm Settings > General > Endpoints**.

![](img/1.keycloak_3_2_0.png)
or 
![](img/1.keycloak_3_2_1.png)

The “clientSecret:” in the example image can be obtained from **Client > Client ID (e.g., Guance) > Credentials**.

![](img/1.keycloak_3.2.png)

2) In the <<< custom_key.brand_name >>> Launcher **namespace: forethought-webclient > frontNginx**, configure the redirection information.

```
        # =========OIDC Protocol Redirection Configuration Start=========
        # Request directly redirected to Inner API endpoint ==========Start=========
        # This address is used for third-party login access; adjust as needed, but do not change the proxy_pass route address
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
         
        # This address is used for callback after successful OIDC protocol authentication by third-party services; this address should be synchronized with the innerUrl configuration under OIDCClientSet in [3.2.1]; do not change the proxy_pass value
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
       # =========OIDC Protocol Redirection Configuration End=========
```

Refer to the example image:

![](img/1.keycloak_4.1.png)

3) In the <<< custom_key.brand_name >>> Launcher **namespace: forethought-webclient > frontWeb**, configure the entry URL for Keycloak users to log into <<< custom_key.brand_name >>> Deployment Plan.

```
window.DEPLOYCONFIG = {
 
    ......

    paasCustomLoginInfo:[
        {url:"http://<<< custom_key.brand_name >>> deployment domain/oidc/login", label:"Keycloak Login"}
    ],
    paasCustomLoginUrl: "https://<customer-provided logout URL>?redirect_url=https://<<< custom_key.brand_name >>> Web login domain/oidc/login"
     
     
    ......
 
};
```

Refer to the example image:

![](img/1.keycloak_5.1.png)

4) After completing the configuration, check the updated **Modify Configuration** option and confirm the restart.

![](img/1.keycloak_6.png)

### 5. Use Keycloak Account for Single Sign-On to <<< custom_key.brand_name >>>

After all configurations are completed, you can use single sign-on to <<< custom_key.brand_name >>>.

1) Open the <<< custom_key.brand_name >>> Deployment Plan login URL, and select **Keycloak Single Sign-On** on the login page.

![](img/1.keycloak_10.png)

2) Enter the email address configured in Keycloak.

![](img/1.keycloak_11.png)

3) Update the login password.

![](img/1.keycloak_12.png)

4) Log in to the corresponding workspace in <<< custom_key.brand_name >>>.

???+ warning

    - If prompted with "This account is not part of any workspace, please go to the management backend to add this account to a workspace.", you need to log into the <<< custom_key.brand_name >>> management backend to add the user to a workspace.

    > For more details, refer to the documentation [Workspace Management for Deployment Plan](space.md).
 
    ![](img/1.keycloak_15.png)

    After adding the workspace for the user in the <<< custom_key.brand_name >>> management backend, the user can start using <<< custom_key.brand_name >>>.

![](img/1.keycloak_14.png)