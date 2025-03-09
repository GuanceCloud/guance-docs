# Web Application Integration

---

<<< custom_key.brand_name >>> application monitoring can collect metrics data from various web applications and analyze the performance of each web application endpoint in a visual manner.

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites have been automatically configured for you, allowing you to directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Ensure DataKit is [publicly accessible and has the IP geolocation database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#access}

Log in to the <<< custom_key.brand_name >>> console, navigate to the **Synthetic Tests** page, click on the top-left **[Create Application](../index.md#create)** to start creating a new application.

- <<< custom_key.brand_name >>> provides **Public DataWay** for direct reception of RUM data without installing the DataKit collector. Configuring `site` and `clientToken` parameters is sufficient. It supports direct SourceMap uploads via the console, enabling multiple files based on different versions and environments.

![](../img/web_01.png)

- <<< custom_key.brand_name >>> also supports receiving RUM data through **local environment deployment**, which requires meeting the prerequisites.

![](../img/6.rum_web.png)

Web application integration offers three methods: NPM integration, asynchronous loading, and synchronous loading.

| Integration Method | Description                                                                                                                                                             |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM                | By bundling the SDK code into the frontend project, this method ensures no impact on the frontend page performance but may miss requests and errors before SDK initialization. |
| CDN Asynchronous   | Through CDN caching, the SDK script is introduced asynchronously, ensuring it does not affect page load performance but may miss requests and errors before SDK initialization. |
| CDN Synchronous    | Through CDN caching, the SDK script is introduced synchronously, ensuring all errors, resources, requests, and performance metrics are collected but may affect page load performance. |

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'

    datafluxRum.init({
      applicationId: 'guance',
      datakitOrigin: '<DataKit domain or IP>', // Required for DK integration
      clientToken: 'clientToken', // Required for public OpenWay integration
      site: 'public OpenWay address', // Required for public OpenWay integration
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackInteractions: true,
      traceType: 'ddtrace', // Optional, defaults to ddtrace, currently supports ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent
      allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, list of origins or regex patterns for requests where tracing headers should be injected
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
        'https://<<< custom_key.static_domain >>>/browser-sdk/v3/dataflux-rum.js',
        'DATAFLUX_RUM'
      )
      DATAFLUX_RUM.onReady(function () {
        DATAFLUX_RUM.init({
          applicationId: 'guance',
          datakitOrigin: '<DataKit domain or IP>', // Required for DK integration
          clientToken: 'clientToken', // Required for public OpenWay integration
          site: 'public OpenWay address', // Required for public OpenWay integration
          env: 'production',
          version: '1.0.0',
          sessionSampleRate: 100,
          sessionReplaySampleRate: 70,
          trackInteractions: true,
          traceType: 'ddtrace', // Optional, defaults to ddtrace, currently supports ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, list of origins or regex patterns for requests where tracing headers should be injected
        })
      })
    </script>
    ```

=== "CDN Synchronous Loading"

    ```javascript
    <script src="https://<<< custom_key.static_domain >>>/browser-sdk/v3/dataflux-rum.js" type="text/javascript"></script>
    <script>
      window.DATAFLUX_RUM &&
        window.DATAFLUX_RUM.init({
          applicationId: 'guance',
          datakitOrigin: '<DataKit domain or IP>', // Required for DK integration
          clientToken: 'clientToken', // Required for public OpenWay integration
          site: 'public OpenWay address', // Required for public OpenWay integration
          env: 'production',
          version: '1.0.0',
          sessionSampleRate: 100,
          sessionReplaySampleRate: 70,
          trackInteractions: true,
          traceType: 'ddtrace', // Optional, defaults to ddtrace, currently supports ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // Optional, list of origins or regex patterns for requests where tracing headers should be injected
        })
    </script>
    ```

## Configuration {#config}

### Initialization Parameters

| Parameter                                   | Type         | Required | Default | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| ------------------------------------------- | ------------ | -------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                             | String       | Yes      |         | The application ID created in <<< custom_key.brand_name >>>.                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `datakitOrigin`                             | String       | Yes      |         | DataKit data reporting Origin. Format: `protocol (including ://), domain name (or IP address) [and port number]`. Example: [https://www.datakit.com](https://www.datakit.com); [http://100.20.34.3:8088](http://100.20.34.3:8088).                                                                                                                                                                                                                                                                             |
| `clientToken`                               | String       | Yes      |         | Token for data reporting via openway, obtained from the <<< custom_key.brand_name >>> console (required for public openway integration).                                                                                                                                                                                                                                                                                                                                                                  |
| `site`                                      | String       | Yes      |         | Public openway data reporting URL, obtained from the <<< custom_key.brand_name >>> console (required for public openway integration).                                                                                                                                                                                                                                                                                                                                                                     |
| `env`                                       | String       | No       |         | Current environment of the web application, e.g., prod: production; gray: gray release; pre: pre-release; common: daily; local: local.                                                                                                                                                                                                                                                                                                                                                                    |
| `version`                                   | String       | No       |         | Version number of the web application.                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `service`                                   | String       | No       | `browser` | Name of the current service, default is `browser`, supports custom configuration.                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `sessionSampleRate`                         | Number       | No       | `100`   | Percentage of metrics data collection: `100` means full collection; `0` means no collection.                                                                                                                                                                                                                                                                                                                                                                                                                |
| `sessionReplaySampleRate`                   | Number       | No       | `100`   | [Session Replay](../session-replay/replay.md) data collection percentage: `100` means full collection; `0` means no collection.                                                                                                                                                                                                                                                                                                                                                                            |
| `trackSessionAcrossSubdomains`              | Boolean      | No       | `false` | Share cache across subdomains under the same domain.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| `usePartitionedCrossSiteSessionCookie`     | Boolean      | No       | `false` | Enable partitioned secure cross-site session cookie [more details](https://developers.google.com/privacy-sandbox/3pcd/chips?hl=en)                                                                                                                                                                                                                                                                                                                                                                         |
| `useSecureSessionCookie`                    | Boolean      | No       | `false` | Use secure session cookies. This will disable sending RUM events over insecure (non-HTTPS) connections.                                                                                                                                                                                                                                                                                                                                                                                                  |
| `traceType`                                 | Enum         | No       | `ddtrace` | Configure the tracing tool type. If not specified, defaults to `ddtrace`. Currently supports `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent`.<br><br>:warning:<br>1. `opentelemetry` supports `zipkin_single_header`, `w3c_traceparent`, `zipkin`, `jaeger`.<br>2. This configuration depends on `allowedTracingOrigins`.<br>3. For setting different `Access-Control-Allow-Headers`, refer to [How APM Connects with RUM](../../application-performance-monitoring/collection/connect-web-app.md). |
| `traceId128Bit`                             | Boolean      | No       | `false` | Generate `traceID` as 128-bit, corresponding to `traceType`, currently supports types `zipkin`, `jaeger`.                                                                                                                                                                                                                                                                                                                                                                                                   |
| `allowedTracingOrigins`                     | Array        | No       | `[]`    | List of origins or regex patterns for requests where tracing headers should be injected. Can be request origin or regex pattern, origin: `protocol (including ://), domain name (or IP address) [and port number]`. Example: `["https://api.example.com", /https:\\/\\/._\\.my-api-domain\\.com/]`.                                                                                                                                                                                                                       |
| `allowedTracingUrls`                        | Array        | No       | `[]`    | List of URLs matching APM associated requests. Can be request URL, regex pattern, or match function, e.g., `["https://api.example.com/xxx", /https:\/\/.*\.my-api-domain\.com\/xxx/, function(url) {if (url === 'xxx') { return false} else { return true }}]`. This parameter extends `allowedTracingOrigins`; configuring either one is sufficient.                                                                                                                                                                                    |
| `trackUserInteractions`                     | Boolean      | No       | `false` | Whether to enable user interaction tracking.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `actionNameAttribute`                       | String       | No       |         | Version requirement: `>3.1.2`. Add custom attributes to elements to specify action names. For detailed usage, [refer here](./tracking-user-actions.md)                                                                                                                                                                                                                                                                                                                                                          |
| `beforeSend`                                | Function(event, context):Boolean | No |        | Version requirement: `>3.1.2`. Intercepts and modifies data. [Refer here](../../security/before-send.md) for more details.                                                                                                                                                                                                                                                                                                                                                                                 |
| `storeContextsToLocal`                      | Boolean      | No       |         | Version requirement: `>3.1.2`. Whether to cache user-defined data locally in localstorage, such as data added via `setUser`, `addGlobalContext` APIs.                                                                                                                                                                                                                                                                                                                                                           |
| `storeContextsKey`                          | String       | No       |         | Version requirement: `>3.1.18`. Define the key for storing data in localstorage, default is auto-generated if not specified. This parameter helps differentiate store usage among different sub-paths under the same domain.                                                                                                                                                                                                                                                                                              |
| `compressIntakeRequests`                    | Boolean      | No       |         | Compress RUM data request content to reduce bandwidth usage when sending large amounts of data and decrease the number of data requests. Compression occurs in the WebWorker thread. For CSP security policy [refer here](../../security/content-security-policy.md#webwork). SDK version requirement `>= 3.2.0`. DataKit version requirement `>=1.60`. Deployment Plan requirement `>= 1.96.178`.                                                                                                                     |
| `workerUrl`                                 | String       | No       |         | Session replay and compressIntakeRequests data compression occur in the webwork thread, so by default, in CSP secure access scenarios, `worker-src blob:` needs to be allowed. This configuration allows specifying a self-hosted worker URL. For CSP security policy [refer here](../../security/content-security-policy.md#webwork). SDK version requirement `>= 3.2.0`.                                                                                                             |