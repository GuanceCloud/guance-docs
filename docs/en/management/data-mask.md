# Data Masking 
---

After the data is collected and reported to the Guance workspace, there are certain sensitive information fields in some of the data, such as IP addresses and user information. For these information, you can perform data desensitization by configuring sensitive fields.

**Notes**:

- Different data types can have their sensitive fields customized (field names are case-sensitive). The data types include: Logs, Infrastructure, Custom, Events, APM, RUM, Security Check, Network, Profile.
- After configuring field desensitization, the data of string type fields will be displayed as "***".
- Only the selected member roles that have been designated to view the original data can see the desensitized information. Other members will not be able to view the sensitive information in the corresponding explorer or chart.

## Setup

Click **Management > Data Rights Management > Data Masking**, click **Add** to start adding sensitive fields.

Enter the name of the current desensitization rule, select the corresponding data type, and enter the fields that need to be desensitized.

![](img/2.field_1.png)

To configure desensitization for field values using regular expressions, you can write regular expressions based on the syntax rules. Currently, you can choose from the [template library](../dql/regex.md) or provide custom input. Click on **Preview**, enter the original text, and click on **Confirm** to see the desensitized result.

As shown in the image, Guance will match the results based on the regular expression on the left and desensitize the matched results with `***`.

<img src="../img/token-mask.png" width="70%" >

You can configure sensitive data masking rules **based on role level** by selecting the roles that need to be distributed. Multiple selections are supported.

Click on **Confirm** to view the configured sensitive fields, such as `host_ip`.


## Rule List

![](img/2.field_2.png)

- Search: In the search bar on the right side of the page, you can directly enter the rule name for searching.
- Edit: Click to EDIT the current rule.
- Delete: If you don't need the current rule, click to delete it.
- Batch operations: In the rule list, you can enable, disable, or delete specific rules in bulk.

