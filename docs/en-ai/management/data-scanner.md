# Sensitive Data Scanning

During the use of Guance products, sensitive data such as network device addresses, Tokens, API keys, and personal privacy information are inevitably generated. To prevent information leakage and security risks, Guance provides a feature for scanning sensitive data, allowing users to create desensitization rules to customize information masking.

## Create Desensitization Rules

Go to **Management > Sensitive Data Scanning**, where you can choose to [**Create Custom Rules**](#custom) or directly create from the [**Official Rule Library**](#official).

![](img/scan-3.png)

### Custom Creation {#custom}

![](img/scan.png)

1. Scan Scope:

| Field | Description |
| ---------- | ------------- |
| Data Type | The type of data that needs to be scanned; by default, 【Logs】is selected. |
| Data Filtering | The scope of data that needs to be scanned. |

2. Define Matching Rules:

| Field | Description |
| ---------- | ------------- |
| Rule Name | The name of the current data rule. |
| Regular Expression | Used to match strings of data that need to be encrypted. |
| Data Testing | Enter a string of data, click Test to verify if it matches the regular expression.<br />:warning: Test data will not be saved. |

3. Handling Sensitive Data:

- Desensitization Fields: Supports all fields, specific fields, and excluded fields; by default, 【Specific Fields】is selected.
- Desensitization Method:
  
    :material-numeric-1-circle: General Encryption: Replace all matching sensitive data with *;

    :material-numeric-2-circle: Partial Encryption: Replace part of the sensitive data with *, retaining some sensitive information, e.g., phone number *******1005;

    :material-numeric-3-circle: Replacement Encryption: Replace all matching sensitive data with a specified string, irreversible after replacement;

    :material-numeric-4-circle: MD5 Encryption: Encrypt any data into a fixed-length string, irreversible after replacement.

??? abstract "Characteristics of MD5 Encryption"

    - Fixed Length: Regardless of the length of the original string, the encrypted result is always 32 characters;
    - High Dispersal: Any modification to the original data, even minor changes, results in a significantly different hash;
    - Non-Reversible: It is impossible to derive the original string from the hash, but it can still be used for filtering and positioning.

- Add Tags: You can add custom tags to the desensitized data; multiple tags are separated by 【,】.

### Official Rule Library {#official}

![](img/scan-1.png)

On the **Create Rules > Official Rule Library** page, the left side lists all monitoring template types, and the right side shows all detection rules under each template type. You can perform the following operations:

- In the left-side library, check specific rule libraries to filter accordingly;
- Select multiple detection rules to batch-create multiple data rules.

When you select one or more detection rules and click Create;

On the creation page, **Define Matching Rules** is automatically collapsed, and you can choose official rules as needed.

![](img/scan-2.gif)

After successful creation, view all created rules in the rule list.

## Desensitization Rule List

1. Search: Use the 🔍 bar to search based on monitor name.
2. Click :fontawesome-regular-trash-can: to delete the current rule.
3. Click the edit button to modify the current rule.
4. Support enabling or disabling the current rule.
5. Batch Operations: Click the :fontawesome-regular-square: symbol next to the rule name to select batch disable, enable, or delete selected rules.

![](img/scan-4.png)