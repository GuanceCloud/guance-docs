# Browser Log Collection
---


Send different levels of log data (`corresponding source: browser_log` metric type log data) to [Guance](https://www.guance.com/) through a web browser or javascript client.

## Feature List

- Custom log data collection is applied to client through sdk and then collect different log data for different scenarios.   
- Automatically collect application-side error messages (including network errors, console errors and js errors) and report them to Guance.   
- Custom error levels (`debug`, `critical`, `error`, `info`, `warn`), custom Logger objects and custom log fields   
- Data related to [RUM](../real-user-monitoring/web/app-access.md) can be automatically collected to correlate RUM business scenarios. 


## Get Started

### Preconditions

**Datakit:** Send log data to Guance through datakit log collection API.

**Import SDK:** SDK can be introduced into applications by `NPM`, `DN sync` or `CDN async`.

**Supported Browsers:** Support all PC and mobile browsers.

### Access Methods

You can choose one of the following ways to access your Web application:

| Methods     | Description                                                                                                                                                             |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM         | By packaging the SDK code into your front-end project, this ensures that the performance of the front-end page will not be affected, but you may miss the request before SDK initialization and collect errors.                     |
| CDN async | Through CDN accelerated caching, the SDK script is introduced in the way of asynchronous script introduction, which can ensure that the download of SDK script will not affect the loading performance of pages, but it may miss the request before SDK initialization and collect errors. |
| CDN sync | SDK scripts are introduced through CDN accelerated caching in a synchronous script introduction manner that ensures that all errors, resources, requests and performance metrics are collected. However, it may affect the loading performance of the page.        |


### NPM

```javascript
import { datafluxLogs } from '@cloudcare/browser-logs'
datafluxLogs.init({
  datakitOrigin: '<DATAKIT ORIGIN>'
  //service: 'browser',
  //forwardErrorsToLogs:true
})
```

### CDN Async

```html
<script>
  ;(function (h, o, u, n, d) {
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
    'https://static.guance.com/browser-sdk/v3/dataflux-logs.js',
    'DATAFLUX_LOGS'
  )
  DATAFLUX_LOGS.onReady(function () {
    DATAFLUX_LOGS.init({
      datakitOrigin: '<DATAKIT ORIGIN>'
      //service: 'browser',
      //forwardErrorsToLogs:true
    })
  })
</script>
```

### CDN Sync

```html
<script
  src="https://static.guance.com/browser-sdk/v3/dataflux-logs.js" 
  type="text/javascript"
></script>
<script>
  window.DATAFLUX_LOGS &&
    window.DATAFLUX_LOGS.init({
      datakitOrigin: '<DATAKIT ORIGIN>'
      //service: 'browser',
      //forwardErrorsToLogs:true
    })
</script>
```

## Configuration

### Initialization

| Parameter              | Type | Option | Default | Description                                                                                                                           |
| --------------------- | -------- | ------------ | ---------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `datakitOrigin`       | String   | Required           |            | datakit data report origin note: `Protocol (including://), domain name (or IP address)[and port number]` For example: https://www.datakit.com, http://100.20.34.3:8088 |
| `service`             | String   | Optional           | `browser`  | service name in log                                                                                                                    |
| `env`                 | String   | Optional           |            | Current environment of web application, such as prod: online environment; Grey: Grayscale environment; pre: pre-release environment command: daily environment; local: The local environment;                          |
| `version`             | String   | Optional           |            | web application version                                                                                                                   |
| `sampleRate`          | Number   | Optional           | `100`      | Percentage of metric data collection: `100` for full collection, `0` for no collection                                                                                  |
| `forwardErrorsToLogs` | Boolean  | Optional           | `true`     | Set to `false`  to stop collecting console.error, js and report network errors to DataFlux log data                                                 |
| `silentMultipleInit`  | Boolean  | Optional           | `false`    | Do not allowed  initialize multiple log objects                                                                                                     |

## Use

After the SDK is initialized in the application, you can customize the configuration log data through the exposed JS API. 

```javascript
logger.debug | info | warn | error | critical (message: string, messageContext = Context)
```

### NPM

```javascript
import { datafluxLogs } from '@cloudcare/browser-logs'

datafluxLogs.logger.info('Button clicked', { name: 'buttonName', id: 123 })
```

### CDN Async

```javascript
DATAFLUX_LOGS.onReady(function () {
  DATAFLUX_LOGS.logger.info('Button clicked', { name: 'buttonName', id: 123 })
})
```

### CDN Sync

```javascript
window.DATAFLUX_LOGS && DATAFLUX_LOGS.logger.info('Button clicked', { name: 'buttonName', id: 123 })
```

## Return Data Structure

```json
{
    "service": "browser",
    "session": {
        "id": "c549c2b8-4955-4f74-b7f8-a5f42fc6e79b"
    },
    "type": "logger",
    "_dd": {
        "sdk_name": "Web LOG SDK",
        "sdk_version": "1.0.0",
        "env": "",
        "version": ""
    },
    "device": {
        "os": "Mac OS",
        "os_version": "10.14.6",
        "os_version_major": "10",
        "browser": "Chrome",
        "browser_version": "90.0.4430.85",
        "browser_version_major": "90",
        "screen_size": "2560*1440",
        "network_type": "3g",
        "divice": "PC"
    },
    "user": {},
    "date": 1621321916756,
    "view": {
        "referrer": "",
        "url": "http://localhost:8080/",
        "host": "localhost:8080",
        "path": "/",
        "path_group": "/",
        "url_query": "{}",
        "id": "5dce64f4-8d6d-411a-af84-c41653ccd94a"
    },
    "application": {
        "id": "app_idxxxxxx"
    },
    "message": "XHR error get http://testing-ft2x-api.cloudcare.cn/api/v1/workspace/xxx",
    "status": "error",
    "tags": {},
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

After the SDk is initialized, you can define different types of states using the `log` API provided:

```javascript
log (message: string, messageContext: Context, status? = 'debug' | 'info' | 'warn' | 'error' | 'critical')
```

### NPM

```javascript
import { datafluxLogs } from '@cloudcare/browser-logs'

datafluxLogs.logger.log(<MESSAGE>,<JSON_ATTRIBUTES>,<STATUS>);
```

### CDN Async

```javascript
DATAFLUX_LOGS.onReady(function () {
  DATAFLUX_LOGS.logger.log(<MESSAGE>,<JSON_ATTRIBUTES>,<STATUS>);
})
```

### CDN Sync

```javascript
window.DATAFLUX_LOGS && DATAFLUX_LOGS.logger.log(<MESSAGE>,<JSON_ATTRIBUTES>,<STATUS>);
```

## Parameter Description

| Parameter            | Description                                                   |
| ------------------- | ---------------------------------------------------------- |
| `<MESSAGE>`         | message field in Guance **Log**                             |
| `<JSON_ATTRIBUTES>` | The additional data that describes the message is a json object.                      |
| `<STATUS>`          | status，option:`debug`,`info`,`warn`,`error`,`critical` |
