# 自定义添加 Action
---


初始化 RUM 后，使用`addAction（'<NAME>'，'<JSON_OBJECT>'）` API,可以自定义添加采集之外的action 指标数据

### 添加 Action

#### CDN 同步

```javascript
window.DATAFLUX_RUM && window.DATAFLUX_RUM.addAction('<NAME>'，'<JSON_OBJECT>');

// Code example
window.DATAFLUX_RUM && window.DATAFLUX_RUM.addAction('cart', {
   amount: 42,
   nb_items: 2,
   items: ['socks', 't-shirt'],
});

```

#### CDN 异步

```javascript
DATAFLUX_RUM.onReady(function() {
    DATAFLUX_RUM.addAction('<NAME>'，'<JSON_OBJECT>');
})

// Code example
DATAFLUX_RUM.onReady(function() {
    DATAFLUX_RUM.addAction('cart', {
     amount: 42,
     nb_items: 2,
     items: ['socks', 't-shirt'],
  });
})

```

#### NPM

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum.addAction('<NAME>'，'<JSON_OBJECT>');

// Code example
datafluxRum && datafluxRum.addAction('cart', {
  amount: 42,
  nb_items: 2,
  items: ['socks', 't-shirt'],
});              

```


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![](../../img/logo_2.png)
