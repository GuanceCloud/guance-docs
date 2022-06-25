# 基于uniapp开发框架的小程序接入
---

## 更新日志
2022.3.29

-   新增  `traceType` 配置，配置链路追踪工具类型，如果不配置默认为`ddtrace`。目前支持 `ddtrace`、`zipkin`、`skywalking_v3`、`jaeger`、`zipkin_single_header`、`w3c_traceparent` 6种数据类型。
- 新增 `allowedTracingOrigins` 允许注入 trace 采集器所需header头部的所有请求列表。可以是请求的origin，也可以是是正则。

通过引入 sdk 文件，监控小程序性能指标，错误 log，以及资源请求情况数据，上报到 DataFlux 平台。

## 使用方法

### 在uniapp项目入口文件`main.js`文件头部位置以如下方式引入代码

### NPM

=== "VUE 2" 

	引入(可参考uniapp官方[npm引入方式](https://uniapp.dcloud.net.cn/frame?id=npm%e6%94%af%e6%8c%81))

	```javascript
	...
	import Vue from 'vue'
	//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
	const { datafluxRum } = require('@cloudcare/rum-uniapp')
	// 初始化 Rum
	datafluxRum.init(Vue, {
		datakitOrigin: 'https://datakit.xxx.com/',// 必填，Datakit域名地址 需要在微信小程序管理后台加上域名白名单
		applicationId: 'appid_xxxxxxx', // 必填，dataflux 平台生成的应用ID
		env: 'testing', // 选填，小程序的环境
		version: '1.0.0', // 选填，小程序版本
		trackInteractions: true, // 用户行为数据
	})
	//#endif
	....
	```
=== "VUE 3" 

	引入(可参考uniapp官方[npm引入方式](https://uniapp.dcloud.net.cn/frame?id=npm%e6%94%af%e6%8c%81))

	```javascript hl_lines="5"
	...
	//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
	import { datafluxRum } from '@cloudcare/rum-uniapp'
	// 初始化 Rum
	datafluxRum.initVue3({
		datakitOrigin: 'https://datakit.xxx.com/',// 必填，Datakit域名地址 需要在微信小程序管理后台加上域名白名单
		applicationId: 'appid_xxxxxxx', // 必填，dataflux 平台生成的应用ID
		env: 'testing', // 选填，小程序的环境
		version: '1.0.0', // 选填，小程序版本
		trackInteractions: true, // 用户行为数据
	})
	//#endif
	....
	```
### CDN

=== "VUE 2" 

	下载文件本地方式引入([下载地址](https://static.dataflux.cn/miniapp-sdk/v2/dataflux-rum-uniapp.js))

	```javascript
	...
	import Vue from 'vue'
	//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
	const { datafluxRum } = require('./dataflux-rum-miniapp.js'); // js文件本地路径
	// 初始化 Rum
	datafluxRum.init(Vue, {
		datakitOrigin: 'https://datakit.xxx.com/',// 必填，Datakit域名地址 需要在微信小程序管理后台加上域名白名单
		applicationId: 'appid_xxxxxxx', // 必填，dataflux 平台生成的应用ID
		env: 'testing', // 选填，小程序的环境
		version: '1.0.0', // 选填，小程序版本
		trackInteractions: true, // 用户行为数据
	})
	//#endif
	....
	```
=== "VUE 3" 

	下载文件本地方式引入([下载地址](https://static.dataflux.cn/miniapp-sdk/v2/dataflux-rum-uniapp.js))

	```javascript hl_lines="5"
	...
	//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
	import { datafluxRum } from './dataflux-rum-miniapp.js'; // js文件本地路径
	// 初始化 Rum
	datafluxRum.initVue3({
		datakitOrigin: 'https://datakit.xxx.com/',// 必填，Datakit域名地址 需要在微信小程序管理后台加上域名白名单
		applicationId: 'appid_xxxxxxx', // 必填，dataflux 平台生成的应用ID
		env: 'testing', // 选填，小程序的环境
		version: '1.0.0', // 选填，小程序版本
		trackInteractions: true, // 用户行为数据
	})
	//#endif
	....
	```

## 配置

### 初始化参数

| 参数                            | 类型    | 是否必须 | 默认值    | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| ------------------------------- | ------- | -------- | --------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                 | String  | 是       |           | 从 dataflux 创建的应用 ID                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `datakitOrigin`                 | String  | 是       |           | datakit 数据上报 Origin;`注意：需要在小程序管理后台加上request白名单`                                                                                                                                                                                                                                                                                                                                                                                                       |
| `env`                           | String  | 否       |           | 小程序 应用当前环境， 如 prod：线上环境；gray：灰度环境；pre：预发布环境 common：日常环境；local：本地环境；                                                                                                                                                                                                                                                                                                                                                                |
| `version`                       | String  | 否       |           | 小程序 应用的版本号                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `sampleRate`                    | Number  | 否       | `100`     | 指标数据收集百分比:                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `100`表示全收集，`0`表示不收集  |         |          |           |                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `trackInteractions`             | Boolean | 否       | `false`   | 是否开启用户行为采集                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `traceType`【新增】             | Enum    | 否       | `ddtrace` | 配置链路追踪工具类型，如果不配置默认为`ddtrace`。目前支持 `ddtrace`、`zipkin`、`skywalking_v3`、`jaeger`、`zipkin_single_header`、`w3c_traceparent` 6种数据类型。注： `opentelemetry` 支持 `zipkin_single_header`,`w3c_traceparent`,`zipkin`、`jaeger`三种类型。<br><br>注意：配置相应类型的traceType 需要对相应的API服务 设置不同的 `Access-Control-Allow-Headers` 具体查看 [APM 如何关联 RUM ](../../../application-performance-monitoring/collection/connect-web-app.md) |
| `traceId128Bit`【新增】         | Boolean | 否       | `false`   | 是否以128字节的方式生成 `traceID`，与`traceType` 对应，目前支持类型 `zipkin`、`jaeger`                                                                                                                                                                                                                                                                                                                                                                                      |
| `allowedTracingOrigins`【新增】 | Array   | 否       | [`[]`     | 允许注入`ddtrace`采集器所需header头部的所有请求列表。可以是请求的origin，也可以是是正则，origin: `协议（包括：//），域名（或IP地址）[和端口号]`<br>例如：<br>`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]`                                                                                                                                                                                                                                          |

## 注意事项

1. `datakitOrigin` 所对应的datakit域名必须在小程序管理后台加上request白名单
2. 目前各平台小程序在性能数据api暴露这块，并没有完善统一，所以导致一些性能数据并不能完善收集，比如`小程序启动`、`小程序包下载`、`脚本注入` 等一些数据除微信平台外，都有可能会存在缺失的情况。
3. 目前各平台小程序请求资源API`uni.request`、`uni.downloadFile`返回数据中`profile`字段目前只有微信小程序ios系统不支持返回，所以会导致收集的资源信息中和timing相关的数据收集不全。目前暂无解决方案，[request](https://developers.weixin.qq.com/miniprogram/dev/api/network/request/wx.request.html), [downloadFile](https://developers.weixin.qq.com/miniprogram/dev/api/network/download/wx.downloadFile.html) ;[API支持情况](https://developers.weixin.qq.com/community/develop/doc/000ecaa8b580c80601cac8e6f56000?highLine=%2520request%2520profile)
4. `trackInteractions` 用户行为采集开启后，因为微信小程序的限制，无法采集到控件的内容和结构数据，所以在小程序 SDK 里面我们采取的是声明式编程，通过在 模版 里面设置 data-name 属性，可以给 交互元素 添加名称，方便后续统计是定位操作记录， 例如：

```javascript
 <button bindtap="bindSetData" data-name="setData">setData</button>
```

