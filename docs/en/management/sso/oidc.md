# OIDC 
---


This section defaults to **standard OIDC Configuration**. If you are not using a standard OIDC configuration, you can [switch pages for configuration](#non-standard).

## Start Configuration

1. Identity Provider Name: The name of the platform providing identity management services.
2. Remarks: Users can add custom descriptive information to record relevant explanations about the identity provider.
3. Identity Provider URL: The full URL of the identity provider, which is also the service discovery address. For example: https://guance.example.com.
4. Client ID: A unique identifier provided by the authentication service used to identify client applications.
5. Client Secret: Used together with the Client ID to authenticate the client application.
6. Authorization Request Scope: The scope of the authorization request. By default, it includes `openid`, `profile`, and `email`. You can add additional claims such as `address` and `phone` if needed.


### Mapping Configuration

To implement SSO login, you need to map account information from the Identity Provider (IdP) to <<< custom_key.brand_name >>> account information. The main fields are as follows:

1. Username: Required; the "username" field from the identity provider, e.g., `referred_username`.
2. Email: Required; the "email" field from the identity provider, e.g., `email`.
3. Phone Number: Optional; the "phone number" field from the identity provider, e.g., `phone`.

### Login Control {#login_config}


1. Access Restrictions: Verifies whether the domain suffix of the login email matches the configured domain. Only matching emails will have access to the SSO login link. User accounts in <<< custom_key.brand_name >>> can be dynamically created during their first login without needing to be pre-created in the workspace.
2. Role Assignment: Assigns roles to SSO accounts logging in for the first time. Accounts logging in subsequently are unaffected.
    - If [SAML mapping](#saml-mapping) is enabled within the workspace, roles will be assigned based on the mapping rules.
3. [Session Persistence](./saml.md#login-hold-time): Sets the idle timeout and maximum duration for SSO login sessions. After timing out, the login session will expire.


???- abstract "User-side Configuration Notes for OIDC"

    - Authorization Mode: Only supports `authorization_code` authorization mode; its return type must be `code`.
    - `id_token` Signature Algorithm: Currently only supports `HS256`.
    - `code` Exchange `token` Authentication Method:

        - Default Support: `client_secret_basic`
        - Custom Methods Supported: `client_secret_post`, `client_secret_basic`, `none`

    - `scope` Range:
        
        - Default Scope: `openid`, `profile`, `email`, `phone`
        - Custom Requirements: Must include `openid`, others can be customized but the result must contain `email`, optionally returning `phone_number`.


## Non-standard OIDC Configuration {#non-standard}

???- abstract "Understanding Non-standard OIDC Configurations?"

    Non-standard configurations typically occur when customers use Oauth2 for identity authentication. However, the Oauth2 protocol does not specify an **interface for obtaining account information**, leading to significant differences in how user information is retrieved since successful mapping relationships depend on this step. Additionally, due to varying interface design rules across different customers, there may be inconsistencies in **parameter case styles**, which also leads to non-standard configurations.

1. Navigate to **Manage > Member Management > SSO Management > OIDC > Create Identity Provider**;
2. Click the top-right corner to switch to the standard OIDC configuration page;
3. Identity Provider Name: The name of the platform providing identity management services;
4. Configuration File Upload: Download the template, fill in the relevant information, and upload it;
5. Remarks: Custom-added descriptive information to record relevant explanations about the identity provider;
6. [Login Configuration](#login_config).

<img src="../img/oidc-5.png" width="70%" >

### Obtain URLs

After successfully adding an identity provider, you can obtain the **Callback URL** and the **Initiate Login URL**.

| Field      | Description                  |
| ----------- | ------------------- |
| Callback URL      | The callback address agreed upon in the OIDC protocol after successful authentication, used to receive the identity provider's authentication response.       |
| Initiate Login URL      | The entry point address for starting the OIDC login flow from <<< custom_key.brand_name >>>, provided by the identity provider.     |

After obtaining these two URLs, they need to be provided to the identity provider.