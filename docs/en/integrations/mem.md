---
title     : 'Mem'
summary   : 'Collect metrics of host memory'
__int_icon      : 'icon/mem'
dashboard :
  - desc  : 'memory'
    path  : 'dashboard/en/mem'
monitor   :
  - desc  : 'host detection library'
    path  : 'monitor/en/host'  
---

<!-- markdownlint-disable MD025 -->
# Memory
<!-- markdownlint-enable -->

<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Mem collector is used to collect system memory information, some general metrics such as total memory, used memory and so on.


## Configuration {#config}

After successfully installing and starting DataKit, the Mem collector will be enabled by default without the need for manual activation.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `mem.conf.sample` and name it `mem.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.mem]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
    
    [inputs.mem.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_MEM_INTERVAL**
    
        Collect interval
    
        **Type**: TimeDuration
    
        **input.conf**: `interval`
    
        **Default**: 10s
    
    - **ENV_INPUT_MEM_TAGS**
    
        Customize tags. If there is a tag with the same name in the configuration file, it will be overwritten
    
        **Type**: Map
    
        **input.conf**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## Metric {#metric}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.mem.tags]`:

``` toml
 [inputs.mem.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `mem`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|

- metric list


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


