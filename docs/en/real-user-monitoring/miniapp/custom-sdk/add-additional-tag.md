# Customize to Add Additional Data TAG
---


After initializing the RUM, use the `addRumGlobalContext(key:string, value:any)` API to add additional TAGs to all RUM events collected from the application.

### Add TAG

=== "CDN" 

    下载文件本地方式引入([下载地址](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))
    
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

    引入(可参考微信官方[npm引入方式](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))
    
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

    下载文件本地方式引入([下载地址](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))
    
    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    
    datafluxRum.setRumGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });
    
    // Code example
    datafluxRum.setRumGlobalContext({
        codeVersion: 34,
    });
    ```

=== "NPM"

    引入(可参考微信官方[npm引入方式](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))
    
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

    下载文件本地方式引入([下载地址](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))
    
    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    
    const context = datafluxRum.getRumGlobalContext();
    ```

=== "NPM"

    引入(可参考微信官方[npm引入方式](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))
    
    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')
    
    const context = datafluxRum.getRumGlobalContext();
    
    ```

### Remove the Custom TAG Corresponding to Specific Key

=== "CDN"

    下载文件本地方式引入([下载地址](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))
    
    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js');
    
    const context = datafluxRum.removeRumGlobalContext('<CONTEXT_KEY>');
    ```

=== "NPM"

    引入(可参考微信官方[npm引入方式](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))
    
    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')
    
    const context = datafluxRum.removeRumGlobalContext('<CONTEXT_KEY>');
    ```

