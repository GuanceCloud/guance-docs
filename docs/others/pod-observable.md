# 如何采集 Pod 对象
---

## 简介


“观测云” 支持采集当前主机上 Kubelet Pod 指标和对象，并上报到 “观测云” 中。在「基础设施」的「容器」，您可以快速查看和分析工作空间内全部 Container 和 pod 的数据信息。

## 前置条件

- 安装 DataKit（[DataKit 安装文档](https://www.yuque.com/dataflux/datakit/datakit-how-to)）
- DataKit 版本：1.1.8-rc1.1 及以上
- 操作系统支持：`linux`
- 安装 Docker v17.04 及以上版本。

## 方法/步骤

### Step1：开启采集器

安装/升级 datakit 后，进入 DataKit 安装目录下的 `conf.d/container` 目录，复制 `container.conf.sample` 并命名为 `container.conf`。更多详情请参考 [容器配置](https://www.yuque.com/dataflux/datakit/container#224e2ccd)。

### Step2：开启 Pod 的指标采集

采集器默认不采集 Kubelet Pod 的指标数据，如需开启指标采集，请在配置文件中，将 `enable_metric` 改为 `true` 并重启 DataKit。

配置过程如下：

1. 进入 DataKit 安装目录下的`conf.d/container` 目录
1. 复制 `container.conf.sample` 并命名为 `container.conf`
1. 打开 `container.conf`  ，将`enable_metric` 改为 `true` 
1. 配置完成后， 重启datakit 即可生效

更多详情请参考 [容器配置](https://www.yuque.com/dataflux/datakit/container#224e2ccd)。

## 其他

更多详细的Pod数据采集的配置方法和指标说明，可查看[容器采集](https://www.yuque.com/dataflux/datakit/container)。

