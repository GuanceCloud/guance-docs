# Web Application Integration

---

By collecting metrics data from web applications, analyze the application performance in a visualized way.

## Prerequisites

???+ warning "Note"

    If the [RUM Headless](../../dataflux-func/headless.md) service has been enabled, the prerequisites are automatically configured, and you can directly integrate the application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure [RUM Collector](../../integrations/rum.md);
- DataKit should be configured as [publicly accessible and install IP geolocation database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Start Integration {#access}

1. Enter **Synthetic Tests > Create > Web**;
2. Input the application name;
3. Input the application ID;
4. Select the integration method:

   - Public DataWay: Directly receive RUM data without installing DataKit collector.
   - Local Environment Deployment: After meeting the prerequisites, receive RUM data.

### Integration Methods

<div class="grid" markdown>

=== "DK Integration"

    1. Ensure that DataKit is installed and configured as [publicly accessible and with IP geolocation database installed](../../datakit/datakit-tools-how-to.md#install-ipdb);    
    2. Obtain `applicationId`, `env`, `version` and other parameters from the console to start [integrating the application](#access);   
    3. When integrating the SDK, set `datakitOrigin` to the domain name or IP of DataKit.

    ---

=== "Public OpenWay" 

    1. Obtain `applicationId`, `clientToken` and `site` and other parameters from the console to start [integrating the application](#access);  
    2. When integrating the SDK, there's no need to configure `datakitOrigin`. The data will be sent by default to the public DataWay.

    ---

</div>


### SDK Configuration

| <div style="width: 130px">Integration Method</div>     | Description      |
| ------------ | ------------------------- |
| [NPM](#npm)          | Package the SDK code into the frontend project to ensure that the frontend performance is not affected. Some requests and error collections before the SDK initialization may be missed. |
| [CDN Asynchronous Loading](#cdn-asynchronous) | Introduce the SDK script asynchronously via CDN, which does not affect the page loading performance. Some requests and error collections before the initialization may be missed.        |
| [CDN Synchronous Loading](#cdn-synchronous) | Introduce the SDK script synchronously via CDN, which can collect all errors and performance metrics completely. But it might affect the page loading performance.          |

#### NPM Integration {#npm}

Install and import the SDK in your frontend project:

```bash
npm install @cloudcare/browser-rum
```

Initialize the SDK in the project:

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'

datafluxRum.init({
  applicationId: 'Your Application ID',
  datakitOrigin: '<DataKit Domain Name or IP>', // Needs configuration when using DK method
  clientToken: 'clientToken', // Required for public OpenWay access
  site: 'Public OpenWay Address', // Required for public OpenWay access
  env: 'production',
  version: '1.0.0',
  sessionSampleRate: 100,
  sessionReplaySampleRate: 70,
  trackUserInteractions: true,
  // Other optional configurations...
})

// Start SESSION REPLAY recording
datafluxRum.startSessionReplayRecording()
```


#### CDN Asynchronous Loading {#cdn-asynchronous}

Add the script in the HTML file:

```html
<script>
  ;(function (h, o, u, n, d) {
    h = h[d] = h[d] || {
      q: [],
      onReady: function (c) {
        h.q.push(c)
      },
    }
    ;(d = o.createElement(u)), (d.async = 1), (d.src = n)
    n = o.getElementsByTagName(u)[0]
    n.parentNode.insertBefore(d, n)
  })(
    window,
    document,
    'script',
    'https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js',
    'DATAFLUX_RUM'
  )

  window.DATAFLUX_RUM.onReady(function () {
    window.DATAFLUX_RUM.init({
      applicationId: 'Your Application ID',
      datakitOrigin: '<DataKit Domain Name or IP>', // Needs configuration when using DK method
      clientToken: 'clientToken', // Required for public OpenWay access
      site: 'Public OpenWay Address', // Required for public OpenWay access
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackUserInteractions: true,
      // Other configurations...
    })
    // Start SESSION REPLAY recording
    window.DATAFLUX_RUM.startSessionReplayRecording()
  })
</script>
```

#### CDN Synchronous Loading {#cdn-synchronous}

Add the script in the HTML file:

```html
<script
  src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js"
  type="text/javascript"
></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'Your Application ID',
      datakitOrigin: '<DataKit Domain Name or IP>', // Needs configuration when using DK method
      clientToken: 'clientToken', // Required for public OpenWay access
      site: 'Public OpenWay Address', // Required for public OpenWay access
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackUserInteractions: true,
      // Other configurations...
    })
  // Start SESSION REPLAY recording
  window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording()
</script>
```


## Parameter Configuration {#config}

### Initialization Parameters

| Parameter                                   | <div style="width: 60px">Type</div> | <div style="width: 60px">Required?</div> | <div style="width: 60px">Default Value</div> | Description      |
| -------------------------------------- | ----------------------------------- | --------------------------------------- | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                        | String                              | Yes                                     |                                       | Application ID created from <<< custom_key.brand_name >>>.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `datakitOrigin`                        | String                              | Yes                                     |                                       | DataKit data reporting Origin. Annotation: <br>`Protocol (including: //), domain name (or IP address) [and port number]`<br> For example:<br>[https://www.datakit.com](https://www.datakit.com);<br>[http://100.20.34.3:8088](http://100.20.34.3:8088).                                                                                                                                                                                                                                                                                                                                                   |
| `clientToken`                          | String                              | Yes                                     |                                       | Data token reported via openway obtained from the <<< custom_key.brand_name >>> console (required for public openway access).                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| `site`                                 | String                              | Yes                                     |                                       | Data reporting address via public openway obtained from the <<< custom_key.brand_name >>> console (required for public openway access).                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `env`                                  | String                              | No                                      |                                       | Current environment of the web application, such as prod: production environment; gray: gray release environment; pre: pre-release environment; common: daily environment; local: local environment.                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `version`                              | String                              | No                                      |                                       | Version number of the web application.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `service`                              | String                              | No                                      |                                       | Service name of the current application, default is `browser`, supports custom configuration.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `sessionSampleRate`                    | Number                              | No                                      | `100`                                 | Percentage of metric data collection:<br>`100` means full collection; `0` means no collection.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `sessionOnErrorSampleRate`             | Number                              | No                                      | `0`                                   | Error session compensation sampling rate: If the session is not sampled by `sessionSampleRate`, but an error occurs during the session, it will be collected according to this ratio. Such sessions will start recording events when the error occurs and continue recording until the session ends. Requires SDK version `>= 3.2.19`                                                                                                                                                                                                                                                                                                                                                                            |
| `sessionReplaySampleRate`              | Number                              | No                                      | `100`                                 | [Session Replay](../session-replay/web/replay.md#config) data collection percentage: <br>`100` means full collection; `0` means no collection.                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `sessionReplayOnErrorSampleRate`       | Number                              | No                                      | `0`                                   | [Session Replay](../session-replay/web/replay.md#config) error session replay compensation sampling rate: If the session is not sampled by `sessionReplaySampleRate`, but an error occurs during the session, it will be collected according to this ratio. Such replays will record up to one minute of events before the error occurs and continue recording until the session ends. Requires SDK version `>= 3.2.19`                                                                                                                                                                                                                                                                                                   |
| `trackSessionAcrossSubdomains`         | Boolean                             | No                                      | `false`                               | Subdomains under the same domain share cache.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `usePartitionedCrossSiteSessionCookie` | Boolean                             | No                                      | `false`                               | Whether to enable partitioned secure cross-site session cookie [Details](https://developers.google.com/privacy-sandbox/3pcd/chips?hl=zh-cn)                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `useSecureSessionCookie`               | Boolean                             | No                                      | `false`                               | Use secure session cookies. This will disable sending RUM events over insecure (non-HTTPS) connections.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `traceType`                            | Enum                                | No                                      | `ddtrace`                             | Configure the tracing tool type, default is `ddtrace` if not configured. Currently supports `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent` six data types.<br><br>:warning: <br>1. `opentelemetry` supports `zipkin_single_header`, `w3c_traceparent`, `zipkin`, `jaeger` four types.<br>2. The effectiveness of this configuration depends on the `allowedTracingOrigins` configuration item.<br>3. Configuring corresponding traceType requires corresponding API services. Refer to [How APM Connects to RUM ](../../application-performance-monitoring/collection/connect-web-app.md) for setting different `Access-Control-Allow-Headers`. |
| `traceId128Bit`                        | Boolean                             | No                                      | `false`                               | Whether to generate `traceID` in 128-byte format, corresponding to `traceType`, currently supports types `zipkin`, `jaeger`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `allowedTracingOrigins`                | Array                               | No                                      | `[]`                                  | List of all requests allowed to inject `trace` collector required headers. Can be request origin, or regular expression, origin: `protocol (including: //), domain name (or IP address) [and port number]`._For example:<br>`["https://api.example.com", /https:\\/\\/._\\.my-api-domain\\.com/]`.\*                                                                                                                                                                                                                                                                                                                        |
| `allowedTracingUrls`                   | Array                               | No                                      | `[]`                                  | URL matching list associated with Apm requests. Can be request url, or regular expression, or match function for example: `["https://api.example.com/xxx", /https:\/\/.*\.my-api-domain\.com\/xxx/, function(url) {if (url === 'xxx') { return false} else { return true }}]` This parameter is an extension of the `allowedTracingOrigins` configuration, either one of them needs to be configured.                                                                                                                                                                                                                                               |
| `trackUserInteractions`                | Boolean                             | No                                      | `false`                               | Whether to enable user behavior collection.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `actionNameAttribute`                  | String                              | No                                      |                                       | Version requirement:`>3.1.2`. Add custom attributes to elements to specify the operation name. Refer to [details](./tracking-user-actions.md) for specific usage.                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `beforeSend`                           | Function(event, context):Boolean    | No                                      |                                       | Version requirement:`>3.1.2`. Intercept and modify data, refer to [details](../../security/before-send.md) for more information.                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `storeContextsToLocal`                 | Boolean                             | No                                      |                                       | Version requirement:`>3.1.2`. Whether to cache custom user data locally in localstorage, such as: `setUser`, `addGlobalContext` api added custom data.                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `storeContextsKey`                     | String                              | No                                      |                                       | Version requirement:`>3.1.18`. Define the key stored in localstorage, default is not filled, auto-generated. This parameter mainly distinguishes between different subpaths sharing store under the same domain.                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `compressIntakeRequests`               | Boolean                             | No                                      |                                       | Compress RUM data request content to reduce bandwidth usage when sending large amounts of data, while reducing the number of data requests sent. Compression is completed in the WebWorker thread. Refer to csp security policy[refer to csp security](../../security/content-security-policy.md#webwork). SDK version requirement`>= 3.2.0`. Datakit version requirement `>=1.60 `. Deployment Plan requirement `>= 1.96.178`                                                                                                                                                                                                                                                                    |
| `workerUrl`                            | Sring                               | No                                      |                                       | Both sessionReplay and compressIntakeRequests data compression are completed in the webwork thread, so by default, in the case of enabling csp secure access, worker-src blob: needs to be allowed; This configuration allows adding self-hosted worker addresses. Refer to csp security policy[refer to csp security](../../security/content-security-policy.md#webwork). SDK version requirement`>= 3.2.0`.                                                                                                                                                                                                                                                        |

#### `site` Parameter Handling {#site}

<<<% if custom_key.brand_key == 'truewatch' %>>>

| Node Name       | Address                       |
|-----------|--------------------------------|
| Overseas Zone 1 (Oregon) | https://us1-openway.<<< custom_key.brand_main_domain >>> |
| Europe Zone 1 (Frankfurt) | https://eu1-openway.<<< custom_key.brand_main_domain >>> |
| Asia-Pacific Zone 1 (Singapore) | https://ap1-openway.<<< custom_key.brand_main_domain >>> |
| Africa Zone 1 (South Africa) | https://za1-openway.<<< custom_key.brand_main_domain >>> |
| Indonesia Zone 1 (Jakarta) | https://id1-openway.<<< custom_key.brand_main_domain >>> |

<<<% else %>>>

| Node Name       | Address                       |
|-----------|--------------------------------|
| China Zone 1 (Hangzhou)  | https://rum-openway.<<< custom_key.brand_main_domain >>>     |
| China Zone 2 (Ningxia)  | https://aws-openway.<<< custom_key.brand_main_domain >>> |
| China Zone 4 (Guangzhou)  | https://cn4-openway.<<< custom_key.brand_main_domain >>> |
| China Zone 6 (Hong Kong)  | https://cn6-openway.guance.one |
| Overseas Zone 1 (Oregon) | https://us1-openway.<<< custom_key.brand_main_domain >>> |
| Europe Zone 1 (Frankfurt) | https://eu1-openway.guance.one |
| Asia-Pacific Zone 1 (Singapore) | https://ap1-openway.guance.one |
| Africa Zone 1 (South Africa) | https://za1-openway.<<< custom_key.brand_main_domain >>> |
| Indonesia Zone 1 (Jakarta) | https://id1-openway.<<< custom_key.brand_main_domain >>> |

<<<% endif %>>>

## Use Cases

### Collect Only Error Session Events

???+ warning "Prerequisite"

    SDK version requirement: 3.2.19 or higher.

When an error occurs on the page, the SDK will automatically perform:

- Continuous Recording: From the time the error occurs, fully record the entire lifecycle data of the session.
- Precise Compensation: Through an independent sampling channel, ensuring no omission of error scenarios.

#### Configuration Scheme

```javascript
<script
  src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js"
  type="text/javascript"
></script>
<script>
// Core configuration initialization
window.DATAFLUX_RUM && window.DATAFLUX_RUM.init({

   ...
   // Precise collection strategy
   sessionSampleRate: 0,             // Disable normal session collection
   sessionOnErrorSampleRate: 100, // Fully collect error sessions

});

</script>
```

### Custom Adding Data TAGS

Use the `setGlobalContextProperty` or `setGlobalContext` API to add custom tags to all RUM events [Add custom tags](./custom-sdk/add-additional-tag.md).


```javascript
// Use setGlobalContextProperty to add a single TAG
window.DATAFLUX_RUM && window.DATAFLUX_RUM.setGlobalContextProperty('userName', 'Zhang San')

// Use setGlobalContext to add multiple TAGS
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.setGlobalContext({
    userAge: 28,
    userGender: 'Male',
  })
```

### Track User Actions

#### Control Whether to Enable Action Collection

Control whether to collect user click behaviors through the `trackUserInteractions` initialization parameter.

#### Customize Action Names

- Customize the Action name by adding the `data-guance-action-name` attribute or `data-custom-name` (depending on the `actionNameAttribute` configuration) to clickable elements.

#### Use `addAction` API to Customize Actions

```javascript
// CDN Synchronous Loading
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.addAction('cart', {
    amount: 42,
    nb_items: 2,
    items: ['socks', 't-shirt'],
  })

// CDN Asynchronous Loading
window.DATAFLUX_RUM.onReady(function () {
  window.DATAFLUX_RUM.addAction('cart', {
    amount: 42,
    nb_items: 2,
    items: ['socks', 't-shirt'],
  })
})

// NPM
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum &&
  datafluxRum.addAction('cart', {
    amount: 42,
    nb_items: 2,
    items: ['socks', 't-shirt'],
  })
```

### Custom Adding Errors

Use the `addError` API to customize adding Error metrics data [Add custom Errors](./custom-sdk/add-error.md).

```javascript
// CDN Synchronous Loading
const error = new Error('Something wrong occurred.')
window.DATAFLUX_RUM && DATAFLUX_RUM.addError(error, { pageStatus: 'beta' })

// CDN Asynchronous Loading
window.DATAFLUX_RUM.onReady(function () {
  const error = new Error('Something wrong occurred.')
  window.DATAFLUX_RUM.addError(error, { pageStatus: 'beta' })
})

// NPM
import { datafluxRum } from '@cloudcare/browser-rum'
const error = new Error('Something wrong occurred.')
datafluxRum.addError(error, { pageStatus: 'beta' })
```

### Custom User Identification

Use the `setUser` API to add identification attributes (such as ID, name, email) for the current user [Add custom user information](./custom-sdk/user-id.md).

```javascript
// CDN Synchronous Loading
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.setUser({
    id: '1234',
    name: 'John Doe',
    email: 'john@doe.com',
  })

// CDN Asynchronous Loading
window.DATAFLUX_RUM.onReady(function () {
  window.DATAFLUX_RUM.setUser({ id: '1234', name: 'John Doe', email: 'john@doe.com' })
})

// NPM
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum.setUser({ id: '1234', name: 'John Doe', email: 'john@doe.com' })
```


## Web Session Replay

???+ warning "Prerequisite"

    Ensure that the SDK version supports the session replay feature (usually `> 3.0.0` version).

### Start Recording

After initializing the SDK, call the `startSessionReplayRecording()` method to start recording the session replay. You can choose to start under specific conditions, such as after user login [Start session recording](../session-replay/index.md).

### Collect Only Error-Related Session Replay Data

???+ warning "Prerequisite"

    SDK version requirement is 3.2.19 or higher.

When an error occurs on the page, the SDK will automatically perform the following actions:

- Retroactive Collection: Record a complete snapshot of the page one minute before the error;
- Continuous Recording: Continue recording from the time the error occurs until the session ends;
- Intelligent Compensation: Through an independent sampling channel, ensuring no omission of error scenarios.

#### Configuration Example

```javascript
<script
  src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js"
  type="text/javascript"
></script>
<script>
// Initialize core SDK configuration
window.DATAFLUX_RUM && window.DATAFLUX_RUM.init({
   ....

   // Sampling strategy configuration
   sessionSampleRate: 100,          // Full basic session collection (100%)
   sessionReplaySampleRate: 0,       // Disable regular screen recording sampling
   sessionReplayOnErrorSampleRate: 100, // 100% sampling for error scenarios

});

// Forcefully enable screen recording engine (must be called)
window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording();
</script>
```

#### Notes

- The session replay feature does not cover iframe, video, audio, and canvas element playback;   
- To ensure that static resources (such as fonts, images) can be accessed normally during replay, CORS policies may need to be configured;   
- Ensure that CSS rules can be accessed via the CSSStyleSheet interface to support CSS styles and mouse hover events.

#### Debugging Optimization

- Use the logging and monitoring tools provided by the SDK for debugging to improve application performance;   
- Adjust the `sessionSampleRate` and `sessionReplaySampleRate` parameters based on business needs.