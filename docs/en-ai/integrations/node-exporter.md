---
title     : 'Node Exporter'
summary   : 'Collecting host Metrics information via Node Exporter'
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

This document introduces the deployment of the Node Exporter component on the host to collect host Metrics and gather them through Datakit for storage. Finally, the data is visualized using Guance. Node Exporter can collect various system runtime Metrics including CPU usage, memory usage, disk I/O, network traffic, etc.

## Configuration {#config}

### Prerequisites {#requirement}

- [x] Datakit is installed

### Collecting Host Metrics Data via Node Exporter

- Create a DaemonSet configuration file `node-exporter.yaml`

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
      hostPID: true        # Use the host's PID
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

Execution:

```shell
kubectl create ns monitor-sa
kubectl apply -f node-exporter.yaml
```

View all monitoring data obtained from the current host via `http://host_ip:31672/metrics`.

### Configuring Datakit

- Add `kubernetesprometheus.conf` in the `ConfigMap` resource within the `datakit.yaml` file
  
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
            role       = "service"     # Required, can be configured as service, pod, endpoints, node
            namespaces = ["monitor-sa"]    # Optional, supports multiple configurations separated by commas; empty matches all
            selector   = ""       # Optional, labels of collected resources to match selected objects; empty matches all

            scrape     = "true"            # Optional, collection switch, default true,
            scheme     = "http" 
            port       = "__kubernetes_service_port_%s_port " 
            path       = "/metrics"        # Optional, most Prometheus collection paths are /metrics; specific to actual metrics address of the collected service
            params     = ""                # Optional, HTTP access parameters, a string, e.g., name=nginx&package=middleware, not required
            interval   = "30s"             # Optional, collection frequency, default 30s

            [inputs.kubernetesprometheus.instances.custom]
              measurement        = "kube_nodeexporter"       # Optional, Guance Metrics name, defaults to the first letter of the metric underscore
              job_as_measurement = false             # Optional, whether to use the job label value in the data as the Mearsurement name
              [inputs.kubernetesprometheus.instances.custom.tags]
                instance         = "__kubernetes_mate_instance"    # Optional, Metrics tag
                host             = "__kubernetes_mate_host"        # Optional, Metrics tag
                pod_name         = "__kubernetes_pod_name"         # Optional, Metrics tag
                pod_namespace    = "__kubernetes_pod_namespace"    # Optional, Metrics tag, can add more here, does not inherit global tags or elected tags
                cluster          = "cluster01"                     # Optional
```

- Mount `kubernetesprometheus.conf`
Add the following in the `volumeMounts` section of the `datakit.yaml` file

```yaml
- mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
  name: datakit-conf
  subPath: kubernetesprometheus.conf
  readOnly: true
