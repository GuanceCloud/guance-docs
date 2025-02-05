---
title     : 'eBPF'
summary   : '通过 eBPF 采集 Linux 网络数据'
tags:
  - 'EBPF'
  - 'NETWORK'
__int_icon      : 'icon/ebpf'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

:fontawesome-brands-linux: :material-kubernetes:

---

eBPF 采集器，采集主机网络 TCP、UDP 连接信息，Bash 执行日志等。采集器包含以下几个插件：

- `ebpf-net`:
    - 数据类别： `Network`
    - 由 `netflow/httpflow/dnsflow` 构成，分别用于采集主机 TCP/UDP 连接统计信息，HTTP 请求信息和主机 DNS 解析信息；

- `ebpf-bash`:
    - 数据类别： `Logging`
    - 采集 Bash 的执行日志，包含 Bash 进程号、用户名、执行的命令和时间等；

- `ebpf-conntrack`: [:octicons-tag-24: Version-1.8.0](../datakit/changelog.md#cl-1.8.0)
    - 往网络流数据上添加两个标签 `dst_nat_ip` 和 `dst_nat_port`，记录经 `DNAT` 后的目标 ip 和 port；当内核加载 `nf_conntrack` 时可选择开启该插件；

- `ebpf-trace`: [:octicons-tag-24: Version-1.17.0](../datakit/changelog.md#cl-1.17.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)
    - 数据类别： `Tracing`
    - 用于跟踪应用网络请求调用关系，基于 `ebpf-net` 的 `httpflow` 数据和 eBPF 探针实现；

- `bpf-netlog`:
    - 数据类别： `Logging`, `Network`
    - 该插件实现网络日志 `bpf_net_l4_log/bpf_net_l7_log`   采集，也可以在内核不支持 eBPF 的情况下替代 `ebpf-net` 的 `netflow/httpflow` 数据采集；

## 配置 {#config}

### 前置条件 {#requirements}

在 Kubernetes 环境下部署时，需要将以下目录挂在到容器中：

- `/sys/kernel/debug`
- 将主机的 `/` 目录挂载为容器的 `/rootfs` 目录，并设置环境变量 `HOST_ROOT="/rootfs"` 和 `HOST_PROC="/rootfs/proc"`

可参考 *datakit.yaml*；

如果为低于 v1.5.6 版本的 Datakit ，则需手动安装 `datakit-ebpf` 外部采集器。

### Linux 内核版本要求 {#kernel}

目前 Linux 3.10 内核的项目生命周期已经结束，建议您升级至 Linux 4.9 及以上 LTS 版内核。

除 CentOS 7.6+ 和 Ubuntu 16.04 以外，其他发行版本推荐 Linux 内核版本高于 4.9，否则可能无法启动 eBPF 采集器。

若 Linux 内核版本低于 4.4 时可能无法开启 `ebpf-trace` 插件。

如果要启用 *ebpf-conntrack* ，请确认内核中的符号是否包含 `nf_ct_delete` 和 `__nf_conntrack_hash_insert`，可执行以下命令查看：

```sh
cat /proc/kallsyms | awk '{print $3}' | grep "^nf_ct_delete$\|^__nf_conntrack_hash_insert$"
```

或内核是否加载 `nf_conntrack` 模块：

```sh
lsmod | grep nf_conntrack
```

### 已启用 SELinux 的系统 {#selinux}

对于启用了 SELinux 的系统，无法开启 eBPF 采集器，需要关闭其，执行以下命令进行关闭：

```shell
setenforce 0
```

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `ebpf.conf.sample` 并命名为 `ebpf.conf`。示例如下：
    
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
    
    配置好后，重启 DataKit 即可。

=== "Kubernetes"

    Kubernetes 中可以通过 ConfigMap 或者直接默认启用 eBPF 采集器两种方式来开启采集：

    1. ConfigMap 方式参照通用的[安装示例](../datakit/datakit-daemonset-deploy.md#configmap-setting)。
    2. 在 *datakit.yaml* 中的环境变量 `ENV_ENABLE_INPUTS` 中追加 `ebpf`，此时使用默认配置，即仅开启 `ebpf-net` 网络数据采集
    
    ```yaml
    - name: ENV_ENABLE_INPUTS
           value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ebpf
    ```

### 环境变量与配置项 {#input-cfg-field-env}

通过以下环境变量可以调整 Kubernetes 中 eBPF 采集配置：

配置项：

- `enabled_plugins`:
    - 描述：用于配置开启采集器的内置插件
    - 环境变量：`ENV_INPUT_EBPF_ENABLED_PLUGINS`
    - 示例：`ebpf-net,ebpf-trace`

- `l7net_enabled`
    - 描述：开启 http 协议数据采集
    - 环境变量：`ENV_INPUT_EBPF_L7NET_ENABLED`
    - 示例：`httpflow`

- `interval`
    - 描述：设置采样时间间隔
    - 环境变量：`ENV_INPUT_EBPF_INTERVAL`
    - 示例：`1m30s`

- `ipv6_disabled`
    - 描述：系统是否不支持 IPv6
    - 环境变量：`ENV_INPUT_EBPF_IPV6_DISABLED`
    - 示例：`false`

- `ephemeral_port`
    - 描述：临时端口开始位置
    - 环境变量：`ENV_INPUT_EBPF_EPHEMERAL_PORT`
    - 示例：`32768`

- `pprof_host`
    - 描述：pprof host
    - 环境变量：`ENV_INPUT_EBPF_PPROF_HOST`
    - 示例：`127.0.0.1`

- `pprof_port`
    - 描述：pprof port
    - 环境变量：`ENV_INPUT_EBPF_PPROF_PORT`
    - 示例：`6061`

<!-- - `interval`
    - 描述：数据聚合周期
    - 环境变量：`ENV_INPUT_EBPF_INTERVAL`
    - 示例：`60s` -->

- `trace_server`
    - 描述：开启 `ebpftrace` 采集器的 DataKit ELinker/ Datakit 的地址
    - 环境变量：`ENV_INPUT_EBPF_TRACE_SERVER`
    - 示例：`<ip>:<port>`

- `trace_all_process`
    - 描述：对系统内的所有进程进行跟踪
    - 环境变量：`ENV_INPUT_EBPF_TRACE_ALL_PROCESS`
    - 示例：`false`

- `trace_name_blacklist`
    - 描述：指定进程名的进程将被禁止采集链路数据
    - 环境变量：`ENV_INPUT_EBPF_TRACE_NAME_BLACKLIST`
    - 示例：

- `trace_env_blacklist`
    - 描述：包含任意一个指定环境变量名的进程将被禁止采集链路数据
    - 环境变量：`ENV_INPUT_EBPF_TRACE_ENV_BLACKLIST`
    - 示例：`DKE_DISABLE_ETRACE`

- `trace_env_list`
    - 描述：含有任意指定环境变量的进程的链路数据将被跟踪和上报
    - 环境变量：`ENV_INPUT_EBPF_TRACE_ENV_LIST`
    - 示例：`DK_BPFTRACE_SERVICE,DD_SERVICE,OTEL_SERVICE_NAME`

- `trace_name_list`
    - 描述：进程名在指定集合内的的进程将被跟踪和上报
    - 环境变量：`ENV_INPUT_EBPF_TRACE_NAME_LIST`
    - 示例：`chrome,firefox`

- `conv_to_ddtrace`
    - 描述：将所有的应用侧链路 id 转换为 10 进制表示的字符串，兼容用途，非必要不使用
    - 环境变量：`ENV_INPUT_EBPF_CONV_TO_DDTRACE`
    - 示例：`false`

- `netlog_blacklist`
    - 描述：用于实现在抓包之后的数据包的过滤
    - 环境变量：`ENV_INPUT_EBPF_NETLOG_BLACKLIST`
    - 示例：`ip_saddr=='127.0.0.1' \|\| ip_daddr=='127.0.0.1'`

- `netlog_metric`
    - 描述：从网络数据包分析采集网络指标
    - 环境变量：`ENV_INPUT_EBPF_NETLOG_METRIC`
    - 示例：`true`

- `netlog_log`
    - 描述：从网络数据包分析采集网络日志
    - 环境变量：`ENV_INPUT_EBPF_NETLOG_LOG`
    - 示例：`false`

- `cpu_limit`
    - 描述：单位时间内 CPU 最大核心数使用限制，到达上限，采集器退出
    - 环境变量：`ENV_INPUT_EBPF_CPU_LIMIT`
    - 示例："2.0"`

- `mem_limit`
    - 描述：内存大小使用限制
    - 环境变量：`ENV_INPUT_EBPF_MEM_LIMIT`
    - 示例：`"4GiB"`

- `net_limit`
    - 描述：网络带宽（任意网卡）限制
    - 环境变量：`ENV_INPUT_EBPF_NET_LIMIT`
    - 示例：`"100MiB/s"`

- `sampling_rate`
    - 描述：设置 eBPF 采集器上报数据时的采样率，范围 `0.01 ~ 1.00`；与设置 `samping_rate_pts_per_min` 互斥
    - 环境变量：`ENV_INPUT_EBPF_SAMPLING_RATE`
    - 示例：`0.50`

- `samping_rate_pts_per_min`
    - 描述：设置 eBPF 采集器上报数据时的每分钟数据量阈值，动态调整采样率
    - 环境变量：`ENV_INPUT_EBPF_SAMPLING_RATE_PTSPERMIN`
    - 示例：`1500`

<!-- markdownlint-enable -->

## eBPF 链路功能 {#ebpf-tracing}

`ebpf-trace` 采集分析主机上的进程读写的网络数据，并对进程的内核级线程/用户级线程（如 golang goroutine）进行跟踪，生成链路 eBPF Span 该数据需要被 `ebpftrace` 采集进行进一步的加工处理。

使用时，需要在多个节点部署了该开启链路数据采集的 eBPF 采集器，则需要将所有 eBPF Span 数据发往同一个开启了 [`ebpftrace`](./ebpftrace.md#ebpftrace-config) 采集器插件的 DataKit ELinker/DataKit。更多配置细节见 [eBPF 链路文档](./ebpftrace.md#ebpf-config)

## `bpf-netlog` 插件的黑名单功能 {#blacklist}

过滤器规则示例：

单条规则：

以下规则过滤 ip 为 `1.1.1.1` 且端口为 80 的网络数据。(运算符后允许换行)

```py
(ip_saddr == "1.1.1.1" || ip_saddr == "1.1.1.1") &&
     (src_port == 80 || dst_port == 80)
```

多条规则：

规则间使用 `;` 或 `\n` 分隔，满足任意一条规则就进行数据过滤

```py
udp
ip_saddr == "1.1.1.1" && (src_port == 80 || dst_port == 80);
ip_saddr == "10.10.0.1" && (src_port == 80 || dst_port == 80)

ipnet_contains("127.0.0.0/8", ip_saddr); ipv6
```

可用于过滤的数据：

该过滤器用于对网络数据进行过滤，可比较的数据如下：

| key 名        | 类型 | 描述                                     |
| ------------- | ---- | ---------------------------------------- |
| `tcp`         | bool | 是否为 `TCP` 协议                        |
| `udp`         | bool | 是否为 `UDP` 协议                        |
| `ipv4`        | bool | 是否为 `IPv4` 协议                       |
| `ipv6`        | bool | 是否为 `IPv6` 协议                       |
| `src_port`    | int  | 源端口（以被观测网卡/主机/容器为参考系） |
| `dst_port`    | int  | 目标端口                                 |
| `ip_saddr`    | str  | 源 `IPv4` 网络地址                       |
| `ip_saddr`    | str  | 目标 `IPv4` 网络地址                     |
| `ip6_saddr`   | str  | 源 `IPv6` 网络地址                       |
| `ip6_daddr`   | str  | 目标 `IPv6` 网络地址                     |
| `k8s_src_pod` | str  | 源 `pod` 名                              |
| `k8s_dst_pod` | str  | 目标 `pod` 名                            |

运算符：

运算符从高往低：

| 优先级 | Op     | 名称               | 结合方向 |
| ------ | ------ | ------------------ | -------- |
| 1      | `()`   | 圆括号             | 左       |
| 2      | `！`   | 逻辑非，一元运算符 | 右       |
| 3      | `!=`   | 不等于             | 左       |
| 3      | `>=`   | 大于等于           | 左       |
| 3      | `>`    | 大于               | 左       |
| 3      | `==`   | 等于               | 左       |
| 3      | `<=`   | 小于等于           | 左       |
| 3      | `<`    | 小于               | 左       |
| 4      | `&&`   | 逻辑与             | 左       |
| 4      | `\|\|` | 逻辑或             | 左       |

函数：

1. **ipnet_contains**

    函数签名： `fn ipnet_contains(ipnet: str, ipaddr: str) bool`

    描述： 判断地址是否在指定的网段内

    示例：

    ```py
    ipnet_contains("127.0.0.0/8", ip_saddr)
    ```

    如果 `ip_saddr` 值为 "127.0.0.1"，则该规则返回 `true`，该 TCP 连接数据包/ UDP 数据包将被过滤。

2. **has_prefix**

    函数签名： `fn has_prefix(s: str, prefix: str) bool`

    描述： 指定字段是否包含某一前缀

    示例：

    ```py
    has_prefix(k8s_src_pod, "datakit-") || has_prefix(k8s_dst_pod, "datakit-")
    ```

    如果 pod 名为 `datakit-kfez321`，该规则返回 `true`。

## 网络聚合数据 {#network}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.ebpf.tags]` 指定其它标签：

``` toml
 [inputs.ebpf.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```





### `netflow`

- 标签列表


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

- 字段列表


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

- 标签列表


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

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`count`|The number of DNS requests in a collection cycle|int|-|
|`latency`|Average response time for DNS requests|int|ns|
|`latency_max`|Maximum response time for DNS requests|int|ns|
|`rcode`|DNS response code: 0 - `NoError`, 1 - `FormErr`, 2 - `ServFail`, 3 - NXDomain, 4 - NotImp, 5 - Refused, ...; A value of -1 means the request timed out|int|-|










### `httpflow`

- 标签列表


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

- 字段列表


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
















## 日志 {#logging}













### `bash`

- 标签列表


| Tag | Description |
|  ----  | --------|
|`host`|host name|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cmd`|Command|string|-|
|`message`|The bash execution record generated by the collector|string|-|
|`pid`|Process identification number|string|-|
|`user`|The user who executes the bash command|string|-|










### `bpf_net_l4_log`

- 标签列表


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

- 字段列表


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

- 标签列表


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

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`http_method`|HTTP method|string|-|
|`http_path`|HTTP path|string|-|
|`http_status_code`|HTTP status code|int|-|
|`rx_seq`|The tcp sequence number of the request/response first byte received by the network interface|int|-|
|`tx_seq`|The tcp sequence number of the request/response first byte sent by the network interface|int|-|








## 链路 {#tracing}





























### `dketrace`

- 标签列表


| Tag | Description |
|  ----  | --------|
|`dst_ip`|Destination IP address|
|`dst_port`|Destination port|
|`host`|System hostname|
|`service`|Service name|
|`src_ip`|Source IP|
|`src_port`|Source port|

- 字段列表


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
|`trace_id`|APM trace id, can choose between existing app trace id and ebpf generation,set by the `ebpftrace` collector|string|-|



