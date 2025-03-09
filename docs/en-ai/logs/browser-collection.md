# Browser Log Collection

---

Send log data of different levels (`source:browser_log` Metrics type log data) from Web browsers or JavaScript clients to [<<< custom_key.brand_name >>>](https://www.guance.com/).


- Custom log data collection, by integrating SDK into client applications to collect different log data for different scenarios;
- Automatically collect error information from the application end (including network errors, console errors, and JS errors) and report it to <<< custom_key.brand_name >>>;
- Customize error levels (`debug`, `critical`, `error`, `info`, `warn`), customize Logger objects, and customize log fields;
- Automatically collect [RUM](../real-user-monitoring/web/app-access.md) related data and associate it with RUM business scenarios.

## Getting Started

### Prerequisites

- **DataKit**: Send log data to the <<< custom_key.brand_name >>> platform via the DataKit Log Collection API;

- **Integrate SDK**: The SDK can be integrated into your application via `NPM`, `CDN Sync`, or `CDN Async`;

- **Supported Browsers**: Supports all PC and mobile browsers.

### Choose Integration Method

| Integration Method | Description                                                                                                                                                             |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM                | By bundling the SDK code with your frontend project, this method ensures no impact on frontend page performance but might miss requests and errors before SDK initialization. |
| CDN Async Loading  | Using asynchronous script loading via CDN cache, this method ensures that the SDK script download does not affect page load performance but might miss requests and errors before SDK initialization. |
| CDN Sync Loading   | Using synchronous script loading via CDN cache, this method ensures collecting all errors, resources, requests, and performance metrics but may impact page load performance. |

#### NPM

```javascript
import { datafluxLogs } from '@cloudcare/browser-logs'
datafluxLogs.init({
  datakitOrigin: '<DataKit domain or IP>', // Required for DK integration
  clientToken: 'clientToken', // Required for public OpenWay integration
  site: 'public OpenWay address', // Required for public OpenWay integration
  //service: 'browser',
  //forwardErrorsToLogs:true
})
```

#### CDN Async Loading

```html
<script>
  ;(function (h, o, u, n, d) {
    h = h[d] = h[d] || {
      q: [],
      onReady: function (c) {
        h.q.push(c)
      },
    }
    d = o.createElement(u)
    d.async = 1
    d.src = n
    n = o.getElementsByTagName(u)[0]
    n.parentNode.insertBefore(d, n)
  })(window, document, 'script', 'https://<<< custom_key.static_domain >>>/browser-sdk/v3/dataflux-logs.js', 'DATAFLUX_LOGS')
  DATAFLUX_LOGS.onReady(function () {
    DATAFLUX_LOGS.init({
      datakitOrigin: '<DataKit domain or IP>', // Required for DK integration
      clientToken: 'clientToken', // Required for public OpenWay integration
      site: 'public OpenWay address', // Required for public OpenWay integration
      //service: 'browser',
      //forwardErrorsToLogs:true
    })
  })
</script>
```

#### CDN Sync Loading

```html
<script src="https://<<< custom_key.static_domain >>>/browser-sdk/v3/dataflux-logs.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_LOGS &&
    window.DATAFLUX_LOGS.init({
      datakitOrigin: '<DataKit domain or IP>', // Required for DK integration
      clientToken: 'clientToken', // Required for public OpenWay integration
      site: 'public OpenWay address', // Required for public OpenWay integration
      //service: 'browser',
      //forwardErrorsToLogs:true
    })
</script>
```

## Configuration

### Initialization Parameters

| **Parameter**               | **Type**    | **Required** | **Default Value** | **Description**                                                                                                                               |
| --------------------------- | ----------- | ------------ | ----------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| `datakitOrigin`             | String      | Yes          |                   | DataKit data reporting Origin: `protocol (including: //), domain name (or IP address) [and port number]`. Example: https://www.datakit.com.  |
| `clientToken`               | String      | Yes          |                   | Data reporting token for openway method, obtained from the <<< custom_key.brand_name >>> console (required for public openway integration).  |
| `site`                      | String      | Yes          |                   | Data reporting URL for public openway method, obtained from the <<< custom_key.brand_name >>> console (required for public openway integration). |
| `service`                   | String      | No           | `browser`         | Log Service name                                                                                                                             |
| `env`                       | String      | No           |                   | Current environment of the web application, e.g., Prod: production; Gray: gray release; Pre: pre-release; Common: daily; Local: local.       |
| `version`                   | String      | No           |                   | Version number of the web application                                                                                                        |
| `sessionSampleRate`         | Number      | No           | `100`             | Percentage of metric data collection: `100` means full collection, `0` means no collection                                                   |
| `forwardErrorsToLogs`       | Boolean     | No           | `true`            | Set to `false` to stop collecting console.error, JS, and network errors in <<< custom_key.brand_name >>> log data                           |
| `silentMultipleInit`        | Boolean     | No           | `false`           | Prevent multiple log objects from being initialized                                                                                          |
| `forwardConsoleLogs`        | String/Array| No           |                   | Console log types to collect, options: `error`, `log`, `info`, `warn`, `error`                                                              |
| `storeContextsToLocal`      | Boolean     | No           |                   | Version requirement: `>3.1.2`. Whether to cache user-defined data in localstorage, e.g., data added via `setUser`, `addGlobalContext` APIs.  |
| `storeContextsKey`          | String      | No           |                   | Version requirement: `>3.1.18`. Define the key for storing data in localstorage, auto-generated if not specified, mainly for distinguishing store usage under the same domain with different sub-paths. |

## Usage

After initializing the SDK in your application, you can customize log data through exposed JS APIs.

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

After initializing the SDK, you can use the provided `log` API to define different types of statuses.

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

| **Parameter**            | **Description**                                                    |
| ------------------------ | ------------------------------------------------------------------- |
| `<MESSAGE>`              | Message field in <<< custom_key.brand_name >>> logs                 |
| `<JSON_ATTRIBUTES>`      | Additional data describing the message, a JSON object               |
| `<STATUS>`               | Log level, options: `debug`,`info`,`warn`,`error`,`critical`        |

## Adding Custom Data Tags

---

After initializing the log, use the `setGlobalContextProperty(key:string, value:any)` API to add extra tags to all collected log events.

### Adding Tags

=== "CDN Sync"

    ```javascript
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.setGlobalContextProperty('<CONTEXT_KEY>', '<CONTEXT_VALUE>');

    // Code example
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.setGlobalContextProperty('isvip', 'xxxx');
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.setGlobalContextProperty('activity', {
        hasPaid: true,
        amount: 23.42
    });
    ```

=== "CDN Async"

    ```javascript
    DATAFLUX_LOGS.onReady(function() {
        DATAFLUX_LOGS.setGlobalContextProperty('<CONTEXT_KEY>', '<CONTEXT_VALUE>');
    })

    // Code example
    DATAFLUX_LOGS.onReady(function() {
        DATAFLUX_LOGS.setGlobalContextProperty('isvip', 'xxxx');
    })
    DATAFLUX_LOGS.onReady(function() {
        DATAFLUX_LOGS.setGlobalContextProperty('activity', {
            hasPaid: true,
            amount: 23.42
        });
    })

    ```

=== "NPM"

    ```javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'
    datafluxLogs.setGlobalContextProperty('<CONTEXT_KEY>', <CONTEXT_VALUE>);

    // Code example
    datafluxLogs && datafluxLogs.setGlobalContextProperty('isvip', 'xxxx');
    datafluxLogs.setGlobalContextProperty('activity', {
        hasPaid: true,
        amount: 23.42
    });
    ```

### Replacing Tags (Overwrite)

=== "CDN Sync"

    ```javascript
    window.DATAFLUX_LOGS &&
         window.DATAFLUX_LOGS.setGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

    // Code example
    window.DATAFLUX_LOGS &&
         window.DATAFLUX_LOGS.setGlobalContext({
            codeVersion: 34,
        });
    ```

=== "CDN Async"

    ```javascript
     window.DATAFLUX_LOGS.onReady(function() {
         window.DATAFLUX_LOGS.setGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });
    })

    // Code example
     window.DATAFLUX_LOGS.onReady(function() {
         window.DATAFLUX_LOGS.setGlobalContext({
            codeVersion: 34,
        })
    })
    ```

=== "NPM"

    ```javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'

    datafluxLogs.setGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

    // Code example
    datafluxLogs.setGlobalContext({
        codeVersion: 34,
    });
    ```

### Retrieving All Custom Tags

=== "CDN Sync"

    ```javascript
    var context = window.DATAFLUX_LOGS &&  window.DATAFLUX_LOGS.getGlobalContext();

    ```

=== "CDN Async"

    ```javascript
     window.DATAFLUX_LOGS.onReady(function() {
        var context =  window.DATAFLUX_LOGS.getGlobalContext();
    });
    ```

=== "NPM"

    ```javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'

    const context = datafluxLogs.getGlobalContext();

    ```

### Removing Specific Key's Custom Tag

=== "CDN Sync"

    ```javascript
    var context = window.DATAFLUX_LOGS &&  window.DATAFLUX_LOGS.removeGlobalContextProperty('<CONTEXT_KEY>');

    ```

=== "CDN Async"

    ```javascript
     window.DATAFLUX_LOGS.onReady(function() {
        var context =  window.DATAFLUX_LOGS.removeGlobalContextProperty('<CONTEXT_KEY>');
    });
    ```

=== "NPM"

    ```javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'

    const context = datafluxLogs.removeGlobalContextProperty('<CONTEXT_KEY>');
    ```

### Removing All Custom Tags

=== "CDN Sync"

    ```javascript
    var context = window.DATAFLUX_LOGS &&  window.DATAFLUX_LOGS.clearGlobalContext();

    ```

=== "CDN Async"

    ```javascript
     window.DATAFLUX_LOGS.onReady(function() {
        var context =  window.DATAFLUX_LOGS.clearGlobalContext();
    });
    ```

=== "NPM"

    ```javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'

    const context = datafluxLogs.clearGlobalContext();
    ```

## Custom User Identification

---

By default, the SDK automatically generates a unique identifier ID for each user. This ID has no identifying attributes and is only used to distinguish different users. We provide additional APIs to add different identifying attributes to the current user.

| Property       | Type   | Description               |
| -------------- | ------ | -------------------------- |
| user.id        | string | User ID                    |
| user.name      | string | User nickname or username  |
| user.email     | string | User email                 |

**Note**: These properties are optional, but it is recommended to provide at least one.

### Adding User Identification

=== "CDN Sync"

    ```javascript
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

=== "CDN Async"

    ```javascript
    window.DATAFLUX_LOGS.onReady(function() {
        window.DATAFLUX_LOGS.setUser({
            id: '1234',
            name: 'John Doe',
            email: 'john@doe.com',
        })
    })
    ```

=== "NPM"

    ```javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'
    datafluxLogs.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

### Removing User Identification

=== "CDN Sync"

    ```javascript
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.clearUser()
    ```

=== "CDN Async"

    ```javascript
    window.DATAFLUX_LOGS.onReady(function() {
        window.DATAFLUX_LOGS.clearUser()
    })
    ```

=== "NPM"

    ```javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'
    datafluxLogs.clearUser()
    ```