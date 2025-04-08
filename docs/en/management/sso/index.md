# SSO Management
---

<<< custom_key.brand_name >>> supports SAML-based and OIDC/Oauth2.0 protocol SSO management. Enterprises can manage employee information in the local IdP (identity provider) without synchronizing users between <<< custom_key.brand_name >>> and the enterprise IdP, allowing employees to log in and access <<< custom_key.brand_name >>> through specified roles.

In SSO Management, you can:

- [Configure single sign-on based on the corporate domain](#corporate)
- [Enable role mapping based on the corporate domain for more precise single sign-on](./role_mapping.md)

## User SSO {#corporate}

If an employee's email matches the domain suffix of the unified identity authentication of the company, they can log in to <<< custom_key.brand_name >>> via this email and access the system according to the configured permissions.

1. Navigate to **Management > Member Management > SSO Management > User SSO**;
2. Select [SAML](#saml) or [OIDC](#oidc) as needed;
3. Start configuration.

???+ warning "Note"

    - You can create multiple SSO IDP configurations, with a maximum of 10 configurations per workspace;
    - When configuring the same identity provider SSO single sign-on across multiple workspaces, users who log in via SSO can switch between different workspaces by clicking the workspace option in the top-left corner.

### Access Types

:material-numeric-1-circle: [SAML](./saml.md)   
:material-numeric-2-circle: [OIDC](./oidc.md)    


## SSO List

### Role Mapping

- Enable role mapping:   

    - SSO login users are dynamically assigned roles based on matching role mapping rules from the `attribute fields` and `attribute values` provided by the identity provider;  
    - Users who do not match any mapping rule will have all roles removed and will be unable to log in and access the workspace.

- Disable role mapping: Single sign-on users retain previously assigned roles and are unaffected by changes in assertions from the identity provider side.


### Enable/Update/Delete/Import/Export

After adding an identity provider, you can enable or disable the current SSO configuration as needed. After enabling, the following operations are supported:

- Update SSO Configuration: This operation may affect the login experience of existing SSO members, so proceed with caution;    
- Delete SSO Configuration: This operation will remove the current single sign-on configuration, preventing related members from logging in via this configuration. Proceed with caution;
- Import/Export Identity Providers: Support importing and exporting identity provider configurations, making it convenient to quickly replicate them across multiple workspaces.

???+ warning "Note"

    - When exporting files, the file name cannot be the same as any existing identity provider in the current workspace.
    - Exported files must comply with JSON format standards.


### View SSO Members

- Member Count: Displays the total number of members who have logged in via SSO.  
- Member List: Click on the member count to view the specific list of authorized SSO members.


### Email Notifications

When enabling, configuring, or deleting SSO, Owners and Administrators of the workspace will receive relevant email notifications.


## Login Verification {#login}

1. Log in via email to <<< custom_key.brand_name >>> SSO page: https://<<< custom_key.studio_main_site_auth >>>/login/sso;
2. Enter the email address configured during SSO creation to access all authorized workspaces for that identity provider;
3. Login address;
4. Input username, password, etc.;
5. Successful login.


<img src="../img/sso_login.png" width="70%" >


<img src="../img/sso_login_1.png" width="70%" >

???+ warning "Note"

    - If the workspace has enabled [role mapping](./role_mapping.md), but the current user does not match any role or the role mapping is disabled, a prompt of "No access permission" will appear;   
    - After deleting the identity provider from the workspace, users selecting SSO login will no longer see unauthorized workspaces.