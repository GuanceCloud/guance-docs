---
title     : 'Node Exporter'
summary   : 'Collect host Metrics information via Node Exporter'
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

This document describes the deployment of the Node Exporter component on a host to collect host Metrics and gather, store them through Datakit, and finally visualize the data using Guance.

Node Exporter can collect various system runtime Metrics, including CPU usage, memory usage, disk I/O, network traffic, etc.

## Configuration {#config}

### Prerequisites {#requirement}

- [x] Datakit is installed

### Collecting Host Metrics Data via Node-Exporter

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

Execute

```shell
kubectl create ns monitor-sa
kubectl apply -f node-exporter.yaml
```

View all monitoring data obtained from the current host via `http://host-ip:31672/metrics`.

### Configuring Datakit

- Add `kubernetesprometheus.conf` in the `ConfigMap` resource of the `datakit.yaml` file
  
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
            role       = "service"     # Required Can be configured as service, pod, endpoints, node
            namespaces = ["monitor-sa"]    # Optional, supports multiple entries separated by commas, empty matches all
            selector   = ""       # Optional, labels of collected resources to match selected objects, empty matches all

            scrape     = "true"            # Optional Collection switch, default true,
            scheme     = "http" 
            port       = "__kubernetes_service_port_%s_port " 
            path       = "/metrics"        # Optional Most Prometheus collection paths are /metrics, specific to actual metrics address of the collected service
            params     = ""                # Optional HTTP access parameters, a string, e.g., name=nginx&package=middleware, not required
            interval   = "30s"             # Optional Collection frequency, default 30s

            [inputs.kubernetesprometheus.instances.custom]
              measurement        = "kube_nodeexporter"       # Optional Guance Metrics name, defaults to the first letter of the Metrics underscore
              job_as_measurement = false             # Optional Whether to use the job label value in the data as the Measurement name
              [inputs.kubernetesprometheus.instances.custom.tags]
                instance         = "__kubernetes_mate_instance"    # Optional Metrics tag
                host             = "__kubernetes_mate_host"        # Optional Metrics tag
                pod_name         = "__kubernetes_pod_name"         # Optional Metrics tag
                pod_namespace    = "__kubernetes_pod_namespace"    # Optional Metrics tag, can add more here without inheriting global tags or election tags
                cluster          = "cluster01"                     # Optional
