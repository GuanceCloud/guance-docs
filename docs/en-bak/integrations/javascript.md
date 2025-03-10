---
title     : 'JavaScript'
summary   : 'Monitoring browser usage behavior through JavaScript (Web)'
__int_icon: 'icon/javascript'
dashboard :
  - desc  : 'No'
    path  : '-'
monitor   :
  - desc  : 'No'
    path  : '-'
---


<!-- markdownlint-disable MD025-->
# JavaScript
<!-- markdownlint-enable -->

JavaScript belongs to the category of [RUM (User Access Detection)](../real-user-monitoring/) and is mainly used to detect browser user access behavior and report it to the observation cloud.



## Configure {#config}


### Starting the RUM collector with DataKit


[Enable RUM Collector](rum.md)


### Web application access


There are three ways to access web applications: NPM access, synchronous loading, and asynchronous loading.


| Access Method | Introduction|
|-------- | --------|
|NPM | By packaging SDK code together into your front-end project, this method can ensure that there is no impact on the performance of front-end pages, but it may miss requests and error collection before SDK initialization|
|CDN Asynchronous Loading | By accelerating caching through CDN, SDK scripts are introduced in an asynchronous manner. This method ensures that downloading SDK scripts does not affect page loading performance, but may miss requests and error collection before SDK initialization|
|CDN synchronous loading | By accelerating caching through CDN and introducing SDK scripts through synchronous scripts, this method ensures that all errors, resources, requests, and performance metrics can be collected. However, it may affect the loading performance of the page|


<!--markdownlint-disable MD046 MD009 MD051-->

=== "NPM"
    
    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    
    datafluxRum.init({
      applicationId: 'guance',
      datakitOrigin: '<DATAKIT ORIGIN>', //protocol (including://), domain name (or IP address) [and port number]
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackInteractions: true,
      traceType: 'ddtrace', //Not required, defaults to ddtrace. Currently supports ddtrace, zipkin, and skywalking_V3, jaeger, zipkin_Single_Header, w3c_6 types of traceparent
      allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  //Not mandatory, allows injection of all request lists in the header header required by the trace collector. It can be the origin of the request or it can be a regular
    })
    ```

=== "CDN asynchronous loading"
    
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
          datakitOrigin: '<DATAKIT ORIGIN>', //protocol (including://), domain name (or IP address) [and port number]
          env: 'production',
          version: '1.0.0',
          sessionSampleRate: 100,
          sessionReplaySampleRate: 70,
          trackInteractions: true,
          traceType: 'ddtrace', //Not required, defaults to ddtrace. Currently supports ddtrace, zipkin, and skywalking_V3, jaeger, zipkin_Single_Header, w3c_6 types of traceparent
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  //Not mandatory, allows injection of all request lists in the header header required by the trace collector. It can be the origin of the request or it can be a regular
        })
      })
    </script>
    ```

=== "CDN synchronous loading"
    
    ```javascript
    <script src="https://static.guance.com/browser-sdk/v3/dataflux-rum.js" type="text/javascript"></script>
    <script>
      window.DATAFLUX_RUM &&
        window.DATAFLUX_RUM.init({
          applicationId: 'guance',
          datakitOrigin: '<DATAKIT ORIGIN>', //protocol (including://), domain name (or IP address) [and port number]
          env: 'production',
          version: '1.0.0',
          sessionSampleRate: 100,
          sessionReplaySampleRate: 70,
          trackInteractions: true,
          traceType: 'ddtrace', //Not required, defaults to ddtrace. Currently supports ddtrace, zipkin, and skywalking_V3, jaeger, zipkin_Single_Header, w3c_6 types of traceparent
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  //Not mandatory, allows injection of all request lists in the header header required by the trace collector. It can be the origin of the request or it can be a regular
        })
    </script>
    ```

<!-- markdownlint-enable -->

### Parameter configuration

JavaScript provides many parameters to achieve personalized [configuration](../real-user-monitoring/web/app-access.md#config) of web monitoring.
