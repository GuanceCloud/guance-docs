# Web Application Access
---

## Update Logs
2022.9.29

- The initialization parameter adds `isIntakeUrl` configuration, which is used to determine whether the data of the corresponding resource needs to be captured according to the requested resource url, and by default they are all captured. 

2022.3.10

-   New `traceType` configuration, configure the link tracing tool type, if not configure the default is `ddtrace`. Currently supports `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent` 6 data types.
- New `allowedTracingOrigins` allows to inject a list of all requests with the header headers required by the trace collector. It can be the origin of the request, or it can be a regular.
- The original configuration item `allowedDDTracingOrigins` and the new configuration item `allowedTracingOrigins` are part of the same feature configuration. Either one can be configured, but if both are configured, `allowedTracingOrigins` is given more weight than `allowedDDTracingOrigins`.

2021.5.20 

-  In line with the V2 version metric data changes, you need to upgrade the DataKit 1.1.7-rc0 onwards Refer to [DataKit Configuration](... /... /datakit/rum.md). 
- SDK upgrade V2, CDN address changed to `https://static.guance.com/browser-sdk/v2/dataflux-rum.js`.
- Removed `rum_web_page_performance`, `rum_web_resource_performance`, ` js_error`, `page` metrics data collection, added `view`, `action`, `long_task`, `error` metrics data collection.
- Initialize the new `trackInteractions` configuration to enable action (user behavior data) collection, and turn off the default state.

## Overview

Guance Real User Monitoring can analyze the performance of each Web application in a visual way by collecting the metrics data of each Web application.

## Precondition

- Installing DataKit ([DataKit Installation Documentation](.../.../datakit/datakit-install.md))

  
## Web Application Access

Login to Guance Console, enter "Real User Monitoring" page, click "New Application" in the upper right corner, enter "Application Name" and customize "Application ID" in the new window, and click "Create" to select the application type to get access.

- Application Name (required): The name of the application used to identify the current implementation of user access monitoring.
- Application ID (required): The unique identification of the application in the current workspace, which is used for SDK data collection and upload matching, and corresponds to the field: app_id after data entry. This field only supports English, numeric, underscore input, up to 48 characters.

![](../img/sampling.png)



