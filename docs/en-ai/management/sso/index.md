# SSO Management
---

<<< custom_key.brand_name >>> supports SSO management based on SAML, OIDC/Oauth2.0 protocols, allowing enterprises to manage employee information locally in their IdP (Identity Provider) without needing user synchronization between <<< custom_key.brand_name >>> and the enterprise IdP. Enterprise employees can log in and access <<< custom_key.brand_name >>> with specified roles.

In SSO management, you can:

- [Configure Single Sign-On Based on Corporate Domain](#corporate)
- [Configure More Precise Single Sign-On with Role Mapping Based on Corporate Domain](#saml-mapping)

## User SSO {#corporate}

<<< custom_key.brand_name >>> supports single sign-on configuration based on corporate domains. As long as an employee's email matches the domain suffix of the unified identity authentication, they can log in directly via that email and access the system according to the configured permissions.

1. Navigate to **Management > Member Management > SSO Management > User SSO**;
2. Select [SAML](#saml) or [OIDC](#oidc) as needed;
3. Start configuration.

???+ warning "Note"

    - Multiple SSO IDP configurations can be created, with a maximum of 10 configurations per workspace.
    - If multiple workspaces are configured with the same identity provider SSO login, users can switch between different workspaces by clicking the workspace option in the top-left corner after logging in via SSO.

### SAML {#saml}

![](../img/5.sso_mapping_7.png)

| Input Field | Description |
| ----------- | ----------- |
| Identity Provider | Platform providing identity management services to manage user identities and authentication information. Define the name here. |
| Metadata Document | XML document provided by the IdP (Identity Provider). |
| Remarks | Custom-added descriptive information for recording relevant explanations about the identity provider. |
| Access Restrictions | Verifies whether the login email domain suffix matches the configured domain. Only matching emails have permission to access the SSO login link. User accounts can be dynamically created during the first login without pre-creation in the workspace. |
| Role Authorization | Assign roles to SSO accounts logging in for the first time; existing accounts remain unaffected.<br/>:warning: If [SAML Mapping](#saml-mapping) is enabled in the workspace, roles will be assigned based on mapping rules.<br/>Refer to [Role Management](../role-management.md) for role permissions. |
| [Session Persistence](#login-hold-time) | Set inactive session persistence time and maximum session duration. Sessions expire after the timeout period. |

#### Obtain Entity ID and Assertion URL {#obtain}

After successfully adding the identity provider, click the **Update** button on the right to obtain the **Entity ID** and **Assertion URL**, which can then be used in the corresponding SAML configuration.

| Field | Description |
| ----------- | ----------- |
| Login URL | The <<< custom_key.brand_name >>> SSO login URL generated from the uploaded metadata document. Each login URL is limited to one workspace. |
| Metadata | The <<< custom_key.brand_name >>> SSO metadata file generated from the uploaded metadata document. |
| Entity ID | The <<< custom_key.brand_name >>> SSO login entity ID generated from the uploaded metadata document. Used to identify the service provider (SP) in the identity provider (IdP), e.g., <<< custom_key.brand_name >>>. |
| Assertion URL | The <<< custom_key.brand_name >>> SSO login assertion target URL generated from the uploaded metadata document. Used by the identity provider (IdP) to complete single sign-on. |

![](../img/5.sso_mapping_8.png)

#### Session Persistence {#login-hold-time}

When configuring SSO single sign-on, you can set a uniform login session duration for enterprise members who log in via SSO, including inactive session persistence time and maximum session duration.

- Inactive session persistence time: Supports setting within the range of 180 to 1440 minutes, defaulting to 180 minutes.
- Maximum session duration: Supports setting within the range of 0 to 7 days, where 0 indicates never expiring, defaulting to 7 days.

???+ abstract "Example Explanation"

    After updating the SSO login session duration:

    - Logged-in members: Their session expiration time remains unchanged.
    - New logins: Follow the latest session duration settings.

    For example:
    - Initially, the inactive session expiration time is set to 30 minutes. Member A logs in at this time and has an inactive session expiration time of 30 minutes.
    - The administrator subsequently updates the inactive session expiration time to 60 minutes. Member A’s inactive session expiration time remains 30 minutes, while member B, who logs in afterward, has an inactive session expiration time of 60 minutes, and so on.

### OIDC {#oidc}

Navigate to **Management > Member Management > SSO Management > OIDC > Create Identity Provider**, defaulting to **Standard OIDC Configuration**. If it is not a standard OIDC configuration, you can [switch pages for configuration](#non-standard).

![](../img/oidc.png)

#### Connection Configuration

![](../img/oidc-1.png)

| Input Field | Description |
| ----------- | ----------- |
| Identity Provider Name | Name of the platform providing identity management services. |
| Remarks | Custom-added descriptive information for recording relevant explanations about the identity provider. |
| Identity Provider URL | Full URL of the identity provider, also the service discovery address. For example: https://guance.example.com<br/>Note: If the link is inaccessible, check the URL's validity or try again later. |
| Client ID | Unique identifier provided by the authentication service to identify the client application. |
| Client Secret | Used with the client ID to authenticate the client application. |
| Authorization Request Scope | Authorization request scope. Defaults to `openid`, `profile`, and `email`. Additional claims like `address` and `phone` can be added as needed. |

#### Mapping Configuration

To achieve SSO login, map the identity provider (IdP) account information to <<< custom_key.brand_name >>> account information. Key fields include:

<img src="../img/oidc-2.png" width="70%" >

1. Username: Required; identity provider's “username” field, e.g., `referred_username`.
2. Email: Required; identity provider's “email” field, e.g., `email`.
3. Phone Number: Optional; identity provider's “phone number” field, e.g., `phone`.

#### Login Configuration

<img src="../img/oidc-3.png" width="70%" >

| Field | Description |
| ----------- | ----------- |
| Access Restrictions | Verifies whether the login email domain suffix matches the configured domain. Only matching emails have permission to access the SSO login link. User accounts can be dynamically created during the first login without pre-creation in the workspace. |
| Role Authorization | Assign roles to SSO accounts logging in for the first time; existing accounts remain unaffected.<br/>:warning: If [Role Mapping](#saml-mapping) is enabled in the workspace, roles will be assigned based on mapping rules. Refer to [Role Management](../role-management.md) for role permissions. |
| [Session Persistence](#login-hold-time) | Set inactive session persistence time and maximum session duration. Sessions expire after the timeout period. |

???- abstract "User-side OIDC Configuration Notes"

    1. Authorization Mode: Only supports `authorization_code` authorization mode; return type must be `code`.
    2. `id_token` Signature Algorithm: Currently only supports `HS256`.
    3. `code` Exchange `token` Authentication Method:

        - Default support: `client_secret_basic`
        - Custom methods supported: `client_secret_post`, `client_secret_basic`, `none`

    4. `scope` Scope:
        - Default scope: openid profile email phone
        - Custom requirements: Must include `openid`; others can be customized but must include `email` in the returned result, optionally returning `phone_number`.

### Non-standard OIDC Configuration {#non-standard}

???- abstract "Understanding Non-standard OIDC Configuration?"

    Non-standard configurations typically occur when customers use Oauth2 for identity authentication. Since the Oauth2 protocol does not specify an **account information retrieval interface**, this step varies widely across implementations. Additionally, different customer interfaces may result in inconsistent **parameter case styles**, leading to non-standard configurations.

1. Navigate to **Management > Member Management > SSO Management > OIDC > Create Identity Provider**;
2. Click the top-right corner to switch to the standard OIDC configuration page:

<img src="../img/oidc-5.png" width="70%" >

![](../img/oidc-4.png)

#### Connection Configuration

| Input Field | Description |
| ----------- | ----------- |
| Identity Provider Name | Name of the platform providing identity management services. |
| Configuration File Upload | Click to download the template, fill in the necessary information, and upload it. |
| Remarks | Custom-added descriptive information for recording relevant explanations about the identity provider. |

#### Login Configuration

| Input Field | Description |
| ----------- | ----------- |
| Access Restrictions | Verifies whether the login email domain suffix matches the configured domain. Only matching emails have permission to access the SSO login link. User accounts can be dynamically created during the first login without pre-creation in the workspace. |
| Role Authorization | Assign roles to SSO accounts logging in for the first time; existing accounts remain unaffected.<br/>:warning: If [Role Mapping](#saml-mapping) is enabled in the workspace, roles will be assigned based on mapping rules. Refer to [Role Management](../role-management.md) for role permissions. |
| [Session Persistence](#login-hold-time) | Set inactive session persistence time and maximum session duration. Sessions expire after the timeout period. |

#### Obtain URLs

After successfully adding the identity provider, you can obtain the **Callback URL** and **Initiate Login URL**.

| Field | Description |
| ----------- | ----------- |
| Callback URL | OIDC protocol-defined callback address after successful authentication, used to receive the identity provider's authentication response. |
| Initiate Login URL | Entry address for initiating OIDC login flow from <<< custom_key.brand_name >>>, provided by the identity provider. |

Provide these two URLs to the identity provider after obtaining them.

## SSO List

### Enable Role Mapping

You can enable or disable role mapping for individual identity providers (IDPs):

- Enable Role Mapping:
    - SSO login user accounts will be dynamically assigned roles based on the `attribute fields` and `attribute values` provided by the identity provider.
    - If no role mapping rule is matched, user accounts will lose all roles and cannot log in to access the workspace.
- Disable Role Mapping: SSO login users retain previously assigned roles, unaffected by changes in assertions from the identity provider side.

### Enable/Update/Delete/Import/Export SSO

After adding an identity provider, you can enable or disable the current SSO configuration as needed. Once enabled, the following operations are supported:

- Update SSO Configuration: Updating affects the login experience of existing SSO members, proceed with caution.
- Delete SSO Configuration: Deleting removes the current SSO configuration, preventing related members from logging in via this SSO configuration, proceed with caution.
- Import/Export Identity Providers: Support importing and exporting identity provider configurations for quick replication across multiple workspaces.

**Note**:

- Exported files must not share names with existing identity providers in the current workspace.
- Exported files must conform to JSON format specifications.

### View SSO Members

- Member Count: Displays the total number of members who have logged in via SSO.
- Member List: Click on the member count to view the specific list of authorized SSO members.

## Login Verification {#login}

1. Email login to <<< custom_key.brand_name >>> SSO page: https://auth.guance.com/login/sso;
2. Enter the email address configured during SSO creation to access all authorized workspaces linked to the identity provider;
3. Login URL;
4. Enter username, password, etc.;
5. Successful login.

<img src="../img/sso_login.png" width="70%" >

<img src="../img/sso_login_1.png" width="70%" >

???+ warning "Note"

    - If the workspace has [Role Mapping](./role_mapping.md) enabled but the current user does not match any roles or role mapping is disabled, the message "No Access Permissions" will be displayed.
    - If the workspace deletes the identity provider, users selecting SSO login will not see unauthorized workspaces.

## Email Notifications

Workspace Owners and Administrators will receive email notifications when SSO is enabled, configured, or deleted.

## Audit Events

Enabling, configuring, or deleting SSO operations will generate [audit](../operation-audit.md) events.

## SSO Configuration Examples

- [Alibaba Cloud IDaaS](aliyun-idaas.md)
- [Authing](authing.md)
- [Azure AD](azure-ad.md)
- [IAM Identity Center](./aws_iam_sso.md)
- [Okta](okta.md)
- [Keycloak](keycloak.md)