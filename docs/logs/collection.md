# 日志采集
---

## 简介
观测云拥有全面的日志采集能力，您可以通过开启标准日志采集和配置自定义日志采集两种方式，对来自于Ngnix、Redis、Docker、ES、Windows/Linux/MacOS主机等多种日志数据进行日志采集。若您需要自定义日志数据采集，您可以通过配置对应的日志采集器，对日志采集的绝对路径、过滤条件、标签等进行配置。同时，“观测云” 为您提供了「日志过滤」功能，即通过添加日志过滤规则，符合该规则的日志数据将不会上报到工作平台。

## 前置条件

- 安装 DataKit（[DataKit 安装文档](../datakit/datakit-install.md)）

## 数据采集

DataKit 安装完成后，你需要开启并配置日志采集器。“观测云” 支持标准日志采集和自定义日志采集。

- 标准日志采集：通过开启观测云支持的日志采集器，如[Nginx](../integrations/nginx.md)、[Redis](../integrations/redis.md)、[ES](../integrations/elasticsearch.md)等，你可以一键开启日志采集。
- 自定义日志采集：进入 DataKit 安装目录下的 `conf.d/log` 目录，复制 `logging.conf.sample` 并命名为 `logging.conf`进行配置。配置完成后，重启 DataKit 即可生效。详情可参考[日志采集](../integrations/logging.md)。

注意：日志采集器开启后，需开通日志 Pipeline 功能，更多关于Pipeline使用可参考文档 [Pipeline](pipelines/index.md) 。