```

- Mount `kubernetesprometheus.conf`
Add it under `volumeMounts` in the `datakit.yaml` file

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

### node Measurement

Node Exporter Metrics are located under the node Measurement. Here we introduce related explanations for Node Exporter Metrics.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`node_arp_entries`|Number of entries in the ARP table| count |
|`node_boot_time_seconds`|Time since system boot| s |
|`node_context_switches_total`|Total number of context switches| count |
|`node_cpu_guest_seconds_total`|Total time spent by CPU running other operating systems in virtual machines or containers| s |
|`node_cpu_seconds_total`|Total time spent by CPU in user, system, and idle states| s |
|`node_disk_io_now`|Number of disk I/O operations currently executing| count |
|`node_disk_io_time_seconds_total`|Total time spent on disk I/O operations| s |
|`node_disk_io_time_weighted_seconds_total`|Weighted total time waiting for I/O operations| s |
|`node_disk_read_bytes_total`|Total bytes read from disk| byte |
|`node_disk_read_time_seconds_total`|Total time spent reading from disk| s |
|`node_disk_reads_completed_total`|Total number of completed disk read operations| count |
|`node_disk_reads_merged_total`|Total number of merged disk read operations| count |
|`node_disk_write_time_seconds_total`|Total time spent writing to disk| count |
|`node_disk_writes_completed_total`|Total number of completed disk write operations| count |
|`node_disk_writes_merged_total`|Total number of merged disk write operations| count |
|`node_disk_written_bytes_total`|Total bytes written to disk| byte |
|`node_entropy_available_bits`|Available entropy (for cryptographic operations)| count |
|`node_filefd_allocated`|Number of allocated file descriptors| count |
|`node_filefd_maximum`|Maximum number of file descriptors| count |
|`node_filesystem_avail_bytes`|Available space in bytes on the filesystem| byte |
|`node_ilesystem_device_error`|Filesystem device error count| count |
|`node_filesystem_files`|Number of files in the filesystem| count |
|`node_filesystem_files_free`|Number of free files in the filesystem| count |
|`node_filesystem_free_bytes`|Free space in bytes on the filesystem| byte |
|`node_filesystem_size_bytes`|Total size of the filesystem| byte |
|`node_forks_total`|Total number of fork() system calls| count |
|`node_intr_total`|Total number of interrupts| count |
|`node_ipvs_backend_connections_active`|Number of active IP Virtual Server backends| count |
|`node_ipvs_backend_connections_inactive`|Number of inactive IPVS backend connections| count |
|`node_ipvs_connections_total`|Total number of IPVS connections| count |
|`node_ipvs_incoming_bytes_total`|Total bytes received via IPVS| byte |
|`node_ipvs_incoming_packets_total`|Total packets received via IPVS| count |
|`node_ipvs_outgoing_bytes_total`|Total bytes sent via IPVS| byte |
|`node_load1`|Average load over the past 1 minute| count |
|`node_load15`|Average load over the past 15 minutes| count |
|`node_load5`|Average load over the past 5 minutes| count |
|`node_memory_Active_anon_bytes`|Bytes of active anonymous memory used| byte |
|`node_memory_Active_bytes`|Bytes of active memory used| byte |
|`node_memory_Active_file_bytes`|Bytes of active file memory used| byte |
|`node_memory_AnonHugePages_bytes`|Bytes of anonymous huge pages memory used| byte |
|`node_memory_Bounce_bytes`|Bytes of bounce buffer memory used| byte |
|`node_memory_Buffers_bytes`|Bytes of buffer cache memory used| byte |
|`node_memory_Cached_bytes`|Bytes of cached memory used| byte |
|`node_memory_CmaFree_bytes`|Bytes of free CMA (reserved kernel memory)| byte |
|`node_memory_CmaTotal_bytes`|Total bytes of CMA| byte |
|`node_memory_CommitLimit_bytes`|Bytes of memory that the system can commit| byte |
|`node_memory_Committed_AS_bytes`|Bytes of committed memory used| byte |
|`node_memory_DirectMap1G_bytes`|Bytes of directly mapped 1G memory regions| byte |
|`node_memory_DirectMap2M_bytes`|Bytes of directly mapped 2M memory regions| byte |
|`node_memory_DirectMap4k_bytes`|Bytes of directly mapped 4k memory regions| byte |
|`node_memory_Dirty_bytes`|Bytes of dirty memory (memory that needs to be written back to disk)| byte |
|`node_memory_HardwareCorrupted_bytes`|Bytes of hardware-corrupted memory| byte |
|`node_memory_HugePages_Free`|Number of free huge pages| count |
|`node_memory_HugePages_Rsvd`|Number of reserved huge pages| count |
|`node_memory_HugePages_Surp`|Number of surplus huge pages| count |
|`node_memory_HugePages_Total`|Total number of huge pages| byte |
|`node_memory_Hugepagesize_bytes`|Size of each huge page| byte |
|`node_memory_Inactive_anon_bytes`|Bytes of inactive anonymous memory used| byte |
|`node_memory_Inactive_bytes`|Bytes of inactive file memory used| byte |
|`node_memory_SReclaimable_bytes`|Bytes of reclaimable slow memory used| byte |
|`node_memory_SUnreclaim_bytes`|Bytes of unreclaimable slow memory used| byte |
|`node_memory_Shmem_bytes`|Bytes of shared memory used| byte |
|`node_memory_Slab_bytes`|Bytes of slab memory used| byte |
|`node_memory_SwapCached_bytes`|Bytes of cached swap space used| byte |
|`node_memory_SwapFree_bytes`|Bytes of free swap space| byte |
|`node_memory_SwapTotal_bytes`|Total bytes of swap space| byte |
|`node_memory_Unevictable_bytes`|Bytes of unevictable memory used| byte |
|`node_memory_VmallocChunk_bytes`|Bytes of vmalloc chunk memory used| byte |
|`node_memory_VmallocTotal_bytes`|Total bytes of vmalloc memory| byte |
|`node_memory_VmallocUsed_bytes`|Bytes of used vmalloc memory| byte |
|`node_memory_WritebackTmp_bytes`|Bytes of temporary memory used for writeback operations| byte |
|`node_memory_VmallocTotal_bytes`|Total bytes of vmalloc memory| byte |
|`node_netstat_Icmp6_InErrors`|Number of received IPv6 ICMP error messages| count |
|`node_netstat_Icmp6_InMsgs`|Number of received IPv6 ICMP messages| count |
|`node_netstat_Icmp6_OutMsgs`|Number of sent IPv6 ICMP messages| count |
|`node_netstat_Icmp_InErrors`|Number of received ICMP error messages| count |
|`node_netstat_Icmp_InMsgs`|Number of received ICMP messages| count |
|`node_netstat_Icmp_OutMsgs`|Number of sent ICMP messages| count |
|`node_netstat_Ip6_InOctets`|Bytes of received IPv6 data| byte |
|`node_netstat_Ip6_OutOctets`|Bytes of sent IPv6 data| byte |
|`node_netstat_IpExt_InOctets`|Extended IPv4 bytes received| byte |
|`node_netstat_IpExt_OutOctets`|Extended IPv4 bytes sent| byte |
|`node_netstat_TcpExt_ListenDrops`|Number of TCP listen queue overflows| count |
|`node_netstat_TcpExt_ListenOverflows`|Number of TCP listen queue overflows.| count |
|`node_netstat_TcpExt_SyncookiesFailed`|Number of failed SYN cookies| count |