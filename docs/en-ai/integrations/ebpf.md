---
title: 'eBPF'
summary: 'Collecting Linux network data via eBPF'
tags:
  - 'EBPF'
  - 'NETWORK'
__int_icon: 'icon/ebpf'
dashboard:
  - desc: 'Not available'
    path: '-'
monitor:
  - desc: 'Not available'
    path: '-'
---

:fontawesome-brands-linux: :material-kubernetes:

---

The eBPF collector gathers host network TCP, UDP connection information, Bash execution logs, etc. The collector includes the following plugins:

- `ebpf-net`:
    - Data category: `Network`
    - Composed of `netflow/httpflow/dnsflow`, used for collecting host TCP/UDP connection statistics, HTTP request information, and DNS resolution information;

- `ebpf-bash`:
    - Data category: `Logging`
    - Collects Bash execution logs, including process ID, username, executed commands, and timestamps;

- `ebpf-conntrack`: [:octicons-tag-24: Version-1.8.0](../datakit/changelog.md#cl-1.8.0)
    - Adds two labels `dst_nat_ip` and `dst_nat_port` to network flow data, recording the destination IP and port after DNAT; this plugin can be enabled when the kernel loads `nf_conntrack`;

- `ebpf-trace`: [:octicons-tag-24: Version-1.17.0](../datakit/changelog.md#cl-1.17.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)
    - Data category: `Tracing`
    - Used to trace application network request call relationships, based on `ebpf-net`'s `httpflow` data and eBPF probes;

- `bpf-netlog`:
    - Data category: `Logging`, `Network`
    - This plugin collects network logs `bpf_net_l4_log/bpf_net_l7_log` and can replace `ebpf-net`'s `netflow/httpflow` data collection when the kernel does not support eBPF;

## Configuration {#config}

### Prerequisites {#requirements}

When deploying in a Kubernetes environment, the following directories need to be mounted into the container:

- `/sys/kernel/debug`
- Mount the host's `/` directory as the container's `/rootfs` directory and set environment variables `HOST_ROOT="/rootfs"` and `HOST_PROC="/rootfs/proc"`

Refer to *datakit.yaml*;

If using a Datakit version below v1.5.6, manually install the external collector `datakit-ebpf`.

### Linux Kernel Version Requirements {#kernel}

Currently, the project lifecycle for Linux 3.10 has ended. It is recommended to upgrade to Linux 4.9 or higher LTS kernels.

Except for CentOS 7.6+ and Ubuntu 16.04, other distributions are recommended to use Linux kernel versions higher than 4.9, otherwise, the eBPF collector may not start.

If the Linux kernel version is lower than 4.4, the `ebpf-trace` plugin may not be enabled.

To enable *ebpf-conntrack*, confirm that the kernel symbols include `nf_ct_delete` and `__nf_conntrack_hash_insert`. You can check by running the following command:

```sh
cat /proc/kallsyms | awk '{print $3}' | grep "^nf_ct_delete$\|^__nf_conntrack_hash_insert$"
```

Or check if the `nf_conntrack` module is loaded:

```sh
lsmod | grep nf_conntrack
```

### Systems with SELinux Enabled {#selinux}

For systems with SELinux enabled, the eBPF collector cannot be started. You need to disable it by running the following command:

```shell
setenforce 0
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `ebpf.conf.sample` and rename it to `ebpf.conf`. An example is as follows:
    
    ```toml
        
    [[inputs.ebpf]]
      daemon = true
      name = 'ebpf'
      cmd = "/usr/local/datakit/externals/datakit-ebpf"
      args = [
        "--datakit-apiserver", "0.0.0.0:9529",
      ]
      envs = []
    
      ## Resource limits.
      ## The collector automatically exits when the limit is exceeded.
      ## Can configure the number of CPU cores, memory size, and network bandwidth.
      ##
      # cpu_limit = "2.0"
      # mem_limit = "4GiB"
      # net_limit = "100MiB/s"
    
      ## Automatically takes effect when running DataKit in 
      ## Kubernetes daemonset mode
      ##
      # kubernetes_url = "https://kubernetes.default:443"
      # bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
      ##
      ## or 
      # bearer_token_string = "<your-token-string>"
      
      ## All supported plugins:
      ## - "ebpf-net"  :
      ##     contains L4-network(netflow), L7-network(httpflow, dnsflow) collection
      ## - "ebpf-bash" :
      ##     log bash
      ## - "ebpf-conntrack":
      ##     add two tags "dst_nat_ip" and "dst_nat_port" to the network flow data
      ## - "ebpf-trace":
      ##     param trace_server must be set simultaneously.
      ## - "bpf-netlog":
      ##     contains L4-network log (bpf_net_l4_log), L7-network log (bpf_net_l7_log), 
      ##              L4-network(netflow), L7-network(httpflow, dnsflow) collection
      enabled_plugins = [
        "ebpf-net",
      ]
    
      ## If you enable the ebpf-net plugin, you can configure:
      ##  - "httpflow" (* enabled by default)
      ##  - "httpflow-tls"
      ##
      l7net_enabled = [
        "httpflow",
        # "httpflow-tls"
      ]
    
    
      ## datakit-ebpf pprof service
      pprof_host = "127.0.0.1"
      pprof_port = "6061"
    
      ## netlog blacklist
      ##
      # netlog_blacklist = "ip_saddr=='127.0.0.1' || ip_daddr=='127.0.0.1'"
    
      ## bpf-netlog plugin collection metric and log
      ##
      netlog_metric = true
      netlog_log = false
      
      ## eBPF trace generation server center address.
      trace_server = ""
    
      ## Trace all processes directly
      ##
      trace_all_process = false
      
      ## Trace all processes containing any specified environment variable
      trace_env_list = [
        "DK_BPFTRACE_SERVICE",
        "DD_SERVICE",
        "OTEL_SERVICE_NAME",
      ]
      
      ## Deny tracking any process containing any specified environment variable
      trace_env_blacklist = []
      
      ## Trace all processes containing any specified process names,
      ## can be used with trace_namedenyset
      ##
      trace_name_list = []
      
      ## Deny tracking any process containing any specified process names
      ##
      trace_name_blacklist = [
        
        ## The following two processes are hard-coded to never be traced,
        ## and do not need to be set:
        ##
        # "datakit",
        # "datakit-ebpf",
      ]
    
      ## Convert other trace id to datadog trace id (base 10, 64-bit) 
      conv_to_ddtrace = false
    
      ## If the system does not enable IPv6, it needs to be changed to true
      ##
      ipv6_disabled = false
    
      ## Ephemeral port starts from <ephemeral_port>
      ##
      # ephemeral_port = 10001
    
      # interval = "60s"
    
      # sampling_rate = "0.50"
      # sampling_rate_pts_per_min = "1500"
    
      [inputs.ebpf.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    #############################
    ## Parameter description (if marked * is required)
    #############################
    ##  --hostname               : Host name, this parameter can change the value of the host tag when the collector uploads data, the priority is: specify this parameter >
    ##                             ENV_HOSTNAME value in datakit.conf (if it is not empty, this parameter will be added automatically at startup) >
    ##                             collector Get it yourself (the default).
    ##  --datakit-apiserver      : DataKit API Server address, default value 0.0.0.0:9529 .
    ##  --log                    : Log output path, default <DataKitInstallDir>/externals/datakit-ebpf.log.
    ##  --log-level              : Log level, the default value is 'info'.
    ##  --service                : The default value is 'ebpf'.
    
    ```
    
    After configuration, restart DataKit.

=== "Kubernetes"

    In Kubernetes, you can enable the eBPF collector via ConfigMap or by default enabling it in *datakit.yaml*:

    1. Refer to the general [installation example](../datakit/datakit-daemonset-deploy.md#configmap-setting) for the ConfigMap method.
    2. Append `ebpf` to the environment variable `ENV_ENABLE_INPUTS` in *datakit.yaml*, using the default configuration which only enables `ebpf-net` network data collection
    
    ```yaml
    - name: ENV_ENABLE_INPUTS
           value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ebpf
    ```

### Environment Variables and Configuration Items {#input-cfg-field-env}

Adjust the eBPF collector configuration in Kubernetes using the following environment variables:

Configuration items:

- `enabled_plugins`:
    - Description: Configure the built-in plugins to enable
    - Environment variable: `ENV_INPUT_EBPF_ENABLED_PLUGINS`
    - Example: `ebpf-net,ebpf-trace`

- `l7net_enabled`
    - Description: Enable HTTP protocol data collection
    - Environment variable: `ENV_INPUT_EBPF_L7NET_ENABLED`
    - Example: `httpflow`

- `interval`
    - Description: Set the sampling interval
    - Environment variable: `ENV_INPUT_EBPF_INTERVAL`
    - Example: `1m30s`

- `ipv6_disabled`
    - Description: Whether the system supports IPv6
    - Environment variable: `ENV_INPUT_EBPF_IPV6_DISABLED`
    - Example: `false`

- `ephemeral_port`
    - Description: Starting position of ephemeral ports
    - Environment variable: `ENV_INPUT_EBPF_EPHEMERAL_PORT`
    - Example: `32768`

- `pprof_host`
    - Description: pprof host
    - Environment variable: `ENV_INPUT_EBPF_PPROF_HOST`
    - Example: `127.0.0.1`

- `pprof_port`
    - Description: pprof port
    - Environment variable: `ENV_INPUT_EBPF_PPROF_PORT`
    - Example: `6061`

- `trace_server`
    - Description: Address of DataKit ELinker/DataKit where `ebpftrace` collector is enabled
    - Environment variable: `ENV_INPUT_EBPF_TRACE_SERVER`
    - Example: `<ip>:<port>`

- `trace_all_process`
    - Description: Track all processes within the system
    - Environment variable: `ENV_INPUT_EBPF_TRACE_ALL_PROCESS`
    - Example: `false`

- `trace_name_blacklist`
    - Description: Processes with specified names will be prohibited from collecting trace data
    - Environment variable: `ENV_INPUT_EBPF_TRACE_NAME_BLACKLIST`
    - Example:

- `trace_env_blacklist`
    - Description: Processes containing any specified environment variable names will be prohibited from collecting trace data
    - Environment variable: `ENV_INPUT_EBPF_TRACE_ENV_BLACKLIST`
    - Example: `DKE_DISABLE_ETRACE`

- `trace_env_list`
    - Description: Traces and reports link data for processes containing any specified environment variables
    - Environment variable: `ENV_INPUT_EBPF_TRACE_ENV_LIST`
    - Example: `DK_BPFTRACE_SERVICE,DD_SERVICE,OTEL_SERVICE_NAME`

- `trace_name_list`
    - Description: Traces and reports link data for processes with names in the specified set
    - Environment variable: `ENV_INPUT_EBPF_TRACE_NAME_LIST`
    - Example: `chrome,firefox`

- `conv_to_ddtrace`
    - Description: Converts all application-side trace IDs to base 10 strings, compatible but not necessary unless needed
    - Environment variable: `ENV_INPUT_EBPF_CONV_TO_DDTRACE`
    - Example: `false`

- `netlog_blacklist`
    - Description: Filters captured packets after packet capture
    - Environment variable: `ENV_INPUT_EBPF_NETLOG_BLACKLIST`
    - Example: `ip_saddr=='127.0.0.1' || ip_daddr=='127.0.0.1'`

- `netlog_metric`
    - Description: Collects network metrics from network packets
    - Environment variable: `ENV_INPUT_EBPF_NETLOG_METRIC`
    - Example: `true`

- `netlog_log`
    - Description: Collects network logs from network packets
    - Environment variable: `ENV_INPUT_EBPF_NETLOG_LOG`
    - Example: `false`

- `cpu_limit`
    - Description: Maximum CPU core usage per unit time, the collector exits when the limit is reached
    - Environment variable: `ENV_INPUT_EBPF_CPU_LIMIT`
    - Example: `"2.0"`

- `mem_limit`
    - Description: Memory size usage limit
    - Environment variable: `ENV_INPUT_EBPF_MEM_LIMIT`
    - Example: `"4GiB"`

- `net_limit`
    - Description: Network bandwidth limit (any NIC)
    - Environment variable: `ENV_INPUT_EBPF_NET_LIMIT`
    - Example: `"100MiB/s"`

- `sampling_rate`
    - Description: Sets the sampling rate for reporting data, range `0.01 ~ 1.00`; mutually exclusive with `sampling_rate_pts_per_min`
    - Environment variable: `ENV_INPUT_EBPF_SAMPLING_RATE`
    - Example: `0.50`

- `sampling_rate_pts_per_min`
    - Description: Sets the threshold for the amount of data reported per minute, dynamically adjusts the sampling rate
    - Environment variable: `ENV_INPUT_EBPF_SAMPLING_RATE_PTSPERMIN`
    - Example: `1500`

<!-- markdownlint-enable -->

## eBPF Tracing Functionality {#ebpf-tracing}

`ebpf-trace` collects and analyzes network data read/written by processes on the host and tracks kernel/user-level threads (such as golang goroutines), generating eBPF Span data which requires further processing by `ebpftrace`.

When using this feature, ensure that all nodes have the eBPF collector enabled for tracing, then send all eBPF Span data to a single DataKit ELinker/DataKit instance with the [`ebpftrace`](./ebpftrace.md#ebpftrace-config) collector plugin enabled. More configuration details can be found in the [eBPF Tracing documentation](./ebpftrace.md#ebpf-config).

## Blacklist Functionality of the `bpf-netlog` Plugin

Filter rule examples:

Single rule:

The following rule filters network data for IP `1.1.1.1` and port 80. (Operators allow line breaks)

```py
(ip_saddr == "1.1.1.1" || ip_saddr == "1.1.1.1") &&
     (src_port == 80 || dst_port == 80)
```

Multiple rules:

Rules are separated by `;` or `\n`, satisfying any one rule will filter the data

```py
udp
ip_saddr == "1.1.1.1" && (src_port == 80 || dst_port == 80);
ip_saddr == "10.10.0.1" && (src_port == 80 || dst_port == 80)

ipnet_contains("127.0.0.0/8", ip_saddr); ipv6
```

Usable filtering data:

This filter is used to filter network data, comparable data includes:

| Key Name        | Type | Description                                     |
| ------------- | ---- | ---------------------------------------- |
| `tcp`         | bool | Whether it is `TCP` protocol                        |
| `udp`         | bool | Whether it is `UDP` protocol                        |
| `ipv4`        | bool | Whether it is `IPv4` protocol                       |
| `ipv6`        | bool | Whether it is `IPv6` protocol                       |
| `src_port`    | int  | Source port (relative to observed NIC/host/container) |
| `dst_port`    | int  | Destination port                                 |
| `ip_saddr`    | str  | Source `IPv4` network address                       |
| `ip_daddr`    | str  | Destination `IPv4` network address                     |
| `ip6_saddr`   | str  | Source `IPv6` network address                       |
| `ip6_daddr`   | str  | Destination `IPv6` network address                     |
| `k8s_src_pod` | str  | Source `pod` name                              |
| `k8s_dst_pod` | str  | Destination `pod` name                            |

Operators:

Operators from highest to lowest precedence:

| Precedence | Op     | Name               | Associativity |
| ------ | ------ | ------------------ | -------- |
| 1      | `()`   | Parentheses             | Left       |
| 2      | `!`   | Logical NOT, unary operator | Right       |
| 3      | `!=`   | Not equal             | Left       |
| 3      | `>=`   | Greater than or equal           | Left       |
| 3      | `>`    | Greater than               | Left       |
| 3      | `==`   | Equal               | Left       |
| 3      | `<=`   | Less than or equal           | Left       |
| 3      | `<`    | Less than               | Left       |
| 4      | `&&`   | Logical AND             | Left       |
| 4      | `||` | Logical OR             | Left       |

Functions:

1. **ipnet_contains**

    Function signature: `fn ipnet_contains(ipnet: str, ipaddr: str) bool`

    Description: Determines if an address is within a specified subnet

    Example:

    ```py
    ipnet_contains("127.0.0.0/8", ip_saddr)
    ```

    If `ip_saddr` is "127.0.0.1", this rule returns `true`, and the TCP/UDP packet will be filtered.

2. **has_prefix**

    Function signature: `fn has_prefix(s: str, prefix: str) bool`

    Description: Checks if a specified field contains a certain prefix

    Example:

    ```py
    has_prefix(k8s_src_pod, "datakit-") || has_prefix(k8s_dst_pod, "datakit-")
    ```

    If the pod name is `datakit-kfez321`, this rule returns `true`.

## Aggregated Network Data {#network}

All collected data defaults to appending a global tag named `host` (tag value being the hostname where DataKit resides), and additional tags can be specified in the configuration using `[inputs.ebpf.tags]`:

``` toml
 [inputs.ebpf.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `netflow`

- Tag List


| Tag | Description |
|  ----  | --------|
|`direction`|Identifies the connection initiator using the source (src_ip:src_port). (incoming/outgoing)|
|`dst_domain`|Destination domain|
|`dst_ip`|Destination IP address|
|`dst_ip_type`|Destination IP type. (other/private/multicast)|
|`dst_k8s_deployment_name`|Destination K8s deployment name|
|`dst_k8s_namespace`|Destination K8s namespace|
|`dst_k8s_pod_name`|Destination K8s pod name|
|`dst_k8s_service_name`|Destination K8s service name|
|`dst_nat_ip`|For data containing the `outging` tag, this value is the IP after the DNAT operation|
|`dst_nat_port`|For data containing the `outging` tag, this value is the port after the DNAT operation|
|`dst_port`|Destination port|
|`family`|Network layer protocol. (IPv4/IPv6)|
|`host`|System hostname|
|`pid`|Process identification number|
|`process_name`|Process name|
|`source`|Fixed value: `netflow`.|
|`src_ip`|Source IP|
|`src_ip_type`|Source IP type. (other/private/multicast)|
|`src_k8s_deployment_name`|Source K8s deployment name|
|`src_k8s_namespace`|Source K8s namespace|
|`src_k8s_pod_name`|Source K8s pod name|
|`src_k8s_service_name`|Source K8s service name|
|`src_port`|Source port|
|`sub_source`|Specific connection classifications, such as the sub_source value for Kubernetes network traffic is K8s|
|`transport`|Transport layer protocol. (udp/tcp)|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bytes_read`|The number of bytes read|int|B|
|`bytes_written`|The number of bytes written|int|B|
|`retransmits`|The number of retransmissions|int|count|
|`rtt`|TCP Latency|int|μs|
|`rtt_var`|TCP Jitter|int|μs|
|`tcp_closed`|The number of TCP connections closed|int|count|
|`tcp_established`|The number of TCP connections established|int|count|






### `dnsflow`

- Tag List


| Tag | Description |
|  ----  | --------|
|`direction`|Identifies the connection initiator using the source (src_ip:src_port). (incoming/outgoing)|
|`dst_domain`|Destination domain|
|`dst_ip`|Destination IP address|
|`dst_ip_type`|Destination IP type. (other/private/multicast)|
|`dst_k8s_deployment_name`|Destination K8s deployment name|
|`dst_k8s_namespace`|Destination K8s namespace|
|`dst_k8s_pod_name`|Destination K8s pod name|
|`dst_k8s_service_name`|Destination K8s service name|
|`dst_port`|Destination port|
|`family`|Network layer protocol. (IPv4/IPv6)|
|`host`|System hostname|
|`source`|Fixed value: `dnsflow`.|
|`src_ip`|Source IP|
|`src_ip_type`|Source IP type. (other/private/multicast)|
|`src_k8s_deployment_name`|Source K8s deployment name|
|`src_k8s_namespace`|Source K8s namespace|
|`src_k8s_pod_name`|Source K8s pod name|
|`src_k8s_service_name`|Source K8s service name|
|`src_port`|Source port|
|`sub_source`|Specific connection classifications, such as the sub_source value for Kubernetes network traffic is K8s|
|`transport`|Transport layer protocol. (udp/tcp)|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`count`|The number of DNS requests in a collection cycle|int|-|
|`latency`|Average response time for DNS requests|int|ns|
|`latency_max`|Maximum response time for DNS requests|int|ns|
|`rcode`|DNS response code: 0 - `NoError`, 1 - `FormErr`, 2 - `ServFail`, 3 - NXDomain, 4 - NotImp, 5 - Refused, ...; A value of -1 means the request timed out|int|-|










### `httpflow`

- Tag List


| Tag | Description |
|  ----  | --------|
|`direction`|Identifies the connection initiator using the source (src_ip:src_port). (incoming/outgoing)|
|`dst_domain`|Destination domain|
|`dst_ip`|Destination IP address|
|`dst_ip_type`|Destination IP type. (other/private/multicast)|
|`dst_k8s_deployment_name`|Destination K8s deployment name|
|`dst_k8s_namespace`|Destination K8s namespace|
|`dst_k8s_pod_name`|Destination K8s pod name|
|`dst_k8s_service_name`|Destination K8s service name|
|`dst_nat_ip`|For data containing the `outging` tag, this value is the IP after the DNAT operation|
|`dst_nat_port`|For data containing the `outging` tag, this value is the port after the DNAT operation|
|`dst_port`|Destination port|
|`family`|Network layer protocol. (IPv4/IPv6)|
|`host`|System hostname|
|`pid`|Process identification number|
|`process_name`|Process name|
|`source`|Fixed value: `httpflow`.|
|`src_ip`|Source IP|
|`src_ip_type`|Source IP type. (other/private/multicast)|
|`src_k8s_deployment_name`|Source K8s deployment name|
|`src_k8s_namespace`|Source K8s namespace|
|`src_k8s_pod_name`|Source K8s pod name|
|`src_k8s_service_name`|Source K8s service name|
|`src_port`|Source port|
|`sub_source`|Specific connection classifications, such as the sub_source value for Kubernetes network traffic is K8s|
|`transport`|Transport layer protocol. (udp/tcp)|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bytes_read`|The number of bytes read|int|B|
|`bytes_written`|The number of bytes written|int|B|
|`count`|The total number of HTTP requests in a collection cycle|int|-|
|`http_version`|1.1 / 1.0 ...|string|-|
|`latency`|TTFB|int|ns|
|`method`|GET/POST/...|string|-|
|`path`|Request path|string|-|
|`status_code`|HTTP status codes|int|-|
|`truncated`|The length of the request path has reached the upper limit of the number of bytes collected, and the request path may be truncated|bool|-|
















## Logs {#logging}













### `bash`

- Tag List


| Tag | Description |
|  ----  | --------|
|`host`|Hostname|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cmd`|Command|string|-|
|`message`|The bash execution record generated by the collector|string|-|
|`pid`|Process identification number|string|-|
|`user`|The user who executes the bash command|string|-|










### `bpf_net_l4_log`

- Tag List


| Tag | Description |
|  ----  | --------|
|`client_ip`|The IP address of the client|
|`client_port`|Client port|
|`conn_side`|The side of the connection: client/server/unknown|
|`direction`|Identifies the connection initiator using the source (src_ip:src_port). (incoming/outgoing)|
|`dst_ip`|The IP address of the foreign network interface|
|`dst_k8s_deployment_name`|Destination K8s deployment name|
|`dst_k8s_namespace`|Destination K8s namespace|
|`dst_k8s_pod_name`|Destination K8s pod name|
|`dst_k8s_service_name`|Destination K8s service name|
|`dst_port`|Foreign port|
|`host`|Hostname|
|`host_network`|Whether the network log data is collected on the host network|
|`inner_traceid`|Correlate the layer 4 and layer 7 network log data of a TCP connection on the collected network interface|
|`k8s_container_name`|Kubernetes container name|
|`k8s_namespace`|Kubernetes namespace|
|`k8s_pod_name`|Kubernetes pod name|
|`l4_proto`|Transport protocol|
|`l7_proto`|Application protocol|
|`netns`|Network namespace, format: `NS(<device id>:<inode number>)`|
|`nic_mac`|MAC address of the collected network interface|
|`nic_name`|Name of the collected network interface|
|`server_ip`|The IP address of the server|
|`server_port`|Server port|
|`src_ip`|The IP address of the collected local network interface|
|`src_k8s_deployment_name`|Source K8s deployment name|
|`src_k8s_namespace`|Source K8s namespace|
|`src_k8s_pod_name`|Source K8s pod name|
|`src_k8s_service_name`|Source K8s service name|
|`src_port`|Local port|
|`sub_source`|Specific connection classifications, such as the sub_source value for Kubernetes network traffic is K8s|
|`virtual_nic`|Whether the network log data is collected on the virtual network interface|
|`vni_id`|Virtual Network Identifier|
|`vxlan_packet`|Whether it is a VXLAN packet|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`chunk_id`|A connection may be divided into several chunks for upload based on time interval or TCP segment number|int|-|
|`rx_bytes`|The number of bytes received by the network interface|int|B|
|`rx_packets`|The number of packets received by the network interface|int|-|
|`rx_retrans`|The number of retransmitted packets received by the network interface|int|-|
|`rx_seq_max`|The maximum value of the TCP sequence number of the data packet received by the network interface, which is a 32-bit unsigned integer|int|-|
|`rx_seq_min`|The minimum value of the TCP sequence number of the data packet received by the network interface, which is a 32-bit unsigned integer|int|-|
|`tcp_syn_retrans`|The number of retransmitted SYN packets sent by the network interface|int|-|
|`tx_bytes`|The number of bytes sent by the network interface|int|B|
|`tx_packets`|The number of packets sent by the network interface|int|-|
|`tx_retrans`|The number of retransmitted packets sent by the network interface|int|-|
|`tx_seq_max`|The maximum value of the TCP sequence number of the data packet sent by the network interface, which is a 32-bit unsigned integer|int|-|
|`tx_seq_min`|The minimum value of the TCP sequence number of the data packet sent by the network interface, which is a 32-bit unsigned integer|int|-|






### `bpf_net_l7_log`

- Tag List


| Tag | Description |
|  ----  | --------|
|`client_ip`|The IP address of the client|
|`client_port`|Client port|
|`conn_side`|The side of the connection: client/server/unknown|
|`direction`|Identifies the connection initiator using the source (src_ip:src_port). (incoming/outgoing)|
|`dst_ip`|The IP address of the foreign network interface|
|`dst_k8s_deployment_name`|Destination K8s deployment name|
|`dst_k8s_namespace`|Destination K8s namespace|
|`dst_k8s_pod_name`|Destination K8s pod name|
|`dst_k8s_service_name`|Destination K8s service name|
|`dst_port`|Foreign port|
|`host`|Hostname|
|`host_network`|Whether the network log data is collected on the host network|
|`inner_traceid`|Correlate the layer 4 and layer 7 network log data of a TCP connection on the collected network interface|
|`k8s_container_name`|Kubernetes container name|
|`k8s_namespace`|Kubernetes namespace|
|`k8s_pod_name`|Kubernetes pod name|
|`l4_proto`|Transport protocol|
|`l7_proto`|Application protocol|
|`l7_traceid`|Correlate the layer 7 network log data of a TCP connection on all collected network interfaces|
|`netns`|Network namespace, format: `NS(<device id>:<inode number>)`|
|`nic_mac`|MAC address of the collected network interface|
|`nic_name`|Name of the collected network interface|
|`parent_id`|The span id of the APM span corresponding to this network request|
|`server_ip`|The IP address of the server|
|`server_port`|Server port|
|`src_ip`|The IP address of the collected local network interface|
|`src_k8s_deployment_name`|Source K8s deployment name|
|`src_k8s_namespace`|Source K8s namespace|
|`src_k8s_pod_name`|Source K8s pod name|
|`src_k8s_service_name`|Source K8s service name|
|`src_port`|Local port|
|`sub_source`|Specific connection classifications, such as the sub_source value for Kubernetes network traffic is K8s|
|`trace_id`|APM trace id|
|`virtual_nic`|Whether the network log data is collected on the virtual network interface|
|`vni_id`|Virtual Network Identifier|
|`vxlan_packet`|Whether it is a VXLAN packet|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`http_method`|HTTP method|string|-|
|`http_path`|HTTP path|string|-|
|`http_status_code`|HTTP status code|int|-|
|`rx_seq`|The TCP sequence number of the request/response first byte received by the network interface|int|-|
|`tx_seq`|The TCP sequence number of the request/response first byte sent by the network interface|int|-|








## Tracing {#tracing}































### `dketrace`

- Tag List


| Tag | Description |
|  ----  | --------|
|`dst_ip`|Destination IP address|
|`dst_port`|Destination port|
|`host`|System hostname|
|`service`|Service name|
|`src_ip`|Source IP|
|`src_port`|Source port|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`app_parent_id`|Parent span id carried by the application in the request|string|-|
|`app_trace_id`|Trace id carried by the application in the request|string|-|
|`bytes_read`|Bytes read|int|B|
|`bytes_written`|Bytes written|int|B|
|`duration`|Duration|int|μs|
|`ebpf_parent_id`|eBPF parent span id, generated by the `ebpftrace` collector|string|-|
|`ebpf_trace_id`|eBPF trace id, generated by the `ebpftrace` collector|string|-|
|`err_msg`|Redis error message|string|-|
|`grpc_status_code`|gRPC status code|string|-|
|`http_method`|HTTP method|string|-|
|`http_route`|HTTP route|string|-|
|`http_status_code`|HTTP status code|string|-|
|`mysql_err_msg`|MySQL error message|string|-|
|`mysql_status_code`|MySQL request status code|int|-|
|`operation`|Operation|string|-|
|`parent_id`|APM parent span id, set by the `ebpftrace` collector|string|-|
|`pid`|Process identification number|string|-|
|`process_name`|Process name|string|-|
|`resource_type`|Redis resource type|string|-|
|`source_type`|Source type, value is `ebpf`|string|-|
|`span_id`|APM span id, generated by the `ebpftrace` collector|string|-|
|`span_type`|Span type|string|-|
|`start`|Start time|int|usec|
|`status`|Status|string|-|
|`status_msg`|Redis status message|string|-|
|`thread_name`|Thread name|string|-|
|`trace_id`|APM trace id, can choose between existing app trace id and ebpf generation, set by