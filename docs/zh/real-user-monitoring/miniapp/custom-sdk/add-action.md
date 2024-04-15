# 自定义添加 Action
---


初始化 RUM 后，使用 `addAction（'<NAME>'，'<JSON_OBJECT>'）` API，可以自定义添加采集之外的 Action 指标数据。

### 添加 Action

=== "CDN" 

    [下载文件](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js)本地方式引入

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

    [引入](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)

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

