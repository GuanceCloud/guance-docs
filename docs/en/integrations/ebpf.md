---
title     : 'eBPF'
summary   : 'Collect Linux network data through eBPF'
__int_icon      : 'icon/ebpf'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# eBPF
<!-- markdownlint-enable -->
---

:fontawesome-brands-linux: :material-kubernetes:

---

eBPF collector, collecting host network TCP, UDP connection information, Bash execution log, etc. This collector mainly includes `ebpf-net`, `ebpf-conntrack` and `ebpf-bash` three plugins:

- `ebpf-net`:
    - Data category: Network
    - It is composed of netflow, httpflow and dnsflow, which are used to collect host TCP/UDP connection statistics and host DNS resolution information respectively;

- `ebpf-bash`:

    - Data category: Logging
    - Collect Bash execution log, including Bash process number, user name, executed command and time, etc.;

- `ebpf-conntrack`: [:octicons-tag-24: Version-1.8.0](../datakit/changelog.md#cl-1.8.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)
    - Add two tags `dst_nat_ip` and `dst_nat_port` to the network flow data.


- `ebpf-trace`:
    - Application call relationship tracking.

- `bpf-netlog`:
    - Data category: `Logging`, `Network`
    - This plugin implements `ebpf-net`’s `netflow/httpflow`

## Configuration {#config}

### Preconditions {#requirements}

For DataKit before v1.5.6, you need to execute the installation command to install:

- v1.2.13 ~ v1.2.18
    - Install time [specify environment variable](datakit-install.md#extra-envs)：`DK_INSTALL_EXTERNALS="datakit-ebpf"`
    - After the DataKit is installed, manually install the eBPF collector: `datakit install --datakit-ebpf`
- v1.2.19+
    - [specify environment variable](datakit-install.md#extra-envs)：`DK_INSTALL_EXTERNALS="ebpf"` when installing
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

### `eBPF Tracing` using {#ebpf-trace}

`ebpf-trace` uses eBPF technology to obtain network data, and traces the kernel-level threads/user-level threads of the process (such as golang goroutine) to generate link eBPF Span.

If the eBPF collector with link data collection enabled is deployed on multiple nodes, all eBPF link data needs to be sent to the same DataKit ELinker/DataKit with the [`ebpftrace`](./ebpftrace.md#ebpftrace-config) collector plug-in enabled.

For more details, see the [eBPF link document](./ebpftrace.md#ebpf-config)

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
    
      ## automatically takes effect when running DataKit in 
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

    In Kubernetes, you can enable collection through ConfigMap or directly enable the eBPF collector by default:

    1. For the ConfigMap method, refer to the general [Installation Example](../datakit/datakit-daemonset-deploy.md#configmap-setting).
    2. Add `ebpf` to the environment variable `ENV_ENABLE_INPUTS` in *datakit.yaml*. In this case, the default configuration is used, that is, only `ebpf-net` network data collection is enabled.
    
    ```yaml
    - name: ENV_ENABLE_INPUTS
           value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ebpf
    ```

### Environment variables and configuration items {#input-cfg-field-env}

The following environment variables can be used to adjust the eBPF collection configuration in Kubernetes:

Configuration items:

- `enabled_plugins`:
    - Description: Used to configure the built-in plugins for the collector
    - Environment variable: `ENV_INPUT_EBPF_ENABLED_PLUGINS`
    - Example: `ebpf-net,ebpf-trace`

- `l7net_enabled`
    - Description: Enable http protocol data collection
    - Environment variable: `ENV_INPUT_EBPF_L7NET_ENABLED`
    - Example: `httpflow`

- `ipv6_disabled`
    - Description: Whether the system does not support IPv6
    - Environment variable: `ENV_INPUT_EBPF_IPV6_DISABLED`
    - Example: `false`

- `ephemeral_port`
    - Description: Ephemeral port start location
    - Environment variable: `ENV_INPUT_EBPF_EPHEMERAL_PORT`
    - Example: `32768`

<!-- - `interval`
    - Description: Data aggregation period
    - Environment variable: `ENV_INPUT_EBPF_INTERVAL`
    - Example: `60s` -->

- `trace_server`
    - Description: The address of DataKit ELinker/Datakit to enable the `ebpftrace` collector
    - Environment variable: `ENV_INPUT_EBPF_TRACE_SERVER`
    - Example: `<ip>:<port>`

- `trace_all_process`
    - Description: Trace all processes in the system
    - Environment variable: `ENV_INPUT_EBPF_TRACE_ALL_PROCESS`
    - Example: `false`

- `trace_name_blacklist`
    - Description: The process with the specified process name will be **disabled** from collecting trace data
    - Environment variable: `ENV_INPUT_EBPF_TRACE_NAME_BLACKLIST`
    - Example:

- `trace_env_blacklist`
    - Description: Any process containing any of the specified environment variable names will be **disabled** from collecting trace data
    - Environment variable: `ENV_INPUT_EBPF_TRACE_ENV_BLACKLIST`
    - Example: `DKE_DISABLE_ETRACE`

- `trace_env_list`
    - Description: Link data for processes with any specified environment variables will be traced and reported
    - Environment variable: `ENV_INPUT_EBPF_TRACE_ENV_LIST`
    - Example: `DK_BPFTRACE_SERVICE,DD_SERVICE,OTEL_SERVICE_NAME`

- `trace_name_list`
    - Description: Processes whose names are in the specified set will be traced and reported
    - Environment variable: `ENV_INPUT_EBPF_TRACE_NAME_LIST`
    - Example: `chrome,firefox`

- `conv_to_ddtrace`
    - Description: Convert all application side link IDs to decimal strings for compatibility purposes, not used unless necessary
    - Environment variable: `ENV_INPUT_EBPF_CONV_TO_DDTRACE`
    - Example: `false`

- `netlog_blacklist`
    - Description: Used to filter packets after packet capture
    - Environment variable: `ENV_INPUT_EBPF_NETLOG_BLACKLIST`
    - Example: `ip_saddr=='127.0.0.1' \|\| ip_daddr=='127.0.0.1'`

- `netlog_metric`
    - Description: Collect network metrics from network packet analysis
    - Environment variable: `ENV_INPUT_EBPF_NETLOG_METRIC`
    - Example: `true`

- `netlog_log`
    - Description: Collect network logs from network packet analysis
    - Environment variable: `ENV_INPUT_EBPF_NETLOG_LOG`
    - Example: `false`

- `cpu_limit`
    - Description: The maximum number of CPU cores used per unit time. When the upper limit is reached, the collector exits.
    - Environment variable: `ENV_INPUT_EBPF_CPU_LIMIT`
    - Example: "2.0"`

- `mem_limit`
    - Description: Memory size usage limit
    - Environment variable: `ENV_INPUT_EBPF_MEM_LIMIT`
    - Example: `"4GiB"`

- `net_limit`
    - Description: Network bandwidth (any network card) limit
    - Environment variable: `ENV_INPUT_EBPF_NET_LIMIT`
    - Example: `"100MiB/s"`

<!-- markdownlint-enable -->

### The blacklist function of the `netlog` plug-in

Filter rule example:

Single rule:

The following rules filter network data with ip `1.1.1.1` and port 80. (Line breaks allowed after operator)

```py
(ip_saddr == "1.1.1.1" || ip_saddr == "1.1.1.1") &&
      (src_port == 80 || dst_port == 80)
```

Multiple rules:

Use `;` or `\n` to separate the rules. If any rule is met, the data will be filtered.

```py
udp
ip_saddr == "1.1.1.1" && (src_port == 80 || dst_port == 80);
ip_saddr == "10.10.0.1" && (src_port == 80 || dst_port == 80)

ipnet_contains("127.0.0.0/8", ip_saddr); ipv6
```

Data available for filtering:

This filter is used to filter network data. Comparable data is as follows:

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

Operator:

Operators from highest to lowest:

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

function:

1. **ipnet_contains**

    Function signature: `fn ipnet_contains(ipnet: str, ipaddr: str) bool`

    Description: Determine whether the address is within the specified network segment

     Example:

    ```py
    ipnet_contains("127.0.0.0/8", ip_saddr)
    ```

    If the `ip_saddr` value is "127.0.0.1", then this rule returns `true` and the TCP connection packet/UDP packet will be filtered.

2. **has_prefix**

    Function signature: `fn has_prefix(s: str, prefix: str) bool`

    Description: Specifies whether the field contains a certain prefix

    Example:

    ```py
    has_prefix(k8s_src_pod, "datakit-") || has_prefix(k8s_dst_pod, "datakit-")
    ```

    This rule returns `true` if the pod name is `datakit-kfez321`.

## Metric {#metric}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.ebpf.tags]`:

``` toml
 [inputs.ebpf.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `netflow`

- tag


| Tag | Description |
|  ----  | --------|
|`direction`|Use the source as a frame of reference to identify the connection initiator. (incoming/outgoing)|
|`dst_domain`|Destination domain.|
|`dst_ip`|Destination IP address.|
|`dst_ip_type`|Destination IP type. (other/private/multicast)|
|`dst_k8s_deployment_name`|Destination K8s deployment name.|
|`dst_k8s_namespace`|Destination K8s namespace.|
|`dst_k8s_pod_name`|Destination K8s pod name.|
|`dst_k8s_service_name`|Destination K8s service name.|
|`dst_nat_ip`|For data containing the `outging` tag, this value is the ip after the DNAT operation.|
|`dst_nat_port`|For data containing the `outging` tag, this value is the port after the DNAT operation.|
|`dst_port`|Destination port.|
|`family`|Network layer protocol. (IPv4/IPv6)|
|`host`|System hostname.|
|`pid`|Process identification number.|
|`process_name`|Process name.|
|`source`|Fixed value: `netflow`.|
|`src_ip`|Source IP.|
|`src_ip_type`|Source IP type. (other/private/multicast)|
|`src_k8s_deployment_name`|Source K8s deployment name.|
|`src_k8s_namespace`|Source K8s namespace.|
|`src_k8s_pod_name`|Source K8s pod name.|
|`src_k8s_service_name`|Source K8s service name.|
|`src_port`|Source port.|
|`sub_source`|Some specific connection classifications, such as the sub_source value for Kubernetes network traffic is K8s.|
|`transport`|Transport layer protocol. (udp/tcp)|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bytes_read`|The number of bytes read.|int|B|
|`bytes_written`|The number of bytes written.|int|B|
|`retransmits`|The number of retransmissions.|int|count|
|`rtt`|TCP Latency.|int|μs|
|`rtt_var`|TCP Jitter.|int|μs|
|`tcp_closed`|The number of TCP connection closed.|int|count|
|`tcp_established`|The number of TCP connection established.|int|count|



### `dnsflow`

- tag


| Tag | Description |
|  ----  | --------|
|`direction`|Use the source as a frame of reference to identify the connection initiator. (incoming/outgoing)|
|`dst_domain`|Destination domain.|
|`dst_ip`|Destination IP address.|
|`dst_ip_type`|Destination IP type. (other/private/multicast)|
|`dst_k8s_deployment_name`|Destination K8s deployment name.|
|`dst_k8s_namespace`|Destination K8s namespace.|
|`dst_k8s_pod_name`|Destination K8s pod name.|
|`dst_k8s_service_name`|Destination K8s service name.|
|`dst_port`|Destination port.|
|`family`|Network layer protocol. (IPv4/IPv6)|
|`host`|System hostname.|
|`source`|Fixed value: `dnsflow`.|
|`src_ip`|Source IP.|
|`src_ip_type`|Source IP type. (other/private/multicast)|
|`src_k8s_deployment_name`|Source K8s deployment name.|
|`src_k8s_namespace`|Source K8s namespace.|
|`src_k8s_pod_name`|Source K8s pod name.|
|`src_k8s_service_name`|Source K8s service name.|
|`src_port`|Source port.|
|`sub_source`|Some specific connection classifications, such as the sub_source value for Kubernetes network traffic is K8s.|
|`transport`|Transport layer protocol. (udp/tcp)|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`count`|The number of DNS requests in a collection cycle.|int|-|
|`latency`|Average response time for DNS requests.|int|ns|
|`latency_max`|Maximum response time for DNS requests.|int|ns|
|`rcode`|DNS response code: 0 - `NoError`, 1 - `FormErr`, 2 - `ServFail`, 3 - NXDomain, 4 - NotImp, 5 - Refused, ...; A value of -1 means the request timed out.|int|-|



### `bash`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|host name|
|`source`|Fixed value: bash|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cmd`|Command.|string|-|
|`message`|The bash execution record generated by the collector|string|-|
|`pid`|Process identification number.|string|-|
|`user`|The user who executes the bash command.|string|-|



### `httpflow`

- tag


| Tag | Description |
|  ----  | --------|
|`direction`|Use the source as a frame of reference to identify the connection initiator. (incoming/outgoing)|
|`dst_domain`|Destination domain.|
|`dst_ip`|Destination IP address.|
|`dst_ip_type`|Destination IP type. (other/private/multicast)|
|`dst_k8s_deployment_name`|Destination K8s deployment name.|
|`dst_k8s_namespace`|Destination K8s namespace.|
|`dst_k8s_pod_name`|Destination K8s pod name.|
|`dst_k8s_service_name`|Destination K8s service name.|
|`dst_nat_ip`|For data containing the `outging` tag, this value is the ip after the DNAT operation.|
|`dst_nat_port`|For data containing the `outging` tag, this value is the port after the DNAT operation.|
|`dst_port`|Destination port.|
|`family`|Network layer protocol. (IPv4/IPv6)|
|`host`|System hostname.|
|`pid`|Process identification number.|
|`process_name`|Process name.|
|`source`|Fixed value: `httpflow`.|
|`src_ip`|Source IP.|
|`src_ip_type`|Source IP type. (other/private/multicast)|
|`src_k8s_deployment_name`|Source K8s deployment name.|
|`src_k8s_namespace`|Source K8s namespace.|
|`src_k8s_pod_name`|Source K8s pod name.|
|`src_k8s_service_name`|Source K8s service name.|
|`src_port`|Source port.|
|`sub_source`|Some specific connection classifications, such as the sub_source value for Kubernetes network traffic is K8s.|
|`transport`|Transport layer protocol. (udp/tcp)|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bytes_read`|The number of bytes read.|int|B|
|`bytes_written`|The number of bytes written.|int|B|
|`count`|The total number of HTTP requests in a collection cycle.|int|-|
|`http_version`|1.1 / 1.0 ...|string|-|
|`latency`|TTFB.|int|ns|
|`method`|GET/POST/...|string|-|
|`path`|Request path.|string|-|
|`status_code`|Http status codes.|int|-|
|`truncated`|The length of the request path has reached the upper limit of the number of bytes collected, and the request path may be truncated.|bool|-|


