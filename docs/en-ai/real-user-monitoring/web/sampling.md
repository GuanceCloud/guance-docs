# How to Configure RUM Sampling
---

## Introduction

<<< custom_key.brand_name >>> supports collecting data from Web, Android, iOS, and mini-program applications. By default, it collects user access data in full volume. You can configure sampling to collect user access data, thereby reducing data storage and lowering costs.

Below, *we will use a Web application as an example to introduce how to collect 90% of the user access data for a Web application.*

## Sampling Configuration

Taking **synchronous loading** as an example, add `sessionSampleRate: 90` in your code, then copy and paste it into the first line of the HTML page you want to integrate, which will collect user access data for the Web application at a rate of 90%.

```javascript
import { datafluxRum } from '@cloudcare/browser-rum';
datafluxRum.init({
    applicationId: '<Application ID>',
    datakitOrigin: '<DATAKIT ORIGIN>', // Protocol (including: //), domain name (or IP address) [and port number]
    env: 'production',
    version: '1.0.0',
    service: 'browser',
    sessionSampleRate: 100,
    sessionReplaySampleRate: 70,
    trackInteractions: true,
    traceType: 'ddtrace', // Optional, defaults to ddtrace. Currently supports 6 types: ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent
    allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, list of origins or regex patterns that allow injecting trace headers
})
```
**Note**: After setting the sampling rate, initialization will generate a random number between 0-100. If this number is less than the set sampling rate, the relevant user access data will be reported; otherwise, it will not be reported.

> **NPM integration** and **asynchronous loading** can also be configured similarly. Please refer to the documentation [Web Application Integration](../web/app-access.md#access).

## Sampling for Other Applications

- For iOS sampling configuration, refer to [iOS Application Integration](../ios/app-access.md).
- For Android sampling configuration, refer to [Android Application Integration](../android/app-access.md).
- For mini-program sampling configuration, refer to [Mini-program Application Integration](../miniapp/app-access.md).