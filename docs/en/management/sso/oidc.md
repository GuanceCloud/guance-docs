# OIDC 
---


This section defaults to **standard OIDC Configuration**. If you are not using the standard OIDC configuration, you can [switch pages for configuration](#non-standard).

## Start Configuration

1. Identity Provider Name: The name of the platform providing identity management services.                          
2. Notes: Users can add custom descriptive information to record relevant explanations about the identity provider.  
3. Identity Provider URL: The full URL of the identity provider, which is also the service discovery address. For example: https://guance.example.com.
4. Client ID: A unique identifier provided by the authentication service, used to identify the client application. 
5. Client Secret: Used together with the Client ID to authenticate the client application.  
6. Authorization Request Scope: The scope of the authorization request. By default, it includes `openid`, `profile`, and `email`. You can optionally add `address` and `phone` claims.


### Mapping Configuration

To achieve SSO login, the account information from the Identity Provider (IdP) needs to be mapped to the <<< custom_key.brand_name >>> account information. The main fields are as follows:

1. Username: Required; the "username" field from the identity provider, for example `referred_username`;
2. Email: Required; the "email" field from the identity provider, for example `email`;
3. Phone Number: Optional; the "phone number" field from the identity provider, for example `phone`.

### Login Control {#login_config}


1. Access Restrictions: Verifies whether the domain suffix of the login email matches the configured domain. Only matching emails have permission to access the SSO login link. When users log in for the first time, a <<< custom_key.brand_name >>> member account can be dynamically created without needing to create it in advance within the workspace. 
2. Role Assignment: Assign roles to SSO accounts logging in for the first time; accounts logging in subsequently are unaffected.
    - If SAML mapping is enabled within the workspace, roles will be assigned based on the mapping rules.
3. [Session Persistence](./saml.md#login-hold-time): Set the idle persistence time and maximum persistence time for SSO login sessions.


???- abstract "User-side Configuration OIDC Related Considerations"

    - Authorization Mode: Only supports `authorization_code` authorization mode; its return type must be `code`;
    - `id_token` Signature Algorithm: Currently only supports `HS256`;
    - `code` Exchange `token` Authentication Method:

        - Default Supported: `client_secret_basic`  
        - Custom Methods Supported: `client_secret_post`, `client_secret_basic`, `none`

    - `scope` Range:  
        
        - Default Scope: `openid`, `profile`, `email`, `phone`

        - Custom Requirements: Must include `openid`, others can be customized, but the result must contain `email`, optionally return `phone_number`.


## Non-standard OIDC Configuration {#non-standard}

???- abstract "How to Understand Non-standard OIDC Configuration?"

    Non-standard configurations usually occur because customers use OAuth2 for identity authentication. However, the OAuth2 protocol does not specify an **interface for obtaining account information**, leading to significant differences in this step since successful mapping depends on this information. Additionally, due to differing interface design rules on the customer side, there may be inconsistencies in **parameter case styles**, making it non-standard.

1. Enter **Management > Member Management > SSO Management > OIDC > Create Identity Provider**;
2. Click the top-right corner to switch to the standard OIDC configuration page;
3. Identity Provider Name: The name of the platform providing identity management services;                            
4. Configuration File Upload: Download the template, fill in the relevant information, then upload;                            
5. Notes: Custom-added descriptive information used to record relevant explanations about the identity provider;  
6. [Login Configuration](#login_config).

<img src="../../img/oidc-5.png" width="70%" >

### Obtain URLs

After successfully adding the identity provider, you can obtain the **callback URL** and the **initiate login URL**.

| Field      | Description                  |
| ----------- | ------------------- |
| Callback URL      | The callback address agreed upon in the OIDC protocol after successful authentication, used to receive responses from the identity provider.       |
| Initiate Login URL      | The entry address to start the OIDC login process from the <<< custom_key.brand_name >>> side, provided by the identity provider.     |

After obtaining these two URLs, you need to provide them to the identity provider.