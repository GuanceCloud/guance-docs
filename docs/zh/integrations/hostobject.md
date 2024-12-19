---
title     : '主机对象'
summary   : '采集主机基本信息'
tags:
  - '主机'
__int_icon      : 'icon/hostobject'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

主机对象采集器用于收集主机基本信息，如硬件型号、基础资源消耗等。

## 配置 {#config}

成功安装 Datakit 并启动后，会默认开启主机对象采集器，无需手动开启。

<!-- markdownlint-disable MD046 -->

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `hostobject.conf.sample` 并命名为 `hostobject.conf`。示例如下：

    ```toml
        
    [inputs.hostobject]
    
    ## Datakit does not collect network virtual interfaces under the linux system.
    ## Setting enable_net_virtual_interfaces to true will collect network virtual interfaces stats for linux.
    # enable_net_virtual_interfaces = true
    
    ## absolute path to the configuration file
    # config_path = ["/usr/local/datakit/conf.d/datakit.conf"]
    
    ##############################
    # Disk related options
    ##############################
    ## Deprecated
    # ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "autofs", "squashfs", "aufs"]
    
    ## We collect all devices prefixed with dev by default,If you want to collect additional devices, it's in extra_device add
    # extra_device = []
    
    ## exclude some with dev prefix (We collect all devices prefixed with dev by default)
    # exclude_device = ["/dev/loop0","/dev/loop1"]
    
    ## Physical devices only (e.g. hard disks, cd-rom drives, USB keys)
    # and ignore all others (e.g. memory partitions such as /dev/shm)
    only_physical_device = false
    
    ## Ignore the disk which space is zero
    ignore_zero_bytes_disk = true
    
    ## Disable cloud provider information synchronization
    disable_cloud_provider_sync = false
    
    ## Enable put cloud provider region/zone_id information into global election tags, (default to true).
    # enable_cloud_host_tags_as_global_election_tags = true
    
    ## Enable put cloud provider region/zone_id information into global host tags, (default to true).
    # enable_cloud_host_tags_as_global_host_tags = true
    
    ## [inputs.hostobject.tags] # (optional) custom tags
      # cloud_provider = "aliyun" # aliyun/tencent/aws/hwcloud/azure/volcengine, probe automatically if not set
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    
    ## [inputs.hostobject.cloud_meta_url]
      # tencent = "xxx"  # URL for Tencent Cloud metadata
      # aliyun = "yyy"   # URL for Alibaba Cloud metadata
      # aws = "zzz"
      # azure = ""
      # Hwcloud = ""
      # volcengine = ""
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_HOSTOBJECT_ENABLE_NET_VIRTUAL_INTERFACES**
    
        允许采集虚拟网卡
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `enable_net_virtual_interfaces`
    
        **默认值**: false
    
    - **ENV_INPUT_HOSTOBJECT_IGNORE_ZERO_BYTES_DISK**
    
        忽略大小为 0 的磁盘
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `ignore_zero_bytes_disk`
    
        **默认值**: false
    
    - **ENV_INPUT_HOSTOBJECT_ONLY_PHYSICAL_DEVICE**
    
        忽略非物理磁盘（如网盘、NFS），任意非空字符串
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `only_physical_device`
    
        **默认值**: false
    
    - **ENV_INPUT_HOSTOBJECT_EXCLUDE_DEVICE**
    
        忽略的 device
    
        **字段类型**: List
    
        **采集器配置字段**: `exclude_device`
    
        **示例**: /dev/loop0,/dev/loop1
    
    - **ENV_INPUT_HOSTOBJECT_EXTRA_DEVICE**
    
        额外增加的 device
    
        **字段类型**: List
    
        **采集器配置字段**: `extra_device`
    
        **示例**: `/nfsdata,other`
    
    - **ENV_INPUT_HOSTOBJECT_CLOUD_META_AS_ELECTION_TAGS**
    
        将云服务商 region/zone_id 信息放入全局选举标签
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `enable_cloud_host_tags_global_election_tags`
    
        **默认值**: true
    
    - **ENV_INPUT_HOSTOBJECT_CLOUD_META_AS_HOST_TAGS**
    
        将云服务商 region/zone_id 信息放入全局主机标签
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `enable_cloud_host_tags_global_host_tags`
    
        **默认值**: true
    
    - **ENV_INPUT_HOSTOBJECT_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **字段类型**: Map
    
        **采集器配置字段**: `tags`
    
        **示例**: tag1=value1,tag2=value2
    
    - **ENV_CLOUD_PROVIDER**
    
        指定云服务商
    
        **字段类型**: String
    
        **采集器配置字段**: `none`
    
        **示例**: `aliyun/aws/tencent/hwcloud/azure`
    
    - **ENV_CLOUD_META_URL**
    
        云服务商元数据 URL 映射
    
        **字段类型**: Map
    
        **采集器配置字段**: `cloud_meta_url`
    
        **示例**: `{"tencent":"xxx", "aliyun":"yyy"}`

<!-- markdownlint-enable -->

### 开启云同步 {#cloudinfo}

Datakit 默认开启云同步，目前支持阿里云/腾讯云/AWS/华为云/微软云/火山引擎。可以通过设置 cloud_provider tag 显式指定云厂商，也可以由 Datakit 自动进行探测：

```toml
[inputs.hostobject.tags]
  # 此处目前支持 aliyun/tencent/aws/hwcloud/azure 几种，若不设置，则由 Datakit 自动探测并设置此 tag
  cloud_provider = "aliyun"
