# Generate Metrics Use Practices
---

## What are generate metrics used for?

Different enterprises have different perspectives and methods for analyzing product quality, user experience and business value, but standard collectors cannot meet various observable requirements. A custom metrics feature that makes the data collected by the collector more appropriate to your needs. By tracking the data, you can generate flexible and self-defined reports to observe the most important metrics for you in real time.

## What can generate metrics of Guance be used for?
The generate metrics of Guance can be used to collect, integrate and analyze data that will not be automatically tracked by the collector, and support the generation of new metric data based on existing data in the current space, so that you can design and implement new technical metrics according to your requirements.

- If you are the developer of "e-commerce platform", "search PV", "search UV" or "empty result PV" may meet your needs better than predefined metrics such as screen views. Enabling the function of generating metrics can help you optimize observation metrics.
- If you have tracked all logs in **Test Execution**, enabling custom build metrics can help you submit logs as part of error reporting at the same time.
- ...

## Precondition

You need to create a [Guance account](https://www.guance.com) and [install DataKit](../../datakit/datakit-install.md) on your host to start the related integration and collect data.

## Custom Metrics

There must be a metric that you have always wanted, but it just doesn't exist in the standard package. When you are not satisfied with the metrics provided by the system by default, the metric generation function of Guance supports the introduction of new metrics, which can be simply carried out in three steps:

- Data filtering: select all existing/single application data sources in Guance, and start generating new data based on this data source.
- Data query: Based on the selected data source, you can filter existing data, re-aggregate (Avg (average), Min (minimum), Max (maximum), Count (data points), p75, p95, p99, etc.), and request to generate new indicator results and data sets.
- Generate metrics: Set the method of generating metric, including the period of generating metric, the name of newly generated metric and the name of measurement.

![](../img/1.generate-metrics_1.png)

## <u>Example</u>


Let's take **Generate Test Results Report** as an example, and use the information in the test log <u>to understand the project status, product quality, etc.</u>. When testing the system, the test log will be uploaded to Guance in real time through Guance collector DataKit, and named as the log data source of `http_dial_testing`.

In the workbench, all test logs of this log source can be queried through the **Logs** function.

![](../img/1.generate-metrics_2.png)

The test results report shows the following details:

- Project name: The name of the current project
- Test category: The name of the test object, "name" = "bing"
- Number of failures: Number of logs for the current test object "status" = "fail"
- Number of successes: Number of logs for the current test object "status" = "ok"

| **Test Report** |  |
| --- | --- |
| Project Name | http_dial_testing |
| Test Category | bing |
| Status (ok) |  123 |
| Status (fail) |  123 |

### How to Filter Data Ranges

Data source and label filtering can filter out the data range you need. After the hit data is collected and sent to Guance, you can select "source" as "http_dial_testing" in "data filter" to match the data range with "project name" as the filter.

![](../img/1.generate-metrics_3.png)

### How to Process Data

Based on the selected data source, you can add filter and aggregate expressions to existing data, requesting new metric results and data sets. The number of successes of the current test object can be filtered out by "name" = "bing", the default time granularity is 15 minutes, and the number of logs with "status" = "ok" is aggregated by **Count** (taking data points).

![](../img/1.generate-metrics_4.png)

### Generate Metrics Configuration

By generating metrics, you can set the method and result of generating metrics, including the period of generating metrics, metric name and measurement name. The default is 1 minute, that is, new metric data is generated every 1 minute; Set the measurement to "test_ok"; Set the metric to "count_ok".

![](../img/1.generate-metrics_5.png)

Click **Confirm** to complete the generation of metric rules and start data collection.

![](../img/1.generate-metrics_6.png)

### Report

After the data processing is completed, you can generate test reports according to the newly generated metrics.

![](../img/1.generate-metrics_7.png)

If you need to visually observe other custom fields, you can also put metrics in lists, timing charts, pie charts, maps, and other ways.

![](../img/1.generate-metrics_8.png)