# FAQ

## After configuring allowedTracingOrigins, asynchronous requests are cross-origin

To achieve full tracking from the frontend to the backend when using APM (Application Performance Monitoring) tools (commonly referred to as RUM, or Real User Monitoring), you need to configure both the frontend and backend accordingly. Below are the main steps and considerations:

### Frontend Configuration

1. **Install and configure the RUM SDK**:
   - Install the RUM SDK provided by the APM tool in your Web frontend application.
   - Configure the SDK, including setting `allowedTracingOrigins` (domains allowed to send tracing information) and `traceType` (tracing type or framework, such as `ddtrace` for Datadog).

2. **Send tracing information**:
   - The RUM SDK will automatically add necessary tracing information to the headers of requests initiated from the frontend, such as `x-datadog-parent-id`, `x-datadog-origin`, `x-datadog-sampling-priority`, `x-datadog-trace-id`, etc.

### Backend Configuration

1. **Set up CORS policy**:
   - On the backend server, configure the CORS (Cross-Origin Resource Sharing) policy to allow requests from the frontend domain and specifically specify `Access-Control-Allow-Headers` to include all necessary tracing information headers.
   - For example, if your backend uses Node.js and Express framework, you can add the CORS middleware and set the `allowedHeaders` property to include these tracing information headers.

   ```javascript
   const cors = require('cors')
   app.use(
     cors({
       origin: 'https://your-frontend-domain.com', // Replace with your frontend application domain
       allowedHeaders: [
         'x-datadog-parent-id',
         'x-datadog-origin',
         'x-datadog-sampling-priority',
         'x-datadog-trace-id',
         // Possibly other necessary headers
       ],
     })
   )
   ```

2. **Handle requests**:
   - Ensure that the backend service can receive and correctly process these tracing information headers. These details are typically used to associate and track requests within the backend service.

### Verification and Testing

- **Test configuration**:
  - Initiate a request from the frontend to the backend and check the HTTP headers of the network request to ensure that the tracing information is being sent correctly.
  - Review the backend server logs to confirm that the tracing information is being processed correctly.

- **Debugging and correction**:
  - If any issues arise (such as CORS errors, missing headers, etc.), review the configurations on both the frontend and backend and adjust as needed.

### Notes

- **Security**: Ensure that `allowedTracingOrigins` only includes trusted sources to prevent potential Cross-Site Request Forgery (CSRF) attacks.
- **Performance**: Although tracing information is crucial for performance monitoring, ensure that it does not negatively impact the performance of your application.

By following the above steps, you can successfully configure the APM tool to support full tracking from the frontend to the backend, allowing for more effective monitoring and optimization of your Web application's performance.

## Script error occurs

When using <<< custom_key.brand_name >>> Web Rum Sdk to collect Web-side errors, you often see Script error in `js_error`. Such error messages do not contain any detailed information.

:face_with_monocle: Possible reasons for this issue:

1. The browser used by the user does not support error capturing (very rare).
2. The script file is loaded across domains.

For cases where the user's browser does not support it, there is nothing we can do; here we mainly address the reasons and solutions for cross-domain script errors not being collected.

In general, script files are loaded using `<script>` tags. For same-origin scripts, when an error occurs, using the browser's `GlobalEventHandlers API` will collect detailed error information. When different-origin scripts encounter errors, the collected error information only contains the text `Script error.` This is controlled by the browser's same-origin policy and is normal. For non-same-origin scripts, we only need to perform Cross-Origin Resource Sharing (also known as HTTP Access Control / CORS).

:partying_face: Solution:

:material-numeric-1-circle-outline: Script file directly stored on the server:

Add Header when outputting static files on the server:

```
Access-Control-Allow-Origin: *
```

Add attribute `crossorigin="anonymous"` to the `<script>` tag for non-same-origin scripts:

```
<script type="text/javascript" src="path/to/your/script.js" crossorigin="anonymous"></script>
```

:material-numeric-2-circle-outline: Script file stored on CDN:

Add Header in CDN settings:

```
Access-Control-Allow-Origin: *
```

Add attribute `crossorigin="anonymous"` to the `<script>` tag for non-same-origin scripts:

```
<script type="text/javascript" src="path/to/your/script.js" crossorigin="anonymous"></script>
```

:material-numeric-3-circle-outline: Script file loaded from third party:

Add attribute `crossorigin="anonymous"` to the `<script>` tag for non-same-origin scripts:

```
<script type="text/javascript" src="path/to/your/script.js" crossorigin="anonymous"></script>
```

## Incomplete collection of Resource data

The following phenomena may be considered as incomplete collection of resource data:

1. **Resource size related data is 0**
   Including fields such as `resource_transfer_size`, `resource_decode_size`, `resource_encode_size`, `resource_size`.

2. **Time-related data not collected**
   Including fields such as `resource_dns`, `resource_tcp`, `resource_ssl`, `resource_ttfb`, `resource_trans`, `resource_first_byte`, `resource_dns_time`, `resource_download_time`, `resource_first_byte_time`, `resource_connect_time`.

### Possible Reasons

- **Connection reuse (Keep-Alive)**
  When resource requests use the `keep-alive` method to maintain connections, DNS queries and TCP connection processes only occur during the first request. Subsequent requests reuse the same connection, so related data may not be recorded or may be 0.

- **Cross-domain loading resources**
  If resources are loaded across domains and relevant header information is not configured, the browser cannot collect complete performance data. This is the main cause of missing data.

- **Browser compatibility**
  In rare cases, some browsers may not support the `Performance API`, resulting in the inability to obtain resource-related performance data.

---

### How to solve data loss caused by cross-domain resources

**1. Resource files stored on the server**
Add the following HTTP Header for resource files on the server:

```http
Timing-Allow-Origin: *
```

**2. Resource files stored on CDN**
Add the following HTTP Header for resource files in CDN configuration:

```http
Timing-Allow-Origin: *
```

[Reference Document](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceResourceTiming/transferSize)

## Resource `resource_status` data not collected

In some cases, `resource_status` data may be missing due to the following reasons:

- **Cross-domain loading resources**
  If resources are loaded across domains and cross-domain access permissions are not set, the browser will not be able to obtain resource status information.

- **Browser compatibility**
  Some browsers may not support the `Performance API`, leading to the inability to collect related data (very rare).

---

### How to solve `resource_status` data loss caused by cross-domain resources

**1. Resource files stored on the server**
Add the following HTTP Header in the server configuration for resource files:

```http
Access-Control-Allow-Origin: *
```

**2. Resource files stored on CDN**
Add the following HTTP Header in the CDN configuration for resource files:

```http
Access-Control-Allow-Origin: *
```

Through the above configuration, you can effectively solve the problem of data collection caused by cross-domain resources and ensure that the browser can correctly obtain performance data.
[Reference Document](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceResourceTiming/responseStatus).

## Identifying search engine bots {#bot}

When engaging in web activities, it is necessary to distinguish between real user activity and search engines. The following sample script can be used to filter sessions with bots:

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

## More Reading

<font size=2>

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

</font>