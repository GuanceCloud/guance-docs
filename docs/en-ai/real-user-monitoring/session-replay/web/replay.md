# How to Integrate Session Replay

---

## Enable Session Replay

Using your previous SDK integration method, replace the NPM package with version `> 3.0.0` or replace the original CDN link with `https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js`. After initializing the SDK with `init()`, it will not automatically collect Session Replay Record data. You need to execute `startSessionReplayRecording` to start collecting data. This is useful for scenarios where you only want to collect Session Replay Record data under specific conditions, such as:

```js
// Collect user operation data only after login
if (user.isLogin()) {
  DATAFLUX_RUM.startSessionReplayRecording()
}
```

To stop collecting Session Replay data, you can call `stopSessionReplayRecording()`.

### NPM {#npm}

Integrate the `@cloudcare/browser-rum` package and ensure that the version of [@cloudcare/browser-rum](https://www.npmjs.com/package/@cloudcare/browser-rum) is `> 3.0.0`. If you want to start recording, execute `datafluxRum.startSessionReplayRecording()` after initialization.

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

Replace the original CDN URL `https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v2/dataflux-rum.js` with `https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js`, and after executing `DATAFLUX_RUM.init()`, run `DATAFLUX_RUM.startSessionReplayRecording()`.

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

## Precautions

### Certain HTML Elements Are Invisible During Playback

Session Replay does not support the following HTML elements: iframe, video, audio, or canvas. Session Replay also does not support Web Components and Shadow DOM.

### Fonts or Images Do Not Display Correctly

Session Replay is not a video but a reconstruction based on DOM snapshots. Therefore, playback depends on various static resources on the page: fonts and images.

Static resources may be unavailable during playback for the following reasons:

- The static resource no longer exists. For example, it was part of a previous deployment.
- The static resource is inaccessible. For example, authentication may be required, or the resource may only be accessible from an internal network.
- Static resources are blocked by the browser due to CORS (usually web fonts).

  - Since playback occurs in a sandbox environment corresponding to `guance.com`, if certain static resources do not have permission for a specific domain, your browser will block the request;
  - Allow `guance.com` access to any font or image static resources your site depends on by setting the Access-Control-Allow-Origin header, ensuring these resources can be accessed during playback.

  > For more details, refer to [Cross-Origin Resource Sharing](https://developer.mozilla.org/en-US/docs/Web).

### CSS Styles Not Applied Correctly or Mouse Hover Events Not Reproduced

Unlike fonts and images, Session Replay Record attempts to use the [CSSStyleSheet](https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleSheet) interface to bundle various CSS rules as part of the recorded data. If this fails, it falls back to recording the links to CSS files.

To ensure correct mouse hover support, CSS rules must be accessible via the CSSStyleSheet interface.

If the style file is hosted on a different domain than the webpage, access to CSS rules will be subject to the browser's cross-origin security checks, and the browser must load the style file using the [crossorigin](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/crossorigin) attribute to utilize CORS.

For example, if your application is on the example.com domain and depends on a CSS file on assets.example.com via a link element, the `crossorigin` attribute should be set to `anonymous`.

```js
<link rel="stylesheet" crossorigin="anonymous"
      href="https://assets.example.com/style.css”>
```

Additionally, authorize the example.com domain on assets.example.com. This allows the resource file to be loaded correctly by setting the [Access-Control-Allow-Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin) header.

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; How Does Session Replay Ensure Your Data Security?</font>](../../../security/index.md#session-replay)

</div>