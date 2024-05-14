# 自定义添加额外的数据 TAG

---

初始化 RUM 后，使用 `setGlobalContextProperty:string，value:any）` API 向从应用程序收集的所有 RUM 事件添加额外的 TAG。

### 添加 TAG

=== "CDN 同步"

    ``` javascript
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.setGlobalContextProperty('<CONTEXT_KEY>', '<CONTEXT_VALUE>');

    // Code example
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.setGlobalContextProperty('isvip', 'xxxx');
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.setGlobalContextProperty('activity', {
        hasPaid: true,
        amount: 23.42
    });
    ```

=== "CDN 异步"

    ``` javascript
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.setGlobalContextProperty('<CONTEXT_KEY>', '<CONTEXT_VALUE>');
    })

    // Code example
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.setGlobalContextProperty('isvip', 'xxxx');
    })
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.setGlobalContextProperty('activity', {
            hasPaid: true,
            amount: 23.42
        });
    })

    ```

=== "NPM"

    ``` javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.setGlobalContextProperty('<CONTEXT_KEY>', <CONTEXT_VALUE>);

    // Code example
    datafluxRum && datafluxRum.setGlobalContextProperty('isvip', 'xxxx');
    datafluxRum.setGlobalContextProperty('activity', {
        hasPaid: true,
        amount: 23.42
    });
    ```

### 替换 TAG（覆盖）

=== "CDN 同步"

    ```javascript
    window.DATAFLUX_RUM &&
        DATAFLUX_RUM.setGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

    // Code example
    window.DATAFLUX_RUM &&
        DATAFLUX_RUM.setGlobalContext({
            codeVersion: 34,
        });
    ```

=== "CDN 异步"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.setGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });
    })

    // Code example
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.setGlobalContext({
            codeVersion: 34,
        })
    })
    ```

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'

    datafluxRum.setGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

    // Code example
    datafluxRum.setGlobalContext({
        codeVersion: 34,
    });
    ```

### 获取所有设置的自定义 TAG

=== "CDN 同步"

    ```javascript
    var context = window.DATAFLUX_RUM && DATAFLUX_RUM.getGlobalContext();

    ```

=== "CDN 异步"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        var context = DATAFLUX_RUM.getGlobalContext();
    });
    ```

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'

    const context = datafluxRum.getGlobalContext();

    ```

### 移除特定 key 对应的自定义 TAG

=== "CDN 同步"

    ```javascript
    var context = window.DATAFLUX_RUM && DATAFLUX_RUM.removeGlobalContextProperty('<CONTEXT_KEY>');

    ```

=== "CDN 异步"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        var context = DATAFLUX_RUM.removeGlobalContextProperty('<CONTEXT_KEY>');
    });
    ```

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'

    const context = datafluxRum.removeGlobalContextProperty('<CONTEXT_KEY>');
    ```

### 移除所有的自定义 TAG

=== "CDN 同步"

    ```javascript
    var context = window.DATAFLUX_RUM && DATAFLUX_RUM.clearGlobalContext();

    ```

=== "CDN 异步"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        var context = DATAFLUX_RUM.clearGlobalContext();
    });
    ```

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'

    const context = datafluxRum.clearGlobalContext();
    ```
