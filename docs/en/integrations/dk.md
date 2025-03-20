---
title: 'DataKit Self-Monitoring Metrics Collection'
summary: 'Collection of DataKit self-running metrics'
tags:
  - 'HOSTs'
__int_icon: 'icon/dk'
dashboard:
  - desc: 'DataKit Built-in Views'
    path: 'dashboard/en/dk'
  - desc: 'DataKit Testing Built-in Views'
    path: 'dashboard/en/dialtesting'

monitor:
  - desc: 'N/A'
    path: '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker: · [:octicons-tag-24: Version-1.11.0](../datakit/changelog.md#cl-1.11.0)

---

The DataKit collector is used for collecting basic information about itself, including runtime environment information, CPU, memory usage, and various core module Metrics.

## Configuration {#config}

After DataKit starts, it will by default expose some [Prometheus Metrics](../datakit/datakit-metrics.md). No additional operations are required, and this collector is enabled by default, replacing the previous `self` collector.

<!-- markdownlint-disable MD046 -->
=== "HOST Deployment"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `dk.conf.sample`, and rename it to `dk.conf`. An example is as follows:

    ```toml
        
    [[inputs.dk]]
    
      # See <<< homepage >>>/datakit/datakit-metrics/#metrics for all Metrics exported by DataKit.
      metric_name_filter = [
        ### Collect all Metrics(these may collect over 300 Metrics of DataKit)
        ### If you want to collect all, make this rule the first in the list.
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

    After configuring, simply restart DataKit.

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    It also supports modifying configuration parameters via environment variables (you need to add it to ENV_DEFAULT_ENABLED_INPUTS as a default collector):

    - **ENV_INPUT_DK_ENABLE_ALL_METRICS**
    
        Collect all Metrics, any non-empty string
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: ``-``
    
        **Example**: true
    
        **Default Value**: `-`
    
    - **ENV_INPUT_DK_ADD_METRICS**
    
        Append Metrics list, available Metric names are listed [here](../datakit/datakit-metrics.md)
    
        **Field Type**: List
    
        **Collector Configuration Field**: ``-``
    
        **Example**: `["datakit_io_.*", "datakit_pipeline_.*"]`
    
        **Default Value**: `-`
    
    - **ENV_INPUT_DK_ONLY_METRICS**
    
        Enable only specified Metrics
    
        **Field Type**: List
    
        **Collector Configuration Field**: ``-``
    
        **Example**: `["datakit_io_.*", "datakit_pipeline_.*"]`
    
        **Default Value**: `-`

<!-- markdownlint-enable -->

## Metrics {#metric}

DataKit self-Metrics mainly consist of Prometheus Metrics, and their documentation can be found [here](../datakit/datakit-metrics.md)
