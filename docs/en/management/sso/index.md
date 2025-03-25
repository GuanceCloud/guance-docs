# SSO Management
---

<<< custom_key.brand_name >>> supports SSO management based on SAML, OIDC/ Oauth2.0 protocols, allowing enterprises to manage employee information in their local IdP (identity provider). There is no need for user synchronization between <<< custom_key.brand_name >>> and the enterprise's IdP, and enterprise employees can log in and access <<< custom_key.brand_name >>> with specified roles.

In SSO Management, you can:

- [Configure single sign-on based on corporate domain](#corporate)
- [Configure a more refined single sign-on scheme based on corporate domain with role mapping enabled](#saml-mapping)

## User SSO {#corporate}

<<< custom_key.brand_name >>> supports single sign-on configuration based on corporate domains. As long as an employee’s email matches the unified identity authentication domain suffix of the company, they can directly log in to <<< custom_key.brand_name >>> via this email and access the system according to the configured permissions.

1. Navigate to **Management > Member Management > SSO Management > User SSO**;
2. Select [SAML](#saml) or [OIDC](#oidc) as needed;
3. Start configuring.

???+ warning "Note"

    - You can create multiple SSO IDP configurations; each workspace SSO configuration is limited to no more than 10;
    - If multiple workspaces are simultaneously configured with the same identity provider SSO single sign-on, users can log in via SSO to the workspace and switch between different workspaces by clicking the workspace option in the top-left corner to view data.


### SAML {#saml}

![](../img/5.sso_mapping_7.png)

| Input Field      | Description                          |
| ----------- | ------------------------------------ |
| Identity Provider      | Platform that provides identity management services for managing user identities and authentication information. Define the name here.                          |
| Metadata Document       | XML document provided by the IdP (identity provider). |
| Notes       | Custom-added descriptive information used to record relevant explanations about the identity provider.  |
| Access Restrictions    | Verifies whether the login email domain suffix matches the configured domain. Only matching emails have permission to access the SSO login link. User accounts can be dynamically created upon first login without needing to be pre-created in the workspace. |
| Role Authorization       | Assign roles to SSO accounts logging in for the first time; accounts logging in subsequently are unaffected.<br/>:warning: If [SAML Mapping](#saml-mapping) is enabled within the workspace, roles will be assigned according to the mapping rules with priority.<br/>For details on role permissions, refer to [Role Management](../role-management.md).  |
| [Session Persistence](#login-hold-time)       | Set the idle persistence time and maximum persistence time for SSO login sessions. Sessions will expire after the timeout period.  |


#### Obtain Entity ID and Assertion Address {#obtain}

After successfully adding the identity provider, click the **Update** button on the right side to obtain the **Entity ID** and **Assertion Address**, then complete the corresponding SAML configuration according to the requirements of the identity provider.

| Field      | Description                  |
| ----------- | ------------------- |
| Login Address       | <<< custom_key.brand_name >>> SSO login address generated from the metadata document uploaded by the user. Each login address is limited to accessing one workspace.  |
| Metadata      | <<< custom_key.brand_name >>> SSO metadata file generated from the metadata document uploaded by the user.                  |
| Entity ID      | <<< custom_key.brand_name >>> SSO login entity ID generated from the metadata document uploaded by the user. Used to identify the service provider (SP) in the identity provider (IdP), such as << custom_key.brand_name >>>.    |
| Assertion Address      | <<< custom_key.brand_name >>> SSO login assertion target address generated from the metadata document uploaded by the user. Used by the identity provider (IdP) to call and complete single sign-on.                  |


![](../img/5.sso_mapping_8.png)

#### Session Persistence {#login-hold-time}

When configuring SSO single sign-on, you can set a uniform login persistence time for enterprise members logging in via SSO, including "idle session persistence time" and "maximum session persistence time."

- Idle session persistence time: Supported range is 180～1440 minutes, default value is 180 minutes.
- Maximum session persistence time: Supported range is 0～7 days, where 0 indicates never expiring, default value is 7 days.

???+ abstract "Example Explanation"

    After updating the SSO login persistence time:

    - Already logged-in members: Their login session expiration time remains unchanged.
    - Newly logged-in members: The latest login persistence time settings take effect.

    For example:
    - Initially, when configuring SSO, the idle session expiration time was set to 30 minutes. Member A logs in at this point, and their idle session expiration time is 30 minutes.
    - The administrator subsequently updates the idle session expiration time to 60 minutes. Member A's idle session expiration time remains 30 minutes, while Member B, who logs in afterward, will have an idle session expiration time of 60 minutes, and so on.

### OIDC {#oidc}

Navigate to **Management > Member Management > SSO Management > OIDC > Create Identity Provider**, which defaults to **standard OIDC configuration**. If you are not using a standard OIDC configuration, you can [switch pages to configure](#non-standard).

![](../img/oidc.png)

#### Connection Configuration

![](../img/oidc-1.png)

| Input Field      | Description                          |
| ----------- | ------------------------------------ |
| Identity Provider Name      | Name of the platform providing identity management services.                          |
| Notes       | Custom-added descriptive information used to record relevant explanations about the identity provider.  |
| Identity Provider URL       | Full URL of the identity provider, also the service discovery address. For example: https://guance.example.com<br/>Note: If the link cannot be accessed, check the legality of the URL or try again later. |
| Client ID    | Unique identifier provided by the authentication service to identify the client application. |
| Client Secret       | Used together with the client ID to authenticate the client application.  |
| Authorization Request Scope      | Scope of the authorization request. Defaults include `openid`, `profile`, and `email`. You can add additional claims like `address` and `phone` as needed.|


#### Mapping Configuration

To achieve SSO login, it is necessary to map the account information from the identity provider (IdP) to the <<< custom_key.brand_name >>> account information. The main fields are as follows:

<img src="../img/oidc-2.png" width="70%" >

1. Username: Required; the "username" field from the identity provider, for example `referred_username`;
2. Email: Required; the "email" field from the identity provider, for example `email`;
3. Phone Number: Optional; the "phone number" field from the identity provider, for example `phone`.

#### Login Configuration

<img src="../img/oidc-3.png" width="70%" >

| Field      | Description                          |
| ----------- | -------------------------- |
| Access Restrictions    | Verifies whether the login email domain suffix matches the configured domain. Only matching emails have permission to access the SSO login link. User accounts can be dynamically created upon first login without needing to be pre-created in the workspace. |
| Role Authorization       | Assign roles to SSO accounts logging in for the first time; accounts logging in subsequently are unaffected.<br/>:warning: If [Role Mapping](#saml-mapping) is enabled within the workspace, roles will be assigned according to the mapping rules with priority.<br/>For details on role permissions, refer to [Role Management](../role-management.md).  |
| [Session Persistence](#login-hold-time)       | Set the idle persistence time and maximum persistence time for SSO login sessions. Sessions will expire after the timeout period.  |


???- abstract "User-side OIDC Configuration Considerations"

    1. Authorization Mode: Only supports `authorization_code` authorization mode; its return type must be `code`;
    2. `id_token` Signature Algorithm: Currently only supports `HS256`;
    3. `code` Exchange `token` Authentication Method:

        - Default support: `client_secret_basic`
        - Custom method support: `client_secret_post`, `client_secret_basic`, `none`

    4. `scope` Scope:
        - Default scope: openid profile email phone

        - Custom requirement: Must include `openid`, others can be customized, but the returned result must contain `email`, optionally returning `phone_number`.


### Non-Standard OIDC Configuration {#non-standard}

???- abstract "Understanding Non-Standard OIDC Configuration?"

    Non-standard configuration usually occurs because the customer uses Oauth2 for identity authentication. However, the Oauth2 protocol does not specify an **interface for obtaining account information**, leading to significant differences in this step since successful mapping depends on this information. Additionally, due to inconsistent interface design rules among customers, there may be discrepancies in the **case style of parameters**, making it non-standard.

1. Navigate to **Management > Member Management > SSO Management > OIDC > Create Identity Provider**;
2. Click the upper-right corner to switch into the standard OIDC configuration page:

<img src="../img/oidc-5.png" width="70%" >

![](../img/oidc-4.png)

#### Connection Configuration

| Input Field      | Description                          |
| ----------- | ------------------------------------ |
| Identity Provider Name      | Name of the platform providing identity management services.                          |
| Configuration File Upload      | Download the template, fill in the relevant information, and upload it.                          |
| Notes       | Custom-added descriptive information used to record relevant explanations about the identity provider.  |

#### Login Configuration

| Input Field      | Description                          |
| ----------- | -------------------------- |
| Access Restrictions    | Verifies whether the login email domain suffix matches the configured domain. Only matching emails have permission to access the SSO login link. User accounts can be dynamically created upon first login without needing to be pre-created in the workspace. |
| Role Authorization       | Assign roles to SSO accounts logging in for the first time; accounts logging in subsequently are unaffected.<br/>:warning: If [Role Mapping](#saml-mapping) is enabled within the workspace, roles will be assigned according to the mapping rules with priority. Refer to [Role Management](../role-management.md) for detailed role permissions.  |
| [Session Persistence](#login-hold-time)       | Set the idle persistence time and maximum persistence time for SSO login sessions. Sessions will expire after the timeout period.  |

#### Obtain URLs

After successfully adding the identity provider, you can obtain the **Callback URL** and **Initiate Login URL**.

| Field      | Description                  |
| ----------- | ------------------- |
| Callback URL      | The callback address agreed upon in the OIDC protocol after authentication is successful, used to receive the authentication response from the identity provider.       |
| Initiate Login URL      | The entry address from <<< custom_key.brand_name >>> to start the OIDC login process, provided by the identity provider.     |

After obtaining these two URLs, provide them to the identity provider.

## SSO List

### Enable Role Mapping

You can enable or disable role mapping for a single identity provider (IDP):

- Enable role mapping:
    - SSO user accounts will be dynamically assigned roles based on the `attribute fields` and `attribute values` provided by the identity provider that match the role mapping rules.
    - If no role mapping rule is matched, the user account will be deprived of all roles and will not be able to log in to access the workspace.
- Disable role mapping: SSO login users will continue to retain previously assigned roles, unaffected by changes in assertions on the identity provider side.


### Enable/Update/Delete/Import/Export SSO

After adding an identity provider, you can enable or disable the current SSO configuration as needed. Once enabled, the following operations are supported:

- Update SSO configuration: Updates will affect the login experience of existing SSO members, so proceed with caution.
- Delete SSO configuration: Deletion will remove the current SSO configuration, and all related members will no longer be able to log in via this SSO configuration, so proceed with caution.
- Import/Export Identity Providers: Support importing and exporting identity provider configurations for quick replication across multiple workspaces.

**Note**:  

- When exporting files, the file name cannot be the same as any existing identity provider in the current workspace.
- Exported files must conform to JSON format standards.


### View SSO Members

- Member Count: Displays the total number of members who have logged in via SSO.  
- Member List: Clicking on the member count allows you to view the specific list of authorized SSO members.


## Login Verification {#login}

1. Email login to <<< custom_key.brand_name >>> SSO page: https://<<< custom_key.studio_main_site_auth >>>/login/sso;
2. Enter the email address configured during SSO creation to access all authorized workspaces under that identity provider;
3. Login address;
4. Enter username, password, etc.;
5. Login success.


<img src="../img/sso_login.png" width="70%" >


<img src="../img/sso_login_1.png" width="70%" >

???+ warning "Note"

    - If the workspace has enabled [role mapping](./role_mapping.md) but the current user does not match a role or the role mapping is disabled, a message indicating "no access permission" will appear;
    - If the workspace deletes the identity provider, users selecting SSO login will not see unauthorized workspaces.


## Email Notifications

When enabling, configuring, or deleting SSO, the Owner and Administrator of the workspace will receive relevant email notifications.

## Audit Events

Enabling, configuring, or deleting SSO operations will generate [audit](../operation-audit.md) events.



## SSO Configuration Examples

- [Alibaba Cloud IDaaS](aliyun-idaas.md)
- [Authing](authing.md)
- [Azure AD](azure-ad.md)
- [IAM Identity Center](./aws_iam_sso.md)
- [Okta](okta.md)
- [Keycloak](keycloak.md)