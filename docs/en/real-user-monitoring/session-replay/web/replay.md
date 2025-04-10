# How to Connect SESSION REPLAY

---

## Configuration {#config}

| Configuration Item                           | Type     | Default Value    | Description                                                                                                                                                                                  |
| ------------------------------------------- | -------- | ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `sessionReplaySampleRate`                   | Number   | `100`           | Replay data collection percentage: <br>`100` means full collection; `0` means no collection                                                                                                      |
| `sessionReplayOnErrorSampleRate`            | Number   | `0`             | Sampling rate for recording replays when an error occurs. Such replays will record events up to one minute before the error occurred and continue until the session ends. `100` means capture all sessions with errors, `0` means do not capture any session replays. SDK version requirement `>= 3.2.19` |
| `shouldMaskNode`                            | Function | undefined       | Session replay masking of data recording for a specific node, can be used to implement masking effects for certain custom nodes. SDK version requirement `>= 3.2.19`                                                                                       |

## Enable SESSION REPLAY

Through your previous SDK introduction method, replace the NPM package with version `> 3.0.0`, or replace the original CDN link with `https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js`. After SDK initialization with `init()`, it will not automatically collect SESSION REPLAY RECORD data. You need to execute `startSessionReplayRecording` to start data collection. This is useful for collecting SESSION REPLAY RECORD data under specific conditions, such as:

```js
// Collect only user operations after login
if (user.isLogin()) {
  DATAFLUX_RUM.startSessionReplayRecording()
}
```

If you need to stop SESSION REPLAY data collection, you can call `stopSessionReplayRecording()` to close.

### NPM {#npm}

Introduce the @cloudcare/browser-rum package and ensure that [@cloudcare/browser-rum](https://www.npmjs.com/package/@cloudcare/browser-rum) version is `> 3.0.0`. If you want to start recording, please execute `datafluxRum.startSessionReplayRecording()` after initialization.

```js
import { datafluxRum } from '@cloudcare/browser-rum'

datafluxRum.init({
  applicationId: '<DATAFLUX_APPLICATION_ID>',
  datakitOrigin: '<DATAKIT ORIGIN>',
  service: 'browser',
  env: 'production',
  version: '1.0.0',
  sessionSampleRate: 100,
  sessionReplaySampleRate: 70,
  trackInteractions: true,
})

datafluxRum.startSessionReplayRecording()
```

### CDN {#cdn}

Replace the original CDN address `https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v2/dataflux-rum.js` with `https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js`, and after executing `DATAFLUX_RUM.init()`, execute `DATAFLUX_RUM.startSessionReplayRecording()`.

```js
<script
src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js"
type="text/javascript"
></script>
<script>
window.DATAFLUX_RUM &&
window.DATAFLUX_RUM.init({
    applicationId: '<DATAFLUX_APPLICATION_ID>',
    datakitOrigin: '<DATAKIT ORIGIN>',
    service: 'browser',
    env: 'production',
    version: '1.0.0',
    sessionSampleRate: 100,
    sessionReplaySampleRate: 100,
    trackInteractions: true,
})

window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording()
</script>
```

### How to Collect Only Error-Related SESSION REPLAY Data (SDK Version Requirement `≥3.2.19`)

#### Feature Description

When an error occurs on the page, the SDK will automatically perform the following actions:

1. **Traceback Collection**: Record a complete page snapshot for the **1 minute** before the error occurred
2. **Continuous Recording**: Continuously record from the moment the error occurred until the session ends
3. **Smart Compensation**: Ensure full coverage of error scenarios through an independent sampling channel

#### Configuration Example

```javascript
<script
  src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js"
  type="text/javascript"
></script>
<script>
// Initialize core SDK configuration
window.DATAFLUX_RUM && window.DATAFLUX_RUM.init({
   // Required parameters
   applicationId: '<DATAFLUX_APPLICATION_ID>',
   datakitOrigin: '<DATAKIT_ORIGIN>',

   // Environment identifier
   service: 'browser',
   env: 'production',
   version: '1.0.0',

   // Sampling strategy configuration
   sessionSampleRate: 100,          // Full basic session collection (100%)
   sessionReplaySampleRate: 0,      // Disable regular screen recording sampling
   sessionReplayOnErrorSampleRate: 100, // 100% sampling for error scenarios

   // Auxiliary features
   trackInteractions: true         // Enable user behavior tracking
});

// Force enable screen recording engine (must call)
window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording();
</script>
```

## Precautions

### Some HTML Elements Are Invisible During Playback

SESSION REPLAY does not support the following HTML elements: iframe, video, audio, or canvas. SESSION REPLAY does not support Web Components and Shadow DOM.

### FONT or IMG Cannot Be Correctly Rendered

SESSION REPLAY is not a video but rather a reconstruction based on DOM snapshots of iframes. Therefore, playback depends on various static resources of the page: fonts and images.

For the following reasons, static resources may not be available during playback:

- The static resource no longer exists. For example, it was part of a previous deployment.
- The static resource is inaccessible. For example, authentication may be required, or the resource may only be accessible from an internal network.
- Static resources are blocked by the browser due to CORS (usually web fonts).

  - Since playback is based on the `<<< custom_key.brand_main_domain >>>` sandbox environment corresponding to the iframe, if certain static resources have not been authorized for a specific domain, your browser will block the request;
  - Allow access to any font or image static resources your site depends on via the Access-Control-Allow-Origin Header to ensure these resources can be accessed for playback.

  > For more details, refer to [Cross-Origin Resource Sharing](https://developer.mozilla.org/en-US/docs/Web).

### CSS Style Not Applied Correctly or Mouse Hover Events Not Replayed

Unlike fonts and images, SESSION REPLAY RECORD attempts to use the [CSSStyleSheet](https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleSheet) interface to bundle various CSS rules applied as part of the recorded data. If it cannot be executed, it will fallback to recording the link to the CSS file.

To obtain correct mouse hover support, CSS rules must be accessible via the CSSStyleSheet interface.

If style files are hosted on a different domain than the webpage, access to CSS rules will be subject to cross-origin security checks by the browser, and the browser must be instructed to load style files using CORS by specifying the [crossorigin](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/crossorigin) attribute.

For example, if your application is located on the example.com domain and relies on CSS files on assets.example.com via a link element, the `crossorigin` attribute should be set to `anonymous`.

```js
<link rel="stylesheet" crossorigin="anonymous"
      href="https://assets.example.com/style.css”>
```

Additionally, authorize the example.com domain in assets.example.com. This allows resource files to correctly load resources by setting the [Access-Control-Allow-Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin) Header.

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; How Does SESSION REPLAY Ensure Your Data Security?</font>](../../../security/index.md#session-replay)

</div>