---
title     : 'Node Exporter'
summary   : 'Collect HOST metrics information via Node Exporter'
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

This article introduces the deployment of the Node Exporter component on a HOST to collect HOST metrics and have them collected and stored by Datakit, finally visualizing the data through <<< custom_key.brand_name >>>.
Node Exporter can collect various system operation metrics including CPU usage, memory usage, disk I/O, network traffic, etc.

## Configuration {#config}

### Prerequisites {#requirement}

- [x] Datakit is installed

### Collect HOST metric data via Node-Exporter

- Create DaemonSet configuration file `node-exporter.yaml`

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
      hostPID: true        # Use HOST's PID
      hostIPC: true        # Use HOST's IPC
      hostNetwork: true    # Use HOST's network
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

View all monitoring data obtained from the current HOST via `http://HOST ip:31672/metrics`.

### Configure Datakit

- Add `kubernetesprometheus.conf` to the `ConfigMap` resource in the `datakit.yaml` file
  
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    kubernetesprometheus.conf: |-
      [inputs.kubernetesprometheus]
        node_local = true  # Whether to enable NodeLocal mode, distributing collection across nodes
        [[inputs.kubernetesprometheus.instances]]
            role       = "service"     # Required; can be configured as service, pod, endpoints, node
            namespaces = ["monitor-sa"]    # Not required; supports multiple configurations separated by commas; empty matches all
            selector   = ""       # Not required; labels of resources to be collected, used to match selected objects; empty matches all

            scrape     = "true"            # Not required; collection switch; default is true,
            scheme     = "http" 
            port       = "__kubernetes_service_port_%s_port " 
            path       = "/metrics"        # Not required; most Prometheus collection paths are /metrics; specific to actual service metric addresses
            params     = ""                # Not required; HTTP access parameters; string format, e.g., name=nginx&package=middleware; not required
            interval   = "30s"             # Not required; collection frequency; default is 30s

            [inputs.kubernetesprometheus.instances.custom]
              measurement        = "kube_nodeexporter"       # Not required; <<< custom_key.brand_name >>> Metrics name; default uses the first letter of the underscore in the metric
              job_as_measurement = false             # Not required; whether to use the job label value in the data as the Measurements name
              [inputs.kubernetesprometheus.instances.custom.tags]
                instance         = "__kubernetes_mate_instance"    # Optional; Metrics tag
                host             = "__kubernetes_mate_host"        # Optional; Metrics tag
                pod_name         = "__kubernetes_pod_name"         # Optional; Metrics tag
                pod_namespace    = "__kubernetes_pod_namespace"    # Optional; Metrics tag; does not inherit global tags or election tags
                cluster          = "cluster01"                     # Optional
```

- Mount `kubernetesprometheus.conf`
Add the following to the `volumeMounts` section in the `datakit.yaml` file:

```yaml
- mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
  name: datakit-conf
  subPath: kubernetesprometheus.conf
  readOnly: true
