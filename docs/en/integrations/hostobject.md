---
title     : 'HOST Objects'
summary   : 'Collect basic HOST information'
tags:
  - 'HOST'
__int_icon      : 'icon/hostobject'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The HOST object collector is used to collect basic HOST information, such as hardware models and basic resource consumption.

## Configuration {#config}

After successfully installing Datakit and starting it, the HOST object collector will be enabled by default, without manual activation.

<!-- markdownlint-disable MD046 -->

=== "HOST Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `hostobject.conf.sample` and rename it to `hostobject.conf`. Example as follows:

    ```toml
        
    [inputs.hostobject]
    
    ## Datakit does not collect network virtual interfaces under the linux system.
    ## Setting enable_net_virtual_interfaces to true will collect network virtual interfaces stats for linux.
    # enable_net_virtual_interfaces = true
    
    ## Absolute path to the configuration file
    # config_path = ["/usr/local/datakit/conf.d/datakit.conf"]
    
    # Do not collect disks that with these file systems
    ignore_fstypes = '''^(tmpfs|autofs|binfmt_misc|devpts|fuse.lxcfs|overlay|proc|squashfs|sysfs)$'''
    
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
    
    ## Enable AWS IPv6
    enable_cloud_aws_ipv6 = false
    
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

    After configuring, simply [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    It also supports modifying configuration parameters via environment variables (needs to be added as a default collector in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_HOSTOBJECT_ENABLE_NET_VIRTUAL_INTERFACES**
    
        Allow collection of virtual network interfaces
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_net_virtual_interfaces`
    
        **Default Value**: false
    
    - **ENV_INPUT_HOSTOBJECT_IGNORE_ZERO_BYTES_DISK**
    
        Ignore disks with size 0
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `ignore_zero_bytes_disk`
    
        **Default Value**: false
    
    - **ENV_INPUT_HOSTOBJECT_IGNORE_FSTYPES**
    
        Ignore non-physical disks (like cloud disks, NFS), any non-empty string
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `only_physical_device`
    
        **Default Value**: false
        Ignore disks with these file systems
    
        **Type**: String
    
        **input.conf**: `ignore_fstypes`
    
        **Default**: `^(tmpfs|autofs|binfmt_misc|devpts|fuse.lxcfs|overlay|proc|squashfs|sysfs)$`
    
    - **ENV_INPUT_HOSTOBJECT_IGNORE_MOUNTPOINTS**
    
        Ignore disks with these mount points
    
        **Type**: String
    
        **input.conf**: `ignore_mountpoints`
    
        **Default**: `^(/usr/local/datakit/.*|/run/containerd/.*)$
    
    - **ENV_INPUT_HOSTOBJECT_EXCLUDE_DEVICE**
    
        Ignored devices
    
        **Field Type**: List
    
        **Collector Configuration Field**: `exclude_device`
    
        **Example**: `/dev/loop0,/dev/loop1`
    
    - **ENV_INPUT_HOSTOBJECT_EXTRA_DEVICE**
    
        Additional devices to include
    
        **Field Type**: List
    
        **Collector Configuration Field**: `extra_device`
    
        **Example**: `/nfsdata,other`
    
    - **ENV_INPUT_HOSTOBJECT_CLOUD_META_AS_ELECTION_TAGS**
    
        Place cloud provider region/zone_id information into global election tags
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_cloud_host_tags_global_election_tags`
    
        **Default Value**: true
    
    - **ENV_INPUT_HOSTOBJECT_CLOUD_META_AS_HOST_TAGS**
    
        Place cloud provider region/zone_id information into global host tags
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_cloud_host_tags_global_host_tags`
    
        **Default Value**: true
    
    - **ENV_INPUT_HOSTOBJECT_CLOUD_AWS_IMDS_V2**
    
        Enable AWS IMDSv2
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_cloud_aws_imds_v2`
    
        **Default Value**: false
    
    - **ENV_INPUT_HOSTOBJECT_CLOUD_AWS_IPV6**
    
        Enable AWS IPv6
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_cloud_aws_ipv6`
    
        **Default Value**: false
    
    - **ENV_INPUT_HOSTOBJECT_TAGS**
    
        Custom tags. If there are tags with the same name in the configuration file, they will override them.
    
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
    
    - **ENV_INPUT_HOSTOBJECT_CLOUD_META_TOKEN_URL**
    
        Cloud provider metadata token URL mapping
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `cloud_meta_token_url`
    
        **Example**: `{"aws":"xxx","aliyun":"yyy"}`

<!-- markdownlint-enable -->

### Enable Cloud Sync {#cloudinfo}

Datakit enables cloud sync by default, currently supporting Alibaba Cloud/Tencent Cloud/AWS/Huawei Cloud/Microsoft Cloud/Volcengine. You can explicitly specify the cloud vendor through the cloud_provider tag, or let Datakit automatically detect it:

```toml
[inputs.hostobject.tags]
  # Currently supported: aliyun/tencent/aws/hwcloud/azure. If not set, Datakit will automatically detect and set this tag.
  cloud_provider = "aliyun"
