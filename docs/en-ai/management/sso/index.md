# SSO Management
---

Guance supports SSO management based on SAML, OIDC/Oauth2.0 protocols, allowing enterprises to manage employee information locally in their IdP (Identity Provider) without needing user synchronization between Guance and the enterprise IdP. Enterprise employees can log in and access Guance through specified roles.

In SSO Management, you can:

- [Configure corporate domains for employees to set up single sign-on](#corporate)
- [Configure corporate domains with role mapping for more refined single sign-on solutions](#saml-mapping)

## User SSO {#corporate}

Guance supports setting up single sign-on for employees based on corporate domains. Any employee who meets the unified identity authentication of the company can log in to Guance via an email with the same domain suffix as the company domain, with access permissions selectable as read-only members or standard members.

In Guance workspace **Management > Member Management > SSO Management > User SSO**, choose either [SAML](configuration-faq.md#saml) or [OIDC](#oidc) as needed to start setting up SSO single sign-on for employees.

- Guance supports creating multiple SSO IDP configurations within a workspace, with no more than 10 SSO configurations per workspace.
- If multiple workspaces are configured with the same identity provider SSO single sign-on, users can switch between different workspaces to view data after logging in via SSO single sign-on by clicking the workspace option in the top-left corner of Guance.

![](../img/5.sso_mapping_6.png)

### SAML {#saml}

![](../img/5.sso_mapping_7.png)

| Field        | Description                                                                                   |
| -------------- | ------------------------------------------------------------------------------------------------ |
| Type          | Select [SAML](configuration-faq.md#saml).                                                        |
| Identity Provider | Entity platform used for identity management services.                                             |
| Metadata Document | XML document provided by the IdP (Identity Provider).                                          |
| Remarks       | Customizable description information for the identity provider added by the user.                        |
| Access Restrictions | Verifies that the email suffix entered during single sign-on matches the domain name. Only emails with matching domain suffixes have permission to access the identity provider's single sign-on link. Users can dynamically create Guance member accounts upon first login without pre-creating them in the workspace. |
| Role Authorization | Assign roles to SSO accounts logging in for the first time; existing member accounts remain unaffected.<br/>:warning: If the [SAML Mapping](#saml-mapping) feature is enabled within the workspace, roles will be assigned based on the mapping rules when members log in.<br/>For role permissions, refer to [Role Management](../role-management.md). |
| [Session Persistence](#login-hold-time) | Set idle session persistence time and maximum session persistence time for single sign-on members. Sessions will expire if inactive beyond the set times. |

#### Obtain Entity ID and Assertion URL {#obtain}

After completing the above information, click **Confirm** to obtain the **Entity ID** and **Assertion URL**. Follow the identity provider's requirements to complete the corresponding SAML configuration.

| Field         | Description                                                                                         |
| --------------- | ----------------------------------------------------------------------------------------------------- |
| Login URL      | Generated based on the uploaded metadata document, this URL allows access to only one workspace.                 |
| Metadata       | Generated based on the uploaded metadata document, this is the Guance SSO metadata document.                       |
| Entity ID      | Generated based on the uploaded metadata document, this is the entity ID for Guance SSO login responses used by the identity provider to identify the service provider (SP), such as Guance. |
| Assertion URL  | Generated based on the uploaded metadata document, this is the response target URL for Guance SSO login used by the identity provider for single sign-on. |

After obtaining the **Entity ID** and **Assertion URL**, click **Confirm** or **Cancel** to return to SSO Management.

![](../img/5.sso_mapping_8.png)

#### Session Persistence {#login-hold-time}

When configuring SSO single sign-on, you can set a uniform login persistence time for corporate members logging in via SSO, including idle session persistence time and maximum session persistence time.

- Idle session persistence time: Supports settings from 180 to 1440 minutes, defaulting to 180 minutes;
- Maximum session persistence time: Supports settings from 0 to 7 days, where 0 means never timeout, defaulting to 7 days.

???+ abstract "Example Explanation"

    After configuring SSO single sign-on, if the SSO login persistence time is updated, previously logged-in SSO member sessions will retain their original expiration times, while new SSO members logging in after the update will follow the latest settings.

    For example:

    - When configuring SSO single sign-on, the idle session timeout is set to 30 minutes. Member A logs into Guance at this point, so their SSO login account has an idle session timeout of 30 minutes.
    - Later, the administrator updates the idle session timeout to 60 minutes. Member A's SSO login account still has an idle session timeout of 30 minutes. However, any new member B logging in afterward will have an idle session timeout of 60 minutes, and so on.

### OIDC {#oidc}

Click into **Management > Member Management > SSO Management > OIDC > Create New Identity Provider**, which defaults to **Standard OIDC Configuration**. If you are not using standard OIDC configuration, you can [switch pages for configuration](#non-standard).

![](../img/oidc.png)

:material-numeric-1-circle: Connection Configuration:

| Field            | Description                                                                                           |
| ------------------ | ------------------------------------------------------------------------------------------------------- |
| Type              | Select [OIDC](configuration-faq.md#saml).                                                              |
| Identity Provider Name | The entity platform providing identity management services.                                               |
| Remarks           | Customizable description information for the identity provider added by the user.                             |
| Identity Provider URL | Full URL of the identity provider, also the discovery address, e.g., https://guance.example.com.             |
| Client ID         | Client ID provided by the authentication service.                                                     |
| Client Secret     | Used with the client ID to authenticate the client application.                                         |
| Authorization Request Scope | Scopes for authorization requests; besides the default scopes, additional claims can be manually added; default selected `openid`, `profile`, and `email`. You can add `address` and `phone` claims as needed. |

![](../img/oidc-1.png)

:material-numeric-2-circle: Mapping Configuration:

To achieve SSO login, map the identity provider account information to Guance account information. The main fields include:

<img src="../img/oidc-2.png" width="70%" >

- Username: Required; the "username" field from the identity provider, e.g., `referred_username`;
- Email: Required; the "email" field from the identity provider, e.g., `email`;
- Phone Number: Optional; the "phone number" field from the identity provider, e.g., `phone`.

:material-numeric-3-circle: Login Configuration:

| Field            | Description                                                                                           |
| ------------------ | ------------------------------------------------------------------------------------------------------- |
| Access Restrictions | Verifies that the email suffix entered during single sign-on matches the domain name. Only emails with matching domain suffixes have permission to access the identity provider's single sign-on link. Users can dynamically create Guance member accounts upon first login without pre-creating them in the workspace. |
| Role Authorization | Assign roles to SSO accounts logging in for the first time; existing member accounts remain unaffected.<br/>:warning: If the [Role Mapping](#saml-mapping) feature is enabled within the workspace, roles will be assigned based on the mapping rules when members log in.<br/>For role permissions, refer to [Role Management](../role-management.md). |
| [Session Persistence](#login-hold-time) | Set idle session persistence time and maximum session persistence time for single sign-on members. Sessions will expire if inactive beyond the set times. |

<img src="../img/oidc-3.png" width="70%" >

???- abstract "User-side Configuration Notes for OIDC"

    1. Authorization Mode: Guance only supports the `authorization_code` authorization mode; the response type must be `code`.
    2. `id_token` Signature Algorithm: Currently only supports `HS256`.
    3. `code` Exchange `token` Authentication Method:

        - Default support: `client_secret_basic`
        - Custom methods supported: `client_secret_post`, `client_secret_basic`, `none`

    4. `scope` Range: Defaults to `openid profile email phone`

        - Custom method: Must include `openid`, other scopes can be customized

    **Note**: Although customization is possible, the returned result must contain `email` information, and optionally `phone_number` information.


#### Non-Standard OIDC Configuration {#non-standard}

???- abstract "Understanding Non-Standard OIDC Configuration?"

    Non-standard configurations generally occur because customers use Oauth2 for identity authentication, but Oauth2 does not specify an **account information retrieval interface**, leading to significant differences in obtaining user information. Since successful mapping relies on accurate information, this step can vary widely. Additionally, due to different interface design rules on the customer side, **parameter case styles may be inconsistent**, which also results in non-standard configurations.

Enter **Management > Member Management > SSO Management > OIDC > Create New Identity Provider**, and click the upper-right corner to switch to the standard OIDC configuration page:

![](../img/oidc-5.png)

![](../img/oidc-4.png)

:material-numeric-1-circle: Connection Configuration:

| Field            | Description                                                                                           |
| ------------------ | ------------------------------------------------------------------------------------------------------- |
| Identity Provider Name | The entity platform providing identity management services.                                               |
| Configuration File Upload | Click to download a template, fill in the relevant information, and then upload it.                             |
| Remarks           | Customizable description information for the identity provider added by the user.                             |

:material-numeric-2-circle: Login Configuration:

| Field            | Description                                                                                           |
| ------------------ | ------------------------------------------------------------------------------------------------------- |
| Access Restrictions | Verifies that the email suffix entered during single sign-on matches the domain name. Only emails with matching domain suffixes have permission to access the identity provider's single sign-on link. Users can dynamically create Guance member accounts upon first login without pre-creating them in the workspace. |
| Role Authorization | Assign roles to SSO accounts logging in for the first time; existing member accounts remain unaffected.<br/>:warning: If the [Role Mapping](#saml-mapping) feature is enabled within the workspace, roles will be assigned based on the mapping rules when members log in.<br/>For role permissions, refer to [Role Management](../role-management.md). |
| [Session Persistence](#login-hold-time) | Set idle session persistence time and maximum session persistence time for single sign-on members. Sessions will expire if inactive beyond the set times. |

#### Obtain Relevant URLs

After saving the identity provider information, you can obtain the **Callback URL** and **Initiate Login URL**.

| Field         | Description                                                                                         |
| --------------- | ----------------------------------------------------------------------------------------------------- |
| Callback URL   | The callback address agreed upon in the OIDC protocol after successful account authentication.                  |
| Initiate Login URL | Used to enter the OIDC protocol flow from the Guance end, this is the URL initiated by the provider for login. |

After obtaining these two URLs, send them to the identity provider. They can also be reviewed later on the configuration details page.


### Enable Role Mapping

You can enable or disable role mapping for individual IDPs:

- When enabled, SSO login user accounts will lose their current roles in the workspace and dynamically assign roles based on the identity provider's **attribute fields** and **attribute values**. If no role mapping rule matches, the user account will lose all roles and will not be allowed to log in to the Guance workspace.
- When disabled, SSO login users will continue to have the roles previously assigned to their accounts, which are not affected by changes in assertions from the identity provider side.

![](../img/saml.png)


### Enable/Update/Delete/Import/Export SSO

After adding an identity provider, you can enable or disable the current SSO configuration as needed.

Once SSO is enabled, you can update or delete the SSO configuration. Updating or deleting will affect existing SSO member logins, so proceed with caution.

You can also import/export identity providers to quickly configure multiple workspace single sign-on settings.

When exporting, ensure the file name does not conflict with existing identity providers in the workspace and that it conforms to JSON format standards.

<img src="../img/5.sso_mapping_9.png" width="60%" >

### View SSO Members

After enabling SSO, if enterprise members log in via SSO to Guance, you can view all logged-in members under **SSO Login**. Clicking the member count shows specific authorized SSO login member lists.

![](../img/1.5.sso_mapping_9.png)


## Role Mapping {#saml-mapping}

Guance supports configuring role mapping relationships to provide more refined single sign-on solutions for enterprises. Enabling role mapping allows dynamic allocation of access permissions for employees, who can access Guance based on the roles assigned to them.

### Configure Role Mapping

In Guance workspace **Management > Member Management > SSO Management > Role Mapping**, click **Add Mapping** to create a new mapping relationship.

![](../img/5.sso_mapping_10.png)

- Identity Provider: Select from all identity providers within the current workspace; only single selection is allowed.
- Attribute Field/Attribute Value: Ensure that the attribute fields and values configured in role mapping match those set in the IdP account for successful verification. Upon successful verification, the corresponding role permissions will be assigned to the IdP account upon login.
- Role Authorization: Guance supports four default member roles: Owner, Administrator, Standard, and Read-only; or custom roles created in [Role Management](../role-management.md).

<img src="../img/5.sso_mapping_11.png" width="60%" >

### Search/Edit/Delete Mappings

- Search & Filter: Support searching mapped roles by role, attribute field, attribute value. You can also filter by selecting specific identity providers.
- Edit: Support modifying existing mapped roles. Users logging in via SAML without mapped roles will be stripped of all roles and denied access to the Guance console.
- Delete: Support directly deleting or batch-deleting configured mappings. Users logging in via SAML without mapped roles will be stripped of all roles and denied access to the Guance console.

![](../img/5.sso_mapping_10.1.png)


## Log in to Guance Console {#login}

After SSO configuration is complete, go to the [Guance official website](https://www.guance.com/) login page and select **Single Sign-On**.

<img src="../img/06_sso_5.png" width="60%" >

Enter the email address used to create the SSO to access all authorized workspaces under the identity provider ID. You can also use the search bar to precisely locate specific workspaces.

![](../img/06_sso_6.png)

Click the row to enter the login page:

<img src="../img/06_sso_7.png" width="70%" >

**Note**:

1. If the workspace's identity provider has enabled [role mapping](#mapping) but the current user does not have a role mapping rule or role mapping is disabled, you will be prompted that you do not have access rights.
    
2. If the workspace deletes the identity provider, users choosing SSO login will not see unauthorized workspaces.

Enter the company's general email and password to directly log into the corresponding workspace in Guance:

<img src="../img/06_sso_8.png" width="70%" >

### SSO Account Management {#account}

After entering the workspace with an SSO account, click the left-hand **Account > Account Management** to modify the SSO account.

- Supports changing avatar, username;
- Supports changing session persistence time.

**Note**: By default, SSO login accounts use the session persistence time set in the SSO configuration. After modification in account management, the modified session persistence time takes effect. For more details, refer to [Account Session Persistence Time](../account-management.md#login-hold-time).

## Email Notifications

Enabling, configuring, or deleting SSO will trigger email notifications to Owners and Administrators of the corresponding workspace.


## Audit Events

Enabling, configuring, or deleting SSO generates audit events.

In the Guance workspace, click **Management > Settings > Security > Operation Audit**, then click **View** to review all audit events in the current workspace.

<img src="../img/5.sso_mapping_13.png" width="60%" >

<!-- 
![](../img/06_sso_9.png)

![](../img/5.sso_mapping_12.png)
-->

## Single Sign-On Examples

Integrate external platforms with Guance to enable automatic login (single sign-on) from the external platform into the Guance platform to access corresponding workspace resources without creating separate Guance accounts for the enterprise/team.


|              <font color=coral size=3>:fontawesome-regular-circle-down: &nbsp;**Configuration Example**</font>                         |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [Azure AD](azure-ad.md){ .md-button .md-button--primary } | [Authing](authing.md){ .md-button .md-button--primary } | [Okta](okta.md){ .md-button .md-button--primary } |
| [Aliyun IDaaS](aliyun-idaas.md){ .md-button .md-button--primary } | [Keycloak](keycloak.md){ .md-button .md-button--primary } |  |