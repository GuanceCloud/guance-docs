# <<< custom_key.brand_name >>> RUM SDK Quick Start Guide

## Overview

<<< custom_key.brand_name >>> RUM SDK (Real User Monitoring) provides a powerful set of tools for monitoring and analyzing real user behaviors and performance of Web applications. This quick start guide will help you quickly integrate the RUM SDK into your Web application, distinguishing between DK method integration and public network DataWay integration, while detailing how to customize and add data TAGs.

## Prerequisites

- **Install DataKit**: Ensure that DataKit is installed and configured as publicly accessible (for DK method integration). [How to install DataKit](../../datakit/datakit-install.md);
- **Configure RUM Collector**: Configure the RUM collector according to the <<< custom_key.brand_name >>> documentation [How to configure RUM collector](../../integrations/rum.md);

## Integration Methods

### 1. DK Method Integration

- Ensure DataKit is installed and configured as publicly accessible. [Publicly accessible and IP geographic information database installation](../../datakit/datakit-tools-how-to.md#install-ipdb)
- In the <<< custom_key.brand_name >>> console, obtain parameters such as `applicationId`, `env`, `version` [Create Application](../index.md#create).
- When integrating the SDK, configure `datakitOrigin` as the domain name or IP of DataKit.

### 2. Public Network OpenWay Integration

- Log in to the <<< custom_key.brand_name >>> console, go to the **Synthetic Tests** page, click on the top-left **Create Application**, and obtain the `applicationId`, `clientToken`, and `site` parameters. [Create Application](../index.md#create)
- Configure the `site` and `clientToken` parameters, which support uploading SourceMap in the console.
- When integrating the SDK, no configuration of `datakitOrigin` is required; the SDK will default to sending data to the public network DataWay.

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
  datakitOrigin: '<DataKit domain name or IP>', // Needs to be configured for DK method integration
  clientToken: 'clientToken', // Needs to be filled out for public network OpenWay integration
  site: 'Public OpenWay address', // Needs to be filled out for public network OpenWay integration
  env: 'production',
  version: '1.0.0',
  sessionSampleRate: 100,
  sessionReplaySampleRate: 70,
  trackUserInteractions: true,
  // Other optional configurations...
})

// Enable SESSION REPLAY recording
datafluxRum.startSessionReplayRecording()
```

### Asynchronous Loading via CDN

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
      datakitOrigin: '<DataKit domain name or IP>', // Needs to be configured for DK method integration
      clientToken: 'clientToken', // Needs to be filled out for public network OpenWay integration
      site: 'Public OpenWay address', // Needs to be filled out for public network OpenWay integration
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackUserInteractions: true,
      // Other configurations...
    })
    // Enable SESSION REPLAY recording
    window.DATAFLUX_RUM.startSessionReplayRecording()
  })
</script>
```

### Synchronous Loading via CDN

Add the script in your HTML file:

```html
<script
  src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js"
  type="text/javascript"
></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'Your Application ID',
      datakitOrigin: '<DataKit domain name or IP>', // Needs to be configured for DK method integration
      clientToken: 'clientToken', // Needs to be filled out for public network OpenWay integration
      site: 'Public OpenWay address', // Needs to be filled out for public network OpenWay integration
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackUserInteractions: true,
      // Other configurations...
    })
  // Enable SESSION REPLAY recording
  window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording()
</script>
```

## How to Collect Only Error Session Events (SDK Version Requirement `≥3.2.19`)

#### Feature Characteristics

When an error occurs on the page, the SDK will automatically perform:

1. **Continuous Recording**: From the moment the error is triggered, fully retain all lifecycle data of the session
2. **Precise Compensation**: Through independent sampling channels, ensure 100% capture of error scenarios

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
   sessionSampleRate: 0,             // Disable regular session collection
   sessionOnErrorSampleRate: 100, // Fully collect error sessions

});

</script>
```

## Custom Adding of Data TAGs

Use the `setGlobalContextProperty` or `setGlobalContext` API to add extra TAGs to all RUM events [Add custom tag](./custom-sdk/add-additional-tag.md).

### Example

```javascript
// Add a single TAG using setGlobalContextProperty
window.DATAFLUX_RUM && window.DATAFLUX_RUM.setGlobalContextProperty('userName', 'Zhang San')

