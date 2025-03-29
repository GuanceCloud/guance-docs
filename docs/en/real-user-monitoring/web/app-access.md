# Web Application Integration

---

By collecting metrics data from web applications, analyze application performance in a visualized manner.

## Prerequisites

???+ warning "Note"

    If the [RUM Headless](../../dataflux-func/headless.md) service has already been enabled, the prerequisites are automatically configured, and you can directly integrate the application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure [RUM Collector](../../integrations/rum.md);
- Configure DataKit as [accessible via the public network and install IP geolocation database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Start Integration {#access}

1. Navigate to **Synthetic Tests > Create > Web**;
2. Enter the application name;
3. Input the application ID;
4. Select the application integration method:

   - Public DataWay: Directly receives RUM data without requiring the installation of the DataKit collector.
   - Local Environment Deployment: Receives RUM data after meeting the prerequisites.

### SDK Configuration

| Integration Method | Description                                                                                         |
| ------------------ | --------------------------------------------------------------------------------------------------- |
| NPM               | Package the SDK code into the frontend project to ensure that frontend performance is not affected, but may miss requests and error collections before the SDK initialization. |
| CDN Asynchronous Loading | Introduce the SDK script asynchronously via CDN, which does not affect page loading performance but may miss request and error collection before initialization.         |
| CDN Synchronous Loading | Introduce the SDK script synchronously via CDN, which collects all errors and performance metrics but may impact page loading performance. |

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'

    datafluxRum.init({
      applicationId: 'guance',
      datakitOrigin: '<DataKit domain or IP>', // Needs configuration when integrating through DK
      clientToken: 'clientToken', // Fill in when accessing publicly via OpenWay
      site: 'Public OpenWay address', // Fill in when accessing publicly via OpenWay
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackInteractions: true,
      traceType: 'ddtrace', // Optional, default is ddtrace, currently supports 6 types: ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent
      allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, allows all requests to inject trace collector headers. Can be request origin or regex
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
          datakitOrigin: '<DataKit domain or IP>', // Needs configuration when integrating through DK
          clientToken: 'clientToken', // Fill in when accessing publicly via OpenWay
          site: 'Public OpenWay address', // Fill in when accessing publicly via OpenWay
          env: 'production',
          version: '1.0.0',
          sessionSampleRate: 100,
          sessionReplaySampleRate: 70,
          trackInteractions: true,
          traceType: 'ddtrace', // Optional, default is ddtrace, currently supports 6 types: ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, allows all requests to inject trace collector headers. Can be request origin or regex
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
          datakitOrigin: '<DataKit domain or IP>', // Needs configuration when integrating through DK
          clientToken: 'clientToken', // Fill in when accessing publicly via OpenWay
          site: 'Public OpenWay address', // Fill in when accessing publicly via OpenWay
          env: 'production',
          version: '1.0.0',
          sessionSampleRate: 100,
          sessionReplaySampleRate: 70,
          trackInteractions: true,
          traceType: 'ddtrace', // Optional, default is ddtrace, currently supports 6 types: ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, allows all requests to inject trace collector headers. Can be request origin or regex
        })
    </script>
    ```

## Start Configuration {#config}

### Initialization Parameters

| Parameter                                   | <div style="width: 60px">Type</div> | <div style="width: 60px">Required</div> | <div style="width: 60px">Default Value</div> | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ------------------------------------------ | ------------------------------------ | ---------------------------------------- | -------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                             | String                               | Yes                                      |                                              | The application ID created from <<< custom_key.brand_name >>>.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `datakitOrigin`                            | String                               | Yes                                      |                                              | DataKit data reporting Origin Note: <br>`protocol (including: //), domain name (or IP address)[and port number]`<br> For example:<br>[https://www.datakit.com](https://www.datakit.com);<br>[http://100.20.34.3:8088](http://100.20.34.3:8088).                                                                                                                                                                                                                                                                                                                                                   |
| `clientToken`                              | String                               | Yes                                      |                                              | Data reporting token for openway submission, obtained from the <<< custom_key.brand_name >>> console (required for public openway integration).                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `site`                                     | String                               | Yes                                      |                                              | Public openway data reporting address, obtained from the <<< custom_key.brand_name >>> console (required for public openway integration).                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `env`                                      | String                               | No                                       |                                              | Current environment of the web application, such as prod: production environment; gray: gray-scale environment; pre: pre-release environment; common: daily environment; local: local environment.                                                                                                                                                                                                                                                                                                                                                                             |
| `version`                                  | String                               | No                                       |                                              | Version number of the web application.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `service`                                  | String                               | No                                       | `browser`                                    | Name of the current application's service, default is `browser`, supports custom configuration.                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `sessionSampleRate`                        | Number                               | No                                       | `100`                                       | Percentage of metric data collection: <br>`100` means full collection; `0` means no collection.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `sessionOnErrorSampleRate`                 | Number                               | No                                       | `0`                                         | Error session compensation sampling rate: When the session is not sampled by `sessionSampleRate`, if an error occurs during the session, it will be collected according to this ratio. Such sessions start recording events when an error occurs and continue recording until the session ends. SDK version requirement `>= 3.2.19`.                                                                                                                                                                                                                                 |
| `sessionReplaySampleRate`                  | Number                               | No                                       | `100`                                       | [Session Replay](../session-replay/web/replay.md#config) data collection percentage: <br>`100` means full collection; `0` means no collection.                                                                                                                                                                                                                                                                                                                                                                                                                       |
| `sessionReplayOnErrorSampleRate`           | Number                               | No                                       | `0`                                         | [Session Replay](../session-replay/web/replay.md#config) error session replay compensation sampling rate: When the session is not sampled by `sessionReplaySampleRate`, if an error occurs during the session, it will be collected according to this ratio. Such replays record events up to one minute before the error occurs and continue recording until the session ends. SDK version requirement `>= 3.2.19`.                                                                                                                                                               |
| `trackSessionAcrossSubdomains`             | Boolean                              | No                                       | `false`                                     | Subdomains under the same domain share cache.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `usePartitionedCrossSiteSessionCookie`     | Boolean                              | No                                       | `false`                                     | Whether to enable partitioned secure cross-site session cookies [Details](https://developers.google.com/privacy-sandbox/3pcd/chips?hl=en-us)                                                                                                                                                                                                                                                                                                                                                                                                                       |
| `useSecureSessionCookie`                   | Boolean                              | No                                       | `false`                                     | Use secure session cookies. This will disable sending RUM events over insecure (non-HTTPS) connections.                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| `traceType`                                | Enum                                 | No                                       | `ddtrace`                                   | Configure the type of tracing tool, defaults to `ddtrace` if not specified. Currently supports 6 data types: `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent`.<br><br>:warning: <br>1. `opentelemetry` supports `zipkin_single_header`, `w3c_traceparent`, `zipkin`, `jaeger` 4 types.<br>2. The effectiveness of this configuration depends on the `allowedTracingOrigins` configuration item.<br>3. Configuring the corresponding traceType requires appropriate API services. For setting different `Access-Control-Allow-Headers`, refer to [How APM Connects with RUM](../../application-performance-monitoring/collection/connect-web-app.md). |
| `traceId128Bit`                            | Boolean                              | No                                       | `false`                                     | Whether to generate `traceID` in 128 bytes, corresponding to `traceType`, currently supports types `zipkin`, `jaeger`.                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `allowedTracingOrigins`                    | Array                                | No                                       | `[]`                                        | List of all requests where `trace` collector headers are injected. Can be the request origin or regex, origin: `protocol (including: //), domain name (or IP address)[and port number]`. _For example:<br>`["https://api.example.com", /https:\\/\\/._\\.my-api-domain\\.com/]`.\*                                                                                                                                                                                                                                                                                               |
| `allowedTracingUrls`                       | Array                                | No                                       | `[]`                                        | URL match list associated with APM requests. Can be request URL, regex, or match function, for example: `["https://api.example.com/xxx", /https:\/\/.*\.my-api-domain\.com\/xxx/, function(url) {if (url === 'xxx') { return false} else { return true }}]`. This parameter is an extension of the `allowedTracingOrigins` configuration, configuring either one is sufficient.                                                                                                                                                                                                 |
| `trackUserInteractions`                    | Boolean                              | No                                       | `false`                                     | Whether to enable user behavior collection.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `actionNameAttribute`                      | String                               | No                                       |                                              | Version requirement: `>3.1.2`. Add custom attributes to elements to specify the operation name. Specific usage, [details reference](./tracking-user-actions.md)                                                                                                                                                                                                                                                                                                                                                                                                              |
| `beforeSend`                               | Function(event, context):Boolean      | No                                       |                                              | Version requirement: `>3.1.2`. Data interception and modification, [details reference](../../security/before-send.md)                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `storeContextsToLocal`                     | Boolean                              | No                                       |                                              | Version requirement: `>3.1.2`. Whether to cache user-defined data locally in localstorage, such as: `setUser`, `addGlobalContext` api added custom data.                                                                                                                                                                                                                                                                                                                                                                                                               |
| `storeContextsKey`                         | String                               | No                                       |                                              | Version requirement: `>3.1.18`. Define the key stored in localstorage, default is empty, auto-generated, this parameter mainly solves the problem of shared store across different sub-paths under the same domain.                                                                                                                                                                                                                                                                                                                                                      |
| `compressIntakeRequests`                   | Boolean                              | No                                       |                                              | Compress RUM data request content to reduce bandwidth usage when sending large amounts of data, while reducing the number of data sending requests. Compression is completed in the WebWorker thread. For CSP security policies [refer to CSP security](../../security/content-security-policy.md#webwork). SDK version requirement `>= 3.2.0`. DataKit version requirement `>=1.60`. Deployment version requirement `>= 1.96.178`.                                                                                                                                                |
| `workerUrl`                                | String                               | No                                       |                                              | Both sessionReplay and compressIntakeRequests data compression are completed in the webwork thread, so by default, in case of enabling CSP secure access, `worker-src blob:` needs to be allowed; this configuration allows adding self-hosted worker addresses. For CSP security policies [refer to CSP security](../../security/content-security-policy.md#webwork). SDK version requirement `>= 3.2.0`.                                                                                                                                                                                                 |