```

可以通过在配置文件中配置 `disable_cloud_provider_sync = true` 关闭云同步功能。

## 对象 {#object}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.hostobject.tags]` 指定其它标签：

```toml
 [inputs.hostobject.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

> 注意：这里添加自定义 tag 时，尽量不要跟已有的 tag key/field key 同名。如果同名，DataKit 将选择配置里面的 tag 来覆盖采集的数据，可能导致一些数据问题。



### `HOST`

- 标签


| Tag | Description |
|  ----  | --------|
|`arch`|Host OS Arch|
|`host`|Hostname. Required.|
|`name`|Hostname|
|`os`|Host OS type|
|`unicast_ip`|Host unicast ip|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_usage`|CPU usage|float|percent|
|`datakit_ver`|Collector version|string|-|
|`disk_total`|Disk total|int|B|
|`disk_used_percent`|Disk usage|float|percent|
|`diskio_read_bytes_per_sec`|Disk read rate|int|B/S|
|`diskio_write_bytes_per_sec`|Disk write rate|int|B/S|
|`dk_upgrader`|Upgrade's host and port|string|-|
|`is_docker`|Docker mode|int|-|
|`load`|System load|float|-|
|`logging_level`|Log level|string|-|
|`mem_used_percent`|Memory usage|float|percent|
|`message`|Summary of all host information|string|-|
|`net_recv_bytes_per_sec`|Network receive rate|int|B/S|
|`net_send_bytes_per_sec`|Network send rate|int|B/S|
|`num_cpu`|CPU numbers|int|count|
|`start_time`|Host startup time (Unix timestamp)|int|ms|



如果开启了云同步，会多出如下一些字段（以同步到的字段为准）：

| 字段名                  | 描述           |  类型  |
| ----------------------- | -------------- | :----: |
| `cloud_provider`        | 云服务商       | string |
| `description`           | 描述           | string |
| `instance_id`           | 实例 ID        | string |
| `instance_name`         | 实例名         | string |
| `instance_type`         | 实例类型       | string |
| `instance_charge_type`  | 实例计费类型   | string |
| `instance_network_type` | 实例网络类型   | string |
| `instance_status`       | 实例状态       | string |
| `security_group_id`     | 实例分组       | string |
| `private_ip`            | 实例私网 IP    | string |
| `zone_id`               | 实例 Zone ID   | string |
| `region`                | 实例 Region ID | string |

### `message` 指标字段结构 {#message-struct}

`message` 字段基本结构如下：

```json
{
  "host": {
    "meta": ...,
    "cpu": ...,
    "mem": ...,
    "net": ...,
    "disk": ...,
    "conntrack": ...,
    "filefd": ...,
    "election": ...,
    "config_file": ...,
  },

  "collectors": [ # 各个采集器的运行情况
    ...
  ]
}
```

#### `host.meta` {#host-meta}

| 字段名             | 描述                                           |  类型  |
| ------------------ | ---------------------------------------------- | :----: |
| `host_name`        | 主机名                                         | string |
| `boot_time`        | 开机时间                                       |  int   |
| `os`               | 操作系统类型，如 `linux/windows/darwin`        | string |
| `platform`         | 平台名称，如 `ubuntu`                          | string |
| `platform_family`  | 平台分类，如 `ubuntu` 属于 `debian` 分类       | string |
| `platform_version` | 平台版本，如 `18.04`，即 Ubuntu 的某个分发版本 | string |
| `kernel_release`   | 内核版本，如 `4.15.0-139-generic`              | string |
| `arch`             | CPU 硬件架构，如 `x86_64/arm64` 等             | string |
| `extra_cloud_meta` | 开启云同步时，会带上一串云属性的 JSON 数据     | string |

#### `host.cpu` {#host-cpu}

