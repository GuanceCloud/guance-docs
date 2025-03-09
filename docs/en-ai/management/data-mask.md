# Sensitive Data Masking
---

After data is collected and reported to the <<< custom_key.brand_name >>> workspace, sensitive information fields such as IP addresses and user information can be masked by setting up sensitive fields.

**Note**:

- Different data types (including logs, base objects, resource catalogs, events, APM, RUM, security checks, network, Profile) can have their sensitive fields (field names are case-sensitive) configured individually;
    
- After configuring field masking, string (`string`) type field data will be displayed as `***`;
    
- Only members with added masking rules can view the original data after it has been distributed; other members will not be able to view unmasked information in the Explorer or charts.

## Start Adding Rules

1. Go to **Manage > Sensitive Data Masking > Add Masking Rule**;
2. Define the name of the masking rule;
3. Select the data type;
4. Input the fields that need to be masked;
5. Write a regular expression, i.e., configure masking for field values using regex syntax; currently supports either directly selecting from the [template library](./regex.md) or custom input;
    - Click Preview, enter the original text, click Mask to see the masking effect.
6. Select roles that need to be shielded from viewing the data;
7. Click **Confirm** to view the configured sensitive fields.

As shown in the figure, <<< custom_key.brand_name >>> will mask the results matched by the left-side regular expression according to `***`.

![Masking Example](../img/token-mask.png)

## Manage Rules List

1. Search: In the search bar on the right side of the page, you can directly input the rule name to search;
2. Edit: Click to modify the current rule;
3. Delete: If the current rule is no longer needed, click delete;
4. Batch operations: In the rules list, you can batch enable, disable, or delete specific rules.

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Permission Use Cases Combining Data Access with Sensitive Data Masking Rules**</font>](./access_mask_combine.md)

</div>

</font>