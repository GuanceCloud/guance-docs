# Miniapp Log collection
---


Miniapp sends different levels of log data (`corresponding source: browser_log` metric type log data) to [Guance](https://www.guance.com/).

## Feature List

- Custom log data collection is applied to client through sdk and then collect different log data for different scenarios. 
- Automatically collect application-side error messages (including network errors, console errors and js errors) and report them to DataFlux. 
- Custom error levels (`debug`, `critical`, `error`, `info`, `warn`), custom Logger objects and custom log fields.  
- You can automatically collect [RUM](../real-user-monitoring/miniapp/app-access.md) related data to correlate RUM business scenarios (rum sdk needs to be updated to the latest version). 


## Get Started

### Preconditions

**DataKit:** Send log data to Guance through datakit log collection API.

**import SDK:** SDK can be introduced into application by `NPM` and `CDN`. After initialization, it can be stored in global variables, which is convenient for other pages to refer to.

**Support Miniapp Clients**: WeChat, Baidu, Alipay, Toutiao and other miniapp terminals.

### Npm Introduction

```javascript
//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
const { datafluxRum } = require('@cloudcare/dataflux-rum-miniapp-logs')
// Initialization Rum
datafluxRum.init({
	datakitOrigin: '<DATAKIT ORIGIN>'
  service: 'minapp',
  env: 'prod',
  version: '1.0.0'
})
//#endif
```

### CDN Download File Introduce ([URL](https://static.guance.com/miniapp-sdk/v1/dataflux-rum-miniapp-logs.js)) Locally

```javascript
//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
const { datafluxRum } = require('@cloudcare/dataflux-rum-miniapp-logs')
// Initialization Rum
datafluxRum.init({
	datakitOrigin: '<DATAKIT ORIGIN>'
  service: 'miniapp',
  env: 'prod',
  version: '1.0.0'
})
//#endif
```
## Configuration

### Initialization Parameter

| **Parameter**              | **Type** | **Option** | **Default** | **Description**                                                                                                                           |
| --------------------- | -------- | ------------ | ---------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `datakitOrigin`       | String   | Required           |            | datakit data report origin note: ` Protocol (including://), domain name (or IP address) [and port number] ` For example: https://www.datakit.com, http://100.20.34.3:8088 |
| `service`             | String   | Optional           | `browser`  | service name in log                                                                                                                    |
| `env`                 | String   | Optional           |            | Current environment of web application, such as prod: online environment; Grey: Grayscale environment; pre: pre-release environment command: daily environment; local: The local environment;                          |
| `version`             | String   | Optional           |            | web application version                                                                                                                   |
| `sampleRate`          | Number   | Optional           | `100`      | Percentage of metric data collection: ` 100 ` for full collection, ` 0 ` for no collection                                                                                  |
| `forwardErrorsToLogs` | Boolean  | Optional           | `true`     | Set to ` false `  to stop collecting console.error, js and report network errors to DataFlux log data                                                 |
| `silentMultipleInit`  | Boolean  | Optional           | `false`    | Do not allowed  initialize multiple log objects                                                                                                     |


## Use

After the SDK is initialized in the application, you can customize the configuration log data through the exposed SDK API. 

```javascript
logger.debug | info | warn | error | critical (message: string, messageContext = Context)
```

### NPM

```javascript
import { datafluxLogs } from '@cloudcare/dataflux-rum-miniapp-logs'

datafluxLogs.logger.info('Button clicked', { name: 'buttonName', id: 123 })
```

## Return Data Structure

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

## Status Parameter

After the SDk is initialized, you can define different types of states using the `log` API provided.

```javascript
log (message: string, messageContext: Context, status? = 'debug' | 'info' | 'warning' | 'error' | 'critical')
```

### Use

```javascript
import { datafluxLogs } from '@cloudcare/dataflux-rum-miniapp-logs'

datafluxLogs.logger.log(<MESSAGE>,<JSON_ATTRIBUTES>,<STATUS>);
```

## Parameter Description

| **Parameter**            | **Description**                                                   |
| ------------------- | ---------------------------------------------------------- |
| `<MESSAGE>`         | message field in Guance Log                             |
| `<JSON_ATTRIBUTES>` | The additional data that describes the message is a json object                      |
| `<STATUS>`          | status，option:`debug`,`info`,`warn`,`error`,`critical` |

