# Web 应用接入

---

观测云应用监测能够通过收集各个 Web 应用的指标数据，以可视化的方式分析各个 Web 应用端的性能。

## 前置条件

**注意**：若您开通了 [RUM Headless](../../dataflux-func/headless.md) 服务，前置条件已自动帮您配置完成，直接接入应用即可。

- 安装 [DataKit](../../datakit/datakit-install.md)；
- 配置 [RUM 采集器](../../integrations/rum.md)；
- DataKit 配置为[公网可访问，并且安装 IP 地理信息库](../../datakit/datakit-tools-how-to.md#install-ipdb)。

## 应用接入 {#access}

登录观测云控制台，进入**用户访问监测**页面，点击左上角 **[新建应用](../index.md#create)**，即可开始创建一个新的应用。

- 观测云提供**公网 DataWay**直接接收 RUM 数据，无需安装 DataKit 采集器。配置 `site` 和 `clientToken` 参数即可。支持在控制台中直接上传 SourceMap，可以基于不同的版本和环境上传多个文件。

![](../img/web_01.png)

- 观测云同时支持**本地环境部署**接收 RUM 数据，该方式需满足前置条件。

![](../img/6.rum_web.png)

Web 应用接入的有三种方式：NPM 接入、同步载入和异步载入。

| 接入方式     | 简介                                                                                                                                                             |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM          | 通过把 SDK 代码一起打包到前端项目中，此方式可以确保对前端页面的性能不会有任何影响，不过可能会错过 SDK 初始化之前的的请求、错误的收集。                           |
| CDN 异步加载 | 通过 CDN 加速缓存，以异步脚本引入的方式，引入 SDK 脚本，此方式可以确保 SDK 脚本的下载不会影响页面的加载性能，不过可能会错过 SDK 初始化之前的的请求、错误的收集。 |
| CDN 同步加载 | 通过 CDN 加速缓存，以同步脚本引入的方式，引入 SDK 脚本，此方式可以确保能够收集到所有的错误，资源，请求，性能指标。不过可能会影响页面的加载性能。                 |

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'

    datafluxRum.init({
      applicationId: 'guance',
      datakitOrigin: '<DataKit的域名或IP>', // DK方式接入时需要配置
      clientToken: 'clientToken', // 公网 OpenWay 接入时,需要填写
      site: '公网 OpenWay 地址', // 公网 OpenWay 接入时,需要填写
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackInteractions: true,
      traceType: 'ddtrace', // 非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6种类型
      allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // 非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是正则
    })
    ```

=== "CDN 异步加载"

    ```javascript
    <script>
     (function (h, o, u, n, d) {
        h = h[d] = h[d] || {
          q: [],
          onReady: function (c) {
            h.q.push(c)
          }
        }
        d = o.createElement(u)
        d.async = 1
        d.src = n
        n = o.getElementsByTagName(u)[0]
        n.parentNode.insertBefore(d, n)
      })(
        window,
        document,
        'script',
        'https://static.guance.com/browser-sdk/v3/dataflux-rum.js',
        'DATAFLUX_RUM'
      )
      DATAFLUX_RUM.onReady(function () {
        DATAFLUX_RUM.init({
          applicationId: 'guance',
          datakitOrigin: '<DataKit的域名或IP>', // DK方式接入时需要配置
          clientToken: 'clientToken', // 公网 OpenWay 接入时,需要填写
          site: '公网 OpenWay 地址', // 公网 OpenWay 接入时,需要填写
          env: 'production',
          version: '1.0.0',
          sessionSampleRate: 100,
          sessionReplaySampleRate: 70,
          trackInteractions: true,
          traceType: 'ddtrace', // 非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6种类型
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // 非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是正则
        })
      })
    </script>
    ```

=== "CDN 同步加载"

    ```javascript
    <script src="https://static.guance.com/browser-sdk/v3/dataflux-rum.js" type="text/javascript"></script>
    <script>
      window.DATAFLUX_RUM &&
        window.DATAFLUX_RUM.init({
          applicationId: 'guance',
          datakitOrigin: '<DataKit的域名或IP>', // DK方式接入时需要配置
          clientToken: 'clientToken', // 公网 OpenWay 接入时,需要填写
          site: '公网 OpenWay 地址', // 公网 OpenWay 接入时,需要填写
          env: 'production',
          version: '1.0.0',
          sessionSampleRate: 100,
          sessionReplaySampleRate: 70,
          trackInteractions: true,
          traceType: 'ddtrace', //非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6种类型
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  //非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是正则
        })
    </script>
    ```

## 开始配置 {#config}

### 初始化参数

| 参数                                   | <div style="width: 60px">类型</div> | <div style="width: 60px">是否必须</div> | <div style="width: 60px">默认值</div> | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| -------------------------------------- | ----------------------------------- | --------------------------------------- | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                        | String                              | 是                                      |                                       | 从观测云创建的应用 ID。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| `datakitOrigin`                        | String                              | 是                                      |                                       | DataKit 数据上报 Origin 注释: <br>`协议（包括：//），域名（或IP地址）[和端口号]`<br> 例如：<br>[https://www.datakit.com](https://www.datakit.com)；<br>[http://100.20.34.3:8088](http://100.20.34.3:8088)。                                                                                                                                                                                                                                                                                                                                                   |
| `clientToken`                          | String                              | 是                                      |                                       | 以 openway 方式上报数据令牌，从观测云控制台获取，必填（公共 openway 方式接入）。                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `site`                                 | String                              | 是                                      |                                       | 以 公共 openway 方式上报数据地址，从观测云控制台获取，必填（公共 openway 方式接入）。                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `env`                                  | String                              | 否                                      |                                       | Web 应用当前环境，如 prod：线上环境；gray：灰度环境；pre：预发布环境；common：日常环境；local：本地环境。                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `version`                              | String                              | 否                                      |                                       | Web 应用的版本号。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `service`                              | String                              | 否                                      |                                       | 当前应用的服务名称，默认为 `browser`，支持自定义配置。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `sessionSampleRate`                    | Number                              | 否                                      | `100`                                 | 指标数据收集百分比：<br>`100` 表示全收集；`0` 表示不收集。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `sessionReplaySampleRate`              | Number                              | 否                                      | `100`                                 | [Session Replay](../session-replay/replay.md) 数据采集百分比: <br>`100` 表示全收集；`0` 表示不收集。                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
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

## FAQ

### 配置 allowedTracingOrigins 之后，异步请求跨域

为了在使用 APM（应用性能监控）工具时实现前端到后端的完整跟踪（通常称为 RUM，即真实用户监控），你需要在前端和后端进行相应的配置。以下是主要步骤和注意事项：

### 前端配置

1. **安装并配置 RUM SDK**：

   - 在你的 Web 前端应用中安装 APM 工具提供的 RUM SDK。
   - 配置 SDK，包括设置`allowedTracingOrigins`（允许发送跟踪信息的源域名）和`traceType`（跟踪类型或框架，如`ddtrace`用于 Datadog）。

2. **发送跟踪信息**：
   - RUM SDK 会自动在前端发起的请求头中添加必要的跟踪信息，如`x-datadog-parent-id`, `x-datadog-origin`, `x-datadog-sampling-priority`, `x-datadog-trace-id`等。

### 后端配置

1. **设置 CORS 策略**：

   - 在后端服务器上配置 CORS（跨源资源共享）策略，允许来自前端域的请求，并特别指定`Access-Control-Allow-Headers`以包含所有必要的跟踪信息头部。
   - 例如，如果你的后端使用 Node.js 和 Express 框架，可以添加 CORS 中间件并设置`allowedHeaders`属性来包含这些跟踪信息头部。

   ```javascript
   const cors = require('cors')
   app.use(
     cors({
       origin: 'https://your-frontend-domain.com', // 替换为你的前端应用域名
       allowedHeaders: [
         'x-datadog-parent-id',
         'x-datadog-origin',
         'x-datadog-sampling-priority',
         'x-datadog-trace-id',
         // 可能还有其他必要的头部
       ],
     })
   )
   ```

2. **处理请求**：
   - 确保后端服务能够接收并正确处理这些跟踪信息头部。这些信息通常用于在后端服务中关联和追踪请求。

### 验证与测试

- **测试配置**：

  - 发起从前端到后端的请求，并检查网络请求的 HTTP 头部以确保跟踪信息被正确发送。
  - 查看后端服务器日志，确认跟踪信息被正确处理。

- **调试与修正**：
  - 如果遇到任何问题（如 CORS 错误、头部未发送等），请检查前端和后端的配置，并根据需要调整。

### 注意事项

- **安全性**：确保`allowedTracingOrigins`仅包含受信任的源，以防止潜在的跨站请求伪造（CSRF）攻击。
- **性能**：虽然跟踪信息对于性能监控至关重要，但请确保它们不会对你的应用性能造成负面影响。

通过以上步骤，你可以成功配置 APM 工具以支持前端到后端的完整跟踪，从而更有效地监控和优化你的 Web 应用的性能。

### 产生 Script error

在使用观测云 Web Rum Sdk 进行 Web 端错误收集的时候，经常会在 `js_error` 中看到 Script error。这样的错误信息并没有包含任何详细信息。

:face_with_monocle: 可能出现上面问题的原因：

1. 用户使用的浏览器不支持错误的捕获 (概率极小)。
2. 出错的脚本文件是跨域加载到页面的。

对于用户浏览器不支持的情况，这种我们是无法处理的；这里主要解决跨域脚本错误无法收集的原因和解决方案。

一般情况下脚本文件是使用 `<script>` 标签加载，对于同源脚本出错，在使用浏览器的 `GlobalEventHandlers API` 时，收集到的错误信息会包含详细的错误信息；当不同源脚本出错时，收集到的错误信息只有 `Script error.` 文本，这是由浏览器的同源策略控制的，也是正常的情况。对于非同源脚本我们只需要进行非同源资源共享（也称 HTTP 访问控制 / CORS）的操作即可。

:partying_face: 解决方法：

:material-numeric-1-circle-outline: 脚本文件直接存放在服务器：

在服务器上静态文件输出时添加 Header：

```
Access-Control-Allow-Origin: *
```

在非同源脚本所在的 Script 标签上添加属 crossorigin="anonymous"：

```
<script type="text/javascript" src="path/to/your/script.js" crossorigin="anonymous"></script>
```

:material-numeric-2-circle-outline: 脚本文件存放 CDN 上：

在 CDN 设置中添加 Header：

```
Access-Control-Allow-Origin: *
```

在非同源脚本所在的 Script 标签上添加属 crossorigin="anonymous"：

```
<script type="text/javascript" src="path/to/your/script.js" crossorigin="anonymous"></script>
```

:material-numeric-3-circle-outline: 脚本文件从第三方加载：

在非同源脚本所在的 Script 标签上添加属 crossorigin="anonymous"：

```
<script type="text/javascript" src="path/to/your/script.js" crossorigin="anonymous"></script>
```

### 资源数据收集不完整

资源数据包含 ssl、tcp、dns、trans、ttfb。在数据上报过程中，部分资源 timing 数据有可能收集不完整。比如 tcp、dns 数据没有收集上报。

:face_with_monocle: 可能出现上面问题的原因：

1. 比如 dns 数据没有收集到，有可能是您应用的这个资源请求是以 `keep-alive` 保持链接的，这种情况只有在您第一次请求的时候，会有创建链接的过程，之后的请求都会保持同一连接，不会再重新创建 tcp 连接。所以会出现 dns 数据没有的情况，或者数据为 `0`。
2. 应用的资源是以跨域的形式加载到页面的，和您的网站并非同源（主要原因)。
3. 浏览器不支持 `Performance API` (极少数情况)。

### 跨域资源 {#header}

:material-numeric-1-circle-outline: 资源文件直接存放在服务器：

在服务器上资源文件输出时添加 Header：

```
Timing-Allow-Origin: *
```

:material-numeric-2-circle-outline: 资源文件存放 CDN 上：

在 CDN 设置中添加 Header：

```
Timing-Allow-Origin: *
```

### 识别搜索引擎机器人 {#bot}

进行网页活动时需区分真实用户活动和搜索引擎。可使用以下示例脚本来过滤具有机器人的会话：

```
// regex patterns to identify known bot instances:
let botPattern = "(googlebot\/|bot|Googlebot-Mobile|Googlebot-Image|Google favicon|Mediapartners-Google|bingbot|slurp|java|wget|curl|Commons-HttpClient|Python-urllib|libwww|httpunit|nutch|phpcrawl|msnbot|jyxobot|FAST-WebCrawler|FAST Enterprise Crawler|biglotron|teoma|convera|seekbot|gigablast|exabot|ngbot|ia_archiver|GingerCrawler|webmon |httrack|webcrawler|grub.org|UsineNouvelleCrawler|antibot|netresearchserver|speedy|fluffy|bibnum.bnf|findlink|msrbot|panscient|yacybot|AISearchBot|IOI|ips-agent|tagoobot|MJ12bot|dotbot|woriobot|yanga|buzzbot|mlbot|yandexbot|purebot|Linguee Bot|Voyager|CyberPatrol|voilabot|baiduspider|citeseerxbot|spbot|twengabot|postrank|turnitinbot|scribdbot|page2rss|sitebot|linkdex|Adidxbot|blekkobot|ezooms|dotbot|Mail.RU_Bot|discobot|heritrix|findthatfile|europarchive.org|NerdByNature.Bot|sistrix crawler|ahrefsbot|Aboundex|domaincrawler|wbsearchbot|summify|ccbot|edisterbot|seznambot|ec2linkfinder|gslfbot|aihitbot|intelium_bot|facebookexternalhit|yeti|RetrevoPageAnalyzer|lb-spider|sogou|lssbot|careerbot|wotbox|wocbot|ichiro|DuckDuckBot|lssrocketcrawler|drupact|webcompanycrawler|acoonbot|openindexspider|gnam gnam spider|web-archive-net.com.bot|backlinkcrawler|coccoc|integromedb|content crawler spider|toplistbot|seokicks-robot|it2media-domain-crawler|ip-web-crawler.com|siteexplorer.info|elisabot|proximic|changedetection|blexbot|arabot|WeSEE:Search|niki-bot|CrystalSemanticsBot|rogerbot|360Spider|psbot|InterfaxScanBot|Lipperhey SEO Service|CC Metadata Scaper|g00g1e.net|GrapeshotCrawler|urlappendbot|brainobot|fr-crawler|binlar|SimpleCrawler|Livelapbot|Twitterbot|cXensebot|smtbot|bnf.fr_bot|A6-Indexer|ADmantX|Facebot|Twitterbot|OrangeBot|memorybot|AdvBot|MegaIndex|SemanticScholarBot|ltx71|nerdybot|xovibot|BUbiNG|Qwantify|archive.org_bot|Applebot|TweetmemeBot|crawler4j|findxbot|SemrushBot|yoozBot|lipperhey|y!j-asr|Domain Re-Animator Bot|AddThis)";

let regex = new RegExp(botPattern, 'i');

// define var allowedTracingOrigins if the userAgent matches a pattern in botPatterns
// otherwise, define allowedTracingOrigins to be normal
let allowedTracingOrigins = regex.test(navigator.userAgent)

// initialize the RUM Browser SDK and set allowtracingorigins
DATAFLUX_RUM.init({
 // ... config options
 allowedTracingOrigins: allowedTracingOrigins?[]:["https://***.com"],
});
```

## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :octicons-arrow-right-24: &nbsp; GlobalEventHandlers.onerror</font>](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onerror)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :octicons-arrow-right-24: &nbsp; Cross-Origin Resource Sharing (CORS)</font>](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :octicons-arrow-right-24: &nbsp; The Script element</font>](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :octicons-arrow-right-24: &nbsp; CORS settings attributes</font>](https://developer.mozilla.org/en-US/docs/Web/HTML/CORS_settings_attributes)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :octicons-arrow-right-24: &nbsp; Coping_with_CORS</font>](https://developer.mozilla.org/en-US/docs/Web/API/Resource_Timing_API/Using_the_Resource_Timing_API#Coping_with_CORS)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :octicons-arrow-right-24: &nbsp; Resource Timing Standard; W3C Editor's Draft</font>](https://w3c.github.io/resource-timing/)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :octicons-arrow-right-24: &nbsp; Resource Timing practical tips; Steve Souders</font>](http://www.stevesouders.com/blog/2014/08/21/resource-timing-practical-tips/)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :octicons-arrow-right-24: &nbsp; Measuring network performance with Resource Timing API</font>](http://googledevelopers.blogspot.ca/2013/12/measuring-network-performance-with.html)

</div>