```

- Restart Datakit
Execute the following commands

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

## Metrics {#metric}

### Node Mearsurement

Node Exporter Metrics are located under the node Mearsurement. Here we provide an explanation of the Node Exporter Metrics.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`node_arp_entries`|Number of entries in the ARP table| count |
|`node_boot_time_seconds`|Time since system boot| s |
|`node_context_switches_total`|Total number of context switches| count |
|`node_cpu_guest_seconds_total`|Total time spent by the CPU running other operating systems in virtual machines or containers| s |
|`node_cpu_seconds_total`|Total time spent by the CPU in user, system, and idle states| s |
|`node_disk_io_now`|Number of disk I/O operations currently executing| count |
|`node_disk_io_time_seconds_total`|Total time spent on disk I/O operations| s |
|`node_disk_io_time_weighted_seconds_total`|Weighted total time waiting for I/O operations| s |
|`node_disk_read_bytes_total`|Total number of bytes read from disk| byte |
|`node_disk_read_time_seconds_total`|Total time spent reading from disk| s |
|`node_disk_reads_completed_total`|Total number of completed disk read operations| count |
|`node_disk_reads_merged_total`|Total number of merged disk read operations| count |
|`node_disk_write_time_seconds_total`|Total time spent writing to disk| count |
|`node_disk_writes_completed_total`|Total number of completed disk write operations| count |
|`node_disk_writes_merged_total`|Total number of merged disk write operations| count |
|`node_disk_written_bytes_total`|Total number of bytes written to disk| byte |
|`node_entropy_available_bits`|Available entropy (for cryptographic operations)| count |
|`node_filefd_allocated`|Number of allocated file descriptors| count |
|`node_filefd_maximum`|Maximum number of file descriptors| count |
|`node_filesystem_avail_bytes`|Number of available bytes in the filesystem| byte |
|`node_ilesystem_device_error`|Filesystem device error count| count |
|`node_filesystem_files`|Number of files in the filesystem| count |
|`node_filesystem_files_free`|Number of free files in the filesystem| count |
|`node_filesystem_free_bytes`|Number of free bytes in the filesystem| byte |
|`node_filesystem_size_bytes`|Total size of the filesystem| byte |
|`node_forks_total`|Total number of fork() system calls| count |
|`node_intr_total`|Total number of interrupts| count |
|`node_ipvs_backend_connections_active`|Number of active IPVS backends| count |
|`node_ipvs_backend_connections_inactive`|Number of inactive IPVS backend connections| count |
|`node_ipvs_connections_total`|Total number of IPVS connections| count |
|`node_ipvs_incoming_bytes_total`|Total number of bytes received via IPVS| byte |
|`node_ipvs_incoming_packets_total`|Total number of packets received via IPVS| count |
|`node_ipvs_outgoing_bytes_total`|Total number of bytes sent via IPVS| byte |
|`node_load1`|Average load over the past 1 minute| count |
|`node_load15`|Average load over the past 15 minutes| count |
|`node_load5`|Average load over the past 5 minutes| count |
|`node_memory_Active_anon_bytes`|Number of bytes used by active anonymous memory| byte |
|`node_memory_Active_bytes`|Number of bytes used by active memory| byte |
|`node_memory_Active_file_bytes`|Number of bytes used by active file memory| byte |
|`node_memory_AnonHugePages_bytes`|Number of bytes used by anonymous huge pages| byte |
|`node_memory_Bounce_bytes`|Number of bytes used by bounce buffer memory| byte |
|`node_memory_Buffers_bytes`|Number of bytes used by cache memory| byte |
|`node_memory_Cached_bytes`|Number of bytes used by cached memory| byte |
|`node_memory_CmaFree_bytes`|Number of free bytes in CMAs (reserved kernel memory)| byte |
|`node_memory_CmaTotal_bytes`|Total number of bytes in CMAs| byte |
|`node_memory_CommitLimit_bytes`|Total number of bytes that the system can allocate| byte |
|`node_memory_Committed_AS_bytes`|Number of bytes committed by the system| byte |
|`node_memory_DirectMap1G_bytes`|Number of bytes in directly mapped 1G memory regions| byte |
|`node_memory_DirectMap2M_bytes`|Number of bytes in directly mapped 2M memory regions| byte |
|`node_memory_DirectMap4k_bytes`|Number of bytes in directly mapped 4k memory regions| byte |
|`node_memory_Dirty_bytes`|Number of dirty bytes (memory that needs to be written back to disk)| byte |
|`node_memory_HardwareCorrupted_bytes`|Number of hardware-corrupted bytes| byte |
|`node_memory_HugePages_Free`|Number of free huge pages| count |
|`node_memory_HugePages_Rsvd`|Number of reserved huge pages| count |
|`node_memory_HugePages_Surp`|Number of surplus huge pages| count |
|`node_memory_HugePages_Total`|Total number of huge pages| byte |
|`node_memory_Hugepagesize_bytes`|Size of each huge page| byte |
|`node_memory_Inactive_anon_bytes`|Number of bytes used by inactive anonymous memory| byte |
|`node_memory_Inactive_bytes`|Number of bytes used by inactive file memory| byte |
|`node_memory_SReclaimable_bytes`|Number of bytes used by reclaimable slow memory| byte |
|`node_memory_SUnreclaim_bytes`|Number of bytes used by unreclaimable slow memory| byte |
|`node_memory_Shmem_bytes`|Number of bytes used by shared memory| byte |
|`node_memory_Slab_bytes`|Number of bytes used by slab| byte |
|`node_memory_SwapCached_bytes`|Number of bytes used by cached swap space| byte |
|`node_memory_SwapFree_bytes`|Number of free bytes in swap space| byte |
|`node_memory_SwapTotal_bytes`|Total number of bytes in swap space| byte |
|`node_memory_Unevictable_bytes`|Number of bytes used by unevictable memory| byte |
|`node_memory_VmallocChunk_bytes`|Number of bytes used by vmalloc chunks| byte |
|`node_memory_VmallocTotal_bytes`|Total number of bytes in vmalloc| byte |
|`node_memory_VmallocUsed_bytes`|Number of bytes used by vmalloc| byte |
|`node_memory_WritebackTmp_bytes`|Number of bytes used by temporary writeback memory| byte |
|`node_memory_VmallocTotal_bytes`|Total number of bytes in vmalloc| byte |
|`node_netstat_Icmp6_InErrors`|Number of IPv6 ICMP error messages received| count |
|`node_netstat_Icmp6_InMsgs`|Number of IPv6 ICMP messages received| count |
|`node_netstat_Icmp6_OutMsgs`|Number of IPv6 ICMP messages sent| count |
|`node_netstat_Icmp_InErrors`|Number of ICMP error messages received| count |
|`node_netstat_Icmp_InMsgs`|Number of ICMP messages received| count |
|`node_netstat_Icmp_OutMsgs`|Number of ICMP messages sent| count |
|`node_netstat_Ip6_InOctets`|Number of bytes received via IPv6| byte |
|`node_netstat_Ip6_OutOctets`|Number of bytes sent via IPv6| byte |
|`node_netstat_IpExt_InOctets`|Number of extended IPv4 bytes received| byte |
|`node_netstat_IpExt_OutOctets`|Number of extended IPv4 bytes sent| byte |
|`node_netstat_TcpExt_ListenDrops`|Number of times the TCP listen queue has overflowed| count |
|`node_netstat_TcpExt_ListenOverflows`|Number of times the TCP listen queue has overflowed.| count |
|`node_netstat_TcpExt_SyncookiesFailed`|Number of failed SYN cookies| count |

</input_content>
</example>