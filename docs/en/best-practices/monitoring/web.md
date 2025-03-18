# Web Application Monitoring (RUM) Best Practices

---

## Prerequisites

- Register an account on the [<<< custom_key.brand_name >>> website](https://www.guance.cn/) and log in using your registered account credentials.
- Install DataKit on the server<[Install DataKit](../../datakit/datakit-install.md)>.

## Introduction to Web Application Monitoring (RUM):

**RUM** stands for **_Real User Monitoring (real user experience management)_**. With the development of mobile internet, more and more businesses ultimately present their services to end users, which is where RUM comes into play. Specific forms include Mobile-APPs, web pages, and mini-programs (WeChat, Alipay, Toutiao, etc.). As the internet industry evolves, competition across industries has become increasingly fierce. The real user's terminal experience can directly impact new user acquisition, retention, corporate image, and even revenue. Therefore, improving the terminal user experience has become a critical consideration for both internet companies and traditional enterprises undergoing or planning digital transformation.

---

### Brief Introduction to RUM Principles:

**Principle Explanation:** The method of collecting RUM data has evolved over several generations. Currently, the most common approach is based on the W3C (World Wide Web Consortium) defined [[navigation-timing](https://www.w3.org/TR/navigation-timing/)] standard (see the figure below). This standard meticulously defines various browser events, allowing for simple calculations to determine metrics such as first screen load time, white screen time, DOM loading, HTML loading, etc. Compared to the F12 developer tools in test environments, this method can more effectively collect real user front-end experiences in production environments. It is particularly popular in H5 application scenarios. Domestic commercial software (such as Tingyun, Bonree, Cloudwise, OneAPM) all rely on this standard to build their web monitoring systems, applicable to most H5 scenarios.

![image](../images/web/2.png)

As browsers (especially Chrome) and front-end technologies have advanced, the limitations of navigation-timing have become more apparent. For example, single-page applications (SPAs) are becoming more common due to front-end and back-end separation. In these scenarios, collecting data based on navigation-timing can be cumbersome. Therefore, W3C introduced a new standard [[PaintTiming-github](https://github.com/w3c/paint-timing/)] [[PaintTiming-api](https://developer.mozilla.org/en-US/docs/Web/API/PerformancePaintTiming)]. This standard introduces new metrics like First Paint (FP) and First Contentful Paint (FCP), better reflecting the real user experience when visiting web pages. DF-RUM adopts data collection methods that support the PaintTiming specification. For those interested in this specification, you can read further [[Improving Performance with Paint Timing API](https://zhuanlan.zhihu.com/p/30389490)] [[Using Paint Timing](https://www.w3cplus.com/performance/paint-timing-api.html)].

---

DF officially supports the following RUM monitoring methods:
**Web Applications**: [[Integrate Web Applications with DF Monitoring](../../real-user-monitoring/web/app-access.md)] [Best Practices for Web Application Monitoring]<br />**Apps (Android & iOS)**: [ [Integrate Android with DF Monitoring](../../mobile/index.md)] [ [Integrate iOS with DF Monitoring](../../mobile/index.md)] [Best Practices for App Monitoring - To be added][]<br />**Mini Programs (WeChat)**: [f] [Best Practices for Mini Program Monitoring - To be added]

---

### Steps to Integrate RUM into Web Pages:

##### 1. Log in to <<< custom_key.brand_name >>>

##### 2. Select User Access Monitoring — Create Application — Choose Web Type — Sync Loading

![image](../images/web/3.png)

**Note: Choose CDN Sync Loading**<br />• Modify the front-end index.html page (remember to back up)<br /> Add the copied JS file before the **</head>** tag:

| Integration Method | Description                                                                                                                                                             |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM          | By bundling the SDK code with your front-end project, this method ensures no impact on the front-end page performance but may miss requests and errors before SDK initialization.                       |
| CDN Asynchronous Loading | Through CDN caching, asynchronously introduce the SDK script, ensuring that the SDK script download does not affect page loading performance but may miss requests and errors before SDK initialization. |
| CDN Synchronous Loading | Through CDN caching, synchronously introduce the SDK script, ensuring the collection of all errors, resources, requests, and performance metrics. However, it may affect page loading performance.                 |

##### 3. Integrate the DF observability JS file into the front-end index.html page

```
$ cd /usr/local/ruoyi/dist/index.html

// Remember to back up
$ cp index.html index.html.bkd

// Add df-js to index.html
// Copy the JS content from the DF platform and place it before the </head> tag in index.html, then save the file. Example:
// datakitOrigin: DataKit address, the RUM data flow in DF is: rum.js file —— DataKit —— DataWay —— DF platform
   If it's a production environment, set this IP to a domain name; for testing environments, use internal network IP corresponding to the server running DataKit on port 9529.
// trackInteractions: Configuration for user behavior collection, enabling statistics for user actions on the page.
// allowedTracingOrigins: Configuration for linking RUM and APM, fill in the domain names or IPs of backend servers interacting with the front-end page as needed, e.g., 127.0.0.1 is just an example.

$ vim index.html

<head> 
<script src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
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

- **datakitOrigin**: Data transmission address. In a production environment, if configured as a domain name, the domain request can be forwarded to any server running DataKit on port 9529. If the front-end traffic is too high, consider adding a load balancer (SLB) between the domain and the DataKit server. Front-end JS sends data to the SLB, which forwards the request to multiple DataKit servers. Multiple DataKit servers handle RUM data without interrupting session data or affecting RUM data presentation.

Example:

![image](../images/web/4.png)

![image](../images/web/5.png)

- **allowedTracingOrigins**: Links front-end (RUM) and back-end (APM). This scenario only works when RUM is deployed on the front-end and APM on the back-end. Fill in the domain names (production environment) or IPs (testing environment) of backend application servers interacting with the front-end page. **Use Case**: When a front-end user visit is slow due to abnormal backend code logic, RUM slow request data can directly link to APM data to view the backend code call situation and identify the root cause. **Implementation Principle**: When a user visits a front-end application, it triggers resource and request calls, and rum-js collects performance data. rum-js generates a trace-id and writes it to the request header. When the request reaches the backend, ddtrace reads the trace_id and records it in its own trace data, thus achieving linked monitoring of application performance and user access through the same trace_id.
- **env**: Required, specifies the application environment, e.g., `test` or `product`.
- **version**: Required, specifies the application version number.
- **trackInteractions**: Collects user interactions, such as button clicks and form submissions.
- **traceType**: Optional, defaults to `ddtrace`. Currently supports `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent`.

![image](../images/web/6.png)

##### 4. Save, Verify, and Publish the Page

Open a browser and visit the target page. Use F12 developer tools to check if there are RUM-related requests with a status code of 200.

![image](../images/web/7.png)

**Note**: If the RUM-related request status code is not 200 or shows connection refused, use `telnet IP:9529` to verify if the port is open. If not, modify `/usr/local/datakit/conf.d/datakit.conf` to change `http_listen` from `localhost` to `0.0.0.0` (this configuration controls whether the current server's port 9529 can be accessed externally. Setting it to `127.0.0.1` or `localhost` allows only local or internal network access to the server's port 9529. Setting it to `0.0.0.0` allows both internal and external access, necessary for RUM data transmission).

Example:

![image](../images/web/8.png)

---

### Linking RUM and APM Data (Frontend and Backend via Trace ID):

**Prerequisites**: The backend application server must have APM monitoring installed, i.e., ddtrace (dd-agent). See [Distributed Tracing (APM) Best Practices](../apm) for details. Front-end should add DF-RUM monitoring.<br />**Configuration**: Add the `allowedTracingOrigins` field in the already integrated df-rum-js in the front-end HTML and fill in the corresponding backend domain names, e.g., if dataflux.cn adds RUM monitoring, configure `https://www.dataflux.cn/` in `allowedTracingOrigins`. If there are multiple domains, separate them with commas. Third-party domains do not need to be configured.

![image](../images/web/9.png)

Example after linking:

![image](../images/web/10.png)

![image](../images/web/11.png)

![image](../images/web/12.png)

![image](../images/web/13.png)

---

## DF-WEB Application Monitoring (RUM) Analysis:

**Parameter Description:**

| Parameter                           | Type    | Required | Default Value | Description                                                                                                                                                                                                                                                       |
| ------------------------------------ | ------- | -------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                | String  | Yes      |               | Application ID created in DataFlux                                                                                                                                                                                                                                  |
| `datakitOrigin`                | String  | Yes      |               | DataKit data reporting Origin: <br />`protocol (including ://), domain (or IP address)[and port number]`<br /> e.g.,<br />[https://www.datakit.com](https://www.datakit.com), <br />[http://100.20.34.3:8088](http://100.20.34.3:8088)                                          |
| `env`                          | String  | No       |               | Current environment of the web application, e.g., prod: production environment; gray: gray release environment; pre: pre-release environment; common: daily environment; local: local environment.                                                                                                                                                  |
| `version`                      | String  | No       |               | Version number of the web application                                                                                                                                                                                                                                           |
| `resourceSampleRate`           | Number  | No       | `100`         | Resource metric data collection percentage: <br />`100`<br /> indicates full collection, <br />`0`<br /> indicates no collection                                                                                                                                                                             |
| `sampleRate`                   | Number  | No       | `100`         | Metric data collection percentage: <br />`100`<br /> indicates full collection, <br />`0`<br /> indicates no collection                                                                                                                                                                                 |
| `trackSessionAcrossSubdomains` | Boolean | No       | `false`       | Share cache across subdomains under the same domain                                                                                                                                                                                                                             |
| `allowedTracingOrigins`        | Array   | No       | `[]`          | List of origins or regular expressions allowed to inject `ddtrace` headers. Can be origin or regex, e.g., <br />`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]` |
| `trackInteractions`            | Boolean | No       | `false`       | Enable user interaction tracking                                                                                                                                                                                                                                       |

### Core Metrics

DataFlux integrates Google's Core Web Vitals (LCP, FID, CLS) to measure website loading speed, interactivity, and stability.

| Metric                          | Description                                                            | Target Value    |
| ----------------------------- | --------------------------------------------------------------- | --------- |
| LCP(Largest Contentful Paint) | Measures the time it takes to load the largest content element within the viewport. | Less than 2.5s  |
| FID(First Input Delay)        | Measures the delay between the user's first interaction with the page and the response. | Less than 100ms |
| CLS(Cumulative Layout Shift)  | Measures the visual stability of the page during loading, where 0 means no layout shifts. | Less than 0.1   |

![image](../images/web/14.png)

### Scenario Analysis

DataFlux provides visualized Web application analysis with built-in multi-dimensional Web application monitoring data scenarios, including overview, page performance analysis, resource loading analysis, and JS error analysis.

#### Overview

The overview scene of Web applications statistically presents the number of errors, error rates, sessions, session distribution, browsers, operating systems, most visited pages, resource error rankings, etc. Visualizing user access data helps quickly identify issues with Web application access and improve user experience. You can filter by environment and version to view connected Web applications.

![image](../images/web/15.png)

#### Performance Analysis

Page performance analysis of Web applications includes PV count, page load time, core metrics, most viewed page sessions, page long task analysis, XHR & Fetch analysis, resource analysis, etc. Visualizing real-time overall Web application page performance helps precisely identify pages needing optimization. You can filter by environment and version to view connected Web applications.

![image](../images/web/16.png)

#### Resource Analysis

Resource analysis of Web applications includes resource classification, XHR & Fetch analysis, resource timing analysis, etc. Visualizing real-time overall Web application resource usage helps precisely identify resources needing optimization. You can filter by environment and version to view connected Web applications.

![image](../images/web/17.png)

#### Error Analysis

JS error analysis of Web applications includes error rate, error classification, error versions, network error status distribution, etc. Visualizing real-time overall Web application error conditions helps quickly identify problematic resources. You can filter by environment and version to view connected Web applications.

![image](../images/web/18.png)