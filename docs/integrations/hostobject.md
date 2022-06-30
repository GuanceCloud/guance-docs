
# 主机对象
---

- DataKit 版本：1.4.5
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

hostobject 用于收集主机基本信息，如硬件型号、基础资源消耗等。

## 前置条件

暂无

## 配置

进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `hostobject.conf.sample` 并命名为 `hostobject.conf`。示例如下：

```toml

[inputs.hostobject]

## Datakit does not collect network virtual interfaces under the linux system.
## Setting enable_net_virtual_interfaces to true will collect network virtual interfaces stats for linux.
# enable_net_virtual_interfaces = true

##############################
# Disk related options
##############################
## Ignore mount points by filesystem type. Default ignored following FS types
# ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "autofs", "squashfs", "aufs"]

# Physical devices only (e.g. hard disks, cd-rom drives, USB keys)
# and ignore all others (e.g. memory partitions such as /dev/shm)
only_physical_device = false

# Ignore the disk which space is zero
ignore_zero_bytes_disk = true

[inputs.hostobject.tags] # (optional) custom tags
# cloud_provider = "aliyun" # aliyun/tencent/aws/hwcloud/azure
# some_tag = "some_value"
# more_tag = "some_other_value"
# ...

```

配置好后，重启 DataKit 即可。

### 环境变量配置

支持以环境变量的方式修改配置参数（只在 DataKit 以 K8s daemonset 方式运行时生效，主机部署的 DataKit 不支持此功能）：

| 环境变量名                                           | 对应的配置参数项                | 参数说明 | 参数示例                                                     |
| :---                                                 | ---                             | ---| ---                                                          |
| `ENV_INPUT_HOSTOBJECT_ENABLE_NET_VIRTUAL_INTERFACES` | `enable_net_virtual_interfaces` | 允许采集虚拟网卡| `true`/`false`                                               |
| `ENV_INPUT_HOSTOBJECT_ENABLE_ZERO_BYTES_DISK`        | `ignore_zero_bytes_disk`        | 忽略大小为 0 的磁盘 | `true`/`false`                                               |
| `ENV_INPUT_HOSTOBJECT_TAGS`                          | `tags`                          | 增加额外标签| `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它 |
| `ENV_INPUT_HOSTOBJECT_ONLY_PHYSICAL_DEVICE`          | `only_physical_device`          | 忽略非物理磁盘（如网盘、NFS 等，只采集本机硬盘/CD ROM/USB 磁盘等） | 任意给一个字符串值即可 |
| `ENV_INPUT_HOSTOBJECT_IGNORE_FILE_SYSTEM`            | `ignore_fs`                     | 忽略的文件系统类型列表 | 英文逗号分隔的文件系统类型列表，当前默认列表为 `tmpfs,devtmpfs,devfs,iso9660,overlay,autofs,squashfs,aufs`|
| `ENV_CLOUD_PROVIDER`                                 | `tags`                          | 指定云服务商 | `aliyun/aws/tencent/hwcloud/azure`              |

## 开启云同步

如果 DataKit 所在的主机是云主机（目前支持阿里云/腾讯云/AWS/华为云/微软云），那么可通过 `cloud_provider` 标签开启云同步：

```toml
[inputs.hostobject.tags]
  # 此处目前支持 aliyun/tencent/aws/hwcloud/azure 几种
  cloud_provider = "aliyun"
```

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.hostobject.tags]` 指定其它标签：

``` toml
 [inputs.hostobject.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

> 注意：这里添加自定义 tag 时，尽量不要跟已有的 tag key/field key 同名。如果同名，DataKit 将选择配置里面的 tag 来覆盖采集的数据，可能导致一些数据问题。



### `HOST`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`os`|主机操作系统类型|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`cpu_usage`|CPU 使用率|float|percent|
|`datakit_ver`|采集器版本|string|-|
|`load`|系统负载|float|-|
|`mem_used_percent`|内存使用率|float|percent|
|`message`|主机所有信息汇总|string|-|
|`start_time`|主机启动时间（Unix 时间戳）|int|s|
|`state`|主机状态|string|-|



如果开启了云同步，会多出如下一些字段（以同步到的字段为准）：

| 字段名                  | 描述           | 类型   |
| ---                     | ----           | :---:  |
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


### `message` 指标字段结构

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
  },

  "collectors": [ # 各个采集器的运行情况
    ...
  ]
}
```

#### `host.meta`

