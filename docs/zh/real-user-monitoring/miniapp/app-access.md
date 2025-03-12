# 微信小程序应用接入
---


<<< custom_key.brand_name >>>应用监测能够收集各个小程序应用的指标数据，通过引入 SDK 文件，监控小程序性能指标、错误 Log 以及资源请求情况数据，上报到<<< custom_key.brand_name >>>平台后，以可视化的方式分析各个小程序应用端的性能。

## 前置条件

**注意**：若您开通了 [RUM Headless](../../dataflux-func/headless.md) 服务，前置条件已自动帮您配置完成，直接接入应用即可。

- 安装 [DataKit](../../datakit/datakit-install.md)；  
- 配置 [RUM 采集器](../../integrations/rum.md)；
- DataKit 配置为[公网可访问，并且安装 IP 地理信息库](../../datakit/datakit-tools-how-to.md#install-ipdb)。

## 应用接入

登录<<< custom_key.brand_name >>>控制台，进入**用户访问监测**页面，点击左上角 **[新建应用](../index.md#create)**，即可开始创建一个新的应用。

![](../img/6.rum_miniapp.png)

## 使用方法

在小程序的 app.js 文件以如下方式引入代码：

**注意**：引入位置需要在 App() 初始化之前。

=== "NPM" 

	NPM 包引入方式可参考微信官方 [npm 引入方式](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)
	
	```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')
    // 初始化 Rum
    datafluxRum.init({
      datakitOrigin: '<DATAKIT ORIGIN>',// 必填，Datakit域名地址 需要在微信小程序管理后台加上域名白名单
      applicationId: '<应用 ID>', // 必填，dataflux 平台生成的应用ID
      env: 'testing', // 选填，小程序的环境
      version: '1.0.0', // 选填，小程序版本
      service: 'miniapp', //当前应用的服务名称
      trackInteractions: true,
      traceType: 'ddtrace', // 非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6种类型
      allowedTracingOrigins: ['https://api.example.com',/https:\/\/.*\.my-api-domain\.com/],  // 非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是正则
    })
	```

=== "CDN" 

	[下载文件](https://static.<<< custom_key.brand_main_domain >>>/miniapp-sdk/v2/dataflux-rum-miniapp.js)本地方式引入
	
	```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    // 初始化 Rum
    datafluxRum.init({
      datakitOrigin: '<DATAKIT ORIGIN>',// 必填，Datakit域名地址 需要在微信小程序管理后台加上域名白名单
      applicationId: '<应用 ID>', // 必填，dataflux 平台生成的应用ID
      env: 'testing', // 选填，小程序的环境
      version: '1.0.0', // 选填，小程序版本
      service: 'miniapp', //当前应用的服务名称
      trackInteractions: true,
      traceType: 'ddtrace', // 非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6种类型
      allowedTracingOrigins: ['https://api.example.com',/https:\/\/.*\.my-api-domain\.com/],  // 非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是正则
    })
	```

## 配置

### 初始化参数

| 参数                            | 类型    | 是否必须 | 默认值    | 描述                                                         |
| ------------------------------- | ------- | -------- | --------- | ------------------------------------------------------------ |
| `applicationId`                 | String  | 是       |           | 从<<< custom_key.brand_name >>>创建的应用 ID。                                    |
| `datakitOrigin`                 | String  | 是       |           | DataKit 数据上报 Origin；<br/>:warning: 需要在小程序管理后台加上 request 白名单。 |
| `env`                           | String  | 否       |           | 小程序应用当前环境，如 prod：线上环境；gray：灰度环境；pre：预发布环境；common：日常环境；local：本地环境。 |
| `version`                       | String  | 否       |           | 小程序应用的版本号。                                          |
| `service` | String | 否 | | 当前应用的服务名称，默认为 `miniapp`，支持自定义配置。 |
| `sampleRate`                    | Number  | 否       | `100`     | 指标数据收集百分比：`100` 表示全收集，`0` 表示不收集。            |
| `trackInteractions`             | Boolean | 否       | `false`   | 是否开启用户行为采集。                                         |
| `traceType`                    | Enum    | 否       | `ddtrace` | 配置链路追踪工具类型，如果不配置默认为 `ddtrace`。目前支持 `ddtrace`、`zipkin`、`skywalking_v3`、`jaeger`、`zipkin_single_header`、`w3c_traceparent` 6 种数据类型。<br> :warning: <br>1. `opentelemetry` 支持 `zipkin_single_header`、`w3c_traceparent`、`zipkin`、`jaeger` 4 种类型。<br>2. 配置相应类型的 traceType 需要对相应的 API 服务 设置不同的 `Access-Control-Allow-Headers`，可参考 [APM 如何关联 RUM ](../../application-performance-monitoring/collection/connect-web-app.md)。 |
| `traceId128Bit`                | Boolean | 否       | `false`   | 是否以 128 字节的方式生成 `traceID`，与`traceType` 对应，目前支持类型 `zipkin`、`jaeger`。 |
| `allowedTracingOrigins`        | Array   | 否       | `[]`      | 【新增】允许注入 `ddtrace` 采集器所需 header 头部的所有请求列表。可以是请求的 origin，也可以是正则，origin:`协议（包括：//），域名（或IP地址）[和端口号]`。*例如：`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]`* |
| `isIntakeUrl`                 | Function | 否       | `function(url) {return false}`     | 自定义方法根据请求资源 url 判断是否需要采集对应资源数据，默认都采集。返回：`false` 表示要采集，`true` 表示不需要采集。<br>:warning: <br>1. 该参数方法返回结果必须为 Boolean 类型，否则认为是无效参数。<br>2. 版本要求为 2.1.10 及以上。 |

## 注意

1. `datakitOrigin` 所对应的 DataKit 域名必须在小程序管理后台加上 request 白名单。
1. 因为目前微信小程序请求资源 API `wx.request`、`wx.downloadFile` 返回数据中 `profile` 字段目前 ios 系统不支持返回，所以会导致收集的资源信息中和 timing 相关的数据收集不全。目前暂无解决方案：[request](https://developers.weixin.qq.com/miniprogram/dev/api/network/request/wx.request.html)、[downloadFile](https://developers.weixin.qq.com/miniprogram/dev/api/network/download/wx.downloadFile.html)、[API 支持情况](https://developers.weixin.qq.com/community/develop/doc/000ecaa8b580c80601cac8e6f56000?highLine=%2520request%2520profile)。
1. `trackInteractions` 用户行为采集开启后，因为微信小程序的限制，无法采集到控件的内容和结构数据，所以在小程序 SDK 里面我们采取的是声明式编程，通过在 wxml 文件里面设置 data-name 属性，可以给交互元素添加名称，方便后续统计是定位操作记录， 例如：

```javascript
 <button bindtap="bindSetData" data-name="setData">setData</button>
```

