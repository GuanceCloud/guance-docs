# SAML 
---


## Configure

1. Identity Provider: A platform that provides identity management services, used to manage user identities and authentication information. Define the name here.                          
2. Metadata Document: An XML document provided by the IdP. 
3. Remarks: Custom-added descriptive information, used to record relevant explanations about the identity provider.  
4. Access Restrictions: Verifies whether the email domain suffix of the login matches the configured domain; only matching emails have access to the SSO login link. When users log in for the first time, <<< custom_key.brand_name >>> member accounts can be dynamically created without needing to be pre-created within the workspace.
5. Role Authorization: Assign roles to SSO accounts logging in for the first time; accounts logging in non-initially are unaffected.

    - If [SAML Mapping](./role_mapping.md) is enabled within the workspace, roles will be assigned according to the mapping rules with priority.

6. [Session Persistence](#login-hold-time): Set the inactive persistence time and maximum persistence time for the SSO login session.

> For more on role permissions, refer to [Role Management](../role-management.md).  

### Obtain Entity ID and Assertion URL {#obtain}

After successfully adding the identity provider, click the **Update** button on the right side to obtain the **Entity ID** and **Assertion URL**. Complete the corresponding SAML configuration as required by the identity provider.

<img src="../../img/metadata.png" width="70%" >


| Field      | Description                  |
| ----------- | ------------------- |
| Login URL       | The <<< custom_key.brand_name >>> SSO login URL generated based on the metadata document. Each login URL is limited to accessing one workspace.  |
| Metadata      | The <<< custom_key.brand_name >>> SSO metadata file generated based on the metadata document.                  |
| Entity ID      | The <<< custom_key.brand_name >>> SSO login entity ID generated based on the metadata document. Used to identify the service provider (SP) in the identity provider (IdP), such as << custom_key.brand_name >>>.    |
| Assertion URL      | The <<< custom_key.brand_name >>> SSO login assertion target URL generated based on the metadata document. Used by the identity provider (IdP) to call and complete single sign-on.                  |


### Session Persistence {#login-hold-time}

When configuring SSO single sign-on, you can set a unified login persistence time for enterprise members logging in via SSO, including "inactive login session persistence time" and "maximum login session persistence time".

- Inactive login session persistence time: Supported range is 180～1440 minutes, default value is 180 minutes.
- Maximum login session persistence time: Supported range is 0～7 days, where 0 indicates never timeout, default value is 7 days.

???+ abstract "Example Explanation"

    After updating the SSO login persistence time:

    - Already logged-in members: Their login session expiration time remains unchanged.    
    - Newly logged-in members: The latest login persistence time settings take effect.       

    Example:  

    - Initially configuring SSO, the inactive session expiration time was 30 minutes. Member A logs in at this time, so their inactive session expiration time is 30 minutes.       
    - The administrator subsequently updates the inactive session expiration time to 60 minutes. Member A's inactive session expiration time remains 30 minutes, while for members logging in afterward, such as Member B, the inactive session expiration time will be 60 minutes, and so on.