| Access method            | Introduction                                                 |
| ------------------------ | ------------------------------------------------------------ |
| NPM                      | By packaging the SDK code together with your front-end project, this approach ensures that there will be no impact on the performance of the front-end pages, although requests, and errors collected prior to the initialization of the SDK may be missed. |
| CDN Asynchronous Loading | The SDK scripts are introduced as asynchronous scripts through CDN accelerated caching. This approach ensures that the download of SDK scripts does not affect the page loading performance, although requests, errors collected before the initialization of the SDK may be missed. |
| CDN Synchronous Loading  | The SDK scripts are introduced as synchronous scripts through CDN accelerated caching, this way you can ensure that all errors, resources, requests, performance metrics can be collected. However, it may affect the page loading performance. |

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    
    datafluxRum.init({
        applicationId: '<DATAFLUX_APPLICATION_ID>',
        datakitOrigin: '<DATAKIT ORIGIN>',
        env: 'production',
        version: '1.0.0',
        trackInteractions: true,
    })
    ```

=== "CDN Asynchronous Loading"

    ```javascript
    <script>
    (function (h, o, u, n, d) {
        h = h[d] = h[d] || {
        q: [],
        onReady: function (c) {
            h.q.push(c)
        }
        }
        d = o.createElement(u)
        d.async = 1
        d.src = n
        n = o.getElementsByTagName(u)[0]
        n.parentNode.insertBefore(d, n)
    })(
        window,
        document,
        'script',
        'https://static.guance.com/browser-sdk/v2/dataflux-rum.js',
        'DATAFLUX_RUM'
    )
    DATAFLUX_RUM.onReady(function () {
        DATAFLUX_RUM.init({
            applicationId: '<DATAFLUX_APPLICATION_ID>',
            datakitOrigin: '<DATAKIT ORIGIN>',
            env: 'production',
            version: '1.0.0',
            trackInteractions: true,
        })
    })
    </script>
    ```

=== "CDN Synchronous Loading"

    ```javascript
    <script
    src="https://static.guance.com/browser-sdk/v2/dataflux-rum.js" 
    type="text/javascript"
    ></script>
    <script>
    window.DATAFLUX_RUM &&
        window.DATAFLUX_RUM.init({
            applicationId: '<DATAFLUX_APPLICATION_ID>',
            datakitOrigin: '<DATAKIT ORIGIN>',
            env: 'production',
            version: '1.0.0',
            trackInteractions: true,
        })
    </script>
    ```

## Configuration

### Initialization Parameters

| Parameter                      | Type     | Required | Default Value                      | Description                                                  |
| ------------------------------ | -------- | -------- | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                | String   | Yes    |                                    | Application IDs created from the Guance                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `datakitOrigin`                | String   | Yes    |                                    | Datakit data reporting Origin comments: <br>`Protocol (including: //), domain name (or IP address) [and port number]`<br> For example.<br>[https://www.datakit.com](https://www.datakit.com), <br>[http://100.20.34.3:8088](http://100.20.34.3:8088)                                                                                                                                                                                                                       |
| `env`                          | String   | No      |                                    | The current environment of the web application, such as prod: online environment; gray: grayscale environment; pre: pre-release environment common: daily environment; local: local environment.                                                                                                                                                                                                                                                           |
| `version`                      | String   | No     |                                    | Version number of the web application                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `service` | String | No | | The service name of the current application, default is `browser`, custom configuration is supported. |
| `sampleRate`                   | Number   | No     | `100`                              | Percentage of metric data collection: <br>`100`<br>indicates full collection.<br>`0`<br>Indicates no collection                                                                                                                                                                                                                                                                                                                                                                                                            |
| `trackSessionAcrossSubdomains` | Boolean  | No     | `false`                            | Shared caching of subdomains under the same domain                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `traceType`                    | Enum     | No     | `ddtrace`                          | [New] Configure the link tracing tool type, if not configure the default is `ddtrace`. Currently support `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent` 6 kinds of data types. Note: `opentelemetry` supports `zipkin_single_header`,`w3c_traceparent`,`zipkin`,`jaeger` 4 types.<br><br>Note: 1. This configuration depends on the allowedTracingOrigins configuration item for it to take effect. 2. Configuring the traceType of the appropriate type requires setting different Access-Control-Allow-Headers for the corresponding API service to see how APM associates with RUM, see [how APM associates with RUM](../../application-performance-monitoring/collection/connect-web-app.md) |
| `traceId128Bit`                | Boolean  | No     | `false`                            | Whether to generate ` traceID ` in 128 bytes, corresponding to ` traceType `, currently supported types ` zipkin `, ` jaeger `                                                                                                                                                                                                                                                                                                                                                |
| `allowedDDTracingOrigins`      | Array    | No     | `[]`                               | [Not recommended] All requests list of header headers required to allow injection into trace collector. Can be the origin of the request, or can be is a regular, origin: ` protocol (including://), domain name (or IP address) [and port number] `<br> For example.<br>`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]` |
| `allowedTracingOrigins`        | Array    | No     | `[]`                               | [New] Allows to inject a list of all requests in the header header required by the `trace` collector. Can be the origin of the request, or can be is a regular, origin: `protocol (including: //), domain name (or IP address) [and port number]`<br> For example.<br>`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]`                                                             |
| `trackInteractions`            | Boolean  | No     | `false`                            | Whether to open user behavior collection                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `isServerError`                | Function | No     | `function(request) {return false}` | By default, a request with status code >= 500 is defined as an error request and will be collected as error metric data accordingly. In order to satisfy some scenarios that may not be judged by the status code to determine the error of the business request, we provide a user-defined way to determine whether the request is an `error` request, the callback parameter is the relevant return parameter for the request: `{ isAborted: false, method: "get",response : "{...}" ,status: 200,url: "xxxx" }`, if the method returns true, then the data related to the request will be collected as the `error` metric <br>*The result of the method must be Boolean, otherwise it is considered an invalid parameter* |
| `isIntakeUrl`                    | Function | No     | `function(url) {return false}`     | The custom method determines whether the data of the corresponding resource should be collected according to the requested resource url, and the default is to collect them all. Return: `false` means to collect, `true` means not to collect <br>*The result of the method must be Boolean, otherwise it is considered an invalid parameter*<br/>**Note: Version requirement is v2.1.5 and above** |

## Questions

### Reasons for Script Error Messages

When using DataFlux Web Rum Sdk for web-side error collection, you often see an error message like Script error. in `js_error` without any details included.

#### Possible Reasons for the Above Problem

1. The user is using a browser that does not support error catching (very unlikely).
2. The error script file is loaded to the page across the domain.
   We can't deal with the case that the user's browser doesn't support this; here we mainly address the reasons and solutions for not collecting cross-domain script errors.

In general, script files are loaded using the `<script>` tag. For homologous script errors, when using the browser's `GlobalEventHandlers API`, the error message collected will contain detailed error information; when a different source script error occurs, the error message collected will only be the `Script error.` text, which is controlled by the This is controlled by the browser's homology policy, and is the normal case. For non-homologous scripts we only need to do non-homologous resource sharing (also called HTTP access control / CORS).

### Solution

#### 1.Script files are stored directly on the server

Add Header to static file output on the server

```
Access-Control-Allow-Origin: *
```

Add the genus crossorigin="anonymous" to the Script tag where the non-homologous script is located

```
<script type="text/javascript" src="path/to/your/script.js" crossorigin="anonymous"></script>
```

#### 2.Script files are stored on CDN

Add Header to the CDN settings

```
Access-Control-Allow-Origin: *
```

Add the genus crossorigin="anonymous" to the Script tag where the non-homologous script is located

```
<script type="text/javascript" src="path/to/your/script.js" crossorigin="anonymous"></script>
```

#### 3.Script files are loaded from third parties

Add the genus crossorigin="anonymous" to the Script tag where the non-homologous script is located

```
<script type="text/javascript" src="path/to/your/script.js" crossorigin="anonymous"></script>
```

### Reference and Extended Reading

[GlobalEventHandlers.onerror](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onerror)

[Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)

[The Script element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script)

[CORS settings attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/CORS_settings_attributes)

### Incomplete Collection of Resource Data (ssl, tcp, dns, trans,ttfb)

During the data reporting process, some of the resource timing data may be collected incompletely. For example, tcp, dns data is not collected and reported.

### Reasons for the Above Problems

1. For example, if dns data is not collected, it is possible that this resource request of your application is kept linked with `keep-alive`, this situation is only when you make the first request, there will be the process of creating the link, after that the requests will keep the same connection and will not recreate the tcp connection. So there will be a situation where the dns data is not available, or the data is `0`.
2. The resources of the application are loaded to the page in the form of cross-domain, and your website is not the same source (the main reason).
3. The browser does not support the `Performance API` (very rare case)

### For Cross-Domain Resources {#header}

#### 1.Resource files are stored directly on the server

Add Header to resource file output on the server

```
Timing-Allow-Origin: *
```

#### 2. Resource files are stored on CDN

Add Header to the CDN settings

```
Timing-Allow-Origin: *
```

### Reference and Expansion

[Coping_with_CORS](https://developer.mozilla.org/en-US/docs/Web/API/Resource_Timing_API/Using_the_Resource_Timing_API#Coping_with_CORS)

[Resource Timing Standard; W3C Editor's Draft](https://w3c.github.io/resource-timing/)

[Resource Timing practical tips; Steve Souders](http://www.stevesouders.com/blog/2014/08/21/resource-timing-practical-tips/)

[Measuring network performance with Resource Timing API](http://googledevelopers.blogspot.ca/2013/12/measuring-network-performance-with.html)

