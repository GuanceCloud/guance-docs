# Management

---

## Administrators

On the **Settings > Administrators** page, you can search for, add, modify, and disable/enable all administrator accounts.

Currently, there are two types of administrator account roles: <u>Administrator and Developer</u>:

- Administrator: Has all management permissions and can log in to the management backend and DataFlux f(x) development platform.
- Developer: Can only log in to the DataFlux f(x) development platform.

![](img/20.deployment_3.png)

### Adding an Administrator

On the **Settings > Administrators** page, click **Add Administrator** in the top-right corner. In the pop-up dialog box, enter the administrator account information, select role permissions, input the password, and click Confirm to add a new administrator.

![](img/20.deployment_4.png)

### Editing

On the **Settings > Administrators** page, click **Edit** to the right of the account, which will take you to the **Edit Administrator Information** page. You can modify the administrator account and role permissions here.

![](img/20.deployment_5.png)

### Resetting Password

On the **Settings > Administrators** page, click **Reset Password** to change the password for that administrator account.

![](img/20.deployment_6.png)

### Disabling/Enabling Members

On the **Settings > Administrators** page, click **Disable** or **Enable** to the right of the account to toggle the account status.

**Note**: If the currently logged-in account is disabled, the login credentials become invalid, and the user will be automatically logged out of the management backend. They will not be able to log back in until the account is re-enabled.

## Basic Information

In the <<< custom_key.brand_name >>> management backend **Settings > Basic Information** page, you can customize settings such as default language, product name, logo, and browser display icons.

![](img/20.deployment_1.png)

Additionally, you can view workspace License information and software details, including service expiration dates, DataKit quantity limits, License version, ownership, and expiration times:

![](img/basic-info.png)

## Personal Settings

On the **Settings > Personal Settings** page, you can change the password for the currently logged-in account.

![](img/20.deployment_2.png)

## Mapping Rules {#mapping}

<<< custom_key.brand_name >>> Deployment Plan supports single sign-on (SSO) via OpenID Connect/OAuth 2.0/LDAP protocols and allows configuring mapping rules for these SSO accounts. After enabling mapping, you can dynamically assign access permissions to employees based on their mapped roles, allowing them to access <<< custom_key.brand_name >>> according to their assigned roles.

???+ warning "When an SSO account is set as the workspace owner, note the following:"

    The account's role in this workspace is fixed as the owner and **is not affected by the mapping rules**. Conversely, it follows the actual mapping rules for role access to the workspace.

    <img src="../img/owner-mapping.png" width="70%" >

> Besides configuring mapping rules in the management backend, you also need to [configure Keycloak SSO mapping rules](./keycloak-rule.md). Both configurations must be completed for the mapping rules to take effect.

<!-- 
### Owner Role Mapping

Supports dynamically assigning the **Owner** role to SSO accounts. Go to **Mapping Rules > Owner Role Mapping**, input attribute fields, attribute values, and target workspaces, then click Confirm to successfully add an **Owner** role mapping.
-->

### Application Scope

In **Management > Mapping Rules**, you can choose between **First Login Only** and **Global** for the application scope of the mapping rules:

:material-numeric-1-circle: First Login Only

If you enable this option, users logging in via SSO for the first time will be dynamically assigned roles based on the mapping rules and added to the workspace.

**Note**: Previously logged-in SSO members are not affected by the mapping rules.

:material-numeric-2-circle: Global

If you enable this option, users logging in via SSO will have their current workspace roles revoked and reassigned based on the attributes provided by the identity provider. If no matching rule is found, the user will lose all roles and cannot access the <<< custom_key.brand_name >>> workspace.

**Note**: Each login involves dynamic role assignment; deleting the corresponding mapping rule in the management backend renders the workspace inaccessible to the user.

:material-numeric-3-circle: Not Enabled: Users logging in via SSO will retain previously assigned roles, unaffected by changes in identity provider assertions.

### Adding Mappings

After configuring mapping rules, the management backend will add members to the appropriate workspaces and assign roles based on the mappings. In **Management > Mapping Rules**, click **Add Mapping**.

![](img/deployment-map.png)

In the new mapping dialog box, input the required **attribute field** and **attribute value**, select the **role**, and click **Save**.

| Field        | Description                                                                 |
| -------------- | ----------------------------------------------------------------------------- |
| Attribute Field/Value | The attribute fields and values configured for mapping must match those on the IdP account for successful validation. Successful validation assigns the corresponding role permissions upon IdP login. |
| Workspace     | All workspaces in the management backend.                                    |
| Role          | <<< custom_key.brand_name >>> supports four default member roles: **Owner**, **Administrator**, **Standard**, and **Read-only**. You can also create new roles in **[Role Management](../management/role-management.md)** and assign permissions to meet different user needs. |

![](img/deployment-map-1.png)

### Searching/Editing/Deleting Mapped Roles

- Search: Filter mapped roles by workspace, role, attribute field, or attribute value.
- Edit/Delete: Click the **Edit/Delete** button to the right to modify existing mapped roles. Changes do not affect currently logged-in accounts but will impact future logins.

![](img/deployment-map-2.png)

## Audit Logs {#audit}

Navigate to **Management > Audit Logs** to view all audit events.

### Time Widget

By default, all audit events are listed. You can add a time range to further filter and refine the list.

![](img/time.png)

Selecting a date range will list all audit events within that period. Default start time `00:00:00`, default end time `23:59:59`.

- After selecting a time range, click **Select Time** to customize the time range.
- Click **Clear** to remove the time filter.

### Search & Export

