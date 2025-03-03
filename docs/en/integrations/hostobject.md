---
title     : 'Host Object'
summary   : 'Collect Basic Host Information'
tags:
  - 'HOST'
__int_icon      : 'icon/hostobject'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Host Object is used to collect basic host information, such as hardware model, basic resource consumption and so on.

## Configuration {#config}

### Collector Configuration {#input-config}

In general, the host object is turned on by default and does not need to be configured.

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `hostobject.conf.sample` and name it `hostobject.conf`. Examples are as follows:
    
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
    
    # merge disks that with the same device name(default false)
    # merge_on_device = false
    
    ## Ignore the disk which space is zero
    ignore_zero_bytes_disk = true
    
    ## Disable cloud provider information synchronization
    disable_cloud_provider_sync = false
    
    ## Enable put cloud provider region/zone_id information into global election tags, (default to true).
    # enable_cloud_host_tags_as_global_election_tags = true
    
    ## Enable put cloud provider region/zone_id information into global host tags, (default to true).
    # enable_cloud_host_tags_as_global_host_tags = true
    
    ## Enable AWS IMDSv2
    enable_cloud_aws_imds_v2 = false
    
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
    
    ## [inputs.hostobject.cloud_meta_token_url]
      # aws = "yyy"   # URL for AWS Cloud metadata token
    
    ```
    
    After configuration, restart DataKit.

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    - **ENV_INPUT_HOSTOBJECT_ENABLE_NET_VIRTUAL_INTERFACES**
    
        Enable collect network virtual interfaces
    
        **Type**: Boolean
    
        **input.conf**: `enable_net_virtual_interfaces`
    
        **Default**: false
    
    - **ENV_INPUT_HOSTOBJECT_IGNORE_ZERO_BYTES_DISK**
    
        Ignore the disk which space is zero
    
        **Type**: Boolean
    
        **input.conf**: `ignore_zero_bytes_disk`
    
        **Default**: false
    
    - **ENV_INPUT_HOSTOBJECT_ONLY_PHYSICAL_DEVICE**
    
        Physical devices only, any string
    
        **Type**: Boolean
    
        **input.conf**: `only_physical_device`
    
        **Default**: false
    
    - **ENV_INPUT_HOSTOBJECT_EXCLUDE_DEVICE**
    
        Exclude some with dev prefix
    
        **Type**: List
    
        **input.conf**: `exclude_device`
    
        **Example**: /dev/loop0,/dev/loop1
    
    - **ENV_INPUT_HOSTOBJECT_EXTRA_DEVICE**
    
        Additional device
    
        **Type**: List
    
        **input.conf**: `extra_device`
    
        **Example**: `/nfsdata,other`
    
    - **ENV_INPUT_HOSTOBJECT_CLOUD_META_AS_ELECTION_TAGS**
    
        Enable put cloud provider region/zone_id information into global election tags
    
        **Type**: Boolean
    
        **input.conf**: `enable_cloud_host_tags_global_election_tags`
    
        **Default**: true
    
    - **ENV_INPUT_HOSTOBJECT_CLOUD_META_AS_HOST_TAGS**
    
        Enable put cloud provider region/zone_id information into global host tags
    
        **Type**: Boolean
    
        **input.conf**: `enable_cloud_host_tags_global_host_tags`
    
        **Default**: true
    
    - **ENV_INPUT_HOSTOBJECT_CLOUD_AWS_IMDS_V2**
    
        Enable AWS IMDSv2
    
        **Type**: Boolean
    
        **input.conf**: `enable_cloud_aws_imds_v2`
    
        **Default**: false
    
    - **ENV_INPUT_HOSTOBJECT_TAGS**
    
        Customize tags. If there is a tag with the same name in the configuration file, it will be overwritten
    
        **Type**: Map
    
        **input.conf**: `tags`
    
        **Example**: tag1=value1,tag2=value2
    
    - **ENV_CLOUD_PROVIDER**
    
        Designate cloud service provider
    
        **Type**: String
    
        **input.conf**: `none`
    
        **Example**: `aliyun/aws/tencent/hwcloud/azure`
    
    - **ENV_CLOUD_META_URL**
    
        Cloud metadata URL mapping
    
        **Type**: Map
    
        **input.conf**: `cloud_meta_url`
    
        **Example**: `{"tencent":"xxx", "aliyun":"yyy"}`
    
    - **ENV_INPUT_HOSTOBJECT_CLOUD_META_TOKEN_URL**
    
        Cloud metadata Token URL mapping
    
        **Type**: Map
    
        **input.conf**: `cloud_meta_token_url`
    
        **Example**: `{"aws":"xxx", "aliyun":"yyy"}`

<!-- markdownlint-enable -->

### Turn on Cloud Synchronization {#cloudinfo}

Datakit turns on cloud synchronization by default, and currently supports Alibaba Cloud/Tencent Cloud/AWS/Huawei Cloud/Microsoft Cloud/Volcano Engine. You can specify the cloud vendor explicitly by setting the cloud_provider tag, or you can detect it automatically by Datakit:

```toml
[inputs.hostobject.tags]
  # There are several kinds of aliyun/tencent/aws/hwcloud/azure supported at present. If not set, Datakit will detect and set this tag automatically
  cloud_provider = "aliyun"
