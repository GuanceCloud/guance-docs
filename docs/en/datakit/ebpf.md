
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

Because the executable file of this collector is large, it is no longer packaged in DataKit since v1.2. 13, but the DataKit container image contains this collector by default; For newly installed DataKit, you need to execute the install command to install it. There are two methods:

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
    
      ## If you open the ebpf-net plug-in, you need to select:
      ##  - "httpflow" (* Open by default)
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
    # Parameter description (if * is required)
    #############################
    #  --hostname               : Host name, which can change the value of the host tag when the collector uploads data. The priority is: Specify this parameter > ENV_HOSTNAME value in datakit.conf (if not empty, automatically add this parameter at startup) > Collector gets it by itself (default value)
    #  --datakit-apiserver      : DataKit API Server address, default 0.0.0.0:9529
    #  --log                    : Log output path, default value DataKitInstallDir/externals/datakit-ebpf.log
    #  --log-level              : Log level, default info
    #  --service                : default value ebpf
    
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

-  Tag


| Tag Name | Description    |
|  ----  | --------|
|`direction`|Transmission direction (incoming/outgoing)|
|`dst_domain`|Target domain name|
|`dst_ip`|Target IP|
|`dst_ip_type`|Target IP type (other/private/multicast)|
|`dst_k8s_deployment_name`|deployment name of k8s to which the target IP belongs|
|`dst_k8s_namespace`|namespace of k8s where the target IP is located|
|`dst_k8s_pod_name`|The pod name of the k8s to which the destination IP belongs|
|`dst_k8s_service_name`|The target ip belongs to the service, and if dst_ip is cluster (service) ip, the value of dst_k8s_pod_name is `N/A`|
|`dst_port`|Destination port|
|`family`|TCP/IP Protocol family (IPv4/IPv6)|
|`host`|hostname|
|`pid`|Process number|
|`process_name`|Process name|
|`source`|fixed: netflow|
|`src_ip`|source IP|
|`src_ip_type`|source IP type (other/private/multicast)|
|`src_k8s_deployment_name`|deployment name of k8s to which the source IP belongs|
|`src_k8s_namespace`|namespace of k8s where the source IP is located|
|`src_k8s_pod_name`|The pod name of the k8s to which the source IP belongs|
|`src_k8s_service_name`|service name of k8s to which the source IP belongs|
|`src_port`|Source port, the value of temporary port after aggregation is `*`|
|`sub_source`|Some specific connection classifications for netflow, such as Kubernetes traffic, have a value of K8s|
|`transport`|Transport protocol (udp/tcp)|

- Metrics List


| Metrics | Description| Data Type | Uni t   |
| ---- |---- | :---:    | :----: |
|`bytes_read`|Number of bytes read|int|B|
|`bytes_written`|Number of bytes written|int|B|
|`retransmits`|Number of retransmissions|int|count|
|`rtt`|TCP Latency|int|μs|
|`rtt_var`|TCP Jitter|int|μs|
|`tcp_closed`|TCP Number of closures|int|count|
|`tcp_established`|TCP Number of connections established|int|count|



### `dnsflow`

-  Tag


| Tag Name | Description    |
|  ----  | --------|
|`direction`|Transmission direction (incoming/outgoing)|
|`dst_ip`|target IP|
|`dst_ip_type`|target IP type (other/private/multicast)|
|`dst_k8s_deployment_name`|deployment name of k8s to which the target IP belongs|
|`dst_k8s_namespace`|namespace of k8s where the target IP is located|
|`dst_k8s_pod_name`|the pod name of the k8s to which the destination IP belongs|
|`dst_k8s_service_name`|The target ip belongs to the service, and if dst_ip is cluster (service) ip, the value of dst_k8s_pod_name is `N/A`|
|`dst_port`|Destination port|
|`family`|TCP/IP Protocol family (IPv4/IPv6)|
|`host`|hostname|
|`source`|fixed value: dnsflow|
|`src_ip`|source IP|
|`src_ip_type`|source IP type (other/private/multicast)|
|`src_k8s_deployment_name`|deployment name of k8s to which the source IP belongs|
|`src_k8s_namespace`|namespace of k8s where the source IP is located|
|`src_k8s_pod_name`|the pod name of the k8s to which the source IP belongs|
|`src_k8s_service_name`|service name of k8s to which the source IP belongs|
|`src_port`|Source port, non-53 port aggregated value is `*`|
|`sub_source`|Some specific connection classifications for dnsflow, such as Kubernetes traffic, have a value of K8s|
|`transport`|Transport protocol (udp/tcp)|

- Metrics


| Metrics | Description| Da ta | Unit   |
| ---- |---- | :---:    | :----: |
|`count`|Total number of DNS requests aggregated in one collection cycle|int|-|
|`latency`|DNS average request response time interval|int|ns|
|`latency_max`|Response time interval for DNS maximum request|int|ns|
|`rcode`|DNS response codes: 0-NoError, 1-FormErr, 2-ServFail, 3-NXDomain, 4-NotImp, 5-Refused,...; A value of-1 indicates that the request timed out|int|-|



### `bash`

-  Tag


| Tag Name | Description    |
|  ----  | --------|
|`host`|host name|
|`source`|fixed value: bash|

- Metrics List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`cmd`|bash command|string|-|
|`message`|Single bash execution record|string|-|
|`pid`|The pid of the bash process|string|-|
|`user`|The user who executes the bash command|string|-|



### `httpflow`

-  Tag


| Tag Na me | Description    |
|  ----  | --------|
|`direction`|Transmission direction (incoming/outgoing)|
|`dst_ip`|target IP|
|`dst_ip_type`|target IP type (other/private/multicast)|
|`dst_k8s_deployment_name`|deployment name of k8s to which the target IP belongs|
|`dst_k8s_namespace`|namespace of k8s where the target IP is located|
|`dst_k8s_pod_name`|The pod name of the k8s to which the destination IP belongs|
|`dst_k8s_service_name`|The target ip belongs to the service, and if dst_ip is cluster (service) ip, the value of dst_k8s_pod_name is `N/A`|
|`dst_port`|Destination port|
|`family`|TCP/IP Protocol family (IPv4/IPv6)|
|`host`|hostname|
|`source`|fixed value: httpflow|
|`src_ip`|source IP|
|`src_ip_type`|source IP type (other/private/multicast)|
|`src_k8s_deployment_name`|deployment name of k8s to which the source IP belongs|
|`src_k8s_namespace`|namespace of k8s where the source IP is located|
|`src_k8s_pod_name`|The pod name of the k8s to which the source IP belongs|
|`src_k8s_service_name`|service name of k8s to which the source IP belongs|
|`src_port`|Source port, the value of temporary port after aggregation is `*`|
|`sub_source`|Some specific connection classifications for httpflow, such as Kubernetes traffic, have a value of K8s|
|`transport`|Transport protocol (udp/tcp)|

- Metrics List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`count`|Total number of HTTP requests aggregated in one collection cycle|int|-|
|`http_version`|1.1 / 1.0 ...|string|-|
|`latency`|ttfb|int|ns|
|`method`|GET/POST/...|string|-|
|`path`|Request path|string|-|
|`status_code`|http status codes, such as 200, 301, 404 ...|int|-|
|`truncated`|The length of the requested path reaches the upper limit of the collected bytes, and the requested path may be truncated|bool|-|


