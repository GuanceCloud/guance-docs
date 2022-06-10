
# eBPF

- DataKit 版本：1.4.0
- 文档发布日期：2022-06-10 10:51:49
- 操作系统支持：`linux/amd64,linux/arm64`

eBPF 采集器，采集主机网络 TCP、UDP 连接信息，Bash 执行日志等。本采集器主要包含 `ebpf-net` 及 `ebpf-bash` 俩类:

  * `ebpf-net`:
    * 数据类别: Network
    * 由 netflow、httpflow 和 dnsflow 构成，分别用于采集主机 TCP/UDP 连接统计信息和主机 DNS 解析信息；

  * `ebpf-bash`:
    * 数据类别: Logging
    * 采集 Bash 的执行日志，包含 Bash 进程号、用户名、执行的命令和时间等;

## 前置条件

由于该采集器的可执行文件体积较大，自 v1.2.13 起不再打包在 DataKit 中，但 DataKit 容器镜像默认包含该采集器；对于新装 DataKit，需执行安装命令进行安装，有以下两种方法：

- v1.2.13 ~ v1.2.18
  - 安装时[指定环境变量](datakit-install#f9858758)：`DK_INSTALL_EXTERNALS="datakit-ebpf"`
  - DataKit 安装完后，再手动安装 eBPF 采集器：`datakit install --datakit-ebpf`
- v1.2.19+
  - 安装时[指定环境变量](datakit-install#f9858758)：`DK_INSTALL_EXTERNALS="ebpf"`
  - DataKit 安装完后，再手动安装 eBPF 采集器：`datakit install --ebpf`

### Linux 内核版本要求

```txt
* 目前 Linux 3.10 内核的项目生命周期已经结束，建议您升级至 Linux 4.9 及以上 LTS 版内核
```

除 CentOS 7.6+ 和 Ubuntu 16.04 以外，其他发行版本需要 Linux 内核版本高于 4.0.0, 可使用命令 `uname -r` 查看，如下：

```sh
$ uname -r 
5.11.0-25-generic
```

对于 CentOS 7.6+ 和 Ubuntu 16.04 不能开启 ebpf-net 类别中的 httpflow 数据采集，由于其 Linux 3.10.x 内核不支持 eBPF 程序中的 BPF_PROG_TYPE_SOCKET_FILTER 类型

### 已启用 SELinux 的系统

对于启用了 SELinux 的系统，需要关闭其(待后续优化)，执行以下命令进行关闭:

```sh
setenforce 0
```

## 配置

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
  # or # bearer_token_string = "<your-token-string>"
  
  ## all supported plugins:
  ## - "ebpf-net"  :
  ##     contains L4-network, dns collection
  ## - "ebpf-bash" :
  ##     log bash
  ##
  enabled_plugins = [
    "ebpf-net",
  ]

  [inputs.ebpf.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"

#############################
# 参数说明(若标 * 为必选项)
#############################
#  --hostname               : 主机名，此参数可改变该采集器上传数据时 host tag 的值, 优先级为: 指定该参数 > datakit.conf 中的 ENV_HOSTNAME 值(若非空，启动时自动添加该参数) > 采集器自行获取(默认值)
#  --datakit-apiserver      : DataKit API Server 地址, 默认值 0.0.0.0:9529
#  --log                    : 日志输出路径, 默认值 DataKitInstallDir/externals/datakit-ebpf.log
#  --log-level              : 日志级别，默认 info
#  --service                : 默认值 ebpf

```

默认配置不开启 ebpf-bash，若需开启在 `enabled_plugins` 配置项中添加 `ebpf-bash`；

配置好后，重启 DataKit 即可。

### Kubernetes 安装

1. 参照通用的 [ConfigMap 安装示例](datakit-daemonset-deploy#fb919c14)。
2. 在 datakit.yaml 中的环境变量 `ENV_ENABLE_INPUTS` 中追加 `ebpf`，此时使用默认配置，即仅开启 ebpf-net 网络数据采集

```yaml
   - name: ENV_ENABLE_INPUTS
          value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ebpf

```

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.ebpf.tags]` 指定其它标签：

``` toml
 [inputs.ebpf.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `netflow`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`direction`|传输方向 (incoming/outgoing)|
|`dst_domain`|目标域名|
|`dst_ip`|目标 IP|
|`dst_ip_type`|目标 IP 类型 (other/private/multicast)|
|`dst_k8s_deployment_name`|目标 IP 所属 k8s 的 deployment name|
|`dst_k8s_namespace`|目标 IP 所在 k8s 的 namespace|
|`dst_k8s_pod_name`|目标 IP 所属 k8s 的 pod name|
|`dst_k8s_service_name`|目标 IP 所属 service, 如果是 dst_ip 是 cluster(service) ip 则 dst_k8s_pod_name 值为 `N/A`|
|`dst_port`|目标端口|
|`family`|TCP/IP 协议族 (IPv4/IPv6)|
|`host`|主机名|
|`pid`|进程号|
|`source`|固定值: netflow|
|`src_ip`|源 IP|
|`src_ip_type`|源 IP 类型 (other/private/multicast)|
|`src_k8s_deployment_name`|源 IP 所属 k8s 的 deployment name|
|`src_k8s_namespace`|源 IP 所在 k8s 的 namespace|
|`src_k8s_pod_name`|源 IP 所属 k8s 的 pod name|
|`src_k8s_service_name`|源 IP 所属 k8s 的 service name|
|`src_port`|源端口, 临时端口(32768 ~ 60999)聚合后的值为 `*`|
|`sub_source`|用于 netflow 的部分特定连接分类，如 Kubernetes 流量的值为 K8s|
|`transport`|传输协议 (udp/tcp)|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`bytes_read`|读取字节数|int|B|
|`bytes_written`|写入字节数|int|B|
|`retransmits`|重传次数|int|count|
|`rtt`|TCP Latency|int|μs|
|`rtt_var`|TCP Jitter|int|μs|
|`tcp_closed`|TCP 关闭次数|int|count|
|`tcp_established`|TCP 建立连接次数|int|count|



### `dnsflow`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`dst_ip`|DNS server address|
|`dst_port`|DNS server port|
|`family`|TCP/IP 协议族 (IPv4/IPv6)|
|`host`|host name|
|`source`|固定值: dnsflow|
|`src_ip`|DNS client address|
|`src_port`|DNS client port|
|`transport`|传输协议 (udp/tcp)|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`rcode`|DNS 响应码: 0 - NoError, 1 - FormErr, 2 - ServFail, 3 - NXDomain, 4 - NotImp, 5 - Refused, ...|int|-|
|`resp_time`|DNS 请求的响应时间间隔|int|ns|
|`timeout`|DNS 请求超时|bool|-|



### `bash`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|host name|
|`source`|固定值: bash|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`cmd`|bash 命令|string|-|
|`message`|单条 bash 执行记录|string|-|
|`pid`|bash 进程的 pid|string|-|
|`user`|执行 bash 命令的用户|string|-|



### `httpflow`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`direction`|传输方向 (incoming/outgoing)|
|`dst_ip`|目标 IP|
|`dst_ip_type`|目标 IP 类型 (other/private/multicast)|
|`dst_k8s_deployment_name`|目标 IP 所属 k8s 的 deployment name|
|`dst_k8s_namespace`|目标 IP 所在 k8s 的 namespace|
|`dst_k8s_pod_name`|目标 IP 所属 k8s 的 pod name|
|`dst_k8s_service_name`|目标 IP 所属 service, 如果是 dst_ip 是 cluster(service) ip 则 dst_k8s_pod_name 值为 `N/A`|
|`dst_port`|目标端口|
|`family`|TCP/IP 协议族 (IPv4/IPv6)|
|`host`|主机名|
|`source`|固定值: httpflow|
|`src_ip`|源 IP|
|`src_ip_type`|源 IP 类型 (other/private/multicast)|
|`src_k8s_deployment_name`|源 IP 所属 k8s 的 deployment name|
|`src_k8s_namespace`|源 IP 所在 k8s 的 namespace|
|`src_k8s_pod_name`|源 IP 所属 k8s 的 pod name|
|`src_k8s_service_name`|源 IP 所属 k8s 的 service name|
|`src_port`|源端口, 临时端口(32768 ~ 60999)聚合后的值为 `*`|
|`sub_source`|用于 httpflow 的部分特定连接分类，如 Kubernetes 流量的值为 K8s|
|`transport`|传输协议 (udp/tcp)|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`http_version`|1.1 / 1.0 ...|string|-|
|`latency`|ttfb|int|ns|
|`method`|GET/POST/...|string|-|
|`path`|请求路径|string|-|
|`status_code`|http 状态码，如 200, 301, 404 ...|int|-|