```

You can turn off cloud synchronization by configuring `disable_cloud_provider_sync = true` in the Host Object configuration file.

## Object {#object}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.hostobject.tags]`:

``` toml
 [inputs.hostobject.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

> Note: When adding custom tags here, try not to have the same name as the existing tag key/field key. If it has the same name, DataKit will choose to configure the tag inside to overwrite the collected data, which may cause some data problems.



### `HOST`

- Tags


| Tag | Description |
|  ----  | --------|
|`arch`|Host OS Arch|
|`host`|Hostname. Required.|
|`name`|Hostname|
|`os`|Host OS type|
|`unicast_ip`|Host unicast ip|

- Metrics


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



If cloud synchronization is turned on, the following additional fields will be added (whichever field is synchronized to):

| Field Name                  | Description           | Type   |
| ---                     | ----           | :---:  |
| `cloud_provider`        | Cloud service provider       | string |
| `description`           | Description           | string |
| `instance_id`           | Instance ID        | string |
| `instance_name`         | Instance name         | string |
| `instance_type`         | Instance type       | string |
| `instance_charge_type`  | Instance billing type   | string |
| `instance_network_type` | Instance network type   | string |
| `instance_status`       | Instance state       | string |
| `security_group_id`     | Instance grouping       | string |
| `private_ip`            | Instance private network IP    | string |
| `zone_id`               | Instance Zone ID   | string |
| `region`                | Instance Region ID | string |

### `message` Metric Field Structure {#message-struct}

The basic structure of the `message` field is as follows:

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

  "collectors": [ # Operation of each collector
    ...
  ]
}
```

#### `host.meta` {#host-meta}

| Field Name             | Description                                           | Type   |
| ---                | ----                                           | :---:  |
| `host_name`        | hostname                                         | string |
| `boot_time`        | Startup time                                       | int    |
| `os`               | Operating system type, such as `linux/windows/darwin`        | string |
| `platform`         | Platform name, such as `ubuntu`                          | string |
| `platform_family`  | Platform classification, such as `ubuntu` belongs to `debian` classification       | string |
| `platform_version` | Platform version, such as `18.04`, that is, a distribution version of Ubuntu | string |
| `kernel_release`   | Kernel version, such as `4.15.0-139-generic`              | string |
| `arch`             | Switch hardware architecture, such as `x86_64/arm64`            | string |
| `extra_cloud_meta` | When cloud synchronization is turned on, it will bring a string of JSON data with cloud attributes.     | string |

#### `host.cpu` {#host-cpu}

| Field Name        | Description                                                    | Type   |
| ---           | ----                                                    |:---:   |
| `vendor_id`   | Vendor ID, such as `GenuineIntel`                            | string |
| `module_name` | CPU model, such as `Intel(R) Core(TM) i5-8210Y CPU @ 1.60GHz` | string |
| `cores`       | Audit                                                    | int    |
| `mhz`         | Frequency                                                    | int    |
| `cache_size`  | L2 Cache size (KB)                                       | int    |

#### `host.mem` {#host-mem}

| Field Name         | Description       | Type |
| ---            | ----       |:---: |
| `memory_total` | Total memory size | int  |
| `swap_total`:  | swap size  | int  |

