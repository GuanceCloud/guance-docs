# Custom Addition of Extra Data TAG

---

After initializing RUM, use the `addRumGlobalContext(key:string, value:any)` API to add extra TAGs to all RUM events collected from the application.

### Adding TAGs

=== "CDN"

    [Download File](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js) and include it locally

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

    [Include via NPM](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)

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

### Replacing TAGs (Overwrite)

=== "CDN"

    [Download File](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js) and include it locally

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')

    datafluxRum.setRumGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

    // Code example
    datafluxRum.setRumGlobalContext({
        codeVersion: 34,
    });
    ```

=== "NPM"

    [Include via NPM](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')

    datafluxRum.setRumGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

    // Code example
    datafluxRum.setRumGlobalContext({
        codeVersion: 34,
    });
    ```

### Retrieving All Set Custom TAGs

=== "CDN"

    [Download File](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js) and include it locally

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')

    const context = datafluxRum.getRumGlobalContext();
    ```

=== "NPM"

    [Include via NPM](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')

    const context = datafluxRum.getRumGlobalContext();

    ```

### Removing Specific Key's Custom TAG

=== "CDN"

    [Download File](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js) and include it locally

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js');

    const context = datafluxRum.removeRumGlobalContext('<CONTEXT_KEY>');
    ```

=== "NPM"

    [Include via NPM](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')

    const context = datafluxRum.removeRumGlobalContext('<CONTEXT_KEY>');
    ```

### Clearing All Custom TAGs

=== "CDN"

    [Download File](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js) and include it locally

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js');

    const context = datafluxRum.clearRumGlobalContext();
    ```

=== "NPM"

    [Include via NPM](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')

    const context = datafluxRum.clearRumGlobalContext();
    ```