| 字段名        | 描述                                                    |  类型  |
| ------------- | ------------------------------------------------------- | :----: |
| `vendor_id`   | 供应商 ID，如 `GenuineIntel`                            | string |
| `module_name` | CPU 型号，如 `Intel(R) Core(TM) i5-8210Y CPU @ 1.60GHz` | string |
| `cores`       | 核数                                                    |  int   |
| `mhz`         | 频率                                                    |  int   |
| `cache_size`  | L2 缓存大小（KB）                                       |  int   |

#### `host.mem` {#host-mem}

| 字段名         | 描述       | 类型 |
| -------------- | ---------- | :--: |
| `memory_total` | 总内存大小 | int  |
| `swap_total`:  | swap 大小  | int  |

#### `host.net` {#host-net}

| 字段名    | 描述               |   类型   |
| --------- | ------------------ | :------: |
| `mtu`     | 最大传输单元       |   int    |
| `name`    | 网卡名称           |  string  |
| `mac`     | MAC 地址           |  string  |
| `flags`   | 状态位（可能多个） | []string |
| `ip4`     | IPv4 地址          |  string  |
| `ip6`     | IPv6 地址          |  string  |
| `ip4_all` | 所有 IPv4 地址     | []string |
| `ip6_all` | 所有 IPv6 地址     | []string |

#### `host.disk` {#host-disk}

| 字段名       | 描述         |  类型  |
| ------------ | ------------ | :----: |
| `device`     | 磁盘设备名   | string |
| `total`      | 磁盘总大小   |  int   |
| `mountpoint` | 挂载点       | string |
| `fstype`     | 文件系统类型 | string |

#### `host.election` {#host-election}

> 注意：当配置文件中 `enable_election` 选项关闭时，该字段为 null

| 字段名      | 描述     |  类型  |
| ----------- | -------- | :----: |
| `elected`   | 选举状态 | string |
| `namespace` | 选举空间 | string |

#### `host.conntrack` {#host-conntrack}

<!-- markdownlint-disable MD046 -->

???+ attention

    `conntrack` 仅 Linux 平台支持

<!-- markdownlint-enable -->

| 字段名                | 描述                                           | 类型 |
| --------------------- | ---------------------------------------------- | :--: |
| `entries`             | 当前连接数量                                   | int  |
| `entries_limit`       | 连接跟踪表的大小                               | int  |
| `stat_found`          | 成功的搜索条目数目                             | int  |
| `stat_invalid`        | 不能被跟踪的包数目                             | int  |
| `stat_ignore`         | 已经被跟踪的报数目                             | int  |
| `stat_insert`         | 插入的包数目                                   | int  |
| `stat_insert_failed`  | 插入失败的包数目                               | int  |
| `stat_drop`           | 跟踪失败被丢弃的包数目                         | int  |
| `stat_early_drop`     | 由于跟踪表满而导致部分已跟踪包条目被丢弃的数目 | int  |
| `stat_search_restart` | 由于 hash 表大小修改而导致跟踪表查询重启的数目 | int  |

#### `host.filefd` {#host-filefd}

<!-- markdownlint-disable MD046 -->

???+ attention

    `filefd` 仅 Linux 平台支持

<!-- markdownlint-enable -->

| 字段名         | 描述                                                 | 类型  |
| -------------- | ---------------------------------------------------- | :---: |
| `allocated`    | 已分配文件句柄的数目                                 |  int  |
| `maximum`      | 文件句柄的最大数目（已弃用，用 `maximum_mega` 替代） |  int  |
| `maximum_mega` | 文件句柄的最大数目，单位 M(10^6)                     | float |

#### `host.config_file` {#host-config-file}

config_file 是一个 `file-path`: `file-content` 的 map，每个字段的含义如下：

| 字段名         | 描述                                                 | 类型  |
| -------------- | ---------------------------------------------------- | :---: |
| `file-path`    | 配置文件的绝对路径                                   |  string  |
| `file-content` | 配置文件的内容                                    |  string  |

#### 采集器运行情况字段列表 {#inputs-stats}

`collectors` 字段是一个对象列表，每个对象的字段如下：

| 字段名          | 描述                                               |  类型  |
| --------------- | -------------------------------------------------- | :----: |
| `name`          | 采集器名称                                         | string |
| `count`         | 采集次数                                           |  int   |
| `last_err`      | 最后一次报错信息，只报告最近 30 秒（含）以内的错误 | string |
| `last_err_time` | 最后一次报错时间（Unix 时间戳，单位为秒）          |  int   |
| `last_time`     | 最近一次采集时间（Unix 时间戳，单位为秒）          |  int   |

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->

### :material-chat-question: 为什么 `entries` 和 `entries_limit` 采集不到，显示为 -1？ {#no-entries}

<!-- markdownlint-enable -->

需要加载 `nf_conntrack` 模块，终端执行 `modprobe nf_conntrack` 即可。
