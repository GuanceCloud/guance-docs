---
title     : 'xfsquota'
summary   : 'Collect quota information from the xfs file system'
---

:fontawesome-brands-linux:

---

The xfsquota collector gathers quota information from the xfs file system by running `xfs_quota` and parsing its standard output.

## Configuration {#config}

### Prerequisites {#requirements}

The `xfs_quota` binary executable must exist.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/xfsquota` directory under the DataKit installation directory, copy `xfsquota.conf.sample`, and rename it to `xfsquota.conf`. An example is shown below:
    
    ```toml
        
    [[inputs.xfsquota]]
        ## Path to the xfs_quota binary.
        binary_path = "/usr/sbin/xfs_quota"
    
        ## (Optional) Collection interval: (defaults to "1m").
        interval = "1m"
    
        ## Required.
        ## Filesystem path to which the quota will be applied.
        filesystem_path = "/hana"
    
        ## Specifies the version of the parsing format.
        parser_version = "v1"
    
        [inputs.xfsquota.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metrics {#metric}



### `xfsquota`

- Tags


| Tag | Description |
|  ----  | --------|
|`filesystem_path`|The file path of the XFS quota limit.|
|`project_id`|The Project ID in xfs_quota identifies a project or group for disk usage limits.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`hard`|The hard limit for disk usage.|int|count|
|`soft`|The soft limit for disk usage.|int|count|
|`used`|The current disk usage by the project.|int|count|
