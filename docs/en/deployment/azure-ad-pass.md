# Azure AD Single Sign-On (Deployment Plan)
---

Azure Active Directory (Azure AD) is a cloud-based identity and access management service introduced by Microsoft to help enterprises manage internal and external resources.

## I. Obtaining Key Configuration Information for Single Sign-On

To enable single sign-on with <<< custom_key.brand_name >>> Deployment Plan via Azure AD, three key configuration pieces are required:

| Configuration      | Description                          |
| ----------- | ------------------------------------ |
| wellKnowURL      | The OIDC Endpoints configuration URL for the application, i.e., the complete `https://xxx.xxx.com/xx/.well-known/openid-configuration` address.                          |
| clientSecret      | Client secret value.                          |
| clientId      | Application (client) ID                    |

### 1. Creating an Azure AD Application

1) Create an Azure account on the Microsoft portal.

Go to the [Azure Active Directory Admin Center](https://portal.azure.com/) and click **View > App Registrations** under Azure Active Directory management:

![](img/aad-1.png)

On the **App Registrations** page, click **New Registration**:

![](img/aad-2.png)

2) Register a new application

On the **Register an Application** page, enter a **Name**. Supported account types should be set to **Any organization directory**, and Redirect URI should be selected as **Web**. Click **Register** to create a new application. As shown in the following figure, name this application "<<< custom_key.brand_name >>> Deployment Plan".

![](img/aad-3.png)

### 2. Completing Basic Configuration for the New Application

1) After creating the new application, you will default to the **Overview** page. You can view the applications you have created under **App Registrations > All Applications**.

![](img/aad-4.png)

**Note:** The **Application (client) ID** here is the `clientId` for OIDC client configuration.

2) Add client credentials:

![](img/aad-5-1.png)

![](img/aad-5.png)

![](img/aad-5-2.png)

**Note:** The **Value** listed here is the `clientSecret` for OIDC client configuration. Please save it immediately!

3) Go to the **Token Configuration > Add Optional Claims** page and add a group claim. After adding, a `groups` record will be generated.

![](img/aad-5-3-1.png)

Additionally, select the illustrated claims for both **ID** and **Access** token types so that the logging client can obtain relevant token data.

![](img/aad-5-3.png)

![](img/aad-5-3-2.png)

4) Add API scopes. Enter **Exposed APIs** and add the following scopes: `User.Read`, `User.Read.All`, `GroupMember.Read.All`, `Group.Read.All`. Click **Add Scope** to expose these four permissions for the current application client.

![](img/aad-5-4.png)

![](img/aad-5-5.png)

5) After adding the four scopes, grant permissions to the client application. Enter **API Permissions**:

- First, choose Microsoft API permissions:

![](img/aad-5-6.png)

- Then select the permissions required by the application:

![](img/aad-5-6-1.png)

You need to consent to authorize on behalf of the tenant administrator:

![](img/aad-5-6-2.png)

**Note:** The client ID is the **Application (client) ID**.

### 3. Obtain the OIDC Protocol Endpoint Access Address Information

In **App Registrations > Endpoints**, the WellKnowURL for OIDC client configuration is: `https://login.microsoftonline.com/consumers/v2.0/.well-known/openid-configuration`.

![](img/aad-5-7.png)

> For more information about OpenID configuration document URIs, visit [OpenID Connect on Microsoft Identity Platform](https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-protocols-oidc).

<font color=coral>To this point, the three key configuration pieces have been obtained.</font>

## II. Configuring User Groups within the Azure AD Application

![](img/aad-11.png)

1) Return to the home page and go to **Groups > New Group**;

![](img/aad-12.png)

2) Choose **Group Type**:

- Security: Used for managing access permissions for users and computers to shared resources.
- Microsoft 365: Provides collaboration opportunities by granting members access to shared mailboxes, calendars, files, SharePoint sites, etc.

3) Enter a **Group Name** and optionally add a group description;

4) Add **Owners** or **Members**:

- Select the link under "Owners" or "Members" to populate the list of each user from the directory;
- Choose users from the list and click the "Select" button at the bottom of the window.

5) Click **Create**.

![](img/aad-13.png)

## III. Setting Up Enterprise Application Configuration

1. Go to your application and select **Overview > Self-service**.

![](img/aad-19.png)

2. Enable users to request access to this application and decide which group to add assigned users to.

![](img/aad-20.png)

3. Under your **Application > Users and Groups**, add groups and users who need to log in.

![](img/aad-21.png)

4. Under your **Application > Single Sign-On**, you can see `groups` attribute claims.

![](img/aad-22.png)

