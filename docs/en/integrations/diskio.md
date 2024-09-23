---
title     : 'Disk IO'
summary   : 'Collect metrics of disk io'
tags:
  - 'HOST'
__int_icon      : 'icon/diskio'
dashboard :
  - desc  : 'Disk IO'
    path  : 'dashboard/en/diskio'
monitor   :
  - desc  : 'Host detection library'
    path  : 'monitor/en/host'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :material-kubernetes: :material-docker:

---

Diskio collector is used to collect the index of disk flow and time.

## Configuration {#config}

After successfully installing and starting DataKit, the DiskIO collector will be enabled by default without the need for manual activation.

### Precondition {#requirement}

For some older versions of Windows operating systems, if you encounter an error with Datakit: **"The system cannot find the file specified."**

Run PowerShell as an administrator and execute:

```powershell
diskperf -Y
```

The Datakit service needs to be restarted after successful execution.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `diskio.conf.sample` and name it `diskio.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.diskio]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
    
      ## By default, gather stats for all devices including
      ## disk partitions.
      ## Setting interfaces using regular expressions will collect these expected devices.
      # devices = ['''^sda\d*''', '''^sdb\d*''', '''vd.*''']
    
      ## If the disk serial number is not required, please uncomment the following line.
      # skip_serial_number = true
    
      ## On systems which support it, device metadata can be added in the form of
      ## tags.
      ## Currently only Linux is supported via udev properties. You can view
      ## available properties for a device by running:
      ## 'udevadm info -q property -n /dev/sda'
      ## Note: Most, but not all, udev properties can be accessed this way. Properties
      ## that are currently inaccessible include DEVTYPE, DEVNAME, and DEVPATH.
      # device_tags = ["ID_FS_TYPE", "ID_FS_USAGE"]
    
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
    
    [inputs.diskio.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_DISKIO_INTERVAL**
    
        Collect interval
    
        **Type**: TimeDuration
    
        **input.conf**: `interval`
    
        **Default**: 10s
    
    - **ENV_INPUT_DISKIO_DEVICES**
    
        Setting interfaces using regular expressions will collect these expected devices
    
        **Type**: List
    
        **input.conf**: `devices`
    
        **Example**: `^sda\d,^sdb\d,vd.*`
    
    - **ENV_INPUT_DISKIO_DEVICE_TAGS**
    
        Device metadata added tags
    
        **Type**: List
    
        **input.conf**: `device_tags`
    
        **Example**: ID_FS_TYPE,ID_FS_USAGE
    
    - **ENV_INPUT_DISKIO_NAME_TEMPLATES**
    
        Using the same metadata source as device_tags
    
        **Type**: List
    
        **input.conf**: `name_templates`
    
        **Example**: $ID_FS_LABEL,$DM_VG_NAME/$DM_LV_NAME
    
    - **ENV_INPUT_DISKIO_SKIP_SERIAL_NUMBER**
    
        disk serial number is not required
    
        **Type**: Boolean
    
        **input.conf**: `skip_serial_number`
    
        **Default**: false
    
    - **ENV_INPUT_DISKIO_TAGS**
    
        Customize tags. If there is a tag with the same name in the configuration file, it will be overwritten
    
        **Type**: Map
    
        **input.conf**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## Metric {#metric}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or it can be named by `[[inputs.diskio.tags]]` alternative host in the configuration.



### `diskio`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|
|`name`|Device name.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`io_time`|Time spent doing I/Os.|int|ms|
|`iops_in_progress`|I/Os currently in progress.|int|count|
|`merged_reads`|The number of merged read requests.|int|count|
|`merged_writes`|The number of merged write requests.|int|count|
|`read_bytes`|The number of bytes read from the device.|int|B|
|`read_bytes/sec`|The number of bytes read from the per second.|int|B/S|
|`read_time`|Time spent reading.|int|ms|
|`reads`|The number of read requests.|int|count|
|`weighted_io_time`|Weighted time spent doing I/Os.|int|ms|
|`write_bytes`|The number of bytes written to the device.|int|B|
|`write_bytes/sec`|The number of bytes written to the device per second.|int|B/S|
|`write_time`|Time spent writing.|int|ms|
|`writes`|The number of write requests.|int|count|



### Extended Metric {#extend}

[:octicons-tag-24: Version-1.5.7](../datakit/changelog.md#cl-1.5.7)

### Collecting disk `await` for Linux {#linux-await}

By default, DataKit cannot collect the disk `await` metric. If you need to obtain this metric, you can collect it by [Custom Collector with Python](../developers/pythond.md).

Preconditions

- [Enable Pythond collector](../developers/pythond.md)

Enter the DataKit installation directory, copy the `pythond.conf.sample` file and rename it to `pythond.conf`. Modify the corresponding configuration as follows:

```toml

[[inputs.pythond]]

    # Python collector name 
    name = 'diskio'  # required

    # Environment variables 
    #envs = ['LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH',]

    # Python collector executable path (preferably use absolute path) 
    cmd = "python3" # required. python3 is recommended.

    # Relative path of the user script
    dirs = ["diskio"]

