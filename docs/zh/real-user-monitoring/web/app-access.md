# Web 应用接入
---

## 更新日志
2022.9.29

- 初始化参数新增 `isIntakeUrl` 配置，用于根据请求资源 url 判断是否需要采集对应资源数据，默认都采集。 

2022.3.10

-   新增  `traceType` 配置，配置链路追踪工具类型，如果不配置默认为`ddtrace`。目前支持 `ddtrace`、`zipkin`、`skywalking_v3`、`jaeger`、`zipkin_single_header`、`w3c_traceparent` 6种数据类型。
- 新增 `allowedTracingOrigins` 允许注入 trace 采集器所需header头部的所有请求列表。可以是请求的origin，也可以是是正则。
- 原配置项 `allowedDDTracingOrigins` 与 新增配置项 `allowedTracingOrigins`属于同一个功能配置。两者可以任取其一配置，如果两者都配置则`allowedTracingOrigins` 的权重高于`allowedDDTracingOrigins` 。

2021.5.20 

-  配合V2 版本指标数据变更，需要升级 DataKit 1.1.7-rc0之后的版本 参考 [DataKit配置](../../integrations/rum.md) 。 
-  SDK升级V2版本，CDN地址变更为 `https://static.guance.com/browser-sdk/v2/dataflux-rum.js`。
- 删除 `rum_web_page_performance`,  `rum_web_resource_performance`,` js_error`, `page` 指标数据收集，新增 `view`, `action`, `long_task`, `error` 指标数据采集。
- 初始化新增 `trackInteractions` 配置，用于开启action（用户行为数据）采集，默认关闭状态。

## 简介

观测云应用监测能够通过收集各个Web应用的指标数据，以可视化的方式分析各个Web应用端的性能。

## 前置条件

- 安装 [DataKit](../../datakit/datakit-install.md)；  
- 配置 [RUM 采集器](../../integrations/rum.md)；
- DataKit 配置为[公网可访问，并且安装 IP 地理信息库](../../datakit/datakit-tools-how-to.md#install-ipdb)。

  
## Web 应用接入

登录观测云控制台，进入**用户访问监测**页面，点击左上角 **[新建应用](../index.md#create)**，即可开始创建一个新的应用。


![](../img/6.rum_web.gif)

Web 应用接入的有三种方式：NPM 接入、同步载入和异步载入。

| 接入方式     | 简介                                                                                                                                                             |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM          | 通过把 SDK 代码一起打包到你的前端项目中，此方式可以确保对前端页面的性能不会有任何影响，不过可能会错过 SDK 初始化之前的的请求、错误的收集。                       |
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
      allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // 非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是是正则
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
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // 非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是是正则
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
          allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  //非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是是正则
        })
    </script>
    ```

## 配置 {#config}

### 初始化参数

| 参数                           | 类型     | 是否必须 | 默认值                             | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ------------------------------ | -------- | -------- | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                | String   | 是       |                                    | 从观测云创建的应用 ID                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `datakitOrigin`                | String   | 是       |                                    | datakit 数据上报 Origin 注释: <br>`协议（包括：//），域名（或IP地址）[和端口号]`<br> 例如：<br>[https://www.datakit.com](https://www.datakit.com), <br>[http://100.20.34.3:8088](http://100.20.34.3:8088)                                                                                                                                                                                                                                                                                                                                                           |
| `env`                          | String   | 否       |                                    | web 应用当前环境， 如 prod：线上环境；gray：灰度环境；pre：预发布环境 common：日常环境；local：本地环境；                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `version`                      | String   | 否       |                                    | web 应用的版本号                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `service` | String | 否 | | 当前应用的服务名称，默认为 `browser`，支持自定义配置。 |
| `sessionSampleRate`                   | Number   | 否       | `100`                              | 指标数据收集百分比: <br>`100`<br>表示全收集，<br>`0`<br>表示不收集                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `sessionReplaySampleRate`                   | Number   | 否       | `100`                              | [Session Replay](../session-replay/replay.md) 数据采集百分比: <br>`100`<br>表示全收集，<br>`0`<br>表示不收集                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `trackSessionAcrossSubdomains` | Boolean  | 否       | `false`                            | 同一个域名下面的子域名共享缓存                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `traceType`                    | Enum     | 否       | `ddtrace`                          | 【新增】配置链路追踪工具类型，如果不配置默认为`ddtrace`。目前支持 `ddtrace`、`zipkin`、`skywalking_v3`、`jaeger`、`zipkin_single_header`、`w3c_traceparent` 6 种数据类型。注： `opentelemetry` 支持 `zipkin_single_header`,`w3c_traceparent`,`zipkin`、`jaeger`4 种类型。<br><br>注意：1.该配置的生效，需要依赖 allowedTracingOrigins 配置项。2.配置相应类型的traceType 需要对相应的API服务 设置不同的 Access-Control-Allow-Headers 具体查看 APM 如何关联 RUM，具体查看 [APM 如何关联 RUM ](../../application-performance-monitoring/collection/connect-web-app.md) |
| `traceId128Bit`                | Boolean  | 否       | `false`                            | 是否以128字节的方式生成 `traceID`，与`traceType` 对应，目前支持类型 `zipkin`、`jaeger`                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `allowedDDTracingOrigins`      | Array    | 否       | `[]`                               | 【不建议使用】允许注入`trace`采集器所需header头部的所有请求列表。可以是请求的origin，也可以是是正则，origin:`协议（包括：//），域名（或IP地址）[和端口号]`<br> 例如：<br>`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]`                                                                                                                                                                                                                                                                                                                      |
| `allowedTracingOrigins`        | Array    | 否       | `[]`                               | 【新增】允许注入`trace`采集器所需header头部的所有请求列表。可以是请求的origin，也可以是是正则，origin: `协议（包括：//），域名（或IP地址）[和端口号]`<br> 例如：<br>`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]`                                                                                                                                                                                                                                                                                                                           |
| `trackInteractions`            | Boolean  | 否       | `false`                            | 是否开启用户行为采集                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `isServerError`                | Function | 否       | `function(request) {return false}` | 默认情况下，请求如果status code>= 500 则定义为错误请求，会相应的采集为error 指标数据。为满足部分场景可能并非是通过status code 来判断业务请求的错误情况，提供可通过用户自定义的方式来判断请求是否为`error`请求，callback参数为请求对应的相关返回参数： `{ isAborted: false, method:"get",response: "{...}",status: 200,url: "xxxx" }`, 如果方法返回为true，则该请求相关数据会被采集为`error`指标 <br>*该参数 方法返回结果必须为Boolean 类型， 否则认为是无效参数*                                                                                                    |
| `isIntakeUrl`                    | Function | 否       | `function(url) {return false}`     | 自定义方法根据请求资源 url 判断是否需要采集对应资源数据，默认都采集。 返回：`false` 表示要采集，`true` 表示不需要采集 <br>*该参数 方法返回结果必须为 Boolean 类型， 否则认为是无效参数*<br/>**注意：版本要求为 v2.1.5 及以上**                                                 |

