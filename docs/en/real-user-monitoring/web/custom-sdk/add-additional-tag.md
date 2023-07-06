# Customize to Add Additional Data TAG
---

After initializing RUM, use the `addRumGlobalContext(key:string, value:any)` API to add additional TAGs to all RUM events collected from the application.

### Add TAG
=== "CDN Sync"

    ``` javascript
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.addRumGlobalContext('<CONTEXT_KEY>', '<CONTEXT_VALUE>');
    
    // Code example
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.addRumGlobalContext('isvip', 'xxxx');
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.addRumGlobalContext('activity', {
        hasPaid: true,
        amount: 23.42
    });
    ```
=== "CDN Async"

    ``` javascript
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.addRumGlobalContext('<CONTEXT_KEY>', '<CONTEXT_VALUE>');
    })
    
    // Code example
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.addRumGlobalContext('isvip', 'xxxx');
    })
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.addRumGlobalContext('activity', {
            hasPaid: true,
            amount: 23.42
        });
    })
    
    ```
=== "NPM"

    ``` javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.addRumGlobalContext('<CONTEXT_KEY>', <CONTEXT_VALUE>);
    
    // Code example
    datafluxRum && datafluxRum.addRumGlobalContext('isvip', 'xxxx');                     
    datafluxRum.addRumGlobalContext('activity', {
        hasPaid: true,
        amount: 23.42
    });
    ```

### Replace TAG (Override)

=== "CDN Sync"

    ```javascript
    window.DATAFLUX_RUM &&
        DATAFLUX_RUM.setRumGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });
    
    // Code example
    window.DATAFLUX_RUM &&
        DATAFLUX_RUM.setRumGlobalContext({
            codeVersion: 34,
        });
    ```
=== "CDN Async"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.setRumGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });
    })
    
    // Code example
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.setRumGlobalContext({
            codeVersion: 34,
        })
    })
    ```
=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    
    datafluxRum.setRumGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });
    
    // Code example
    datafluxRum.setRumGlobalContext({
        codeVersion: 34,
    });
    ```

### Get All Set Custom TAGs

=== "CDN Sync"

    ```javascript
    var context = window.DATAFLUX_RUM && DATAFLUX_RUM.getRumGlobalContext();
    
    ```
=== "CDN Async"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        var context = DATAFLUX_RUM.getRumGlobalContext();
    });
    ```
=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    
    const context = datafluxRum.getRumGlobalContext();
    
    ```

### Remove the Custom TAG Corresponding to Specific Key

=== "CDN Sync"

    ```javascript
    var context = window.DATAFLUX_RUM && DATAFLUX_RUM.removeRumGlobalContext('<CONTEXT_KEY>');
    
    ```
=== "CDN Async"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        var context = DATAFLUX_RUM.removeRumGlobalContext('<CONTEXT_KEY>');
    });
    ```
=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    
    const context = datafluxRum.removeRumGlobalContext('<CONTEXT_KEY>');
    ```

