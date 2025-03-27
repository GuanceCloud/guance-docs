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

### SDK 配置

| 接入方式     | 说明                                                                                         |
| ------------ | -------------------------------------------------------------------------------------------- |
| NPM          | 将 SDK 代码打包到前端项目中，确保前端性能不受影响，但可能错过 SDK 初始化前的请求和错误收集。 |
| CDN 异步加载 | 通过 CDN 异步引入 SDK 脚本，不影响页面加载性能，但可能错过初始化前的请求和错误收集。         |
| CDN 同步加载 | 通过 CDN 同步引入 SDK 脚本，能收集所有错误和性能指标，但可能影响页面加载性能。               |

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
        'https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js',
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
    <script src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js" type="text/javascript"></script>
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
| `applicationId`                        | String                              | 是                                      |                                       | 从<<< custom_key.brand_name >>>创建的应用 ID。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `datakitOrigin`                        | String                              | 是                                      |                                       | DataKit 数据上报 Origin 注释: <br>`协议（包括：//），域名（或IP地址）[和端口号]`<br> 例如：<br>[https://www.datakit.com](https://www.datakit.com)；<br>[http://100.20.34.3:8088](http://100.20.34.3:8088)。                                                                                                                                                                                                                                                                                                                                                   |
| `clientToken`                          | String                              | 是                                      |                                       | 以 openway 方式上报数据令牌，从<<< custom_key.brand_name >>>控制台获取，必填（公共 openway 方式接入）。                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| `site`                                 | String                              | 是                                      |                                       | 以 公共 openway 方式上报数据地址，从<<< custom_key.brand_name >>>控制台获取，必填（公共 openway 方式接入）。                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `env`                                  | String                              | 否                                      |                                       | Web 应用当前环境，如 prod：线上环境；gray：灰度环境；pre：预发布环境；common：日常环境；local：本地环境。                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `version`                              | String                              | 否                                      |                                       | Web 应用的版本号。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `service`                              | String                              | 否                                      |                                       | 当前应用的服务名称，默认为 `browser`，支持自定义配置。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `sessionSampleRate`                    | Number                              | 否                                      | `100`                                 | 指标数据收集百分比：<br>`100` 表示全收集；`0` 表示不收集。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `sessionOnErrorSampleRate`             | Number                              | 否                                      | `0`                                   | 错误会话补偿采样率：当会话未被 `sessionSampleRate` 采样时，若会话期间发生错误，则按此比例采集。此类会话将在错误发生时开始记录事件，并持续记录直到会话结束。SDK 版本要求`>= 3.2.19`                                                                                                                                                                                                                                                                                                                                                                            |
| `sessionReplaySampleRate`              | Number                              | 否                                      | `100`                                 | [Session Replay](../session-replay/replay.md#config) 数据采集百分比: <br>`100` 表示全收集；`0` 表示不收集。                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `sessionReplayOnErrorSampleRate`       | Number                              | 否                                      | `0`                                   | [Session Replay](../session-replay/replay.md#config) 错误会话重放补偿采样率：当会话未被 `sessionReplaySampleRate` 采样时，若会话期间发生错误，则按此比例采集。此类回放将记录错误发生前最多一分钟的事件，并持续记录直到会话结束。SDK 版本要求`>= 3.2.19`                                                                                                                                                                                                                                                                                                       |
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
