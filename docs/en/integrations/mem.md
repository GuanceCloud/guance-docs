---
title     : 'Memory'
summary   : 'Collect metrics data from host memory'
tags:
  - 'Host'
__int_icon      : 'icon/mem'
dashboard :
  - desc  : 'Memory'
    path  : 'dashboard/en/mem'
monitor   :
  - desc  : 'Host Monitoring Library'
    path  : 'monitor/en/host'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The Memory collector is used to gather system memory information, including common metrics such as total host memory, used memory, and utilized memory.

## Configuration {#config}

After successfully installing and starting DataKit, the Memory collector is enabled by default and does not require manual activation.

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `mem.conf.sample`, and rename it to `mem.conf`. Example configuration:

    ```toml
        
    [[inputs.mem]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
    
    [inputs.mem.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or by [setting ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    Environment variables can also be used to modify configuration parameters (requires adding to ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_MEM_INTERVAL**
    
        Collector repeat interval duration
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `interval`
    
        **Default Value**: 10s
    
    - **ENV_INPUT_MEM_TAGS**
    
        Custom tags. If the configuration file has tags with the same name, they will be overridden.
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all collected data appends a global tag named `host` (the tag value is the hostname where DataKit resides). Additional tags can be specified in the configuration using `[inputs.mem.tags]`:

```toml
 [inputs.mem.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `mem`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|

- Metrics List


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


</example>
