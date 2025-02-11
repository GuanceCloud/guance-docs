# Browser Log Collection

---

Send log data of different levels (`source: browser_log` Metrics type log data) from Web browsers or JavaScript clients to [Guance](https://www.guance.com).


- Custom log data collection, by integrating the SDK into client applications to collect log data for different scenarios;
- Automatically collect error information from the application end (including network errors, console errors, and JS errors) and report it to Guance;
- Customize error levels (`debug`, `critical`, `error`, `info`, `warn`), customize Logger objects, and customize log fields;
- Automatically collect [RUM](../real-user-monitoring/web/app-access.md) related data, associated with RUM business scenarios.

## Getting Started

### Prerequisites

- **DataKit**: Send log data to the Guance platform using the DataKit Log Collection API;

- **Integrate SDK**: Integrate the SDK into your application via `NPM`, `CDN synchronous`, or `CDN asynchronous`;

- **Supported Browsers**: Supports all PC and mobile browsers.

### Choose Integration Method

| Integration Method | Description                                                                                                                                                             |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM                | By bundling the SDK code into your frontend project, this method ensures no impact on frontend page performance but may miss requests and errors before SDK initialization.  |
| CDN Asynchronous   | Load SDK script asynchronously via CDN cache. This ensures that the SDK script download does not affect page load performance but may miss requests and errors before SDK initialization. |
| CDN Synchronous    | Load SDK script synchronously via CDN cache. This ensures collecting all errors, resources, requests, and performance Metrics but may affect page load performance. |

#### NPM

```javascript
import { datafluxLogs } from '@cloudcare/browser-logs'
datafluxLogs.init({
  datakitOrigin: '<DataKit domain or IP>', // Configuration required for DK integration
  clientToken: 'clientToken', // Required for public OpenWay integration
  site: 'public OpenWay address', // Required for public OpenWay integration
  //service: 'browser',
  //forwardErrorsToLogs:true
})
```

#### CDN Asynchronous Loading

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
  })(window, document, 'script', 'https://static.guance.com/browser-sdk/v3/dataflux-logs.js', 'DATAFLUX_LOGS')
  DATAFLUX_LOGS.onReady(function () {
    DATAFLUX_LOGS.init({
      datakitOrigin: '<DataKit domain or IP>', // Configuration required for DK integration
      clientToken: 'clientToken', // Required for public OpenWay integration
      site: 'public OpenWay address', // Required for public OpenWay integration
      //service: 'browser',
      //forwardErrorsToLogs:true
    })
  })
</script>
```

#### CDN Synchronous Loading

```html
<script src="https://static.guance.com/browser-sdk/v3/dataflux-logs.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_LOGS &&
    window.DATAFLUX_LOGS.init({
      datakitOrigin: '<DataKit domain or IP>', // Configuration required for DK integration
      clientToken: 'clientToken', // Required for public OpenWay integration
      site: 'public OpenWay address', // Required for public OpenWay integration
      //service: 'browser',
      //forwardErrorsToLogs:true
    })
