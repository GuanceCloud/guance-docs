---
title     : 'Pipeline Offload'
summary   : 'Receive data offloaded from Datakit Pipeline for processing'
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

The PlOffload collector is used to receive data offloaded by the DataKit Pipeline Offload feature that needs further processing.

This collector will register a route on the http service started by DataKit: `/v1/write/ploffload/:category`, where the `category` parameter can be `logging`, `network`, etc. It is mainly used to asynchronously process received data and cache data to disk when the Pipeline script fails to handle data in time.

## Configuration  {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->

=== "HOST Deployment"

    Navigate to the `conf.d/ploffload` directory under the DataKit installation directory, copy `ploffload.conf.sample` and rename it to `ploffload.conf`. An example is as follows:

    ```toml
        
    [inputs.ploffload]
    
      ## Storage config defines a local storage space on the hard drive to cache data.
      ## path is the local file path used to cache data.
      ## capacity is the total space size (in MB) used to store data.
      # [inputs.ploffload.storage]
        # path = "./ploffload_storage"
        # capacity = 5120
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    In Kubernetes, you can modify configuration parameters via environment variables:

    | Environment Variable Name                     | Corresponding Configuration Item | Parameter Example             |
    | -------------------------------------------- | ------------------------------- | ----------------------------- |
    | `ENV_INPUT_PLOFFLOAD_STORAGE_PATH`           | `storage.path`                 | `./ploffload_storage`        |
    | `ENV_INPUT_PLOFFLOAD_STORAGE_CAPACITY`       | `storage.capacity`             | `5120`                       |

<!-- markdownlint-enable -->

### Usage {#usage}

After completing the configuration, change the value of the `pipeline.offload.receiver` option in the main configuration file `datakit.yaml` of the DataKit instance from which the data is to be offloaded to `ploffload`.

Please check if the `listen` configuration item under `[http_api]` in the main DataKit configuration file has the host address set to `0.0.0.0` (or LAN IP, WAN IP). If it is set to `127.0.0.0/8`, external access will not be possible, and modification will be necessary.

If you need to enable the disk cache function, uncomment the `storage` related settings in the collector configuration, such as modifying it to:

```toml
[inputs.ploffload]
  [inputs.ploffload.storage]
    path = "./ploffload_storage"
    capacity = 5120
```