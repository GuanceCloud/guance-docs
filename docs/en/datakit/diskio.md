
# DiskIO
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Diskio collector is used to collect the index of disk flow and time.

## Preconditions {#requests}

For some older versions of Windows operating systems, if you encounter an error with Datakit: **"The system cannot find the file specified."**

Run PowerShell as an administrator and execute:

```powershell
diskperf -Y
```

The Datakit service needs to be restarted after successful execution.

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `diskio.conf.sample` and name it `diskio.conf`. Examples are as follows:
    
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

    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Support modifying configuration parameters as environment variables:
    
    | Environment Variable Name                            | Corresponding Configuration Parameter Item     | Parameter Example                                                     |
    | :---                                  | ---                  | ---                                                          |
    | `ENV_INPUT_DISKIO_SKIP_SERIAL_NUMBER` | `skip_serial_number` | `true`/`false`                                               |
    | `ENV_INPUT_DISKIO_TAGS`               | `tags`               | `tag1=value1,tag2=value2`; If there is a tag with the same name in the configuration file, it will be overwritten. |
    | `ENV_INPUT_DISKIO_INTERVAL`           | `interval`           | `10s`                                                        |
    | `ENV_INPUT_DISKIO_DEVICES`            | `devices`            | `'''^sdb\d*'''`                                              |
    | `ENV_INPUT_DISKIO_DEVICE_TAGS`        | `device_tags`        | `"ID_FS_TYPE", "ID_FS_USAGE"`, separated by English commas                 |
    | `ENV_INPUT_DISKIO_NAME_TEMPLATES`     | `name_templates`     | `"$ID_FS_LABEL", "$DM_VG_NAME/$DM_LV_NAME"`, separated by English commas   |

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or it can be named by `[[inputs.diskio.tags]]` alternative host in the configuration.



### `diskio`

-  Tag


| Tag Name | Description    |
|  ----  | --------|
|`host`|hostname|
|`name`|Disk device name|

- Metrics List


| Metrics | Description| Data Type | Unit   |
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


