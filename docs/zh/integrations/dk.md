---
title: 'DataKit 自身指标采集'
summary: '采集 Datakit 自身运行指标'
__int_icon: 'icon/dk'
dashboard:
  - desc: 'Datakit 内置视图'
    path: 'dashboard/zh/dk'
  - desc: 'Datakit 拨测内置视图'
    path: 'dashboard/zh/dialtesting'

monitor:
  - desc: '暂无'
    path: '-'
---

<!-- markdownlint-disable MD025 -->
# DataKit 自身指标
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker: · [:octicons-tag-24: Version-1.11.0](../datakit/changelog.md#cl-1.11.0)

---

Datakit 采集器用于自身基本信息的采集，包括运行环境信息、CPU、内存占用、各个核心模块指标等。

## 配置 {#config}

Datakit 启动后。默认会暴露一些 [Prometheus 指标](../datakit/datakit-metrics.md)，没有额外的操作需要执行，本采集器也是默认启动的，替代了之前的 `self` 采集器。

<!-- markdownlint-disable MD046 -->
=== "主机部署"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `dk.conf.sample` 并命名为 `dk.conf`。示例如下：

    ```toml
        
    [[inputs.dk]]
    
      # See https://docs.guance.com/datakit/datakit-metrics/#metrics for all metrics exported by Datakit.
      metric_name_filter = [
        ### Collect all metrics(these may collect 300+ metrics of Datakit)
        ### if you want to collect all, make this rule the first in the list.
        # ".*",
    
        "datakit_http.*",       # HTTP API
        "datakit_goroutine.*",  # Goroutine
    
        ### runtime related
        "datakit_cpu_.*",
        "datakit_.*_alloc_bytes", # Memory
        "datakit_open_files",
        "datakit_uptime_seconds",
        "datakit_data_overuse",
        "datakit_process_.*",
    
        ### election
        "datakit_election_status",
    
        ### Dataway related
        #"datakit_io_dataway_.*",
        #"datakit_io_http_retry_total",
    
        ### Filter
        #"datakit_filter_.*",
    
        ### dialtesting
        #"datakit_dialtesting_.*",
    
        ### Input feed
        #".*_feed_.*",
      ]
    
      # keep empty to collect all types(count/gauge/summary/...)
      metric_types = []
    
      # collect frequency
      interval = "30s"
    
    [inputs.dk.tags]
       # tag1 = "val-1"
       # tag2 = "val-2"
    
    ```

    配置好后，重启 DataKit 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_DK_ENABLE_ALL_METRICS**
    
        采集所有指标，任意非空字符串
    
        **Type**: Boolean
    
        **ConfField**: `none`
    
        **Example**: any_string
    
    - **ENV_INPUT_DK_ADD_METRICS**
    
        追加指标列表，可用的指标名参见[这里](../datakit/datakit-metrics.md)
    
        **Type**: JSON
    
        **ConfField**: `none`
    
        **Example**: ["datakit_io_.*", "datakit_pipeline_.*"]
    
    - **ENV_INPUT_DK_ONLY_METRICS**
    
        只开启指定指标
    
        **Type**: JSON
    
        **ConfField**: `none`
    
        **Example**: ["datakit_io_.*", "datakit_pipeline_.*"]

<!-- markdownlint-enable -->

## 指标 {#metric}

Datakit 自身指标主要是一些 Prometheus 指标，其文档参见[这里](../datakit/datakit-metrics.md)
