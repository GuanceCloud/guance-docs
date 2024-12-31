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

### Resource 数据收集不完整

以下现象，可能会被视为资源数据未被完整采集：

1. **资源大小相关数据为 0**  
   包括 `resource_transfer_size`、`resource_decode_size`、`resource_encode_size`、`resource_size` 等字段。

2. **时间相关数据未采集**  
   包括 `resource_dns`、`resource_tcp`、`resource_ssl`、`resource_ttfb`、`resource_trans`、`resource_first_byte`、`resource_dns_time`、`resource_download_time`、`resource_first_byte_time`、`resource_connect_time` 等字段。

#### 可能原因

- **连接复用 (Keep-Alive)**  
  当资源请求采用 `keep-alive` 方式保持连接时，DNS 查询和 TCP 连接过程只会在首次请求时发生，后续请求复用同一连接，因此相关数据可能未被记录或为 0。

- **跨域加载资源**  
  如果资源是以跨域的方式加载，且未配置相关头部信息，浏览器无法采集完整的性能数据。这是导致数据缺失的主要原因。

- **浏览器兼容性**  
  极少数情况下，某些浏览器可能不支持 `Performance API`，导致无法获取资源相关的性能数据。

---

### 如何解决跨域资源导致的数据缺失

**1. 资源文件存放在服务器**  
在服务器上为资源文件添加以下 HTTP Header：

```http
Timing-Allow-Origin: *
```

**2. 资源文件存放在 CDN**  
在 CDN 配置中为资源文件添加以下 HTTP Header：

```http
Timing-Allow-Origin: *
```

---

### Resource `resource_status` 数据未采集

在某些情况下，`resource_status` 数据可能缺失，原因如下：

- **跨域加载资源**  
  如果资源以跨域方式加载，且未设置跨域访问权限，浏览器将无法获取资源状态信息。

- **浏览器兼容性**  
  某些浏览器可能不支持 `Performance API`，导致相关数据无法采集（极少见）。

---

### 如何解决跨域资源导致的 `resource_status` 数据缺失

**1. 资源文件存放在服务器**  
在服务器配置中为资源文件添加以下 HTTP Header：

```http
Access-Control-Allow-Origin: *
```

**2. 资源文件存放在 CDN**  
在 CDN 配置中为资源文件添加以下 HTTP Header：

```http
Access-Control-Allow-Origin: *
```

通过以上配置，可以有效解决跨域资源导致的数据采集问题，并确保浏览器能够正确获取性能数据。

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
