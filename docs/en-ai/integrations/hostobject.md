---
title: 'Host Object'
summary: 'Collect basic host information'
tags:
  - 'Host'
__int_icon: 'icon/hostobject'
dashboard:
  - desc: 'Not available'
    path: '-'
monitor:
  - desc: 'Not available'
    path: '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The Host Object Collector is used to collect basic host information, such as hardware model, basic resource consumption, etc.

## Configuration {#config}

After successfully installing and starting DataKit, the Host Object Collector will be enabled by default, without manual activation.

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `hostobject.conf.sample` and rename it to `hostobject.conf`. An example is shown below:

    ```toml
        
    [inputs.hostobject]
    
    ## Datakit does not collect network virtual interfaces under the Linux system.
    ## Setting enable_net_virtual_interfaces to true will collect network virtual interfaces stats for Linux.
    # enable_net_virtual_interfaces = true
    
    ## Absolute path to the configuration file
    # config_path = ["/usr/local/datakit/conf.d/datakit.conf"]
    
    ##############################
    # Disk related options
    ##############################
    ## Deprecated
    # ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "autofs", "squashfs", "aufs"]
    
    ## We collect all devices prefixed with dev by default. If you want to collect additional devices, add them in extra_device
    # extra_device = []
    
    ## Exclude some with dev prefix (We collect all devices prefixed with dev by default)
    # exclude_device = ["/dev/loop0","/dev/loop1"]
    
    ## Physical devices only (e.g., hard disks, CD-ROM drives, USB keys)
    # and ignore all others (e.g., memory partitions such as /dev/shm)
    only_physical_device = false
    
    # Merge disks that have the same device name (default false)
    # merge_on_device = false
    
    ## Ignore the disk which space is zero
    ignore_zero_bytes_disk = true
    
    ## Disable cloud provider information synchronization
    disable_cloud_provider_sync = false
    
    ## Enable putting cloud provider region/zone_id information into global election tags (default to true).
    # enable_cloud_host_tags_as_global_election_tags = true
    
    ## Enable putting cloud provider region/zone_id information into global host tags (default to true).
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

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    It also supports modifying configuration parameters via environment variables (you need to add it as a default collector in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_HOSTOBJECT_ENABLE_NET_VIRTUAL_INTERFACES**
    
        Allow collecting virtual network interfaces
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_net_virtual_interfaces`
    
        **Default Value**: false
    
    - **ENV_INPUT_HOSTOBJECT_IGNORE_ZERO_BYTES_DISK**
    
        Ignore disks with zero size
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `ignore_zero_bytes_disk`
    
        **Default Value**: false
    
    - **ENV_INPUT_HOSTOBJECT_ONLY_PHYSICAL_DEVICE**
    
        Ignore non-physical disks (such as network disks, NFS), any non-empty string
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `only_physical_device`
    
        **Default Value**: false
    
    - **ENV_INPUT_HOSTOBJECT_EXCLUDE_DEVICE**
    
        Ignored devices
    
        **Field Type**: List
    
        **Collector Configuration Field**: `exclude_device`
    
        **Example**: /dev/loop0,/dev/loop1
    
    - **ENV_INPUT_HOSTOBJECT_EXTRA_DEVICE**
    
        Additional devices to include
    
        **Field Type**: List
    
        **Collector Configuration Field**: `extra_device`
    
        **Example**: `/nfsdata,other`
    
    - **ENV_INPUT_HOSTOBJECT_CLOUD_META_AS_ELECTION_TAGS**
    
        Include cloud provider region/zone_id information in global election tags
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_cloud_host_tags_global_election_tags`
    
        **Default Value**: true
    
    - **ENV_INPUT_HOSTOBJECT_CLOUD_META_AS_HOST_TAGS**
    
        Include cloud provider region/zone_id information in global host tags
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_cloud_host_tags_global_host_tags`
    
        **Default Value**: true
    
    - **ENV_INPUT_HOSTOBJECT_TAGS**
    
        Custom tags. If there are tags with the same name in the configuration file, they will overwrite them.
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `tags`
    
        **Example**: tag1=value1,tag2=value2
    
    - **ENV_CLOUD_PROVIDER**
    
        Specify cloud provider
    
        **Field Type**: String
    
        **Collector Configuration Field**: `none`
    
        **Example**: `aliyun/aws/tencent/hwcloud/azure`
    
    - **ENV_CLOUD_META_URL**
    
        Cloud provider metadata URL mapping
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `cloud_meta_url`
    
        **Example**: `{"tencent":"xxx", "aliyun":"yyy"}`
    
