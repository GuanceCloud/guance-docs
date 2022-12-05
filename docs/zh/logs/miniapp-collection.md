# 小程序日志采集
---

## 简介

小程序主动发送不同等级的日志数据(`对应的source:browser_log`指标类型日志数据)到[观测云](https://www.guance.com/)。

## 功能简介

- 自定义日志数据采集，通过sdk接入客户端应用中，针对不同场景采集不同日志数据。
- 可以自动收集应用端的错误信息（包括网络错误，console错误，以及js错误）上报到DataFlux。
- 自定义错误等级（`debug`,`critical`,`error`,`info`,`warn`）,自定义Logger对象，以及自定义log字段
- 可以自动收集[RUM](../real-user-monitoring/miniapp/app-access.md)相关数据，关联RUM业务场景（需要rum sdk 更新到最新版本）

## 开始使用

### 前置条件

**datakit** 通过datakit日志采集API发送日志数据到DataFlux平台

**引入SDK** 可通过`NPM`,`CDN`的方式引入SDK到应用中，初始化后，可以存放到全局变量中，方便其他页面引用

**支持小程序客户端 **： 微信，百度，支付宝，头条等大部分小程序端

### npm 引入

```javascript
//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
const { datafluxRum } = require('@cloudcare/dataflux-rum-miniapp-logs')
// 初始化 Rum
datafluxRum.init({
	datakitOrigin: '<DATAKIT ORIGIN>'
  service: 'minapp',
  env: 'prod',
  version: '1.0.0'
})
//#endif
```

### CDN 下载文件本地方式引入([下载地址](https://static.guance.com/miniapp-sdk/v1/dataflux-rum-miniapp-logs.js))

```javascript
//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
const { datafluxRum } = require('@cloudcare/dataflux-rum-miniapp-logs')
// 初始化 Rum
datafluxRum.init({
	datakitOrigin: '<DATAKIT ORIGIN>'
  service: 'miniapp',
  env: 'prod',
  version: '1.0.0'
})
//#endif
```

## 配置

### 初始化参数
| 参数                  | 类型    | 是否必须 | 默认值    | 描述                                                                                                                                                                                         |
| --------------------- | ------- | -------- | --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `datakitOrigin`       | String  | 是       |           | datakit 数据上报 Origin 注释: `协议（包括：//），域名（或IP地址）[和端口号]`<br>例如：[https://www.datakit.com](https://www.datakit.com), [http://100.20.34.3:8088](http://100.20.34.3:8088) |
| `service`             | String  | 否       | `browser` | 日志service名称                                                                                                                                                                              |
| `env`                 | String  | 否       |           | web 应用当前环境， 如 prod：线上环境；gray：灰度环境；pre：预发布环境 common：日常环境；local：本地环境；                                                                                    |
| `version`             | String  | 否       |           | web 应用的版本号                                                                                                                                                                             |
| `sampleRate`          | Number  | 否       | `100`     | 指标数据收集百分比: `100`表示全收集，`0`表示不收集                                                                                                                                           |
| `forwardErrorsToLogs` | Boolean | 否       | `true`    | 设置为`false`表示停止采集console.error、 js、以及网络错误上报到DataFlux日志数据中                                                                                                            |


## 使用

SDK在应用中初始化后，通过暴露的SDK API 可以自定义配置日志数据

```javascript
logger.debug | info | warn | error | critical (message: string, messageContext = Context)
```

### NPM

```javascript
import { datafluxLogs } from '@cloudcare/dataflux-rum-miniapp-logs'

datafluxLogs.logger.info('Button clicked', { name: 'buttonName', id: 123 })
```

## 返回数据结构

```json
{
    "service": "miniapp",
    "session": {
        "id": "c549c2b8-4955-4f74-b7f8-a5f42fc6e79b"
    },
    "type": "logger",
    "_dd": {
        "sdk_name": "miniapp LOG SDK",
        "sdk_version": "1.0.0",
        "env": "",
        "version": ""
    },
    "device": {
        "platform_version": "8.0.5",
        "model": "iPhone 6/7/8 Plus",
        "app_framework_version":"2.23.3",
        "os": "OS",
        "os_version": "10.14.6",
        "os_version_major": "10",
        "screen_size": "414*736",
        "network_type": "3g",
        "divice": "devtools"
    },
    "user": {},
    "date": 1621321916756,
    "view": {
        "referrer": "",
        "name": "pages/index/index",
        "id": "5dce64f4-8d6d-411a-af84-c41653ccd94a"
    },
    "application": {
        "id": "app_idxxxxxx"
    },
    "message": "XHR error get http://testing-ft2x-api.cloudcare.cn/api/v1/workspace/xxx",
    "status": "error",
    "error": {
        "source": "network",
        "stack": "Failed to load"
    },
    "resource": {
        "method": "get",
        "status": 0,
        "status_group": 0,
        "url": "http://testing-ft2x-api.cloudcare.cn/api/v1/workspace/xxx",
        "url_host": "testing-ft2x-api.cloudcare.cn",
        "url_path": "/api/v1/workspace/xxx",
        "url_path_group": "/api/?/workspace/xxx"
    }
}
```

## Status 参数

初始化SDk后，可以使用提供`log` API,定义不同类型的状态

```javascript
log (message: string, messageContext: Context, status? = 'debug' | 'info' | 'warning' | 'error' | 'critical')
```

### 使用

```javascript
import { datafluxLogs } from '@cloudcare/dataflux-rum-miniapp-logs'

datafluxLogs.logger.log(<MESSAGE>,<JSON_ATTRIBUTES>,<STATUS>);
```

## 参数说明
| 参数                | 描述                                                                |
| ------------------- | ------------------------------------------------------------------- |
| `<MESSAGE>`         | Dataflux 日志中的 message 字段                                      |
| `<JSON_ATTRIBUTES>` | 描述message的额外数据，是一个json对象                               |
| `<STATUS>`          | 日志的等级，可选值：`debug`, `info`, `warning`, `error`, `critical` |
