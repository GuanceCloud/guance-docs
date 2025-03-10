# Analysis Dashboard

<<< custom_key.brand_name >>> supports visual analysis of applications on different ports and presets multiple monitoring schemes. After application data is uploaded to <<< custom_key.brand_name >>>, you can directly view the analysis of web, mobile, mini-program, and macOS applications in the monitoring and analysis dashboard, covering key dimensions such as overview, performance, resources, and errors.

## Concepts

LCP, FID, CLS are core metrics for Google's web pages, used to measure the loading speed, interactivity, and stability of a webpage.

| Metric | Description | Target Value |
| --- | --- | --- |
| LCP (Largest Contentful Paint) | Measures the time it takes to load the largest content element within the visible area of the webpage | Less than 2.5s |
| FID (First Input Delay) | Measures the delay time when users first interact with the webpage | Less than 100ms |
| CLS (Cumulative Layout Shift) | Measures whether the page content shifts due to dynamic loading during page load, 0 indicates no change | Less than 0.1 |

## Analysis Dimensions

Includes four dimensions:

1. Web;
2. Mobile (Android / iOS);
3. Mini-program;
4. macOS Application.

Switching the tabs above the view allows you to switch views.

<!--
**Note**: Under the **macOS** application type, <<< custom_key.brand_name >>> will default to displaying up to five views. You can search via the search bar to locate:

- Enter Application ID: List views bound to the current application ID;  
- Enter View Name: List all matching bound views.


-->

![](img/board.gif)

## Overview {#overview}

Statistics on UV count, PV count, page error rate, page load time, etc., of the current port application, and assists in visually presenting user access data statistics from session analysis, performance analysis, and error analysis, helping to quickly identify issues with user access and improve user access performance.

You can quickly locate and view connected applications by filtering through application ID, environment, version, etc.

## Performance Analysis {#performance}

Statistics on PV count, page load time, most concerned page sessions, long task analysis, resource analysis, etc., and real-time viewing of overall application page performance from Long Task analysis, XHR & Fetch analysis, and resource analysis, further accurately identifying pages that need optimization.

You can细分筛选 through application ID, environment, version, loading type, etc.

## Resource Analysis {#resources}

Statistics on resource classification, resource request ranking, etc., and real-time viewing of overall resource conditions and resources that need optimization from XHR & Fetch analysis and resource timing analysis.

You can细分筛选 through application ID, environment, version, resource address grouping, resource address, etc.

## Error Analysis {#errors}

Statistics on error rate, crash versions, network error status distribution, page error rate, etc., to quickly identify resource errors.

You can细分筛选 through application ID, environment, version, source, page address grouping, browser, etc.

<!--
![](img/overview-4.png)
![](img/overview-1.png)
![](img/overview-2.png)
![](img/overview-3.png)
-->

## Associated Views

The current analysis dashboard is the standard "system view" provided by <<< custom_key.brand_name >>>. If you want to use a personalized view for analysis, you can create a "user view" with the same name as the system view, and the system will automatically prioritize your "user view" for display.

Click the jump button in the top right corner to proceed.

![](img/board.png)