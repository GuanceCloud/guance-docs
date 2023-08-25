# Sensitive Data Scanner

In the process of using Guance products, many sensitive data such as network device addresses, Token, API keys, and personal privacy will inevitably be generated. In order to avoid information leakage and cause security risks, Guance provides the function of Sensitive Data Scanner, which realizes custom information shielding by creating desensitization rules for data.

## New rules

Into **Management > Sensitive Data Scanner**，you can customize the [**New rule**](#custom)，or create directly from the [**Templates**](#official).

![](img/scan-3.png)

### Custom Templates {#custom}

![](img/scan.png)

Ⅰ. Scan range: 

| Field | Description    |
| ---------- | ------------- |
| Type | the type of data that needs to be scanned; 【Log】 is selected by default.    |
| Filters | The range of data that needs to be scanned.    |


II. Define regex to match: 

| Field | Description    |
| ---------- | ------------- |
| Rule Name | The name of the current data rule.    |
| Regex | To match data strings that need to be encrypted.    |
| Data test | Enter a string of data and click Test to verify whether it matches the regex.<br />:warning: Test data will not be saved.    |

III. Sensitive data processing: 

- Desensitization field: All fields are supported. There are three options: specified fields and excluded fields; 【Specified Fields】is selected by default;
- Desensitization mode:  
 
    :material-numeric-1-circle: Universal encryption: Replace all matching sensitive data with *.

    :material-numeric-2-circle: Partially encrypted: Replace some character strings in sensitive data with * to keep some sensitive information, for example: mobile phone number *******1005.  

    :material-numeric-3-circle: Replace encryption: Replace all matching sensitive data with the specified string, which is irreversible after replacement.

    :material-numeric-4-circle: MD5 encryption: Any data can be encrypted into a fixed-length string, which is irreversible after replacement.
??? info "Features of MD5 Encryption"

    - Fixed length: No matter how long the string is, the length after encryption is the same, which is 32 bits.
    - Highly discrete: Any changes to the original data, even small changes, will lead to huge differences in the calculation results.
    - The operation is irreversible: When the operation result is known, the original string cannot be obtained through the inverse operation, but the screening and positioning can still be performed.
- Add tags: You can add custom tags for the desensitized data. Multiple tags are separated by 【,】.

### Templates {#official}

![](img/scan-1.png)

On **New rules > Templates** page，all monitoring template types are on the left, and all detection rules under the template type are on the right. You can perform the following operations:

- In the detection library on the left, check a specific rule library to perform corresponding screening;
- After select multiple detection rules, you can create multiple data rules in batches.

When you select one or more detection rules, click Create;

On the page，**Define regex to match** is automatically collapsed, where you can select the templates again as needed.

![](img/scan-2.png)

After the creation is successful, all created rules can be viewed in the rule list. 

## List of Desensitization Rules 

1. Query: Search based on monitor name in the 🔍 column.
2. Click :fontawesome-regular-trash-can: to delete the current rule.
3. Click the Edit button to modify the current rule.
4. You can enabling or disabling the current rule.
5. Batch operation: Click :fontawesome-regular-square: next to the rule name, the symbol can choose to disable, enable, and delete the selected rules in batches.

![](img/scan-4.png)