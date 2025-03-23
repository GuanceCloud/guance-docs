---
title     : 'eBPF'
summary   : 'Collect Linux network data via eBPF'
tags:
  - 'EBPF'
  - 'NETWORK'
__int_icon      : 'icon/ebpf'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

:fontawesome-brands-linux: :material-kubernetes:

---

The eBPF collector gathers HOST NETWORK TCP and UDP connection information, Bash execution logs, etc. The collector includes the following plugins:

- `ebpf-net`:
    - Data category: Network
    - It is composed of netflow, httpflow and dnsflow, which are used to collect host TCP/UDP connection statistics and host DNS resolution information respectively;

- `ebpf-bash`:

    - Data category: Logging
    - Collect Bash execution log, including Bash process number, user name, executed command and time, etc.;

- `ebpf-conntrack`: [:octicons-tag-24: Version-1.8.0](../datakit/changelog.md#cl-1.8.0)
    - Adds two labels `dst_nat_ip` and `dst_nat_port` to network flow data, recording the target IP and port after `DNAT`; this plugin can be enabled when the kernel loads `nf_conntrack`;

- `ebpf-trace`: [:octicons-tag-24: Version-1.17.0](../datakit/changelog.md#cl-1.17.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)
    - Data categories: `Tracing`
    - Used for tracking application network request call relationships, based on `ebpf-net`'s `httpflow` data and eBPF probes;

- `bpf-netlog`:
    - Data categories: `Logging`, `Network`
    - This plugin implements the collection of network logs `bpf_net_l4_log/bpf_net_l7_log`, and can also replace `ebpf-net`'s `netflow/httpflow` data collection when the kernel does not support eBPF;

## Configuration {#config}

### Preconditions {#requirements}

For DataKit before v1.5.6, you need to execute the installation command to install:

- v1.2.13 ~ v1.2.18
    - Install time [specify environment variable](../datakit/datakit-install.md#extra-envs)：`DK_INSTALL_EXTERNALS="datakit-ebpf"`
    - After the DataKit is installed, manually install the eBPF collector: `datakit install --datakit-ebpf`
- v1.2.19+
    - [specify environment variable](../datakit/datakit-install.md#extra-envs)：`DK_INSTALL_EXTERNALS="ebpf"` when installing
    - After the DataKit is installed, manually install the eBPF collector: `datakit install --ebpf`
- v1.5.6+
    - No manual installation required

When deploying in Kubernetes environment, you must mount the host's' `/sys/kernel/debug` directory into pod, refer to the latest `datakit.yaml`;

### Linux Kernel Version Requirement {#kernel}

In addition to CentOS 7.6+ and Ubuntu 16.04, other distributions recommend that the Linux kernel version is higher than 4.9, otherwise the eBPF collector may not start.

If you want to enable the  *eBPF-conntrack*  plugin, usually requires a higher kernel version, such as v5.4.0 etc., please confirm whether the symbols in the kernel contain `nf_ct_delete` and `__nf_conntrack_hash_insert`, you can execute the following command to view:

```sh
cat /proc/kallsyms | awk '{print $3}' | grep "^nf_ct_delete$\|^__nf_conntrack_hash_insert$"
```
<!-- markdownlint-disable MD046 -->
???+ warning "kernel restrictions"

    When the DataKit version is lower than **v1.5.2**, the httpflow data collection in the eBPF-net category cannot be enabled for CentOS 7.6+, because its Linux 3.10.x kernel does not support the BPF_PROG_TYPE_SOCKET_FILTER type in the eBPF program;

    When the DataKit version is lower than **v1.5.2**, because BPF_FUNC_skb_load_bytes does not exist in Linux Kernel <= 4.4, if you want to enable httpflow, you need Linux Kernel >= 4.5, and this problem will be further optimized;
<!-- markdownlint-enable -->

### SELinux-enabled System {#selinux}

For SELinux-enabled systems, you need to shut them down (pending subsequent optimization), and execute the following command to shut them down:

```sh
setenforce 0
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `ebpf.conf.sample` and name it `ebpf.conf`. The example is as follows:
    
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
      ## Can configure the number of cpu cores, memory size and network bandwidth.
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
      
      ## all supported plugins:
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
    
      ## trace all processes directly
      ##
      trace_all_process = false
      
      ## trace all processes containing any specified environment variable
      trace_env_list = [
        "DK_BPFTRACE_SERVICE",
        "DD_SERVICE",
        "OTEL_SERVICE_NAME",
      ]
      
      ## deny tracking any process containing any specified environment variable
      trace_env_blacklist = []
      
      ## trace all processes containing any specified process names,
      ## can be used with trace_namedenyset
      ##
      trace_name_list = []
      
      ## deny tracking any process containing any specified process names
      ##
      trace_name_blacklist = [
        
        ## The following two processes are hard-coded to never be traced,
        ## and do not need to be set:
        ##
        # "datakit",
        # "datakit-ebpf",
      ]
    
      ## conv other trace id to datadog trace id (base 10, 64-bit) 
      conv_to_ddtrace = false
    
      ## If the system does not enable ipv6, it needs to be changed to true
      ##
      ipv6_disabled = false
    
      ## ephemeral port strart from <ephemeral_port>
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
    
    After configuring, restart DataKit.

=== "Kubernetes"

    In Kubernetes, there are two ways to enable the eBPF collector: through ConfigMap or by enabling it by default in *datakit.yaml*:

    1. Refer to the generic [installation example](../datakit/datakit-daemonset-deploy.md#configmap-setting) for the ConfigMap method.
    2. Append `ebpf` to the environment variable `ENV_ENABLE_INPUTS` in *datakit.yaml*, which uses the default configuration, i.e., only enables `ebpf-net` network data collection.
    
    ```yaml
    - name: ENV_ENABLE_INPUTS
           value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ebpf
    ```

### Environment Variables and Configuration Fields {#input-cfg-field-env}

Adjust the eBPF collection configuration in Kubernetes via the following environment variables:

Configuration items:

- `enabled_plugins`:
    - Description: Used to configure the built-in plugins for the collector
    - Environment variable: `ENV_INPUT_EBPF_ENABLED_PLUGINS`
    - Example: `ebpf-net,ebpf-trace`

- `l7net_enabled`
    - Description: Enable http protocol data collection
    - Environment Variable: `ENV_INPUT_EBPF_L7NET_ENABLED`
    - Example: `httpflow`

- `interval`
    - Description: Set the sampling time interval
    - Environment Variable: `ENV_INPUT_EBPF_INTERVAL`
    - Example: `1m30s`

- `ipv6_disabled`
    - Description: Whether the system does not support IPv6
    - Environment Variable: `ENV_INPUT_EBPF_IPV6_DISABLED`
    - Example: `false`

- `ephemeral_port`
    - Description: Starting position of the ephemeral port
    - Environment Variable: `ENV_INPUT_EBPF_EPHEMERAL_PORT`
    - Example: `32768`

- `pprof_host`
    - Description: pprof host
    - Environment Variable: `ENV_INPUT_EBPF_PPROF_HOST`
    - Example: `127.0.0.1`

- `pprof_port`
    - Description: pprof port
    - Environment Variable: `ENV_INPUT_EBPF_PPROF_PORT`
    - Example: `6061`

<!-- - `interval`
    - Description: Data aggregation period
    - Environment Variable: `ENV_INPUT_EBPF_INTERVAL`
    - Example: `60s` -->

- `trace_server`
    - Description: Address of the DataKit ELinker/Datakit to enable the `ebpftrace` collector
    - Environment Variable: `ENV_INPUT_EBPF_TRACE_SERVER`
    - Example: `<ip>:<port>`

- `trace_all_process`
    - Description: Trace all processes within the system
    - Environment Variable: `ENV_INPUT_EBPF_TRACE_ALL_PROCESS`
    - Example: `false`

- `trace_name_blacklist`
    - Description: Processes with specified process names will be prohibited from collecting link data
    - Environment Variable: `ENV_INPUT_EBPF_TRACE_NAME_BLACKLIST`
    - Example:

- `trace_env_blacklist`
    - Description: Processes containing any one of the specified environment variable names will be prohibited from collecting link data
    - Environment Variable: `ENV_INPUT_EBPF_TRACE_ENV_BLACKLIST`
    - Example: `DKE_DISABLE_ETRACE`

- `trace_env_list`
    - Description: Link data of processes containing any specified environment variables will be tracked and reported
    - Environment Variable: `ENV_INPUT_EBPF_TRACE_ENV_LIST`
    - Example: `DK_BPFTRACE_SERVICE,DD_SERVICE,OTEL_SERVICE_NAME`

- `trace_name_list`
    - Description: Processes with process names in the specified set will be tracked and reported
    - Environment Variable: `ENV_INPUT_EBPF_TRACE_NAME_LIST`
    - Example: `chrome,firefox`

- `conv_to_ddtrace`
    - Description: Convert all application-side link ids to strings represented in base 10, compatible usage, unnecessary not to use
    - Environment Variable: `ENV_INPUT_EBPF_CONV_TO_DDTRACE`
    - Example: `false`

- `netlog_blacklist`
    - Description: Used to filter packets after packet capture
    - Environment Variable: `ENV_INPUT_EBPF_NETLOG_BLACKLIST`
    - Example: `ip_saddr=='127.0.0.1' \|\| ip_daddr=='127.0.0.1'`

- `netlog_metric`
    - Description: Collect network metrics by analyzing network packets
    - Environment Variable: `ENV_INPUT_EBPF_NETLOG_METRIC`
    - Example: `true`

- `netlog_log`
    - Description: Collect network logs by analyzing network packets
    - Environment Variable: `ENV_INPUT_EBPF_NETLOG_LOG`
    - Example: `false`

- `cpu_limit`
    - Description: Maximum CPU core usage restriction per unit time, exit upon reaching the upper limit
    - Environment Variable: `ENV_INPUT_EBPF_CPU_LIMIT`
    - Example: `"2.0"`

- `mem_limit`
    - Description: Memory size usage restriction
    - Environment Variable: `ENV_INPUT_EBPF_MEM_LIMIT`
    - Example: `"4GiB"`

- `net_limit`
    - Description: Network bandwidth (any NIC) restriction
    - Environment Variable: `ENV_INPUT_EBPF_NET_LIMIT`
    - Example: `"100MiB/s"`

- `sampling_rate`
    - Description: Set the sampling rate for reporting data by the eBPF collector, range `0.01 ~ 1.00`; mutually exclusive with setting `samping_rate_pts_per_min`
    - Environment Variable: `ENV_INPUT_EBPF_SAMPLING_RATE`
    - Example: `0.50`

- `samping_rate_pts_per_min`
    - Description: Set the threshold for the amount of data reported per minute by the eBPF collector, dynamically adjusting the sampling rate
    - Environment Variable: `ENV_INPUT_EBPF_SAMPLING_RATE_PTSPERMIN`
    - Example: `1500`
<!-- markdownlint-enable -->

## eBPF Tracing function {#ebpf-tracing}

`ebpf-trace` collects and analyzes the network data read and written by the process on the host, and tracks the kernel-level threads/user-level threads (such as golang goroutine) of the process to generate link eBPF Span. This data needs to be collected by `ebpftrace` for further processing.

When using, you need to deploy the eBPF collector with link data collection enabled on multiple nodes, then you need to send all eBPF Span data to the same DataKit ELinker/DataKit with the [`ebpftrace`](./ebpftrace.md#ebpftrace-config) collector plug-in enabled. For more configuration details, see the [eBPF link document](./ebpftrace.md#ebpf-config)

<!-- markdownlint-disable MD013 -->
### The blacklist function of the `bpf-netlog` plug-in {#blacklist}
<!-- markdownlint-enable -->

Filter rule example:

Single rule:

The following rule filters out network data with an IP of `1.1.1.1` and port 80. (Operators allow line breaks)

```py
(ip_saddr == "1.1.1.1" || ip_saddr == "1.1.1.1") &&
     (src_port == 80 || dst_port == 80)
```

Multiple rules:

Rules are separated by `;` or `\n`, and data filtering occurs if any one rule is satisfied.

```py
udp
ip_saddr == "1.1.1.1" && (src_port == 80 || dst_port == 80);
ip_saddr == "10.10.0.1" && (src_port == 80 || dst_port == 80)

ipnet_contains("127.0.0.0/8", ip_saddr); ipv6
```

Data that can be filtered:

This filter is used to filter network data, and the comparable data is as follows:

| key name      | type | description                                                                             |
| ------------- | ---- | --------------------------------------------------------------------------------------- |
| `tcp`         | bool | Whether it is `TCP` protocol                                                            |
| `udp`         | bool | Whether it is `UDP` protocol                                                            |
| `ipv4`        | bool | Whether it is `IPv4` protocol                                                           |
| `ipv6`        | bool | Whether it is `IPv6` protocol                                                           |
| `src_port`    | int  | Source port (based on the observed network card/host/container as the reference system) |
| `dst_port`    | int  | target port                                                                             |
| `ip_saddr`    | str  | Source `IPv4` network address                                                           |
| `ip_saddr`    | str  | Target `IPv4` network address                                                           |
| `ip6_saddr`   | str  | Source `IPv6` network address                                                           |
| `ip6_daddr`   | str  | Destination `IPv6` network address                                                      |
| `k8s_src_pod` | str  | source `pod` name                                                                       |
| `k8s_dst_pod` | str  | target `pod` name                                                                       |

Operators:

Operator precedence from high to low:

| Priority | Op     | Name                        | Binding Direction |
| -------- | ------ | --------------------------- | ----------------- |
| 1        | `()`   | parentheses                 | left              |
| 2        | `!`    | Logical NOT, unary operator | Right             |
| 3        | `!=`   | Not equal to                | Left              |
| 3        | `>=`   | Greater than or equal to    | Left              |
| 3        | `>`    | greater than                | left              |
| 3        | `==`   | equal to                    | left              |
| 3        | `<=`   | Less than or equal to       | Left              |
| 3        | `<`    | less than                   | left              |
| 4        | `&&`   | Logical AND                 | Left              |
| 4        | `\|\|` | Logical OR                  | Left              |

Functions:

1. **ipnet_contains**

    Function signature: `fn ipnet_contains(ipnet: str, ipaddr: str) bool`

    Description: Determines if the address is within the specified subnet

    Example:

    ```py
    ipnet_contains("127.0.0.0/8", ip_saddr)
    ```

    If `ip_saddr` is "127.0.0.1", this rule returns `true`, and the TCP connection packet/UDP packet will be filtered.

2. **has_prefix**

    Function signature: `fn has_prefix(s: str, prefix: str) bool`

    Description: Checks if the specified field contains a certain prefix

    Example:

    ```py
    has_prefix(k8s_src_pod, "datakit-") || has_prefix(k8s_dst_pod, "datakit-")
    ```

    If the pod name is `datakit-kfez321`, this rule returns `true`.

## Aggregated Network Data {#network}

All the following data collections append a global tag named `host` by default (tag value being the hostname where DataKit resides), and additional tags can also be specified through `[inputs.ebpf.tags]` in the configuration:

``` toml
 [inputs.ebpf.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `netflow`

- Tag list


| Tag | Description |
|  ----  | --------|
|`direction`|Use the source (src_ip:src_port) as a frame of reference to identify the connection initiator. (incoming/outgoing)|
|`dst_domain`|Destination domain|
|`dst_ip`|Destination IP address|
|`dst_ip_type`|Destination IP type. (other/private/multicast)|
|`dst_k8s_deployment_name`|Destination K8s deployment name|
|`dst_k8s_namespace`|Destination K8s namespace|
|`dst_k8s_pod_name`|Destination K8s pod name|
|`dst_k8s_service_name`|Destination K8s service name|
|`dst_nat_ip`|For data containing the `outging` tag, this value is the ip after the DNAT operation|
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
|`sub_source`|Some specific connection classifications, such as the sub_source value for Kubernetes network traffic is K8s|
|`transport`|Transport layer protocol. (udp/tcp)|

- Field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bytes_read`|The number of bytes read|int|B|
|`bytes_written`|The number of bytes written|int|B|
|`retransmits`|The number of retransmissions|int|count|
|`rtt`|TCP Latency|int|μs|
|`rtt_var`|TCP Jitter|int|μs|
|`tcp_closed`|The number of TCP connection closed|int|count|
|`tcp_established`|The number of TCP connection established|int|count|






### `dnsflow`

- Tag list


| Tag | Description |
|  ----  | --------|
|`direction`|Use the source (src_ip:src_port) as a frame of reference to identify the connection initiator. (incoming/outgoing)|
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
|`sub_source`|Some specific connection classifications, such as the sub_source value for Kubernetes network traffic is K8s|
|`transport`|Transport layer protocol. (udp/tcp)|

- Field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`count`|The number of DNS requests in a collection cycle|int|-|
|`latency`|Average response time for DNS requests|int|ns|
|`latency_max`|Maximum response time for DNS requests|int|ns|
|`rcode`|DNS response code: 0 - `NoError`, 1 - `FormErr`, 2 - `ServFail`, 3 - NXDomain, 4 - NotImp, 5 - Refused, ...; A value of -1 means the request timed out|int|-|










### `httpflow`

- Tag list


| Tag | Description |
|  ----  | --------|
|`direction`|Use the source (src_ip:src_port) as a frame of reference to identify the connection initiator. (incoming/outgoing)|
|`dst_domain`|Destination domain|
|`dst_ip`|Destination IP address|
|`dst_ip_type`|Destination IP type. (other/private/multicast)|
|`dst_k8s_deployment_name`|Destination K8s deployment name|
|`dst_k8s_namespace`|Destination K8s namespace|
|`dst_k8s_pod_name`|Destination K8s pod name|
|`dst_k8s_service_name`|Destination K8s service name|
|`dst_nat_ip`|For data containing the `outging` tag, this value is the ip after the DNAT operation|
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
|`sub_source`|Some specific connection classifications, such as the sub_source value for Kubernetes network traffic is K8s|
|`transport`|Transport layer protocol. (udp/tcp)|

- Field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bytes_read`|The number of bytes read|int|B|
|`bytes_written`|The number of bytes written|int|B|
|`count`|The total number of HTTP requests in a collection cycle|int|-|
|`http_version`|1.1 / 1.0 ...|string|-|
|`latency`|TTFB|int|ns|
|`method`|GET/POST/...|string|-|
|`path`|Request path|string|-|
|`status_code`|Http status codes|int|-|
|`truncated`|The length of the request path has reached the upper limit of the number of bytes collected, and the request path may be truncated|bool|-|

















## Logging {#logging}













### `bash`

- Tag list


| Tag | Description |
|  ----  | --------|
|`host`|host name|

- Field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :---: |
|`cmd`|Command|string|-|
|`message`|The bash execution record generated by the collector|string|-|
|`pid`|Process identification number|string|-|
|`user`|The user who executes the bash command|string|-|










### `bpf_net_l4_log`

- Tag list


| Tag | Description |
|  ----  | --------|
|`client_ip`|The IP address of the client|
|`client_port`|Client port|
|`conn_side`|The side of the connection: client/server/unknown|
|`direction`|Use the source (src_ip:src_port) as a frame of reference to identify the connection initiator. (incoming/outgoing)|
|`dst_ip`|The IP address of the foreign network interface|
|`dst_k8s_deployment_name`|Destination K8s deployment name|
|`dst_k8s_namespace`|Destination K8s namespace|
|`dst_k8s_pod_name`|Destination K8s pod name|
|`dst_k8s_service_name`|Destination K8s service name|
|`dst_port`|Foreign port|
|`host`|Host name|
|`host_network`|Whether the network log data is collected on the host network|
|`inner_traceid`|Correlate the layer 4 and layer 7 network log data of a TCP connection on the collected network interface|
|`k8s_container_name`|Kubernetes container name|
|`k8s_namespace`|Kubernetes namespace|
|`k8s_pod_name`|Kubernetes pod name|
|`l4_proto`|Transport protocol|
|`l7_proto`|Application protocol|
|`netns`|Network namespace, format: `NS(<device id>:<inode number>)`|
|`nic_mac`|MAC address of the collected network interface|
|`nic_name`|name of the collected network interface|
|`server_ip`|The IP address of the server|
|`server_port`|Server port|
|`src_ip`|The IP address of the collected local network interface|
|`src_k8s_deployment_name`|Source K8s deployment name|
|`src_k8s_namespace`|Source K8s namespace|
|`src_k8s_pod_name`|Source K8s pod name|
|`src_k8s_service_name`|Source K8s service name|
|`src_port`|Local port|
|`sub_source`|Some specific connection classifications, such as the sub_source value for Kubernetes network traffic is K8s|
|`virtual_nic`|Whether the network log data is collected on the virtual network interface|
|`vni_id`|Virtual Network Identifier|
|`vxlan_packet`|Whether it is a VXLAN packet|

- Field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :---: |
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

- Tag list


| Tag | Description |
|  ----  | --------|
|`client_ip`|The IP address of the client|
|`client_port`|Client port|
|`conn_side`|The side of the connection: client/server/unknown|
|`direction`|Use the source (src_ip:src_port) as a frame of reference to identify the connection initiator. (incoming/outgoing)|
|`dst_ip`|The IP address of the foreign network interface|
|`dst_k8s_deployment_name`|Destination K8s deployment name|
|`dst_k8s_namespace`|Destination K8s namespace|
|`dst_k8s_pod_name`|Destination K8s pod name|
|`dst_k8s_service_name`|Destination K8s service name|
|`dst_port`|Foreign port|
|`host`|Host name|
|`host_network`|Whether the network log data is collected on the host network|
|`inner_traceid`|Correlate the layer 4 and layer 7 network log data of a TCP connection on the collected network interface|
|`k8s_container_name`|Kubernetes container name|
|`k8s_namespace`|Kubernetes namespace|
|`k8s_pod_name`|Kubernetes pod name|
|`l4_proto`|Transport protocol|
|`l7_proto`|Application protocol|
|`l7_traceid`|Correlate the layer 7 network log data of a TCP connection on the all collected network interface|
|`netns`|Network namespace, format: `NS(<device id>:<inode number>)`|
|`nic_mac`|MAC address of the collected network interface|
|`nic_name`|name of the collected network interface|
|`parent_id`|The span id of the APM span corresponding to this network request|
|`server_ip`|The IP address of the server|
|`server_port`|Server port|
|`src_ip`|The IP address of the collected local network interface|
|`src_k8s_deployment_name`|Source K8s deployment name|
|`src_k8s_namespace`|Source K8s namespace|
|`src_k8s_pod_name`|Source K8s pod name|
|`src_k8s_service_name`|Source K8s service name|
|`src_port`|Local port|
|`sub_source`|Some specific connection classifications, such as the sub_source value for Kubernetes network traffic is K8s|
|`trace_id`|APM trace id|
|`virtual_nic`|Whether the network log data is collected on the virtual network interface|
|`vni_id`|Virtual Network Identifier|
|`vxlan_packet`|Whether it is a VXLAN packet|

- Field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :---: |
|`http_method`|HTTP method|string|-|
|`http_path`|HTTP path|string|-|
|`http_status_code`|HTTP status code|int|-|
|`rx_seq`|The tcp sequence number of the request/response first byte received by the network interface|int|-|
|`tx_seq`|The tcp sequence number of the request/response first byte sent by the network interface|int|-|









## Tracing {#tracing}





























### `dketrace`

- Tag list


| Tag | Description |
|  ----  | --------|
|`dst_ip`|Destination IP address|
|`dst_port`|Destination port|
|`host`|System hostname|
|`service`|Service name|
|`src_ip`|Source IP|
|`src_port`|Source port|

- Field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :---: |
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
|`trace_id`|APM trace id, can choose between existing app trace id and ebpf generation,set by the `ebpftrace` collector|string|-|



