# Data Access
---

Guance allows restricting RUM data access permissions for workspace members at the application level. Additionally, by introducing regular expressions and desensitization fields, it effectively enhances the security protection of different application data, ensuring information security.

## Getting Started

1. Enter the new rule creation page;
2. Input the rule name;
3. Optionally input a description for this rule;
4. Select the Application ID (only applications within the current workspace can be selected). You can apply the rule to all applications or select individual/multiple applications covering Web, iOS, Android, etc.;
5. Define the [access scope](../management/logdata-access.md#scope) for RUM data under this rule;

6. Add single or multiple fields that need desensitization;

7. Use regular expressions to desensitize sensitive information in field content;
8. Select one or more member roles to which this access rule applies, including default system roles and custom roles;
9. Click save.

![RUM Data](../img/rum_data.png)

## Configuration Notes

When configuring data access rules, three main logics must be considered:

- [Data Access Scope](../management/logdata-access.md#scope): Members within the access rule can only access data matching the filter conditions.
- [Regular Expression Desensitization](../management/logdata-access.md#regex): If you need an additional layer of data protection on top of defined data scopes, you can set up regular expressions or desensitization fields to shield sensitive data;
- [Role Scenarios and Query Permissions](../management/logdata-access.md#role_permission): Different roles and rules applied individually or cumulatively will produce varying results in the final presentation of data access rules.

## Management List

> For more details, refer to [List Operations](../management/logdata-access.md#list).

## Precautions

**Cross-Workspace Queries**: If two workspaces contain the same application, specific roles can only view filtered data from the authorized workspace according to the permission settings in the data access rule.

**Prerequisite**: Both `Workspace A` and `Workspace B` have the `whytest-android` application, and `Workspace B` has granted RUM application data viewing permissions [authorization](../management/data-authorization.md#site) to `Workspace A`.

When configuring data access rules (as shown in the figure below), `Workspace A` restricts the "Custom Management" role to view only the `source:kodo` data under the `whytest-android` application.


![RUM Data 1](../img/rum_data_1.png)

In this scenario:

:material-numeric-1-circle: [RUM Explorer](./explorer/index.md)

Since the explorer does not support cross-workspace queries, the "Custom Management" role can only view the RUM data of the `whytest-android` application under `Workspace A` in the RUM Explorer.

:material-numeric-2-circle: [Dashboard](../scene/dashboard/config_page.md#cross-workspace)

When selecting both `Workspace A` and `Workspace B` for data queries and querying data from both the `whytest-android` and `whytest-ios` applications in DQL, since the current data access restriction rules limit the "Custom Management" role's access, and the `whytest-android` application data from `Workspace B` as well as the `whytest-ios` application data from both `Workspace A` and `Workspace B` have not been configured with access permissions,

Therefore, the "Custom Management" role can only access the `whytest-android` application data from `Workspace A`.

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