```

- Install `sar` command. You can refer to [https://github.com/sysstat/sysstat#installation](https://github.com/sysstat/sysstat#installation){:target="_blank"}

Install from Ubuntu

```shell
sudo apt-get install sysstat

sudo vi /etc/default/sysstat
# change ENABLED="false" to ENABLED="true"

sudo service sysstat restart
```

After installation, you can ran the following command to check if it was successful.

```shell
sar -d -p 3 1

Linux 2.6.32-696.el6.x86_64 (lgh)   10/06/2019      _x86_64_        (32 CPU)

10:08:16 PM       DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz  avgqu-sz     await     svctm     %util
10:08:17 PM    dev8-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
10:08:17 PM  dev253-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
10:08:17 PM  dev253-1      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00

10:08:17 PM       DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz  avgqu-sz     await     svctm     %util
10:08:18 PM    dev8-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
10:08:18 PM  dev253-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
10:08:18 PM  dev253-1      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00

10:08:18 PM       DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz  avgqu-sz     await     svctm     %util
10:08:19 PM    dev8-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
10:08:19 PM  dev253-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
10:08:19 PM  dev253-1      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00

Average:          DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz  avgqu-sz     await     svctm     %util
Average:       dev8-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:     dev253-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:     dev253-1      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00

```

### Collect Scripts {#py-script}

Create file *<DataKit Dir\>/python.d/diskio/diskio.py* and add the following content:

```python
import subprocess
import re
from datakit_framework import DataKitFramework


class DiskIO(DataKitFramework):
    name = "diskio"
    interval = 10

    def run(self):
        stats = self.getStats()

        data = []

        for s in stats:
            tags = {
                "name": s.get("DEV", "")
            }
            awaitVal = 0.0
            svctmVal = 0.0

            try:
                awaitVal = float(s.get("await"))
            except:
                awaitVal = 0.0
            try:
                svctmVal = float(s.get("svctm"))
            except:
                svctmVal = 0.0

            fields = {
                "await": awaitVal,
                "svctm": svctmVal
            }
            data.append({
                "measurement": "diskio",
                "tags": tags,
                "fields": fields
            })

        in_data = {
            "M": data,
            "input": "datakitpy"
        }

        return self.report(in_data)

    def getStats(self):
        result = subprocess.run(
            ["sar", "-d", "-p", "3", "1"], stdout=subprocess.PIPE)
        output = result.stdout.decode("utf-8")

        str_list = output.splitlines()

        columns = []
        stats = []
        pattern = r'\s+'
        isAverage = False
        for l in enumerate(str_list):
            index, content = l
            if index < 2:
                continue

            stat = re.split(pattern, content)

            if len(stat) == 0 or stat[0] == "":
                isAverage = True
                continue

            if not isAverage:
                continue
            if "await" in stat and "DEV" in stat:
                columns = stat
            else:
                stat_info = {}
                if len(stat) != len(columns):
                    continue

                for s in enumerate(columns):
                    index, name = s
                    if index == 0:
                        continue
                    stat_info[name] = stat[index]
                stats.append(stat_info) 
        return stats

```

After saving the file, restart DataKit and you will be able to see the corresponding metrics on the Guance platform shortly.

### Metric List {#ext-metrics}

The `sar` command can obtain many useful [disk metrics](https://man7.org/linux/man-pages/man1/sar.1.html){:target="_blank"}. The above script only collect `await` and `svctm`. If you need to collect additional metrics, you can modify the script accordingly.

| Metric | Description | Type | Unit |
| ---- | ---- | ---- | ---- |
| `await` | The average time (in milliseconds) for I/O requests issued to the device to be served.  This includes the time spent by the requests in queue and the time spent servicing them. | float | ms |
| `svctm` | awaitThe average service time (in milliseconds) for I/O requests that were issued to the device. | float | ms |


## FAQ {#faq}

### What is the data source on Linux hosts {#linux-diskio}

On Linux hosts, the metrics are parsed and calculated from the */proc/diskstats* file; an explanation of each column can be found in [*procfs-diskstats*](https://www.kernel.org/doc/Documentation/ABI/testing/procfs-diskstats){:target="_blank"};

The corresponding relationship between some data source columns and indicators is as follows:

| col04: reads completed successfully        | `reads`                                                   |
| col05: reads merged                        | `merged_reads`                                            |
| col06: sectors read                        | `read_bytes = col06 * sector_size`; `read_bytes/sec = (read_bytes - last(read_bytes))/(time - last(time))`      |
| col07: time spent reading (ms)             | `read_time`                                               |
| col08: writes completed                    | `writes`                                                  |
| col09: writes merged                       | `merged_writes`                                           |
| col10: sectors written                     | `write_bytes = col10 * sector_size`; `write_bytes/sec = (write_bytes - last(write_bytes))/(time - last(time))` |
| col11: time spent writing (ms)             | `write_time`                                              |
| col12: I/Os currently in progress          | `iops_in_progress`                                        |
| col13: time spent doing I/Os (ms)          | `io_time`                                                 |
| col14: weighted time spent doing I/Os (ms) | `weighted_io_time`                                        |

attention:

1. Sector size is 512 bytes;
2. Increment all but read_bytes/sec and write_bytes/sec.
