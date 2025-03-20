---
title     : 'xfsquota'
summary   : 'Collects quota information from the xfs file system'
---

:fontawesome-brands-linux:

---

The xfsquota collector parses the standard output by running `xfs_quota`, collecting quota information from the xfs file system.

## Configuration {#config}

### Prerequisites {#requirements}

Existence of the `xfs_quota` binary executable file.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/xfsquota` directory under the DataKit installation directory, copy `xfsquota.conf.sample` and rename it to `xfsquota.conf`. An example is as follows:
    
    ```toml
        
    [[inputs.xfsquota]]
        ## Path to the xfs_quota binary.
        binary_path = "/usr/sbin/xfs_quota"
    
        ## (Optional) Collect interval: (defaults to "1m").
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

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`hard`|The hard limit for disk usage.|int|count|
|`soft`|The soft limit for disk usage.|int|count|
|`used`|The current disk usage by the project.|int|count|