---
title     : 'Pipeline Offload'
summary   : 'Receive data to be processed from DataKit Pipeline Offload'
__int_icon: 'icon/ploffload'
tags      :
  - 'PIPELINE'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The PlOffload collector is used to receive data to be processed from the DataKit Pipeline Offload feature.

This collector registers a route on the http service started by DataKit: `/v1/write/ploffload/:category`, where the `category` parameter can be `logging`, `network`, etc. It is mainly used for asynchronously processing data after receiving it, caching data to disk when the Pipeline script does not process data in time.

## Configuration  {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->

=== "Host Deployment"

    Navigate to the `conf.d/ploffload` directory under the DataKit installation directory, copy `ploffload.conf.sample` and rename it to `ploffload.conf`. An example is as follows:

    ```toml
        
    [inputs.ploffload]
    
      ## Storage config a local storage space in hard dirver to cache data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.ploffload.storage]
        # path = "./ploffload_storage"
        # capacity = 5120
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    In Kubernetes, configuration parameters can be modified via environment variables:

    | Environment Variable Name                  | Corresponding Configuration Item | Parameter Example          |
    | :----------------------------------------- | --------------------------------- | --------------------------- |
    | `ENV_INPUT_PLOFFLOAD_STORAGE_PATH`         | `storage.path`                    | `./ploffload_storage`       |
    | `ENV_INPUT_PLOFFLOAD_STORAGE_CAPACITY`     | `storage.capacity`                | `5120`                      |

<!-- markdownlint-enable -->

### Usage {#usage}

After configuration is complete, change the value of the `pipeline.offload.receiver` item in the main configuration file `datakit.yaml` of the DataKit that needs to offload data to `ploffload`.

Check if the `listen` configuration item under `[http_api]` in the main DataKit configuration file has the host address set to `0.0.0.0` (or LAN IP, WAN IP). If it is `127.0.0.0/8`, external access will not be possible, and modifications are needed.

If you need to enable disk cache functionality, uncomment the `storage` related configurations in the collector configuration, such as modifying it to:

```toml
[inputs.ploffload]
  [inputs.ploffload.storage]
    path = "./ploffload_storage"
    capacity = 5120
```