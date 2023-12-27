
# SSO Management

---

Guance supports SSO management based on SAML and OIDC/OAuth2.0 protocols, allowing enterprises to manage employee information in the local IdP (Identity Provider) without the need for user synchronization between Guance and the enterprise IdP. Enterprise employees can log in and access Guance with specified roles.

In SSO management, you can:

- [Set up SSO for employees based on the configuration of the corporate domain](#corporate)
- [Set up more precise SSO solutions for enterprises by configuring the corporate domain and enabling role mapping](#saml-mapping)

## User SSO {#corporate}

Guance supports setting up SSO for employees based on the corporate domain. As long as the employees meet the unified identity authentication of the enterprise, they can log in to Guance using an email address with the same domain suffix as the enterprise domain. The access permission can be set to read-only member or standard member.

In Guance workspace **Admin > Member Management > SSO Management > User SSO**, select [SAML](configuration-faq.md#saml) or [OIDC](#oidc) as needed to start setting up SSO for employees.

- Guance supports creating multiple SSO IDP configurations for workspaces, with up to **10 SSO configurations** per workspace.
- If multiple workspaces are configured with the same identity provider SSO, after users log in to the workspace through SSO, they can click on the workspace option in the upper-left corner of Guance to switch to different workspaces to view data.

![](../img/5.sso_mapping_6.png)

### SAML {#saml}

![](../img/5.sso_mapping_7.png)

| Field | Description |
| --- | --- |
| Type | Select [SAML](configuration-faq.md#saml). |
| Identity Provider | The entity platform that provides identity management services. |
| Metadata Document | The XML document provided by the IdP (Identity Provider). |
| Note | Custom description information that users can add for the identity provider. |
| Access Domain | Used to verify whether the email suffix entered during SSO matches the domain name. Only email addresses with the same domain suffix have permission to obtain the SSO access link provided by this identity provider. Users can dynamically create an Guance member account during the first login without creating it in the workspace in advance. |
| Role Authorization | Grant roles to first-time SSO accounts. Roles of non-first-time member accounts are not affected.<br/>:warning: If [role mapping](#saml-mapping) is enabled in the workspace, the roles assigned in the mapping rules will take precedence for member logins.<br/>For role permissions, see [Roles](../role-management.md). |
| [Session Time](#login-hold-time) | Set the idle login session time and the maximum login session time for SSO members. After the settings, the login session will become invalid upon timeout. |

### Obtain the Entity ID and Assertion URL

After completing the information above, click **Confirm** to obtain the **Entity ID** and **Assertion URL**. After completing the corresponding SAML configuration according to the requirements of the identity provider, you can obtain them.

| Field | Description |
| --- | --- |
| Login URL | The login URL of the Guance SSO generated based on the metadata document uploaded by the user. Each login URL can only access one workspace. |
| Metadata | The metadata document of the Guance SSO generated based on the metadata document uploaded by the user. |
| Entity ID | The response entity ID for the Guance SSO login generated based on the metadata document uploaded by the user. It is used to identify the service provider (SP), such as Guance, in the identity provider. |
| Assertion URL | The response target URL for the Guance SSO login generated based on the metadata document uploaded by the user. It is used for the identity provider to call and perform SSO. |

After obtaining the **Entity ID** and **Assertion URL**, click **Confirm** or **Cancel** to return to SSO Management.

![](../img/5.sso_mapping_8.png)

### Session Time {#login-hold-time}

When configuring SSO, you can set a unified login session time for enterprise members who log in through SSO, including the idle login session time and the maximum login session time.

- Idle Login Session Time: Support a range of 180 to 1440 minutes, with a default of 180 minutes.
- Maximum Login Session Time: Support a range of 0 to 7 days. 0 means never times out, with a default of 7 days.

???+ abstract "Example"

    After configuring SSO, if you update the login session time of SSO, the login session expiration time for SSO member accounts logged in before the update will not change. For SSO member accounts logged in after the update, their SSO login account will have the newly set login session time.

    For example:

    - When configuring SSO, the idle session expiration time is set to 30 minutes, and member A logs in to Guance at this time, so the idle session expiration time for their SSO login account is 30 minutes.
  
    - After that, the administrator updates the idle session expiration time to 60 minutes, and the idle session expiration time for member A's SSO login account remains 30 minutes. If member B logs in to Guance after this, the idle session expiration time for their SSO login account is 60 minutes, and so on.


### OIDC {#oidc}

Click **Management > Member Management > SSO Management > OIDC > Add Identity Provider** and you will enter the **Standard OIDC Configuration** by default. If you are not using the standard OIDC configuration, you can [switch to another page for configuration](#non-standard).

![](../img/oidc.png)

:material-numeric-1-circle: Connection Configuration:

| Field | Description |
| --- | --- |
| Type | Select [OIDC](configuration-faq.md#saml). |
| Identity Provider Name | The entity platform that provides identity management services. |
| Note | Custom description information that users can add for the identity provider. |
| Identity Provider URL | The complete URL of the identity provider, which is also the service discovery address, for example, https://guance.example.com/. |
| Client ID | The client ID provided by the authentication service. |
| Client Secret | The client secret is used in conjunction with the client ID to authenticate the client application. |
| Authorization Request Scope | The scope of the authorization request. In addition to the default scopes, you can manually add more claims. The default options are openid, profile, and email, and you can add address and phone as needed. |

![](../img/oidc-1.png)

:material-numeric-2-circle: Mapping Configuration:

To implement SSO login, the account information of the identity provider needs to be mapped to the account information of Guance. The information mainly includes the following fields:

<img src="../img/oidc-2.png" width="80%" >

- Username: Required. The "Username" field of the identity provider, for example, `referred_username`.
- Email: Required. The "Email" field of the identity provider, for example, `email`.
- Phone Number: Optional. The "Phone Number" field of the identity provider, for example, `phone`.

:material-numeric-3-circle: Login Configuration:

| Field | Description |
| --- | --- |
| Access Domain | Used to verify whether the email suffix entered during SSO matches the domain name. Only email addresses with the same domain suffix have permission to obtain the SSO access link provided by this identity provider. Users can dynamically create an Guance member account during the first login without creating it in the workspace in advance. |
| Role Authorization | Grants roles to first-time SSO accounts. Roles of non-first-time member accounts are not affected.<br/>:warning: If [role mapping](#saml-mapping) is enabled in the workspace, the roles assigned in the mapping rules will take precedence for member logins.<br/>For role permissions, see [Roles](../role-management.md). |
| [Session Time](#login-hold-time) | Sets the idle login session time and the maximum login session time for SSO members. After the settings, the login session will become invalid upon timeout. |

<img src="../img/oidc-3.png" width="70%" >

???- abstract "Notes for configuring OIDC on the user side"

    1. Authorization Mode: Guance only supports the `authorization_code` authorization mode. The return type must be `code`.
    2. `id_token` Signature Algorithm: Currently only `HS256` is supported.
    3. `code` Exchange `token` Authentication Method:

        - Default support: `client_secret_basic`

        - Custom method support: `client_secret_post`, `client_secret_basic`, `none`

    4. `scope` Scope: The default scope is `openid profile email phone`.

        - Custom scope: `openid` must be included, and others can be customized.

**Note**: Although customization is allowed, the returned result must include the `email` information, and the `phone_number` information is optional.


### Non-standard OIDC Configuration {#non-standard}

???- abstract "What does non-standard OIDC configuration mean?"

    Non-standard configurations generally occur because the client-side uses OAuth2 for identity authentication. However, the OAuth2 protocol does not specify an API for obtaining account information, which results in a wide variety of methods to obtain user information as this is the key to establishing mapping relationships. In addition, due to different rules in the design of various client-side interfaces, the parameter case styles specified in the protocol may be inconsistent. In this case, it is also non-standard.


Go to **Management > Member Management > SSO Management > OIDC > Add Identity Provider**, and click the upper-right corner to switch to the standard OIDC configuration page:

![](../img/oidc-5.png)

![](../img/oidc-4.png)

:material-numeric-1-circle: Connection Configuration:

| Field | Description |
| --- | --- |
| IdP Name | The entity platform that provides identity management services. |
| Configuration File Upload | You can click to download the template, add the relevant information, and then upload it. |
| Remarks | Custom description information that users can add for the identity provider. |

:material-numeric-2-circle: Login Configuration:

| Field | Description |
| --- | --- |
| Access Domain | Used to verify whether the email suffix entered during SSO matches the domain name. Only email addresses with the same domain suffix have permission to obtain the SSO access link provided by this identity provider. Users can dynamically create an Guance member account during the first login without creating it in the workspace in advance. |
| Role Authorization | Grant roles to first-time SSO accounts. Roles of non-first-time member accounts are not affected.<br/>:warning: If [role mapping](#saml-mapping) is enabled in the workspace, the roles assigned in the mapping rules will take precedence for member logins.<br/>For role permissions, see [Roles](../role-management.md). |
| [Session Time](#login-hold-time) | Set the idle login session time and the maximum login session time. After the settings, the login session will become invalid upon timeout. |

### Obtaining Related URLs

After saving the identity provider information, you can obtain the **Callback URL** and **Login URL**.

| Field | Description |
| --- | --- |
| Callback URL | The callback address defined in the OIDC protocol after the account authentication service is authenticated. |
| Login URL | The URL for initiating the OIDC protocol process from Guance. It is the URL for the provider to initiate login. |

After obtaining the two URLs, you need to send them to the identity provider, and you can also review them on the configuration details page.

### Enable Role Mapping

You can enable or disable role mapping for individual IDP configurations:

- After enabling role mapping, the roles of SSO login user accounts will be revoked in the current workspace, and roles will be dynamically assigned based on the **attribute keys** and **attribute values** provided by the identity provider. If no role mapping rules are matched, user accounts will be revoked of all roles and will not be allowed to log in to the Guance workspace.
- After disabling role mapping, SSO login users will continue to have the roles assigned to their accounts, and the roles will not be affected by changes in assertions on the identity provider side.

![](../img/saml.png)

### Enable/Update/Delete/Import/Export SSO

After adding an identity provider, you can enable or disable the current SSO configuration as needed.

After enabling SSO, you can update and delete the SSO configuration. Once updated or deleted, it will affect the login of existing SSO member accounts, so please proceed with caution.

You can also import/export identity providers to quickly configure multiple workspace SSO configurations.

When performing the export action, please note that the name of the identity provider cannot be the same as the one already existing in the current workspace, and the file must comply with the JSON format specification.

<img src="../img/5.sso_mapping_9.png" width="60%" >

### View SSO Members

After enabling SSO, if enterprise members log in to Guance through SSO, you can view the number of logged-in members in **SSO Login**, and click on the number of members to view the specific list of members authorized for SSO login.

![](../img/1.5.sso_mapping_9.png)


|              <font color=coral size=3>:fontawesome-regular-circle-down: &nbsp;**Config Example**</font>                         |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [Azure AD](azure-ad.md){ .md-button .md-button--primary } | [Authing](authing.md){ .md-button .md-button--primary } | [Okta](okta.md){ .md-button .md-button--primary } |
| [Alibaba Cloud IDaaS](aliyun-idaas.md){ .md-button .md-button--primary } | [Keycloak](keycloak.md){ .md-button .md-button--primary } |  |

## Role Mapping {#saml-mapping}

Guance supports configuring role mapping relationships to provide enterprises with more precise SSO solutions. After enabling role mapping, enterprises can dynamically assign access permissions to employees. Employees can access Guance based on the assigned role permissions.

### Configure Role Mapping

In Guance workspace **Management > Member Management > SSO Management > Role Mapping**, click **Add Mapping** to create a new mapping relationship.

![](../img/5.sso_mapping_10.png)

- Identity Provider: Select from all identity providers in the current workspace; only single selection is allowed;
- Attribute Field/Value: The attribute field and value configured in the role mapping must be consistent with the attribute field and value configured on the IdP account. Only when the role mapping is verified successfully, the account will be assigned the role permission corresponding to the role mapping during IdP account login;
- Role Authorization: Guance supports four default member roles: Owner, Administrator, Standard, and Read-only; or custom roles created in [Role Management](https://www.notion.so/role-management.md).

<img src="../img/5.sso_mapping_11.png" width="60%" >

### Search/Edit/Delete Mapping

- Search & Filter: Support search of mapping roles based on role, attribute field, and attribute value; You can also filter by selecting specific identity providers;
- Edit: Support modifying the configured mapping roles. At this time, users who have not mapped to Guance roles when logging in with SAML will be stripped of all roles and will not be allowed to log in to the Guance console;
- Delete: Support directly deleting or selecting and deleting the configured mapping roles. At this time, users who have not mapped to Guance roles when logging in with SAML will be stripped of all roles and will not be allowed to log in to the Guance console.

![](../img/5.sso_mapping_10.1.png)

## Log in to Guance Console {#login}

After SSO configuration is completed, select **SSO** on the [Guance official website](https://www.guance.com/) login page.

<img src="../img/06_sso_5.png" width="60%" >

Enter the email address used to create SSO, and you can access all workspaces authorized by the ID of the identity provider. You can also enter keywords directly in the search bar for accurate positioning.

![](../img/06_sso_6.png)

Click on a row to enter the login page:

<img src="../img/06_sso_7.png" width="70%" >

**Note**:

1. If the identity provider of the workspace has enabled [Role Mapping](https://www.notion.so/fa36019e153249d1baf554fe789b4c5e?pvs=21), but the current user has not configured role mapping rules or role mapping is disabled for login, you will be prompted that you do not have access permissions;
2. If the identity provider of the workspace is deleted, when users select SSO login, they will not be able to see unauthorized workspaces.

You can directly log in to the corresponding workspace of Guance by entering the enterprise common email and password:


### SSO Account Management {#account}

After logging into the workspace with an SSO account, click **Account > Account Management** on the left side to modify the SSO account.

- Support modifying avatar and username;
- Support modifying login holding time.

**Note**: By default, the account logged in using SSO uses the login holding time configured by SSO. After modification in account management, the modified login holding time will be used. For more details, please see [Account Login Holding Time](https://www.notion.so/account-management.md#login-hold-time).

## Email Notifications

Enabling, configuring, or deleting SSO will trigger email notifications to the Owner and Administrators of the corresponding workspace.

## Audit Events

Enabling, configuring or deleting SSO will generate audit events.

In the Guance workspace, click **Management > Settings > Security > Audit Logs**, and click **View** to view all audit events of the current workspace.

<img src="../img/5.sso_mapping_13.png" width="60%" >
