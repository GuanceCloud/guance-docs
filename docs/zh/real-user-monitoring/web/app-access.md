# Web 应用接入
---

???- quote "更新日志"

    **2022.9.29**：初始化参数新增 `isIntakeUrl` 配置，用于根据请求资源 url 判断是否需要采集对应资源数据，默认都采集。 

    **2022.3.10**：

    - 新增 `traceType` 配置链路追踪工具类型，如果不配置，默认为`ddtrace`。目前支持 6 种数据类型：`ddtrace`、`zipkin`、`skywalking_v3`、`jaeger`、`zipkin_single_header`、`w3c_traceparent`。
    - 新增 `allowedTracingOrigins` 允许注入 trace 采集器所需 header 头部的所有请求列表。可以是请求的 origin，也可以是正则。
    - 原配置项 `allowedDDTracingOrigins` 与新增配置项 `allowedTracingOrigins` 属于同一个功能配置。两者可以任取其一配置，如果两者都配置，则 `allowedTracingOrigins` 的权重高于`allowedDDTracingOrigins`。

    **2021.5.20**：

    - 配合 V2 版本指标数据变更，需要升级 DataKit 1.1.7-rc0之后的版本。更多详情，可参考 [DataKit 配置](../../integrations/rum.md)。 
    - SDK 升级 V2 版本，CDN 地址变更为 `https://static.guance.com/browser-sdk/v2/dataflux-rum.js`。
    - 删除 `rum_web_page_performance`、`rum_web_resource_performance`、` js_error`、`page` 指标数据收集，新增 `view`, `action`, `long_task`, `error` 指标数据采集。
    - 初始化新增 `trackInteractions` 配置，用于开启 Action（用户行为数据）采集，默认为关闭状态。


观测云应用监测能够通过收集各个 Web 应用的指标数据，以可视化的方式分析各个 Web 应用端的性能。

## 前置条件

**注意**：若您开通了 [RUM Headless](../../dataflux-func/headless.md) 服务，前置条件已自动帮您配置完成，直接接入应用即可。

