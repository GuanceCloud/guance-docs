# Error Tracking

---

Guance provides an APM error data analysis explorer, you can quickly view the historical trend and distribution of similar errors in the trace in **APM > Error Tracking**, helping to quickly locate performance issues.

The error tracking explorer includes two lists: **All Errors** and **Pattern**:

- [All Errors](#errors): Used to <u>need to view all</u> trace errors that occur in the project application;
- [Pattern](#analysis): Used for <u>quickly viewing the most frequently occurring</u> trace errors that need to be resolved.

> Guance explorer provides powerful query and analysis functions, see [Powerful Explorer](../getting-started/function-details/explorer-search.md).


## All Errors {#errors}

In the Guance workspace **APM > Error Tracking**, select the **All Errors** list to view and analyze all trace error data.

**Note:** All error data statistics are based on error status `status=error`, and contain the error type `error_type` field in the Span.

![](img/1.apm_error_12.png)

### Correlation Analysis

In the error tracking explorer, you can click on any error to view the corresponding error trace details, including services, error types, error content, error distribution maps, error details, trace details, extended attributes, and associated logs, hosts, Networks, etc.

<div class="grid" markdown>

=== "Error Distribution"

    In Error explorer Details Page > Error Distribution Map, based on `error_message` and `error_type` two fields, **aggregate statistics of high similarity error traces, and according to the time range selected by the error explorer, automatically select the corresponding time interval to display the distribution trend of errors**. This helps you intuitively view the time point or time range of frequent errors and quickly locate trace problems.

    ![](img/1.apm_error_11.1.png)


=== "Error Details"

    Quickly locate error problems with the help of error detail information.

    ![](img/1.apm_error_14.png)


=== "Trace Details"

    This tab shows you the error information that occurred under the current trace service.

    ![](img/1.apm_error_13.png)


</div>

## Pattern {#analysis}

If you need to view more frequently occurring errors, you can select the **Pattern** list in the Guance workspace **APM > Error Tracking**.

Pattern is a similarity calculation analysis of all error trace data based on cluster fields. The time range selected in the upper right corner is fixed for the current time period, and 10000 data within this time period are obtained for pattern. The error traces with high similarity are aggregated, and the common Pattern clusters are extracted and counted to help quickly find abnormal traces and locate problems.

By default, aggregation is performed based on the `error_message` field, and you can customize the input clustering field, up to 3 can be entered.

![](img/1.apm_error_10.0.png)

### Pattern Details

- In the pattern list, you can click on any error to view all associated error traces, click on the trace to enter the error trace detail page for viewing and analysis;

![](img/1.apm_error_10.png)

- In the pattern page, click the sorting icon :octicons-triangle-up-16: & :octicons-triangle-down-16:, you can sort the document quantity in ascending/descending order (default descending).

<img src="../img/error-1.png" width="60%" >

- If you need to export a piece of data, open the data detail page and click the :material-tray-arrow-up: icon in the upper right corner.

<img src="../img/error-0809.png" width="70%" >