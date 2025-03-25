---
title     : 'JavaScript'
summary   : 'Monitor the usage behavior of browser users via the JavaScript (Web) method.'
__int_icon: 'icon/javascript'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JavaScript
<!-- markdownlint-enable -->

JavaScript falls under the category of [RUM (Real User Monitoring)](../real-user-monitoring/), primarily used for detecting browser user access behaviors and reporting them to <<< custom_key.brand_name >>>.


## Configuration {#config}

### DataKit Enable RUM Collector

[Enable RUM Collector](rum.md)

### Web Application Integration

There are three ways to integrate web applications: NPM integration, synchronous loading, and asynchronous loading.

| Integration Method | Overview                                                                                                                                                             |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM               | By bundling the SDK code into your frontend project, this method ensures no impact on the performance of the frontend page. However, it may miss requests and errors before the SDK initialization. |
| CDN Asynchronous Loading | Through CDN caching with asynchronous script inclusion, this method ensures that the download of the SDK script does not affect the page's loading performance. However, it may miss requests and errors before the SDK initialization. |
| CDN Synchronous Loading | Through CDN caching with synchronous script inclusion, this method ensures the collection of all errors, resources, requests, and performance metrics. However, it may affect the page's loading performance. |

<!-- markdownlint-disable MD046 -->
=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    
    datafluxRum.init({
      applicationId: 'guance',
      datakitOrigin: '<DATAKIT ORIGIN>', // Protocol (including: //), domain name (or IP address) [and port number]
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackInteractions: true,
      traceType: 'ddtrace', // Optional, default is ddtrace. Currently supports 6 types: ddtrace, zipkin, skywalking_v-jaeger, zipkin_single_header, w3c_traceparent.
      allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, list of all request origins where headers needed by the trace collector can be injected. Can be a request origin or a regular expression.
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
        'https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js',
        'DATAFLUX_RUM'
      )
      DATAFLUX_RUM.onReady(function () {
        DATAFLUX_RUM.init({
          applicationId: 'guance',
          datakitOrigin: '<DATAKIT ORIGIN>', // Protocol (including: //), domain name (or IP address) [and port number]
          env: 'production',
          version: '1.0.0',
          sessionSampleRate: 100,
          sessionReplaySampleRate: 70,
          trackInteractions: true,
          traceType: 'ddtrace', // Optional, default is ddtrace. Currently supports 6 types: ddtrace, zipkin, skywalking_v-jaeger, zipkin_single_header, w3c_traceparent.
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, list of all request origins where headers needed by the trace collector can be injected. Can be a request origin or a regular expression.
        })
      })
    </script>
    ```

=== "CDN Synchronous Loading"

    ```javascript
    <script src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js" type="text/javascript"></script>
    <script>
      window.DATAFLUX_RUM &&
        window.DATAFLUX_RUM.init({
          applicationId: 'guance',
          datakitOrigin: '<DATAKIT ORIGIN>', // Protocol (including: //), domain name (or IP address) [and port number]
          env: 'production',
          version: '1.0.0',
          sessionSampleRate: 100,
          sessionReplaySampleRate: 70,
          trackInteractions: true,
          traceType: 'ddtrace', // Optional, default is ddtrace. Currently supports 6 types: ddtrace, zipkin, skywalking_v-jaeger, zipkin_single_header, w3c_traceparent.
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, list of all request origins where headers needed by the trace collector can be injected. Can be a request origin or a regular expression.
        })
    </script>
    ```
<!-- markdownlint-enable -->

### Parameter Configuration

JavaScript provides many parameters to achieve personalized [configuration](../real-user-monitoring/web/app-access.md#config) for web monitoring.
