# SSO Management
---

<<< custom_key.brand_name >>> supports SSO management based on SAML, OIDC/Oauth2.0 protocols, allowing enterprises to manage employee information in their local IdP (Identity Provider). There is no need for user synchronization between <<< custom_key.brand_name >>> and the enterprise IdP; employees can log in to <<< custom_key.brand_name >>> with specified roles.

In SSO management, you can:

- [Configure corporate domain names to set up single sign-on for employees](#corporate)
- [Configure corporate domain names and enable role mapping to provide a more refined single sign-on solution](#saml-mapping)

## User SSO {#corporate}

<<< custom_key.brand_name >>> supports setting up single sign-on for employees based on corporate domain names. Any employee who complies with the unified identity authentication of the company can log in to <<< custom_key.brand_name >>> via an email address with the same suffix as the corporate domain name, with access permissions that can be selected as read-only member or standard member.

In <<< custom_key.brand_name >>> workspace **Management > Member Management > SSO Management > User SSO**, choose [SAML](configuration-faq.md#saml) or [OIDC](#oidc) as needed to start setting up SSO single sign-on for employees.

- <<< custom_key.brand_name >>> supports creating multiple SSO IDP configurations within a workspace, with each workspace's SSO configuration not exceeding 10;
- If multiple workspaces are configured with the same identity provider SSO single sign-on simultaneously, users can switch between different workspaces to view data after logging in through SSO single sign-on by clicking the workspace options in the top-left corner of <<< custom_key.brand_name >>>.

![](../img/5.sso_mapping_6.png)

### SAML {#saml}

![](../img/5.sso_mapping_7.png)

| Field      | Description                          |
| ----------- | ------------------------------------ |
| Type       | Choose [SAML](configuration-faq.md#saml).  |
| Identity Provider      | The entity platform providing identity management services.                          |
| Metadata Document       | XML document provided by the IdP (Identity Provider). |
| Remarks       | Customizable descriptive information added by users regarding the identity provider.  |
| Access Restrictions    | Used to verify whether the email suffix entered during single sign-on matches the domain name. Only emails with matching domain suffixes have permission to obtain the single sign-on access link from this identity provider. Users can dynamically create <<< custom_key.brand_name >>> member accounts upon first login without pre-creating them in the workspace. |
| Role Authorization       | Grant roles to SSO accounts logging in for the first time, leaving existing member accounts unaffected.<br/>:warning: If the [SAML Mapping](#saml-mapping) feature is enabled in the workspace, members will be assigned roles according to the mapping rules when they log in.<br/>For role permissions, refer to [Role Management](../role-management.md).  |
| [Session Persistence](#login-hold-time)       | Set the idle session persistence time and maximum session persistence time for single sign-on members. Sessions will expire if inactive beyond these times. |

#### Obtain Entity ID and Assertion URL {#obtain}

After completing the above information, click **Confirm** to get the **Entity ID** and **Assertion URL**. Once the corresponding SAML configuration is completed according to the identity provider's requirements, it can be used.

| Field      | Description                  |
| ----------- | ------------------- |
| Login URL       | <<< custom_key.brand_name >>> SSO login URL generated based on the uploaded metadata document, which can only access one workspace.  |
| Metadata      | <<< custom_key.brand_name >>> SSO metadata document generated based on the uploaded metadata document.                  |
| Entity ID      | <<< custom_key.brand_name >>> SSO login response entity ID generated based on the uploaded metadata document, used to identify the service provider (SP) in the identity provider, such as <<< custom_key.brand_name >>>.                  |
| Assertion URL      | <<< custom_key.brand_name >>> SSO login response target URL generated based on the uploaded metadata document, used by the identity provider to initiate single sign-on.                  |

After obtaining the **Entity ID** and **Assertion URL**, click **Confirm** or **Cancel** to return to SSO management.

![](../img/5.sso_mapping_8.png)

#### Session Persistence {#login-hold-time}

When configuring SSO single sign-on, you can set a uniform login persistence time for enterprise members accessing via SSO, including idle session persistence time and maximum session persistence time.

- Idle session persistence time: Support range 180 ~ 1440 minutes, default is 180 minutes;
- Maximum session persistence time: Support range 0 ~ 7 days, where 0 indicates never timeout, default is 7 days.

???+ abstract "Example Explanation"

    After configuring SSO single sign-on, if the SSO login persistence time is updated, the session expiration time for previously logged-in SSO members remains unchanged. Members logging in after the update follow the newly set login persistence time.
    
    For example:

    - When configuring SSO single sign-on, the idle session expiration time is set to 30 minutes. Member A logs into <<< custom_key.brand_name >>> at this point, so their SSO login account's idle session expiration time is 30 minutes;
    - Later, the administrator updates the idle session expiration time to 60 minutes. Member A's SSO login account's idle session expiration time remains 30 minutes; however, if Member B logs into <<< custom_key.brand_name >>> afterward, their SSO login account's idle session expiration time will be 60 minutes, and so on.

### OIDC {#oidc}

Click into **Management > Member Management > SSO Management > OIDC > Create Identity Provider**, the default entry is **Standard OIDC Configuration**. If you are not using standard OIDC configuration, you can [switch pages for configuration](#non-standard).

![](../img/oidc.png)

:material-numeric-1-circle: Connection Configuration:

| Field      | Description                          |
| ----------- | ------------------------------------ |
| Type       | Select [OIDC](configuration-faq.md#saml).  |
| Identity Provider Name      | The entity platform providing identity management services.                          |
| Remarks       | Customizable descriptive information added by users regarding the identity provider.  |
| Identity Provider URL       | Complete URL of the identity provider, also the service discovery address, e.g., https://guance.example.com. |
| Client ID    | Client ID provided by the authentication service. |
| Client Secret       | Client secret used together with the client ID to authenticate the client application.  |
| Authorization Request Scope      | Authorization request scope, additional claims can be manually added besides the default scopes; default includes `openid`, `profile`, and `email`. You can add `address` and `phone` as needed.|

![](../img/oidc-1.png)

:material-numeric-2-circle: Mapping Configuration:

To achieve SSO login, the account information from the identity provider needs to be mapped to <<< custom_key.brand_name >>> account information. The fields mainly include:

<img src="../img/oidc-2.png" width="70%" >

- Username: Required; the "username" field from the identity provider, e.g., `referred_username`;
- Email: Required; the "email" field from the identity provider, e.g., `email`;
- Phone Number: Optional; the "phone number" field from the identity provider, e.g., `phone`.

:material-numeric-3-circle: Login Configuration:

| Field      | Description                          |
| ----------- | -------------------------- |
| Access Restrictions    | Used to verify whether the email suffix entered during single sign-on matches the domain name. Only emails with matching domain suffixes have permission to obtain the single sign-on access link from this identity provider. Users can dynamically create <<< custom_key.brand_name >>> member accounts upon first login without pre-creating them in the workspace. |
| Role Authorization       | Grant roles to SSO accounts logging in for the first time, leaving existing member accounts unaffected.<br/>:warning: If the [Role Mapping](#saml-mapping) feature is enabled in the workspace, members will be assigned roles according to the mapping rules when they log in.<br/>For role permissions, refer to [Role Management](../role-management.md).  |
| [Session Persistence](#login-hold-time)       | Set the idle session persistence time and maximum session persistence time for single sign-on members. Sessions will expire if inactive beyond these times.  |

<img src="../img/oidc-3.png" width="70%" >

???- abstract "User-side OIDC Configuration Precautions"

    1. Authorization Mode: <<< custom_key.brand_name >>> only supports the `authorization_code` authorization mode; the response type must be `code`;
    2. `id_token` Signature Algorithm: Currently only supports `HS256`;
    3. `code` Exchange `token` Authentication Method:

        - Default support: `client_secret_basic`

        - Custom methods supported: `client_secret_post`, `client_secret_basic`, `none`

    4. `scope` Scope: Default is `openid profile email phone`

        - Custom method: Must include `openid`, others can be customized

    **Note**: Although customization is allowed, the returned result must contain `email` information, optionally returning `phone_number` information.


#### Non-standard OIDC Configuration {#non-standard}

???- abstract "Understanding Non-standard OIDC Configuration?"

    Non-standard configurations generally occur when customers use OAuth2 for identity authentication. However, OAuth2 does not specify an **interface to retrieve account information**, leading to significant differences in retrieving user information, which is crucial for establishing successful mapping relationships. Additionally, due to varying interface design rules across customers, there may be inconsistencies in **parameter case styles**, making it non-standard.

Enter **Management > Member Management > SSO Management > OIDC > Create Identity Provider**, and click the top-right corner to switch to the standard OIDC configuration page:

![](../img/oidc-5.png)

![](../img/oidc-4.png)

:material-numeric-1-circle: Connection Configuration:

| Field      | Description                          |
| ----------- | ------------------------------------ |
| Identity Provider Name      | The entity platform providing identity management services.                          |
| Configuration File Upload      | Click to download a template, fill in the required information, and upload it.                          |
| Remarks       | Customizable descriptive information added by users regarding the identity provider.  |

:material-numeric-2-circle: Login Configuration:

| Field      | Description                          |
| ----------- | -------------------------- |
| Access Restrictions    | Used to verify whether the email suffix entered during single sign-on matches the domain name. Only emails with matching domain suffixes have permission to obtain the single sign-on access link from this identity provider. Users can dynamically create <<< custom_key.brand_name >>> member accounts upon first login without pre-creating them in the workspace. |
| Role Authorization       | Grant roles to SSO accounts logging in for the first time, leaving existing member accounts unaffected.<br/>:warning: If the [Role Mapping](#saml-mapping) feature is enabled in the workspace, members will be assigned roles according to the mapping rules when they log in.<br/>For role permissions, refer to [Role Management](../role-management.md).  |
| [Session Persistence](#login-hold-time)       | Set the idle session persistence time and maximum session persistence time for single sign-on members. Sessions will expire if inactive beyond these times.  |

#### Obtain Relevant URLs

After saving the identity provider information, you can obtain the **Callback URL** and **Initiate Login URL**.

| Field      | Description                  |
| ----------- | ------------------- |
| Callback URL      | The callback address agreed upon in the OIDC protocol after the account authentication service verifies the credentials.                  |
| Initiate Login URL      | Used to enter the OIDC protocol flow from <<< custom_key.brand_name >>>, which is the URL initiated by the provider for login.                 |

After obtaining the two URLs, send them to the identity provider. They can also be reviewed later on the configuration detail page.


### Enable Role Mapping

You can enable/disable role mapping for individual IDPs:

- Enabling it means SSO login users' current roles in the workspace will be revoked and dynamically assigned based on the **attribute fields** and **attribute values** provided by the identity provider. If no role mapping rule matches, the user account will be stripped of all roles and denied access to <<< custom_key.brand_name >>> workspace;
- Disabling it means SSO login users will retain the roles previously assigned to their accounts, unaffected by changes in assertions from the identity provider side.

![](../img/saml.png)


### Enable/Update/Delete/Import/Export SSO

After adding the identity provider, you can enable or disable the current SSO configuration as needed.

Once SSO is enabled, you can update or delete the SSO configuration, which will affect existing SSO members' login. Be cautious when performing these actions.

You can also import/export identity providers to quickly configure SSO settings for multiple workspaces.

When exporting, ensure the exported file does not have the same name as any existing identity providers in the workspace and conforms to JSON format standards.

<img src="../img/5.sso_mapping_9.png" width="60%" >

### View SSO Members

After enabling SSO, if enterprise members log in to <<< custom_key.brand_name >>> via SSO, you can view the total number of logged-in members under **SSO Login**. Clicking on the member count allows you to see the list of authorized SSO members.

![](../img/1.5.sso_mapping_9.png)


## Role Mapping {#saml-mapping}

<<< custom_key.brand_name >>> supports configuring role mapping relationships to provide a more refined single sign-on solution. Enabling role mapping allows dynamic assignment of access permissions to employees, who can then access <<< custom_key.brand_name >>> based on the roles assigned to them.

### Configure Role Mapping

In <<< custom_key.brand_name >>> workspace **Management > Member Management > SSO Management > Role Mapping**, click **Add Mapping** to create a new mapping relationship.

![](../img/5.sso_mapping_10.png)

- Identity Provider: Select from all identity providers available in the current workspace; only single selection is allowed;
- Attribute Field/Attribute Value: Ensure the attribute fields and values in the role mapping configuration match those configured on the IdP account for successful verification. Upon successful verification, the corresponding role permissions will be assigned to the IdP account upon login;
- Role Authorization: <<< custom_key.brand_name >>> supports four default member roles: Owner, Administrator, Standard, and Read-only; or custom roles created in [Role Management](../role-management.md).

<img src="../img/5.sso_mapping_11.png" width="60%" >

### Search/Edit/Delete Mappings

- Search & Filter: Supports searching for configured mappings by role, attribute field, and attribute value. You can also filter by selecting specific identity providers;
- Edit: Allows reconfiguring existing mappings. Users logging in via SAML without a valid <<< custom_key.brand_name >>> role mapping will lose all roles and cannot log into <<< custom_key.brand_name >>> console;
- Delete: Directly delete or batch delete configured mappings. Users logging in via SAML without a valid <<< custom_key.brand_name >>> role mapping will lose all roles and cannot log into <<< custom_key.brand_name >>> console.

![](../img/5.sso_mapping_10.1.png)


## Logging into <<< custom_key.brand_name >>> Console {#login}

After SSO configuration is complete, go to the <<< custom_key.brand_name >>> [official website](https://www.guance.com/) login page and select **Single Sign-On**.

<img src="../img/06_sso_5.png" width="60%" >

Enter the email address used to create the SSO to access all authorized workspaces associated with the identity provider ID. You can also search for specific workspaces using the search bar.

![](../img/06_sso_6.png)

Clicking on a row will take you to the login page:

<img src="../img/06_sso_7.png" width="70%" >

**Note**:

1. If the workspace identity provider has enabled [Role Mapping](#mapping), but the current user has no role mapping rules or role mapping is disabled, a message indicating no access rights will appear;
    
2. If the workspace deletes the identity provider, users choosing SSO login will not see unauthorized workspaces.

Entering the company-wide email and password directly logs you into the corresponding <<< custom_key.brand_name >>> workspace:

<img src="../img/06_sso_8.png" width="70%" >

### SSO Account Management {#account}

After logging into the workspace with an SSO account, click on the left-hand side **Account > Account Management** to modify the SSO account.

- Modify avatar and username;
- Adjust session persistence time.

**Note**: By default, SSO accounts use the session persistence time configured in SSO. After modification in account management, the modified session persistence time takes effect. For more details, refer to [Account Session Persistence Time](../account-management.md#login-hold-time).

## Email Notifications

Enabling, configuring, or deleting SSO triggers email notifications to the Owner and Administrator of the corresponding workspace.


## Audit Events

Enabling, configuring, or deleting SSO generates audit events.


In <<< custom_key.brand_name >>> workspace, click **Management > Settings > Security > Operation Audit**, and click **View** to check all audit events for the current workspace.

<img src="../img/5.sso_mapping_13.png" width="60%" >

<!-- 
![](../img/06_sso_9.png)

![](../img/5.sso_mapping_12.png)
-->

## Single Sign-On Example

Integrate external platforms with <<< custom_key.brand_name >>> to enable automatic login (single sign-on) from external platform accounts to <<< custom_key.brand_name >>> and access corresponding workspace resources without creating separate <<< custom_key.brand_name >>> accounts for the enterprise/team.


|              <font color=coral size=3>:fontawesome-regular-circle-down: &nbsp;**Configuration Examples**</font>                         |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [Azure AD](azure-ad.md){ .md-button .md-button--primary } | [Authing](authing.md){ .md-button .md-button--primary } | [Okta](okta.md){ .md-button .md-button--primary } |
| [Alibaba Cloud IDaaS](aliyun-idaas.md){ .md-button .md-button--primary } | [Keycloak](keycloak.md){ .md-button .md-button--primary } |  |