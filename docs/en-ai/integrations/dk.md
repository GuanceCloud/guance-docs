---
title: 'DataKit Self Metrics Collection'
summary: 'Collection of DataKit runtime metrics'
tags:
  - 'Host'
__int_icon: 'icon/dk'
dashboard:
  - desc: 'DataKit Built-in Views'
    path: 'dashboard/en/dk'
  - desc: 'DataKit Dial Testing Built-in Views'
    path: 'dashboard/en/dialtesting'

monitor:
  - desc: 'Not Available'
    path: '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker: · [:octicons-tag-24: Version-1.11.0](../datakit/changelog.md#cl-1.11.0)

---

The DataKit collector is used to collect basic information about its own operation, including runtime environment information, CPU usage, memory usage, and metrics from various core modules.

## Configuration {#config}

After DataKit starts, it exposes some [Prometheus Metrics](../datakit/datakit-metrics.md) by default. No additional actions are required, and this collector is enabled by default, replacing the previous `self` collector.

<!-- markdownlint-disable MD046 -->
=== "Host Deployment"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `dk.conf.sample`, and rename it to `dk.conf`. Example configuration:

    ```toml
        
    [[inputs.dk]]
    
      # See https://docs.guance.com/datakit/datakit-metrics/#metrics for all metrics exported by Datakit.
      metric_name_filter = [
        ### Collect all metrics (these may collect 300+ metrics of Datakit)
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
    
      # collection frequency
      interval = "30s"
    
    [inputs.dk.tags]
       # tag1 = "val-1"
       # tag2 = "val-2"
    
    ```

    After configuring, restart DataKit.

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or by [setting ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    You can also modify configuration parameters using environment variables (you need to add it to ENV_DEFAULT_ENABLED_INPUTS as a default collector):

    - **ENV_INPUT_DK_ENABLE_ALL_METRICS**
    
        Collect all metrics; any non-empty string
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: ``-``
    
        **Example**: true
    
        **Default Value**: `-`
    
    - **ENV_INPUT_DK_ADD_METRICS**
    
        Append metrics list; available metric names can be found [here](../datakit/datakit-metrics.md)
    
        **Field Type**: List
    
        **Collector Configuration Field**: ``-``
    
        **Example**: `["datakit_io_.*", "datakit_pipeline_.*"]`
    
        **Default Value**: `-`
    
    - **ENV_INPUT_DK_ONLY_METRICS**
    
        Enable only specified metrics
    
        **Field Type**: List
    
        **Collector Configuration Field**: ``-``
    
        **Example**: `["datakit_io_.*", "datakit_pipeline_.*"]`
    
        **Default Value**: `-`

<!-- markdownlint-enable -->

## Metrics {#metric}

DataKit's self metrics primarily consist of Prometheus metrics. For documentation, refer to [this link](../datakit/datakit-metrics.md)