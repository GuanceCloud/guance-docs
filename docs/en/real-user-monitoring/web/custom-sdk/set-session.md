# Custom Setting Session
---

By setting a custom session ID you can track the entire session flow for a specific session. For example, by setting the session ID to `debug_session_xx`, the SDK will replace the session ID in the reported data with the ID you specify. After the data report is complete, you can track all the `view`, `error`, `action` and `resource` data in the session cycle on the [Guance](https://console.guance.com/) platform based on this session ID.

### Add Session

=== "CDN Sync"

    ```javascript
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.addDebugSession('debug_session_xx') 
    // session ID 最好能指定为特定场景下，可以识别的字符
    ```

=== "CDN Async"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.addDebugSession('debug_session_xx') 
    })
    // session ID 最好能指定为特定场景下，可以识别的字符
    ```

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.addDebugSession()
    // session ID 最好能指定为特定场景下，可以识别的字符
    ```

> Note: The session ID is set to expire in 15 minutes by default without any action or active removal. 

### Get Session Information

If a custom session is set, the session information API allows you to get the id (session ID) and created (creation time) set in the current state.

=== "CDN Sync"

    ```javascript
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.getDebugSession() 
    // {
    //	created: 1628653003152, 毫秒时间戳,
    //  format_created: 2021-08-11 11:39:32.455, 格式化时间,
    //  id: xxxx, 设置的自定义id
    // }
    ```

=== "CDN Async"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.getDebugSession() 
        // {
        //	created: 1628653003152, 毫秒时间戳,
        //  format_created: 2021-08-11 11:39:32.455, 格式化时间,
        //  id: xxxx, 设置的自定义id
        // }
    })
    
    ```

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.getDebugSession()
    // {
    //	created: 1628653003152, 毫秒时间戳,
    //  format_created: 2021-08-11 11:39:32.455, 格式化时间,
    //  id: xxxx, 设置的自定义id
    // }
    
    ```

### Remove Custom Session
=== "CDN Sync"

    ```javascript
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.clearDebugSession() 
    ```

=== "CDN Async"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.clearDebugSession() 
    })
    
    ```

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.clearDebugSession()
    ```