```

- Restart datakit
Execute the following commands

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

## Metrics {#metric}

### node Measurement

Node Exporter Metrics are located under the node Measurement set. Below is an explanation of the Node Exporter Metrics.

| Metrics | Description | Units |
|:--------|:-----|:--|
|`node_arp_entries`|`Number of entries in ARP table`| count |
|`node_boot_time_seconds`|`Time since system boot`| s |
|`node_context_switches_total`|`Total number of context switches`| count |
|`node_cpu_guest_seconds_total`|`Total time CPU spent running other operating systems in virtual machines or CONTAINERS`| s |
|`node_cpu_seconds_total`|`Total time CPU spent in user mode, system mode, and idle state`| s |
|`node_disk_io_now`|`Number of disk I/O operations currently executing`| count |
|`node_disk_io_time_seconds_total`|`Total time spent on disk I/O operations`| s |
|`node_disk_io_time_weighted_seconds_total`|`Weighted total time of I/O operation wait times`| s |
|`node_disk_read_bytes_total`|`Total number of bytes read from disk`| byte |
|`node_disk_read_time_seconds_total`|`Total time spent reading from disk`| s |
|`node_disk_reads_completed_total`|`Total number of completed disk read operations`| count |
|`node_disk_reads_merged_total`|`Total number of merged disk read operations`| count |
|`node_disk_write_time_seconds_total`|`Total time spent writing to disk`| count |
|`node_disk_writes_completed_total`|`Total number of completed disk write operations`| count |
|`node_disk_writes_merged_total`|`Total number of merged disk write operations`| count |
|`node_disk_written_bytes_total`|`Total number of bytes written to disk`| byte |
|`node_entropy_available_bits`|`Available entropy (for cryptographic operations)`| count |
|`node_filefd_allocated`|`Number of allocated file descriptors`| count |
|`node_filefd_maximum`|`Maximum number of file descriptors`| count |
|`node_filesystem_avail_bytes`|`Bytes of available space in filesystem`| byte |
|`node_ilesystem_device_error`|`Filesystem device error counts`| count |
|`node_filesystem_files`|`Number of files in filesystem`| count |
|`node_filesystem_files_free`|`Number of free files in filesystem`| count |
|`node_filesystem_free_bytes`|`Bytes of free space in filesystem`| byte |
|`node_filesystem_size_bytes`|`Total size of filesystem`| byte |
|`node_forks_total`|`Total number of calls to fork() system call`| count |
|`node_intr_total`|`Total number of interrupts`| count |
|`node_ipvs_backend_connections_active`|`Number of active IP Virtual Servers`| count |
|`node_ipvs_backend_connections_inactive`|`Number of inactive IPVS backend connections`| count |
|`node_ipvs_connections_total`|`Total number of IPVS connections`| count |
|`node_ipvs_incoming_bytes_total`|`Total number of bytes received via IPVS`| byte |
|`node_ipvs_incoming_packets_total`|`Total number of packets received via IPVS`| count |
|`node_ipvs_outgoing_bytes_total`|`Total number of bytes sent via IPVS`| byte |
|`node_load1`|`Average load over the last 1 minute`| count |
|`node_load15`|`Average load over the last 15 minutes`| count |
|`node_load5`|`Average load over the last 5 minutes`| count |
|`node_memory_Active_anon_bytes`|`Bytes of active anonymous memory usage`| byte |
|`node_memory_Active_bytes`|`Bytes of active memory usage`| byte |
|`node_memory_Active_file_bytes`|`Bytes of active file memory usage`| byte |
|`node_memory_AnonHugePages_bytes`|`Bytes of anonymous huge pages memory usage`| byte |
|`node_memory_Bounce_bytes`|`Bytes of bounce buffer memory usage`| byte |
|`node_memory_Buffers_bytes`|`Bytes of cached memory usage`| byte |
|`node_memory_Cached_bytes`|`Bytes of cache usage`| byte |
|`node_memory_CmaFree_bytes`|`Bytes of free CMAs (reserved kernel memory)`| byte |
|`node_memory_CmaTotal_bytes`|`Total bytes of CMAs`| byte |
|`node_memory_CommitLimit_bytes`|`Bytes of memory that the system can commit`| byte |
|`node_memory_Committed_AS_bytes`|`Bytes of committed memory usage`| byte |
|`node_memory_DirectMap1G_bytes`|`Bytes of directly mapped 1G memory regions`| byte |
|`node_memory_DirectMap2M_bytes`|`Bytes of directly mapped 2M memory regions`| byte |
|`node_memory_DirectMap4k_bytes`|`Bytes of directly mapped 4k memory regions`| byte |
|`node_memory_Dirty_bytes`|`Bytes of dirty memory (memory that needs to be written back to disk)`| byte |
|`node_memory_HardwareCorrupted_bytes`|`Bytes of hardware-corrupted memory`| byte |
|`node_memory_HugePages_Free`|`Number of free huge pages memory`| count |
|`node_memory_HugePages_Rsvd`|`Number of reserved huge pages memory`| count |
|`node_memory_HugePages_Surp`|`Surplus number of huge pages memory`| count |
|`node_memory_HugePages_Total`|`Total number of huge pages memory`| byte |
|`node_memory_Hugepagesize_bytes`|`Size of each huge page`| byte |
|`node_memory_Inactive_anon_bytes`|`Bytes of inactive anonymous memory usage`| byte |
|`node_memory_Inactive_bytes`|`Bytes of inactive file memory usage`| byte |
|`node_memory_SReclaimable_bytes`|`Bytes of reclaimable slow memory usage`| byte |
|`node_memory_SUnreclaim_bytes`|`Bytes of unreclaimable slow memory usage`| byte |
|`node_memory_Shmem_bytes`|`Bytes of shared memory usage`| byte |
|`node_memory_Slab_bytes`|`Bytes of slab memory usage`| byte |
|`node_memory_SwapCached_bytes`|`Bytes of cached swap space usage`| byte |
|`node_memory_SwapFree_bytes`|`Bytes of free swap space`| byte |
|`node_memory_SwapTotal_bytes`|`Total bytes of swap space`| byte |
|`node_memory_Unevictable_bytes`|`Bytes of unevictable memory usage`| byte |
|`node_memory_VmallocChunk_bytes`|`Bytes of vmalloc memory chunk usage`| byte |
|`node_memory_VmallocTotal_bytes`|`Total bytes of vmalloc memory`| byte |
|`node_memory_VmallocUsed_bytes`|`Bytes of used vmalloc memory`| byte |
|`node_memory_WritebackTmp_bytes`|`Bytes of temporary memory used for writeback operations`| byte |
|`node_memory_VmallocTotal_bytes`|`Total bytes of vmalloc memory`| byte |
|`node_netstat_Icmp6_InErrors`|`Number of received IPv6 ICMP error messages`| count |
|`node_netstat_Icmp6_InMsgs`|`Number of received IPv6 ICMP messages`| count |
|`node_netstat_Icmp6_OutMsgs`|`Number of sent IPv6 ICMP messages`| count |
|`node_netstat_Icmp_InErrors`|`Number of received ICMP error messages`| count |
|`node_netstat_Icmp_InMsgs`|`Number of received ICMP messages`| count |
|`node_netstat_Icmp_OutMsgs`|`Number of sent ICMP messages`| count |
|`node_netstat_Ip6_InOctets`|`Number of received IPv6 data bytes`| byte |
|`node_netstat_Ip6_OutOctets`|`Number of sent IPv6 data bytes`| byte |
|`node_netstat_IpExt_InOctets`|`Extended IPv4 received data bytes`| byte |
|`node_netstat_IpExt_OutOctets`|`Extended IPv4 sent data bytes`| byte |
|`node_netstat_TcpExt_ListenDrops`|`TCP listen queue overflow count`| count |
|`node_netstat_TcpExt_ListenOverflows`|`TCP listen queue overflow count.`| count |
|`node_netstat_TcpExt_SyncookiesFailed`|`SYN cookies failed count`| count |