---
title     : 'eBPF'
summary   : '通过 eBPF 采集 Linux 网络数据'
__int_icon      : 'icon/ebpf'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# eBPF
<!-- markdownlint-enable -->

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
    - 该插件实现 `ebpf-net` 的 `netflow/httpflow`

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

### `eBPF Tracing` 使用 {#ebpf-trace}

`ebpf-trace` 使用 eBPF 技术获取并解析网络数据，并对进程的内核级线程/用户级线程（如 golang goroutine 实现）进行跟踪，并生成链路 eBPF span；

如果在多个节点部署了该开启链路数据采集的 eBPF 采集器，则需要将所有 eBPF 的链路数据发往同一个开启了 [`ebpftrace`](./ebpftrace.md) 采集器插件的 DataKit。

开启该采集器需要在配置文件中进行以下设置（以下配置项不包括如何进行跟踪）：

```toml
[[inputs.ebpf]]
  enabled_plugins = [
    "ebpf-net",
    "ebpf-trace",
    # "ebpf-conntrack"
  ]

  l7net_enabled = [
    "httpflow",
    # "httpflow-tls"
  ]

  trace_server = "x.x.x.x:9529"
```

有以下几种方法对其他进程进行链路跟踪：

- 设置 `trace_all_process` 为 `true`，可以配合 `trace_name_blacklist` 或者 `trace_env_blacklist` 排除部分不希望采集的进程
- 设置 `trace_env_list` 对包含任意一个指定**环境变量**的进程进行跟踪。
- 设置 `trace_name_list` 对包含任意一个指定**进程名**的进程进行跟踪。

可通过为被采集进程注入以下任意一个环境变，来设置 span 的 service name：

- `DK_BPFTRACE_SERVICE`
- `DD_SERVICE`
- `OTEL_SERVICE_NAME`

更多配置项细节见[环境变量和配置项](./ebpf.md#input-cfg-field-env)。

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
    
      ## bpf-netlog plugin collection metric only
      ##
      # netlog_metric_only = false
      
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

| 环境变量名                            | 对应的配置参数项       | 参数示例                                           | 描述                                                                      |
| :------------------------------------ | ---------------------- | -------------------------------------------------- | ------------------------------------------------------------------------- |
| `ENV_INPUT_EBPF_ENABLED_PLUGINS`      | `enabled_plugins`      | `ebpf-net,ebpf-trace`                              | 开启 `ebpf-net` 网络跟踪功能，并在此基础上开启链路功能                    |
| `ENV_INPUT_EBPF_L7NET_ENABLED`        | `l7net_enabled`        | `httpflow`                                         | 开启 http 协议数据采集                                                    |
| `ENV_INPUT_EBPF_IPV6_DISABLED`        | `ipv6_disabled`        | `false`                                            | 系统是否不支持 IPv6                                                       |
| `ENV_INPUT_EBPF_EPHEMERAL_PORT`       | `ephemeral_port`       | `32768`                                            | 临时端口开始位置                                                          |
| `ENV_INPUT_EBPF_INTERVAL`             | `interval`             | `60s`                                              | 数据聚合周期                                                              |
| `ENV_INPUT_EBPF_TRACE_SERVER`         | `trace_server`         | `<datakit ip>:<datakit port>`                      | DataKit 的地址，需要开启 DataKit `ebpftrace` 采集器用于接收 eBPF 链路数据 |
| `ENV_INPUT_EBPF_TRACE_ALL_PROCESS`    | `trace_all_process`    | `false`                                            | 对系统内的所有进程进行跟踪                                                |
| `ENV_INPUT_EBPF_TRACE_NAME_BLACKLIST` | `trace_name_blacklist` | `datakit,datakit-ebpf`                             | 指定进程名的进程将被**禁止采集**链路数据，示例中的进程已被硬编码禁止采集  |
| `ENV_INPUT_EBPF_TRACE_ENV_BLACKLIST`  | `trace_env_blacklist`  | `datakit,datakit-ebpf`                             | 包含任意一个指定环境变量名的进程将被**禁止采集**链路数据                  |
| `ENV_INPUT_EBPF_TRACE_ENV_LIST`       | `trace_env_list`       | `DK_BPFTRACE_SERVICE,DD_SERVICE,OTEL_SERVICE_NAME` | 含有任意指定环境变量的进程的链路数据将被跟踪和上报                        |
| `ENV_INPUT_EBPF_TRACE_NAME_LIST`      | `trace_name_list`      | `chrome,firefox`                                   | 进程名在指定集合内的的进程将被跟踪和上报                                  |
| `ENV_INPUT_EBPF_CONV_TO_DDTRACE`      | `conv_to_ddtrace`      | `false`                                            | 将所有的应用侧链路 id 转换为 10 进制表示的字符串，兼容用途，非必要不使用  |
| `ENV_NETLOG_BLACKLIST`                | `netlog_blacklist`     | `ip_saddr=='127.0.0.1' \|\| ip_daddr=='127.0.0.1'` | 用于实现在抓包之后的数据包的过滤                                          |
| `ENV_NETLOG_METRIC_ONLY`              | `netlog_metric_only`   | `false`                                            | 除了网络流数据外，同时开启网络日志功能                                    |

<!-- markdownlint-enable -->

### `netlog` 插件的黑名单功能

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

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.ebpf.tags]` 指定其它标签：

``` toml
 [inputs.ebpf.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `netflow`

- 标签


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

- 指标列表


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

- 标签


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

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`count`|The number of DNS requests in a collection cycle.|int|-|
|`latency`|Average response time for DNS requests.|int|ns|
|`latency_max`|Maximum response time for DNS requests.|int|ns|
|`rcode`|DNS response code: 0 - `NoError`, 1 - `FormErr`, 2 - `ServFail`, 3 - NXDomain, 4 - NotImp, 5 - Refused, ...; A value of -1 means the request timed out.|int|-|



### `bash`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|host name|
|`source`|Fixed value: bash|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cmd`|Command.|string|-|
|`message`|The bash execution record generated by the collector|string|-|
|`pid`|Process identification number.|string|-|
|`user`|The user who executes the bash command.|string|-|



### `httpflow`

- 标签


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

- 指标列表


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


