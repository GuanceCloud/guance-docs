---
title     : 'etcd'
summary   : '采集 etcd 的指标数据'
__int_icon      : 'icon/etcd'
dashboard :
  - desc  : 'etcd'
    path  : 'dashboard/zh/etcd'
  - desc  : 'etcd-k8s'
    path  : 'dashboard/zh/etcd-k8s'    
monitor   :
  - desc  : '暂无'            # 缺少监控视图示例
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# etcd
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "Election Enabled")

---

etcd 采集器可以从 etcd 实例中采取很多指标，比如 etcd 服务器状态和网络的状态等多种指标，并将指标采集到 DataFlux，帮助你监控分析 etcd 各种异常情况。

## 配置 {#config}

### 前置条件 {#requirements}

etcd 版本 >= 3, 已测试的版本：

- [x] 3.5.7
- [x] 3.4.24
- [x] 3.3.27

开启 etcd，默认的 metrics 接口是 `http://localhost:2379/metrics`，也可以自行在配置文件中修改。

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/etcd` 目录，复制 `etcd.conf.sample` 并命名为 `etcd.conf`。示例如下：
    
    ```toml
        
    [[inputs.etcd]]
      ## Exporter URLs.
      urls = ["http://127.0.0.1:2379/metrics"]
    
      ## TLS configuration.
      tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"
    
      ## Set to 'true' to enable election.
      election = true
    
      ## Ignore tags. Multi supported.
      ## The matched tags would be dropped, but the item would still be sent.
      # tags_ignore = ["xxxx"]
    
      ## Customize tags.
      [inputs.etcd.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      
      ## (Optional) Collect interval: (defaults to "30s").
      # interval = "30s"
    
    ```

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标 {#metric}