- 安装 [DataKit](../../datakit/datakit-install.md)；  
- 配置 [RUM 采集器](../../integrations/rum.md)；
- DataKit 配置为[公网可访问，并且安装 IP 地理信息库](../../datakit/datakit-tools-how-to.md#install-ipdb)。

  
## 应用接入 {#access}

登录观测云控制台，进入**用户访问监测**页面，点击左上角 **[新建应用](../index.md#create)**，即可开始创建一个新的应用。
<///
- 观测云提供**公网 DataWay**直接接收 RUM 数据，无需安装 DataKit 采集器。配置 `site` 和 `clientToken` 参数即可。

支持在控制台中直接上传 SourceMap，可以基于不同的版本和环境上传多个文件。

![](../img/web_01.png)

- 观测云同时支持**本地环境部署**接收 RUM 数据，该方式需满足前置条件。
///>
![](../img/6.rum_web.png)

Web 应用接入的有三种方式：NPM 接入、同步载入和异步载入。

| 接入方式     | 简介                                                                                                                                                             |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM          | 通过把 SDK 代码一起打包到前端项目中，此方式可以确保对前端页面的性能不会有任何影响，不过可能会错过 SDK 初始化之前的的请求、错误的收集。                       |
| CDN 异步加载 | 通过 CDN 加速缓存，以异步脚本引入的方式，引入 SDK 脚本，此方式可以确保 SDK 脚本的下载不会影响页面的加载性能，不过可能会错过 SDK 初始化之前的的请求、错误的收集。 |
| CDN 同步加载 | 通过 CDN 加速缓存，以同步脚本引入的方式，引入 SDK 脚本，此方式可以确保能够收集到所有的错误，资源，请求，性能指标。不过可能会影响页面的加载性能。                 |

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    
    datafluxRum.init({
      applicationId: 'guance',
      datakitOrigin: '<DATAKIT ORIGIN>', // 协议（包括：//），域名（或IP地址）[和端口号]
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
          datakitOrigin: '<DATAKIT ORIGIN>', // 协议（包括：//），域名（或IP地址）[和端口号]
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
          datakitOrigin: '<DATAKIT ORIGIN>', //协议（包括：//），域名（或IP地址）[和端口号]
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

| 参数                           | <div style="width: 60px">类型</div>     | <div style="width: 60px">是否必须</div> | <div style="width: 60px">默认值</div>                             | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ------------------------------ | -------- | -------- | ---------------------------------- | ----------------------------------------------------------------- |
| `applicationId`                | String   | 是       |                                    | 从观测云创建的应用 ID。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `datakitOrigin`                | String   | 是       |                                    | DataKit 数据上报 Origin 注释: <br>`协议（包括：//），域名（或IP地址）[和端口号]`<br> 例如：<br>[https://www.datakit.com](https://www.datakit.com)；<br>[http://100.20.34.3:8088](http://100.20.34.3:8088)。                                                                                                                                                                                                                                                                                                                                                           |
| `env`                          | String   | 否       |                                    | Web 应用当前环境，如 prod：线上环境；gray：灰度环境；pre：预发布环境；common：日常环境；local：本地环境。                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `version`                      | String   | 否       |                                    | Web 应用的版本号。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `service` | String | 否 | | 当前应用的服务名称，默认为 `browser`，支持自定义配置。 |
| `sessionSampleRate`                   | Number   | 否       | `100`                              | 指标数据收集百分比：<br>`100` 表示全收集；`0` 表示不收集。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `sessionReplaySampleRate`                   | Number   | 否       | `100`                              | [Session Replay](../session-replay/replay.md) 数据采集百分比: <br>`100` 表示全收集；`0` 表示不收集。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `trackSessionAcrossSubdomains` | Boolean  | 否       | `false`                            | 同一个域名下面的子域名共享缓存。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `traceType`                    | Enum     | 否       | `ddtrace`                          | 配置链路追踪工具类型，如果不配置默认为 `ddtrace`。目前支持 `ddtrace`、`zipkin`、`skywalking_v3`、`jaeger`、`zipkin_single_header`、`w3c_traceparent` 6 种数据类型。<br><br>:warning: <br>1. `opentelemetry` 支持 `zipkin_single_header`、`w3c_traceparent`、`zipkin`、`jaeger` 4 种类型。<br>2. 该配置的生效需依赖 `allowedTracingOrigins` 配置项。<br>3. 配置相应类型的 traceType 需要对相应的 API 服务。关于设置不同的 `Access-Control-Allow-Headers`，可参考 [APM 如何关联 RUM ](../../application-performance-monitoring/collection/connect-web-app.md)。 |
| `traceId128Bit`                | Boolean  | 否       | `false`                            | 是否以 128 字节的方式生成 `traceID`，与 `traceType` 对应，目前支持类型 `zipkin`、`jaeger`。                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `allowedDDTracingOrigins`      | Array    | 否       | `[]`                               | 【不建议使用】允许注入 `trace` 采集器所需 header 头部的所有请求列表。可以是请求的 origin，也可以是正则，origin:`协议（包括：//），域名（或IP地址）[和端口号]`。*例如：`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]`。*                                                                                                                                                                                                                                                                                                 |
| `allowedTracingOrigins`        | Array    | 否       | `[]`                               | 允许注入 `trace` 采集器所需 header 头部的所有请求列表。可以是请求的 origin，也可以是正则，origin: `协议（包括：//），域名（或IP地址）[和端口号]`。*例如：<br>`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]`。*                                                                                                                                                                                                                                                                                                                           |
| `trackInteractions`            | Boolean  | 否       | `false`                            | 是否开启用户行为采集。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `isServerError`                | Function | 否       | `function(request) {return false}` | 默认情况下，请求如果 `status code>= 500` 则定义为错误请求，会相应地采集为 error 指标数据。为满足部分场景可能并非是通过 status code 来判断业务请求的错误情况，提供可通过用户自定义的方式来判断请求是否为`error`请求，callback 参数为请求对应的相关返回参数：`{ isAborted: false, method:"get",response: "{...}",status: 200,url: "xxxx" }`，如果方法返回为 true，则该请求相关数据会被采集为 `error` 指标 <br>:warning: 该参数方法返回结果必须为 Boolean 类型，否则认为是无效参数。                                                                                                  |
| `isIntakeUrl`                    | Function | 否       | `function(url) {return false}`     | 自定义方法根据请求资源 url 判断是否需要采集对应资源数据，默认都采集。 返回：`false` 表示要采集，`true` 表示不需要采集。 <br>:warning: <br>1. 该参数方法返回结果必须为 Boolean 类型，否则认为是无效参数。<br/>2. 版本要求为 v2.1.5 及以上。                                                |
| `storeContextsToLocal`                    | Boolean | 否       |                                     |版本要求:`>3.1.2`。是否把用户自定义数据缓存到本地 localstorage，例如： `setUser`, `addGlobalContext` api 添加的自定义数据。                                                |
| `sendContentTypeByJson`            | Boolean | 否       |                                    | 版本要求:`>3.1.2`。是否以 json 的方式发送数据，即 write/rum 请求发送 `content-type: application/json` |

## FAQ

### 产生 Script error

在使用观测云 Web Rum Sdk 进行 Web 端错误收集的时候，经常会在 `js_error` 中看到 Script error。这样的错误信息并没有包含任何详细信息。

:face_with_monocle: 可能出现上面问题的原因：

1. 用户使用的浏览器不支持错误的捕获 (概率极小)。
2. 出错的脚本文件是跨域加载到页面的。

对于用户浏览器不支持的情况，这种我们是无法处理的；这里主要解决跨域脚本错误无法收集的原因和解决方案。

一般情况下脚本文件是使用 `<script>` 标签加载，对于同源脚本出错，在使用浏览器的 `GlobalEventHandlers API` 时，收集到的错误信息会包含详细的错误信息；当不同源脚本出错时，收集到的错误信息只有 `Script error.` 文本，这是由浏览器的同源策略控制的，也是正常的情况。对于非同源脚本我们只需要进行非同源资源共享（也称 HTTP访问控制 / CORS）的操作即可。

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

资源数据包含ssl、tcp、dns、trans、ttfb。在数据上报过程中，部分资源 timing 数据有可能收集不完整。比如 tcp、dns 数据没有收集上报。

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


