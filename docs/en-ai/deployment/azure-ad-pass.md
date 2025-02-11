# Azure AD Single Sign-On (Deployment Plan)
---

Azure Active Directory (Azure AD) is a cloud-based identity and access management service introduced by Microsoft, which helps enterprises manage internal and external resources.

## I. Obtain Key Configuration Information for Single Sign-On

To use single sign-on with Guance Deployment Plan via Azure AD, three key configuration details are required:

| Configuration      | Description                          |
| ----------- | ------------------------------------ |
| wellKnowURL      | The OIDC Endpoints configuration URL for the application, i.e., the complete `https://xxx.xxx.com/xx/.well-known/openid-configuration` address.                          |
| clientSecret      | Client secret value.                          |
| clientId      | Application (client) ID                    |

### 1. Create an Azure AD Application

1) Create an Azure account on the Microsoft portal.

Go to the [Azure Active Directory Admin Center](https://portal.azure.com/) and click **View > App registrations** under Azure Active Directory management:

![](img/aad-1.png)

On the **App registrations** page, click **New registration**:

![](img/aad-2.png)

2) Register a new application

On the **Register an application** page, enter a **Name**. Supported account types should be set to **Any organization directory**, and the redirect URI should be selected as **Web**. Click **Register** to create a new application. As shown in the figure below, name this application "Guance Deployment Plan".

![](img/aad-3.png)

### 2. Complete Basic Configuration of the New Application

1) After creating the new application, you will default to the **Overview** page. You can view the created application under **App registrations > All applications**.

![](img/aad-4.png)

**Note:** The **Application (client) ID** here is the same as the `clientId` in the OIDC client configuration.

2) Add client credentials:

![](img/aad-5-1.png)

![](img/aad-5.png)

![](img/aad-5-2.png)

**Note:** The **Value** listed here is the `clientSecret` value in the OIDC client configuration, save it immediately!

3) Go to the **Token configuration > Add optional claims** page and add a group claim. After adding, a `groups` record will be generated.

![](img/aad-5-3-1.png)

Additionally, select the indicated claims for both **ID** and **Access** token types so that the logging-in client can obtain the relevant token data.

![](img/aad-5-3.png)

![](img/aad-5-3-2.png)

4) Add API scopes. Go to **Expose an API** and add the following scopes: `User.Read`, `User.Read.All`, `GroupMember.Read.All`, `Group.Read.All`. Click **Add scope** to expose these four permissions for the current application client:

![](img/aad-5-4.png)

![](img/aad-5-5.png)

5) After adding the four scopes, add authorization for the client application. Go to **API permissions**:

- First, select Microsoft API permissions:

![](img/aad-5-6.png)

- Then choose the necessary permissions for your application:

![](img/aad-5-6-1.png)

You need to consent on behalf of the tenant administrator:

![](img/aad-5-6-2.png)

**Note:** The client ID is the same as the **Application (client) ID**.

### 3. Obtain the OIDC Protocol Endpoint Access Address Information

In **App registrations > Endpoints**, the WellKnowURL in the OIDC client configuration should be set to: `https://login.microsoftonline.com/consumers/v2.0/.well-known/openid-configuration`.

![](img/aad-5-7.png)

> For more information about OpenID configuration document URIs, refer to [OpenID Connect on the Microsoft Identity Platform](https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-protocols-oidc).

<font color=coral>To this point, the three key configuration details have been obtained.</font>

## II. Configure User Groups within the Azure AD Application

![](img/aad-11.png)

1) Return to the home page and go to **Groups > New group**;

![](img/aad-12.png)

2) Select **Group type**:

- Security: Used to manage user and computer access to shared resources.
- Microsoft 365: Provides collaboration opportunities by granting members access to shared mailboxes, calendars, files, SharePoint sites, etc.

3) Enter a **Group name** and optionally add a group description.

4) Add **Owners** or **Members**:
  
- Choose the link under "Owners" or "Members" to populate the list of users from the directory;
- Select users from the list and click the "Select" button at the bottom of the window.

4) Click **Create**.

![](img/aad-13.png)

## III. Configure Enterprise Application Settings

1. In your application, select **Overview > Self-service**.

![](img/aad-19.png)

2. Enable users to request access to this application and decide which group to add assigned users to.

![](img/aad-20.png)

3. Under **Users and groups** in your application, add the groups and users who need to log in.

![](img/aad-21.png)

4. Under **Single sign-on** in your application, you can see the `groups` attribute claim.

![](img/aad-22.png)

## IV. Configure Association in Guance Launcher {#config}

