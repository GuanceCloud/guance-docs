# WeChat Miniapp Application Access
---

## Update Logs
2022.9.29

- The initialization parameter adds `isIntakeUrl` configuration, which is used to determine whether the data of the corresponding resource needs to be captured according to the requested resource url, and by default they are all captured. 

2022.3.29

-   New `traceType` configuration, configure the link tracing tool type, if not configure the default is `ddtrace`. Currently supports `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent` 6 data types.
-   New `allowedTracingOrigins` allows to inject a list of all requests with the header headers required by the trace collector. It can be the origin of the request, or it can be a regular.

## Overview

Guance Real User Monitoring can collect the metrics data of each miniapp application, introduce sdk files, monitor the performance metrics, error log and resource request data of each miniapp, and report them to Guance platform to visually analyze the performance of each miniapp application.

## Precondition

- Installing DataKit ([DataKit Installation Documentation](... /... /datakit/datakit-install.md))
## Miniapp Application Access

Login to Guance Console, enter "Real User Monitoring" page, click "New Application" in the upper right corner, enter "Application Name" and customize "Application ID" in the new window, and click "Create" to select the application type to get access.

- Application Name (required): The name of the application used to identify the current implementation of user access monitoring.
- Application ID (required): The unique identification of the application in the current workspace, which is used for SDK data collection and upload matching, and corresponds to the field: app_id after data entry. This field only supports English, numeric, underscore input, up to 48 characters.

![](../img/13.rum_access_1.png)

## Use Method

Introduce the code in the app.js file of the Miniapp in the following way

=== "NPM" 

	引入(可参考微信官方[npm引入方式](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))
	
	```javascript
	const { datafluxRum } = require('@cloudcare/rum-miniapp')
	// Initialize Rum
	datafluxRum.init({
		datakitOrigin: 'https://datakit.xxx.com/',// 必填，Datakit域名地址 需要在微信小程序管理后台加上域名白名单
		applicationId: 'appid_xxxxxxx', // 必填，dataflux 平台生成的应用ID
		env: 'testing', // 选填，小程序的环境
		version: '1.0.0', // 选填，小程序版本
		trackInteractions: true,
	})
	```

=== "CDN" 

	下载文件本地方式引入([下载地址](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))
	
	```javascript
	const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
	// 初始化 Rum
	datafluxRum.init({
		datakitOrigin: 'https://datakit.xxx.com/',// 必填，Datakit域名地址 需要在微信小程序管理后台加上域名白名单
		applicationId: 'appid_xxxxxxx', // 必填，dataflux 平台生成的应用ID
		env: 'testing', // 选填，小程序的环境
		version: '1.0.0', // 选填，小程序版本
		trackInteractions: true,
	})
	```

## Configuration

### Initialization Parameters

| Parameter                  | Type | Required | Default Value | Description                                              |
| ------------------------------- | ------- | -------- | --------- | ------------------------------------------------------------ |
| `applicationId`                 | String  | Yes     |           | Application ID created from Guance |
| `datakitOrigin`                 | String  | Yes     |           | datakit data reporting Origin; `Note: need to add request whitelist in the Miniapp management backend` |
| `env`                           | String  | No     |           | The current environment of the Miniapp application, such as prod: online environment; gray: grayscale environment; pre: pre-release environment common: daily environment; local: local environment. |
| `version`                       | String  | No     |           | Miniapp App version number                |
| `service` | String | No | | The service name of the current application, default is `browser`, custom configuration is supported. |
| `sampleRate`                    | Number  | No     | `100`     | Metrics data collection percentage: `100` means fully collected, `0` means not collected |
| `trackInteractions`             | Boolean | No     | `false`   | Whether to open user behavior collection |
| `traceType`                    | Enum    | No     | `ddtrace` | Configure the link tracing tool type, if not the default is `ddtrace`. Currently, `ddtrace`, `zipkin`, `skywalking_v3`, `jaeger`, `zipkin_single_header`, `w3c_traceparent` are the 6 data types supported. Note: `opentelemetry` supports `zipkin_single_header`,`w3c_traceparent`,`zipkin`,`jaeger` types.<br><br>Note: Configuring the traceType of the appropriate type requires setting a different ` Access-Control-All-Headers ` for the corresponding API service to see specifically [how APM associates with RUM](../../application-performance-monitoring/collection/connect-web-app.md) |
| `traceId128Bit`                | Boolean | No     | `false`   | Whether to generate `traceID` as 128 bytes, corresponding to `traceType`, currently supports types `zipkin`, `jaeger` |
| `allowedTracingOrigins`        | Array   | No     | `[]`      | [New] Allow to inject a list of all requests with header headers required by `ddtrace` collector. Can be the origin of the request, or can be is a regular, origin: `protocol (including: //), domain name (or IP address) [and port number]`<br>For example.<br>`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]` |
| `isIntakeUrl`                 | Function | No     | `function(url) {return false}`     | The custom method determines whether the data of the corresponding resource should be collected according to the requested resource url, and the default is to collect them all. Return: `false` means to collect, `true` means not to collect <br>*The result of the method must be Boolean, otherwise it is considered an invalid parameter*<br/>**Note: Version 2.1.10 and above is required** |

## Attention

1. The datakit domain name corresponding to `datakitOrigin` must be added to the request whitelist in the Miniapp management backend
1. Because the `profile` field in the returned data of `wx.request` and `wx.downloadFile` of the WeChat Miniapp request resource API is not supported by the ios system at present, so it will lead to incomplete collection of resource information and timing-related data. There is no solution for this, [request](https://developers.weixin.qq.com/miniprogram/dev/api/network/request/wx.request.html), [downloadFile](https://developers.weixin.qq.com/miniprogram/dev/api/network/download/wx.downloadFile.html) ; [API support](https://developers.weixin.qq.com/ community/develop/doc/000ecaa8b580c80601cac8e6f56000?highLine=%2520request%2520profile)
1. After `trackInteractions` user behavior collection is opened, because of the limitation of WeChat Miniapp, the content and structure data of the control cannot be collected, so we adopt declarative programming in the Miniapp SDK, by setting the data-name attribute inside the wxml file, you can add a name to the interaction element to facilitate the subsequent statistics to locate the operation record, for example.

```javascript
 <button bindtap="bindSetData" data-name="setData">setData</button>
```

