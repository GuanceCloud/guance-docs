# Web 应用接入

---

通过收集 Web 应用的指标数据，以可视化方式分析应用性能。

## 前置条件

???+ warning "注意"

    若已开通 [RUM Headless](../../dataflux-func/headless.md) 服务，前置条件已自动配置，可直接接入应用。

- 安装 [DataKit](../../datakit/datakit-install.md)；
- 配置 [RUM 采集器](../../integrations/rum.md)；
- DataKit 配置为[公网可访问，并且安装 IP 地理信息库](../../datakit/datakit-tools-how-to.md#install-ipdb)。

## 开始接入 {#access}

1. 进入**用户访问监测 > 新建应用 > Web**；
2. 输入应用名称；
3. 输入应用 ID；
4. 选择应用接入方式：

   - 公网 DataWay：直接接收 RUM 数据，无需安装 DataKit 采集器。
   - 本地环境部署：满足前置条件后接收 RUM 数据。

### 接入方式

<div class="grid" markdown>

=== "DK 接入"

    1. 确保 DataKit 已安装并配置为[公网可访问，并安装 IP 地理信息库](../../datakit/datakit-tools-how-to.md#install-ipdb)；    
    2. 在控制台获取 `applicationId`、`env`、`version` 等参数，开始[接入应用](#access)；   
    3. 集成 SDK 时，将 `datakitOrigin` 设置为 DataKit 的域名或 IP。

    ---

=== "公网 OpenWay" 

    1. 在控制台获取 `applicationId`、`clientToken` 和 `site` 等参数，开始[接入应用](#access)；  
    2. 集成 SDK 时无需配置 `datakitOrigin`，数据将默认发送到公网 DataWay。

    ---

</div>


### SDK 配置

| <div style="width: 130px">接入方式</div>     | 说明      |
| ------------ | ------------------------- |
| [NPM](#npm)          | 将 SDK 代码打包到前端项目中，确保前端性能不受影响。可能错过 SDK 初始化前的请求和错误收集。 |
| [CDN 异步加载](#cdn-asynchronous) | 通过 CDN 异步引入 SDK 脚本，不影响页面加载性能。可能错过初始化前的请求和错误收集。        |
| [CDN 同步加载](#cdn-synchronous) | 通过 CDN 同步引入 SDK 脚本，能完整收集所有错误和性能指标。但可能影响页面加载性能。          |

#### NPM 接入 {#npm}

在前端项目中安装并引入 SDK：

```bash
npm install @cloudcare/browser-rum
```

在项目中初始化 SDK：

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'

datafluxRum.init({
  applicationId: '您的应用ID',
  datakitOrigin: '<DataKit的域名或IP>', // DK方式接入时需要配置
  clientToken: 'clientToken', // 公网 OpenWay 接入时,需要填写
  site: '公网 OpenWay 地址', // 公网 OpenWay 接入时,需要填写
  env: 'production',
  version: '1.0.0',
  sessionSampleRate: 100,
  sessionReplaySampleRate: 70,
  trackUserInteractions: true,
  // 其他可选配置...
})

// 开启会话重放录制
datafluxRum.startSessionReplayRecording()
```


#### CDN 异步加载 {#cdn-asynchronous}

在 HTML 文件中添加脚本：

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
      applicationId: '您的应用ID',
      datakitOrigin: '<DataKit的域名或IP>', // DK方式接入时需要配置
      clientToken: 'clientToken', // 公网 OpenWay 接入时,需要填写
      site: '公网 OpenWay 地址', // 公网 OpenWay 接入时,需要填写
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackUserInteractions: true,
      // 其他配置...
    })
    // 开启会话重放录制
    window.DATAFLUX_RUM.startSessionReplayRecording()
  })
</script>
```

#### CDN 同步加载 {#cdn-synchronous}

在 HTML 文件中添加脚本：

```html
<script
  src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js"
  type="text/javascript"
></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: '您的应用ID',
      datakitOrigin: '<DataKit的域名或IP>', // DK方式接入时需要配置
      clientToken: 'clientToken', // 公网 OpenWay 接入时,需要填写
      site: '公网 OpenWay 地址', // 公网 OpenWay 接入时,需要填写
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackUserInteractions: true,
      // 其他配置...
    })
  // 开启会话重放录制
  window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording()
</script>
```


## 参数配置 {#config}

### 初始化参数

| 参数                                   | <div style="width: 60px">类型</div> | <div style="width: 60px">是否必须</div> | <div style="width: 60px">默认值</div> | 描述      |
| -------------------------------------- | ----------------------------------- | --------------------------------------- | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                        | String                              | 是                                      |                                       | 从<<< custom_key.brand_name >>>创建的应用 ID。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `datakitOrigin`                        | String                              | 是                                      |                                       | DataKit 数据上报 Origin 注释: <br>`协议（包括：//），域名（或IP地址）[和端口号]`<br> 例如：<br>[https://www.datakit.com](https://www.datakit.com)；<br>[http://100.20.34.3:8088](http://100.20.34.3:8088)。                                                                                                                                                                                                                                                                                                                                                   |
| `clientToken`                          | String                              | 是                                      |                                       | 以 openway 方式上报数据令牌，从<<< custom_key.brand_name >>>控制台获取，必填（公共 openway 方式接入）。                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| `site`                                 | String                              | 是                                      |                                       | 以 公共 openway 方式上报数据地址，从<<< custom_key.brand_name >>>控制台获取，必填（公共 openway 方式接入）。                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `env`                                  | String                              | 否                                      |                                       | Web 应用当前环境，如 prod：线上环境；gray：灰度环境；pre：预发布环境；common：日常环境；local：本地环境。                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `version`                              | String                              | 否                                      |                                       | Web 应用的版本号。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `service`                              | String                              | 否                                      |                                       | 当前应用的服务名称，默认为 `browser`，支持自定义配置。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `sessionSampleRate`                    | Number                              | 否                                      | `100`                                 | 指标数据收集百分比：<br>`100` 表示全收集；`0` 表示不收集。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `sessionOnErrorSampleRate`             | Number                              | 否                                      | `0`                                   | 错误会话补偿采样率：当会话未被 `sessionSampleRate` 采样时，若会话期间发生错误，则按此比例采集。此类会话将在错误发生时开始记录事件，并持续记录直到会话结束。SDK 版本要求`>= 3.2.19`                                                                                                                                                                                                                                                                                                                                                                            |
| `sessionReplaySampleRate`              | Number                              | 否                                      | `100`                                 | [Session Replay](../session-replay/web/replay.md#config) 数据采集百分比: <br>`100` 表示全收集；`0` 表示不收集。                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `sessionReplayOnErrorSampleRate`       | Number                              | 否                                      | `0`                                   | [Session Replay](../session-replay/web/replay.md#config) 错误会话重放补偿采样率：当会话未被 `sessionReplaySampleRate` 采样时，若会话期间发生错误，则按此比例采集。此类回放将记录错误发生前最多一分钟的事件，并持续记录直到会话结束。SDK 版本要求`>= 3.2.19`                                                                                                                                                                                                                                                                                                   |
| `trackSessionAcrossSubdomains`         | Boolean                             | 否                                      | `false`                               | 同一个域名下面的子域名共享缓存。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `usePartitionedCrossSiteSessionCookie` | Boolean                             | 否                                      | `false`                               | 是否开启分区安全跨站点会话 cookie [详情](https://developers.google.com/privacy-sandbox/3pcd/chips?hl=zh-cn)                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `useSecureSessionCookie`               | Boolean                             | 否                                      | `false`                               | 使用安全会话 cookie。这将禁用在不安全（非 HTTPS）连接上发送的 RUM 事件                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `traceType`                            | Enum                                | 否                                      | `ddtrace`                             | 配置链路追踪工具类型，如果不配置默认为 `ddtrace`。目前支持 `ddtrace`、`zipkin`、`skywalking_v3`、`jaeger`、`zipkin_single_header`、`w3c_traceparent` 6 种数据类型。<br><br>:warning: <br>1. `opentelemetry` 支持 `zipkin_single_header`、`w3c_traceparent`、`zipkin`、`jaeger` 4 种类型。<br>2. 该配置的生效需依赖 `allowedTracingOrigins` 配置项。<br>3. 配置相应类型的 traceType 需要对相应的 API 服务。关于设置不同的 `Access-Control-Allow-Headers`，可参考 [APM 如何关联 RUM ](../../application-performance-monitoring/collection/connect-web-app.md)。 |
| `traceId128Bit`                        | Boolean                             | 否                                      | `false`                               | 是否以 128 字节的方式生成 `traceID`，与 `traceType` 对应，目前支持类型 `zipkin`、`jaeger`。                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `allowedTracingOrigins`                | Array                               | 否                                      | `[]`                                  | 允许注入 `trace` 采集器所需 header 头部的所有请求列表。可以是请求的 origin，也可以是正则，origin: `协议（包括：//），域名（或IP地址）[和端口号]`。_例如：<br>`["https://api.example.com", /https:\\/\\/._\\.my-api-domain\\.com/]`。\*                                                                                                                                                                                                                                                                                                                        |
| `allowedTracingUrls`                   | Array                               | 否                                      | `[]`                                  | 与 Apm 关联请求的 Url 匹配列表。可以是请求的 url，也可以是正则，或者是 match function 例如：`["https://api.example.com/xxx", /https:\/\/.*\.my-api-domain\.com\/xxx/, function(url) {if (url === 'xxx') { return false} else { return true }}]` 该参数是 `allowedTracingOrigins` 配置的扩展，两者配置其一即可。                                                                                                                                                                                                                                               |
| `trackUserInteractions`                | Boolean                             | 否                                      | `false`                               | 是否开启用户行为采集。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `actionNameAttribute`                  | String                              | 否                                      |                                       | 版本要求:`>3.1.2`。 为元素添加自定义属性来指定操作的名称。具体使用方式，[详情参考](./tracking-user-actions.md)                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `beforeSend`                           | Function(event, context):Boolean    | 否                                      |                                       | 版本要求:`>3.1.2`。 数据拦截以及数据修改，[详情参考](../../security/before-send.md)                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `storeContextsToLocal`                 | Boolean                             | 否                                      |                                       | 版本要求:`>3.1.2`。是否把用户自定义数据缓存到本地 localstorage，例如： `setUser`, `addGlobalContext` api 添加的自定义数据。                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `storeContextsKey`                     | String                              | 否                                      |                                       | 版本要求:`>3.1.18`。定义存储到 localstorage 的 key ，默认不填，自动生成, 该参数主要是为了区分在同一个域名下，不同子路径共用 store 的问题                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `compressIntakeRequests`               | Boolean                             | 否                                      |                                       | 压缩 RUM 数据请求内容，以减少发送大量数据时的带宽使用量，同时能够减少发送数据的请求数量。压缩在 WebWorker 线程中完成。关于 csp 安全策略[可参考 csp 安全](../../security/content-security-policy.md#webwork)。SDK 版本要求`>= 3.2.0`。 datakit 版本要求 `>=1.60 `。部署版要求 `>= 1.96.178`                                                                                                                                                                                                                                                                    |
| `workerUrl`                            | Sring                               | 否                                      |                                       | sessionReplay 和 compressIntakeRequests 数据压缩都是在 webwork 线程中完成，所以默认情况下，在开启 csp 安全访问的情况下，需要允许 worker-src blob:; 该配置允许添加自行托管 worker 地址。关于 csp 安全策略[可参考 csp 安全](../../security/content-security-policy.md#webwork)。SDK 版本要求`>= 3.2.0`。                                                                                                                                                                                                                                                        |

#### `site` 参数处理 {#site}

<<<% if custom_key.brand_key == 'truewatch' %>>>

| 节点名       | 地址                       |
|-----------|--------------------------------|
| 海外区1（俄勒冈） | https://us1-openway.<<< custom_key.brand_main_domain >>> |
| 欧洲区1（法兰克福） | https://eu1-openway.<<< custom_key.brand_main_domain >>> |
| 亚太区1（新加坡） | https://ap1-openway.<<< custom_key.brand_main_domain >>> |
| 非洲区1（南非） | https://za1-openway.<<< custom_key.brand_main_domain >>> |
| 印尼区1（雅加达） | https://id1-openway.<<< custom_key.brand_main_domain >>> |

<<<% else %>>>

| 节点名       | 地址                       |
|-----------|--------------------------------|
| 中国区1（杭州）  | https://rum-openway.<<< custom_key.brand_main_domain >>>     |
| 中国区2（宁夏）  | https://aws-openway.<<< custom_key.brand_main_domain >>> |
| 中国区4（广州）  | https://cn4-openway.<<< custom_key.brand_main_domain >>> |
| 中国区6（香港）  | https://cn6-openway.guance.one |
| 海外区1（俄勒冈） | https://us1-openway.<<< custom_key.brand_main_domain >>> |
| 欧洲区1（法兰克福） | https://eu1-openway.guance.one |
| 亚太区1（新加坡） | https://ap1-openway.guance.one |
| 非洲区1（南非） | https://za1-openway.<<< custom_key.brand_main_domain >>> |
| 印尼区1（雅加达） | https://id1-openway.<<< custom_key.brand_main_domain >>> |

<<<% endif %>>>

## 应用场景

### 仅采集错误会话事件

???+ warning "前提"

    SDK 版本要求：3.2.19 以上。

当页面触发错误时，SDK 将自动执行：

- 持续记录：从错误触发起，完整记录会话全生命周期数据。
- 精准补偿：通过独立采样通道，确保错误场景无遗漏。

#### 配置方案

```javascript
<script
  src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js"
  type="text/javascript"
></script>
<script>
// 核心配置初始化
window.DATAFLUX_RUM && window.DATAFLUX_RUM.init({

   ...
   // 精准采集策略
   sessionSampleRate: 0,             // 关闭常规会话采集
   sessionOnErrorSampleRate: 100, // 全量采集错误会话

});

</script>
```

### 自定义添加数据 TAG

使用 `setGlobalContextProperty` 或 `setGlobalContext` API 为所有 RUM 事件[添加自定义 tag](./custom-sdk/add-additional-tag.md)。


```javascript
// 使用setGlobalContextProperty添加单个TAG
window.DATAFLUX_RUM && window.DATAFLUX_RUM.setGlobalContextProperty('userName', '张三')

// 使用setGlobalContext添加多个TAG
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.setGlobalContext({
    userAge: 28,
    userGender: '男',
  })
```

### 跟踪用户操作

#### 控制是否开启采集 Action

通过 `trackUserInteractions` 初始化参数控制是否采集用户点击行为。

#### 自定义 Action 名称

- 通过为可点击元素添加`data-guance-action-name`属性或`data-custom-name`（取决于`actionNameAttribute`配置）来自定义 Action 名称。

#### 使用 `addAction` API 自定义 Action

```javascript
// CDN 同步加载
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.addAction('cart', {
    amount: 42,
    nb_items: 2,
    items: ['socks', 't-shirt'],
  })

// CDN 异步加载
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

### 自定义添加 Error

使用 `addError` API 自定义添加 Error 指标数据 [添加自定义 Error](./custom-sdk/add-error.md)。

```javascript
// CDN 同步加载
const error = new Error('Something wrong occurred.')
window.DATAFLUX_RUM && DATAFLUX_RUM.addError(error, { pageStatus: 'beta' })

// CDN 异步加载
window.DATAFLUX_RUM.onReady(function () {
  const error = new Error('Something wrong occurred.')
  window.DATAFLUX_RUM.addError(error, { pageStatus: 'beta' })
})

// NPM
import { datafluxRum } from '@cloudcare/browser-rum'
const error = new Error('Something wrong occurred.')
datafluxRum.addError(error, { pageStatus: 'beta' })
```

### 自定义用户标识

使用 `setUser` API 为当前用户添加标识属性（如 ID、name、email）[添加自定义 用户信息](./custom-sdk/user-id.md)。

```javascript
// CDN 同步加载
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.setUser({
    id: '1234',
    name: 'John Doe',
    email: 'john@doe.com',
  })

// CDN 异步加载
window.DATAFLUX_RUM.onReady(function () {
  window.DATAFLUX_RUM.setUser({ id: '1234', name: 'John Doe', email: 'john@doe.com' })
})

// NPM
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum.setUser({ id: '1234', name: 'John Doe', email: 'john@doe.com' })
```


## Web 会话重放

???+ warning "前提"

    确保您使用的 SDK 版本支持会话重放功能（通常是 `> 3.0.0` 版本）。

### 开启录制

在 SDK 初始化后，调用 `startSessionReplayRecording()` 方法来开启会话重放的录制。您可以选择在特定条件下开启，如用户登录后 [开启会话录制](../session-replay/index.md)。

### 仅采集错误相关的会话重放数据

???+ warning "前提"

    SDK 版本要求在 3.2.19 以上。

当页面发生错误时，SDK 将自动执行以下操作：

- 回溯采集：记录错误前 1 分钟的完整页面快照；      
- 持续录制：从错误发生时起持续记录，直至会话结束；  
- 智能补偿：通过独立采样通道确保错误场景无遗漏。

#### 配置示例

```javascript
<script
  src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js"
  type="text/javascript"
></script>
<script>
// 初始化 SDK 核心配置
window.DATAFLUX_RUM && window.DATAFLUX_RUM.init({
   ....

   // 采样策略配置
   sessionSampleRate: 100,          // 全量基础会话采集 (100%)
   sessionReplaySampleRate: 0,       // 关闭常规录屏采样
   sessionReplayOnErrorSampleRate: 100, // 错误场景 100% 采样

});

// 强制开启录屏引擎（必须调用）
window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording();
</script>
```

#### 注意事项

- 会话重放功能不涵盖 iframe、视频、音频和画布元素的播放；   
- 为确保重放时能正常访问静态资源（如字体、图片），可能需要配置 CORS 策略；   
- 确保通过 CSSStyleSheet 接口可访问 CSS 规则，以支持 CSS 样式和鼠标悬停事件。

#### 调试优化

- 利用 SDK 提供的日志和监控工具进行调试，提升应用性能；   
- 根据业务需求调整 `sessionSampleRate` 和 `sessionReplaySampleRate` 参数。


