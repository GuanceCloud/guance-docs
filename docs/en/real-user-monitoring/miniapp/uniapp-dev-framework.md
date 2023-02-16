# Applet Access Based on Uniapp Development Framework
---

## Update Logs
2022.9.29

- The initialization parameter adds `isIntakeUrl` configuration, which is used to determine whether the data of the corresponding resource needs to be captured according to the requested resource url, and by default they are all captured. 

2022.3.29

-   New `traceType` configuration, configure the link tracing tool type, if not configure the default is `ddtrace`. Currently supports `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent` 6 data types.
-   New `allowedTracingOrigins` allows to inject a list of all requests with the header headers required by the trace collector. It can be the origin of the request, or it can be a regular.

By introducing sdk files, we monitor applet performance metrics, error logs, and resource request status data and report them to the Guance platform.

## Use Method

### Introduce the code at the head of the `main.js` file in the uniapp project entry file in the following way

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

	下载文件本地方式引入([下载地址](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-uniapp.js))
	
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

	下载文件本地方式引入([下载地址](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-uniapp.js))
	
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

## Configuration

### Initialization Parameters

| Parameter                      | Type     | Required | Default Value                  | Description                                                  |
| ------------------------------- | ------- | -------- | --------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                 | String  | Yes     |           | Application ID created from Guance                                                                                                                                                                                                                                                                                                                                                                                                    |
| `datakitOrigin`                 | String  | Yes     |           | datakit data reporting Origin;`Note: need to add request whitelist in the applet management backend`                                                                                                                                                                                                                                                                                                  |
| `env`                           | String  | No      |           | The current environment of the applet application, such as prod: online environment; gray: grayscale environment; pre: pre-release environment common: daily environment; local: local environment.                                                                                                                                                             |
| `version`                       | String  | No     |           | Applet App version number                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `service` | String | No | | The service name of the current application, default is `browser`, custom configuration is supported. |
| `sampleRate`                    | Number  | No     | `100`     | Metric data collection percentage: `100` means fully collected, `0` means not collected                                                                                                                                                                                                                                                                                                                                    |
| `trackInteractions`             | Boolean | No     | `false`   | Whether to open user behavior collection                                                                                                                                                                                                                                                                                                                                                                                                                |
| `traceType`                 | Enum    | No     | `ddtrace` | Configure the link tracing tool type, if not the default is `ddtrace`. Currently, `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent` are the 6 data types supported. Note: `opentelemetry` supports `zipkin_single_header`,`w3c_traceparent`,`zipkin`,`jaeger` types.<br><br>Note: Configuring the traceType of the appropriate type requires setting a different ` Access-Control-All-Headers ` for the corresponding API service to see specifically [how APM associates with RUM](../../application-performance-monitoring/collection/connect-web-app.md) |
| `traceId128Bit`              | Boolean | No     | `false`   | Whether to generate ` traceID ` in 128 bytes, corresponding to ` traceType `, currently supported types ` zipkin `, ` jaeger `                                                                                                                                                                                                                                                        |
| `allowedTracingOrigins`       | Array   | No     | [`[]`     | A list of all requests allowed to inject header headers required by the ` ddtrace ` collector. It can be the origin of the request, or it can be regular, origin: ` Protocol (including://), domain name (or IP address) [and port number] `<br>For example:<br>`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]` |
| `isIntakeUrl`                                     | Function | No     | `function(url) {return false}`     | The user-defined method judges whether the corresponding resource data needs to be collected according to the requested resource url, and collects it by default. Returns: ` false ` means to collect, ` true ` means not to collect<br>*The result returned by this parameter method must be of Boolean type, otherwise it is considered an invalid parameter*<br>**Note: Version requirements are 2.1. 13 and above** |

## Attention

1. The datakit domain name corresponding to ` datakitOrigin ` must be added with a request white list in the applet management background
3. At present, there is no perfect unification of the api exposure of performance data in each platform, so some performance data cannot be collected perfectly, such as `applet start`, `applet package download`, `script injection`, etc. Some data may be missing except for the WeChat platform.
4. At present, the `profile` field in the returned data of `uni.request` and `uni.downloadFile` of the resource request API of each platform is only returned by the ios system of WeChat applet, so it will lead to incomplete collection of resource information and timing-related data. There is no solution at the moment, [request](https://developers.weixin.qq.com/miniprogram/dev/api/network/request/wx.request.html), [downloadFile](https://developers.weixin.qq.com/miniprogram/dev/api/network/download/wx.downloadFile.html) ; [API support](https://developers.weixin.qq.com/ community/develop/doc/000ecaa8b580c80601cac8e6f56000?highLine=%2520request%2520profile)
6. After `trackInteractions` user behavior collection is opened, the content and structure data of the control cannot be collected because of the limitation of WeChat applet, so we adopt declarative programming in the applet SDK, by setting the data-name property in the template, you can add a name to the interaction element to facilitate the subsequent statistics to locate the operation record, for example

```javascript
 <button bindtap="bindSetData" data-name="setData">setData</button>
```

