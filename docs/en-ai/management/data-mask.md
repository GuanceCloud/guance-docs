# Sensitive Data Masking
---

After data is collected and reported to the Guance workspace, sensitive information fields such as IP addresses and user information can be masked by setting up sensitive fields.

**Note**:

- Different data types (including: logs, base objects, Resource Catalog, events, APM, RUM, Security Check, network, Profile) can have their sensitive fields (field names are case-sensitive) configured individually;
    
- After configuring masking for string (`string`) type fields, the data displayed will be `***`;

- Only members with assigned roles after adding masking rules can view the original data; other members will not be able to see the unmasked information in the Explorer or charts.

## Start Adding Rules

1. Go to **Management > Sensitive Data Masking > Add Masking Rule**;
2. Define the name of the masking rule;
3. Select the data type;
4. Enter the fields that need to be masked;
5. Write a regular expression to configure masking based on the field value content using regex syntax; currently supports either selecting from the [template library](./regex.md) or custom input;
    - Click preview, enter the original text, click mask to view the masking effect.
6. Select the roles that need to be shielded from viewing the data;
7. Click **Confirm**, and you can view the configured sensitive fields.

As shown in the figure, Guance will mask the results matched by the left-side regular expression with `***`.

![Masked Data Example](../img/token-mask.png)

## Managing Rule List

1. Search: In the search bar on the right side of the page, you can directly input the rule name to search;
2. Edit: Click to modify the current rule;
3. Delete: If you no longer need the current rule, click delete;
4. Batch Operations: In the rule list, you can batch enable, disable, or delete specific rules.

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Permission Scenarios Combining Data Access with Sensitive Data Masking Rules**</font>](./access_mask_combine.md)

</div>

</font>