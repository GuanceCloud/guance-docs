# 自定义添加 Action
---


初始化 RUM 后，使用 `addAction（'<NAME>'，'<JSON_OBJECT>'）` API，可以自定义添加采集之外的 Action 指标数据。

### 添加 Action

=== "CDN 同步"

    ```javascript
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.addAction('<NAME>'，'<JSON_OBJECT>');

    // Code example
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.addAction('cart', {
        amount: 42,
        nb_items: 2,
        items: ['socks', 't-shirt'],
    });
    ```

=== "CDN 异步"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.addAction('<NAME>'，'<JSON_OBJECT>');
    })

    // Code example
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.addAction('cart', {
        amount: 42,
        nb_items: 2,
        items: ['socks', 't-shirt'],
    });
    })
    ```

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.addAction('<NAME>'，'<JSON_OBJECT>');

    // Code example
    datafluxRum && datafluxRum.addAction('cart', {
        amount: 42,
        nb_items: 2,
        items: ['socks', 't-shirt'],
    });              
    ```