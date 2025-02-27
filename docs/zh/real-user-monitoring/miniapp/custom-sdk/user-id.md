# 自定义用户标识
---


SDK 默认情况下，自动会给用户生成一个唯一标识 ID。这个 ID 不带任何标识属性，只能区别出不同用户属性。为此我们提供了额外的 API 去给当前用户添加不同的标识属性。

| 属性       | 类型   | 描述               |
| ---------- | ------ | ------------------ |
| user.id    | string | 用户 ID             |
| user.name  | string | 用户昵称或者用户名 |
| user.email | string | 用户邮箱           |

**注意**：以下属性是可选的，但建议至少提供其中一个。

### 添加用户标识

=== "CDN" 

    [下载文件](https://<<< custom_key.static_domain >>>/miniapp-sdk/v2/dataflux-rum-miniapp.js)本地方式引入

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    datafluxRum.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

=== "NPM" 

    [引入](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

### 移除用户标识

=== "CDN" 

    [下载文件](https://<<< custom_key.static_domain >>>/miniapp-sdk/v2/dataflux-rum-miniapp.js)本地方式引入

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    datafluxRum.removeUser()
    ```

=== "NPM" 

    [引入](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.removeUser()
    ```