## IV. Configuring Association in <<< custom_key.brand_name >>> Launcher {#config}

1) Configure Azure AD basic information in <<< custom_key.brand_name >>> Launcher **Namespace: forethought-core > core**.

```
# OIDC client configuration (when wellKnowURL is configured, KeyCloakPassSet configuration item becomes invalid automatically)
OIDCClientSet:
  # OIDC Endpoints configuration URL, i.e., the complete `https://xxx.xxx.com/xx/.well-known/openid-configuration` address.
  wellKnowURL:
  # Client ID provided by the authentication service
  clientId:
  # Client's Secret key
  clientSecret:
  # Authentication method, currently only supports authorization_code
  grantType: authorization_code
  # Certificate verification switch in requests
  verify: false
  # List of certificate paths, enter .crt and .key file paths sequentially
  cert:
  # Method to get token interface authentication: basic: located in the Authorization header; post_body: located in the request body
  fetchTokenVerifyMethod: basic
  # Data access scope
  scope: "openid profile email address"
  # 【Internal configuration users do not need to adjust】Callback URL after successful authentication by the authentication server
  innerUrl: "{}://{}/oidc/callback"
  # 【Internal configuration users do not need to adjust】After successful authentication and callback by the DF system, the URL where the DF system redirects the user to the front-end dedicated page
  frontUrl: "{}://{}/tomiddlepage?uuid={}"
  # Mapping configuration between account information from the authentication service and DF system account information fields. Required fields are: username, email, exterId; Optional field is: mobile
  mapping:
    # Username field name in the authentication service, required. If the value does not exist, take the email
    username: preferred_username
    # Email field name in the authentication service, required
    email: email
    # Phone number field name in the authentication service, optional
    mobile: phone_number
    # Unique identifier field name in the authentication service, required
    exterId: sub
```

Refer to the example image:

![](img/aad-14.png)

???+ abstract "**Client ID** and **Client Secret Value** can be obtained from the positions shown in the following images"

    ![](img/aad-15.png)

    ![](img/aad-16.png)

2) Configure redirection information in <<< custom_key.brand_name >>> Launcher **Namespace: forethought-webclient > frontNginx**.

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
         
        # =========OIDC protocol redirection related configuration starts=========
        # Request directly redirects to Inner API endpoint =========starts=========
        # This address is used for third-party login access; it can be changed as needed, but the proxy_pass route address cannot be changed
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
         
        # This address is used for callback to this service after third-party services authenticate through OIDC protocol; this address is directly associated with the innerUrl configuration item under OIDCClientSet in section 【3.2.1】; when changing this address, ensure it is synchronized with innerUrl; the proxy_pass value cannot be changed
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
       # =========OIDC protocol redirection related configuration ends=========
}
```

Refer to the example image:

![](img/aad-17.png)

3) Configure the entry URL for Azure AD user login to <<< custom_key.brand_name >>> Deployment Plan in <<< custom_key.brand_name >>> Launcher **Namespace: forethought-webclient > frontWeb**.

```
window.DEPLOYCONFIG = {
 
    ......
    paasCustomLoginInfo:[
        { "iconUrl":"xxx", "label": "xxx", "url": "xxxx" ,desc:"xxx"}
    ]
     
    ......
 
};
```

**Note:** The `server_name` is the domain name in the <<< custom_key.brand_name >>> login page URL.

Refer to the example image:

![](img/aad-18.png)

1) After completing the configuration, check the updated **Modify Configuration** and confirm the restart.

![](img/1.keycloak_6.png)

## V. Using Azure AD Account for Single Sign-On to <<< custom_key.brand_name >>>

After all configurations are completed, you can use single sign-on to <<< custom_key.brand_name >>>.

1) Open the <<< custom_key.brand_name >>> Deployment Plan login URL, and on the login page, select **Azure AD Single Sign-On**.

2) Enter the email address configured in Azure AD.

3) Update the login password.

4) Log in to the corresponding workspace in <<< custom_key.brand_name >>>.

???+ warning

    - If prompted with "The current account is not part of any workspace, please go to the admin backend to add the account to a workspace.", you need to log into the <<< custom_key.brand_name >>> admin backend to add the user to a workspace.

    > For more details, refer to [Workspace Management in Deployment Plan](space.md).
 
    ![](img/1.keycloak_15.png)

    After adding the workspace for the user in the <<< custom_key.brand_name >>> admin backend, the user can start using <<< custom_key.brand_name >>>.

![](img/1.keycloak_14.png)

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Single Sign-On with Keycloak Accounts via OpenID Connect <<< custom_key.brand_name >>>**</font>](./keycloak-sso.md)

</div>