| Action      | Description                                                                 |
| ----------- | ----------------------------------------------------------------------------- |
| Search :octicons-search-16: | You can search by audit event title or description content.                          |
| Export :octicons-gear-24:   | Click the button to export the current audit events as a CSV file.                  |

### Audit Event Details Page

Click on a specific event in the list to expand its details page. Here, you can view the attributes and content of the audit event.

![](img/detail.png)

## Workspace Audit Events {#audit}

You can view audit events for all workspaces.

![](img/audit.png)

You can filter events by workspace or time range, or directly input relevant titles and descriptions to search and locate events:

![](img/audit-1.png)

## Security Settings {#security}

### Password Rotation Policy

To enhance the security of the management backend, <<< custom_key.brand_name >>> Deployment Plan provides a password rotation policy. By default, **Password Rotation Policy** is **Not Enabled**.

You can choose a password validity period: 3 months, 6 months, 12 months; default is off.

![](img/code.png)

**Note**: Seven days before the password expires, you will receive daily reminder emails about the upcoming expiration. You can reset your password via the email. The new password cannot be the same as the current one.

### Login Session Management {#login-status}

<<< custom_key.brand_name >>> allows unified configuration of login session durations for front-end users. When disabled, front-end workspace members can configure session durations freely; when enabled, they must follow the set duration.

In **Login Session Duration**, click **Modify** to adjust the default login session duration, including idle session duration and maximum session duration. After setting, expired sessions will be invalidated.

- Idle session duration: Settable range 30 ~ 1440 minutes, default is 180 minutes.
- Maximum session duration: Settable range 1 ~ 7 days, default is 7 days.

![](img/login-status.png)

### Console/Management Backend MFA Security Authentication {#mfa}

Both <<< custom_key.brand_name >>> workspaces and the management backend offer mandatory multi-factor authentication (MFA) to add an extra layer of security beyond username and password. Enabling MFA requires a second verification step during login, enhancing account security.

If you prefer not to use secondary verification, you can check "Exempt from Authentication" to simplify the login process.

<img src="../img/login-mfa.png" width="60%" >

- Default: Members can use any authenticator app to complete MFA binding and verification.
- Custom: Members must use a specified app for MFA binding and verification, implemented via DataFlux Func. In custom MFA mode, unbinding MFA simultaneously unbinds <<< custom_key.brand_name >>> side MFA for the account.

### Independent Alert Notifications {#alarm}

<<< custom_key.brand_name >>> supports sending independent alert notifications without aggregation.

In non-aggregated alert notification mode, alerts are sent every 20 seconds as individual notifications to the corresponding notification targets. You can `enable/disable` independent alert notifications, configuring whether alerts should be aggregated into a single notification.

![](img/setting01.png)

### Event Link Public Access {#link}

Alert notifications include jump links that can be publicly shared. Configuring **Event Link Public Access** allows these links to be accessed without login. Enabling this feature means all workspace-sent alert notification links can be viewed without login. Disabling it revokes access for all historical public links.

![](img/setting02.png)

### Login Method Management {#login-method}

Currently, you can log in to <<< custom_key.brand_name >>> console using local accounts, LDAP accounts, or OIDC. Click **Modify** to manage user account login methods.

- Local Account: Accounts created via [Register <<< custom_key.brand_name >>>](../plans/commercial-register.md).
- [LDAP Account](./ldap.md).
- OIDC: Single sign-on via OpenID Connect protocol. Refer to:
    
    - [Keycloak](./keycloak-sso.md)
    - [Azure Active Directory](./azure-ad-pass.md)

### DataKit Management {#datakit}

On this page, administrators can view information about hosts where DataKit has been installed, including run ID, IP address, operating system, hardware platform, count, and DataKit version across different workspaces.

**Note**: For DataKit running in gateway mode, the "count" does not follow physical counts but adheres to CPU core statistics.

For managing this list:

1. Use dropdown filters for workspaces and DataKit versions.
2. Enter host name, run ID, or IP address in the search bar to locate data.
3. Select "Show Online Hosts Only" and filter hosts by data reporting intervals (last 10, 15, 30 minutes, 1 hour, 3 hours).
4. Export DataKit inventory data for troubleshooting and capacity planning.

5. Adjust displayed columns for specific list information:

<img src="../img/datakit-1.png" width="70%" >

**Note**: If the number of DataKits exceeds the license limit, monitor usage across workspaces. Renewal and additional purchases may be necessary to continue using <<< custom_key.brand_name >>>. Contact your client manager to increase DataKit usage.

### Global Configuration {#global-settings}

#### Incident Level Management

You can manage global incident level configurations for all workspaces from this entry point.

**Note**: Enabling global configuration overrides workspace-level incident level settings.

![](img/global-settings.png)

Click **Add Level**, choose a color block, input the level name and description, and confirm to create.

For levels, you can:

1. Edit: Modify the color, name, and description of a custom level.
2. Delete: Remove a level. If this level is used in monitors, smart monitoring, or issue auto-discovery rules, new issues will have an empty level.

### Global DCA Configuration {#dca}

DCA is the online DataKit management platform. Here, you can view DataKit runtime status and manage collectors, blacklists, and Pipelines.

Enabling this configuration syncs the DCA address to all workspaces, overriding original workspace DCA addresses.

1. Enable the switch.
2. Input the new DCA URL.
3. Click Confirm.

After enabling the new configuration, clicking "Configure DCA Address" in the workspace will pre-fill with the backend-configured address and prevent editing.

![](img/dca.png)

Disabling DCA configuration restores the original DCA settings in workspaces, allowing editing of DCA addresses.