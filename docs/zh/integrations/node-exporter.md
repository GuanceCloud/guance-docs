---
title     : 'Node Exporter'
summary   : '通过 Node Exporter 采集主机指标信息'
__int_icon: 'icon/node_exporter'
dashboard :
  - desc  : 'Node Exporter'
    path  : 'dashboard/zh/node_exporter'
monitor   :
  - desc  : 'Node Exporter'
    path  : 'monitor/zh/node_exporter'
---

<!-- markdownlint-disable MD025 -->
# Node Exporter
<!-- markdownlint-enable -->

本文介绍在主机部署Node Exporter组件，采集主机指标并通过Datakit进行收集、存储，最后通过{{{ custom_key.brand_name }}}用于数据的可视化展示。
Node Exporter能够收集包括主机的 CPU 使用率、内存使用情况、磁盘 I/O、网络流量等在内的多种系统运行指标。

## 配置 {#config}

### 前置条件 {#requirement}

- [x] 已安装 datakit

### 通过Node-Exporter采集主机指标数据

- 创建DaemonSet配置文件`node-exporter.yaml`

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-exporter
  namespace: monitor-sa
  labels:
    name: node-exporter
spec:
  selector:
    matchLabels:
     name: node-exporter
  template:
    metadata:
      labels:
        name: node-exporter
    spec:
      hostPID: true        # 使用主机的PID
      hostIPC: true        # 使用主机的IPC
      hostNetwork: true    # 使用主机的网络
      containers:
      - name: node-exporter
        image: quay.io/prometheus/node-exporter:v1.8.2
        ports:
        - containerPort: 9100
        resources:
          requests:
            cpu: 0.15
        securityContext:
          privileged: true
        args:
        - --path.procfs
        - /host/proc
        - --path.sysfs
        - /host/sys
        - --collector.filesystem.ignored-mount-points
        - '"^/(sys|proc|dev|host|etc)($|/)"'
        volumeMounts:
        - name: dev
          mountPath: /host/dev
        - name: proc
          mountPath: /host/proc
        - name: sys
          mountPath: /host/sys
        - name: rootfs
          mountPath: /rootfs
      tolerations:
      - key: "node-role.kubernetes.io/master"
        operator: "Exists"
        effect: "NoSchedule"
      volumes:
        - name: proc
          hostPath:
            path: /proc
        - name: dev
          hostPath:
            path: /dev
        - name: sys
          hostPath:
            path: /sys
        - name: rootfs
          hostPath:
            path: /

---

apiVersion: v1
kind: Service
metadata:
  name: node-exporter
  namespace: monitor-sa
spec:
  type: ClusterIP
  ports:
  - name: http
    port: 9100
    protocol: TCP
    targetPort: 31672
  selector:
    name: node-exporter
        
```

执行

```shell
kubectl create ns monitor-sa
kubectl apply -f node-exporter.yaml
```

通过`http://主机ip:31672/metrics` 查看当前主机获取到的所有监控数据.

### 配置Datakit

- 在`datakit.yaml` 文件中的 `ConfigMap` 资源中添加 `kubernetesprometheus.conf`
  
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    kubernetesprometheus.conf: |-
      [inputs.kubernetesprometheus]
        node_local = true  # 是否开启 NodeLocal 模式，将采集分散到各个节点
        [[inputs.kubernetesprometheus.instances]]
            role       = "service"     # 必填 可以配置为 service、pod、endpoints、node
            namespaces = ["monitor-sa"]    # 非必填，支持配置多个，以逗号隔开，为空会匹配所有
            selector   = ""       # 非必填，被采集资源的labels，用来匹配选择需要采集的对象 ，为空会匹配所有

            scrape     = "true"            # 非必需 采集开关，默认true，
            scheme     = "http" 
            port       = "__kubernetes_service_port_%s_port " 
            path       = "/metrics"        # 非必填 大部分prometheus采集路径都为/metrics，具体以被采集服务实际指标地址为准
            params     = ""                # 非必填 http 访问参数，是一个字符串，例如 name=nginx&package=middleware，非必需
            interval   = "30s"             # 非必填 采集频率，默认30s

            [inputs.kubernetesprometheus.instances.custom]
              measurement        = "kube_nodeexporter"       #非必填 {{{ custom_key.brand_name }}}指标名，默认使用指标下划线第一个字母
              job_as_measurement = false             #非必填 是否使用数据中的 job 标签值当做指标集名
              [inputs.kubernetesprometheus.instances.custom.tags]
                instance         = "__kubernetes_mate_instance"    #可选 指标tag
                host             = "__kubernetes_mate_host"        #可选 指标tag
                pod_name         = "__kubernetes_pod_name"         #可选 指标tag
                pod_namespace    = "__kubernetes_pod_namespace"    #可选 指标tag，可以继续新增，这里不继承全局tag和选举tag
                cluster          = "cluster01"                     #可选
