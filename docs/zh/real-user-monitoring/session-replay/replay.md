# 如何接入会话重放（Session Replay）
---

## 开启 Session Replay

通过您之前的 SDK 引入方式，替换 NPM 包为 `> 3.0.0` 版本、或者替换原来的 CDN 链接为 `https://static.guance.com/browser-sdk/v3/dataflux-rum.js`。SDK 初始化 `init()` 之后并不会自动采集 Session Replay Record 数据，需要执行 `startSessionReplayRecording` 开启数据的采集，这对于一些只采集特定情况 Session Replay Record 数据很有用，比如：

```js
 // 只采集用户登录之后的操作数据
 if (user.isLogin()) {
    DATAFLUX_RUM.startSessionReplayRecording();
 }
```

### NPM {#npm}

引入 @cloudcare/browser-rum 包，并且保证 [@cloudcare/browser-rum](https://www.npmjs.com/package/@cloudcare/browser-rum) 的版本 `> 3.0.0`，如果要开始录制，在初始化后，请执行 `datafluxRum.startSessionReplayRecording()`。

```js
import { datafluxRum } from '@cloudcare/browser-rum';

datafluxRum.init({
    applicationId: '<DATAFLUX_APPLICATION_ID>',
    datakitOrigin: '<DATAKIT ORIGIN>',
    service: 'browser',
    env: 'production',
    version: '1.0.0',
    sessionSampleRate: 100,
    sessionReplaySampleRate: 70,
    trackInteractions: true,
});

datafluxRum.startSessionReplayRecording();
```

### CDN {#cdn}

替换原来的 CDN 地址 `https://static.guance.com/browser-sdk/v2/dataflux-rum.js` 为 `https://static.guance.com/browser-sdk/v3/dataflux-rum.js`, 并在执行 `DATAFLUX_RUM.init()` 之后，执行 `DATAFLUX_RUM.startSessionReplayRecording()`。

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


## 注意事项

### 某些 HTML 元素在播放时候不可见

会话重放不支持以下 HTML 元素：iframe、视频、音频或画布。Session Replay 不支持 Web Components 和 Shadow DOM。

### FONT 或 IMG 无法正确呈现

Session Replay 不是视频，而是基于 DOM 快照重建的 iframe。因此，重放取决于页面的各种静态资源：font 和 image。

由于以下原因，重放时静态资源可能不可用：

- 该静态资源已经不存在。例如，它是以前部署的一部分。
- 该静态资源不可访问。例如，可能需要身份验证，或者资源可能只能从内部网络访问。
- 由于 CORS（通常是网络字体），静态资源被浏览器阻止。

    - 由于重放时，是基于 iframe 对应的 `guance.com` 沙箱环境，如果某些静态资源未获得特定域名授权，您的浏览器将阻止该请求；
    - 通过 Access-Control-Allow-Origin Header头允许 `guance.com`  访问您的网站所依赖的任何 font 或 image 静态资源，以确保可以访问这些资源以进行重放。

    > 有关详细信息，可参考 [跨源资源共享](https://developer.mozilla.org/en-US/docs/Web)。

### CSS style 未正确应用或者鼠标悬停事件未重放

与 font 和 image 不同，Session Replay Record 尝试利用 [CSSStyleSheet](https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleSheet) 接口，将应用的各种 CSS 规则捆绑为记录数据的一部分。如果不能被执行，它会回退到记录 CSS 文件的链接。

要获得正确的鼠标悬停支持，必须可以通过 CSSStyleSheet 接口访问 CSS 规则。

如果样式文件托管在与网页不同的域上，则对 CSS 规则的访问将受到浏览器的跨源安全检查，并且必须指定浏览器使用 [crossorigin](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/crossorigin) 属性加载利用 CORS 的样式文件。


例如，如果您的应用程序位于 example.com 域上并通过 link 元素依赖于 assets.example.com 上的 CSS 文件，则 `crossorigin` 属性应设置为 `anonymous`。
```js
<link rel="stylesheet" crossorigin="anonymous"
      href="https://assets.example.com/style.css”>
```

此外，在 assets.example.com 中授权 example.com 域。这允许资源文件通过设置 [Access-Control-Allow-Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin) Header 头来正确加载资源。

## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Session Replay 如何保证您的数据安全？</font>](../../security/index.md#session-replay)

<br/>

</div>