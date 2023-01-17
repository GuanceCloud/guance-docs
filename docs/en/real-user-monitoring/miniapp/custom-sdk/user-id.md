# 自定义用户标识
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

    下载文件本地方式引入([下载地址](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))
    
    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    datafluxRum.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

=== "NPM" 

    引入(可参考微信官方[npm引入方式](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))
    
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

    下载文件本地方式引入([下载地址](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js))
    
    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    datafluxRum.removeUser()
    ```

=== "NPM" 

    引入(可参考微信官方[npm引入方式](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))
    
    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.removeUser()
    ```

