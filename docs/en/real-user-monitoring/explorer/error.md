# Error
---

You can view the frontend errors sent by the browser during the user's app usage, including error types and error content.

In the Error Explorer, you can:

- View all error types and their related error details in one place.
- Use Sourcemap conversion to restore the obfuscated code, making it easier to locate the source code during error troubleshooting and help users solve problems faster.

## Explorer List

### All Errors

![](../img/12.rum_explorer_6.png)

In the Error Explorer, you can quickly view the page address, code error type, error content and more when the user accesses the page.

- Load failed: indicate an error without a response, the SDK adds Load failed by default.
- Network request failed: indicate an error in the response.


### Patterns {#analysis}

![](../img/error0725.png)

If you want to view errors with a high frequency of occurrence, you can go to **Explorers > Error** and select the **Patterns** list.

Pattern calculates and analyzes the similarity of all error chain data based on clustering fields. It fixes the current time period based on the selected time range in the upper right corner and obtains 10,000 data records within that time period for Patterns. It aggregates error chains with high similarity and extracts and counts common patterns to help quickly detect abnormal chains and locate issues.

By default, it aggregates based on the `error_message` field, but you can customize the clustering field and enter up to 3 fields.

![](../img/error-message.png)

- In the Patterns list, you can click on any error to view all associated errors. Clicking on a chain takes you to the detail page for analysis.
- In the Patterns page, you can click on the sorting icon :octicons-triangle-up-16: & :octicons-triangle-down-16: to sort the document count in ascending/descending order (default is descending).

## Details Page

When you click on a data record in the list, you can view the details of the error, including the error details, extended fields, and associated chains.

![](../img/12.rum_explorer_2.5.png)

### Source

In the **Source** section, you can view the details of the Session / View / Action for the current error. You can filter/copy and view the current Session ID / View ID / Action ID.

### Error Distribution Chart

It aggregates and counts errors with high similarity and automatically selects the corresponding time intervals based on the selected time range in the explorer. It helps you visually view the time points or ranges where errors occur frequently and quickly locate error issues.

### Error Details {#error}

Youu can view the specific content of the error.

#### Sourcemap Conversion

When an application is deployed in a production environment, to prevent code leakage and other security issues, files are typically transformed, compressed, and obfuscated during the packaging process. While these measures ensure code security, they also make the collected error stack information obfuscated, making it difficult to directly locate issues and inconveniencing subsequent bug troubleshooting.

Guance provides Sourcemap functionality for applications, supporting the restoration of obfuscated code, making it easier to locate the source code during error troubleshooting and help users solve problems faster.

You can configure Sourcemap through RUM [Sourcemap Configuration](../sourcemap/set-sourcemap.md) or [Datakit Collector Sourcemap Conversion](../../integrations/rum.md#sourcemap). After configuration, you can view the parsed code and original code in the error details.

**Note**: Currently, only Web applications support Sourcemap configuration in RUM.

##### Parsed Code

Sourcemap conversion and parsed code example in RUM configuration:

![](../img/1.rum_error_4.png)

##### Original Code

![](../img/1.rum_error_5.png)


<!--
Sourcemap conversion and parsed code example using Datakit Collector configuration:

![](../img/sourcemap_02.png)
-->


**Note**: If both RUM and Datakit Collector have Sourcemap configured, the parsed format of RUM configuration is displayed.

### Attributes

:material-numeric-1-circle-outline: In the search bar, you can enter the field name or value to quickly search and locate.
:material-numeric-2-circle-outline: After selecting the field alias, you can view it after the field name. You can choose as needed.
:material-numeric-3-circle-outline: On the chain detail page, you can view the relevant field properties of the current chain in the **Attributes** section:

| <div style="width: 110px">Options</div> | Description |
| --- | --- |
| Filter  | Add this field to the explorer to view all data related to this field. You can filter and view the chain list related to this field in the chain explorer.  |
| Reverse Filter | Add this field to the explorer to view other data except for this field. |
| Add to Columns | Add this field to the explorer list for viewing. |
| Copy | Copy this field to the clipboard. |

![](../img/extension-1.gif)