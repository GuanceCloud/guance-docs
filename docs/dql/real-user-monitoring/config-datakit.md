# 配置用户访问监测所需的DataKit
---

## 简介

应用的用户访问监测数据采集到的 “观测云” 后，可以通过 “观测云” 控制台进行自定义配置场景，对应用的用户访问情况数据进行可视化洞察与分析。

## 前置条件

要开启应用用户访问监测功能，首先需要部署一个公网 DataKit 作为 agent，客户端的用户访问数据通过这个 agent 后将数据打到 DataFlux 中心，具体的 DataKit 安装方法与配置方法，见[DataKit 安装文档](https://www.yuque.com/dataflux/datakit/datakit-install)。

DataKit安装完成后，默认开启[RUM采集器](https://www.yuque.com/dataflux/datakit/rum)，即可开始采集用户访问的相关数据。
## 部署架构

![](img/rum-arch.png)


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![](img/logo_2.png)