1) In the Guance Launcher **namespace: forethought-core > core**, configure the basic information for Azure AD.

```
# OIDC client configuration (when wellKnowURL is configured in this section, the KeyCloakPassSet configuration item automatically becomes invalid)
OIDCClientSet:
  # OIDC Endpoints configuration URL, i.e., the complete `https://xxx.xxx.com/xx/.well-known/openid-configuration` address.
  wellKnowURL:
  # Client ID provided by the authentication service
  clientId:
  # Client secret key
  clientSecret:
  # Authentication method, currently only supports authorization_code
  grantType: authorization_code
  # SSL certificate verification switch in requests
  verify: false
  # List of certificate paths, fill in .crt and .key file paths sequentially
  cert:
  # Method to obtain token interface authentication: basic - in the Authorization header; post_body - in the request body
  fetchTokenVerifyMethod: basic
  # Data access scope
  scope: "openid profile email address"
  # [Internal configuration users do not need to adjust] Callback URL after successful authentication by the authentication server
  innerUrl: "{}://{}/oidc/callback"
  # [Internal configuration users do not need to adjust] Redirect URL to the front-end dedicated page after DF system receives user information
  frontUrl: "{}://{}/tomiddlepage?uuid={}"
  # Mapping configuration between account information from the authentication service and DF system account information fields, required fields are: username, email, exterId; optional field is: mobile
  mapping:
    # Username field name in the authentication service, required, if the value does not exist, it defaults to email
    username: preferred_username
    # Email field name in the authentication service, required
    email: email
    # Phone number field name in the authentication service, optional
    mobile: phone_number
    # Unique identifier field name in the authentication service, required
    exterId: sub
```

Reference diagram:

![](img/aad-14.png)

???+ abstract "**Client ID** and **Client Secret Value** can be obtained from the positions shown in the following images"

    ![](img/aad-15.png)

    ![](img/aad-16.png)


2) In the Guance Launcher **namespace: forethought-webclient > frontNginx**, configure the redirection settings.

```
server {
        listen 80;
        # Note, the server_name service name is the domain name of the frontend access address
        server_name cloudcare.cn, daily-ft2x.cloudcare.cn;
        location / {
           root /config/cloudcare-forethought-webclient;
           index index.html;
           try_files $uri $uri/ /index.html;
           if ($request_filename ~* .*\.(?:htm|html)$)
            {
                add_header Cache-Control "no-cache, no-store";
            }
        }
         
        # =========OIDC protocol redirection configuration starts=========
        # Request directly redirects to Inner API endpoint ==========start==========
        # This address is used for third-party login access; change as needed but do not alter the proxy_pass route
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
         
        # This address is used for callback to this service after successful OIDC protocol authentication by third-party services; this address is directly associated with the innerUrl configuration item under OIDCClientSet in [3.2.1]; when changing this address, synchronize changes with innerUrl; do not alter the proxy_pass value
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
       # =========OIDC protocol redirection configuration ends=========
}
```

Reference diagram:

![](img/aad-17.png)

3) In the Guance Launcher **namespace: forethought-webclient > frontWeb**, configure the entry URL for Azure AD users to log into the Guance Deployment Plan.

```
window.DEPLOYCONFIG = {
 
    ......
    paasCustomLoginInfo:[
        { "iconUrl":"xxx", "label": "xxx", "url": "xxxx" ,desc:"xxx"}
    ]
     
    ......
 
};
```

**Note**: `server_name` is the domain name in the Guance login page URL.

Reference diagram:

![](img/aad-18.png)

1) After completing the configuration, check the updated **Modify Configuration** and confirm the restart.

![](img/1.keycloak_6.png)

## V. Use Azure AD Account to Single Sign-On to Guance

After all configurations are completed, you can use single sign-on to access Guance.

1) Open the login URL for the Guance Deployment Plan, and on the login page, select **Azure AD Single Sign-On**.

2) Enter the email address configured in Azure AD.

3) Update the login password.

4) Log in to the corresponding workspace in Guance.

???+ warning

    - If prompted with "The current account is not part of any workspace, please go to the admin backend to add this account to a workspace," you need to log in to the Guance admin backend and add the user to a workspace.

    > For more details, refer to [Workspace Management for Deployment Plan](space.md).
 
    ![](img/1.keycloak_15.png)

    After adding the user to a workspace in the Guance admin backend, the user can start using Guance.

![](img/1.keycloak_14.png)

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Single Sign-On to Guance Using Keycloak Accounts Based on the OpenID Connect Protocol**</font>](./keycloak-sso.md)

</div>