</script>
```

## Configuration

### Initialization Parameters

| **Parameter**               | **Type**    | **Required** | **Default Value** | **Description**                                                                                                                                       |
| --------------------------- | ----------- | ------------ | ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| `datakitOrigin`             | String      | Yes          |                   | DataKit data reporting Origin: `Protocol (including: //), domain name (or IP address) [and port number]`, e.g., https://www.datakit.com, http://100.20.34.3:8088. |
| `clientToken`               | String      | Yes          |                   | Data token for reporting data via openway, obtained from the Guance console (required for public openway integration).                               |
| `site`                      | String      | Yes          |                   | Data reporting address for public openway, obtained from the Guance console (required for public openway integration).                                |
| `service`                   | String      | No           | `browser`         | Log Service name                                                                                                                                      |
| `env`                       | String      | No           |                   | Current environment of the web application, e.g., Prod: production environment; Gray: gray release environment; Pre: pre-release environment.        |
| `version`                   | String      | No           |                   | Version number of the web application                                                                                                                 |
| `sessionSampleRate`         | Number      | No           | `100`             | Percentage of Metrics data collected: `100` means full collection, `0` means no collection                                                             |
| `forwardErrorsToLogs`       | Boolean     | No           | `true`            | Set to `false` to stop collecting console.error, JS, and network errors in Guance log data                                                            |
| `silentMultipleInit`        | Boolean     | No           | `false`           | Prevent multiple log objects from being initialized                                                                                                   |
| `forwardConsoleLogs`        | String/Array|              |                   | Console log types to collect, options include: `error`, `log`, `info`, `warn`, `error`                                                               |
| `storeContextsToLocal`      | Boolean     | No           |                   | Version requirement: `>3.1.2`. Whether to cache user-defined data locally in localstorage, e.g., custom data added via `setUser`, `addGlobalContext` APIs. |
| `storeContextsKey`          | String      | No           |                   | Version requirement: `>3.1.18`. Define the key stored in localstorage, default is auto-generated. Mainly used to distinguish shared stores under the same domain. |

## Usage

After initializing the SDK in your application, you can customize log data using exposed JS APIs.

```javascript
logger.debug | info | warn | error | critical (message: string, messageContext = Context)
```

### NPM

```javascript
import { datafluxLogs } from '@cloudcare/browser-logs'

datafluxLogs.logger.info('Button clicked', { name: 'buttonName', id: 123 })
```

### CDN Asynchronous

```javascript
DATAFLUX_LOGS.onReady(function () {
  DATAFLUX_LOGS.logger.info('Button clicked', { name: 'buttonName', id: 123 })
})
```

### CDN Synchronous

```javascript
window.DATAFLUX_LOGS && DATAFLUX_LOGS.logger.info('Button clicked', { name: 'buttonName', id: 123 })
```

## Returned Data Structure

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

datafluxLogs.logger.log(<MESSAGE>, <JSON_ATTRIBUTES>, <STATUS>);
```

### CDN Asynchronous

```javascript
DATAFLUX_LOGS.onReady(function () {
  DATAFLUX_LOGS.logger.log(<MESSAGE>, <JSON_ATTRIBUTES>, <STATUS>);
})
```

### CDN Synchronous

```javascript
window.DATAFLUX_LOGS && DATAFLUX_LOGS.logger.log(<MESSAGE>, <JSON_ATTRIBUTES>, <STATUS>);
```

## Parameter Explanation

| **Parameter**            | **Description**                                                    |
| ------------------------ | ------------------------------------------------------------------- |
| `<MESSAGE>`              | Message field in Guance logs                                       |
| `<JSON_ATTRIBUTES>`      | Additional data describing the Message, as a JSON object           |
| `<STATUS>`               | Log level, options include `debug`, `info`, `warn`, `error`, `critical` |

## Adding Custom Tags

---

After initializing LOG, use the `setGlobalContextProperty(key:string, value:any)` API to add additional tags to all collected LOG events from the application.

### Adding Tags

=== "CDN Synchronous"

    ```javascript
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.setGlobalContextProperty('<CONTEXT_KEY>', '<CONTEXT_VALUE>');

    // Code example
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.setGlobalContextProperty('isvip', 'xxxx');
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.setGlobalContextProperty('activity', {
        hasPaid: true,
        amount: 23.42
    });
    ```

=== "CDN Asynchronous"

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

=== "CDN Synchronous"

    ```javascript
    window.DATAFLUX_LOGS &&
         window.DATAFLUX_LOGS.setGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

    // Code example
    window.DATAFLUX_LOGS &&
         window.DATAFLUX_LOGS.setGlobalContext({
            codeVersion: 34,
        });
    ```

=== "CDN Asynchronous"

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

=== "CDN Synchronous"

    ```javascript
    var context = window.DATAFLUX_LOGS &&  window.DATAFLUX_LOGS.getGlobalContext();

    ```

=== "CDN Asynchronous"

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

=== "CDN Synchronous"

    ```javascript
    var context = window.DATAFLUX_LOGS &&  window.DATAFLUX_LOGS.removeGlobalContextProperty('<CONTEXT_KEY>');

    ```

=== "CDN Asynchronous"

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

=== "CDN Synchronous"

    ```javascript
    var context = window.DATAFLUX_LOGS &&  window.DATAFLUX_LOGS.clearGlobalContext();

    ```

=== "CDN Asynchronous"

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

By default, the SDK automatically generates a unique ID for each user. This ID does not contain any identifying attributes and only distinguishes between different users. To provide more identifying attributes for the current user, additional APIs are available.

| Property       | Type   | Description               |
| -------------- | ------ | ------------------------- |
| user.id        | string | User ID                   |
| user.name      | string | Username or nickname      |
| user.email     | string | User email                |

**Note**: The following properties are optional, but it is recommended to provide at least one.

### Adding User Identification

=== "CDN Synchronous"

    ```javascript
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

=== "CDN Asynchronous"

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

=== "CDN Synchronous"

    ```javascript
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.clearUser()
    ```

=== "CDN Asynchronous"

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