#### `host.net` {#host-net}

| Field Name  | Description               | Type     |
| ---     | ----               |:---:     |
| `mtu`   | Maximum transmission unit       | int      |
| `name`  | NIC Name           | string   |
| `mac`   | MAC address           | string   |
| `flags` | Status bits (may be multiple) | []string |
| `ip4`   | IPv4 address          | string   |
| `ip6`   | IPv6 address          | string   |
| `ip4_all`| all IPv4 address     | []string |
| `ip6_all`| all IPv6 address     | []string |

#### `host.disk` {#host-disk}

> In previous versions, only one mount point would be collected for the same device (which specific mount point was collected depended on the order in which the mount points appeared in */proc/self/mountpoint*). In the [:octicons-tag-24: Version-1.66.0](../datakit/changelog.md#cl-1.66.0) release, the disk section of the host object will collect all mount points that meet certain criteria (such as device names starting with `/dev`). The purpose of this change is to display all devices visible to Datakit to avoid any omissions.


| Field Name       | Description         | Type   |
| ---          | ----         |:---:   |
| `device`     | Disk device name   | string |
| `total`      | Total disk size   | int    |
| `mountpoint` | Mount point       | string |
| `fstype`     | File system type | string |

#### `host.election` {#host-election}

> Note: This field is null when the `enable_election` option is turned off in the configuration file

| Field Name      | Description     | Type   |
| ---         | ----     | :---:  |
| `elected`   | Election status | string |
| `namespace` | Election space | string |

#### `host.conntrack` {#host-conntrack}

<!-- markdownlint-disable MD046 -->

???+ attention

    `conntrack` 仅 Linux 平台支持

<!-- markdownlint-enable -->

| Field Name                | Description                                           | Type  |
| ---                   | ---                                            | :---: |
| `entries`             | Current number of connections                                   | int   |
| `entries_limit`       | Size of Connection Trace Table                               | int   |
| `stat_found`          | Number of successful search terms                             | int   |
| `stat_invalid`        | Number of packets that cannot be tracked                             | int   |
| `stat_ignore`         | Number of reports that have been tracked                             | int   |
| `stat_insert`         | Number of packets inserted                                   | int   |
| `stat_insert_failed`  | Number of packets that failed to insert                               | int   |
| `stat_drop`           | Trace failed the number of discarded packets                         | int   |
| `stat_early_drop`     | Number of partially tracked packet entries discarded due to full trace table | int   |
| `stat_search_restart` | Number of trace table queries restarted due to hash table size modification   | int   |

#### `host.filefd` {#host-filefd}

<!-- markdownlint-disable MD046 -->

???+ attention

    `filefd` Linux platform only

<!-- markdownlint-enable -->

| Field Name         | Description                                                 | Type  |
| ---            | ---                                                  | :---: |
| `allocated`    | Number of allocated file handles                                 | int   |
| `maximum`      | Maximum number of file handles (deprecated, replaced by `maximum_mega`) | int   |
| `maximum_mega` | Maximum number of file handles in M(10^6)                     | float |

#### `host.config_file` {#host-config-file}

config_file is a map of `file-path`: `file-content`, with the following meaning for each field:

| 字段名         | 描述                                                 | 类型  |
| -------------- | ---------------------------------------------------- | :---: |
| `file-path`    | The absolute path of the configuration file           |  string  |
| `file-content` | The contents of the configuration file                |  string  |

#### Collector Performance Field List {#inputs-stats}

The `collectors` field is a list of objects with the following fields for each object:

| Field Name          | Description                                             | Type   |
| ---             | ----                                             | :---:  |
| `name`          | Collector name                                       | string |
| `count`         | Collection times                                         | int    |
| `last_err`      | For the last error message, only the errors within the last 30 seconds (inclusive) are reported. | string |
| `last_err_time` | The last time an error was reported (Unix timestamp in seconds).        | int    |
| `last_time`     | Last collection time (Unix timestamp in seconds)       | int    |

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->

### :material-chat-question: Why no `entries` and `entries_limit`, the value shows -1？ {#no-entries}

<!-- markdownlint-enable -->

Need to load `nf_conntrack` module, run `modprobe nf_conntrack` in a terminal.
