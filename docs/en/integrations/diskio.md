---
title     : 'Disk IO'
summary   : 'Collect Disk IO Metrics data'
tags:
  - 'Host'
__int_icon      : 'icon/diskio'
dashboard :
  - desc  : 'Disk IO'
    path  : 'dashboard/en/diskio'
monitor   :
  - desc  : 'Host Monitoring Library'
    path  : 'monitor/en/host'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :material-kubernetes: :material-docker:

---

The Disk IO collector is used to collect metrics related to disk traffic and time.

## Configuration {#config}

After successfully installing DataKit and starting it, the DiskIO collector will be enabled by default, so there is no need for manual activation.

### Prerequisites {#requirement}

For some older versions of Windows operating systems, if you encounter an error from DataKit: **"The system cannot find the file specified."**

Please run PowerShell as an administrator and execute:

```powershell
$ diskperf -Y
...
```

After successful execution, you need to restart the DataKit service.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `diskio.conf.sample` and rename it to `diskio.conf`. An example is shown below:

    ```toml
        
    [[inputs.diskio]]
      ## (optional) collection interval, default is 10 seconds
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

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    You can also modify configuration parameters via environment variables (you need to add it to ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_DISKIO_INTERVAL**
    
        Collector repeat interval duration
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `interval`
    
        **Default Value**: 10s
    
    - **ENV_INPUT_DISKIO_DEVICES**
    
        Use regex to set interfaces that will collect these expected devices
    
        **Field Type**: List
    
        **Collector Configuration Field**: `devices`
    
        **Example**: `^sda\d,^sdb\d,vd.*`
    
    - **ENV_INPUT_DISKIO_DEVICE_TAGS**
    
        Device additional tags
    
        **Field Type**: List
    
        **Collector Configuration Field**: `device_tags`
    
        **Example**: ID_FS_TYPE,ID_FS_USAGE
    
    - **ENV_INPUT_DISKIO_NAME_TEMPLATES**
    
        Use the same metadata source as device_tags
    
        **Field Type**: List
    
        **Collector Configuration Field**: `name_templates`
    
        **Example**: $ID_FS_LABEL,$DM_VG_NAME/$DM_LV_NAME
    
    - **ENV_INPUT_DISKIO_SKIP_SERIAL_NUMBER**
    
        Do not require disk serial number
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `skip_serial_number`
    
        **Default Value**: false
    
    - **ENV_INPUT_DISKIO_TAGS**
    
        Custom tags. If the config file has the same named tag, it will overwrite it
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## Metrics {#metric}

All data collected below will append a global tag named `host` (tag value is the hostname where DataKit resides), or you can specify another host name through `[[inputs.diskio.tags]]` in the configuration.



### `diskio`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|
|`name`|Device name.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`io_time`|Time spent doing I/Os.|int|ms|
|`iops_in_progress`|I/Os currently in progress.|int|count|
|`merged_reads`|The number of merged read requests.|int|count|
|`merged_writes`|The number of merged write requests.|int|count|
|`read_bytes`|The number of bytes read from the device.|int|B|
|`read_bytes/sec`|The number of bytes read per second.|int|B/S|
|`read_time`|Time spent reading.|int|ms|
|`reads`|The number of read requests.|int|count|
|`weighted_io_time`|Weighted time spent doing I/Os.|int|ms|
|`write_bytes`|The number of bytes written to the device.|int|B|
|`write_bytes/sec`|The number of bytes written to the device per second.|int|B/S|
|`write_time`|Time spent writing.|int|ms|
|`writes`|The number of write requests.|int|count|



### Extended Metrics {#extend}

[:octicons-tag-24: Version-1.5.7](../datakit/changelog.md#cl-1.5.7)

### Collecting `await` on Linux Platforms {#linux-await}

By default, DataKit cannot collect the `await` metric for disks. To obtain this metric, you can use a [custom Python collector](../developers/pythond.md).

Navigate to the DataKit installation directory, copy the `pythond.conf.sample` file and rename it to `pythond.conf`. Modify the relevant configuration as follows:

```toml
[[inputs.pythond]]

    # Python collector name
    name = 'diskio'  # required

    # Environment variables required to run the Python collector
    #envs = ['LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH',]

    # Path to the Python collector executable (use absolute paths when possible)
    cmd = "python3" # required. python3 is recommended.

    # Relative path to user scripts (enter the folder; all modules and py files in the next level directory will be applied)
    dirs = ["diskio"]

```

- Install the `sar` command, refer to [https://github.com/sysstat/sysstat#installation](https://github.com/sysstat/sysstat#installation){:target="\_blank"}

For Ubuntu installation, follow these steps:

```shell
sudo apt-get install sysstat

sudo vi /etc/default/sysstat
# change ENABLED="false" to ENABLED="true"

sudo service sysstat restart
```

After installation, you can run the following command to verify:

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

### Collection Script {#py-script}

Create a new file *[DataKit Directory]/python.d/diskio/diskio.py*, with the following content:

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

After saving the file, restart DataKit, and shortly after you should see the corresponding metrics on the Guance platform.

### Metrics List {#ext-metrics}

The `sar` command can collect many useful [disk metrics](https://man7.org/linux/man-pages/man1/sar.1.html){:target="_blank"}, the above script only collects `await` and `svctm`. If you need to collect additional metrics, you can modify the script accordingly.

| Metric  | Description         | Type  | Unit |
| ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- | ---- |
| `await` | The average time (in milliseconds) for I/O requests issued to the device to be served. This includes the time spent by the requests in queue and the time spent servicing them. | float | ms   |
| `svctm` | The average service time (in milliseconds) for I/O requests that were issued to the device.                                                                                  | float | ms   |


## FAQ {#faq}

### What is the data source for `diskio` metrics on Linux hosts? {#linux-diskio}

On Linux hosts, metrics are obtained from the */proc/diskstats* file through parsing and calculation; each column's explanation can be referenced in the [documentation](https://www.kernel.org/doc/Documentation/ABI/testing/procfs-diskstats){:target="_blank"};

Some data source columns and metric correspondences are:

| `diskstats` field                           | `diskio` metric                                                                                                  |
| ---                                        | ---                                                                                                            |
| col04: reads completed successfully        | `reads`                                                                                                        |
| col05: reads merged                        | `merged_reads`                                                                                                 |
| col06: sectors read                        | `read_bytes = col06 * sector_size`; `read_bytes/sec = (read_bytes - last(read_bytes))/(time - last(time))`     |
| col07: time spent reading (ms)             | `read_time`                                                                                                    |
| col08: writes completed                    | `writes`                                                                                                       |
| col09: writes merged                       | `merged_writes`                                                                                                |
| col10: sectors written                     | `write_bytes = col10 * sector_size`; `write_bytes/sec = (write_bytes - last(write_bytes))/(time - last(time))` |
| col11: time spent writing (ms)             | `write_time`                                                                                                   |
| col12: I/Os currently in progress          | `iops_in_progress`                                                                                             |
| col13: time spent doing I/Os (ms)          | `io_time`                                                                                                      |
| col14: weighted time spent doing I/Os (ms) | `weighted_io_time`                                                                                             |

Note:

1. Sector size (`sector_size`) is 512 bytes;
2. Except for `read_bytes/sec` and `write_bytes/sec`, all others are incremental values.
