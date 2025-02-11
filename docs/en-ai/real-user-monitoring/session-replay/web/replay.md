# How to Integrate Session Replay

---

## Enabling Session Replay

Using your previous SDK integration method, replace the NPM package with version `> 3.0.0` or update the original CDN link to `https://static.guance.com/browser-sdk/v3/dataflux-rum.js`. After initializing the SDK with `init()`, it will not automatically collect Session Replay Record data. You need to call `startSessionReplayRecording` to start collecting this data. This is useful for scenarios where you only want to collect Session Replay Record data under specific conditions, such as:

```js
// Collect user interaction data only after login
if (user.isLogin()) {
  DATAFLUX_RUM.startSessionReplayRecording()
}
```

To stop collecting Session Replay data, you can call `stopSessionReplayRecording()`.

### NPM {#npm}

Introduce the `@cloudcare/browser-rum` package and ensure that the version of [@cloudcare/browser-rum](https://www.npmjs.com/package/@cloudcare/browser-rum) is `> 3.0.0`. To start recording, execute `datafluxRum.startSessionReplayRecording()` after initialization.

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

Replace the original CDN URL `https://static.guance.com/browser-sdk/v2/dataflux-rum.js` with `https://static.guance.com/browser-sdk/v3/dataflux-rum.js`, and after executing `DATAFLUX_RUM.init()`, run `DATAFLUX_RUM.startSessionReplayRecording()`.

```js
<script
src="https://static.guance.com/browser-sdk/v3/dataflux-rum.js"
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

## Precautions

### Some HTML Elements Are Invisible During Playback

Session Replay does not support the following HTML elements: iframe, video, audio, or canvas. Session Replay also does not support Web Components and Shadow DOM.

### Fonts or Images Do Not Display Correctly

Session Replay is not a video but a reconstruction based on DOM snapshots within an iframe. Therefore, playback depends on various static resources on the page, such as fonts and images.

Static resources may be unavailable during playback for the following reasons:

- The static resource no longer exists. For example, it was part of a previous deployment.
- The static resource is inaccessible. For example, authentication may be required, or the resource may only be accessible from an internal network.
- Static resources are blocked by the browser due to CORS (commonly for web fonts).

  - Since playback occurs in the `guance.com` sandbox environment corresponding to the iframe, if certain static resources do not have authorization for a specific domain, your browser will block the request.
  - Allow `guance.com` to access any font or image static resources your site depends on by setting the `Access-Control-Allow-Origin` header, ensuring these resources can be accessed for playback.

  > For more details, refer to [Cross-Origin Resource Sharing](https://developer.mozilla.org/en-US/docs/Web).

### CSS Styles Are Not Applied Correctly or Mouse Hover Events Are Not Replayed

Unlike fonts and images, Session Replay Record attempts to use the [CSSStyleSheet](https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleSheet) interface to bundle the various CSS rules applied to the page as part of the recorded data. If this fails, it falls back to recording links to CSS files.

To ensure correct mouse hover support, CSS rules must be accessible via the CSSStyleSheet interface.

If style files are hosted on a different domain than the webpage, access to CSS rules will be subject to browser cross-origin security checks, and the browser must be instructed to load style files using the [crossorigin](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/crossorigin) attribute to utilize CORS.

For example, if your application is on the example.com domain and relies on CSS files on assets.example.com via a link element, the `crossorigin` attribute should be set to `anonymous`.

```html
<link rel="stylesheet" crossorigin="anonymous"
      href="https://assets.example.com/style.css">
```

Additionally, authorize the example.com domain on assets.example.com. This allows resource files to be loaded correctly by setting the [Access-Control-Allow-Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin) header.

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; How Does Session Replay Ensure Your Data Security?</font>](../../../security/index.md#session-replay)

</div>