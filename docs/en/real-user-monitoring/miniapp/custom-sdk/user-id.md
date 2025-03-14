# Custom User Identifier
---

By default, the SDK automatically generates a unique identifier ID for users. This ID does not carry any identifying attributes and can only distinguish between different user properties. Therefore, we provide additional APIs to add different identifying attributes to the current user.

| Property   | Type   | Description               |
| ---------- | ------ | ------------------------- |
| user.id    | string | User ID                   |
| user.name  | string | User nickname or username |
| user.email | string | User email                |

**Note**: The following properties are optional, but it is recommended to provide at least one of them.

### Add User Identifier

=== "CDN" 

    [Download file](https://static.<<< custom_key.brand_main_domain >>>/miniapp-sdk/v2/dataflux-rum-miniapp.js) for local introduction

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

### Remove User Identifier

=== "CDN" 

    [Download file](https://static.<<< custom_key.brand_main_domain >>>/miniapp-sdk/v2/dataflux-rum-miniapp.js) for local introduction

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