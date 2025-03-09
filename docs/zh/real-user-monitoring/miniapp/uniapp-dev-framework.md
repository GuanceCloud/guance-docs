# 基于 Uniapp 开发框架的小程序接入
---

???- quote "更新日志"

    **2022.9.29**：初始化参数新增 `isIntakeUrl` 配置，用于根据请求资源 url 判断是否需要采集对应资源数据，默认都采集。 

	**2022.3.29**：

	-  新增 `traceType` 配置，配置链路追踪工具类型，如果不配置默认为 `ddtrace`。目前支持 `ddtrace`、`zipkin`、`skywalking_v3`、`jaeger`、`zipkin_single_header`、`w3c_traceparent` 6 种数据类型。
	- 新增 `allowedTracingOrigins` 允许注入 trace 采集器所需 header 头部的所有请求列表。可以是请求的origin，也可以是正则。


## 前置条件

- 安装 [DataKit](../../datakit/datakit-install.md)。

## 应用接入

登录<<< custom_key.brand_name >>>控制台，进入**用户访问监测**页面，点击左上角[新建应用](../index.md#create)，即可开始创建一个新的应用。

在右侧，选择安装配置的接入方式，点击右侧的**参数配置**，填入相关配置参数后，即可复制到项目中使用。

![](../img/6.rum_uniapp.png)

## 使用方法

在 Uniapp 项目入口文件 `main.js` 头部位置以如下方式引入代码：

### NPM

=== "VUE 2" 

	引入(可参考 uniapp 官方[npm 引入方式](https://uniapp.dcloud.net.cn/frame?id=npm%e6%94%af%e6%8c%81))
	
	```javascript
	...
	import Vue from 'vue'
	//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
	const { datafluxRum } = require('@cloudcare/rum-uniapp')
	// 初始化 Rum
	datafluxRum.init(Vue, {
	  datakitOrigin: '<DATAKIT ORIGIN>',// 必填，Datakit域名地址 需要在微信小程序管理后台加上域名白名单
      applicationId: '<应用 ID>', // 必填，dataflux 平台生成的应用ID
      env: 'testing', // 选填，小程序的环境
      version: '1.0.0', // 选填，小程序版本
      service: 'miniapp', //当前应用的服务名称
      trackInteractions: true, // 用户行为数据
      sampleRate: 100, //指标数据收集的百分比，100 表示全收集，0 表示不收集
      allowedTracingOrigins: ['https://api.example.com',/https:\/\/.*\.my-api-domain\.com/],  // 非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是正则
	})
	//#endif
	....
	```
=== "VUE 3" 

	引入(可参考 uniapp 官方[npm 引入方式](https://uniapp.dcloud.net.cn/frame?id=npm%e6%94%af%e6%8c%81))
	
	```javascript hl_lines="5"
	...
	//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
	import { datafluxRum } from '@cloudcare/rum-uniapp'
	// 初始化 Rum
	datafluxRum.initVue3({
	  datakitOrigin: '<DATAKIT ORIGIN>',// 必填，Datakit域名地址 需要在微信小程序管理后台加上域名白名单
      applicationId: '<应用 ID>', // 必填，dataflux 平台生成的应用ID
      env: 'testing', // 选填，小程序的环境
      version: '1.0.0', // 选填，小程序版本
      service: 'miniapp', //当前应用的服务名称
      trackInteractions: true, // 用户行为数据
      sampleRate: 100, //指标数据收集的百分比，100 表示全收集，0 表示不收集
      allowedTracingOrigins: ['https://api.example.com',/https:\/\/.*\.my-api-domain\.com/],  // 非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是正则
	})
	//#endif
	....
	```
### CDN

=== "VUE 2" 

	下载文件本地方式引入([下载地址](https://static.<<< custom_key.brand_main_domain >>>/miniapp-sdk/v2/dataflux-rum-uniapp.js))
	
	```javascript
	...
	import Vue from 'vue'
	//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
	const { datafluxRum } = require('./dataflux-rum-miniapp.js'); // js文件本地路径
	// 初始化 Rum
	datafluxRum.init(Vue, {
	  datakitOrigin: '<DATAKIT ORIGIN>',// 必填，Datakit域名地址 需要在微信小程序管理后台加上域名白名单
      applicationId: '<应用 ID>', // 必填，dataflux 平台生成的应用ID
      env: 'testing', // 选填，小程序的环境
      version: '1.0.0', // 选填，小程序版本
      service: 'miniapp', //当前应用的服务名称
      trackInteractions: true, // 用户行为数据
      sampleRate: 100, //指标数据收集的百分比，100 表示全收集，0 表示不收集
      allowedTracingOrigins: ['https://api.example.com',/https:\/\/.*\.my-api-domain\.com/],  // 非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是正则
	})
	//#endif
	....
	```
=== "VUE 3" 

	下载文件本地方式引入([下载地址](https://static.<<< custom_key.brand_main_domain >>>/miniapp-sdk/v2/dataflux-rum-uniapp.js))
	
	```javascript hl_lines="5"
	...
	//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
	import { datafluxRum } from './dataflux-rum-miniapp.js'; // js文件本地路径
	// 初始化 Rum
	datafluxRum.initVue3({
	  datakitOrigin: '<DATAKIT ORIGIN>',// 必填，Datakit域名地址 需要在微信小程序管理后台加上域名白名单
      applicationId: '<应用 ID>', // 必填，dataflux 平台生成的应用ID
      env: 'testing', // 选填，小程序的环境
      version: '1.0.0', // 选填，小程序版本
      service: 'miniapp', //当前应用的服务名称
      trackInteractions: true, // 用户行为数据
      sampleRate: 100, //指标数据收集的百分比，100 表示全收集，0 表示不收集
      allowedTracingOrigins: ['https://api.example.com',/https:\/\/.*\.my-api-domain\.com/],  // 非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是正则
	})
	//#endif
	....
	```

## 配置

### 初始化参数

| 参数                            | 类型    | 是否必须 | 默认值    | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| ------------------------------- | ------- | -------- | --------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                 | String  | 是       |           | 从<<< custom_key.brand_name >>>创建的应用 ID。                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `datakitOrigin`                 | String  | 是       |           | DataKit 数据上报 Origin；<br/>:warning: 需要在小程序管理后台加上 request 白名单。                                                                                                                                                                                                                                                                                                                                                                                                      |
| `env`                           | String  | 否       |           | 小程序应用当前环境，如 prod：线上环境；gray：灰度环境；pre：预发布环境；common：日常环境；local：本地环境。                                                                                                                                                                                                                                                                                  |
| `version`                       | String  | 否       |           | 小程序应用的版本号。                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `service` | String | 否 | | 当前应用的服务名称，默认为 `miniapp`，支持自定义配置。 |
| `sampleRate`                    | Number  | 否       | `100`     | 指标数据收集百分比。                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `100`表示全收集，`0`表示不收集  |         |          |           |                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `trackInteractions`             | Boolean | 否       | `false`   | 是否开启用户行为采集。                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `traceType`                 | Enum    | 否       | `ddtrace` | 配置链路追踪工具类型，如果不配置默认为 `ddtrace`。目前支持 `ddtrace`、`zipkin`、`skywalking_v3`、`jaeger`、`zipkin_single_header`、`w3c_traceparent` 6 种数据类型。<br> :warning: <br>1. `opentelemetry` 支持 `zipkin_single_header`、`w3c_traceparent`、`zipkin`、`jaeger`4 种类型。<br>2. 配置相应类型的 traceType 需要对相应的 API 服务设置不同的 `Access-Control-Allow-Headers`，可参考 [APM 如何关联 RUM](../../application-performance-monitoring/collection/connect-web-app.md)。 |
| `traceId128Bit`              | Boolean | 否       | `false`   | 是否以 128 字节的方式生成 `traceID`，与`traceType` 对应，目前支持类型 `zipkin`、`jaeger`。                                                                                                                                                                                                                                                                                                                                                                                      |
| `allowedTracingOrigins`       | Array   | 否       | [`[]`     | 允许注入 `ddtrace` 采集器所需 header 头部的所有请求列表。可以是请求的 origin，也可以是正则，origin:`协议（包括：//），域名（或IP地址）[和端口号]`。*例如：`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]`*                                                                                                                                                                                                                                          |
| `isIntakeUrl`                                     | Function | 否       | `function(url) {return false}`     | 自定义方法根据请求资源 url 判断是否需要采集对应资源数据，默认都采集。 返回：`false` 表示要采集，`true` 表示不需要采集。 <br>:warning: <br>1. 该参数方法返回结果必须为 Boolean 类型，否则认为是无效参数。<br>2. 版本要求为 2.1.13 及以上。                                                                                                                                                                                                                                    |

**注意**：

1. `datakitOrigin` 所对应的 DataKit 域名必须在小程序管理后台加上 request 白名单。
2. 目前各平台小程序在性能数据  API 暴露这块并没有完善统一，所以导致一些性能数据并不能完善收集，比如`小程序启动`、`小程序包下载`、`脚本注入`等一些数据除微信平台外，都有可能会存在缺失的情况。
3. 目前各平台小程序请求资源 API `uni.request`、`uni.downloadFile` 返回数据中 `profile` 字段目前只有微信小程序 ios 系统不支持返回，所以会导致收集的资源信息中和 timing 相关的数据收集不全。目前暂无解决方案：[request](https://developers.weixin.qq.com/miniprogram/dev/api/network/request/wx.request.html)、[downloadFile](https://developers.weixin.qq.com/miniprogram/dev/api/network/download/wx.downloadFile.html)、[API支持情况](https://developers.weixin.qq.com/community/develop/doc/000ecaa8b580c80601cac8e6f56000?highLine=%2520request%2520profile)。
4. `trackInteractions` 用户行为采集开启后，因为微信小程序的限制，无法采集到控件的内容和结构数据，所以在小程序 SDK 里面我们采取的是声明式编程，通过在板里面设置 data-name 属性，可以给交互元素添加名称，方便后续统计是定位操作记录，例如：

```javascript
 <button bindtap="bindSetData" data-name="setData">setData</button>
```

