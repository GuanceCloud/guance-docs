---
title: 'DataKit own metrics collection'
summary: 'Collect DataKit's own operational metrics'
__int_icon: 'icon/dk'
dashboard:
  - desc: 'DataKit dashboard'
    path: 'dashboard/en/dk'
  - desc: 'DataKit dial test built-in dashboard'
    path: 'dashboard/en/dialtesting'

monitor:
  - desc: 'N/A'
    path: '-'
---

<!-- markdownlint-disable MD025 -->
# DataKit Metrics
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker: · [:octicons-tag-24: Version-1.10.0](../datakit/changelog.md#cl-1.10.0)

---

This Input used to collect Datakit exported metrics, such as runtime/CPU/memory and various other metrics of each modules.

## Configuration {#config}

After Datakit startup, it will expose a lot of [Prometheus metrics](datakit-metrics.md), and the input `dk` can scrap
these metrics.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `dk.conf.sample` and name it `dk.conf`. Examples are as follows:

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

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_DK_ENABLE_ALL_METRICS**
    
        Collect all metrics, any string
    
        **Type**: Boolean
    
        **ConfField**: `none`
    
        **Example**: any_string
    
    - **ENV_INPUT_DK_ADD_METRICS**
    
        Additional metrics, Available metrics list [here](../datakit/datakit-metrics.md)
    
        **Type**: JSON
    
        **ConfField**: `none`
    
        **Example**: ["datakit_io_.*", "datakit_pipeline_.*"]
    
    - **ENV_INPUT_DK_ONLY_METRICS**
    
        Only enable metrics
    
        **Type**: JSON
    
        **ConfField**: `none`
    
        **Example**: ["datakit_io_.*", "datakit_pipeline_.*"]

<!-- markdownlint-enable -->

## Metric {#metric}

Datakit exported Prometheus metrics, see [here](../datakit/datakit-metrics.md) for full metric list.
