# Data Access
---

Log, RUM PV, APM, and Metrics data may contain sensitive information. Therefore, for security reasons, even within the same business organization, data access permissions need to be finely divided. The **Data Access** feature of <<< custom_key.brand_name >>> first sets the data access scope at the [member role](../management/role-list.md) level based on different sources of indexes for the target visitors. Additionally, to further protect the data, tools such as regular expressions and desensitization fields can be used to "re-edit" the data on top of restricted access, ensuring that sensitive information is properly handled without compromising the value of the data.

In the **Management > Data Access** page, new rules can be created using the following two methods:

:material-numeric-1-circle: Click the **Create** button in the top-left corner of the page to start creating;

:material-numeric-2-circle: If there are historical access rules on the current page, click the :octicons-copy-24: icon under the operations on the right side of the rule to clone an existing rule and then create.

## Start Configuration

<img src="../img/data-2.png" width="80%" >

1. Select the data type;
2. Define the name of the current rule;
3. Enter a description for the current rule;
4. Choose the corresponding [**Index**](../logs/multi-index/index.md), service, application, and metrics for the selected data type;

5. Define the [access scope](#scope) for the data under the current rule;

6. Add one or more fields that need desensitization;

7. Use regular expressions to desensitize sensitive information in the field content;

8. Select one or more member roles to which the current access rule will apply, including both default and user-defined roles;
9. Click Save.

## Configuration Notes {#config}   

### Defining Data Access Scope {#scope}

**Data Scope**: Members within the access rule can only view data that matches the filtering conditions.

Logical relationships between different fields can be customized to choose either **Any (OR)** or **All (AND)**;

- By default, **All (AND)** is selected, but it can be switched to **Any (OR)**:

- Logical relationship examples are as follows:
    
    - Example 1: (Default AND)
    
        - host=[host1,host2] AND service = [service1,service2];
    
    - Example 2: (Switched to Any OR)

        - host=[host1,host2] OR service = [service1,service2].
        
- Filtering values can be done via `labels/attributes`, including positive filtering, negative filtering, fuzzy matching, reverse fuzzy matching, existence, and non-existence.

### Regular Expression Desensitization {#regex}

When setting up access rules, even though the data scope has been defined, additional measures are needed to prevent the leakage of sensitive or unnecessary information. At this point, **desensitization fields** or **regular expressions** can be used to further process the data to enhance data protection.

On the configuration page, besides directly adding individual desensitization fields, if you need to further desensitize certain parts of the log `message`, such as not displaying token or IP information, you can add a regular expression to meet this requirement.

1. Multiple regular expressions can be configured; up to 10 expressions can be configured under one access rule;
2. Regular expressions can be disabled or enabled, and subsequent applications and previews will only apply desensitization based on enabled regular expressions;
3. Directly edit or delete a specific regular expression here;
4. Drag and drop to change the position of regular expressions; when data matches this desensitization rule, regular expressions are applied in top-to-bottom order;
5. You can directly create a new regular expression here:

<img src="../img/data-3.png" width="50%" >

In the pop-up window, [enter the required information](../management/regex.md#diy).

<img src="../img/data-4.png" width="60%" >

If **Apply to Rule** is checked, the rule will be added directly below the regular expression.

<img src="../img/data-5.png" width="50%" >

### Role Scenarios and Query Permissions {#role_permission}

#### Simple Scenario

Assume a member only holds one role, such as `read-only`. After selecting this role, the system will only apply desensitization for this role's configuration.

If you select the "All" role, all roles except Owner will be affected by the desensitization.

<img src="../img/data-9.png" width="60%" >

**Note**:

1. Default roles have full query permissions if no data access rules are configured;
2. Based on the **existence of data query permissions for user roles**, data access rules take effect;
3. After matching the role with the rule, you can only add filters within the configured rule's scope; any queries outside this scope will return no data.

#### Multi-Role Permission Overlap

If a member **holds multiple roles**, and these roles have different query permission scopes (as shown in the figure below), then the final data query permissions for the member will be the **sum of all role data access viewing scopes**.

<img src="../img/logdata_8.png" width="70%" >

#### Multi-Rule Permission Control

In complex business data with many layers, sometimes multiple access rules need to be set for data from different sources and attributes to meet various data access requirements.

1. Relationship between multiple filters in one rule: multiple values for the same key are OR, and different keys are AND;
2. Relationships between multiple rules are OR.

Therefore, if:

Rule 1: host = [host1,host2] AND service = [service1,service2]  
Rule 2: host = [host3,host4] AND source = [source1,source2]

If a role **has both of these permission rules**, the actual data displayed will be `Rule 1 OR Rule 2` to achieve a union effect.

The actual visible data range is:

`(host = [host1,host2] AND service = [service1,service2]) OR (host = [host3,host4] AND source = [source1,source2])`

If a role has multiple permission rules and one of them includes desensitization rules, all returned data under all permission rules will be affected by the desensitization rules.

## Configuration Example

1. Select the index `rp70` for the current workspace;
2. Set the data scope to `host:cn-hangzhou.172.**.**` and `service:kodo`;
3. Here we do not set desensitization fields but directly write the regular expression `tkn_[\da-z]*` to encrypt `token` information;
4. Finally, assign the current access rule to all `Read-only` members in the current workspace.
5. Click Save. If necessary, you can click the **Preview** button in the lower-left corner to check the desensitization effect.

<img src="../img/data-6.png" width="80%" >

This access rule applies to all `Read-only` members in the current workspace, who can only access data under the log index `rp70` where `host:cn-hangzhou.172.**.**` and `service:kodo`, and in this data, they cannot see any `token` information.

## Use Cases {#snapshot}

Based on the effective data access rules, members hit by the rules will receive snapshot data automatically filtered according to their permission rules. Even if the [snapshot](../getting-started/function-details/snapshot.md) contains data beyond the member's access permissions, the system will filter it first, and members can only view data that conforms to their access rules.

## Management List {#list}

1. View: In the data access rule list, you can directly view information related to the rule, such as associated indexes, data query conditions, whether desensitization is applied, and the number of associated roles and members.
2. Show only rules related to me:

    - The system defaults to "Off", meaning the list shows all data access rules by default;

    - Enabling this button will show only data access rules related to the current account's role.
3. Enable/Disable Rules: Modify the status of data access rules. When rules are disabled, different roles' data access query ranges are unrestricted; when rules are enabled, restrictions are restored.
4. Click the Edit button to modify settings such as the rule's name, description, bound indexes, filtering conditions, and authorized roles.
5. Click the Clone button to quickly copy the current rule.
6. Operation Audit: Records of operations related to the rule.
7. Click the Delete button to delete the rule.
8. Batch enable, disable, and delete multiple rules.

## Further Reading


<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Permission Use Cases Combining Data Access and Sensitive Data Desensitization Rules**</font>](./access_mask_combine.md)

</div>

</font>