---
title: 'NetFlow'
summary: 'The NetFlow collector can be used to visualize and monitor devices that have enabled NetFlow'
tags:
  - 'Network'
__int_icon: 'icon/netflow'
dashboard:
  - desc: 'NetFlow'
    path: 'dashboard/en/netflow'
monitor:
  - desc: 'NetFlow'
    path: 'monitor/en/netflow'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The NetFlow collector can be used to visualize and monitor devices that have enabled NetFlow, and collect logs into Guance to help monitor and analyze various anomalies in NetFlow.

## What is NetFlow {#what}

NetFlow is the most widely used traffic data statistics standard, developed by Cisco for monitoring and recording all traffic entering and exiting interfaces. NetFlow analyzes the traffic data it collects to provide visibility into traffic patterns and sources, tracking where traffic comes from, where it goes, and how much traffic is generated at any given time. The recorded information can be used for usage monitoring, anomaly detection, and other network management tasks.

Currently, Datakit supports the following protocols:

- netflow5
- netflow9
- sflow5
- ipfix

## Configuration {#config}

### Prerequisites {#requirements}

- Devices that support the NetFlow feature and have it enabled. Each device's method of enabling this feature may vary, so it is recommended to refer to the official documentation. For example: [Enabling NetFlow on Cisco ASA](https://www.petenetlive.com/KB/Article/0000055){:target="_blank"}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/netflow` directory under the DataKit installation directory, copy `netflow.conf.sample` and rename it to `netflow.conf`. An example configuration is as follows:
    
    ```toml
        
    [[inputs.netflow]]
        source    = "netflow"
        namespace = "namespace"
    
        #[[inputs.netflow.listeners]]
        #    flow_type = "netflow9"
        #    port      = 2055
    
        [[inputs.netflow.listeners]]
            flow_type = "netflow5"
            port      = 2056
    
        #[[inputs.netflow.listeners]]
        #    flow_type = "ipfix"
        #    port      = 4739
    
        #[[inputs.netflow.listeners]]
        #    flow_type = "sflow5"
        #    port      = 6343
    
        [inputs.netflow.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable collectors via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Logs {#logging}

Below is an example log entry:

```json
{
    "flush_timestamp":1692077978547,
    "type":"netflow5",
    "sampling_rate":0,
    "direction":"ingress",
    "start":1692077976,
    "end":1692077976,
    "bytes":668,
    "packets":1588,
    "ether_type":"IPv4",
    "ip_protocol":"TCP",
    "device":{
        "namespace":"namespace"
    },
    "exporter":{
        "ip":"10.200.14.142"
    },
    "source":{
        "ip":"130.240.103.204",
        "port":"4627",
        "mac":"00:00:00:00:00:00",
        "mask":"130.240.96.0/20"
    },
    "destination":{
        "ip":"152.222.36.168",
        "port":"424",
        "mac":"00:00:00:00:00:00",
        "mask":"152.0.0.0/8"
    },
    "ingress":{
        "interface":{
            "index":0
        }
    },
    "egress":{
        "interface":{
            "index":0
        }
    },
    "host":"MacBook-Air-2.local",
    "next_hop":{
        "ip":"20.104.52.139"
    }
}
```

Explanation:

- Root/NetFlow node

| Field            | Description                  |
| ----:            | :----                        |
| flush_timestamp  | Reporting timestamp          |
| type             | Protocol                     |
| sampling_rate    | Sampling rate                |
| direction        | Direction                    |
| start            | Start time                   |
| end              | End time                     |
| bytes            | Transmitted bytes            |
| packets          | Transmitted packet count     |
| ether_type       | Ethernet type (IPv4/IPv6)    |
| ip_protocol      | IP protocol (TCP/UDP)        |
| device           | Device information node      |
| exporter         | Exporter information node    |
| source           | Flow source endpoint info    |
| destination      | Flow destination endpoint info|
| ingress          | Ingress gateway info         |
| egress           | Egress gateway info          |
| host             | Collector's Hostname         |
| tcp_flags        | TCP flags                    |
| next_hop         | Next_Hop attribute info      |

- `device` node

| Field      | Description  |
| ----:      | :----        |
| namespace  | Namespace    |

- `exporter` node

| Field  | Description         |
| ----:  | :----              |
| ip     | Exporter's IP      |

- `source` node

| Field  | Description         |
| ----:  | :----              |
| ip     | Source IP address  |
| port   | Source port        |
| mac    | Source MAC address |
| mask   | Source subnet mask |

- `destination` node

| Field  | Description         |
| ----:  | :----              |
| ip     | Destination IP     |
| port   | Destination port   |
| mac    | Destination MAC    |
| mask   | Destination subnet |

- `ingress` node

| Field      | Description  |
| ----:      | :----        |
| interface  | Interface ID |

- `egress` node

| Field      | Description  |
| ----:      | :----        |
| interface  | Interface ID |

- `next_hop` node

| Field  | Description                         |
| ----:  | :----                               |
| ip     | Next hop IP address                 |

## Mearsurement {#metric}

All collected data will default to appending a global tag named `host` (tag value is the hostname of the DataKit host), or you can specify other tags through `[inputs.netflow.tags]` in the configuration:

```toml
 [inputs.netflow.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

<!-- markdownlint-disable MD046 -->
???+ info

    Data collected by the Netflow collector is stored in the log category (`L`) data.
<!-- markdownlint-enable -->


### `netflow` {#netflow}

Using the `source` field in the config file, default is `default`.

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Hostname.|
|`ip`|Collector IP address.|

- Metrics list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bytes`|Flow bytes.|int|B|
|`dest_ip`|Flow destination IP.|string|-|
|`dest_port`|Flow destination port.|string|-|
|`device_ip`|NetFlow exporter IP.|string|-|
|`ip_protocol`|Flow network protocol.|string|-|
|`message`|The text of the logging.|string|-|
|`source_ip`|Flow source IP.|string|-|
|`source_port`|Flow source port.|string|-|
|`status`|The status of the logging, only supported `info/emerg/alert/critical/error/warning/debug/OK/unknown`.|string|-|
|`type`|Flow type.|string|-|