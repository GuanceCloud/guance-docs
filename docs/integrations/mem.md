
# 内存
- DataKit 版本：1.4.0
- 文档发布日期：2022-06-12 10:58:47
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

mem 采集器用于收集系统内存信息，一些通用的指标如主机总内存、用的内存、已使用的内存等  

## 前置条件

暂无

## 配置

进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `mem.conf.sample` 并命名为 `mem.conf`。示例如下：

```toml

[[inputs.mem]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'

[inputs.mem.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

配置好后，重启 DataKit 即可。

支持以环境变量的方式修改配置参数（只在 DataKit 以 K8s daemonset 方式运行时生效，主机部署的 DataKit 不支持此功能）：

| 环境变量名           | 对应的配置参数项 | 参数示例                                                     |
| :---                 | ---              | ---                                                          |
| `ENV_INPUT_MEM_TAGS` | `tags`           | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它 |
| `ENV_INPUT_MEM_INTERVAL` | `interval` | `10s` |

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.mem.tags]` 指定其它标签：

``` toml
 [inputs.mem.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `mem`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`active`|Memory that has been used more recently and usually not reclaimed unless absolutely necessary. (Darwin, Linux)|int|B|
|`available`|Amount of available memory|int|B|
|`available_percent`|Available memory percent|float|percent|
|`buffered`|buffered (Linux)|int|B|
|`cached`|In-memory cache for files read from the disk. (Linux)|int|B|
|`commit_limit`|This is the total amount of memory currently available to be allocated on the system. (Linux)|int|B|
|`committed_as`|The amount of memory presently allocated on the system. (Linux)|int|B|
|`dirty`|Memory which is waiting to get written back to the disk. (Linux)|int|B|
|`free`|Amount of free memory(Darwin, Linux)|int|B|
|`high_free`|Amount of free highmem. (Linux)|int|B|
|`high_total`|Total amount of highmem. (Linux)|int|B|
|`huge_page_total`|The size of the pool of huge pages. (Linux)|int|count|
|`huge_pages_free`|The number of huge pages in the pool that are not yet allocated. (Linux)|int|count|
|`huge_pages_size`|The size of huge pages. (Linux)|int|B|
|`inactive`|Memory which has been less recently used.  It is more eligible to be reclaimed for other purposes. (Darwin, Linux)|int|B|
|`low_free`|Amount of free lowmem. (Linux)|int|B|
|`low_total`|Total amount of lowmem. (Linux)|int|B|
|`mapped`|Files which have been mapped into memory, such as libraries. (Linux)|int|B|
|`page_tables`|Amount of memory dedicated to the lowest level of page tables. (Linux)|int|B|
|`shared`|Amount of shared memory (Linux)|int|B|
|`slab`|In-kernel data structures cache. (Linux)|int|B|
|`sreclaimable`|Part of Slab, that might be reclaimed, such as caches. (Linux)|int|B|
|`sunreclaim`|Part of Slab, that cannot be reclaimed on memory pressure. (Linux)|int|B|
|`swap_cached`|Memory that once was swapped out, is swapped back in but still also is in the swap file. (Linux)|int|B|
|`swap_free`|Amount of swap space that is currently unused. (Linux)|int|B|
|`swap_total`|Total amount of swap space available. (Linux)|int|B|
|`total`|Total amount of memory|int|B|
|`used`|Amount of used memory|int|B|
|`used_percent`|Used memory percent|float|percent|
|`vmalloc_chunk`|Largest contiguous block of vmalloc area which is free. (Linux)|int|B|
|`vmalloc_total`|Total size of vmalloc memory area. (Linux)|int|B|
|`vmalloc_used`|Amount of vmalloc area which is used. (Linux)|int|B|
|`wired`|wired (Darwin)|int|B|
|`write_back`|Memory which is actively being written back to the disk. (Linux)|int|B|
|`write_back_tmp`|Memory used by FUSE for temporary writeback buffers. (Linux)|int|B|


