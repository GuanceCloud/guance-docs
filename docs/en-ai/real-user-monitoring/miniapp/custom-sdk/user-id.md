# Custom User Identifiers
---

By default, the SDK automatically generates a unique identifier ID for users. This ID does not carry any identifying attributes and can only distinguish between different user properties. To address this, we provide an additional API to add different identifying attributes to the current user.

| Property     | Type   | Description               |
| ------------ | ------ | ------------------------- |
| user.id      | string | User ID                   |
| user.name    | string | User nickname or username |
| user.email   | string | User email                |

**Note**: The following properties are optional, but it is recommended to provide at least one of them.

### Adding User Identifiers

=== "CDN" 

    [Download File](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js) for local inclusion

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    datafluxRum.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

=== "NPM" 

    [Introduction](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

### Removing User Identifiers

=== "CDN" 

    [Download File](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js) for local inclusion

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    datafluxRum.removeUser()
    ```

=== "NPM" 

    [Introduction](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.removeUser()
    ```