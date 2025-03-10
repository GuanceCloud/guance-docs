# Sensitive Data Scanning

During the use of <<< custom_key.brand_name >>> products, various sensitive data such as network device addresses, Tokens, API keys, and personal privacy information are inevitably generated. To prevent information leakage and avoid security risks, <<< custom_key.brand_name >>> provides a sensitive data scanning feature. This allows users to create desensitization rules to achieve customized information masking.

## Create Desensitization Rules

Enter **Manage > Sensitive Data Scanning**, where you can choose to customize [**Create**](#custom) or directly create from the [**Official Rule Library**](#official).

![](img/scan-3.png)

### Custom Creation {#custom}

![](img/scan.png)

1. Scanning Scope:

| Field | Description |
| ---------- | ------------- |
| Data Type | The type of data that needs to be scanned; by default, it selects 【Logs】. |
| Data Filtering | The scope of data that needs to be scanned. |

2. Define Matching Rules:

| Field | Description |
| ---------- | ------------- |
| Rule Name | The name of the current data rule. |
| Regular Expression | Used to match strings of data that need to be encrypted. |
| Data Testing | Enter a string of data, click Test, to verify if it matches the regular expression.<br />:warning: Test data will not be saved. |

3. Sensitive Data Processing:

- Desensitization Fields: Supports all fields, specified fields, and excluded fields; by default, it selects 【Specified Fields】.
- Desensitization Method: 

    :material-numeric-1-circle: General Encryption: Replaces all matching sensitive data with *;

    :material-numeric-2-circle: Partial Encryption: Replaces part of the sensitive data string with *, retaining some sensitive information, e.g., phone number *******1005;

    :material-numeric-3-circle: Replacement Encryption: Replaces all matching sensitive data with a specified string, which is irreversible after replacement;

    :material-numeric-4-circle: MD5 Encryption: Encrypts any data into a fixed-length string, which is irreversible after replacement.

??? abstract "Characteristics of MD5 Encryption"

    - Fixed Length: Regardless of the length of the string, the encrypted result is always 32 characters;
    - Highly Dispersed: Any change in the original data, even minor changes, results in a vastly different hash;
    - Non-Reversible: It's impossible to reverse-engineer the original string from the hash, but it can still be used for filtering and positioning.

- Add Tags: You can add custom tags to the desensitized data; multiple tags are separated by 【,】.

### Official Rule Library {#official}

![](img/scan-1.png)

On the **Create Rule > Official Rule Library** page, the left side lists all monitoring template types, while the right side shows all detection rules under each template type. You can perform the following operations:

- In the left-side rule library, check specific rule libraries to filter accordingly;
- Select multiple detection rules to batch-create multiple data rules.

When you select one or more detection rules and click Create;

On the creation page, **Define Matching Rules** is automatically collapsed, allowing you to reselect official rules as needed.

![](img/scan-2.gif)

After successful creation, you can view all created rules in the rule list.

## Desensitization Rule List

1. Search: Use the 🔍 bar to search based on monitor name.
2. Click :fontawesome-regular-trash-can: to delete the current rule.
3. Click the edit button to modify the current rule.
4. Supports enabling or disabling the current rule.
5. Batch Operations: Click the :fontawesome-regular-square: symbol next to the rule name to choose batch disable, enable, or delete selected rules.

![](img/scan-4.png)