| 字段名             | 描述                                           | 类型   |
| ---                | ----                                           | :---:  |
| `host_name`        | 主机名                                         | string |
| `boot_time`        | 开机时间                                       | int    |
| `os`               | 操作系统类型，如 `linux/windows/darwin`        | string |
| `platform`         | 平台名称，如 `ubuntu`                          | string |
| `platform_family`  | 平台分类，如 `ubuntu` 属于 `debian` 分类       | string |
| `platform_version` | 平台版本，如 `18.04`，即 Ubuntu 的某个分发版本 | string |
| `kernel_release`   | 内核版本，如 `4.15.0-139-generic`              | string |
| `arch`             | CPU 硬件架构，如 `x86_64/arm64` 等             | string |
| `extra_cloud_meta` | 开启云同步时，会带上一串云属性的 JSON 数据     | string |

#### `host.cpu`

| 字段名        | 描述                                                    | 类型   |
| ---           | ----                                                    |:---:   |
| `vendor_id`   | 供应商 ID，如 `GenuineIntel`                            | string |
| `module_name` | CPU 型号，如 `Intel(R) Core(TM) i5-8210Y CPU @ 1.60GHz` | string |
| `cores`       | 核数                                                    | int    |
| `mhz`         | 频率                                                    | int    |
| `cache_size`  | L2 缓存大小（KB）                                       | int    |

#### `host.mem`

| 字段名         | 描述       | 类型 |
| ---            | ----       |:---: |
| `memory_total` | 总内存大小 | int  |
| `swap_total`:  | swap 大小  | int  |

#### `host.net`

| 字段名  | 描述               | 类型     |
| ---     | ----               |:---:     |
| `mtu`   | 最大传输单元       | int      |
| `name`  | 网卡名称           | string   |
| `mac`   | MAC 地址           | string   |
| `flags` | 状态位（可能多个） | []string |
| `ip4`   | IPv4 地址          | string   |
| `ip6`   | IPv6 地址          | string   |
| `ip4_all`| 所有 IPv4 地址     | []string |
| `ip6_all`| 所有 IPv6 地址     | []string |

#### `host.disk`

| 字段名       | 描述         | 类型   |
| ---          | ----         |:---:   |
| `device`     | 磁盘设备名   | string |
| `total`      | 磁盘总大小   | int    |
| `mountpoint` | 挂载点       | string |
| `fstype`     | 文件系统类型 | string |

#### `host.election`

> 注意：当配置文件中 `enable_election`选项关闭时，该字段为null

| 字段名       | 描述         | 类型   |
| ---          | ----         |:---:   |
| `elected`     | 选举状态      | string |
| `namespace`     | 选举空间      | string |


#### `host.conntrack`

> 注意：仅 Linux 平台支持

| 字段名                | 描述                                           | 类型  |
| ---                   | ---                                            | :---: |
| `entries`             | 当前连接数量                                   | int   |
| `entries_limit`       | 连接跟踪表的大小                               | int   |
| `stat_found`          | 成功的搜索条目数目                             | int   |
| `stat_invalid`        | 不能被跟踪的包数目                             | int   |
| `stat_ignore`         | 已经被跟踪的报数目                             | int   |
| `stat_insert`         | 插入的包数目                                   | int   |
| `stat_insert_failed`  | 插入失败的包数目                               | int   |
| `stat_drop`           | 跟踪失败被丢弃的包数目                         | int   |
| `stat_early_drop`     | 由于跟踪表满而导致部分已跟踪包条目被丢弃的数目 | int   |
| `stat_search_restart` | 由于hash表大小修改而导致跟踪表查询重启的数目   | int   |

#### `host.filefd`

> 注意：仅 Linux 平台支持

| 字段名         | 描述                                                 | 类型  |
| ---            | ---                                                  | :---: |
| `allocated`    | 已分配文件句柄的数目                                 | int   |
| `maximum`      | 文件句柄的最大数目（已弃用，用 `maximum_mega` 替代） | int   |
| `maximum_mega` | 文件句柄的最大数目，单位 M(10^6)                     | float |

#### 采集器运行情况字段列表

`collectors` 字段是一个对象列表，每个对象的字段如下：

| 字段名          | 描述                                             | 类型   |
| ---             | ----                                             | :---:  |
| `name`          | 采集器名称                                       | string |
| `count`         | 采集次数                                         | int    |
| `last_err`      | 最后一次报错信息，只报告最近 30 秒(含)以内的错误 | string |
| `last_err_time` | 最后一次报错时间（Unix 时间戳，单位为秒）        | int    |
| `last_time`     | 最近一次采集时间（Unix 时间戳，单位为秒）        | int    |
