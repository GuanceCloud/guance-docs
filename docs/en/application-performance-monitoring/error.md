# Error Tracing
---

## Introduction

Guance provides an application performance monitoring error data analysis observer. You can quickly view the historical trend and distribution of similar errors in the link in the "error tracing" of "application performance monitoring", and help quickly locate performance problems.

The error tracing observer includes two lists: "All Errors" and "Clustering Analysis":

- All errors: Used to view all link errors that occurred in the project application as a whole.

- Clustering analysis: Used to quickly view the most frequent link errors that need to be resolved.

## Data Query and Analysis

Guance obserever provides powerful query and analysis functions, You can use the time control, search and filter data within a certain time range, quickly filter, customize display columns, export data and other operations. Through chart analysis mode, all wrong link data are grouped and counted based on **1-3 labels** in order to reflect the distribution characteristics and trends of wrong links in different groups and at different times and help you quickly find wrong links to locate performance problems. See the documentation [observer notes](../getting-started/necessary-for-beginners/explorer-search.md).

## All errors

If you need to view all link errors in the project application as a whole, you can view and analyze the error data of all links by selecting the "All Errors" list in the Guance workspace "Application Performance Monitoring"-"Error Tracking".

???+ attention

    All error statistics are based on the service top-level Span with the error status `status=error` and the error type `error_type` field. Service top-level Span refers to filtering and displaying all Span data entered for the first time within the currently selected time range.

![](img/1.apm_error_12.png)

### Error Link Association Analysis

In the Error Tracking Observer, you can click any error to view the corresponding error link details, including service, error type, error content, error profile, error details, link details, extended attributes, associated logs, hosts and networks.

#### Error Profile

On the error profile of the Error Observer Details page, Based on the `error_message` and `error_type` two fields, the error links with high approximation are aggregated and counted, and according to the time range selected by the error observer, the corresponding time interval is automatically selected to show the distribution trend of errors, which helps you intuitively view the time points or time ranges where frequent errors occur and quickly locate link problems.

![](img/1.apm_error_11.1.png)



#### View Link

Click "View Link" in the upper right corner, you can locate the link problem by viewing the upstream and downstream Span of the flame diagram of the wrong link, and click Span to view the corresponding "Link Details".

![](img/1.apm_error_13.png)

You can also switch to "Error Details" to view the error details of upstream and downstream error Spans to quickly locate error problems. Click "Back" to return to the error tracking observer details page.

![](img/1.apm_error_14.png)

## Cluster Analysis

If you need to check the errors with high frequency, you can select the "Cluster Analysis" list in the Guance workspace "Application Performance Monitoring"-"Error Tracing" to quickly check the most frequent error links and help you locate error problems.

???+ attention

    Cluster analysis is to calculate and analyze the similarity of all wrong link data based on two fields: `error_message` and `error_type`. The current time period is fixed according to the time range selected at the upper right, and 10000 pieces of data in this time period are obtained for cluster analysis, and the error links with high approximation are aggregated, and the common Pattern cluster is extracted and counted to help quickly find abnormal links and positioning problems.

![](img/1.apm_error_10.0.png)



### Cluster Analysis Details

In the cluster analysis list, you can view all associated error links by clicking on any error, and click on the link to go to the error link details page for analysis.

![](img/1.apm_error_10.png)

