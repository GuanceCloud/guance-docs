---
title     : 'Node Exporter'
summary   : 'Collect host metric information through Node Exporter'
__int_icon: 'icon/node_exporter'
dashboard :
  - desc  : 'Node Exporter'
    path  : 'dashboard/en/node_exporter'
monitor   :
  - desc  : 'Node Exporter'
    path  : 'monitor/en/node_exporter'
---

<!-- markdownlint-disable MD025 -->
# Node Exporter
<!-- markdownlint-enable -->

This article introduces deploying the Node Exporter component on a host, collecting host metrics and storing them through Datakit, and finally visualizing the data through observation cloud.
Node Exporter can collect various system performance indicators, including CPU usage, memory usage, disk I/O, network traffic, etc. of the host.

## Config {#config}

### Preconditions {#requirement}

- [x] Installed datakit

### Collecting host metric data through Node-Exporter

- Create DaemonSet configuration file`node-exporter.yaml`

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
      hostPID: true        # Use the PID of the host
      hostIPC: true        # Use the host's IPC
      hostNetwork: true    # Use the host's network
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

Execute

```shell
kubectl create ns monitor-sa
kubectl apply -f node-exporter.yaml
```

View all monitoring data obtained by the current host through `http://host ip: 31672/metrics`

### Configure Datakit

- Add `kubernetesprometheus. conf` to the `Config Map` resource in the `datakit. yaml` file.
  
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    kubernetesprometheus.conf: |-
      [inputs.kubernetesprometheus]
        node_local = true  # Do you want to enable NodeLocal mode to distribute data collection to various nodes
        [[inputs.kubernetesprometheus.instances]]
            role       = "service"     # Required fields can be configured as service、pod、endpoints、node
            namespaces = ["monitor-sa"]
            selector   = ""

            scrape     = "true"
            scheme     = "http" 
            port       = "__kubernetes_service_port_%s_port " 
            path       = "/metrics"
            params     = ""
            interval   = "30s"

            [inputs.kubernetesprometheus.instances.custom]
              measurement        = "kube_nodeexporter"
              job_as_measurement = false
              [inputs.kubernetesprometheus.instances.custom.tags]
                instance         = "__kubernetes_mate_instance"    #Optional metric tag
                host             = "__kubernetes_mate_host"        #Optional metric tag
                pod_name         = "__kubernetes_pod_name"         #Optional metric tag
                pod_namespace    = "__kubernetes_pod_namespace"   #Optional metric tag
                cluster          = "cluster01"                    #Optional
```

- Mount`kubernetesprometheus.conf`
Add under `volumeMounts` in the `datakit. yaml`file

```yaml
- mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
  name: datakit-conf
  subPath: kubernetesprometheus.conf
  readOnly: true
