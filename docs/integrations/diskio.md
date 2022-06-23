
# DiskIO
---

- DataKit 版本：1.4.3
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

diskio 采集器用于磁盘流量和时间的指标的采集

## 前置条件

对于部分旧版本 Windows 操作系统，如若遇到 Datakit 报错： **"The system cannot find the file specified."**

请以管理员身份运行 PowerShell，并执行：

```powershell
diskperf -Y
```

在执行成功后需要重启 Datakit 服务。

## 配置

进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `diskio.conf.sample` 并命名为 `diskio.conf`。示例如下：

```toml

[[inputs.diskio]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'
  ##
  ## By default, gather stats for all devices including
  ## disk partitions.
  ## Setting interfaces using regular expressions will collect these expected devices.
  # devices = ['''^sda\d*''', '''^sdb\d*''', '''vd.*''']
  #
  ## If the disk serial number is not required, please uncomment the following line.
  # skip_serial_number = true
  #
  ## On systems which support it, device metadata can be added in the form of
  ## tags.
  ## Currently only Linux is supported via udev properties. You can view
  ## available properties for a device by running:
  ## 'udevadm info -q property -n /dev/sda'
  ## Note: Most, but not all, udev properties can be accessed this way. Properties
  ## that are currently inaccessible include DEVTYPE, DEVNAME, and DEVPATH.
  # device_tags = ["ID_FS_TYPE", "ID_FS_USAGE"]
  #
  ## Using the same metadata source as device_tags,
  ## you can also customize the name of the device through a template.
  ## The "name_templates" parameter is a list of templates to try to apply equipment.
  ## The template can contain variables of the form "$PROPERTY" or "${PROPERTY}".
  ## The first template that does not contain any variables that do not exist
  ## for the device is used as the device name label.
  ## A typical use case for LVM volumes is to obtain VG/LV names,
  ## not DM-0 names which are almost meaningless.
  ## In addition, "device" is reserved specifically to indicate the device name.
  # name_templates = ["$ID_FS_LABEL","$DM_VG_NAME/$DM_LV_NAME", "$device:$ID_FS_TYPE"]
  #

[inputs.diskio.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

配置好后，重启 DataKit 即可。

支持以环境变量的方式修改配置参数（只在 DataKit 以 K8s daemonset 方式运行时生效，主机部署的 DataKit 不支持此功能）：

| 环境变量名                            | 对应的配置参数项     | 参数示例                                                     |
| :---                                  | ---                  | ---                                                          |
| `ENV_INPUT_DISKIO_SKIP_SERIAL_NUMBER` | `skip_serial_number` | `true`/`false`                                               |
| `ENV_INPUT_DISKIO_TAGS`               | `tags`               | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它 |
| `ENV_INPUT_DISKIO_INTERVAL`           | `interval`           | `10s`                                                        |
| `ENV_INPUT_DISKIO_DEVICES`            | `devices`            | `'''^sdb\d*'''`                                              |
| `ENV_INPUT_DISKIO_DEVICE_TAGS`        | `device_tags`        | `"ID_FS_TYPE", "ID_FS_USAGE"` 以英文逗号隔开                 |
| `ENV_INPUT_DISKIO_NAME_TEMPLATES`     | `name_templates`     | `"$ID_FS_LABEL", "$DM_VG_NAME/$DM_LV_NAME"` 以英文逗号隔开   |

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[[inputs.diskio.tags]]` 另择 host 来命名。



### `diskio`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名|
|`name`|磁盘设备名|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`io_time`|time spent doing I/Os|int|ms|
|`iops_in_progress`|I/Os currently in progress|int|count|
|`merged_reads`|reads merged|int|count|
|`merged_writes`|writes merged|int|count|
|`read_bytes`|read bytes|int|B|
|`read_bytes/sec`|read bytes per second|int|B/S|
|`read_time`|time spent reading|int|ms|
|`reads`|reads completed successfully|int|count|
|`weighted_io_time`|weighted time spent doing I/Os|int|ms|
|`write_bytes`|write bytes|int|B|
|`write_bytes/sec`|write bytes per second|int|B/S|
|`write_time`|time spent writing|int|ms|
|`writes`|writes completed|int|count|


