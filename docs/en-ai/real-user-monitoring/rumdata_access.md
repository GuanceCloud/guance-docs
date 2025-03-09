# Data Access
---

<<< custom_key.brand_name >>> allows restricting RUM data access permissions for workspace members at the application level. Additionally, by introducing regular expressions and desensitization fields, it effectively enhances the security protection of different application data, ensuring information security.

## Start Creating

1. Enter the Create page;
2. Input the rule name;
3. Optionally input a description for this rule;
4. Select the Application ID (only applications within the current workspace can be selected). You can apply the rule to all applications or select individual/multiple applications covering Web, iOS, Android, etc.;
5. Define the [access scope](../management/logdata-access.md#scope) for RUM data under this rule;

6. Add one or more fields that need desensitization;

7. Use regular expressions to desensitize sensitive information in field content;
8. Select one or more member roles to which the current access rule applies, including default roles and user-defined roles;
9. Click Save.

<img src="../img/rum_data.png" width="70%" >

## Configuration Notes

When configuring data access rules, note the following three logics:

- [Data Access Scope](../management/logdata-access.md#scope): Members within the access rule can only access data that matches the filtering conditions.
- [Regular Expression Desensitization](../management/logdata-access.md#regex): If you need an additional layer of data protection on top of the defined data scope, you can set up regular expressions or desensitization fields to shield sensitive data.
- [Role Scenarios and Query Permissions](../management/logdata-access.md#role_permission): Different roles and rules, either individually or combined, will produce different outcomes in the final presentation of the data access rule.

## Management List

> For more details, refer to [List Operations](../management/logdata-access.md#list).

## Important Points

**Cross-Workspace Queries**: If two workspaces contain the same application, specific roles can only view filtered data from the authorized workspace according to the permission settings in the data access rule.

**Prerequisite**: Both `Workspace A` and `Workspace B` contain the `whytest-android` application, and `Workspace B` has [authorized](../management/data-authorization.md#site) `Workspace A` to view RUM application data.

When configuring the data access rule (as shown below), `Workspace A` restricts the "Custom Management" role to view only the data from `whytest-android` where `source:kodo`.

<img src="../img/rum_data_1.png" width="80%" >

The following scenarios exist:

:material-numeric-1-circle: [RUM Explorer](./explorer/index.md)

Since this explorer does not support cross-workspace queries, the "Custom Management" role can only view RUM data from the `whytest-android` application under `Workspace A` in the RUM Explorer.

:material-numeric-2-circle: [Dashboard](../scene/dashboard/config_page.md#cross-workspace)

When selecting both `Workspace A` and `Workspace B` for data queries and querying data from both `whytest-android` and `whytest-ios` applications in DQL, since the current data access restriction rule limits the "Custom Management" role and no access permissions are configured for `whytest-android` in `Workspace B` or `whytest-ios` in either workspace,

ultimately, the "Custom Management" role can only access data from the `whytest-android` application in `Workspace A`.

## Further Reading

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Log Data Access Control**</font>](../management/logdata-access.md)

</div>



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Power of the Explorer**</font>](../getting-started/function-details/explorer-search.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Snapshots to Enhance Collaboration Efficiency**</font>](../getting-started/function-details/snapshot.md)

</div>


</font>