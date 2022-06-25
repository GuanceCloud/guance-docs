# 自定义添加额外的数据TAG
---


初始化 RUM 后，使用`addRumGlobalContext（key:string，value:any）` API 向从应用程序收集的所有 RUM 事件添加额外的TAG。

### 添加TAG

=== "CDN" 

    下载文件本地方式引入([下载地址](https://static.dataflux.cn/miniapp-sdk/v2/dataflux-rum-miniapp.js))

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    datafluxRum.addRumGlobalContext('<CONTEXT_KEY>', '<CONTEXT_VALUE>');

    // Code example
    datafluxRum.addRumGlobalContext('isvip', 'xxxx');

    datafluxRum.addRumGlobalContext('activity', {
        hasPaid: true,
        amount: 23.42
    });

    ```

=== "NPM"

    引入(可参考微信官方[npm引入方式](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')
    datafluxRum.addRumGlobalContext('<CONTEXT_KEY>', '<CONTEXT_VALUE>');

    // Code example
    datafluxRum.addRumGlobalContext('isvip', 'xxxx');

    datafluxRum.addRumGlobalContext('activity', {
        hasPaid: true,
        amount: 23.42
    });
    ```

### 替换TAG（覆盖）

=== "CDN"

    下载文件本地方式引入([下载地址](https://static.dataflux.cn/miniapp-sdk/v2/dataflux-rum-miniapp.js))

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')

    datafluxRum.setRumGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

    // Code example
    datafluxRum.setRumGlobalContext({
        codeVersion: 34,
    });
    ```

=== "NPM"

    引入(可参考微信官方[npm引入方式](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')

    datafluxRum.setRumGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

    // Code example
    datafluxRum.setRumGlobalContext({
        codeVersion: 34,
    });
    ```

### 获取所有设置的自定义TAG

=== "CDN"

    下载文件本地方式引入([下载地址](https://static.dataflux.cn/miniapp-sdk/v2/dataflux-rum-miniapp.js))

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')

    const context = datafluxRum.getRumGlobalContext();
    ```

=== "NPM"

    引入(可参考微信官方[npm引入方式](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')

    const context = datafluxRum.getRumGlobalContext();

    ```

### 移除特定key对应的自定义TAG

=== "CDN"

    下载文件本地方式引入([下载地址](https://static.dataflux.cn/miniapp-sdk/v2/dataflux-rum-miniapp.js))

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js');

    const context = datafluxRum.removeRumGlobalContext('<CONTEXT_KEY>');
    ```

=== "NPM"

    引入(可参考微信官方[npm引入方式](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')

    const context = datafluxRum.removeRumGlobalContext('<CONTEXT_KEY>');
    ```

