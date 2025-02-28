# 日志采集
---


<<< custom_key.brand_name >>>拥有全面的日志采集能力，主要分成<u>主机日志采集和 K8S 容器日志采集</u>，两者 DataKit 的安装方式不同，日志采集的方式也不尽相同。采集的日志数据统一汇总到<<< custom_key.brand_name >>>进行统一存储、搜索和分析，帮助我们快速定位问题并解决问题。

本文主要介绍如何在**主机环境**下采集日志，关于在 K8S 环境采集日志可参考最佳实践 [Kubernetes 集群中日志采集的几种玩法](../best-practices/cloud-native/k8s-logs.md)。

## 前置条件

[安装 DataKit](../datakit/datakit-install.md)。                

或者您也可以登录 [<<< custom_key.brand_name >>>](https://auth.guance.com/login/pwd)，在**集成 > DataKit**，根据主机系统选择 **Linux、Windows、MacOS**，获取 DataKit 安装指令和安装步骤。

## 日志采集器配置

DataKit 安装完成后，您可以通过开启标准日志采集或者自定义日志采集两种方式，对来自于系统日志、应用日志如 Nginx、Redis、Docker、ES 等多种日志数据进行日志采集。

=== "自定义日志采集器"

    进入 DataKit 安装目录下的 `conf.d/log` 目录，复制 `logging.conf.sample` 并命名为 `logging.conf` 进行配置。配置完成后，重启 DataKit 即可生效。
    
    > 详情可参考[主机日志采集](../integrations/logging.md)。

=== "标准日志采集器"

    通过开启<<< custom_key.brand_name >>>支持的标准日志采集器，如 [Nginx](../integrations/nginx.md)、[Redis](../integrations/redis.md)、[ES](../integrations/elasticsearch.md) 等，您可以一键开启日志采集。

???+ warning "注意"

    配置日志采集器时，需开通日志的 Pipeline 功能，提取日志时间 `time` 和日志等级 `status` 的字段：
    
    - `time`：日志的产生时间，如果没有提取 `time` 字段或解析此字段失败，默认使用系统当前时间；
    - `status`：日志的等级，如果没有提取出 `status` 字段，则默认将 `stauts` 置为 `unknown`。
    
    > 更多详情可参考文档 [Pipeline 配置和使用](../integrations/logging.md#pipeline)。



## 日志数据存储

日志采集器配置完成后，重启 DataKit，日志数据就可以统一上报到<<< custom_key.brand_name >>>工作空间。

- 对于日志数据量比较多的用户来说，我们可以通过配置 [日志索引](./multi-index/index.md) 或者 [日志黑名单](../getting-started/function-details/logs-blacklist.md) 来节约数据存储费用；
- 对于需要日志长久存储的用户来说，我们可以通过 [日志备份](../management/backup/index.md)来保存日志数据。

