# 第三方框架支持
---

## 调用原理
第三方框架 SDK 依赖原生 SDK
### SDK 结构

- AutoTrack 负责原生应用行为，从而自动生成 RUM，Log，Trace 数据
- Open API 对外开放接口
- DataSync 数据同步模块，将数据同步至 Datakit

![](../img/sdk_arch.png)

### 第三方框架数据追踪

![](../img/third-part.png)

## 开发进程

- [Flutter](https://www.yuque.com/dataflux/doc/nst0ca)（试验版）
- [React Native ](https://www.yuque.com/dataflux/doc/gza592)（试验版）


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![](../img/logo_2.png)




