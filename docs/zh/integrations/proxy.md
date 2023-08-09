---
title     : 'Proxy'
summary   : '代理 Datakit 的 HTTP 请求'
__int_icon      : 'icon/proxy'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# DataKit 代理
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

代理 Datakit 的请求，将其数据从内网发送到公网。

<!-- TODO: 此处缺一个代理的网络流量拓扑图 -->

## 配置 {#config}

挑选网络中的一个能访问外网的 DataKit，作为代理，配置其代理设置。

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/proxy` 目录，复制 `proxy.conf.sample` 并命名为 `proxy.conf`。示例如下：
    
    ```toml
        
    [[inputs.proxy]]
      ## default bind ip address
      bind = "0.0.0.0"
      ## default bind port
      port = 9530
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标 {#metric}

本采集器，暂无指标输出。
