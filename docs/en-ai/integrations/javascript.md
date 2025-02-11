---
title     : 'JavaScript'
summary   : 'Monitor browser user behavior using JavaScript (Web)'
__int_icon: 'icon/javascript'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JavaScript
<!-- markdownlint-enable -->

JavaScript falls under the [RUM (Real User Monitoring)](../real-user-monitoring/) category, primarily used to monitor browser user activity and report it to Guance.


## Configuration {#config}

### Enable RUM Collector in DataKit

[Enable RUM Collector](rum.md)

### Web Application Integration

There are three methods for integrating web applications: NPM integration, asynchronous loading, and synchronous loading.

| Integration Method | Description                                                                                                                                                             |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM                | By bundling the SDK code into your front-end project, this method ensures no impact on the performance of the front-end page. However, it may miss requests and errors before the SDK initializes. |
| CDN Asynchronous Loading | Through CDN caching, asynchronously load the SDK script. This method ensures that the download of the SDK script does not affect the page loading performance but may miss requests and errors before the SDK initializes. |
| CDN Synchronous Loading | Through CDN caching, synchronously load the SDK script. This method ensures all errors, resources, requests, and performance metrics are collected but may impact page loading performance. |

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
      traceType: 'ddtrace', // Optional, default is ddtrace. Currently supports 6 types: ddtrace, zipkin, skywalking_v-jaeger, zipkin_single_header, w3c_traceparent
      allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, list of origins or regex patterns for headers injection
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
        'https://static.guance.com/browser-sdk/v3/dataflux-rum.js',
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
          traceType: 'ddtrace', // Optional, default is ddtrace. Currently supports 6 types: ddtrace, zipkin, skywalking_v-jaeger, zipkin_single_header, w3c_traceparent
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, list of origins or regex patterns for headers injection
        })
      })
    </script>
    ```

=== "CDN Synchronous Loading"

    ```javascript
    <script src="https://static.guance.com/browser-sdk/v3/dataflux-rum.js" type="text/javascript"></script>
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
          traceType: 'ddtrace', // Optional, default is ddtrace. Currently supports 6 types: ddtrace, zipkin, skywalking_v-jaeger, zipkin_single_header, w3c_traceparent
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, list of origins or regex patterns for headers injection
        })
    </script>
    ```
<!-- markdownlint-enable -->

### Parameter Configuration

JavaScript provides many parameters for personalized [configuration](../real-user-monitoring/web/app-access.md#config) of web monitoring.
</input_content>