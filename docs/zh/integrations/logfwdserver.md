---
title     : 'Log Forward'
summary   : '通过 sidecar 方式收集 Pod 内日志数据'
tags:
  - 'KUBERNETES'
  - '日志'
  - '容器'
__int_icon      : 'icon/logfwd'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

:material-kubernetes:

---

logfwdserver 会开启 websocket 功能，和 logfwd 配套使用，负责接收和处理 logfwd 发送的数据。

logfwd 的使用参见[这里](logfwd.md)。

## 配置 {#config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/log` 目录，复制 `logfwdserver.conf.sample` 并命名为 `logfwdserver.conf`。示例如下：
    
    ```toml
        
    [inputs.logfwdserver]
      address = "0.0.0.0:9533"
    
      [inputs.logfwdserver.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->
