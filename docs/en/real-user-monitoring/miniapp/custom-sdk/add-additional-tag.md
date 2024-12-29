# Customize to Add Additional Data TAG

---

After initializing the RUM, use the `addRumGlobalContext(key:string, value:any)` API to add additional TAGs to all RUM events collected from the application.

### Add TAG

=== "CDN"

    Download files imported locally ([download address](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    datafluxRum.addRumGlobalContext('<CONTEXT_KEY>', '<CONTEXT_VALUE>');

    // Code example
    datafluxRum.addRumGlobalContext('isvip', 'xxxx');

    datafluxRum.addRumGlobalContext('activity', {
        hasPaid: true,
        amount: 23.42
    });

    ```

=== "NPM"

    Introduction: (see WeChat official [npm introduction method](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')
    datafluxRum.addRumGlobalContext('<CONTEXT_KEY>', '<CONTEXT_VALUE>');

    // Code example
    datafluxRum.addRumGlobalContext('isvip', 'xxxx');

    datafluxRum.addRumGlobalContext('activity', {
        hasPaid: true,
        amount: 23.42
    });
    ```

### Replace TAG (Override)

=== "CDN"

    Download files imported locally ([download address](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')

    datafluxRum.setRumGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

    // Code example
    datafluxRum.setRumGlobalContext({
        codeVersion: 34,
    });
    ```

=== "NPM"

    Introduction: (see WeChat official [npm introduction method](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')

    datafluxRum.setRumGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

    // Code example
    datafluxRum.setRumGlobalContext({
        codeVersion: 34,
    });
    ```

### Get All Set Custom TAGs

=== "CDN"

    Introduction: (see WeChat official [npm introduction method](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')

    const context = datafluxRum.getRumGlobalContext();
    ```

=== "NPM"

    Introduction: (see WeChat official [npm introduction method](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')

    const context = datafluxRum.getRumGlobalContext();

    ```

### Remove the Custom TAG Corresponding to Specific Key

=== "CDN"

    Download files imported locally ([download address](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js');

    const context = datafluxRum.removeRumGlobalContext('<CONTEXT_KEY>');
    ```

=== "NPM"

    Introduction: (see WeChat official [npm introduction method](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')

    const context = datafluxRum.removeRumGlobalContext('<CONTEXT_KEY>');
    ```

### Clear all the Custom TAG

=== "CDN"

    Download files imported locally ([download address](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js');

    const context = datafluxRum.clearRumGlobalContext();
    ```

=== "NPM"

    Introduction: (see WeChat official [npm introduction method](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')

    const context = datafluxRum.clearRumGlobalContext();
    ```
