
# 磁盘 S.M.A.R.T
---

- DataKit 版本：1.4.2
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

计算机硬盘运行状态数据采集

## 前置条件

安装 smartmontools

- Linux: `sudo apt install smartmontools -y`

	如果固态硬盘，符合  nvme 标准，建议安装 nvme-cli 以得到更多 nvme 信息：`sudo apt install nvme-cli -y`

- MacOS: `brew install smartmontools -y`
- WinOS: 下载 [Windows 版本](https://www.smartmontools.org/wiki/Download#InstalltheWindowspackage){:target="_blank"}


## 配置

进入 DataKit 安装目录下的 `conf.d/smart` 目录，复制 `smart.conf.sample` 并命名为 `smart.conf`。示例如下：

```toml

[[inputs.smart]]
  ## The path to the smartctl executable
  # path_smartctl = "/usr/bin/smartctl"

  ## The path to the nvme-cli executable
  # path_nvme = "/usr/bin/nvme"

  ## Gathering interval
  # interval = "10s"

  ## Timeout for the cli command to complete.
  # timeout = "30s"

  ## Optionally specify if vendor specific attributes should be propagated for NVMe disk case
  ## ["auto-on"] - automatically find and enable additional vendor specific disk info
  ## ["vendor1", "vendor2", ...] - e.g. "Intel" enable additional Intel specific disk info
  # enable_extensions = ["auto-on"]

  ## On most platforms used cli utilities requires root access.
  ## Setting 'use_sudo' to true will make use of sudo to run smartctl or nvme-cli.
  ## Sudo must be configured to allow the telegraf user to run smartctl or nvme-cli
  ## without a password.
  # use_sudo = false

  ## Skip checking disks in this power mode. Defaults to "standby" to not wake up disks that have stopped rotating.
  ## See --nocheck in the man pages for smartctl.
  ## smartctl version 5.41 and 5.42 have faulty detection of power mode and might require changing this value to "never" depending on your disks.
  # no_check = "standby"

  ## Optionally specify devices to exclude from reporting if disks auto-discovery is performed.
  # excludes = [ "/dev/pass6" ]

  ## Optionally specify devices and device type, if unset a scan (smartctl --scan and smartctl --scan -d nvme) for S.M.A.R.T. devices will be done
  ## and all found will be included except for the excluded in excludes.
  # devices = [ "/dev/ada0 -d atacam", "/dev/nvme0"]

  ## Customer tags, if set will be seen with every metric.
  [inputs.smart.tags]
    # "key1" = "value1"
    # "key2" = "value2"

```

配置好后，重启 DataKit 即可。

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.smart.tags]` 指定其它标签：

```toml
 [inputs.smart.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `smart`

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`capacity`|disk capacity|
|`device`|device mount name|
|`enabled`|is SMART supported|
|`exit_status`|command process status|
|`health_ok`|SMART overall-health self-assessment test result|
|`host`|host name|
|`model`|device model|
|`serial_no`|device serial number|
|`wwn`|WWN Device Id|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`airflow_temperature_cel_raw_value`|The raw value of air celsius temperature read from device record.|int|C|
|`airflow_temperature_cel_threshold`|The threshold of air celsius temperature read from device record.|int|C|
|`airflow_temperature_cel_value`|The value of air celsius temperature read from device record.|int|C|
|`airflow_temperature_cel_worst`|The worst value of air celsius temperature read from device record.|int|C|
|`avg_write/erase_count_raw_value`|The raw value of average write/ease count.|int|count|
|`avg_write/erase_count_value`|The value of average write/ease count.|int|count|
|`avg_write/erase_count_worst`|The worst value of average write/ease count.|int|count|
|`command_timeout_raw_value`|The raw value of command timeout.|int|count|
|`command_timeout_threshold`|The threshold of command timeout.|int|count|
|`command_timeout_value`|The value of command timeout.|int|count|
|`command_timeout_worst`|The worst value of command timeout.|int|count|
|`current_pending_sector_raw_value`|The raw value of current pending sector.|int|count|
|`current_pending_sector_threshold`|The threshold of current pending sector.|int|count|
|`current_pending_sector_value`|The value of current pending sector.|int|count|
|`current_pending_sector_worst`|The worst value of current pending sector.|int|count|
|`end-to-end_error_raw_value`|The raw value of bad data that loaded into cache and then written to the driver have had a different parity.|int|count|
|`end-to-end_error_threshold`|The threshold of bad data that loaded into cache and then written to the driver have had a different parity.|int|count|
|`end-to-end_error_value`|The value of bad data that loaded into cache and then written to the driver have had a different parity.|int|count|
|`end-to-end_error_worst`|The worst value of bad data that loaded into cache and then written to the driver have had a different parity.|int|count|
|`erase_fail_count_raw_value`|The raw value of erase failed count.|int|count|
|`erase_fail_count_value`|The value of erase failed count.|int|count|
|`erase_fail_count_worst`|The worst value of erase failed count.|int|count|
|`fail`|Read attribute failed.|bool|count|
|`flags`|Attribute falgs.|int|count|
|`g-sense_error_rate_raw_value`|The raw value of|int|count|
|`g-sense_error_rate_threshold`|The threshold value of g-sensor error rate.|int|count|
|`g-sense_error_rate_value`|The value of g-sensor error rate.|int|count|
|`g-sense_error_rate_worst`|The worst value of g-sensor error rate.|int|count|
|`high_fly_writes_raw_value`|The raw value of Fly Height Monitor.|int|count|
|`high_fly_writes_threshold`|The threshold value of Fly Height Monitor.|int|count|
|`high_fly_writes_value`|The value of Fly Height Monitor.|int|count|
|`high_fly_writes_worst`|The worst value of Fly Height Monitor.|int|count|
|`load_cycle_count_raw_value`|The raw value of load cycle count.|int|count|
|`load_cycle_count_threshold`|The threshold value of load cycle count.|int|count|
|`load_cycle_count_value`|The value of load cycle count.|int|count|
|`load_cycle_count_worst`|The worst value of load cycle count.|int|count|
|`maximum_erase_cycle_raw_value`|The raw value of maximum erase cycle count.|int|count|
|`maximum_erase_cycle_value`|The raw value of maximum erase cycle count.|int|count|
|`maximum_erase_cycle_worst`|The worst value of maximum erase cycle count.|int|count|
|`min_bad_block/die_raw_value`|The raw value of min bad block.|int|count|
|`min_bad_block/die_value`|The value of min bad block.|int|count|
|`min_bad_block/die_worst`|The worst value of min bad block.|int|count|
|`min_w/e_cycle_raw_value`|The raw value of min write/erase cycle count.|int|count|
|`min_w/e_cycle_value`|The value of min write/erase cycle count.|int|count|
|`min_w/e_cycle_worst`|The worst value of min write/erase cycle count.|int|count|
|`offline_uncorrectable_raw_value`|The raw value of offline uncorrectable.|int|count|
|`offline_uncorrectable_threshold`|The threshold value of offline uncorrectable.|int|count|
|`offline_uncorrectable_value`|The value of offline uncorrectable.|int|count|
|`offline_uncorrectable_worst`|The worst value of offline uncorrectable.|int|count|
|`perc_avail_resrvd_space_raw_value`|The raw value of available percentage of reserved space.|int|count|
|`perc_avail_resrvd_space_threshold`|The threshold value of available percentage of reserved space.|int|count|
|`perc_avail_resrvd_space_value`|The value of available reserved space.|int|count|
|`perc_avail_resrvd_space_worst`|The worst value of available reserved space.|int|count|
|`perc_write/erase_count_raw_value`|The raw value of write/erase count.|int|count|
|`perc_write/erase_count_value`|The value of of write/erase count.|int|count|
|`perc_write/erase_count_worst`|The worst value of of write/erase count.|int|count|
|`perc_write/erase_ct_bc_raw_value`|The raw value of write/erase count.|int|count|
|`perc_write/erase_ct_bc_value`|The value of write/erase count.|int|count|
|`perc_write/erase_ct_bc_worst`|The worst value of write/erase count.|int|count|
|`power-off_retract_count_raw_value`|The raw value of power-off retract count.|int|count|
|`power-off_retract_count_threshold`|The threshold value of power-off retract count.|int|count|
|`power-off_retract_count_value`|The value of power-off retract count.|int|count|
|`power-off_retract_count_worst`|The worst value of power-off retract count.|int|count|
|`power_cycle_count_raw_value`|The raw value of power cycle count.|int|count|
|`power_cycle_count_threshold`|The threshold value of power cycle count.|int|count|
|`power_cycle_count_value`|The value of power cycle count.|int|count|
|`power_cycle_count_worst`|The worst value of power cycle count.|int|count|
|`power_on_hours_raw_value`|The raw value of power on hours.|int|count|
|`power_on_hours_threshold`|The threshold value of power on hours.|int|count|
|`power_on_hours_value`|The value of power on hours.|int|count|
|`power_on_hours_worst`|The worst value of power on hours.|int|count|
|`program_fail_count_raw_value`|The raw value of program fail count.|int|count|
|`program_fail_count_value`|The value of program fail count.|int|count|
|`program_fail_count_worst`|The worst value of program fail count.|int|count|
|`raw_read_error_rate_raw_value`|The raw value of raw read error rate.|int|count|
|`raw_read_error_rate_threshold`|The threshold value of raw read error rate.|int|count|
|`raw_read_error_rate_value`|The value of raw read error rate.|int|count|
|`raw_read_error_rate_worst`|The worst value of raw read error rate.|int|count|
|`read_error_rate`|The read error rate.|int|count|
|`reallocated_sector_ct_raw_value`|The raw value of reallocated sector count.|int|count|
|`reallocated_sector_ct_threshold`|The threshold value of reallocated sector count.|int|count|
|`reallocated_sector_ct_value`|The value of reallocated sector count.|int|count|
|`reallocated_sector_ct_worst`|The worst value of reallocated sector count.|int|count|
|`reported_uncorrect_raw_value`|The raw value of reported uncorrect.|int|count|
|`reported_uncorrect_threshold`|The threshold value of reported uncorrect.|int|count|
|`reported_uncorrect_value`|The value of reported uncorrect.|int|count|
|`reported_uncorrect_worst`|The worst value of reported uncorrect.|int|count|
|`sata_crc_error_raw_value`|The raw value of S-ATA cyclic redundancy check error.|int|count|
|`sata_crc_error_value`|The value of S-ATA cyclic redundancy check error.|int|count|
|`sata_crc_error_worst`|The worst value of S-ATA cyclic redundancy check error.|int|count|
|`seek_error_rate`|Seek error rate.|int|count|
|`seek_error_rate_raw_value`|The raw value of seek error rate.|int|count|
|`seek_error_rate_threshold`|The threshold value of seek error rate.|int|count|
|`seek_error_rate_value`|The value of seek error rate.|int|count|
|`seek_error_rate_worst`|The worst value of seek error rate.|int|count|
|`spin_retry_count_raw_value`|The raw value of spin retry count.|int|count|
|`spin_retry_count_threshold`|The threshold value of spin retry count.|int|count|
|`spin_retry_count_value`|The value of spin retry count.|int|count|
|`spin_retry_count_worst`|The worst value of spin retry count.|int|count|
|`spin_up_time_raw_value`|The raw value of spin up time.|int|count|
|`spin_up_time_threshold`|The threshold value of spin up time.|int|count|
|`spin_up_time_value`|The value of spin up time.|int|count|
|`spin_up_time_worst`|The worst value of spin up time.|int|count|
|`start_stop_count_raw_value`|The raw value of start and stop count.|int|count|
|`start_stop_count_threshold`|The threshold value of start and stop count.|int|count|
|`start_stop_count_value`|The value of start and stop count.|int|count|
|`start_stop_count_worst`|The worst value of start and stop count.|int|count|
|`temp_c`|Device temperature.|int|C|
|`temperature_celsius_raw_value`|The raw value of temperature.|int|C|
|`temperature_celsius_threshold`|The threshold value of themperature.|int|C|
|`temperature_celsius_value`|The value of temperature.|int|C|
|`temperature_celsius_worst`|The worst value of temperature.|int|C|
|`thermal_throttle_raw_value`|The raw value of thermal throttle.|int|count|
|`thermal_throttle_value`|The value of thermal throttle.|int|count|
|`thermal_throttle_worst`|The worst value of thermal throttle.|int|count|
|`total_bad_block_raw_value`|The raw value of total bad block.|int|count|
|`total_bad_block_value`|The value of total bad block.|int|count|
|`total_bad_block_worst`|The worst value of total bad block.|int|count|
|`total_nand_writes_gib_raw_value`|The raw value of total NAND flush writes.|int|count|
|`total_nand_writes_gib_value`|The value of total NAND flush writes.|int|count|
|`total_nand_writes_gib_worst`|The worst value of total NAND flush writes.|int|count|
|`total_reads_gib_raw_value`|The raw value of total read.|int|count|
|`total_reads_gib_value`|The value of total read.|int|count|
|`total_reads_gib_worst`|The worst value of total read|int|count|
|`total_write/erase_count_raw_value`|The raw value of total write/erase count.|int|count|
|`total_write/erase_count_value`|The value of total write/erase count.|int|count|
|`total_write/erase_count_worst`|The worst value of total write/erase count.|int|count|
|`total_writes_gib_raw_value`|The raw value of total write.|int|count|
|`total_writes_gib_value`|The value of total write.|int|count|
|`total_writes_gib_worst`|The worst value of total write.|int|count|
|`udma_crc_error_count_raw_value`|The raw value of ultra direct memory access cyclic redundancy check error count.|int|count|
|`udma_crc_error_count_threshold`|The threshold value of ultra direct memory access cyclic redundancy check error count.|int|count|
|`udma_crc_error_count_value`|The value of ultra direct memory access cyclic redundancy check error count.|int|count|
|`udma_crc_error_count_worst`|The worst value of ultra direct memory access cyclic redundancy check error count.|int|count|
|`udma_crc_errors`|Ultra direct memory access cyclic redundancy check error count.|int|count|
|`unexpect_power_loss_ct_raw_value`|The raw value of unexpected power loss count.|int|count|
|`unexpect_power_loss_ct_value`|The value of unexpected power loss count.|int|count|
|`unexpect_power_loss_ct_worst`|The worst value of unexpected power loss count.|int|count|
|`unknown_attribute_raw_value`|The raw value of nknow attribute.|int|-|
|`unknown_attribute_value`|The value of unknow attribute.|int|-|
|`unknown_attribute_worst`|The worst value of unknow attribute.|int|-|


