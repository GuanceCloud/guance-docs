# <<< custom_key.brand_name >>> RUM SDK Quick Start Guide

## Overview

<<< custom_key.brand_name >>> RUM SDK (Real User Monitoring) provides a powerful set of tools for monitoring and analyzing the behavior and performance of Web applications from real users. This quick start guide will help you integrate the RUM SDK into your Web application quickly, distinguishing between DK integration and public DataWay integration, while detailing how to customize and add data TAGs.

## Prerequisites

- **Install DataKit**: Ensure that DataKit is installed and configured to be publicly accessible (for DK integration). [How to install DataKit](../../datakit/datakit-install.md).
- **Configure RUM Collector**: Configure the RUM collector according to <<< custom_key.brand_name >>> documentation [How to configure RUM collector](../../integrations/rum.md).

## Integration Methods

### 1. DK Integration

- Ensure DataKit is installed and configured to be publicly accessible. [Publicly accessible and IP geolocation database installed](../../datakit/datakit-tools-how-to.md#install-ipdb)
- Obtain parameters such as `applicationId`, `env`, `version` in the <<< custom_key.brand_name >>> console [Create Application](../index.md#create).
- When integrating the SDK, configure `datakitOrigin` to the domain name or IP of DataKit.

### 2. Public OpenWay Integration

- Log in to the <<< custom_key.brand_name >>> console, go to the **Synthetic Tests** page, click on **Create Application** in the top-left corner to obtain `applicationId`, `clientToken`, and `site` parameters. [Create Application](../index.md#create)
- Configure `site` and `clientToken` parameters; SourceMap uploads are supported in the console.
- When integrating the SDK, there's no need to configure `datakitOrigin`; the SDK will default to sending data to the public DataWay.

## SDK Integration

### NPM Integration

Install and import the SDK in your frontend project:

```bash
npm install @cloudcare/browser-rum
```

Initialize the SDK in your project:

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'

datafluxRum.init({
  applicationId: 'Your Application ID',
  datakitOrigin: '<DataKit Domain or IP>', // Required for DK integration
  clientToken: 'clientToken', // Required for public OpenWay integration
  site: 'Public OpenWay Address', // Required for public OpenWay integration
  env: 'production',
  version: '1.0.0',
  sessionSampleRate: 100,
  sessionReplaySampleRate: 70,
  trackUserInteractions: true,
  // Other optional configurations...
})

// Start session replay recording
datafluxRum.startSessionReplayRecording()
```

### Asynchronous CDN Loading

Add the script in your HTML file:

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
  })(window, document, 'script', 'https://<<< custom_key.static_domain >>>/browser-sdk/v3/dataflux-rum.js', 'DATAFLUX_RUM')

  window.DATAFLUX_RUM.onReady(function () {
    window.DATAFLUX_RUM.init({
      applicationId: 'Your Application ID',
      datakitOrigin: '<DataKit Domain or IP>', // Required for DK integration
      clientToken: 'clientToken', // Required for public OpenWay integration
      site: 'Public OpenWay Address', // Required for public OpenWay integration
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackUserInteractions: true,
      // Other configurations...
    })
    // Start session replay recording
    window.DATAFLUX_RUM.startSessionReplayRecording()
  })
</script>
```

### Synchronous CDN Loading

Add the script in your HTML file:

```html
<script src="https://<<< custom_key.static_domain >>>/browser-sdk/v3/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'Your Application ID',
      datakitOrigin: '<DataKit Domain or IP>', // Required for DK integration
      clientToken: 'clientToken', // Required for public OpenWay integration
      site: 'Public OpenWay Address', // Required for public OpenWay integration
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackUserInteractions: true,
      // Other configurations...
    })
  // Start session replay recording
  window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording()
</script>
```

## Customizing Data TAGs

Use the `setGlobalContextProperty` or `setGlobalContext` API to add additional TAGs to all RUM events [Add custom tags](./custom-sdk/add-additional-tag.md).

### Example

```javascript
// Add a single TAG using setGlobalContextProperty
window.DATAFLUX_RUM && window.DATAFLUX_RUM.setGlobalContextProperty('userName', 'John Doe')

// Add multiple TAGs using setGlobalContext
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.setGlobalContext({
    userAge: 28,
    userGender: 'Male',
  })
```

With the above code, you can add `userName`, `userAge`, and `userGender` TAGs to all RUM events.

## Tracking User Actions

### Control Action Collection

Control whether to collect user click actions via the `trackUserInteractions` initialization parameter.

### Customize Action Names

- Customize Action names by adding the `data-guance-action-name` attribute or `data-custom-name` (depending on the `actionNameAttribute` configuration) to clickable elements.

### Use `addAction` API to Customize Actions

```javascript
// Synchronous CDN loading
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.addAction('cart', {
    amount: 42,
    nb_items: 2,
    items: ['socks', 't-shirt'],
  })

// Asynchronous CDN loading
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

## Customizing Errors

Use the `addError` API to add custom Error Metrics data [Add custom errors](./custom-sdk/add-error.md).

```javascript
// Synchronous CDN loading
const error = new Error('Something wrong occurred.')
window.DATAFLUX_RUM && DATAFLUX_RUM.addError(error, { pageStatus: 'beta' })

// Asynchronous CDN loading
window.DATAFLUX_RUM.onReady(function () {
  const error = new Error('Something wrong occurred.')
  window.DATAFLUX_RUM.addError(error, { pageStatus: 'beta' })
})

// NPM
import { datafluxRum } from '@cloudcare/browser-rum'
const error = new Error('Something wrong occurred.')
datafluxRum.addError(error, { pageStatus: 'beta' })
```

## Customizing User Identifiers

Use the `setUser` API to add identifier properties (such as ID, name, email) for the current user [Add custom user information](./custom-sdk/user-id.md).

```javascript
// Synchronous CDN loading
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.setUser({
    id: '1234',
    name: 'John Doe',
    email: 'john@doe.com',
  })

// Asynchronous CDN loading
window.DATAFLUX_RUM.onReady(function () {
  window.DATAFLUX_RUM.setUser({ id: '1234', name: 'John Doe', email: 'john@doe.com' })
})

// NPM
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum.setUser({ id: '1234', name: 'John Doe', email: 'john@doe.com' })
```

## Session Replay Configuration

### Ensure SDK Version Support

Ensure the SDK version you are using supports session replay functionality (usually versions `> 3.0.0`).

### Start Session Replay Recording

After initializing the SDK, call the `startSessionReplayRecording()` method to start session replay recording. You can choose to enable it under specific conditions, such as after user login [Start session recording](../session-replay/index.md).

## Important Notes

- Session replay does not support playing iframes, videos, audio, canvases, etc.
- Ensure static resources (like fonts, images) remain accessible during replay, which may require setting up CORS policies.
- For CSS styles and mouse hover events, ensure CSS rules can be accessed via the CSSStyleSheet interface.

## Debugging and Optimization

- Use the logging and monitoring tools provided by the SDK to debug and optimize your application performance.
- Adjust parameters like `sessionSampleRate` and `sessionReplaySampleRate` based on business needs to optimize data collection.

By following these steps, you can successfully integrate the <<< custom_key.brand_name >>> RUM SDK into your Web application and start collecting data and using session replay features to optimize user experience and performance.