```

- Restart datakit
Execute the following command

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

## Metric {#metric}

### node Metric set

The Node Exporter metric is located under the node metric set. Here are the relevant explanations for the Node Exporter metric

| Metrics | description | unit |
|:--------|:-----|:--|
|`node_arp_entries`|`The number of entries in the ARP table`| count |
|`node_boot_time_seconds`|`Time since system startup`| s |
|`node_context_switches_total`|`The total number of context switches`| count |
|`node_cpu_guest_seconds_total`|`The total amount of time CPU spends running other operating systems on virtual machines or containers`| s |
|`node_cpu_seconds_total`|`The total time spent by the CPU in user mode, system mode, and idle mode`| s |
|`node_disk_io_now`|`The number of disk I/O operations currently being executed`| count |
|`node_disk_io_time_seconds_total`|`The total time spent on disk I/O operations`| s |
|`node_disk_io_time_weighted_seconds_total`|`Weighted total waiting time for I/O operations`| s |
|`node_disk_read_bytes_total`|`The total number of bytes read from the disk`| byte |
|`node_disk_read_time_seconds_total`|`The total time spent reading the disk`| s |
|`node_disk_reads_completed_total`|`The total number of disk read operations completed`| count |
|`node_disk_reads_merged_total`|`The total number of merged disk read operations`| count |
|`node_disk_write_time_seconds_total`|`The total time spent writing to the disk`| count |
|`node_disk_writes_completed_total`|`The total number of disk write operations completed`| count |
|`node_disk_writes_merged_total`|`The total number of merged disk write operations`| count |
|`node_disk_written_bytes_total`|`The total number of bytes written to the disk`| byte |
|`node_entropy_available_bits`|`Available entropy quantity (for encryption operations)`| count |
|`node_filefd_allocated`|`Number of allocated file descriptors`| count |
|`node_filesystem_avail_bytes`|`The number of bytes of available space in the file system`| byte |
|`node_filesystem_device_error`|`File system device error count`| count |
|`node_filesystem_files`|`The number of files in the file system`| count |
|`node_filesystem_files_free`|`The number of idle files in the file system`| count |
|`node_filesystem_free_bytes`|`The number of bytes of free space in the file system`| byte |
|`node_filesystem_size_bytes`|`The total size of the file system`| byte |
|`node_forks_total`|`The total number of system calls to fork()`| count |
|`node_intr_total`|`Total number of interruptions`| count |
|`node_ipvs_backend_connections_active`|`Number of active IP virtual servers`| count |
|`node_ipvs_backend_connections_inactive`|`Number of inactive IPVS backend connections`| count |
|`node_ipvs_connections_total`|`The total number of connections in IPVS`| count |
|`node_ipvs_incoming_bytes_total`|`The total number of bytes received through IPVS`| byte |
|`node_ipvs_incoming_packets_total`|`The total number of data packets received through IPVS`| count |
|`node_ipvs_outgoing_bytes_total`|`The total number of bytes sent through IPVS`| byte |
|`node_load1`|`Average load in the past minute`| count |
|`node_load15`|`Average load in the past 15 minutes`| count |
|`node_load5`|`Average load in the past 5 minutes`| count |
|`node_memory_Active_anon_bytes`|`The number of bytes used by active anonymous memory`| byte |
|`node_memory_Active_bytes`|`The number of bytes used by active memory`| byte |
|`node_memory_Active_file_bytes`|`The number of bytes used by active file memory`| byte |
|`node_memory_AnonHugePages_bytes`|`The number of bytes used for anonymous large page memory`| byte |
|`node_memory_Bounce_bytes`|`The number of bytes used by the memory bounce buffer`| byte |
|`node_memory_Buffers_bytes`|`The number of bytes used by cache memory`| byte |
|`node_memory_Cached_bytes`|`The number of bytes used for caching`| byte |
|`node_memory_CmaFree_bytes`|`The number of idle bytes in CMAs (reserved kernel memory)`| byte |
|`node_memory_CmaTotal_bytes`|`The total number of bytes in CMAs`| byte |
|`node_memory_CommitLimit_bytes`|`The number of bytes of memory that the system can allocate`| byte |
|`node_memory_Committed_AS_bytes`|`The number of bytes used by the submitted memory`| byte |
|`node_memory_DirectMap1G_bytes`|`The number of bytes directly mapped to a 1GB memory area`| byte |
|`node_memory_DirectMap2M_bytes`|`The number of bytes directly mapped to a 2M memory area`| byte |
|`node_memory_DirectMap4k_bytes`|`The number of bytes in the 4k memory area directly mapped`| byte |
|`node_memory_Dirty_bytes`|`The number of bytes of dirty memory (memory that needs to be written back to disk)`| byte |
|`node_memory_HardwareCorrupted_bytes`|`Number of memory bytes damaged by hardware`| byte |
|`node_memory_HugePages_Free`|`The amount of idle large page memory`| count |
|`node_memory_HugePages_Rsvd`|`The amount of reserved large page memory`| count |
|`node_memory_HugePages_Surp`|`The surplus quantity of large page memory`| count |
|`node_memory_HugePages_Total`|`The total amount of large page memory`| byte |
|`node_memory_Hugepagesize_bytes`|`The size of each large page`| byte |
|`node_memory_Inactive_anon_bytes`|`The number of bytes used by inactive anonymous memory`| byte |
|`node_memory_Inactive_bytes`|`The number of bytes used by inactive file memory`| byte |
|`node_memory_SReclaimable_bytes`|`The number of bytes used by recyclable slow memory`| byte |
|`node_memory_SUnreclaim_bytes`|`The number of bytes used by non recyclable slow memory`| byte |
|`node_memory_Shmem_bytes`|`The number of bytes used for shared memory`| byte |
|`node_memory_Slab_bytes`|`The number of memory bytes used by slab`| byte |
|`node_memory_SwapCached_bytes`|`The number of bytes used for cache swap space`| byte |
|`node_memory_SwapFree_bytes`|`The number of bytes of idle swap space`| byte |
|`node_memory_SwapTotal_bytes`|`The total number of bytes in the swap space`| byte |
|`node_memory_Unevictable_bytes`|`The number of bytes used by non evicted memory`| byte |
|`node_memory_VmallocChunk_bytes`|`The number of bytes used by vmalloc memory blocks`| byte |
|`node_memory_VmallocTotal_bytes`|`The total number of bytes in vmalloc memory`| byte |
|`node_memory_VmallocUsed_bytes`|`The number of bytes of vmalloc memory used`| byte |
|`node_memory_WritebackTmp_bytes`|`The number of bytes used for temporary memory for write back operations`| byte |
|`node_memory_VmallocTotal_bytes`|`The total number of bytes in vmalloc memory`| byte |
|`node_netstat_Icmp6_InErrors`|`Number of received IPv6 ICMP error messages`| count |
|`node_netstat_Icmp6_InMsgs`|`Number of received IPv6 ICMP messages`| count |
|`node_netstat_Icmp6_OutMsgs`|`Number of IPv6 ICMP messages sent`| count |
|`node_netstat_Icmp_InErrors`|`The number of ICMP error messages received`| count |
|`node_netstat_Icmp_InMsgs`|`The number of ICMP messages received`| count |
|`node_netstat_Icmp_OutMsgs`|`The number of ICMP messages sent`| count |
|`node_netstat_Ip6_InOctets`|`Number of received IPv6 data bytes`| byte |
|`node_netstat_Ip6_OutOctets`|`Number of bytes of IPv6 data sent`| byte |
|`node_netstat_IpExt_InOctets`|`Expand the byte count of IPv4 received data`| byte |
|`node_netstat_IpExt_OutOctets`|`Expand the number of bytes of IPv4 data sent`| byte |
|`node_netstat_TcpExt_ListenDrops`|`TCP listening queue overflow times`| count |
|`node_netstat_TcpExt_ListenOverflows`|`TCP listening queue overflow times`| count |
|`node_netstat_TcpExt_SyncookiesFailed`|`SYN cookies failed times`| count |
