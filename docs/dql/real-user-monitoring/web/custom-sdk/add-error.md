# 自定义添加 Error
---


初始化 RUM 后，使用`addError（'<NAME>'，'<JSON_OBJECT>'）` API,可以自定义添加采集之外的 error 指标数据

### 添加 Error

#### CDN 同步

```javascript
// Send a custom error with context
const error = new Error('Something wrong occurred.');

window.DATAFLUX_RUM && DATAFLUX_RUM.addError(error, {
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

#### CDN 异步

```javascript
// Send a custom error with context
const error = new Error('Something wrong occurred.');

DATAFLUX_RUM.onReady(function() {
    DATAFLUX_RUM.addError(error, {
        pageStatus: 'beta',
    });
});

// Send a network error
fetch('<SOME_URL>').catch(function(error) {
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.addError(error);
    });
})

// Send a handled exception error
try {
    //Some code logic
} catch (error) {
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.addError(error);
    })
}
```

#### NPM

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'

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


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![](../../img/logo_2.png)
