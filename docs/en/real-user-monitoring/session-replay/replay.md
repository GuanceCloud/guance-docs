# Access to Session Replay
---

## Open Session Replay

Replace the NPM package with `> 3.0.0` version, or replace the original CDN link with `https://static.guance.com/browser-sdk/v3/dataflux-rum.js.` by using your previous SDK introduction. Session Replay Record data is not automatically collected after the SDK initializes `init()`, and you need to execute `startSessionReplayRecording` to start data collection, which is useful for collecting Session Replay Record data only for specific situations, such as:

```js
 // Collect only the operation data after the user logs in
 if (user.isLogin()) {
    DATAFLUX_RUM.startSessionReplayRecording();
 }
```

### NPM {#npm}

Introduce the @cloudcare/browser-rum package, and guarantee the version of [@cloudcare/browser-rum](https://www.npmjs.com/package/@cloudcare/browser-rum) is `over 3.0.0`, and if you want to start recording, after initialization, execute `datafluxRum.startSessionReplayRecording()`.

```js
import { datafluxRum } from '@cloudcare/browser-rum';

datafluxRum.init({
    applicationId: '<DATAFLUX_APPLICATION_ID>',
    datakitOrigin: '<DATAKIT ORIGIN>',
    service: 'browser',
    env: 'production',
    version: '1.0.0',
    sessionSampleRate: 100,
    sessionReplaySampleRate: 100,
    trackInteractions: true,
});

datafluxRum.startSessionReplayRecording();
```

### CDN {#cdn}

Replace the original CDN address `https://static.guance.com/browser-sdk/v2/dataflux-rum.js` with `https://static.guance.com/browser-sdk/v3/dataflux-rum.js`, and execute `DATAFLUX_RUM.startSessionReplayRecording()` after executing `DATAFLUX_RUM.init()`.

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

## Notes

:material-numeric-1-circle: **Some HTML elements are not visible during replay**

Session Replay does not support the following HTML elements during replay: iframes, videos, audios, or canvases. Session Replay also does not support Web Components and Shadow DOM.

:material-numeric-2-circle: **FONT 或 IMG 无法正确呈现**

Session Replay is not a video, but it reconstructs iframes based on DOM snapshots. Therefore, replay relies on various static resources of the page, such as fonts and images.

There are several reasons why static resources may not be available during replay:

- The static resource no longer exists, for example, it was part of a previous deployment.
- The static resource is not accessible, for example, it requires authentication, or the resource can only be accessed from an internal network.
- The static resource is blocked by the browser due to CORS (typically for web fonts).

    - During replay, since it is based on the `guance.com` sandbox environment for the iframe, if certain static resources do not have authorization from a specific domain, your browser will block the request.
    - Allow `guance.com` to access any font or image static resources that your website depends on through the Access-Control-Allow-Origin header, to ensure access to these resources for replay.

    > For more information, see [Cross-Origin Resource Sharin](https://developer.mozilla.org/en-US/docs/Web)。

:material-numeric-3-circle: **CSS style 未正确应用或者鼠标悬停事件未重放**

Unlike fonts and images, Session Replay Record attempts to bundle various applied CSS rules as part of the recorded data using the [CSSStyleSheet](https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleSheet) interface. If it cannot be executed, it falls back to recording the link to the CSS file.

To obtain proper mouse hover support, CSS rules must be accessible through the CSSStyleSheet interface.

If the style file is hosted on a different domain than the webpage, access to the CSS rules will be subject to the browser's cross-origin security check, and the browser must load the CORS-enabled style file with the [crossorigin](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/crossorigin) attribute specified.

For example, if your application is hosted on the `example.com` domain and relies on a CSS file on `assets.example.com` through the link element, the `crossorigin` attribute should be set to `anonymous`.

```js
<link rel="stylesheet" crossorigin="anonymous"
      href="https://assets.example.com/style.css”>
```

Furthermore, authorize the example.com domain in assets.example.com. This allows the resource files to be correctly loaded by setting the [Access-Control-Allow-Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin) header.

## More Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; How does Session Replay ensure the security of your data?</font>](../../security/index.md#session-replay)


</div>

<!-- 
## Session Repaly Privacy Settings

Session Replay provides privacy controls to ensure that no company exposes sensitive or personal data. And the data is stored encrypted.
Session Replay's default privacy options are designed to protect end-user privacy and prevent sensitive organizational information from being collected.

By opening Session Replay, sensitive elements can be automatically masked from being recorded by the RUM SDK.

### Configuration

To enable your privacy settings, set defaultPrivacyLevel to mask-user-input, mask, or allow in your SDK configuration.

```js
import { datafluxRum } from '@cloudcare/browser-rum';

datafluxRum.init({
    applicationId: '<DATAFLUX_APPLICATION_ID>',
    datakitOrigin: '<DATAKIT ORIGIN>',
    service: 'browser',
    env: 'production',
    version: '1.0.0',
    sessionSampleRate: 100,
    sessionReplaySampleRate: 100,
    trackInteractions: true,
    defaultPrivacyLevel: 'mask-user-input' | 'mask' | 'allow'
});

datafluxRum.startSessionReplayRecording();
```

After updating the configuration, you can overwrite elements of an HTML document with the following privacy options:

### Mask User Input Mode

Mask most form fields, such as input, text areas, and check box values, while recording all other text as it is. The input is replaced with three asterisks (***), and the text area is obfuscated by the x character of the reserved space.

Note: By default, mask-user-input is the privacy setting when session replay is enabled.

### Mask Mode

Mask all HTML text, user input, images, and links. The text on the application is replaced with X, rendering the page as a wireframe.

### Allow Mode

Record all data.

## Some Restrictions on Privacy

For data security reasons, the following elements are blocked regardless of the mode you configure `defaultPrivacyLevel`:

- Input elements of type password, email, and tel.
- Elements with the `autocomplete` attribute, such as credit card number, expiration date, and security code.

## Notes

## Some HTML elements are not visible when playing

Session replay does not support the following HTML elements: iframe, video, audio, or canvas. Session Replay does not support Web Components and the Shadow DOM.

## FONT or IMG does not render correctly

Session Replay is not a video, but an iframe based on DOM snapshot reconstruction. Therefore, replay depends on various static resources of the page: font and image.

Static resources may not be available during replay for the following reasons:

- The static resource no longer exists. For example, it is part of a previous deployment.
- The static resource is inaccessible. For example, authentication may be required, or resources may be accessible only from the internal network.
- Static resources are blocked by browsers due to CORS (usually web fonts).

  1. Because the replay is based on the `guance.com` sandbox environment corresponding to iframe, your browser will block the request if some static resources are not authorized by a specific domain name.
  2. Allow `guance.com` access to any font or image static resources that your Web site depends on through the Access-Control-Allow-Origin Header header to ensure that they are accessible for replay. For more information, see [cross-source resources sharing](https://developer.mozilla.org/en-US/docs/Web).

## CSS style is not applied correctly or mouse hover events are not replayed

Unlike font and image, Session Replay Record attempts to bundle the various CSS rules applied as part of the recorded data using the [CSSStyleSheet](https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleSheet) interface. If it cannot be executed, it will fall back to the link of recording CSS file.

For proper mouse hover support, CSS rules must be accessible through the CSSStyleSheet interface.

If the style file is hosted on a different domain than the Web page, access to CSS rules is subject to cross-source security checks by the browser, and the browser must be specified to load the style file that utilizes CORS using the [crossorigin](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/crossorigin) attribute.


For example, if your application is on the example.com domain and depends on the CSS file on assets.example.com through the link element, the `crossorigin` property should be set to `anonymous`.
```js
<link rel="stylesheet" crossorigin="anonymous"
      href="https://assets.example.com/style.css”>
```

In addition, authorize the example.com domain in assets.example.com. This allows the resource file to load the resource correctly by setting the Header of [Access-Control-Allow-Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin).

-->