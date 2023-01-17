
# eBPF
---

:fontawesome-brands-linux: :material-kubernetes:

---

eBPF collector, collecting host network TCP, UDP connection information, Bash execution log, etc. This collector mainly includes `ebpf-net` and `ebpf-bash` classes:

* `ebpf-net`:
    * Data category: Network
    * It is composed of netflow, httpflow and dnsflow, which are used to collect host TCP/UDP connection statistics and host DNS resolution information respectively;

* `ebpf-bash`:

    * Data category: Logging
    * Collect Bash execution log, including Bash process number, user name, executed command and time, etc.;

## Preconditions {#requirements}

As the executable file of this collector is large, it is no longer packaged in DataKit since v1.2. 13, but the DataKit container image contains this collector by default; For newly installed DataKit, you need to execute the install command to install it. There are two methods:

- v1.2.13 ~ v1.2.18
  - Install time [specify environment variable](datakit-install.md#extra-envs)：`DK_INSTALL_EXTERNALS="datakit-ebpf"`
  - After the DataKit is installed, manually install the eBPF collector: `datakit install --datakit-ebpf`
- v1.2.19+
  - [specify environment variable](datakit-install.md#extra-envs)：`DK_INSTALL_EXTERNALS="ebpf"` when installing
  - After the DataKit is installed, manually install the eBPF collector: `datakit install --ebpf`

When deploying in Kubernetes environment, you must mount the host's' `/sys/kernel/debug` directory into pod, refer to the latest datakit.yaml;

### HTTPS Support {#https}

[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) ·
[:octicons-beaker-24: Experimental](index.md#experimental)

If ebpf-net is required to start https request data collection support for processes in the container, you need to mount the overlay directory to the container.

datakit.yaml reference changes:

=== "Docker"

    ```yaml
    ...
            volumeMounts:
            - mountPath: /var/lib/docker/overlay2/
              name: vol-docker-overlay
              readOnly: true
    ...
          volumes:
          - hostPath:
              path: /var/lib/docker/overlay2/
              type: ""
            name: vol-docker-overlay
    ```

=== "Containerd"

    ```yaml
            volumeMounts:
            - mountPath: /run/containerd/io.containerd.runtime.v2.task/
              name: vol-containerd-overlay
              readOnly: true
    ...
          volumes:
          - hostPath:
              path: /run/containerd/io.containerd.runtime.v2.task/
              type: ""
            name: vol-containerd-overlay
    ```

You can view the overlay mount point through `cat /proc/mounts`

### Linux Kernel Version Requirement {#kernel}

Now that the project life cycle of the Linux 3.10 kernel is over, it is recommended that you upgrade to the Linux 4.9 and above LTS kernel.

With the exception of CentOS 7.6 + and Ubuntu 16.04, other distributions require a Linux kernel version higher than 4.0. 0, which can be viewed using the command `uname -r`, as follows:

```shell
uname -r 
5.11.0-25-generic
```

???+ warning "kernel restrictions"

    For CentOS 7.6 + and Ubuntu 16.04, httpflow data collection in the eBPF-net class cannot be turned on because its Linux 3.10. x kernel does not support the BPF_PROG_TYPE_SOCKET_FILTER type in the eBPF program;
    
    Because BPF_FUNC_skb_load_bytes does not exist in Linux Kernel <= 4.4, if httpflow needs to be turned on, Linux Kernel >= 4.5, which needs to be optimized later.

### SELinux-enabled System {#selinux}

For SELinux-enabled systems, you need to shut them down (pending subsequent optimization), and execute the following command to shut them down:

```sh
setenforce 0
```

## Configuation {#config}

=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `ebpf.conf.sample` and name it `ebpf.conf`. Examples are as follows:
    
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
      ##     contains L4-network(netflow), L7-network(httpflow, dnsflow) collection
      ## - "ebpf-bash" :
      ##     log bash
      ##
      enabled_plugins = [
        "ebpf-net",
      ]
    
      ## 若开启 ebpf-net 插件，需选配: 
      ##  - "httpflow" (* 默认开启)
      ##  - "httpflow-tls"
      ##
      l7net_enabled = [
        "httpflow",
        # "httpflow-tls"
      ]
    
      ## if the system does not enable ipv6, it needs to be changed to true
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
    # 参数说明(若标 * 为必选项)
    #############################
    #  --hostname               : 主机名，此参数可改变该采集器上传数据时 host tag 的值, 优先级为: 指定该参数 > datakit.conf 中的 ENV_HOSTNAME 值(若非空，启动时自动添加该参数) > 采集器自行获取(默认值)
    #  --datakit-apiserver      : DataKit API Server 地址, 默认值 0.0.0.0:9529
    #  --log                    : 日志输出路径, 默认值 DataKitInstallDir/externals/datakit-ebpf.log
    #  --log-level              : 日志级别，默认 info
    #  --service                : 默认值 ebpf
    
    ```
    
    The default configuration does not turn on ebpf-bash. If you need to turn on, add `ebpf-bash` in the `enabled_plugins` configuration item;
    
    After configuration, restart DataKit.

=== "Kubernetes"

    In Kubernetes, collection can be started by ConfigMap or directly enabling ebpf collector by default:
    
    1. Refer to the generic [Installation Sample](datakit-daemonset-deploy.md#configmap-setting) for the ConfigMap mode.
    2. Append `ebpf` to the environment variable `ENV_ENABLE_INPUTS` in datakit.yaml, using the default configuration, which only turns on ebpf-net network data collection.
    
    ```yaml
    - name: ENV_ENABLE_INPUTS
           value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ebpf
    ```
    
    The ebpf collection configuration in Kubernetes can be adjusted by the following environment variables:
    
    | Environment Variable Name                                    | Corresponding Configuration Parameter Item                 | Parameter Example                    |
    | :---                                        | ---                           | ---                        |
    | `ENV_INPUT_EBPF_ENABLED_PLUGINS`            | `enabled_plugins`             | `ebpf-net,ebpf-bash`       |
    | `ENV_INPUT_EBPF_L7NET_ENABLED`              | `l7net_enabled`               | `httpflow,httpflow-tls`    |
    | `ENV_INPUT_EBPF_IPV6_DISABLED`              | `ipv6_disabled`               | `false/true`               |
    | `ENV_INPUT_EBPF_EPHEMERAL_PORT`             | `ephemeral_port`              | `32768`                    |
    | `ENV_INPUT_EBPF_INTERVAL`                   | `interval`                    | `60s`                      |


## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.ebpf.tags]`:

``` toml
 [inputs.ebpf.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `netflow`

- tag


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
|`process_name`|进程名|
|`source`|固定值: netflow|
|`src_ip`|源 IP|
|`src_ip_type`|源 IP 类型 (other/private/multicast)|
|`src_k8s_deployment_name`|源 IP 所属 k8s 的 deployment name|
|`src_k8s_namespace`|源 IP 所在 k8s 的 namespace|
|`src_k8s_pod_name`|源 IP 所属 k8s 的 pod name|
|`src_k8s_service_name`|源 IP 所属 k8s 的 service name|
|`src_port`|源端口, 临时端口聚合后的值为 `*`|
|`sub_source`|用于 netflow 的部分特定连接分类，如 Kubernetes 流量的值为 K8s|
|`transport`|传输协议 (udp/tcp)|

- metric list


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

- tag


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
|`source`|固定值: dnsflow|
|`src_ip`|源 IP|
|`src_ip_type`|源 IP 类型 (other/private/multicast)|
|`src_k8s_deployment_name`|源 IP 所属 k8s 的 deployment name|
|`src_k8s_namespace`|源 IP 所在 k8s 的 namespace|
|`src_k8s_pod_name`|源 IP 所属 k8s 的 pod name|
|`src_k8s_service_name`|源 IP 所属 k8s 的 service name|
|`src_port`|源端口, 非 53 端口聚合后的值为 `*`|
|`sub_source`|用于 dnsflow 的部分特定连接分类，如 Kubernetes 流量的值为 K8s|
|`transport`|传输协议 (udp/tcp)|

- metric list


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`count`|一个采集周期内的 DNS 请求数聚合总数|int|-|
|`latency`|DNS 平均请求的响应时间间隔|int|ns|
|`latency_max`|DNS 最大请求的响应时间间隔|int|ns|
|`rcode`|DNS 响应码: 0 - NoError, 1 - FormErr, 2 - ServFail, 3 - NXDomain, 4 - NotImp, 5 - Refused, ...；值为 -1 表示请求超时|int|-|



### `bash`

- tag


| 标签名 | 描述    |
|  ----  | --------|
|`host`|host name|
|`source`|固定值: bash|

- metric list


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`cmd`|bash 命令|string|-|
|`message`|单条 bash 执行记录|string|-|
|`pid`|bash 进程的 pid|string|-|
|`user`|执行 bash 命令的用户|string|-|



### `httpflow`

- tag


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
|`pid`|进程号|
|`process_name`|进程名|
|`source`|固定值: httpflow|
|`src_ip`|源 IP|
|`src_ip_type`|源 IP 类型 (other/private/multicast)|
|`src_k8s_deployment_name`|源 IP 所属 k8s 的 deployment name|
|`src_k8s_namespace`|源 IP 所在 k8s 的 namespace|
|`src_k8s_pod_name`|源 IP 所属 k8s 的 pod name|
|`src_k8s_service_name`|源 IP 所属 k8s 的 service name|
|`src_port`|源端口, 临时端口聚合后的值为 `*`|
|`sub_source`|用于 httpflow 的部分特定连接分类，如 Kubernetes 流量的值为 K8s|
|`transport`|传输协议 (udp/tcp)|

- metric list


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`count`|一个采集周期内的 HTTP 请求数聚合总数|int|-|
|`http_version`|1.1 / 1.0 ...|string|-|
|`latency`|ttfb|int|ns|
|`method`|GET/POST/...|string|-|
|`path`|请求路径|string|-|
|`status_code`|http 状态码，如 200, 301, 404 ...|int|-|
|`truncated`|请求路径长度达到采集的字节上限，请求路径存在截断可能|bool|-|


