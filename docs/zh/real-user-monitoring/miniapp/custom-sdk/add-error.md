# 自定义添加 Error
---


初始化 RUM 后，使用 `addError（'<NAME>'，'<JSON_OBJECT>'）` API，可以自定义添加采集之外的 Error 指标数据。

### 添加 Error

=== "CDN"

    ```javascript
    // Send a custom error with context
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    const error = new Error('Something wrong occurred.');

    datafluxRum.addError(error, {
        pageStatus: 'beta',
    });

    // Send a network error
    fetch('<SOME_URL>').catch(function(error) {
        window.DATAFLUX_RUM && DATAFLUX_RUM.addError(error);
    })

    // Send a handled exception error
    try {
        //Some code logic
    } catch (error) {
        window.DATAFLUX_RUM && DATAFLUX_RUM.addError(error);
    }

    ```

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'

    const { datafluxRum } = require('@cloudcare/rum-miniapp')
    // Send a custom error with context
    const error = new Error('Something wrong occurred.');

    datafluxRum.addError(error, {
        pageStatus: 'beta',
    });

    // Send a network error
    fetch('<SOME_URL>').catch(function(error) {
        datafluxRum.addError(error);
    })

    // Send a handled exception error
    try {
        //Some code logic
    } catch (error) {
        datafluxRum.addError(error);
    }         

    ```

