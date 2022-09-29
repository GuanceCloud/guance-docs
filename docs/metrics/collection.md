# 指标采集
---

## 简介

观测云具有全域数据采集能力，支持多种标准采集器，可快速配置数据源，轻松采集上百种类型数据。

## 数据采集

采集指标有两种方式，前提是都需要先创建一个[观测云账号](https://auth.guance.com/register)，并在主机上[安装 DataKit](../datakit/datakit-install.md) 。

- 第一种方式：登录控制台，进入「集成」页面，安装完 DataKit 以后，开启需要采集指标的采集器，如[CPU采集器](../datakit/cpu.md)、[Nginx采集器](../datakit/nginx.md)等等；
- 第二种方式是通过 [DataKit API](../datakit/apis.md) 方式，[通过 DataKit 自定义写入指标数据](../dataflux-func/write-data-via-datakit.md)，观测云提供了 [DataFlux Func 函数处理平台](../dataflux-func/quick-start.md)，集成大量现成的函数，帮您快速上报数据进行整体可观测。

![](img/2.datakit_1.png)

## 删除指标数据

观测云支持管理员删除空间内的指标集，进入「管理」-「基本设置」，点击「删除指标集」后，输入完整的指标集名称，点击「确定」即可删除。

???+ attention

    - 只允许空间拥有者和管理员进行此操作；
    - 指标集一经删除，无法恢复，请谨慎操作

![](img/3.metric_10.png)
