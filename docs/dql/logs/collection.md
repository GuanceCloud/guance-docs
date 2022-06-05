# 日志采集
---

## 简介
“观测云” 拥有全面的日志采集能力，您可以通过开启标准日志采集和配置自定义日志采集两种方式，对来自于Ngnix、Redis、Docker、ES、Windows/Linux/MacOS主机等多种日志数据进行日志采集。若您需要自定义日志数据采集，您可以通过配置对应的日志采集器，对日志采集的绝对路径、过滤条件、标签等进行配置。同时，“观测云” 为您提供了「日志过滤」功能，即通过添加日志过滤规则，符合该规则的日志数据将不会上报到工作平台。

## 前置条件

- 安装 DataKit（[DataKit 安装文档](https://www.yuque.com/dataflux/datakit/datakit-install)）

## 数据采集

DataKit 安装完成后，你需要开启并配置日志采集器。“观测云” 支持标准日志采集和自定义日志采集。

- 标准日志采集：通过开启“观测云”支持的日志采集器，如[Nginx](https://www.yuque.com/dataflux/datakit/nginx#62b5133f)、[Redis](https://www.yuque.com/dataflux/datakit/redis#62b5133f)、[Docker](https://www.yuque.com/dataflux/datakit/docker)、[ES](https://www.yuque.com/dataflux/datakit/elasticsearch#62b5133f)等，你可以一键开启日志采集。
- 自定义日志采集：进入 DataKit 安装目录下的 `conf.d/log` 目录，复制 `logging.conf.sample` 并命名为 `logging.conf`进行配置。配置完成后，重启 DataKit 即可生效。详情可参考[日志采集](https://www.yuque.com/dataflux/datakit/logging)。

注意：日志采集器开启后，需开通日志 Pipeline 功能，更多关于Pipeline使用可参考文档 [Pipeline](https://www.yuque.com/dataflux/doc/caczze) 。


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![logo_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642758850050-dd65be15-ef8f-4827-9656-60ca37ae3e9d.png#clientId=u523a84ff-d8ca-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ube1f8bcc&margin=%5Bobject%20Object%5D&name=logo_2.png&originHeight=169&originWidth=746&originalType=binary&ratio=1&rotation=0&showTitle=false&size=139415&status=done&style=none&taskId=ue5d4a35d-7950-484b-856e-3d5ce38ee01&title=)