// Add multiple TAGs using setGlobalContext
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.setGlobalContext({
    userAge: 28,
    userGender: 'Male',
  })
```

Through the above code, you can add `userName`, `userAge`, and `userGender` TAGs to all RUM events.

## Tracking User Actions

### Control Whether to Enable Action Collection

Control whether to collect user click actions through the `trackUserInteractions` initialization parameter.

### Customize Action Names

- Customize the Action name by adding the `data-guance-action-name` attribute or `data-custom-name` (depending on the `actionNameAttribute` configuration) to clickable elements.

### Use the `addAction` API to Customize Actions

```javascript
// Synchronous loading via CDN
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.addAction('cart', {
    amount: 42,
    nb_items: 2,
    items: ['socks', 't-shirt'],
  })

// Asynchronous loading via CDN
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

## Custom Adding Errors

Use the `addError` API to customize and add Error Metrics data [Add custom Error](./custom-sdk/add-error.md).

```javascript
// Synchronous loading via CDN
const error = new Error('Something wrong occurred.')
window.DATAFLUX_RUM && DATAFLUX_RUM.addError(error, { pageStatus: 'beta' })

// Asynchronous loading via CDN
window.DATAFLUX_RUM.onReady(function () {
  const error = new Error('Something wrong occurred.')
  window.DATAFLUX_RUM.addError(error, { pageStatus: 'beta' })
})

// NPM
import { datafluxRum } from '@cloudcare/browser-rum'
const error = new Error('Something wrong occurred.')
datafluxRum.addError(error, { pageStatus: 'beta' })
```

## Custom User Identification

Use the `setUser` API to add identification attributes for the current user (such as ID, name, email) [Add custom User Information](./custom-sdk/user-id.md).

```javascript
// Synchronous loading via CDN
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.setUser({
    id: '1234',
    name: 'John Doe',
    email: 'john@doe.com',
  })

// Asynchronous loading via CDN
window.DATAFLUX_RUM.onReady(function () {
  window.DATAFLUX_RUM.setUser({ id: '1234', name: 'John Doe', email: 'john@doe.com' })
})

// NPM
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum.setUser({ id: '1234', name: 'John Doe', email: 'john@doe.com' })
```

## SESSION REPLAY Configuration

### Ensure SDK Version Support

Ensure the SDK version you are using supports SESSION REPLAY functionality (usually versions `> 3.0.0`).

### Enable SESSION REPLAY Recording

After initializing the SDK, call the `startSessionReplayRecording()` method to enable SESSION REPLAY recording. You can choose to enable it under specific conditions, such as after user login [Enable Session Recording](../session-replay/index.md).

#### How to Collect Only SESSION REPLAY Data Related to Errors (SDK Version Requirement `≥3.2.19`)

##### Function Description

When an error occurs on the page, the SDK will automatically perform the following operations:

1. **Retrospective Collection**: Record a complete page snapshot for **1 minute** before the error occurred
2. **Continuous Recording**: Continuously record until the session ends from the moment the error occurred
3. **Smart Compensation**: Through independent sampling channels, ensure full coverage of error scenarios

##### Configuration Example

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

// Force-enable screen recording engine (must be called)
window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording();
</script>
```

## Notes

- SESSION REPLAY does not support playback of iframe, video, audio, canvas, and other elements.
- Ensure static resources (such as fonts, images) remain accessible during replay, possibly requiring CORS policy settings.
- For CSS styles and mouse hover events, ensure access to CSS rules via the CSSStyleSheet interface.

## Debugging and Optimization

- Use the logs and monitoring tools provided by the SDK to debug and optimize your application's performance.
- Adjust parameters such as `sessionSampleRate` and `sessionReplaySampleRate` based on business needs to optimize data collection.

By following the steps above, you can successfully integrate the <<< custom_key.brand_name >>> RUM SDK into your Web application and begin collecting data and using SESSION REPLAY functionality to optimize user experience and performance.