
# eBPF
---

:fontawesome-brands-linux: :material-kubernetes:

---

eBPF collector, collecting host network TCP, UDP connection information, Bash execution log, etc. This collector mainly includes `ebpf-net`, `ebpf-conntrack` and `ebpf-bash` three plugins:

* `ebpf-net`:
    * Data category: Network
    * It is composed of netflow, httpflow and dnsflow, which are used to collect host TCP/UDP connection statistics and host DNS resolution information respectively;

* `ebpf-bash`:

    * Data category: Logging
    * Collect Bash execution log, including Bash process number, user name, executed command and time, etc.;

* `ebpf-conntrack`: [:octicons-tag-24: Version-1.8.0](../datakit/changelog.md#cl-1.8.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)
    * Add two tags `dst_nat_ip` and `dst_nat_port` to the network flow data.


- `ebpf-trace`:
    - Application call relationship tracking.

## Preconditions {#requirements}

For DataKit before v1.5.6, you need to execute the installation command to install:

- v1.2.13 ~ v1.2.18
  - Install time [specify environment variable](datakit-install.md#extra-envs)：`DK_INSTALL_EXTERNALS="datakit-ebpf"`
  - After the DataKit is installed, manually install the eBPF collector: `datakit install --datakit-ebpf`
- v1.2.19+
  - [specify environment variable](datakit-install.md#extra-envs)：`DK_INSTALL_EXTERNALS="ebpf"` when installing
  - After the DataKit is installed, manually install the eBPF collector: `datakit install --ebpf`
- v1.5.6+
  - No manual installation required

When deploying in Kubernetes environment, you must mount the host's' `/sys/kernel/debug` directory into pod, refer to the latest datakit.yaml;

### HTTPS Support {#https}

[:octicons-tag-24: Version-1.4.6](../datakit/changelog.md#cl-1.4.6) ·
[:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

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

In addition to CentOS 7.6+ and Ubuntu 16.04, other distributions recommend that the Linux kernel version is higher than 4.9, otherwise the ebpf collector may not start.

If you want to enable the  *ebpf-conntrack*  plugin, usually requires a higher kernel version, such as v5.4.0 etc., please confirm whether the symbols in the kernel contain `nf_ct_delete` and `__nf_conntrack_hash_insert`, you can execute the following command to view:

```sh
cat /proc/kallsyms | awk '{print $3}' | grep "^nf_ct_delete$\|^__nf_conntrack_hash_insert$"
```

???+ warning "kernel restrictions"

    When the DataKit version is lower than **v1.5.2**, the httpflow data collection in the ebpf-net category cannot be enabled for CentOS 7.6+, because its Linux 3.10.x kernel does not support the BPF_PROG_TYPE_SOCKET_FILTER type in the eBPF program;

    When the DataKit version is lower than **v1.5.2**, because BPF_FUNC_skb_load_bytes does not exist in Linux Kernel <= 4.4, if you want to enable httpflow, you need Linux Kernel >= 4.5, and this problem will be further optimized;

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
    
    The default configuration does not turn on ebpf-bash. If you need to turn on, add `ebpf-bash` in the `enabled_plugins` configuration item;
    
    After configuration, restart DataKit.

=== "Kubernetes"

    In Kubernetes, collection can be started by ConfigMap or directly enabling ebpf collector by default:
    
    1. Refer to the generic [Installation Sample](../datakit/datakit-daemonset-deploy.md#configmap-setting) for the ConfigMap mode.
    2. Append `ebpf` to the environment variable `ENV_ENABLE_INPUTS` in datakit.yaml, using the default configuration, which only turns on ebpf-net network data collection.
    
    ```yaml
    - name: ENV_ENABLE_INPUTS
           value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ebpf
    ```
    
    The ebpf collection configuration in Kubernetes can be adjusted by the following environment variables:
    
    | Environment Variable Name                                    | Corresponding Configuration Parameter Item                 | Parameter Example                    |
    | :---                                        | ---                           | ---                        |
    | `ENV_INPUT_EBPF_ENABLED_PLUGINS`            | `enabled_plugins`             | `ebpf-net,ebpf-bash,ebpf-conntrack`       |
    | `ENV_INPUT_EBPF_L7NET_ENABLED`              | `l7net_enabled`               | `httpflow,httpflow-tls`    |
    | `ENV_INPUT_EBPF_IPV6_DISABLED`              | `ipv6_disabled`               | `false/true`               |
    | `ENV_INPUT_EBPF_EPHEMERAL_PORT`             | `ephemeral_port`              | `32768`                    |
    | `ENV_INPUT_EBPF_INTERVAL`                   | `interval`                    | `60s`                      |
    | `ENV_INPUT_EBPF_TRACE_SERVER`               | `trace_server`                | `x.x.x.x:zzz`              |
    | `ENV_INPUT_EBPF_CONV_TO_DDTRACE`            | `conv_to_ddtrace`             | `false`                    |

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


