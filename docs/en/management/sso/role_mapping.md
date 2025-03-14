# Role Mapping 
---

Based on the added [SSO configuration](./index.md), after enabling role mapping, access permissions can be dynamically assigned to employees. Employees will access <<< custom_key.brand_name >>> according to the allocated role permissions.


## Adding Mappings

1. Navigate to **Manage > Member Management > SSO Management > Role Mapping**;
2. Click **Add Mapping** to start creating a new mapping relationship;
3. Identity Provider: Select from all identity providers available in the current workspace;
4. Define `Attribute Field`, `Attribute Value`: The configured attribute fields and values must match those set up in the identity provider (IdP) account to successfully verify and assign the corresponding role permissions;
5. Select roles for authorization.

![](../img/5.sso_mapping_10.png)

## Managing Mappings

The following operations can be performed to manage mapping rules:

- Search & Filter: Support searching for mapping relationships by role, attribute field, or attribute value, and filter by identity provider.
- Edit: Modify existing mapping configurations. If an SSO login user does not match any role, they will lose all roles and will not be able to log into the <<< custom_key.brand_name >>> console.
- Delete: Directly or batch delete mapping relationships. After deletion, users who do not match any role will lose all roles and will not be able to log into the <<< custom_key.brand_name >>> console.