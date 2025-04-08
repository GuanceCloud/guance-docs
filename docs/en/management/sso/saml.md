# SAML 
---


## Start Configuration

1. Identity Provider: A platform that provides identity management services, used to manage user identities and authentication information. Define the name here.                          
2. Metadata Document: An XML document provided by the IdP. 
3. Remarks: Custom-added descriptive information, used to record relevant explanations about the identity provider.  
4. Access Restrictions: Verifies whether the login email domain suffix matches the configured domain. Only matching email addresses have access to the SSO login link. The first-time user can dynamically create a <<< custom_key.brand_name >>> member account without needing to create it in advance within the workspace.
5. Role Authorization: Assign roles to SSO accounts logging in for the first time; accounts logging in non-first times are unaffected.

    - If [SAML Mapping](./role_mapping.md) is enabled within the workspace, roles will be assigned according to the mapping rules with priority.

6. [Session Persistence](#login-hold-time): Set the idle persistence time and maximum persistence time for SSO login sessions. After timeout, the login session will become invalid.  

> For more information on role permissions, refer to [Role Management](../role-management.md).  

### Obtain Entity ID and Assertion Address {#obtain}

After successfully adding the identity provider, click the **Update** button on the right to obtain the **Entity ID** and **Assertion Address**, which can then be completed according to the SAML configuration requirements of the identity provider.

<img src="../img/metadata.png" width="70%" >


| Field      | Description                  |
| ----------- | ------------------- |
| Login URL       | Generated based on the metadata document, this is the <<< custom_key.brand_name >>> SSO login URL for accessing one specific workspace.  |
| Metadata      | Generated based on the metadata document, this is the <<< custom_key.brand_name >>> SSO metadata file.                  |
| Entity ID      | Generated based on the metadata document, this is the <<< custom_key.brand_name >>> SSO login Entity ID. Used to identify the service provider (SP) in the identity provider (IdP), such as << custom_key.brand_name >>>.    |
| Assertion Address      | Generated based on the metadata document, this is the <<< custom_key.brand_name >>> SSO login assertion target address. Used by the identity provider (IdP) to call and complete single sign-on.                  |


### Session Persistence {#login-hold-time}

When configuring SSO single sign-on, you can set a unified login persistence time for enterprise members logging in via SSO, including "idle login session persistence time" and "maximum login session persistence time".

- Idle login session persistence time: Supported range is 180～1440 minutes, default value is 180 minutes.
- Maximum login session persistence time: Supported range is 0～7 days, where 0 indicates never expiring, default value is 7 days.

???+ abstract "Example Explanation"

    After updating the SSO login persistence time:

    - Already logged-in members: Their login session expiration time remains unchanged.    
    - Newly logged-in members: The latest login persistence time settings take effect.       

    For example:  

    - When initially configuring SSO, the idle session expiration time is 30 minutes. Member A logs in at this time, so their idle session expiration time is 30 minutes.       
    - The administrator subsequently updates the idle session expiration time to 60 minutes. Member A's idle session expiration time remains 30 minutes, while Member B, who logs in afterward, will have an idle session expiration time of 60 minutes, and so on.