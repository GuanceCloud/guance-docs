# Web Application Analysis
---

## Overview

Application performance analysis can be viewed through the Guance console after application data has been collected to the Guance, improve page loading (LCP), interactivity (FID) and page stability (CLS), and improve the user experience.

LCP, FID, CLS are Google's core website metrics that measure the speed of loading, interactivity and page stability of a website.

| Metric | **DESCRIPTION** | 目标值 |
| --- | --- | --- |
| LCP(Largest Contentful Paint) | Moment in the page load timeseries in which the largest DOM object in the viewport (as in, visible on screen) is rendered. | Less than 2.5s |
| FID(First Input Delay) | Time elapsed between a user’s first interaction with the page and the browser’s response. | Less than 100ms |
| CLS(Cumulative Layout Shift) | Quantifies unexpected page movement due to dynamically loaded content (for example, third-party ads) where 0 means that no shifts are happening. | Less than 0.1 |

![](../img/14.rum_web.png)

## Explorer Analysis

Guance provides Real User Monitoring explorer to help you view and analyze detailed information about user access to your applications. In "Real User Monitoring" , click on any application and then you can use "Explorer" to understand each user session, page performance, resources, long tasks, errors in action, the impact of latency on users, and help you fully understand and improve the operation status and usage of your application through search, filtering and correlation analysis to improve user experience. More details can be found in the documentation [Explorer](... /explorer/index.md).

## Scene Analysis

Guance provides visual Web application analysis with multiple built-in Web application monitoring data scenarios, including overview, page performance analysis, resource loading analysis, and JS error analysis.

### Overview

The overview scene of Web application counts the error number, error rate, session number, session distribution, browser, operating system, most popular page, resource error ranking and other contents of page access, visually displays the data statistics of users accessing Web pages, quickly locates the problems of users accessing Web applications, and improves user access performance. Web applications that have been accessed can be viewed through environment and version filtering.

![](../img/9.web_overview.png)

### Performance Analysis

Page performance analysis of Web application, through statistics of PV number, page loading time, website core metrics, the number of most concerned page sessions, page long task analysis, XHR & Fetch analysis, resource analysis and other metrics,  visually view the overall performance of Web application pages in real time, more accurately locate the pages that need to be optimized, and screen and view the accessed Web applications through environment and version.

![](../img/9.web_performance.png)

### Resource Analysis

Web application resource analysis, through statistical resource classification, XHR & Fetch analysis, resource time-consuming analysis and other metrics, visual real-time view of the overall Web application resources; Through statistical resource request ranking, the resources that need to be optimized can be positioned more accurately; Web applications that have been accessed can be filtered through environment and version.

![](../img/9.web_resource.png)

### Error Analysis

JS error analysis of Web application, through statistical error rate, error classification, error version, network error state distribution and other metrics, visually view the overall Web application error situation in real time; Through the statistics of affected resource errors, resource errors can be quickly located; Web applications that have been accessed can be filtered through environment and version.

![](../img/9.web_error.png)

