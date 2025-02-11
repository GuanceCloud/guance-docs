# How to Configure User Access Monitoring Sampling
---

## Introduction

Guance supports collecting data from Web, Android, iOS, and Mini Program applications. By default, it collects user access data in full volume. You can reduce data storage and lower costs by configuring sampling to collect user access data.

Below is an example of how to collect 90% of the user access data for a Web application.

## Sampling Configuration

Using **synchronous loading** as an example, add `sessionSampleRate: 90` in the code and paste it into the first line of the HTML page you want to integrate. This will sample 90% of the Web application's user access data.

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
    allowedTracingOrigins: ['https://api.example.com',/https:\/\/.*\.my-api-domain\.com/],  // Optional, list of origins or regex patterns that allow injecting trace headers
})
```
**Note**: After setting the sampling rate, the initialization process will generate a random number between 0-100. If this number is less than the configured sampling rate, the relevant user access data will be reported; otherwise, it will not be reported.

> **NPM Integration** and **asynchronous loading** can be configured similarly. Refer to the documentation [Web Application Integration](../web/app-access.md#access).

## Sampling for Other Applications

- For iOS, refer to [iOS Application Integration](../ios/app-access.md).
- For Android, refer to [Android Application Integration](../android/app-access.md).
- For Mini Programs, refer to [Mini Program Application Integration](../miniapp/app-access.md).