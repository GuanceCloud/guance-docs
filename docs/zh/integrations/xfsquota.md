---
title     : 'xfsquota'
summary   : '采集 xfs 文件系统的限额信息'
---

:fontawesome-brands-linux:

---

xfsquota 采集器通过运行 `xfs_quota` 解析标准输出，采集 xfs 文件系统的限额信息。

## 配置 {#config}

### 前置条件 {#requirements}

存在 `xfs_quota` 二进制执行文件。

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/xfsquota` 目录，复制 `xfsquota.conf.sample` 并命名为 `xfsquota.conf`。示例如下：
    
    ```toml
        
    [[input.xfsquota]]
        ## Path to the xfs_quota binary.
        binary_path = "/usr/sbin/xfs_quota"
    
        ## (Optional) Collect interval: (defaults to "1m").
        interval = "1m"
    
        ## Require.
        ## Filesystem path to which the quota will be applied.
        filesystem_path = "/hana"
    
        ## Specifies the version of the parsing format.
        parser_version = "v1"
    
        [inputs.xfsquota.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标 {#metric}



### `xfsquota`

- 标签


| Tag | Description |
|  ----  | --------|
|`filesystem_path`|The file path of the XFS quota limit.|
|`project_id`|The Project ID in xfs_quota identifies a project or group for disk usage limits.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`hard`|The hard limit for disk usage.|int|count|
|`soft`|The soft limit for disk usage.|int|count|
|`used`|The current disk usage by the project.|int|count|


