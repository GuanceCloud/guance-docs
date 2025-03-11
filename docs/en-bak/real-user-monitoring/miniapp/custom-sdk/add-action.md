# Custom Add Action
---


After initializing RUM, use the `addAction('<NAME>', '<JSON_OBJECT>')` API to customize and add action metrics other than those collected

### Add Action

=== "CDN" 

    Download files imported locally ([download address](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))
    
    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    datafluxRum.addAction('<NAME>'，'<JSON_OBJECT>');
    
    // Code example
    datafluxRum && datafluxRum.addAction('cart', {
        amount: 42,
        nb_items: 2,
        items: ['socks', 't-shirt'],
    });   
    ```
=== "NPM"

    Introduction: (see WeChat official [npm introduction method](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))
    
    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')
    datafluxRum.addAction('<NAME>'，'<JSON_OBJECT>');
    
    // Code example
    datafluxRum && datafluxRum.addAction('cart', {
        amount: 42,
        nb_items: 2,
        items: ['socks', 't-shirt'],
    });   
    ```

