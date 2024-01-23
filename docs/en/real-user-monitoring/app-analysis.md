# Analysis Dashboard


For different ports, Guance provides visual application analysis and built-in monitoring solutions. After the application data is collected to Guance, you can view the analysis of the Web, mobile (Android/iOS), mini program, and macOS under RUM > Analysis Dashboard in Guance.


In the **Analysis Dashboard**, you can view various analysis scenarios within the Web, mobile (Android/iOS), and mini program ports, including views from dimensions of [**Overview**](#overview), [**Performance**](#performance), [**Resources**](#resources) and [**Errors**](#errors).

**Web Application Terms:**

LCP, FID, CLS are Google's core web vitals, used to measure the loading speed, interactivity, and stability of a website.

| Metrics | Description | Target Value |
| --- | --- | --- |
| LCP(Largest Contentful Paint) | Calculate how long it takes to load the largest content element within the visible range of the webpage | Less than 2.5s |
| FID(First Input Delay) | Calculate the delay time when the user first interacts with the webpage | Less than 100ms |
| CLS(Cumulative Layout Shift) | Calculate whether the content of the webpage will move due to dynamic loading when the webpage is loaded, 0 means no change. | Less than 0.1 |


**macOS:**

In the **macOS** section, up to five views are displayed by default. You can also use the search bar to locate:

- Enter the Application ID: List the views bound under the current Application ID;
- Enter the View Name: List all matching bound views.

![](img/board.png)


## Overview {#overview}

It provides statistics on the current port application's <u>Unique Visitors (UV), Page Views (PV), Page Error Rate, Page Load Time</u>, and assists in visualizing data on user access to the application from three aspects: Session Analysis, Performance Analysis, and Error Analysis. This helps quickly identify issues with user access and improve user performance.

You can quickly locate and view applications that have been accessed by filtering through Application ID, Environment, Version, etc.

![](img/overview-1.png)

## Performance Analysis {#performance}

It provides statistics on <u>Page Views (PV), Page Load Time, Most Viewed Pages, Long Task Analysis, Resource Analysis</u>, and allows real-time viewing of overall application page performance from three aspects: Long Task Analysis, XHR & Fetch Analysis, and Resource Analysis. This further helps pinpoint pages that need optimization.

You can segment and filter by Application ID, Environment, Version, Load Type, etc.

![](img/overview-2.png)

## Resource Analysis {#resources}

It provides statistics on <u>Resource Categories, Resource Request Rankings</u>, and allows real-time viewing of overall resource status and resources that need optimization from two aspects: XHR & Fetch Analysis and Resource Consumption Analysis.

You can segment and filter by Application ID, Environment, Version, Resource Address Grouping, Resource Address, etc.

![](img/overview-3.png)

## Error Analysis {#errors}

The Error Analysis section allows quick identification of resource errors by <u>Statistics on Error Rate, Crash Versions, Network Error Distribution, Page Error Rate</u>.

You can segment and filter by Application ID, Environment, Version, Source, Page Address Grouping, Browser, etc.

![](img/overview-4.png)