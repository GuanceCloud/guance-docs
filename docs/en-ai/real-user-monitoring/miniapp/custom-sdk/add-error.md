# Custom Adding Error
---

After initializing RUM, use the `addError('<NAME>', '<JSON_OBJECT>')` API to add custom Error Metrics data outside of the collected data.

### Add Error

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

In this documentation, the term "RUM" refers to User Access Monitoring (RUM). The `addError` function allows you to add custom error data that can be used for further analysis and troubleshooting.