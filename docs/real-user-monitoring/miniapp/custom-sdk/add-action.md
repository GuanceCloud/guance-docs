# 自定义添加 Action
---


初始化 RUM 后，使用`addAction（'<NAME>'，'<JSON_OBJECT>'）` API,可以自定义添加采集之外的action 指标数据

### 添加 Action

#### CDN 下载文件本地方式引入([下载地址](https://static.dataflux.cn/miniapp-sdk/v2/dataflux-rum-miniapp.js))

```javascript
const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
datafluxRum.addAction('<NAME>'，'<JSON_OBJECT>');

// Code example
datafluxRum && datafluxRum.addAction('cart', {
  amount: 42,
  nb_items: 2,
  items: ['socks', 't-shirt'],
});   

```

#### npm 引入(可参考微信官方[npm引入方式](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html))

```javascript
const { datafluxRum } = require('@cloudcare/rum-miniapp')
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