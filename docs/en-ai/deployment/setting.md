# Management
---

## Administrators

On the **Settings > Administrators** page, you can search for, add, modify, and disable/enable all administrator accounts.

Administrator account roles are currently divided into two types: <u>Administrator and Developer</u>:

- Administrator: Has all management permissions and can log in to the management backend and the DataFlux Func (Automata) development platform;
- Developer: Can only log in to the DataFlux Func (Automata) development platform.

![](img/20.deployment_3.png)

### Adding an Administrator

On the **Settings > Administrators** page, click **Add Administrator** in the top-right corner. In the pop-up dialog box, enter the administrator account information, select role permissions, input the password, and click OK to add a new administrator.

![](img/20.deployment_4.png)

### Modification

On the **Settings > Administrators** page, click **Modify** next to the account to enter the **Edit Administrator Information** page. You can modify the administrator's account and role permissions.

![](img/20.deployment_5.png)

### Reset Password

On the **Settings > Administrators** page, click **Reset Password** to change the password for that administrator account.

![](img/20.deployment_6.png)

### Disable/Enable Members

On the **Settings > Administrators** page, click **Disable** or **Enable** next to the account to switch the account status.

**Note**: If the current logged-in account is disabled, the login credentials become invalid, and you will be automatically logged out of the management backend. You will not be able to log back in until the account is re-enabled.

## Basic Information

In the Guance management backend **Settings > Basic Information** page, you can customize settings such as the default language, product name, logo, and browser display icon.

![](img/20.deployment_1.png)

Additionally, you can view Workspace License information and software details, including service expiration dates, DataKit quantity limits, License version, affiliation, and expiration dates:

![](img/basic-info.png)

## User Settings

On the **Settings > User Settings** page, you can change the password for the currently logged-in account.

![](img/20.deployment_2.png)

## Mapping Rules {#mapping}

Guance Deployment Plan supports single sign-on (SSO) using OpenID Connect/OAuth 2.0/LDAP protocols and allows configuring mapping rules for these SSO accounts. After enabling mapping, you can dynamically assign access permissions to enterprise employees based on their assigned roles.

???+ warning "When an SSO account is set as a workspace owner, note:"

    The account’s role in this workspace is fixed as the owner and **is not affected by mapping rules**. Conversely, roles are assigned according to actual mapping rules.

    <img src="../img/owner-mapping.png" width="70%" >

> Besides configuring mapping rules in the management backend, you also need to [configure Keycloak SSO mapping rules](./keycloak-rule.md). Both configurations must be completed for the mapping rules to take effect.

### Application Scope

In **Management > Mapping Rules**, you can choose between **Effective Only on First Login** and **Globally Effective**:

:material-numeric-1-circle: Effective Only on First Login

When you enable this option, if a user logs in via SSO for the first time, they will be added to the workspace and assigned a role based on the mapping rules.

**Note**: Previously logged-in SSO member accounts are not affected by the mapping rules.

:material-numeric-2-circle: Globally Effective

When you enable this option, SSO user accounts will have their current workspace roles revoked and reassigned based on the attributes provided by the identity provider. If no matching mapping rule is found, the user will lose all roles and will not be allowed to log in to the Guance workspace.

**Note**: Every login requires dynamic role assignment; deleting a mapping rule in the management backend will make the corresponding workspace inaccessible to users.

:material-numeric-3-circle: Not Enabled: Users logging in via SSO will retain previously assigned roles, unaffected by changes in identity provider assertions.

### Adding Mappings

After configuring mapping rules, the management backend will add members to the appropriate workspaces and assign roles based on the mappings. In **Management > Mapping Rules**, click **Add Mapping**.

![](img/deployment-map.png)

In the new mapping dialog box, input the **Attribute Field** and **Attribute Value**, select the **Role**, and click **Save**.

| Field      | Description                          |
| ----------- | ------------------------------------ |
| Attribute Field/Value       | The attribute fields and values configured must match those set up on the IdP account for successful validation. Once validated, the IdP account will be assigned the mapped role upon login.  |
| Workspace      | All workspaces available in the management backend. |
| Role   | Guance supports four default member roles: **Owner**, **Administrator**, **Standard**, and **Read-only**. You can also create new roles in **[Role Management](../management/role-management.md)** and assign permissions to meet different user needs. |

![](img/deployment-map-1.png)

### Searching/Editing/Deleting Mapped Roles

- Search: You can filter and view mapped roles by workspace, role, attribute field, or attribute value.
- Edit/Delete: You can click the **Edit/Delete** button on the right to modify existing mapped roles. Changes do not affect currently logged-in users but will impact subsequent logins.

![](img/deployment-map-2.png)

## Operation Audit {#audit}

Go to **Management > Operation Audit** to view all audit events.

### Time Controls

By default, all audit events are listed. You can add a time range for further filtering.

![](img/time.png)

Selecting a date range will list all audit events within that period. The default start time is `00:00:00`, and the default end time is `23:59:59`.

- After selecting a time range, click **Select Time** to define a custom range;
- Click **Clear** to remove the time filter.

### Search & Export