```

- 挂载`kubernetesprometheus.conf`
在`datakit.yaml` 文件中 `volumeMounts`下添加

```yaml
- mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
  name: datakit-conf
  subPath: kubernetesprometheus.conf
  readOnly: true
```

- 重启 datakit
执行以下命令

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

## 指标 {#metric}

### node 指标集

Node Exporter 指标位于 node 指标集下，这里介绍Node Exporter指标相关说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`node_arp_entries`|`ARP表中的条目数量`| count |
|`node_boot_time_seconds`|`系统启动以来的时间`| s |
|`node_context_switches_total`|`上下文切换的总次数`| count |
|`node_cpu_guest_seconds_total`|`CPU花费在虚拟机或容器上运行其他操作系统的时间总和`| s |
|`node_cpu_seconds_total`|`CPU花费在用户态、系统态和空闲态的总时间`| s |
|`node_disk_io_now`|`正在执行的磁盘I/O操作的数量`| count |
|`node_disk_io_time_seconds_total`|`磁盘I/O操作花费的总时间`| s |
|`node_disk_io_time_weighted_seconds_total`|`I/O操作等待时间的加权总时间`| s |
|`node_disk_read_bytes_total`|`磁盘读取的总字节数`| byte |
|`node_disk_read_time_seconds_total`|`读取磁盘花费的总时间`| s |
|`node_disk_reads_completed_total`|`完成的磁盘读取操作的总次数`| count |
|`node_disk_reads_merged_total`|`合并的磁盘读取操作的总次数`| count |
|`node_disk_write_time_seconds_total`|`写入磁盘花费的总时间`| count |
|`node_disk_writes_completed_total`|`完成的磁盘写入操作的总次数`| count |
|`node_disk_writes_merged_total`|`合并的磁盘写入操作的总次数`| count |
|`node_disk_written_bytes_total`|`写入磁盘的总字节数`| byte |
|`node_entropy_available_bits`|`可用的熵数量(用于加密操作)`| count |
|`node_filefd_allocated`|`已分配的文件描述符数量`| count |
|`node_filefd_maximum`|`文件描述符的最大数量`| count |
|`node_filesystem_avail_bytes`|`文件系统可用空间的字节数`| byte |
|`node_ilesystem_device_error`|`文件系统设备错误计数`| count |
|`node_filesystem_files`|`文件系统中的文件数量`| count |
|`node_filesystem_files_free`|`文件系统中空闲的文件数量`| count |
|`node_filesystem_free_bytes`|`文件系统空闲空间的字节数`| byte |
|`node_filesystem_size_bytes`|`文件系统的总大小`| byte |
|`node_forks_total`|`系统调用fork()的总次数`| count |
|`node_intr_total`|`总的中断次数`| count |
|`node_ipvs_backend_connections_active`|`活跃的IP虚拟服务器数量`| count |
|`node_ipvs_backend_connections_inactive`|`不活跃的IPVS后端连接数`| count |
|`node_ipvs_connections_total`|`IPVS的总连接数`| count |
|`node_ipvs_incoming_bytes_total`|`通过IPVS接收的总字节数`| byte |
|`node_ipvs_incoming_packets_total`|`通过IPVS接收的总数据包数`| count |
|`node_ipvs_outgoing_bytes_total`|`通过IPVS发送的总字节数`| byte |
|`node_load1`|`最近1分钟内的平均负载`| count |
|`node_load15`|`最近15分钟内的平均负载`| count |
|`node_load5`|`最近5分钟内的平均负载`| count |
|`node_memory_Active_anon_bytes`|`活跃的匿名内存使用的字节数`| byte |
|`node_memory_Active_bytes`|`活跃内存使用的字节数`| byte |
|`node_memory_Active_file_bytes`|`活跃文件内存使用的字节数`| byte |
|`node_memory_AnonHugePages_bytes`|`匿名大页内存使用的字节数`| byte |
|`node_memory_Bounce_bytes`|`内存bounce buffer使用的字节数`| byte |
|`node_memory_Buffers_bytes`|`缓存内存使用的字节数`| byte |
|`node_memory_Cached_bytes`|`缓存使用的字节数`| byte |
|`node_memory_CmaFree_bytes`|`CMAs（预留的内核内存）中空闲的字节数`| byte |
|`node_memory_CmaTotal_bytes`|`CMAs的总字节数`| byte |
|`node_memory_CommitLimit_bytes`|`系统可以分配的内存的字节数`| byte |
|`node_memory_Committed_AS_bytes`|`已提交的内存使用的字节数`| byte |
|`node_memory_DirectMap1G_bytes`|`直接映射的1G内存区域的字节数`| byte |
|`node_memory_DirectMap2M_bytes`|`直接映射的2M内存区域的字节数`| byte |
|`node_memory_DirectMap4k_bytes`|`直接映射的4k内存区域的字节数`| byte |
|`node_memory_Dirty_bytes`|`脏内存（需要写回磁盘的内存）的字节数`| byte |
|`node_memory_HardwareCorrupted_bytes`|`被硬件损坏的内存字节数`| byte |
|`node_memory_HugePages_Free`|`空闲的大页内存的数量`| count |
|`node_memory_HugePages_Rsvd`|`保留的大页内存的数量`| count |
|`node_memory_HugePages_Surp`|`大页内存的surplus数量`| count |
|`node_memory_HugePages_Total`|`大页内存的总数量`| byte |
|`node_memory_Hugepagesize_bytes`|`每个大页的大小`| byte |
|`node_memory_Inactive_anon_bytes`|`非活跃的匿名内存使用的字节数`| byte |
|`node_memory_Inactive_bytes`|`非活跃文件内存使用的字节数`| byte |
|`node_memory_SReclaimable_bytes`|`可回收的慢速内存使用的字节数`| byte |
|`node_memory_SUnreclaim_bytes`|`不可回收的慢速内存使用的字节数`| byte |
|`node_memory_Shmem_bytes`|`共享内存使用的字节数`| byte |
|`node_memory_Slab_bytes`|`slab使用的内存字节数`| byte |
|`node_memory_SwapCached_bytes`|`缓存的交换空间使用的字节数`| byte |
|`node_memory_SwapFree_bytes`|`空闲的交换空间的字节数`| byte |
|`node_memory_SwapTotal_bytes`|`总的交换空间的字节数`| byte |
|`node_memory_Unevictable_bytes`|`不可驱逐的内存使用的字节数`| byte |
|`node_memory_VmallocChunk_bytes`|`vmalloc内存块使用的字节数`| byte |
|`node_memory_VmallocTotal_bytes`|`vmalloc内存的总字节数`| byte |
|`node_memory_VmallocUsed_bytes`|`使用的vmalloc内存的字节数`| byte |
|`node_memory_WritebackTmp_bytes`|`用于写回操作的临时内存使用的字节数`| byte |
|`node_memory_VmallocTotal_bytes`|`vmalloc内存的总字节数`| byte |
|`node_netstat_Icmp6_InErrors`|`IPv6 ICMP错误消息的接收数量`| count |
|`node_netstat_Icmp6_InMsgs`|`IPv6 ICMP消息的接收数量`| count |
|`node_netstat_Icmp6_OutMsgs`|`IPv6 ICMP消息的发送数量`| count |
|`node_netstat_Icmp_InErrors`|`ICMP错误消息的接收数量`| count |
|`node_netstat_Icmp_InMsgs`|`ICMP消息的接收数量`| count |
|`node_netstat_Icmp_OutMsgs`|`ICMP消息的发送数量`| count |
|`node_netstat_Ip6_InOctets`|`接收的IPv6数据字节数`| byte |
|`node_netstat_Ip6_OutOctets`|`发送的IPv6数据字节数`| byte |
|`node_netstat_IpExt_InOctets`|`扩展IPv4接收数据字节数`| byte |
|`node_netstat_IpExt_OutOctets`|`扩展IPv4发送数据字节数`| byte |
|`node_netstat_TcpExt_ListenDrops`|`TCP监听队列溢出次数`| count |
|`node_netstat_TcpExt_ListenOverflows`|`TCP监听队列溢出次数。`| count |
|`node_netstat_TcpExt_SyncookiesFailed`|`SYN cookies失败次数`| count |