## 问题

### 产生 Script error 消息的原因

在使用观测云 Web Rum Sdk 进行 Web 端错误收集的时候，经常会在`js_error`中看到 Script error. 这样的错误信息，同时并没有包含任何详细信息。

#### 可能出现上面问题的原因

1. 用户使用的浏览器不支持错误的捕获 (概率极小)。
2. 出错的脚本文件是跨域加载到页面的。
对于用户浏览器不支持的情况，这种我们是无法处理的；这里主要解决跨域脚本错误无法收集的原因和解决方案。

一般情况下脚本文件是使用 `<script>` 标签加载，对于同源脚本出错，在使用浏览器的 `GlobalEventHandlers API` 时，收集到的错误信息会包含详细的错误信息；当不同源脚本出错时，收集到的错误信息只有 `Script error.` 文本，这是由浏览器的同源策略控制的，也是正常的情况。对于非同源脚本我们只需要进行非同源资源共享（也称 HTTP访问控制 / CORS）的操作即可。

### 解决方法

#### 1.脚本文件直接存放在服务器

在服务器上静态文件输出时添加 Header

```
Access-Control-Allow-Origin: *
```

在非同源脚本所在的 Script 标签上添加属 crossorigin="anonymous"

```
<script type="text/javascript" src="path/to/your/script.js" crossorigin="anonymous"></script>
```

#### 2.脚本文件存放 CDN 上

在 CDN 设置中添加 Header

```
Access-Control-Allow-Origin: *
```

在非同源脚本所在的 Script 标签上添加属 crossorigin="anonymous"

```
<script type="text/javascript" src="path/to/your/script.js" crossorigin="anonymous"></script>
```

#### 3. 脚本文件从第三方加载

在非同源脚本所在的 Script 标签上添加属 crossorigin="anonymous"

```
<script type="text/javascript" src="path/to/your/script.js" crossorigin="anonymous"></script>
```

### 参考及扩展阅读

[GlobalEventHandlers.onerror](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onerror)

[Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)

[The Script element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script)

[CORS settings attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/CORS_settings_attributes)

### 资源数据(ssl, tcp, dns, trans,ttfb)收集不完整问题

在数据上报过程中，部分资源timing数据有可能收集不完整。比如tcp，dns数据没有收集上报。

### 出现上面问题原因

1. 比如dns数据没有收集到，有可能是您应用的这个资源请求是以`keep-alive`保持链接的，这种情况只有在你第一次请求的时候，会有创建链接的过程，之后的请求都会保持同一连接，不会再重新创建tcp连接。所以会出现dns数据没有的情况，或者数据为`0`。
2. 应用的资源是以跨域的形式加载到页面的，和你的网站并非是同源（主要原因）。
3. 浏览器不支持`Performance API`(极少数情况)

### 针对跨域资源的问题 {#header}

#### 1.资源文件直接存放在服务器

在服务器上资源文件输出时添加 Header

```
Timing-Allow-Origin: *
```

#### 2.资源文件存放 CDN 上

在 CDN 设置中添加 Header

```
Timing-Allow-Origin: *
```

### 参考以及拓展

[Coping_with_CORS](https://developer.mozilla.org/en-US/docs/Web/API/Resource_Timing_API/Using_the_Resource_Timing_API#Coping_with_CORS)

[Resource Timing Standard; W3C Editor's Draft](https://w3c.github.io/resource-timing/)

[Resource Timing practical tips; Steve Souders](http://www.stevesouders.com/blog/2014/08/21/resource-timing-practical-tips/)

[Measuring network performance with Resource Timing API](http://googledevelopers.blogspot.ca/2013/12/measuring-network-performance-with.html)

