# Mini Program Log Collection

---

The mini program actively sends log data of different levels (`corresponding source: browser_log` Metrics type log data) to [<<< custom_key.brand_name >>>](https://www.guance.com/).

## Feature Overview

- Custom log data collection, by integrating the SDK into client applications, collecting different log data for different scenarios;
- Automatically collects error information from the application end (including network errors, console errors, and JS errors) and reports it to DataFlux;
- Custom error levels (`debug`, `critical`, `error`, `info`, `warn`), custom Logger objects, and custom Log fields;
- Automatically collects [RUM](../real-user-monitoring/miniapp/app-access.md) related data, associating RUM business scenarios (requires updating rum,sdk to the latest version).

## Getting Started

### Prerequisites

- **DataKit**: Send log data to the DataFlux platform via the DataKit Log Collection API;

- **Integrate SDK**: The SDK can be introduced into the application via `NPM` or `CDN`. After initialization, it can be stored in a global variable for easy reference by other pages;

- **Supports Mini Program Clients**: WeChat, Baidu, Alipay, Toutiao, and most other mini program clients.

### NPM Integration

```javascript
//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
const { datafluxLogs } = require('@cloudcare/dataflux-rum-miniapp-logs')
// Initialize Rum
datafluxLogs.init({
	datakitOrigin: '<DATAKIT ORIGIN>',
	service: 'minapp',
	env: 'prod',
	version: '1.0.0'
})
//#endif
```

### CDN Local File Integration ([Download Link](https://<<< custom_key.static_domain >>>/miniapp-sdk/v1/dataflux-rum-miniapp-logs.js))

```javascript
//#ifndef H5 || APP-PLUS || APP-NVUE || APP-PLUS-NVUE
const { datafluxLogs } = require('@cloudcare/dataflux-rum-miniapp-logs')
// Initialize Rum
datafluxLogs.init({
	datakitOrigin: '<DATAKIT ORIGIN>',
	service: 'miniapp',
	env: 'prod',
	version: '1.0.0'
})
//#endif
```

## Configuration

### Initialization Parameters

| Parameter           | Type   | Required | Default Value | Description                                                                                                                                                                                                 |
| ------------------- | ------ | -------- | ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `datakitOrigin`     | String | Yes      |               | DataKit data reporting Origin Note: `Protocol (including: //), domain name (or IP address)[and port number]`<br>For example: [https://www.datakit.com](https://www.datakit.com), [http://100.20.34.3:8088](http://100.20.34.3:8088) |
| `clientToken`       | String | Yes      |               | Data token for reporting data using the openway method, obtained from the <<< custom_key.brand_name >>> console, required (for public openway access).                                                                                 |
| `site`              | String | Yes      |               | Data reporting URL using the public openway method, obtained from the <<< custom_key.brand_name >>> console, required (for public openway access).                                                                                      |
| `service`           | String | No       | `browser`     | Name of the log Service                                                                                                                                                                                     |
| `env`               | String | No       |               | Current environment of the web application, such as Prod: production environment; Gray: gray release environment; Pre: pre-release environment; Common: daily environment; Local: local environment;         |
| `version`           | String | No       |               | Version number of the web application                                                                                                                                                                       |
| `sampleRate`        | Number | No       | `100`         | Percentage of Metrics data collected: `100` means full collection, `0` means no collection                                                                                                                   |
| `forwardErrorsToLogs` | Boolean | No  | `true`    | Set to `false` to stop collecting console.error, JS, and network errors into DataFlux log data                                                                                                             |

## Usage

After initializing the SDK in the application, you can customize log data through exposed SDK APIs.

```javascript
logger.debug | info | warn | error | critical (message: string, messageContext = Context)
```

### NPM

```javascript
import { datafluxLogs } from '@cloudcare/dataflux-rum-miniapp-logs'

datafluxLogs.logger.info('Button clicked', { name: 'buttonName', id: 123 })
```

## Returned Data Structure

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
    "app_framework_version": "2.23.3",
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

After initializing the SDK, you can use the provided `log` API to define different types of statuses.

```javascript
log (message: string, messageContext: Context, status? = 'debug' | 'info' | 'warning' | 'error' | 'critical')
```

### Usage

```javascript
import { datafluxLogs } from '@cloudcare/dataflux-rum-miniapp-logs'

datafluxLogs.logger.log(<MESSAGE>, <JSON_ATTRIBUTES>, <STATUS>);
```

## Parameter Description

| Parameter            | Description                                                                 |
| -------------------- | --------------------------------------------------------------------------- |
| `<MESSAGE>`          | Message field in Dataflux logs.                                             |
| `<JSON_ATTRIBUTES>`  | Additional data describing the Message, which is a JSON object.             |
| `<STATUS>`           | Log level, options: `debug`, `info`, `warning`, `error`, `critical`.        |