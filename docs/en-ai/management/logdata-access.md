# Data Access
---

Logs, RUM, APM, and Metrics data may contain sensitive information. Therefore, for security reasons, even within the same business organization, detailed divisions of data access permissions are necessary. The **Data Access** feature in Guance first sets the data access scope at the [member role](../management/role-list.md) level based on different sources of indexes. Additionally, to further protect the data, regular expressions and desensitization fields can be used to "re-edit" the data as needed while restricting access, ensuring that sensitive information is properly handled without sacrificing data value.

In the **Management > Data Access** page, new rules can be created using the following two methods:

:material-numeric-1-circle: Click the **New Rule** button in the top left corner of the page to start creating;

:material-numeric-2-circle: If there are existing historical access rules on the current page, click the :octicons-copy-24: icon under the operations on the right side of the rule to clone an existing rule and then create.

## Getting Started with Configuration

<img src="../img/data-2.png" width="80%" >

1. Select the data type;
2. Define the name of the current rule;
3. Enter a description for the current rule;
4. For the selected data type, choose the corresponding [**index**](../logs/multi-index/index.md), service, application, and metrics;

5. Define the [access scope](#scope) of the data under the current rule;

6. Add one or more fields that need to be desensitized;

7. Use regular expressions to desensitize sensitive information in field content;

8. Select one or more member roles that this access rule applies to, including default roles and user-defined roles;
9. Click save.

## Configuration Guidelines {#config}   

### Defining Data Access Scope {#scope}

**Data Scope**: Members within the access rule can only view data that matches the filtering conditions.

The logical relationship between different fields can be customized to either **Any (OR)** or **All (AND)**;

- By default, **All (AND)** is selected, but it can be switched to **Any (OR)**:

- Logical relationship examples are as follows:
    
    - Example 1: (Default AND)
    
        - host=[host1,host2] AND service = [service1,service2];
    
    - Example 2: (Switched to Any OR)

        - host=[host1,host2] OR service = [service1,service2].
        
- Support filtering values via `tags/attributes`, including positive filtering, negative filtering, fuzzy matching, reverse fuzzy matching, exist and not exist.

### Regular Expression Desensitization {#regex}

When setting up access rules, even though data scope has been defined, additional measures are needed to prevent leakage of sensitive or unnecessary information. At this point, **desensitization fields** or **regular expressions** can be used to further process the data for enhanced protection.

In the configuration page, besides directly adding individual desensitization fields, if further desensitization of certain parts of log `message` such as token or IP information is required, regular expressions can be added to meet this need.

1. Multiple regular expressions can be configured, with up to 10 expressions per access rule;
2. Individual regular expressions can be disabled or enabled, with only enabled expressions applied during subsequent use and preview;
3. Direct editing or deletion of individual regular expressions is supported;
4. Drag-and-drop reordering of regular expressions is supported, with data matched to desensitization rules applied in top-down order;
5. New regular expressions can be created directly here:

<img src="../img/data-3.png" width="50%" >

In the pop-up window, [enter the required information](../management/regex.md#diy).

<img src="../img/data-4.png" width="60%" >

If **Apply to Rule** is checked, this rule will be added directly below the regular expression.

<img src="../img/data-5.png" width="50%" >

### Role Scenarios and Query Permissions {#role_permission}

#### Simple Scenario

Assume a member only holds one role, such as `read-only`. After selecting this role, the system will apply desensitization only to this role's configurations.

If "All" is selected, all roles except Owner will be affected by desensitization.

<img src="../img/data-9.png" width="60%" >

**Note**:

1. Default roles have full query permissions if no data access rules are configured;
2. Data access rules take effect based on **user roles having data query permissions**;
3. After role matching rules, you can only add filters within the configured scope. Queries outside this scope will return empty data.

#### Multi-role Permission Overlap

If a member **holds multiple roles**, and these roles have different query permission scopes (as shown in the figure below), the final data query permissions for the member will be the **sum of all role data access viewing scopes**.

<img src="../img/logdata_8.png" width="70%" >

#### Multi-rule Permission Control

In complex business data with many layers, sometimes multiple access rules need to be set for different data sources and attributes to accommodate various data access needs.

1. Relationship between multiple filters in one rule: multiple values of the same key are OR, relationships between different keys are AND;  
2. Relationships between multiple rules are OR.  

So, if:

Rule 1: host = [Host1, Host2] AND service = [Service1, Service2]   
Rule 2: host = [Host3, Host4] AND source = [Source1, Source2]

For a role that **has both rules above**, the actual data will show `Rule 1 OR Rule 2` to achieve union effect.

The actual visible data range is:  
    
`(host = [Host1, Host2] AND service = [Service1, Service2]) OR (host = [Host3, Host4] AND source = [Source1, Source2])`

If a role has multiple permission rules and Rule 1 contains desensitization rules, all data returned under all permission rules will be affected by the desensitization rules.

## Configuration Example

1. Select the index `rp70` of this workspace;
2. Set the data scope to `host:cn-hangzhou.172.**.**` and `service:kodo`;
3. Here we do not set desensitization fields but directly write the regular expression `tkn_[\da-z]*` to encrypt `token` information;
4. Finally, assign the current access rule to all `Read-only` members within the workspace.
5. Click save. If needed, click **Preview** in the lower-left corner to check the desensitization effect.

<img src="../img/data-6.png" width="80%" >

This access rule applies to all `Read-only` members within the current workspace, allowing them to access logs indexed `rp70` where `host:cn-hangzhou.172.**.**` and `service:kodo`, and they cannot see any `token` information in such data.

## Application Scenarios {#snapshot}

Based on effective data access rules, members who match the rules will receive snapshot data automatically filtered according to their permission rules. Even if the [snapshot](../getting-started/function-details/snapshot.md) contains data beyond the member's access permissions, the system will filter it first, and the member can only view data that complies with their access rules.

## Management List {#list}

1. View: In the data access rule list, you can directly view related indexes, data query conditions, whether desensitization is applied, and the number of associated roles and members.
2. Show Only Rules Related to Me:

    - The system defaults to "Off", meaning all data access rules are displayed by default;

    - Enabling this option will display only data access rules related to the current account's role.

3. Enable/Disable Rules: Modify the status of data access rules. When rules are disabled, different roles have unrestricted access to data queries. When rules are enabled, restrictions are restored.
4. Click the edit button to modify settings such as the rule name, description, bound indexes, filter conditions, and authorized roles.
5. Click the clone button to quickly copy the current rule.
6. Operation Audit: Logs of actions related to this rule.
7. Click the delete button to delete the rule.
8. Batch enable, disable, and delete multiple rules.

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Permission Application Scenarios Combining Data Access and Sensitive Data Desensitization Rules**</font>](./access_mask_combine.md)

</div>

</font>