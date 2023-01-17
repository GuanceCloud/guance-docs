# Error
---

## Overview

The Error explorer supports viewing front-end errors issued by the browser during the user's use of the application, including the error type, error content, etc.

In the Error explorer, you can:

- view all error types, and their associated error details in one place.
- Correlate error traces and locate upstream and downstream spans of error traces to quickly identify performance issues.
- Restore the obfuscated code through Sourcemap conversion, which is convenient to locate the source code when troubleshooting errors and help users solve problems faster.

## Precondition

Guance Cloud supports collecting errors, resources, requests, performance metrics, etc. by means of introducing SDK scripts. For details, you can refer to [Rum Collector Configuration](... /... /datakit/rum.md).

## Error Explorer

In the Real User Monitoring explorer, you can switch to the "error explorer" to query and analyze the code errors that occur during user access, and you can quickly view the page address, code error type, and error content of user access.

Attention.

- Error content Load failed: is the error of no response, the default SDK added Load failed
- Error content Network request failed: is the response return error

![](../img/1.rum_error_1.png)

## Error Detail

Click on the data you need to view in the list, and in the row out details page, you can view the error details of user access, including error details, extended fields, associated traces, etc.

### Error Detail

In the error details, you can view the details of the error.

![](../img/1.rum_error_2.png)

#### Sourcemap Conversion

When the application is released in the production environment, in order to prevent code leakage and other security issues, generally the packaging process will do conversion, compression and other operations for the file. While the above measures ensure code security, they also result in the collection of error stack information after obfuscation, which makes it impossible to locate the problem directly and brings inconvenience to the subsequent bug investigation.

Guance Cloud provides sourcemap function for applications, which supports restoring the obfuscated code to locate the source code and help users solve the problem faster.

You can see the documentation [Sourcemap conversion](... /... /datakit/rum.md#sourcemap) to configure it. After the configuration, you can view the error map in the error details, as well as the parsed code and the original code.

##### Error Distribution Chart

The error distribution chart aggregates statistics for errors with high proximity and automatically selects the corresponding time interval to display the error distribution trend according to the time range selected by the explorer, helping you to visually view the time point or time range where frequent errors occur and quickly locate the error problem.

##### Parsing Code Example

![](../img/1.rum_error_4.png)

##### Original Code Example

![](../img/1.rum_error_5.png)



### Extended Field

Extension fields include application ID, browser, browser version, system version, etc., and support quick filtering by selecting extension fields.

![](../img/1.rum_error_3.png)



### Associated Trace

In Real User Monitoring, if there is a associated trace for an erroneous network request, click on "Trace" in the error details to view the details.

**Note: You will not be able to see the "Trace" when there is no trace associated with the erroneous network request. **

![](../img/6.error_4.png)  

