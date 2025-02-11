# Custom Adding Action
---

After initializing RUM, use the `addAction('<NAME>', '<JSON_OBJECT>')` API to add custom Action metric data outside of the collected data.

### Add Action

=== "CDN Sync"

    ```javascript
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.addAction('<NAME>', '<JSON_OBJECT>');

    // Code example
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.addAction('cart', {
        amount: 42,
        nb_items: 2,
        items: ['socks', 't-shirt'],
    });
    ```

=== "CDN Async"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.addAction('<NAME>', '<JSON_OBJECT>');
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
    datafluxRum.addAction('<NAME>', '<JSON_OBJECT>');

    // Code example
    datafluxRum && datafluxRum.addAction('cart', {
        amount: 42,
        nb_items: 2,
        items: ['socks', 't-shirt'],
    });              
    ```