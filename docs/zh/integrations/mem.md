---
title     : '内存'
summary   : '采集主机内存的指标数据'
tags:
  - '主机'
__int_icon      : 'icon/mem'
dashboard :
  - desc  : '内存'
    path  : 'dashboard/zh/mem'
monitor   :
  - desc  : '主机检测库'
    path  : 'monitor/zh/host'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Memory 采集器用于收集系统内存信息，一些通用的指标如主机总内存、用的内存、已使用的内存等。

## 配置 {#config}

成功安装 DataKit 并启动后，会默认开启 Memory 采集器，无需手动开启。

<!-- markdownlint-disable MD046 -->

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `mem.conf.sample` 并命名为 `mem.conf`。示例如下：

    ```toml
        
    [[inputs.mem]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
    
    [inputs.mem.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_MEM_INTERVAL**
    
        采集器重复间隔时长
    
        **字段类型**: TimeDuration
    
        **采集器配置字段**: `interval`
    
        **默认值**: 10s
    
    - **ENV_INPUT_MEM_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **字段类型**: Map
    
        **采集器配置字段**: `tags`
    
        **示例**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.mem.tags]` 指定其它标签：

```toml
 [inputs.mem.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `mem`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active`|Memory that has been used more recently and usually not reclaimed unless absolutely necessary. (Darwin, Linux)|int|B|
|`available`|Amount of available memory.|int|B|
|`available_percent`|Available memory percent.|float|percent|
|`buffered`|Buffered. (Linux)|int|B|
|`cached`|In-memory cache for files read from the disk. (Linux)|int|B|
|`commit_limit`|This is the total amount of memory currently available to be allocated on the system. (Linux)|int|B|
|`committed_as`|The amount of memory presently allocated on the system. (Linux)|int|B|
|`dirty`|Memory which is waiting to get written back to the disk. (Linux)|int|B|
|`free`|Amount of free memory. (Darwin, Linux)|int|B|
|`high_free`|Amount of free high memory. (Linux)|int|B|
|`high_total`|Total amount of high memory. (Linux)|int|B|
|`huge_page_total`|The size of the pool of huge pages. (Linux)|int|count|
|`huge_pages_free`|The number of huge pages in the pool that are not yet allocated. (Linux)|int|count|
|`huge_pages_size`|The size of huge pages. (Linux)|int|B|
|`inactive`|Memory which has been less recently used.  It is more eligible to be reclaimed for other purposes. (Darwin, Linux)|int|B|
|`low_free`|Amount of free low memory. (Linux)|int|B|
|`low_total`|Total amount of low memory. (Linux)|int|B|
|`mapped`|Files which have been mapped into memory, such as libraries. (Linux)|int|B|
|`page_tables`|Amount of memory dedicated to the lowest level of page tables. (Linux)|int|B|
|`shared`|Amount of shared memory. (Linux)|int|B|
|`slab`|In-kernel data structures cache. (Linux)|int|B|
|`sreclaimable`|Part of Slab, that might be reclaimed, such as caches. (Linux)|int|B|
|`sunreclaim`|Part of Slab, that cannot be reclaimed on memory pressure. (Linux)|int|B|
|`swap_cached`|Memory that once was swapped out, is swapped back in but still also is in the swap file. (Linux)|int|B|
|`swap_free`|Amount of swap space that is currently unused. (Linux)|int|B|
|`swap_total`|Total amount of swap space available. (Linux)|int|B|
|`total`|Total amount of memory.|int|B|
|`used`|Amount of used memory.|int|B|
|`used_percent`|Used memory percent.|float|percent|
|`vmalloc_chunk`|Largest contiguous block of vmalloc area which is free. (Linux)|int|B|
|`vmalloc_total`|Total size of vmalloc memory area. (Linux)|int|B|
|`vmalloc_used`|Amount of vmalloc area which is used. (Linux)|int|B|
|`wired`|Wired. (Darwin)|int|B|
|`write_back`|Memory which is actively being written back to the disk. (Linux)|int|B|
|`write_back_tmp`|Memory used by FUSE for temporary write back buffers. (Linux)|int|B|


