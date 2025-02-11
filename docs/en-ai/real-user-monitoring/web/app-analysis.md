# Web Application Analysis
---

After collecting application data in Guance, you can view the APM analysis through the Guance console to improve page load (LCP), interactivity (FID), and page stability (CLS), enhancing user experience.

![](../img/web-pic.png)

???+ abstract "Web Application Terminology"

    LCP, FID, CLS are core web vitals defined by Google, used to measure the loading speed, interactivity, and stability of a website.

    | Metrics | Description | Target Value |
    | --- | --- | --- |
    | LCP(Largest Contentful Paint) | Measures the time it takes to load the largest content element within the visible area of the webpage | Less than 2.5s |
    | FID(First Input Delay) | Measures the delay time when a user first interacts with the webpage | Less than 100ms |
    | CLS(Cumulative Layout Shift) | Measures whether the content on the webpage shifts due to dynamic loading during page load; 0 indicates no change | Less than 0.1 |

    ![](../img/14.rum_web.png)

## Analysis Dashboard

Guance provides visualized Web application analysis with built-in multi-dimensional RUM scenarios. You can view the Summary, page performance analysis, resource loading analysis, and JS error analysis under **RUM > Analysis Dashboard > Web**.

> For more details, refer to [Analysis Dashboard](../app-analysis.md).

## Explorer

Guance provides an RUM Explorer to help you view and analyze detailed information about user visits to your application. By clicking the button on the right side of the application, you can use the **Explorer** to understand each user session, page performance, resources, long tasks, and how errors and delays impact users. This helps you gain a comprehensive understanding of the application's runtime status and usage through search, filtering, and correlation analysis, improving the overall user experience.

> For more details, refer to [Explorer](../explorer/index.md).

<!--
### Summary

The Summary section of the Web application statistics includes error counts, error rates, session counts, session distribution, browsers, operating systems, most popular pages, resource error rankings, etc. It visually presents data statistics on user visits to Web pages, helping you quickly identify issues with user visits to Web applications and improve user visit performance. You can filter by environment and version to view connected Web applications.

![](../img/9.web_overview.png)

### Performance Analysis

The page performance analysis of the Web application involves metrics such as PV count, page load time, core web vitals, most viewed page sessions, page long task analysis, XHR & Fetch analysis, resource analysis, etc. It provides real-time visualization of the overall page performance of the Web application, allowing for precise identification of pages that need optimization. You can filter by environment and version to view connected Web applications.

![](../img/9.web_performance.png)

### Resource Analysis

The resource analysis of the Web application involves metrics such as resource classification, XHR & Fetch analysis, resource timing analysis, etc. It provides real-time visualization of the overall resource situation of the Web application. By analyzing resource request rankings, you can precisely identify resources that need optimization. You can filter by environment and version to view connected Web applications.

![](../img/9.web_resource.png)

### Error Analysis

The JS error analysis of the Web application involves metrics such as error rate, error classification, error version, network error status distribution, etc. It provides real-time visualization of the overall error situation of the Web application. By analyzing affected resource errors, you can quickly identify resource errors. You can filter by environment and version to view connected Web applications.

![](../img/9.web_error.png)
-->