| Action      | Description                          |
| ----------- | ------------------------------------ |
| Search :octicons-search-16:    | You can search by audit event title or description.                          |
| Export :octicons-gear-24:      | Click to export the current audit events as a CSV file.                          |

### Audit Event Details Page

Click on a specific event in the list to expand its details page. Here, you can view the properties and content of that audit event.

![](img/detail.png)

## Workspace Audit Events {#audit}

You can view audit events for all workspaces.

![](img/audit.png)

You can filter events by workspace or time range, or directly input relevant titles and descriptions for searching:

![](img/audit-1.png)

## Security Settings {#security}

### Password Rotation Policy

To enhance the security of the management backend, Guance Deployment Plan provides a password rotation policy. By default, the **Password Rotation Policy** is **Not Enabled**.

You can choose a password validity period: 3 months, 6 months, or 12 months; it is disabled by default.

![](img/code.png)

**Note**: Seven days before the password expires, you will receive daily reminder emails to reset your password. The new password cannot be the same as the current one.

### Login Session Management {#login-status}

Guance supports unified configuration of login session duration for frontend users. When disabled, workspace members can configure their own session durations freely; when enabled, members must follow the preset configuration.

In **Login Session Duration**, click **Modify** to set the default login session duration, including idle session duration and maximum session duration. After setting, expired sessions will become invalid.

- Idle session duration: Range from 30 to 1440 minutes, default is 180 minutes;
- Maximum session duration: Range from 1 to 7 days, default is 7 days.

![](img/login-status.png)

### Console/Management Backend MFA Security Authentication {#mfa}

Both the Guance workspace and management backend provide mandatory Multi-Factor Authentication (MFA) to add an extra layer of security beyond username and password. Enabling MFA requires a second verification step during login, enhancing account security.

If you do not require secondary verification, you can check “Exempt from Authentication” to simplify the login process.

<img src="../img/login-mfa.png" width="60%" >

- Default: Members can use any authenticator app to complete MFA binding and authentication;
- Custom: Members must use a specified app for MFA binding and authentication, which requires implementation via DataFlux Func. In custom MFA mode, unbinding MFA on the Guance side will also unbind MFA from the user account.

### Independent Alert Notifications {#alarm}

Guance supports sending independent alert notifications when alerts are not aggregated.

In non-aggregated alert notification mode, alert events are combined into a single notification every 20 seconds and sent to the designated notification targets. You can configure whether to send alert notifications independently or combine them into one notification.

![](img/setting01.png)

### Event Link Public Sharing {#link}

Alert notifications include built-in jump links that can be viewed through public sharing. You can configure **Event Link Public Sharing**. Enabling this feature allows all event links in workspace alerts to be accessed without login. Disabling it will invalidate all previously shared links.

![](img/setting02.png)

### Login Method Management {#login-method}

Currently, you can log into the Guance console via local accounts, LDAP accounts, or OIDC. Click **Modify** to manage user login methods.

- Local account: Accounts created by [registering with Guance](../plans/commercial-register.md);
- [LDAP Account](./ldap.md);
- OIDC: Single sign-on via the OpenID Connect protocol, refer to:
    
    - [Keycloak](./keycloak-sso.md)
    - [Azure Active Directory](./azure-ad-pass.md)

### DataKit Management {#datakit}

On this page, administrators can view host information for DataKit installations across different workspaces, including run ID, IP address, operating system, hardware platform, count, and DataKit version.

**Note**: If DataKit runs in gateway mode, the “count” does not follow physical counts but CPU Core statistics.

For this list, you can:

1. Use dropdowns to filter by workspace or DataKit version;
2. Enter host name, run ID, or IP address in the search bar to locate data;
3. Check “Show Online Hosts Only” and filter hosts by recent activity (last 10, 15, 30 minutes, 1 hour, 3 hours).
4. Export DataKit inventory data for troubleshooting and capacity planning.

5. Adjust displayed columns for better visibility:

<img src="../img/datakit-1.png" width="70%" >

**Note**: If the number of DataKits exceeds the license limit, monitor usage across workspaces. If this occurs, renew licenses and avoid upgrading Guance versions until resolved. Contact your customer manager to purchase additional DataKit units.

### Global Configuration {#global-settings}

#### Incident Level Management

From this entry point, you can uniformly manage incident level configurations across all workspaces.

**Note**: Enabling global configuration disables workspace-level incident level settings.

![](img/global-settings.png)

Click **Add Level** to select a color, input a level name and description, and create successfully.

For levels, you can:

1. Edit: Modify the current custom level’s color, name, and description.
2. Delete: Remove the current level. If used in monitors, smart monitoring, or issue auto-discovery rules, new issues will have no level assigned.

### Global DCA Configuration {#dca}

DCA is the DataKit online management platform where you can view DataKit runtime status and manage collectors, blacklists, and pipelines.

Enabling this configuration will sync the DCA address to all workspaces, overriding existing workspace DCA addresses.

1. Enable the switch;
2. Input the new DCA URL;
3. Click OK.

Once enabled, clicking “Configure DCA Address” in workspaces will pre-fill with the management backend-configured address and prevent editing.

![](img/dca.png)

If you disable DCA configuration, workspaces revert to original DCA settings, allowing DCA address editing.