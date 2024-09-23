# Data Access

---

Sensitive information may be contained in log data, so for security reasons, even within the same business organization, it is necessary to finely divide data access permissions. The **Data Access** feature of Guance first sets the data access range for target visitors based on the index of different sources at the [member role](../management/role-list.md) level. In addition, to further protect data, tools such as regular expressions and desensitization fields can be used to "re-edit" the data on the basis of restricted access, ensuring that sensitive information is properly handled without sacrificing data value.

On the **Logs > Data Access** page, you can start creating new rules in the following two ways:

:material-numeric-1-circle: Click the **Create** button in the upper left corner of the page;  
:material-numeric-2-circle: If there are historical access rules on the current page, click the :octicons-copy-24: icon next to the rule operation to clone the existing rule.

## Configuration

![](img/data-2.png)

1. Define the name of the current rule;   
2. Enter a description for the current rule;   
3. Select [**Indexes**](../logs/multi-index/index.md). The optional range includes log indices within the current workspace (including default log indices, custom indices, and bound external indices) as well as [all authorized viewable indices](./cross-workspace-index.md);  

4. Define the [access range](#range) of log data under the current rule;

5. Add fields that need to be desensitized; optional; multiple selections allowed;

6. Use regular expressions to desensitize sensitive information in field content;

7. Select the member roles to which the current access rule can be applied, including default roles within the system and self-built roles; multiple selections allowed;   
8. You can click the preview in the lower right corner to view the visual display effect of the current data access rule in the explorer;   
9. Click save.

<img src="../img/logdata_6.png" width="70%" >

## Config Instructions {#config}

### Range of Data Access {#range}

**Data Range**: Members within the access rule can only access the selected field information.

The logical relationship between different fields can be customized to choose **Any (OR)** or **All (AND)**;

- Default to **All (AND)**, which supports switching to **Any (OR)**:

- Logical relationship examples are as follows:

    - Example 1: (Default AND)

        - host=[host1,host2] AND service = [service1,service2];

    - Example 2: (Switched to Any OR)

        - host=[host1,host2] OR service = [service1,service2].

- Filter values through `Tags/Attributes`, including positive filtering, negative filtering, fuzzy matching, reverse fuzzy matching, existence and non-existence, and other filtering methods.

### Desensitization with Regex {#regex}

When setting access rules, even though the data range has been defined, additional measures are still needed to prevent the leakage of sensitive or unnecessary information. At this time, **desensitization fields** or **regular expressions** can be used to further process the data to strengthen data protection.

On the configuration page, in addition to directly adding individual desensitization fields, if you need to further desensitize a part of the content in the log `message`, such as not displaying token or IP information, you can meet this need by adding regular expressions.

1. Configure multiple regular expressions, up to 10 expressions can be configured under one access rule;
2. Disable or enabling a regular expression, and subsequent applications and previews will only adapt to the enabled regular expressions for desensitization;
3. Directly edit or delete a regular expression here;
4. Drag and drop to move the position of the regular expression, and when data matches this desensitization rule, the regular expression is applied in the order from top to bottom for desensitization processing;
5. Directly create a new regular expression here:

<img src="../img/data-3.png" width="60%" >

In the pop-up window, [input the required information](../management/regex.md#diy).

<img src="../img/data-4.png" width="70%" >

If you check **Apply to Rule**, the rule will be directly added below the regular expression.

<img src="../img/data-5.png" width="60%" >

### Roles and Query Rights


#### Simple Case

Assuming a member only holds one role, such as `read-only`, after selecting this role, the system will only desensitize the view for this role.

If you choose the "All" role, all roles except Owner will be affected by desensitization.

<img src="../img/data-9.png" width="70%" >

**Note**:

1. Default roles have all log data query permissions when data access rules are not configured;
2. Based on the foundation of **user roles having log data query permissions**, log data access rules can take effect;
3. After role matching rules, you can only continue to add filters within the range of the rule configuration, and if you query beyond this range, the data will return empty.

#### Multi-Role Permission

If a member has multiple roles (as below) and each role's query permission coverage range is different, the final data query permission of the member will adopt the **highest permission under the role**.

<img src="../img/logdata_8.png" width="70%" >

#### Multi-Rule Permission

In the case of complex and multi-level business data, we need to set multiple access rules to adapt to different data access needs.

1. The relationship between multiple filters in one rule: the relationship between multiple values of the same key is OR, and the relationship between different keys is AND;
2. The relationship between multiple rules is OR.

So, if:

Rule 1: host = [Host1,Host2] AND service = [Service1,Service2]
Rule 2: host = [Host3,Host4] AND source = [Source1,Source2]

A role has both of the above permission rules, the actual data will display `Rule 1 OR Rule 2` to achieve a union effect.

The actual data range that can be seen is:

`(Host = [Host1,Host2] AND Service = [Service1,Service2]) OR (Host = [Host3,Host4] AND Source = [Source1,Source2])`

If a role has multiple permission rules, and Rule 1 includes a desensitization rule, then all data returned under all permission rules will be affected by the desensitization rule.

## Config Example

1. Select the index `default`;
2. Set the data range to `host:myClient111` and `service:datakit_service`;
3. We do not set desensitization fields here, directly write the regular expression `tkn_[\da-z]*`, which means encrypting `token` information;
4. Finally, assign the current access rule to all `Read-only` members in the current workspace.
5. Click save. If necessary, you can click **Preview** in the lower left corner to view the desensitization effect.

<img src="../img/data-6.png" width="70%" >

The above access rule is for all `Read-only` members within the current workspace, who can only access the data with `host:myClient111` and `service:datakit_service` under the log index `default`, and all `token` information in this type of data is not visible.

## Use Case {#snapshot}


When data access rules are in effect, members' snapshot data is automatically filtered to match their permissions. If the [snapshot](../getting-started/function-details/snapshot.md) includes unauthorized data, it's filtered out, allowing members to view only data they're allowed to access.

## List Operations {#list}

1. View: Directly view the index associated with the rule, data query conditions, desensitization status, and the number of roles and corresponding member numbers.

2. Only display rules related to me:

    - The system defaults to "Off", which means that by default, the list will display all data access rules;

    - After enabling this button, the list will only display data access rules associated with the current account role.

3. Enable/Disable Rules: When a rule is disabled, the access query range of log data for different roles is unrestricted, and it is restored when the rule is enabled.

4. Modify the current rule's name, description, bound index, filter conditions, and authorized roles, etc.
5. Copy the current rule.
6. Audit: That is, the operation records related to this rule.
7. Delete the rule.
8. Enable, disable and delete multiple rules in batches.
