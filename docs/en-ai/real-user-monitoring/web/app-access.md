# Web Application Integration

---

Guance can collect metrics data from various web applications and analyze the performance of each web application end in a visualized manner.

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites are automatically configured for you, allowing you to integrate your application directly.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Ensure that DataKit is [publicly accessible and has the IP geolocation database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#access}

Log in to the Guance console, go to the **User Access Monitoring** page, and click the **[Create New Application](../index.md#create)** in the top-left corner to start creating a new application.

- Guance provides **Public DataWay** to receive RUM data directly without installing the DataKit collector. Configuring the `site` and `clientToken` parameters is sufficient. You can upload SourceMaps directly from the console, supporting multiple files based on different versions and environments.

![](../img/web_01.png)

- Guance also supports receiving RUM data via **local environment deployment**, which requires meeting the prerequisites.

![](../img/6.rum_web.png)

There are three ways to integrate web applications: NPM integration, synchronous loading, and asynchronous loading.

| Integration Method | Description                                                                                                                                                             |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM                | By bundling the SDK code into the frontend project, this method ensures no impact on frontend page performance but may miss requests and errors before SDK initialization. |
| CDN Asynchronous   | Using a CDN to cache and asynchronously load the SDK script ensures that the SDK script download does not affect page load performance but may miss requests and errors before SDK initialization. |
| CDN Synchronous    | Using a CDN to cache and synchronously load the SDK script ensures capturing all errors, resources, requests, and performance metrics but may impact page load performance. |

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'

    datafluxRum.init({
      applicationId: 'guance',
      datakitOrigin: '<DataKit domain or IP>', // Required for DK integration
      clientToken: 'clientToken', // Required for Public OpenWay integration
      site: 'Public OpenWay URL', // Required for Public OpenWay integration
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackInteractions: true,
      traceType: 'ddtrace', // Optional, default is ddtrace. Currently supports ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent.
      allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, list of origins or regex patterns for allowed tracing headers
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
          datakitOrigin: '<DataKit domain or IP>', // Required for DK integration
          clientToken: 'clientToken', // Required for Public OpenWay integration
          site: 'Public OpenWay URL', // Required for Public OpenWay integration
          env: 'production',
          version: '1.0.0',
          sessionSampleRate: 100,
          sessionReplaySampleRate: 70,
          trackInteractions: true,
          traceType: 'ddtrace', // Optional, default is ddtrace. Currently supports ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent.
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, list of origins or regex patterns for allowed tracing headers
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
          datakitOrigin: '<DataKit domain or IP>', // Required for DK integration
          clientToken: 'clientToken', // Required for Public OpenWay integration
          site: 'Public OpenWay URL', // Required for Public OpenWay integration
          env: 'production',
          version: '1.0.0',
          sessionSampleRate: 100,
          sessionReplaySampleRate: 70,
          trackInteractions: true,
          traceType: 'ddtrace', // Optional, default is ddtrace. Currently supports ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent.
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, list of origins or regex patterns for allowed tracing headers
        })
    </script>
    ```

## Configuration {#config}

### Initialization Parameters

| Parameter                                   | Type       | Required | Default Value | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ------------------------------------------- | ---------- | -------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                             | String     | Yes      |               | The application ID created in Guance.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `datakitOrigin`                             | String     | Yes      |               | DataKit data reporting Origin. Format: `protocol://domain(or IP address)[:port]`. Example: [https://www.datakit.com](https://www.datakit.com); [http://100.20.34.3:8088](http://100.20.34.3:8088).                                                                                                                                                                                                                                                                                                                                                   |
| `clientToken`                               | String     | Yes      |               | Data reporting token for public OpenWay, obtained from the Guance console (required for public OpenWay integration).                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `site`                                      | String     | Yes      |               | Public OpenWay data reporting URL, obtained from the Guance console (required for public OpenWay integration).                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `env`                                       | String     | No       |               | Current environment of the web application, such as prod: production; gray: canary; pre: pre-release; common: daily; local: local.                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `version`                                   | String     | No       |               | Version number of the web application.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `service`                                   | String     | No       | `browser`     | Name of the current application's service, default is `browser`, supports custom configuration.                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `sessionSampleRate`                         | Number     | No       | `100`         | Percentage of metrics data collected: `100` means full collection; `0` means no collection.                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `sessionReplaySampleRate`                   | Number     | No       | `100`         | Percentage of [Session Replay](../session-replay/replay.md) data collected: `100` means full collection; `0` means no collection.                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `trackSessionAcrossSubdomains`              | Boolean    | No       | `false`       | Share cache across subdomains under the same domain.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `usePartitionedCrossSiteSessionCookie`      | Boolean    | No       | `false`       | Enable partitioned secure cross-site session cookies [details](https://developers.google.com/privacy-sandbox/3pcd/chips?hl=en)                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `useSecureSessionCookie`                    | Boolean    | No       | `false`       | Use secure session cookies. This disables sending RUM events over insecure (non-HTTPS) connections.                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `traceType`                                 | Enum       | No       | `ddtrace`     | Configure the tracing tool type, defaults to `ddtrace` if not specified. Currently supports `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent`.<br><br>:warning:<br>1. `opentelemetry` supports `zipkin_single_header`, `w3c_traceparent`, `zipkin`, `jaeger`.<br>2. This setting depends on the `allowedTracingOrigins` configuration.<br>3. For configuring specific `Access-Control-Allow-Headers`, refer to [How APM Connects with RUM](../../application-performance-monitoring/collection/connect-web-app.md). |
| `traceId128Bit`                             | Boolean    | No       | `false`       | Generate `traceID` using 128 bits, corresponding to `traceType`, currently supports types `zipkin`, `jaeger`.                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `allowedTracingOrigins`                     | Array      | No       | `[]`          | List of origins or regex patterns for injecting tracing headers. Can be an origin or regex pattern, format: `protocol://domain(or IP address)[:port]`. Example: `["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]`.                                                                                                                                                                                                                                                                                                                        |
| `allowedTracingUrls`                        | Array      | No       | `[]`          | URL matching list for associating with APM requests. Can be URLs, regex patterns, or match functions, example: `["https://api.example.com/xxx", /https:\/\/.*\.my-api-domain\.com\/xxx/, function(url) {if (url === 'xxx') { return false} else { return true }}]`. This parameter extends the `allowedTracingOrigins` configuration, configure either one.                                                                                                                                                                                                                                               |
| `trackUserInteractions`                     | Boolean    | No       | `false`       | Enable user interaction tracking.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `actionNameAttribute`                       | String     | No       |               | Version requirement: `>3.1.2`. Add a custom attribute to elements to specify action names. For usage details, [refer here](./tracking-user-actions.md).                                                                                                                                                                                                                                                                                                                                                                                                             |
| `beforeSend`                                | Function   | No       |               | Version requirement: `>3.1.2`. Intercept and modify data. For more details, [refer here](../../security/before-send.md).                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `storeContextsToLocal`                      | Boolean    | No       |               | Version requirement: `>3.1.2`. Cache custom user data locally in localStorage, e.g., data added via `setUser`, `addGlobalContext` APIs.                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `storeContextsKey`                          | String     | No       |               | Version requirement: `>3.1.18`. Define the key stored in localStorage, defaults to auto-generated if not specified. This parameter mainly addresses shared store issues among different sub-paths under the same domain.                                                                                                                                                                                                                                                                                                                                                     |
| `compressIntakeRequests`                    | Boolean    | No       |               | Compress RUM data request content to reduce bandwidth usage when sending large amounts of data, and reduce the number of data requests. Compression occurs in the WebWorker thread. For CSP security policy, [refer here](../../security/content-security-policy.md#webwork). SDK version requirement `>= 3.2.0`. DataKit version requirement `>=1.60`. Deployment Plan requirement `>= 1.96.178`.                                                                                                                                                                                                                     |
| `workerUrl`                                 | String     | No       |               | Session replay and compressIntakeRequests data compression occur in the WebWorker thread, so by default, in CSP secure access scenarios, you need to allow worker-src blob:. This configuration allows adding self-hosted worker URLs. For CSP security policy, [refer here](../../security/content-security-policy.md#webwork). SDK version requirement `>= 3.2.0`.                                                                                                                                                                                                                                                        |