# 自定义添加额外的数据TAG
---


初始化 RUM 后，使用`addRumGlobalContext（key:string，value:any）` API 向从应用程序收集的所有 RUM 事件添加额外的TAG。

### 添加TAG

#### CDN 同步

```javascript
window.DATAFLUX_RUM && window.DATAFLUX_RUM.addRumGlobalContext('<CONTEXT_KEY>', '<CONTEXT_VALUE>');

// Code example
window.DATAFLUX_RUM && window.DATAFLUX_RUM.addRumGlobalContext('isvip', 'xxxx');
window.DATAFLUX_RUM && window.DATAFLUX_RUM.addRumGlobalContext('activity', {
    hasPaid: true,
    amount: 23.42
});
```

#### CDN 异步

```javascript
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

#### NPM

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum.addRumGlobalContext('<CONTEXT_KEY>', <CONTEXT_VALUE>);

// Code example
datafluxRum && datafluxRum.addRumGlobalContext('isvip', 'xxxx');                     
datafluxRum.addRumGlobalContext('activity', {
    hasPaid: true,
    amount: 23.42
});
```

### 替换TAG（覆盖）

#### CDN 同步

```javascript
window.DATAFLUX_RUM &&
    DATAFLUX_RUM.setRumGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

// Code example
window.DATAFLUX_RUM &&
    DATAFLUX_RUM.setRumGlobalContext({
        codeVersion: 34,
    });
```

#### CDN 异步

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

#### NPM

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'

datafluxRum.setRumGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

// Code example
datafluxRum.setRumGlobalContext({
    codeVersion: 34,
});
```

### 获取所有设置的自定义TAG

#### CDN 同步

```javascript
var context = window.DATAFLUX_RUM && DATAFLUX_RUM.getRumGlobalContext();

```

#### CDN 异步

```javascript
DATAFLUX_RUM.onReady(function() {
  var context = DATAFLUX_RUM.getRumGlobalContext();
});
```

#### NPM

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'

const context = datafluxRum.getRumGlobalContext();

```

### 移除特定key对应的自定义TAG

#### CDN 同步

```javascript
var context = window.DATAFLUX_RUM && DATAFLUX_RUM.removeRumGlobalContext('<CONTEXT_KEY>');

```

#### CDN 异步

```javascript
DATAFLUX_RUM.onReady(function() {
  var context = DATAFLUX_RUM.removeRumGlobalContext('<CONTEXT_KEY>');
});
```

#### NPM

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'

const context = datafluxRum.removeRumGlobalContext('<CONTEXT_KEY>');
```


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![](../../img/logo_2.png)