# 自定义用户标识
---


SDK 默认情况下，自动会给用户生成一个唯一标识ID。这个ID不带任何标识属性，只能区别出不同用户属性。
为此我们提供了额外的API去给当前用户添加不同的标识属性。

| 属性 | 类型 | 描述 |
| --- | --- | --- |
| user.id | string | 用户ID |
| user.name | string | 用户昵称或者用户名 |
| user.email | string | 用户邮箱 |

以下属性是可选的，但建议至少提供其中一个。

### 添加用户标识

#### CDN 同步

```javascript
window.DATAFLUX_RUM && window.DATAFLUX_RUM.setUser({
    id: '1234',
    name: 'John Doe',
    email: 'john@doe.com',
})
```

#### CDN 异步

```javascript
DATAFLUX_RUM.onReady(function() {
    DATAFLUX_RUM.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
})
```

#### NPM

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum.setUser({
    id: '1234',
    name: 'John Doe',
    email: 'john@doe.com',
})
```

### 移除用户标识

#### CDN 同步

```javascript
window.DATAFLUX_RUM && window.DATAFLUX_RUM.removeUser()
```

#### CDN 异步

```javascript
DATAFLUX_RUM.onReady(function() {
    DATAFLUX_RUM.removeUser()
})
```

#### NPM

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum.removeUser()
```


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![](../../img/logo_2.png)