<!-- markdownlint-enable -->

### Enabling Cloud Sync {#cloudinfo}

DataKit enables cloud sync by default, currently supporting Alibaba Cloud/Tencent Cloud/AWS/Huawei Cloud/Microsoft Cloud/Volcengine. You can explicitly specify the cloud provider using the `cloud_provider` tag, or let DataKit automatically detect it:

```toml
[inputs.hostobject.tags]
  # Currently supported: aliyun/tencent/aws/hwcloud/azure. If not set, DataKit will automatically detect and set this tag.
  cloud_provider = "aliyun"
```

You can disable cloud sync by setting `disable_cloud_provider_sync = true` in the configuration file.

## Objects {#object}

All data collected by default will append a global tag named `host` (the tag value is the hostname where DataKit resides). You can also specify other tags through `[inputs.hostobject.tags]` in the configuration:

```toml
 [inputs.hostobject.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

> Note: When adding custom tags, try not to use the same names as existing tag keys/field keys. If they are the same, DataKit will choose the tag from the configuration to override the collected data, which may cause some data issues.

### `HOST`

- Tags

| Tag | Description |
| --- | ----------- |
| `arch` | Host OS architecture |
| `host` | Hostname. Required. |
| `name` | Hostname |
| `os` | Host OS type |
| `unicast_ip` | Host unicast IP |

- Metrics List

| Metric | Description | Type | Unit |
| ------ | ----------- | ---- | ---- |
| `cpu_usage` | CPU usage | float | percent |
| `datakit_ver` | Collector version | string | - |
| `disk_total` | Total disk space | int | B |
| `disk_used_percent` | Disk usage | float | percent |
| `diskio_read_bytes_per_sec` | Disk read rate | int | B/S |
| `diskio_write_bytes_per_sec` | Disk write rate | int | B/S |
| `dk_upgrader` | Upgrader's host and port | string | - |
| `is_docker` | Docker mode | int | - |
| `load` | System load | float | - |
| `logging_level` | Log level | string | - |
| `mem_used_percent` | Memory usage | float | percent |
| `message` | Summary of all host information | string | - |
| `net_recv_bytes_per_sec` | Network receive rate | int | B/S |
| `net_send_bytes_per_sec` | Network send rate | int | B/S |
| `num_cpu` | Number of CPUs | int | count |
| `start_time` | Host startup time (Unix timestamp) | int | ms |

If cloud sync is enabled, the following additional fields will be included (depending on the synchronized fields):

| Field Name | Description | Type |
| ---------- | ----------- | ---- |
| `cloud_provider` | Cloud provider | string |
| `description` | Description | string |
| `instance_id` | Instance ID | string |
| `instance_name` | Instance name | string |
| `instance_type` | Instance type | string |
| `instance_charge_type` | Instance billing type | string |
| `instance_network_type` | Instance network type | string |
| `instance_status` | Instance status | string |
| `security_group_id` | Security group ID | string |
| `private_ip` | Private IP of instance | string |
| `zone_id` | Zone ID of instance | string |
| `region` | Region ID of instance | string |

### Structure of `message` Metric Field {#message-struct}

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

  "collectors": [ # Status of various collectors
    ...
  ]
}
```

#### `host.meta` {#host-meta}

| Field Name | Description | Type |
| ---------- | ----------- | ---- |
| `host_name` | Hostname | string |
| `boot_time` | Boot time | int |
| `os` | Operating system type, e.g., `linux/windows/darwin` | string |
| `platform` | Platform name, e.g., `ubuntu` | string |
| `platform_family` | Platform family, e.g., `ubuntu` belongs to `debian` | string |
| `platform_version` | Platform version, e.g., `18.04` for Ubuntu | string |
| `kernel_release` | Kernel version, e.g., `4.15.0-139-generic` | string |
| `arch` | CPU hardware architecture, e.g., `x86_64/arm64` | string |
| `extra_cloud_meta` | JSON data of cloud attributes when cloud sync is enabled | string |

#### `host.cpu` {#host-cpu}

