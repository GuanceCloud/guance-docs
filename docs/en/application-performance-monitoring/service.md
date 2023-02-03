# Service List
---

## Introduction

After the link data is collected into Guance, You can log in to the Guance Workspace, Click on the "Service" list of "Application Performance Monitoring" to view all link service lists within the selected time range and their corresponding key performance metrics, including average request number, average response time, P75 response time, P95 response time and error number. They are sorted in descending order according to "Error Number" by default, and it is supported to click on the name of key performance metrics to adjust the sorting display.

![](img/3.apm_1.png)

## Service Query and Analysis

### Time Control

In the "Service" list of "Application Performance Monitoring", the data of the last 15 minutes is displayed by default, and you can select the time range of data display through the "Time Control" in the upper right corner. See the doc [time control description](../getting-started/necessary-for-beginners/explorer-search.md#time).

### Search and Filter

In the service search bar, it supports keyword search, wildcard search, association search and other search methods, and supports field screening of link services based on one or more tags such as service type, environment (env), version, project and service, including forward screening, reverse screening, fuzzy matching and reverse fuzzy matching. For more searching and filtering, refer to the doc [searching and filtering for the explorer](../getting-started/necessary-for-beginners/explorer-search.md).

**Note: When you switch to view the Service or Link explorer, Guance reserves the current filter criteria and time range for you by default. Refer to the doc [Tracing data collection general configuration](../datakit/datakit-tracing.md#tracing-common-config).**

### Quick Filter

In shortcut filter, you can quickly filter based on service type, environment (env), version, project, and service, and more shortcut filter can be found in the doc [shortcut filter](../getting-started/necessary-for-beginners/explorer-search.md#quick-filter).

### View Error List

Hover the mouse over the service performance metric "error Number" and click on :octicons-search-16: displayed on the right to jump to the "Link" page to view the link data of the service in the currently selected time range with the data status "status" as "error".

![](img/3.apm_2.gif)

