# Customized User Id
---

By default, the SDK automatically generates a unique ID for the user, which does not have any identifying attributes and can only distinguish between different user attributes.

For this reason we provide an additional API to add different identification attributes to the current user.

| Properties | Type   | Description               |
| ---------- | ------ | ------------------------- |
| user.id    | string | User ID                   |
| user.name  | string | User nickname or username |
| user.email | string | User Email                |

The following attributes are optional, but it is recommended that at least one of them be provided.

### Adding User Identification

=== "CDN" 

    Download files imported locally ([download address](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))
    
    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    datafluxRum.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

=== "NPM" 

    Introduction: (see WeChat official [npm introduction method](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))
    
    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

### Remove User Identification
=== "CDN" 

    Download files imported locally ([download address](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))
    
    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    datafluxRum.removeUser()
    ```

=== "NPM" 

    Introduction: (see WeChat official [npm introduction method](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))
    
    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.removeUser()
    ```

