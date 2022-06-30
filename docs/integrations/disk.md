
# Disk
---

- DataKit 版本：1.4.3
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

disk 采集器用于主机磁盘信息采集，如磁盘存储空间、inodes 使用情况等。

## 前置条件

暂无

## 配置

进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `disk.conf.sample` 并命名为 `disk.conf`。示例如下：

```toml

[[inputs.disk]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'

  ## By default stats will be gathered for all mount points.
  ## Set mount_points will restrict the stats to only the specified mount points.
  # mount_points = ["/"]

  # Physical devices only (e.g. hard disks, cd-rom drives, USB keys)
  # and ignore all others (e.g. memory partitions such as /dev/shm)
  only_physical_device = false

  ## Ignore mount points by filesystem type.
  ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"]

  [inputs.disk.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

配置好后，重启 DataKit 即可。

支持以环境变量的方式修改配置参数（只在 DataKit 以 K8s daemonset 方式运行时生效，主机部署的 DataKit 不支持此功能）：

| 环境变量名                            | 对应的配置参数项       | 参数示例                                                                                 |
| ---                                   | ---                    | ---                                                                                      |
| `ENV_INPUT_DISK_IGNORE_FS`            | `ignore_fs`            | `tmpfs,devtmpfs,devfs,iso9660,overlay,aufs,squashfs` 以英文逗号隔开                      |
| `ENV_INPUT_DISK_TAGS`                 | `tags`                 | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它                             |
| `ENV_INPUT_DISK_ONLY_PHYSICAL_DEVICE` | `only_physical_device` | 忽略非物理磁盘（如网盘、NFS 等，只采集本机硬盘/CD ROM/USB 磁盘等）任意给一个字符串值即可 |
| `ENV_INPUT_DISK_INTERVAL`             | `interval`             | `10s`                                                                                    |
| `ENV_INPUT_DISK_MOUNT_POINTS`         | `mount_points`         | `/, /path/to/point1, /path/to/point2` 以英文逗号隔开                                     |

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.disk.tags]` 指定其它标签：

``` toml
 [inputs.disk.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `disk`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`device`|磁盘设备名|
|`fstype`|文件系统名|
|`host`|主机名|
|`mode`|读写模式|
|`path`|磁盘挂载点|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`free`|Free disk size in bytes|int|B|
|`inodes_free`|Free inodes(**DEPRECATED: use inodes_free_mb instead**)|int|count|
|`inodes_free_mb`|Free inodes(in MB)|int|count|
|`inodes_total`|Total inodes(**DEPRECATED: use inodes_total_mb instead**)|int|count|
|`inodes_total_mb`|Total inodes(in MB)|int|count|
|`inodes_used`|Used inodes(**DEPRECATED: use inodes_used_mb instead**)|int|count|
|`inodes_used_mb`|Used inodes(in MB)|int|count|
|`total`|Total disk size in bytes|int|B|
|`used`|Used disk size in bytes|int|B|
|`used_percent`|Used disk size in percent|float|percent|


