# Custom Mapping

In the workspace of the Deployment Plan, custom mapping rules are used to dynamically manage workspace member roles and permissions. After enabling the configuration, users accessing the system through the single sign-on entry will have their role permissions dynamically assigned based on the priority order where **custom mapping rules in the workspace take precedence over the backend management mapping rules**.

![](img/custom-mapping.png)


## Create a New Mapping

<img src="../img/custom-mapping-1.png" width="60%" >

- Attribute Field/Attribute Value: The attribute fields and values configured in the SAML mapping must match those configured in the IdP account for successful validation. Upon successful validation, when an IdP account logs in, it will be assigned the role permissions corresponding to the SAML mapping;
- Role Authorization: Guance supports four default member roles: Owner, Administrator, Standard, and Read-only; or custom roles created in [Role Management](../management/member-management.md). Multiple selections are supported.


## Search/Edit/Delete Mappings

- Search: Supports searching for configured mapping roles by role, attribute field, or attribute value;
- Edit: Supports re-modifying already configured mapping roles;
- Delete: Supports directly deleting or selecting multiple mappings for batch deletion.