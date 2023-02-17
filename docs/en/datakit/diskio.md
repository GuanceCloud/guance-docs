

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

- tag


| Tag | Descrition |
|  ----  | --------|
|`host`|System hostname.|
|`name`|Device name.|

- metric list


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`io_time`|Time spent doing I/Os.|int|ms|
|`iops_in_progress`|I/Os currently in progres.|int|count|
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


