# Web Application Monitoring (RUM) Best Practices

---

## Prerequisites

- Register an account and log in using your registered credentials at the [Guance official website](https://www.guance.cn/).
- Install DataKit on your server <[Install DataKit](../../datakit/datakit-install.md)>.

## Introduction to Web Application Monitoring (RUM):

**RUM** stands for **Real User Monitoring**, which focuses on managing the real user experience. As mobile internet has developed, more and more businesses present their final business outcomes on the client side, specifically through RUM endpoints. These include Mobile-APPs, web pages, and mini-programs (WeChat, Alipay, Toutiao, etc.). With the intense competition in the internet industry, the end-user experience can directly impact new user acquisition, retention, corporate image, and even revenue. Therefore, enhancing the end-user experience is a critical consideration for both internet companies and traditional enterprises undergoing or planning digital transformation.

---

### Brief Introduction to RUM Principles:

**Principle Explanation:** The method of collecting RUM data has evolved over several generations. Currently, the most common standard is based on the W3C (World Wide Web Consortium) defined [[navigation-timing](https://www.w3.org/TR/navigation-timing/)] standard (see the figure below). This standard details various browser events, allowing simple calculations to determine front-end page metrics such as first screen load time, white screen time, DOM loading time, and HTML loading time. Compared to F12 inspection mode in test environments, this standard effectively collects real user front-end experiences in production environments. It is particularly popular in H5 application scenarios. Commercial software in China (Tingyun, Borui, Cloudwise, OneAPM) all rely on this standard for their web monitoring systems, which is applicable to most H5 scenarios.

![image](../images/web/2.png)

As browsers (especially Chrome) and front-end technologies have advanced, the limitations of navigation-timing have become more apparent, especially with the increasing prevalence of single-page applications in front-end and back-end separation scenarios. Thus, W3C introduced a new standard [[PaintTiming-github](https://github.com/w3c/paint-timing/)] [[PaintTiming-api](https://developer.mozilla.org/en-US/docs/Web/API/PerformancePaintTiming)]. This new standard introduces metrics such as First Paint and First Contentful Paint, better reflecting the actual user experience when accessing web pages. DF-RUM uses data collection methods that support the PaintTiming specification. For those interested in this specification, further reading can be found at [[Improving Performance Using Paint Timing API](https://zhuanlan.zhihu.com/p/30389490)] [[Using PaintTiming](https://www.w3cplus.com/performance/paint-timing-api.html)].

---

DF officially supports the following RUM monitoring methods:
- **Web Applications**: [[Integrating Web Applications with DF Monitoring](../../real-user-monitoring/web/app-access.md)] [Best Practices for Web Application Monitoring]
- **Mobile Apps (Android & iOS)**: [ [Integrating Android with DF Monitoring](../../mobile/index.md)] [ [Integrating iOS with DF Monitoring](../../mobile/index.md)] [Best Practices for Mobile App Monitoring - To Be Added]
- **Mini Programs (WeChat)**: [f] [Best Practices for Mini Program Monitoring - To Be Added]

---

### Steps to Integrate RUM into Web Pages:

##### 1. Log in to Guance

##### 2. Select User Access Monitoring — Create New Application — Choose Web Type — Synchronous Loading

![image](../images/web/3.png)

**Note: Choose CDN Synchronous Loading**<br />• Modify the front-end index.html page (remember to back up)<br /> Add the copied JS file before **</head>**:

| Integration Method | Description                                                                                                                                                             |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM                | Package the SDK code together with your front-end project to ensure no impact on page performance, but may miss requests and errors before SDK initialization.        |
| CDN Asynchronous   | Load the SDK script asynchronously via CDN caching to ensure it does not affect page load performance, but may miss requests and errors before SDK initialization. |
| CDN Synchronous    | Load the SDK script synchronously via CDN caching to ensure capturing all errors, resources, requests, and performance metrics, but may affect page load performance. |

##### 3. Integrate the Observable JS File into the Front-End index.html Page

```bash
$ cd /usr/local/ruoyi/dist/index.html

// Remember to back up
$ cp index.html index.html.bkd

// Add df-js to index.html
// Copy the JS content from the DF platform and place it before </head>, then save the file. Example:
// datakitOrigin: DataKit address, data flow for RUM data is rum.js file — DataKit — DataWay — DF platform
// For production environments, set the IP to a domain name; for testing environments, use internal network IPs corresponding to servers running DataKit on port 9529.
// trackInteractions: Configuration for user behavior collection, enabling tracking of user operations on the page.
// allowedTracingOrigins: Configuration for linking RUM and APM, specify backend server domains or IPs interacting with the front-end.

$ vim index.html

<head> 
<script src="https://static.guance.com/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
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

**Notes:**

- **datakitOrigin**: Data transmission address. In production environments, if configured as a domain name, the domain request can be forwarded to any server running DataKit on port 9529. If front-end traffic is high, consider adding a load balancer (SLB) between the domain and DataKit servers. The SLB forwards requests to multiple DataKit servers, ensuring session data continuity and accurate RUM data presentation.

Example:

![image](../images/web/4.png)

![image](../images/web/5.png)

- **allowedTracingOrigins**: Enables linking between front-end RUM and back-end APM. This feature only works if RUM is deployed on the front-end and APM on the back-end. Specify the domains (for production) or IPs (for testing) of backend servers interacting with the front-end. **Use Case**: If a slow front-end request is due to backend code issues, you can jump from RUM slow request data to APM data to analyze the backend code calls and identify the root cause. **Implementation Principle**: When a user accesses the front-end application, resource and request calls trigger rum-js performance data collection. rum-js generates a trace-id in the request_header, which is read by the backend ddtrace and recorded in its trace data, allowing correlation via the same trace-id.
- **env**: Required, specifies the environment (e.g., `test`, `product`).
- **version**: Required, specifies the application version number.
- **trackInteractions**: Enables user behavior statistics, such as button clicks and form submissions.
- **traceType**: Optional, defaults to `ddtrace`. Supports `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent`.

![image](../images/web/6.png)

##### 4. Save, Verify, and Publish the Page

Open a browser and visit the target page. Use F12 Developer Tools to check if there are any RUM-related requests with a status code of 200.

![image](../images/web/7.png)

**Note**: If the RUM-related request status code is not 200 or shows "connection refused," use `telnet IP:9529` to verify if the port is accessible. If not, modify `/usr/local/datakit/conf.d/datakit.conf` to change `http_listen` from `localhost` to `0.0.0.0` (this configuration controls whether the current server's port 9529 can be accessed externally. Setting it to `0.0.0.0` allows both internal and external access).

Example:

![image](../images/web/8.png)

---

### Linking RUM and APM Data via Trace ID:

**Prerequisites**: Backend application servers must have APM monitoring installed, i.e., ddtrace (dd-agent). See [Distributed Tracing (APM) Best Practices](../apm) for details. Front-end RUM monitoring should also be added.<br />**Configuration**: Add the `allowedTracingOrigins` tag in the already integrated df-rum-js in the front-end HTML and fill in the corresponding backend domains. For example, if dataflux.cn adds RUM monitoring, configure `https://www.dataflux.cn/` in `allowedTracingOrigins`. If there are multiple domains, separate them with commas. Third-party domains do not need to be configured.

![image](../images/web/9.png)

Example of linked effects:

![image](../images/web/10.png)

![image](../images/web/11.png)

![image](../images/web/12.png)

![image](../images/web/13.png)

---

## DF-WEB Application Monitoring (RUM) Application Analysis:

**Parameter Descriptions:**

| Parameter                        | Type     | Required | Default Value | Description                                                                                                                                                                                                                                                       |
| -------------------------------- | -------- | -------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                  | String   | Yes      |               | Application ID created in DataFlux                                                                                                                                                                                                                                 |
| `datakitOrigin`                  | String   | Yes      |               | DataKit data reporting Origin: <br />`Protocol (including //), domain (or IP address)[and port]`<br /> Examples:<br />[https://www.datakit.com](https://www.datakit.com), <br />[http://100.20.34.3:8088](http://100.20.34.3:8088)                                          |
| `env`                            | String   | No       |               | Current environment of the web application, e.g., prod: production; gray: gray release; pre: pre-release; common: daily; local: local                                                                                                                             |
| `version`                        | String   | No       |               | Version number of the web application                                                                                                                                                                                                                             |
| `resourceSampleRate`             | Number   | No       | `100`         | Resource metric data collection percentage: <br />`100`<br /> indicates full collection, <br />`0`<br /> indicates no collection                                                                                                                                 |
| `sampleRate`                     | Number   | No       | `100`         | Metric data collection percentage: <br />`100`<br /> indicates full collection, <br />`0`<br /> indicates no collection                                                                                                                                           |
| `trackSessionAcrossSubdomains`   | Boolean  | No       | `false`       | Share cache across subdomains under the same domain                                                                                                                                                                                                               |
| `allowedTracingOrigins`          | Array    | No       | `[]`          | List of origins or regex patterns allowed to inject `ddtrace` headers. Origins can be protocols (including //), domains (or IP addresses)[and ports]. Examples: <br />`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]`                       |
| `trackInteractions`              | Boolean  | No       | `false`       | Enable user interaction tracking                                                                                                                                                                                                                                  |

### Core Website Metrics

DataFlux integrates Google's core web vitals (LCP, FID, CLS) to measure website load speed, interactivity, and visual stability.

| Metric                          | Description                                                            | Target Value    |
| ----------------------------- | --------------------------------------------------------------- | --------- |
| LCP(Largest Contentful Paint) | Measures the time taken to load the largest content element within the viewport                | Less than 2.5s  |
| FID(First Input Delay)        | Measures the delay between the user's first interaction with the page and the browser's response                              | Less than 100ms |
| CLS(Cumulative Layout Shift)  | Measures how much the layout shifts during page load, where 0 indicates no changes. | Less than 0.1   |

![image](../images/web/14.png)

### Scenario Analysis

DataFlux provides visualized web application analysis with built-in multi-dimensional monitoring data scenarios, including summary, page performance analysis, resource loading analysis, and JS error analysis.

#### Summary

The summary scene of web applications includes statistics on page visit errors, error rates, session counts, session distribution, browsers, operating systems, most visited pages, and resource error rankings. This visualization helps quickly identify issues in user visits and improve web application performance. You can filter by environment and version to view connected web applications.

![image](../images/web/15.png)

#### Performance Analysis

Page performance analysis of web applications involves metrics like PV count, page load time, core website metrics, most viewed page sessions, long task analysis, XHR & Fetch analysis, and resource analysis. This visualization provides real-time insights into overall web application performance, helping pinpoint pages that need optimization. You can filter by environment and version to view connected web applications.

![image](../images/web/16.png)

#### Resource Analysis

Resource analysis of web applications includes metrics like resource classification, XHR & Fetch analysis, and resource timing analysis. This visualization offers real-time insights into the overall resource situation of web applications. By analyzing resource request rankings, you can precisely identify resources needing optimization. You can filter by environment and version to view connected web applications.

![image](../images/web/17.png)

#### Error Analysis

JS error analysis of web applications includes metrics like error rate, error classification, error versions, and network error status distribution. This visualization provides real-time insights into overall web application error conditions. By analyzing affected resource errors, you can quickly identify resource issues. You can filter by environment and version to view connected web applications.

![image](../images/web/18.png)