```

You can disable the cloud sync feature by setting `disable_cloud_provider_sync = true` in the configuration file.

## Object {#object}

All the following data collections will append a global tag named `host` by default (the tag value is the hostname where DataKit resides). You can also specify other tags via `[inputs.hostobject.tags]` in the configuration:

```toml
 [inputs.hostobject.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

> Note: When adding custom tags here, try to avoid naming conflicts with existing tag keys/field keys. If there is a conflict, DataKit will choose the tag from the configuration to override the collected data, which may cause some data issues.



### `HOST`

- Tags


| Tag | Description |
|  ----  | --------|
|`arch`|Host OS Arch|
|`host`|Hostname. Required.|
|`name`|Hostname|
|`os`|Host OS type|
|`unicast_ip`|Host unicast ip|

- Metrics List


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



If cloud sync is enabled, the following additional fields will appear (depending on the synchronized fields):

| Field Name                  | Description           |  Type  |
| ----------------------- | -------------- | :----: |
| `cloud_provider`        | Cloud provider       | string |
| `description`           | Description           | string |
| `instance_id`           | Instance ID        | string |
| `instance_name`         | Instance name         | string |
| `instance_type`         | Instance type       | string |
| `instance_charge_type`  | Instance billing type   | string |
| `instance_network_type` | Instance network type   | string |
| `instance_status`       | Instance status       | string |
| `security_group_id`     | Instance group       | string |
| `private_ip`            | Instance private IP    | string |
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

  "collectors": [ # Status of each collector
    ...
  ]
}
```

#### `host.meta` {#host-meta}

| Field Name             | Description                                           |  Type  |
| ------------------ | ---------------------------------------------- | :----: |
| `host_name`        | Hostname                                         | string |
| `boot_time`        | Boot time                                       |  int   |
| `os`               | Operating system type, e.g., `linux/windows/darwin`        | string |
| `platform`         | Platform name, e.g., `ubuntu`                          | string |
| `platform_family`  | Platform family, e.g., `ubuntu` belongs to `debian` family       | string |
| `platform_version` | Platform version, e.g., `18.04`, i.e., an Ubuntu distribution version | string |
| `kernel_release`   | Kernel version, e.g., `4.15.0-139-generic`              | string |
| `arch`             | CPU hardware architecture, e.g., `x86_64/arm64` etc             | string |
| `extra_cloud_meta` | If cloud sync is enabled, it will include a JSON string of cloud properties     | string |

#### `host.cpu` {#host-cpu}

| Field Name        | Description                                                    |  Type  |
| ------------- | ------------------------------------------------------- | :----: |
| `vendor_id`   | Vendor ID, e.g., `GenuineIntel`                            | string |
| `module_name` | CPU model, e.g., `Intel(R) Core(TM) i5-8210Y CPU @ 1.60GHz` | string |
| `cores`       | Number of cores                                                    |  int   |
| `mhz`         | Frequency                                                    |  int   |
| `cache_size`  | L2 cache size (KB)                                       |  int   |

#### `host.mem` {#host-mem}

| Field Name         | Description       | Type |
| -------------- | ---------- | :--: |
| `memory_total` | Total memory size | int  |
| `swap_total`:  | Swap size  | int  |

#### `host.net` {#host-net}

| Field Name    | Description               |   Type   |
| --------- | ------------------ | :------: |
| `mtu`     | Maximum transmission unit       |   int    |
| `name`    | Network card name           |  string  |
| `mac`     | MAC address           |  string  |
| `flags`   | Status bits (possibly multiple) | []string |
| `ip4`     | IPv4 address          |  string  |
| `ip6`     | IPv6 address          |  string  |
| `ip4_all` | All IPv4 addresses     | []string |
| `ip6_all` | All IPv6 addresses     | []string |

#### `host.disk` {#host-disk}

> In previous versions, only one mount point would be collected per device (specifically which one depends on the order in which the mount points appear in */proc/self/mountpoint*). Starting from [:octicons-tag-24: Version-1.66.0](../datakit/changelog.md#cl-1.66.0), the disk portion of the HOST object will collect all eligible mount points (e.g., those with device names beginning with `/dev`) to display all devices visible to Datakit, avoiding omissions.

| Field Name       | Description         |  Type  |
| ------------ | ------------ | :----: |
| `device`     | Disk device name   | string |
| `total`      | Disk total size   |  int   |
| `mountpoint` | Mount point       | string |
| `fstype`     | File system type | string |

#### `host.election` {#host-election}

> Note: When the `enable_election` option is turned off in the configuration file, this field will be null.

| Field Name      | Description     |  Type  |
| ----------- | -------- | :----: |
| `elected`   | Election status | string |
| `namespace` | Election namespace | string |

#### `host.conntrack` {#host-conntrack}

<!-- markdownlint-disable MD046 -->

???+ attention

    `conntrack` is only supported on Linux platforms.

<!-- markdownlint-enable -->

| Field Name                | Description                                           | Type |
| --------------------- | ---------------------------------------------- | :--: |
| `entries`             | Current number of connections                                   | int  |
| `entries_limit`       | Size of the connection tracking table                               | int  |
| `stat_found`          | Successful search entries count                             | int  |
| `stat_invalid`        | Number of packets that cannot be tracked                             | int  |
| `stat_ignore`         | Number of already tracked packets                             | int  |
| `stat_insert`         | Number of inserted packets                                   | int  |
| `stat_insert_failed`  | Number of failed insert packets                               | int  |
| `stat_drop`           | Number of packets dropped due to tracking failure                         | int  |
| `stat_early_drop`     | Number of tracked packet entries dropped due to full tracking table | int  |
| `stat_search_restart` | Number of tracking table queries restarted due to hash table size modification | int  |

#### `host.filefd` {#host-filefd}

<!-- markdownlint-disable MD046 -->

???+ attention

    `filefd` is only supported on Linux platforms.

<!-- markdownlint-enable -->

| Field Name         | Description                                                 | Type  |
| -------------- | ---------------------------------------------------- | :---: |
| `allocated`    | Number of allocated file handles                                 |  int  |
| `maximum`      | Maximum number of file handles (deprecated, use `maximum_mega` instead) |  int  |
| `maximum_mega` | Maximum number of file handles, in units of M(10^6)                     | float |

#### `host.config_file` {#host-config-file}

`config_file` is a `file-path`: `file-content` map. The meaning of each field is as follows:

| Field Name         | Description                                                 | Type  |
| -------------- | ---------------------------------------------------- | :---: |
| `file-path`    | Absolute path of the configuration file                                   |  string  |
| `file-content` | Content of the configuration file                                    |  string  |

#### Collector Running Status Fields List {#inputs-stats}

The `collectors` field is a list of objects, with the following fields for each object:

| Field Name          | Description                                               |  Type  |
| --------------- | -------------------------------------------------- | :----: |
| `name`          | Collector name                                         | string |
| `count`         | Collection times                                           |  int   |
| `last_err`      | Last error message, reports errors within the last 30 seconds (inclusive) | string |
| `last_err_time` | Last error time (Unix timestamp, in seconds)          |  int   |
| `last_time`     | Last collection time (Unix timestamp, in seconds)          |  int   |

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->

### :material-chat-question: Why are `entries` and `entries_limit` not being collected and showing as -1? {#no-entries}

<!-- markdownlint-enable -->

Load the `nf_conntrack` module by running `modprobe nf_conntrack` in the terminal.