| Field Name | Description | Type |
| ---------- | ----------- | ---- |
| `vendor_id` | Vendor ID, e.g., `GenuineIntel` | string |
| `module_name` | CPU model, e.g., `Intel(R) Core(TM) i5-8210Y CPU @ 1.60GHz` | string |
| `cores` | Number of cores | int |
| `mhz` | Frequency | int |
| `cache_size` | L2 cache size (KB) | int |

#### `host.mem` {#host-mem}

| Field Name | Description | Type |
| ---------- | ----------- | ---- |
| `memory_total` | Total memory size | int |
| `swap_total` | Swap size | int |

#### `host.net` {#host-net}

| Field Name | Description | Type |
| ---------- | ----------- | ---- |
| `mtu` | Maximum transmission unit | int |
| `name` | Network interface name | string |
| `mac` | MAC address | string |
| `flags` | Status flags (multiple possible) | []string |
| `ip4` | IPv4 address | string |
| `ip6` | IPv6 address | string |
| `ip4_all` | All IPv4 addresses | []string |
| `ip6_all` | All IPv6 addresses | []string |

#### `host.disk` {#host-disk}

> In previous versions, only one mount point per device was collected (which one depends on the order in */proc/self/mountpoint*). Starting from [:octicons-tag-24: Version-1.66.0](../datakit/changelog.md#cl-1.66.0), all mount points that meet certain criteria (e.g., device names starting with `/dev`) will be collected to show all devices visible to DataKit, avoiding omissions.

| Field Name | Description | Type |
| ---------- | ----------- | ---- |
| `device` | Disk device name | string |
| `total` | Total disk size | int |
| `mountpoint` | Mount point | string |
| `fstype` | Filesystem type | string |

#### `host.election` {#host-election}

> Note: This field is null when the `enable_election` option in the configuration file is disabled.

| Field Name | Description | Type |
| ---------- | ----------- | ---- |
| `elected` | Election status | string |
| `namespace` | Election namespace | string |

#### `host.conntrack` {#host-conntrack}

<!-- markdownlint-disable MD046 -->

???+ attention

    `conntrack` is only supported on Linux platforms.

<!-- markdownlint-enable -->

| Field Name | Description | Type |
| ---------- | ----------- | ---- |
| `entries` | Current number of connections | int |
| `entries_limit` | Size of the connection tracking table | int |
| `stat_found` | Number of successful searches | int |
| `stat_invalid` | Number of packets that cannot be tracked | int |
| `stat_ignore` | Number of already tracked packets | int |
| `stat_insert` | Number of inserted packets | int |
| `stat_insert_failed` | Number of failed insertions | int |
| `stat_drop` | Number of dropped packets due to tracking failure | int |
| `stat_early_drop` | Number of partially tracked packets discarded due to full tracking table | int |
| `stat_search_restart` | Number of tracking table queries restarted due to hash table size changes | int |

#### `host.filefd` {#host-filefd}

<!-- markdownlint-disable MD046 -->

???+ attention

    `filefd` is only supported on Linux platforms.

<!-- markdownlint-enable -->

| Field Name | Description | Type |
| ---------- | ----------- | ---- |
| `allocated` | Number of allocated file handles | int |
| `maximum` | Maximum number of file handles (deprecated, use `maximum_mega` instead) | int |
| `maximum_mega` | Maximum number of file handles, in units of M(10^6) | float |

#### `host.config_file` {#host-config-file}

`config_file` is a map of `file-path`: `file-content`, with each field defined as follows:

| Field Name | Description | Type |
| ---------- | ----------- | ---- |
| `file-path` | Absolute path of the configuration file | string |
| `file-content` | Content of the configuration file | string |

#### Collector Runtime Status Fields List {#inputs-stats}

The `collectors` field is a list of objects, each object having the following fields:

| Field Name | Description | Type |
| ---------- | ----------- | ---- |
| `name` | Collector name | string |
| `count` | Collection count | int |
| `last_err` | Last error message, reports only errors within the last 30 seconds | string |
| `last_err_time` | Timestamp of the last error (Unix timestamp, in seconds) | int |
| `last_time` | Timestamp of the last collection (Unix timestamp, in seconds) | int |

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->

### :material-chat-question: Why are `entries` and `entries_limit` not collected and display as -1? {#no-entries}

<!-- markdownlint-enable -->

You need to load the `nf_conntrack` module; run `modprobe nf_conntrack` in the terminal.