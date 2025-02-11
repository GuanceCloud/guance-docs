# Analysis Dashboard

Guance supports visual analysis of applications on different platforms and has preset multiple monitoring solutions. After application data is uploaded to Guance, you can directly view the analysis of web, mobile, mini-program, and macOS applications in the monitoring and analysis dashboard, covering key dimensions such as summary, performance, resources, and errors.

## Concept Explanation

LCP, FID, and CLS are Google's core web vitals used to measure a website's loading speed, interactivity, and visual stability.

| Metric | Description | Target Value |
| --- | --- | --- |
| LCP (Largest Contentful Paint) | Measures the time it takes to load the largest content element within the visible area of the webpage | Less than 2.5s |
| FID (First Input Delay) | Measures the delay between the user's first interaction with the webpage and the browser's response | Less than 100ms |
| CLS (Cumulative Layout Shift) | Measures how much the page shifts during loading due to dynamic content changes; 0 indicates no shift | Less than 0.1 |

## Analysis Dimensions

The dashboard includes four dimensions:

1. Web;
2. Mobile (Android / iOS);
3. Mini-program;
4. macOS Application.

Switching tabs at the top of the view allows you to switch between different views.

<!-- 
**Note**: Under the **macOS** application type, Guance will default to displaying up to five views. You can use the search bar to locate specific views:

- Enter the application ID: List views bound to the current application ID;
- Enter the view name: List all matching bound views.


-->

![](img/board.gif)

## Summary {#overview}

This section provides statistics on UV, PV, page error rate, page load time, and other metrics for the current platform application. It visually presents user access data from session analysis, performance analysis, and error analysis to quickly identify issues with user access and improve application performance.

You can filter by application ID, environment, version, etc., to quickly locate and view connected applications.

## Performance Analysis {#performance}

This section provides statistics on PV, page load time, number of sessions for popular pages, long task analysis, resource analysis, and other metrics. It offers real-time insights into overall application page performance from three aspects: Long Task analysis, XHR & Fetch analysis, and resource analysis, helping to precisely identify pages that need optimization.

You can filter by application ID, environment, version, load type, etc.

## Resource Analysis {#resources}

This section provides statistics on resource classification, resource request rankings, and other metrics. It offers real-time insights into overall resource conditions and identifies resources that need optimization from two aspects: XHR & Fetch analysis and resource timing analysis.

You can filter by application ID, environment, version, resource group, resource URL, etc.

## Error Analysis {#errors}

This section provides statistics on error rates, crash versions, network error status distribution, page error rates, and other metrics to quickly identify resource errors.

You can filter by application ID, environment, version, source, page URL group, browser, etc.

<!-- 
![](img/overview-4.png)
![](img/overview-1.png)
![](img/overview-2.png)
![](img/overview-3.png)
-->

## Associated Views

The current analysis dashboard is the standard "System View" provided by Guance. If you wish to use a customized view for analysis, you can create a "User View" with the same name as the system view. The system will automatically prioritize your "User View" for display.

Click the jump button in the top-right corner to proceed.

![](img/board.png)