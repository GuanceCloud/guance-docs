# 如何接入会话重放（Session Replay）

---

## 配置 {#config}

| 配置项                           | 类型     | 默认值    | 描述                                                                                                                                                                                  |
| -------------------------------- | -------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `sessionReplaySampleRate`        | Number   | `100`     | 回放数据采集百分比: <br>`100` 表示全收集；`0` 表示不收集                                                                                                                              |
| `sessionReplayOnErrorSampleRate` | Number   | `0`       | 在发生错误时记录回放的采样率。此类回放将记录错误发生前最多一分钟的事件，并持续记录直到会话结束。`100` 表示捕获所有发生错误的会话，`0` 表示不捕获任何会话回放。SDK 版本要求`>= 3.2.19` |
| `shouldMaskNode`                 | Function | undefined | session replay 屏蔽某个节点数据录制，可用于实现对某些自定义节点屏蔽效果。SDK 版本要求`>= 3.2.19`                                                                                      |

## 开启 Session Replay

通过您之前的 SDK 引入方式，替换 NPM 包为 `> 3.0.0` 版本、或者替换原来的 CDN 链接为 `https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js`。SDK 初始化 `init()` 之后并不会自动采集 Session Replay Record 数据，需要执行 `startSessionReplayRecording` 开启数据的采集，这对于一些只采集特定情况 Session Replay Record 数据很有用，比如：

```js
// 只采集用户登录之后的操作数据
if (user.isLogin()) {
  DATAFLUX_RUM.startSessionReplayRecording()
}
```

如果需要停止 Session Replay 数据采集，可以调用 `stopSessionReplayRecording()` 关闭。

### NPM {#npm}

引入 @cloudcare/browser-rum 包，并且保证 [@cloudcare/browser-rum](https://www.npmjs.com/package/@cloudcare/browser-rum) 的版本 `> 3.0.0`，如果要开始录制，在初始化后，请执行 `datafluxRum.startSessionReplayRecording()`。

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

替换原来的 CDN 地址 `https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v2/dataflux-rum.js` 为 `https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js`, 并在执行 `DATAFLUX_RUM.init()` 之后，执行 `DATAFLUX_RUM.startSessionReplayRecording()`。

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

### 如何实现仅采集错误相关的 Session Replay 数据（SDK 版本要求 `≥3.2.19`）

#### 功能说明

当页面发生错误时，SDK 将自动执行以下操作：

1. **回溯采集**：记录错误发生前 **1 分钟** 的完整页面快照
2. **持续录制**：从错误发生时刻起持续记录直至会话结束
3. **智能补偿**：通过独立采样通道确保错误场景的全覆盖

#### 配置示例

```javascript
<script
  src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js"
  type="text/javascript"
></script>
<script>
// 初始化 SDK 核心配置
window.DATAFLUX_RUM && window.DATAFLUX_RUM.init({
   // 必填参数
   applicationId: '<DATAFLUX_APPLICATION_ID>',
   datakitOrigin: '<DATAKIT_ORIGIN>',

   // 环境标识
   service: 'browser',
   env: 'production',
   version: '1.0.0',

   // 采样策略配置
   sessionSampleRate: 100,          // 全量基础会话采集 (100%)
   sessionReplaySampleRate: 0,       // 关闭常规录屏采样
   sessionReplayOnErrorSampleRate: 100, // 错误场景 100% 采样

   // 辅助功能
   trackInteractions: true          // 启用用户行为追踪
});

// 强制开启录屏引擎（必须调用）
window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording();
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

  - 由于重放时，是基于 iframe 对应的 `<<< custom_key.brand_main_domain >>>` 沙箱环境，如果某些静态资源未获得特定域名授权，您的浏览器将阻止该请求；
  - 通过 Access-Control-Allow-Origin Header 头允许 `<<< custom_key.brand_main_domain >>>` 访问您的网站所依赖的任何 font 或 image 静态资源，以确保可以访问这些资源以进行重放。

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

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Session Replay 如何保证您的数据安全？</font>](../../../security/index.md#session-replay)

</div>
