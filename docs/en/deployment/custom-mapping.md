# Custom Mapping

In the Deployment Plan workspace, custom mapping rules are used to dynamically manage workspace member roles and permissions. After configuration is enabled, users accessing the system through the single sign-on entry will have role permissions dynamically assigned according to the priority order of **workspace custom mapping rules over backend management mapping rules**.

![](img/custom-mapping.png)


## Create Mapping

<img src="../img/custom-mapping-1.png" width="60%" >

- Attribute Fields/Attribute Values: The attribute fields and values in the SAML mapping configuration must match those configured on the IdP account for the SAML mapping to be successfully verified. Upon successful verification, when logging in with an IdP account, the corresponding role permissions from the SAML mapping will be assigned to the account;
- Role Authorization: <<< custom_key.brand_name >>> supports four default member roles: Owner, Administrator, Standard, and Read-only; or custom roles created in [Role Management](../management/member-management.md). Multiple selections are supported.


## Search/Edit/Delete Mapping

- Search: Supports searching for configured mapping roles by role, attribute field, or attribute value;
- Edit: Supports re-modifying already configured mapping roles;
- Delete: Supports directly deleting or batch deleting already configured mapping roles.