# Web Application Monitoring (RUM) Best Practices

---

## Prerequisites

- Register an account and log in using your registered credentials at the [<<< custom_key.brand_name >>> official website](https://www.guance.cn/).
- Install [DataKit on the server](../../datakit/datakit-install.md).

## Introduction to Web Application Monitoring (RUM):

**RUM** stands for **_Real User Monitoring (real user experience management)_**. With the development of mobile internet, more and more businesses present their final service forms on the client side, specifically RUM endpoints. These forms include Mobile-APPs, web pages, and mini-programs (WeChat, Alipay, Toutiao, etc.). As the internet industry evolves, competition has intensified, and the end-user experience directly impacts new users, retention, corporate image, and even revenue. Therefore, improving the end-user experience is a critical consideration for internet companies and traditional enterprises undergoing or planning digital transformation.

---

### Brief Introduction to RUM Principles:

**Principle Explanation:** The method of collecting RUM data has evolved through several generations. Currently, the most common standard is based on W3C's [[navigation-timing](https://www.w3.org/TR/navigation-timing/)] specification (see the figure below). This standard defines various browser events, allowing simple calculations to determine key metrics such as first screen load time, blank screen load time, DOM loading, HTML loading, etc. Compared to the F12 developer tools in test environments, this method can more effectively collect real-world front-end experiences from production environments, making it particularly popular as H5 applications become more prevalent. Commercial software in China (such as Tingyun, Borui, CloudWisdom, OneAPM) all rely on this standard for their web monitoring systems, which are applicable to most H5 scenarios.

![image](../images/web/2.png)

As browsers (especially Chrome) and front-end technologies have developed, the limitations of navigation-timing have become more apparent. For example, single-page applications (SPAs) have become increasingly common due to front-end and back-end separation. In these scenarios, collecting data based on navigation-timing can be cumbersome. Therefore, W3C introduced a new standard [[PaintTiming-github](https://github.com/w3c/paint-timing/)] [[PaintTiming-api](https://developer.mozilla.org/en-US/docs/Web/API/PerformancePaintTiming)]. This standard introduces new metrics such as First Paint and First Contentful Paint, providing a better reflection of the actual user experience when accessing web pages. DF-RUM adopts data collection methods that support the PaintTiming specification. For more information, see [[Improving Performance with Paint Timing API](https://zhuanlan.zhihu.com/p/30389490)] [[Using Paint Timing](https://www.w3cplus.com/performance/paint-timing-api.html)].

---

DF officially supports the following RUM monitoring methods:
**Web Applications**: [[Integrate Web Applications with DF Monitoring](../../real-user-monitoring/web/app-access.md)] [Best Practices for Web Application Monitoring]<br />**Mobile Apps (Android & iOS)**: [ [Integrate Android with DF Monitoring](../../mobile/index.md)] [ [Integrate iOS with DF Monitoring](../../mobile/index.md)] [Best Practices for App Monitoring - To Be Added][]<br />**Mini Programs (WeChat)**: [f] [Best Practices for Mini Program Monitoring - To Be Added]

---

### Steps to Integrate RUM into Web Pages:

##### 1. Log in to <<< custom_key.brand_name >>>

##### 2. Select User Access Monitoring — Create New Application — Choose Web Type — Synchronous Loading

![image](../images/web/3.png)

**Note: Choose CDN Synchronous Loading**<br />• Modify the front-end index.html page (remember to back up)<br />Add the following JS file before **</head>**:

| Integration Method | Description                                                                                                                                                             |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM                | By bundling the SDK code with your front-end project, this method ensures no impact on page performance but may miss requests and errors before SDK initialization.   |
| CDN Asynchronous   | Load the SDK script asynchronously via CDN caching. This method ensures no impact on page load performance but may miss requests and errors before SDK initialization. |
| CDN Synchronous    | Load the SDK script synchronously via CDN caching. This method ensures capturing all errors, resources, requests, and performance metrics but may affect page load performance. |

##### 3. Integrate the RUM Observability JS File into the Front-end index.html Page

```
$ cd /usr/local/ruoyi/dist/index.html

// Remember to back up
$ cp index.html index.html.bkd

// Add df-js to index.html
// Copy the JS content from the DF platform and place it before </head> in index.html, then save the file. Example:
// datakitOrigin: Datakit address, the data flow path for RUM in DF is: rum.js file — datakit — dataway — DF platform
   If it's a production environment, set the IP to a domain name; for testing environments, use internal network IPs corresponding to servers running DataKit on port 9529.
// trackInteractions: Configuration for user interaction tracking, enabling statistics on user operations on the page.
// allowedTracingOrigins: Configuration for connecting RUM and APM, fill in the domain names or IPs of backend servers interacting with the front-end page as needed.

$ vim index.html

<head> 
<script src="https://<<< custom_key.static_domain >>>/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'xxxxxxxxxxxxxxxxxxxxxxxxxx',
      datakitOrigin: 'http://127.0.0.1:9529', 
      env: 'test',
      version: '1.0.0',
      trackInteractions: true,
      traceType: 'ddtrace', 
      allowedTracingOrigins: ['http://127.0.0.1']
    })
</script>
</head> 
```

**Important Notes:**

- **datakitOrigin**: Data transmission address. In production environments, if configured as a domain name, the domain request can be forwarded to any server running DataKit on port 9529. If front-end traffic is high, you can add an SLB between the domain and DataKit servers. Front-end JS sends data to the SLB, which forwards requests to multiple DataKit servers on port 9529. Multiple DataKit servers handle RUM data without interrupting session data or affecting RUM data presentation.

Example:

![image](../images/web/4.png)

![image](../images/web/5.png)

- **allowedTracingOrigins**: Connects front-end (RUM) and back-end (APM). This configuration is effective only when RUM is deployed on the front-end and APM on the back-end. Fill in the domain names (production environment) or IPs (testing environment) of backend application servers interacting with the front-end page. **Use Case**: If a slow response on the front-end is caused by backend code issues, you can trace the slow request data from RUM to APM to identify the root cause. **Implementation Principle**: When a user accesses a front-end application, the application triggers resource and request calls, initiating RUM-JS performance data collection. RUM-JS generates a trace-id in the request header, which the backend ddtrace reads and records in its trace data, allowing correlation via the same trace-id.
- **env**: Required, specifies the environment (e.g., test, product, etc.).
- **version**: Required, specifies the application version number.
- **trackInteractions**: Tracks user interactions like button clicks and form submissions.
- **traceType**: Optional, defaults to `ddtrace`. Supports `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent`.

![image](../images/web/6.png)

##### 4. Save, Verify, and Publish the Page

Open a browser and visit the target page. Use F12 developer tools to check if there are related RUM requests in the network tab, ensuring the status code is 200.

![image](../images/web/7.png)

**Note**: If the RUM-related request status code is not 200 or shows "connection refused," use `telnet IP:9529` to verify if the port is accessible. If not, modify `/usr/local/datakit/conf.d/datakit.conf` to change `http_listen` from `localhost` to `0.0.0.0` (this setting controls whether external networks can access the server's 9529 port. Setting it to `0.0.0.0` allows both internal and external network access to port 9529, necessary for external RUM data).

![image](../images/web/8.png)

---

### Connecting RUM and APM Data (Front-End and Back-End Correlation via Trace ID):

**Prerequisites**: The back-end application server must have APM monitoring installed (ddtrace/dd-agent). See [Distributed Tracing (APM) Best Practices](../apm), and add DF-RUM monitoring on the front-end.<br />**Configuration**: Add the `allowedTracingOrigins` tag in the already integrated df-rum-js in the front-end HTML and fill in the corresponding back-end domain names, e.g., if dataflux.cn has RUM monitoring, add `https://www.dataflux.cn/` to `allowedTracingOrigins`. If multiple domains exist, configure them using commas. Third-party domains do not need to be configured.

![image](../images/web/9.png)

Example of connected data:

![image](../images/web/10.png)

![image](../images/web/11.png)

![image](../images/web/12.png)

![image](../images/web/13.png)

---

## DF-WEB Application Monitoring (RUM) Application Analysis:

**Parameter Descriptions:**

| Parameter                           | Type    | Required | Default Value | Description                                                                                                                                                                                                                                                       |
| ----------------------------------- | ------- | -------- | ------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                     | String  | Yes     |               | Application ID created in DataFlux                                                                                                                                                                                                                                  |
| `datakitOrigin`                     | String  | Yes     |               | Datakit data reporting origin: <br />`Protocol (including //), domain (or IP address)[and port]`<br /> Examples:<br />[https://www.datakit.com](https://www.datakit.com), <br />[http://100.20.34.3:8088](http://100.20.34.3:8088)                                          |
| `env`                               | String  | No      |               | Current environment of the web application, e.g., prod: production environment; gray: gray release environment; pre: pre-release environment; common: daily environment; local: local environment;                                                                                                                                                  |
| `version`                           | String  | No      |               | Version number of the web application                                                                                                                                                                                                                                           |
| `resourceSampleRate`                | Number  | No      | `100`         | Resource metric data collection percentage: <br />`100`<br /> means full collection, <br />`0`<br /> means no collection                                                                                                                                                                             |
| `sampleRate`                        | Number  | No      | `100`         | Metric data collection percentage: <br />`100`<br /> means full collection, <br />`0`<br /> means no collection                                                                                                                                                                                 |
| `trackSessionAcrossSubdomains`      | Boolean | No      | `false`       | Share cache across subdomains under the same domain                                                                                                                                                                                                                             |
| `allowedTracingOrigins`             | Array   | No      | `[]`          | List of origins or regex patterns for headers injected by `ddtrace` collector. Can be origins or regex patterns: <br />`Protocol (including //), domain (or IP address)[and port]`<br /> Examples:<br />`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]` |
| `trackInteractions`                 | Boolean | No      | `false`       | Enable user interaction tracking                                                                                                                                                                                                                                       |

### Core Metrics

DataFlux's Web Application Analysis integrates Google's Core Web Vitals (LCP, FID, CLS) to measure website loading speed, interactivity, and stability.

| Metric                          | Description                                                            | Target Value    |
| ----------------------------- | --------------------------------------------------------------- | --------- |
| LCP(Largest Contentful Paint) | Time taken to load the largest content element within the viewport                | Less than 2.5s  |
| FID(First Input Delay)        | Delay time when the user first interacts with the webpage                              | Less than 100ms |
| CLS(Cumulative Layout Shift)  | Measures layout shifts during page load, 0 indicates no changes. | Less than 0.1   |

![image](../images/web/14.png)

### Scenario Analysis

DataFlux provides visual Web Application Analysis with built-in multi-dimensional Web Application Monitoring data scenes, including Overview, Page Performance Analysis, Resource Loading Analysis, and JS Error Analysis.

#### Overview

The Overview scene of Web Applications includes error counts, error rates, session counts, session distribution, browsers, operating systems, most visited pages, and resource error rankings. It visually presents user access data to quickly identify issues with Web Applications and improve user access performance. You can filter by environment and version to view connected Web Applications.

![image](../images/web/15.png)

#### Performance Analysis

Page Performance Analysis of Web Applications includes PV counts, page load times, core metrics, most visited page sessions, page long task analysis, XHR & Fetch analysis, and resource analysis. It visually displays the overall performance of Web Applications, helping to precisely identify pages that need optimization. You can filter by environment and version to view connected Web Applications.

![image](../images/web/16.png)

#### Resource Analysis

Resource Analysis of Web Applications includes resource classification, XHR & Fetch analysis, and resource timing analysis. It visually displays the overall resource situation of Web Applications. By analyzing resource request rankings, it helps precisely identify resources that need optimization. You can filter by environment and version to view connected Web Applications.

![image](../images/web/17.png)

#### Error Analysis

JS Error Analysis of Web Applications includes error rates, error classifications, error versions, and network error distributions. It visually displays the overall error situation of Web Applications. By analyzing affected resource errors, it helps quickly identify problematic resources. You can filter by environment and version to view connected Web Applications.

![image](../images/web/18.png)