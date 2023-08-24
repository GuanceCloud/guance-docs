# DataKit Metrics

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker: · [:octicons-tag-24: Version-1.10.0](../datakit/changelog.md#cl-1.10.0)

---

This Input used to collect Datakit exported metrics, such as runtime/CPU/memory and various other metrics of each modules.

## Configuration {#config}

After Datakit startup, it will expose a lot of [Prometheus metrics](datakit-metrics.md), and the input `dk` can scrap
these metrics.

<!-- markdownlint-disable MD046 -->
=== "*dk.conf*"

    
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

    After configuration, [restart DataKit]().

=== "Kubernetes"

    Kubernetes supports modifying configuration parameters in the form of environment variables:

    | Environment Name                  | Description                                                            | Examples                                                                               |
    | :---                              | ---                                                                    | ---                                                                                    |
    | `ENV_INPUT_DK_ENABLE_ALL_METRICS` | Enable all metrics, this may collect more than 300+ metrics on Datakit | `on/yes/`                                                                              |
    | `ENV_INPUT_DK_ADD_METRICS`        | Add extra metrics (JSON array)                                         | `["datakit_io_.*", "datakit_pipeline_.*"]`, Available metrics list [here](../datakit/datakit-metrics.md) |
    | `ENV_INPUT_DK_ONLY_METRICS`       | **Only** enalbe specified metrics(JSON array)                          | `["datakit_io_.*", "datakit_pipeline_.*"]`                                             |
<!-- markdownlint-enable -->

## Measurements {#metric}

Datakit exported Prometheus metrics, see [here](../datakit/datakit-metrics.md) for full metric list.
