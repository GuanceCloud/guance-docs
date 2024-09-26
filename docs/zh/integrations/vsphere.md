---
title     : 'vSphere'
summary   : '采集 vSphere 的指标数据'
tags:
  - 'VMWARE'
__int_icon      : 'icon/vsphere'
dashboard :
  - desc  : 'vSphere'
    path  : 'dashboard/zh/vsphere'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# vSphere
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

本采集器采集 vSphere 集群的资源使用指标，包括 CPU、内存和网络等资源，并把这些数据上报到观测云。

## 配置 {#config}

### 前置条件 {#requirements}

- 创建用户

在 vCenter 的管理界面中创建一个用户 `datakit`，并赋予 `read-only` 权限，并应用到需要监控的资源上。如果需要监控所有子对象，可以勾选 `Propagate to children` 选项。

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/vmware` 目录，复制 `vsphere.conf.sample` 并命名为 `vsphere.conf`。示例如下：
    
    ```toml
        
    [[inputs.vsphere]]
      ## Collect interval
      interval = "60s"
    
      ## vCenter URL to be monitored
      vcenter = "https://vcenter.local" 
    
      ## Username and password to be used for authentication
      username = "datakit@corp.local"
      password = "secret"
    
      ## timeout applies to any of the api request made to vcenter
      timeout = "60s"
    
      ## VMs
      ## Typical VM metrics (if omitted or empty, all metrics are collected)
      # vm_include = [ "/*/vm/**"] # Inventory path to VMs to collect (by default all are collected)
      # vm_exclude = [] # Inventory paths to exclude
      vm_metric_include = [
        "cpu.demand.average",
        "cpu.idle.summation",
        "cpu.latency.average",
        "cpu.readiness.average",
        "cpu.ready.summation",
        "cpu.run.summation",
        "cpu.usagemhz.average",
        "cpu.used.summation",
        "cpu.wait.summation",
        "mem.active.average",
        "mem.granted.average",
        "mem.latency.average",
        "mem.swapin.average",
        "mem.swapinRate.average",
        "mem.swapout.average",
        "mem.swapoutRate.average",
        "mem.usage.average",
        "mem.vmmemctl.average",
        "net.bytesRx.average",
        "net.bytesTx.average",
        "net.droppedRx.summation",
        "net.droppedTx.summation",
        "net.usage.average",
        "power.power.average",
        "virtualDisk.numberReadAveraged.average",
        "virtualDisk.numberWriteAveraged.average",
        "virtualDisk.read.average",
        "virtualDisk.readOIO.latest",
        "virtualDisk.throughput.usage.average",
        "virtualDisk.totalReadLatency.average",
        "virtualDisk.totalWriteLatency.average",
        "virtualDisk.write.average",
        "virtualDisk.writeOIO.latest",
        "sys.uptime.latest",
      ]
      # vm_metric_exclude = [] ## Nothing is excluded by default
      # vm_instances = true ## true by default
    
      ## Hosts
      ## Typical host metrics (if omitted or empty, all metrics are collected)
      # host_include = [ "/*/host/**"] # Inventory path to hosts to collect (by default all are collected)
      # host_exclude [] # Inventory paths to exclude
      host_metric_include = [
        "cpu.coreUtilization.average",
        "cpu.costop.summation",
        "cpu.demand.average",
        "cpu.idle.summation",
        "cpu.latency.average",
        "cpu.readiness.average",
        "cpu.ready.summation",
        "cpu.swapwait.summation",
        "cpu.usage.average",
        "cpu.usagemhz.average",
        "cpu.used.summation",
        "cpu.utilization.average",
        "cpu.wait.summation",
        "disk.deviceReadLatency.average",
        "disk.deviceWriteLatency.average",
        "disk.kernelReadLatency.average",
        "disk.kernelWriteLatency.average",
        "disk.numberReadAveraged.average",
        "disk.numberWriteAveraged.average",
        "disk.read.average",
        "disk.totalReadLatency.average",
        "disk.totalWriteLatency.average",
        "disk.write.average",
        "mem.active.average",
        "mem.latency.average",
        "mem.state.latest",
        "mem.swapin.average",
        "mem.swapinRate.average",
        "mem.swapout.average",
        "mem.swapoutRate.average",
        "mem.totalCapacity.average",
        "mem.usage.average",
        "mem.vmmemctl.average",
        "net.bytesRx.average",
        "net.bytesTx.average",
        "net.droppedRx.summation",
        "net.droppedTx.summation",
        "net.errorsRx.summation",
        "net.errorsTx.summation",
        "net.usage.average",
        "power.power.average",
        "storageAdapter.numberReadAveraged.average",
        "storageAdapter.numberWriteAveraged.average",
        "storageAdapter.read.average",
        "storageAdapter.write.average",
        "sys.uptime.latest",
      ]
    
      # host_metric_exclude = [] ## Nothing excluded by default
      host_instances = true ## true by default
    
      ## Clusters
      # cluster_include = [ "/*/host/**"] # Inventory path to clusters to collect (by default all are collected)
      # cluster_exclude = [] # Inventory paths to exclude
      # cluster_metric_include = [] ## if omitted or empty, all metrics are collected
      # cluster_metric_exclude = [] ## Nothing excluded by default
      # cluster_instances = false ## false by default
    
      ## Datastores
      # datastore_include = [ "/*/datastore/**"] # Inventory path to datastores to collect (by default all are collected)
      # datastore_exclude = [] # Inventory paths to exclude
      # datastore_metric_include = [] ## if omitted or empty, all metrics are collected
      # datastore_metric_exclude = [] ## Nothing excluded by default
      # datastore_instances = false ## false by default
    
      ## Datacenters
      # datacenter_include = [ "/*/host/**"] # Inventory path to clusters to collect (by default all are collected)
      # datacenter_exclude = [] # Inventory paths to exclude
      datacenter_metric_include = [] ## if omitted or empty, all metrics are collected
      datacenter_metric_exclude = [ "*" ] ## Datacenters are not collected by default.
      datacenter_instances = false ## false by default
    
      ## number of objects to retrieve per query for realtime resources (vms and hosts)
      ## set to 64 for vCenter 5.5 and 6.0 (default: 256)
      # max_query_objects = 256
    
      ## number of metrics to retrieve per query for non-realtime resources (clusters and datastores)
      ## set to 64 for vCenter 5.5 and 6.0 (default: 256)
      # max_query_metrics = 256
    
      ## The Historical Interval value must match EXACTLY the interval in the daily
      # "Interval Duration" found on the VCenter server under Configure > General > Statistics > Statistic intervals
      historical_interval = "5m"
    
      ## Set true to enable election
      election = true
    
      ## TLS connection config
      # ca_certs = ["/etc/ssl/certs/mongod.cert.pem"]
      # cert = "/etc/ssl/certs/mongo.cert.pem"
      # cert_key = "/etc/ssl/certs/mongo.key.pem"
      # insecure_skip_verify = true
      # server_name = ""
    
    # [inputs.vsphere.tags]
      # "key1" = "value1"
      # "key2" = "value2"
      # ...
    
    ```
    
    配置好后，重启 DataKit 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.vsphere.tags]` 指定其它标签：

``` toml
 [inputs.vsphere.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

<!-- markdownlint-disable MD046 -->
???+ attention

    下面的指标并非全部被采集到，具体可参阅[数据集合级别](https://docs.vmware.com/cn/VMware-vSphere/7.0/com.vmware.vsphere.monitoring.doc/GUID-25800DE4-68E5-41CC-82D9-8811E27924BC.html){:target="_blank"}中的说明。

<!-- markdownlint-enable -->




### `vsphere_cluster`



- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name`|Cluster name|
|`dcname`|`Datacenter` name|
|`host`|The host of the vCenter|
|`moid`|The managed object id|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_usage_average`|Percentage of CPU capacity being used.|float|percent|
|`cpu_usagemhz_average`|CPU usage, as measured in megahertz.|float|percent|
|`mem_consumed_average`|Amount of host physical memory consumed by a virtual machine, host, or cluster.|int|KB|
|`mem_overhead_average`|Host physical memory consumed by the virtualization infrastructure for running the virtual machine.|int|KB|
|`mem_usage_average`|Memory usage as percent of total configured or available memory.|float|percent|
|`mem_vmmemctl_average`|Amount of memory allocated by the virtual machine memory control driver (`vmmemctl`).|float|percent|
|`vmop_numChangeDS_latest`|Number of datastore change operations for powered-off and suspended virtual machines.|int|count|
|`vmop_numChangeHostDS_latest`|Number of host and datastore change operations for powered-off and suspended virtual machines.|int|count|
|`vmop_numChangeHost_latest`|Number of host change operations for powered-off and suspended virtual machines.|int|count|
|`vmop_numClone_latest`|Number of virtual machine clone operations.|int|count|
|`vmop_numCreate_latest`|Number of virtual machine create operations.|int|count|
|`vmop_numDeploy_latest`|Number of virtual machine template deploy operations.|int|count|
|`vmop_numDestroy_latest`|Number of virtual machine delete operations.|int|count|
|`vmop_numPoweroff_latest`|Number of virtual machine power off operations.|int|count|
|`vmop_numPoweron_latest`|Number of virtual machine power on operations.|int|count|
|`vmop_numRebootGuest_latest`|Number of virtual machine guest reboot operations.|int|count|
|`vmop_numReconfigure_latest`|Number of virtual machine reconfigure operations.|int|count|
|`vmop_numRegister_latest`|Number of virtual machine register operations.|int|count|
|`vmop_numReset_latest`|Number of virtual machine reset operations.|int|count|
|`vmop_numSVMotion_latest`|Number of migrations with Storage vMotion (datastore change operations for powered-on VMs).|int|count|
|`vmop_numShutdownGuest_latest`|Number of virtual machine guest shutdown operations.|int|count|
|`vmop_numStandbyGuest_latest`|Number of virtual machine standby guest operations.|int|count|
|`vmop_numSuspend_latest`|Number of virtual machine suspend operations.|int|count|
|`vmop_numUnregister_latest`|Number of virtual machine unregister operations.|int|count|
|`vmop_numVMotion_latest`|Number of migrations with vMotion (host change operations for powered-on VMs).|int|count|
|`vmop_numXVMotion_latest`|Number of host and datastore change operations for powered-on and suspended virtual machines.|int|count|






### `vsphere_datastore`



- 标签


| Tag | Description |
|  ----  | --------|
|`dcname`|`Datacenter` name|
|`dsname`|The name of the datastore|
|`host`|The host of the vCenter|
|`moid`|The managed object id|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`datastore_busResets_sum`|Number of SCSI-bus reset commands issued.|int|count|
|`datastore_commandsAborted_sum`|Number of SCSI commands aborted.|int|count|
|`datastore_numberReadAveraged_average`|Average number of read commands issued per second to the datastore.|float|-|
|`datastore_numberWriteAveraged_average`|Average number of write commands issued per second to the datastore during the collection interval.|float|-|
|`datastore_throughput_contention.avg`|Average amount of time for an I/O operation to the datastore or LUN across all ESX hosts accessing it.|int|ms|
|`datastore_throughput_usage_average`|The current bandwidth usage for the datastore or LUN.|int|KB|
|`disk_busResets_sum`|Number of SCSI-bus reset commands issued.|int|-|
|`disk_capacity_contention_average`|The amount of storage capacity overcommitment for the entity, measured in percent.|float|percent|
|`disk_capacity_latest`|Configured size of the datastore.|int|KB|
|`disk_capacity_provisioned_average`|Provisioned size of the entity.|int|KB|
|`disk_capacity_usage.avg`|The amount of storage capacity currently being consumed by or on the entity.|int|KB|
|`disk_numberReadAveraged_average`|Average number of read commands issued per second to the datastore.|float|-|
|`disk_numberWriteAveraged_average`|Average number of write commands issued per second to the datastore.|float|-|
|`disk_provisioned_latest`|Amount of storage set aside for use by a datastore or a virtual machine. Files on the datastore and the virtual machine can expand to this size but not beyond it.|int|KB|
|`disk_unshared_latest`|Amount of space associated exclusively with a virtual machine.|int|KB|
|`disk_used_latest`|Amount of space actually used by the virtual machine or the datastore. May be less than the amount provisioned at any given time, depending on whether the virtual machine is powered-off, whether snapshots have been created or not, and other such factors.|int|KB|






### `vsphere_host`



- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name`|Cluster name|
|`dcname`|`Datacenter` name|
|`esx_hostname`|The name of the ESXi host|
|`host`|The host of the vCenter|
|`instance`|The name of the instance|
|`moid`|The managed object id|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_capacity_contention_average`|Percent of time the virtual machine is unable to run because it is contending for access to the physical CPU(s).|float|percent|
|`cpu_capacity_usage_average`|CPU usage as a percent during the interval.|int|-|
|`cpu_coreUtilization_average`|CPU utilization of the corresponding core (if hyper-threading is enabled) as a percentage.|int|percent|
|`cpu_costop_sum`|Time the virtual machine is ready to run, but is unable to run due to co-scheduling constraints.|int|ms|
|`cpu_demand_average`|The amount of CPU resources a virtual machine would use if there were no CPU contention or CPU limit.|int|-|
|`cpu_idle_sum`|Total time that the CPU spent in an idle state.|int|ms|
|`cpu_latency_average`|Percent of time the virtual machine is unable to run because it is contending for access to the physical CPU(s).|int|percent|
|`cpu_readiness_average`|Percentage of time that the virtual machine was ready, but could not get scheduled to run on the physical CPU.|int|percent|
|`cpu_ready_sum`|Milliseconds of CPU time spent in ready state.|int|ms|
|`cpu_reservedCapacity_average`|Total CPU capacity reserved by virtual machines.|int|-|
|`cpu_swapwait_sum`|CPU time spent waiting for swap-in.|int|ms|
|`cpu_totalCapacity_average`|Total CPU capacity reserved by and available for virtual machines.|int|-|
|`cpu_usage_average`|Percentage of CPU capacity being used.|float|percent|
|`cpu_usagemhz_average`|CPU usage, as measured in megahertz.|float|-|
|`cpu_used_sum`|Time accounted to the virtual machine. If a system service runs on behalf of this virtual machine, the time spent by that service (represented by cpu.system) should be charged to this virtual machine. If not, the time spent (represented by cpu.overlap) should not be charged against this virtual machine.|int|ms|
|`cpu_utilization_average`|CPU utilization as a percentage during the interval (CPU usage and CPU utilization might be different due to power management technologies or hyper-threading).|int|percent|
|`cpu_wait_sum`|Total CPU time spent in wait state.The wait total includes time spent the CPU Idle, CPU Swap Wait, and CPU I/O Wait states.|int|ms|
|`datastore_datastoreIops_average`|Storage I/O Control aggregated IOPS.|int|-|
|`datastore_datastoreMaxQueueDepth_latest`|Storage I/O Control datastore maximum queue depth.|int|-|
|`datastore_datastoreNormalReadLatency_latest`|Storage DRS datastore normalized read latency.|int|ms|
|`datastore_datastoreNormalWriteLatency_latest`|Storage DRS datastore normalized write latency.|int|ms|
|`datastore_datastoreReadBytes_latest`|Storage DRS datastore bytes read.|int|ms|
|`datastore_datastoreReadIops_latest`|Storage DRS datastore read I/O rate.|int|-|
|`datastore_datastoreReadLoadMetric_latest`|Storage DRS datastore metric for read workload model.|int|-|
|`datastore_datastoreReadOIO_latest`|Storage DRS datastore outstanding read requests.|int|-|
|`datastore_datastoreVMObservedLatency_latest`|The average datastore latency as seen by virtual machines.|int|μs|
|`datastore_datastoreWriteBytes_latest`|Storage DRS datastore bytes written.|int|ms|
|`datastore_datastoreWriteIops_latest`|Storage DRS datastore write I/O rate.|int|-|
|`datastore_datastoreWriteLoadMetric_latest`|Storage DRS datastore metric for write workload model.|int|-|
|`datastore_datastoreWriteOIO_latest`|Storage DRS datastore outstanding write requests.|int|-|
|`datastore_maxTotalLatency_latest`|Highest latency value across all datastores used by the host.|int|ms|
|`datastore_numberReadAveraged_average`|Average number of read commands issued per second to the datastore.|float|-|
|`datastore_numberWriteAveraged_average`|Average number of write commands issued per second to the datastore during the collection interval.|float|-|
|`datastore_read_average`|Rate of reading data from the datastore.|float|KB|
|`datastore_siocActiveTimePercentage_average`|Percentage of time Storage I/O Control actively controlled datastore latency.|int|percent|
|`datastore_sizeNormalizedDatastoreLatency_average`|Storage I/O Control size-normalized I/O latency.|int|μs|
|`datastore_totalReadLatency_average`|Average amount of time for a read operation from the datastore.|float|ms|
|`datastore_totalWriteLatency_average`|Average amount of time for a write operation from the datastore.|float|ms|
|`datastore_write_average`|Rate of writing data to the datastore.|float|KB|
|`disk_busResets_sum`|Number of SCSI-bus reset commands issued.|int|-|
|`disk_commandsAborted_sum`|Number of SCSI commands aborted.|int|-|
|`disk_commandsAveraged_average`|Average number of SCSI commands issued per second.|int|-|
|`disk_commands_sum`|Number of SCSI commands issued|int|-|
|`disk_deviceLatency_average`|Average amount of time it takes to complete an SCSI command from physical device.|int|ms|
|`disk_deviceReadLatency_average`|Average amount of time to read from the physical device.|int|ms|
|`disk_deviceWriteLatency_average`|Average amount of time to write from the physical device.|int|ms|
|`disk_kernelLatency_average`|Average amount of time spent by VMkernel to process each SCSI command.|int|ms|
|`disk_kernelReadLatency_average`|Average amount of time spent by VMkernel to process each SCSI read command.|int|ms|
|`disk_kernelWriteLatency_average`|Average amount of time spent by VMkernel to process each SCSI write command.|int|ms|
|`disk_maxQueueDepth_average`|Maximum queue depth.|int|-|
|`disk_maxTotalLatency_latest`|Highest latency value across all disks used by the host.|int|ms|
|`disk_numberReadAveraged_average`|Average number of read commands issued per second to the datastore.|int|-|
|`disk_numberRead_sum`|Number of disk reads during the collection interval.|int|-|
|`disk_numberWriteAveraged_average`|Average number of write commands issued per second to the datastore.|float|-|
|`disk_numberWrite_sum`|Number of disk writes during the collection interval.|int|-|
|`disk_queueLatency_average`|Average amount of time spent in the VMkernel queue per SCSI command.|int|ms|
|`disk_queueReadLatency_average`|Average amount of time spent in the VMkernel queue per SCSI read command.|int|ms|
|`disk_queueWriteLatency_average`|Average amount of time spent in the VMkernel queue per SCSI write command.|int|ms|
|`disk_read_average`|Average number of kilobytes read from the disk each second.|float|KB|
|`disk_scsiReservationCnflctsPct_average`|Number of SCSI reservation conflicts for the LUN as a percent of total commands during the collection interval.|int|percent|
|`disk_scsiReservationConflicts_sum`|Number of SCSI reservation conflicts for the LUN during the collection interval.|int|-|
|`disk_totalLatency_average`|Average amount of time taken during the collection interval to process a SCSI command issued by the guest OS to the virtual machine.|int|ms|
|`disk_totalReadLatency_average`|Average amount of time taken to process a SCSI read command issued from the guest OS to the virtual machine.|int|ms|
|`disk_totalWriteLatency_average`|Average amount of time taken to process a SCSI write command issued by the guest OS to the virtual machine.|int|ms|
|`disk_usage_average`|Aggregated disk I/O rate.|float|KB|
|`disk_write_average`|Average number of kilobytes written to the disk each second.|float|KB|
|`hbr_hbrNetRx_average`|Kilobytes per second of outgoing host-based replication network traffic (for this virtual machine or host).|float|KB|
|`hbr_hbrNetTx_average`|Average amount of data transmitted per second.|float|KB|
|`hbr_hbrNumVms_average`|Number of powered-on virtual machines running on this host that currently have host-based replication protection enabled.|int|-|
|`mem_active_average`|Amount of memory that is actively used, as estimated by VMkernel based on recently touched memory pages.|float|KB|
|`mem_activewrite_average`|Estimate for the amount of memory actively being written to by the virtual machine.|float|KB|
|`mem_capacity_contention_average`|Percentage of time VMs are waiting to access swapped, compressed or ballooned memory.|int|KB|
|`mem_capacity_usage_average`|Amount of physical memory actively used.|int|KB|
|`mem_compressed_average`|Amount of memory reserved by `userworlds`.|float|KB|
|`mem_compressionRate_average`|Rate of memory compression for the virtual machine.|float|KB|
|`mem_consumed_average`|Amount of host physical memory consumed by a virtual machine, host, or cluster.|float|KB|
|`mem_consumed_userworlds.avg`|Amount of physical memory consumed by `userworlds` on this host.|int|KB|
|`mem_consumed_vms.avg`|Amount of physical memory consumed by VMs on this host.|int|KB|
|`mem_decompressionRate_average`|Rate of memory decompression for the virtual machine.|float|KB|
|`mem_granted_average`|Amount of host physical memory or physical memory that is mapped for a virtual machine or a host.|float|KB|
|`mem_heap_average`|VMkernel virtual address space dedicated to VMkernel main heap and related data.|int|KB|
|`mem_heapfree_average`|Free address space in the VMkernel main heap.Varies based on number of physical devices and configuration options. There is no direct way for the user to increase or decrease this statistic. For informational purposes only: not useful for performance monitoring.|int|KB|
|`mem_latency_average`|Percentage of time the virtual machine is waiting to access swapped or compressed memory.|float|percent|
|`mem_llSwapInRate_average`|Rate at which memory is being swapped from host cache into active memory.|float|KB|
|`mem_llSwapIn_average`|Amount of memory swapped-in from host cache.|int|KB|
|`mem_llSwapOutRate_average`|Rate at which memory is being swapped from active memory to host cache.|float|KB|
|`mem_llSwapOut_average`|Amount of memory swapped-out to host cache.|int|KB|
|`mem_llSwapUsed_average`|Space used for caching swapped pages in the host cache.|float|KB|
|`mem_lowfreethreshold_average`|Threshold of free host physical memory below which ESX/ESXi will begin reclaiming memory from virtual machines through ballooning and swapping.|int|KB|
|`mem_overhead_average`|Host physical memory consumed by the virtualization infrastructure for running the virtual machine.|float|KB|
|`mem_reservedCapacity_average`|Total amount of memory reservation used by powered-on virtual machines and vSphere services on the host.|int|MB|
|`mem_shared_average`|Amount of guest physical memory that is shared with other virtual machines, relative to a single virtual machine or to all powered-on virtual machines on a host.|float|KB|
|`mem_sharedcommon_average`|Amount of machine memory that is shared by all powered-on virtual machines and vSphere services on the host.|int|KB|
|`mem_state_latest`|One of four threshold levels representing the percentage of free memory on the host. The counter value determines swapping and ballooning behavior for memory reclamation.|int|KB|
|`mem_swapinRate_average`|Rate at which memory is swapped from disk into active memory.|float|KB|
|`mem_swapin_average`|Amount of memory swapped-in from disk.|float|KB|
|`mem_swapoutRate_average`|Rate at which memory is being swapped from active memory to disk.|float|KB|
|`mem_swapout_average`|Amount of memory swapped-out to disk.|float|KB|
|`mem_swapused_average`|Amount of memory that is used by swap. Sum of memory swapped of all powered on VMs and vSphere services on the host.|int|KB|
|`mem_sysUsage_average`|Amount of host physical memory used by VMkernel for core functionality, such as device drivers and other internal uses. Does not include memory used by virtual machines or vSphere services.|int|KB|
|`mem_totalCapacity_average`|Total amount of memory reservation used by and available for powered-on virtual machines and vSphere services on the host.|int|MB|
|`mem_unreserved_average`|Amount of memory that is unreserved. Memory reservation not used by the Service Console, VMkernel, vSphere services and other powered on VMs user-specified memory reservations and overhead memory.|int|KB|
|`mem_usage_average`|Memory usage as percent of total configured or available memory|float|percent|
|`mem_vmfs_pbc_capMissRatio_latest`|Trailing average of the ratio of capacity misses to compulsory misses for the `VMFS` PB Cache.|int|percent|
|`mem_vmfs_pbc_overhead_latest`|Amount of `VMFS` heap used by the `VMFS` PB Cache.|int|KB|
|`mem_vmfs_pbc_sizeMax_latest`|Maximum size the `VMFS` Pointer Block Cache can grow to.|int|MB|
|`mem_vmfs_pbc_size_latest`|Space used for holding `VMFS` Pointer Blocks in memory.|int|MB|
|`mem_vmfs_pbc_workingSetMax_latest`|Maximum amount of file blocks whose addresses are cached in the `VMFS` PB Cache.|int|TB|
|`mem_vmfs_pbc_workingSet_latest`|Amount of file blocks whose addresses are cached in the `VMFS` PB Cache.|int|TB|
|`mem_vmmemctl_average`|Amount of memory allocated by the virtual machine memory control driver (`vmmemctl`).|int|KB|
|`mem_zero_average`|Memory that contains 0s only. Included in shared amount. Through transparent page sharing, zero memory pages can be shared among virtual machines that run the same operating system.|int|KB|
|`net_broadcastRx_sum`|Number of broadcast packets received.|int|-|
|`net_broadcastTx_sum`|Number of broadcast packets transmitted.|int|-|
|`net_bytesRx_average`|Average amount of data received per second.|int|KB|
|`net_bytesTx_average`|Average amount of data transmitted per second.|int|KB|
|`net_droppedRx_sum`|Number of received packets dropped.|int|-|
|`net_droppedTx_sum`|Number of transmitted packets dropped.|int|-|
|`net_errorsRx_sum`|Number of packets with errors received.|int|-|
|`net_errorsTx_sum`|Number of packets with errors transmitted.|int|-|
|`net_multicastRx_sum`|Number of multicast packets received.|int|-|
|`net_multicastTx_sum`|Number of multicast packets transmitted.|int|-|
|`net_packetsRx_sum`|Number of packets received.|int|-|
|`net_packetsTx_sum`|Number of packets transmitted.|int|-|
|`net_received_average`|Average rate at which data was received during the interval. This represents the bandwidth of the network.|float|KB|
|`net_throughput_usage_average`|The current network bandwidth usage for the host.|float|KB|
|`net_transmitted_average`|Average rate at which data was transmitted during the interval. This represents the bandwidth of the network.|float|KB|
|`net_unknownProtos_sum`|Number of frames with unknown protocol received.|int|KB|
|`net_usage_average`|Network utilization (combined transmit- and receive-rates).|float|KB|
|`power_energy_sum`|Total energy (in joule) used since last stats reset.|int|-|
|`power_powerCap_average`|Maximum allowed power usage.|int|-|
|`power_power_average`|Current power usage.|int|-|
|`rescpu_actav15_latest`|CPU active average over 15 minutes.|int|percent|
|`rescpu_actav1_latest`|CPU active average over 1 minute.|int|percent|
|`rescpu_actav5_latest`|CPU active average over 5 minutes.|int|percent|
|`rescpu_actpk15_latest`|CPU active peak over 15 minutes.|int|percent|
|`rescpu_actpk1_latest`|CPU active peak over 1 minute.|int|percent|
|`rescpu_actpk5_latest`|CPU active peak over 5 minutes.|int|percent|
|`rescpu_maxLimited15_latest`|Amount of CPU resources over the limit that were refused, average over 15 minutes.|int|percent|
|`rescpu_maxLimited1_latest`|Amount of CPU resources over the limit that were refused, average over 1 minute.|int|percent|
|`rescpu_maxLimited5_latest`|Amount of CPU resources over the limit that were refused, average over 5 minutes.|int|percent|
|`rescpu_runav15_latest`|CPU running average over 15 minutes.|int|percent|
|`rescpu_runav1_latest`|CPU running average over 1 minute.|int|percent|
|`rescpu_runav5_latest`|CPU running average over 5 minutes.|int|percent|
|`rescpu_runpk15_latest`|CPU running peak over 15 minutes.|int|percent|
|`rescpu_runpk1_latest`|CPU running peak over 1 minute.|int|percent|
|`rescpu_runpk5_latest`|CPU running peak over 5 minutes.|int|percent|
|`rescpu_sampleCount_latest`|Group CPU sample count.|int|-|
|`rescpu_samplePeriod_latest`|Group CPU sample period.|int|ms|
|`storageAdapter_commandsAveraged_average`|Average number of commands issued per second by the storage adapter.|int|-|
|`storageAdapter_maxTotalLatency_latest`|Highest latency value across all storage adapters used by the host.|int|ms|
|`storageAdapter_numberReadAveraged_average`|Average number of read commands issued per second by the storage adapter.|int|-|
|`storageAdapter_numberWriteAveraged_average`|Average number of write commands issued per second by the storage adapter.|int|-|
|`storageAdapter_outstandingIOs_average`|The number of I/Os that have been issued but have not yet completed.|int|-|
|`storageAdapter_queueDepth_average`|The maximum number of I/Os that can be outstanding at a given time.|int|-|
|`storageAdapter_queueLatency_average`|Average amount of time spent in the VMkernel queue per SCSI command.|int|-|
|`storageAdapter_queued_average`|The current number of I/Os that are waiting to be issued.|int|-|
|`storageAdapter_read_average`|Rate of reading data by the storage adapter.|int|KB|
|`storageAdapter_totalReadLatency_average`|Average amount of time for a read operation by the storage adapter.|int|ms|
|`storageAdapter_totalWriteLatency_average`|Average amount of time for a write operation by the storage adapter.|int|ms|
|`storageAdapter_write_average`|Rate of writing data by the storage adapter.|int|KB|
|`storagePath_busResets_sum`|Number of SCSI-bus reset commands issued.|int|-|
|`storagePath_commandsAborted_sum`|Number of SCSI commands aborted.|int|-|
|`storagePath_commandsAveraged_average`|Average number of commands issued per second on the storage path during the collection interval.|int|-|
|`storagePath_maxTotalLatency_latest`|Highest latency value across all storage paths used by the host.|int|ms|
|`storagePath_numberReadAveraged_average`|Average number of read commands issued per second on the storage path during the collection interval.|int|-|
|`storagePath_numberWriteAveraged_average`|Average number of write commands issued per second on the storage path during the collection interval.|int|-|
|`storagePath_read_average`|Rate of reading data on the storage path.|int|KB|
|`storagePath_totalReadLatency_average`|Average amount of time for a read issued on the storage path. Total latency = kernel latency + device latency.|int|ms|
|`storagePath_totalWriteLatency_average`|Average amount of time for a write issued on the storage path. Total latency = kernel latency + device latency.|int|ms|
|`storagePath_write_average`|Rate of writing data on the storage path.|int|KB|
|`sys_resourceCpuAct1_latest`|CPU active average over 1 minute of the system resource group.|int|percent|
|`sys_resourceCpuAct5_latest`|CPU active average over 5 minutes of the system resource group.|int|percent|
|`sys_resourceCpuAllocMax_latest`|CPU allocation limit (in MHz) of the system resource group.|int|-|
|`sys_resourceCpuAllocMin_latest`|CPU allocation reservation (in MHz) of the system resource group.|int|-|
|`sys_resourceCpuAllocShares_latest`|CPU allocation shares of the system resource group.|int|-|
|`sys_resourceCpuMaxLimited1_latest`|CPU maximum limited over 1 minute of the system resource group.|int|percent|
|`sys_resourceCpuMaxLimited5_latest`|CPU maximum limited over 5 minutes of the system resource group.|int|percent|
|`sys_resourceCpuRun1_latest`|CPU running average over 1 minute of the system.|int|percent|
|`sys_resourceCpuRun5_latest`|CPU running average over 5 minutes of the system resource group.|int|percent|
|`sys_resourceCpuUsage_average`|Amount of CPU used by the Service Console and other applications during the interval by the Service Console and other applications.|int|-|
|`sys_resourceFdUsage_latest`|Number of file descriptors used by the system resource group.|int|-|
|`sys_resourceMemAllocMax_latest`|Memory allocation limit (in KB) of the system resource group.|int|KB|
|`sys_resourceMemAllocMin_latest`|Memory allocation reservation (in KB) of the system resource group.|int|KB|
|`sys_resourceMemAllocShares_latest`|Memory allocation shares of the system resource group.|int|-|
|`sys_resourceMemConsumed_latest`|Memory consumed by the system resource group.|int|KB|
|`sys_resourceMemCow_latest`|Memory shared by the system resource group.|int|KB|
|`sys_resourceMemMapped_latest`|Memory mapped by the system resource group.|int|KB|
|`sys_resourceMemOverhead_latest`|Overhead memory consumed by the system resource group.|int|KB|
|`sys_resourceMemShared_latest`|Memory saved due to sharing by the system resource group.|int|KB|
|`sys_resourceMemSwapped_latest`|Memory swapped out by the system resource group.|int|KB|
|`sys_resourceMemTouched_latest`|Memory touched by the system resource group.|int|KB|
|`sys_resourceMemZero_latest`|Zero filled memory used by the system resource group.|int|KB|
|`sys_uptime_latest`|Total time elapsed since last system startup|int|s|
|`virtualDisk_busResets_sum`|Number of SCSI-bus reset commands issued.|int|-|
|`virtualDisk_commandsAborted_sum`|Number of SCSI commands aborted|int|-|






### `vsphere_vm`



- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name`|Cluster name|
|`dcname`|`Datacenter` name|
|`esx_hostname`|The name of the ESXi host|
|`host`|The host of the vCenter|
|`instance`|The name of the instance|
|`moid`|The managed object id|
|`vm_name`|The name of the resource|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_capacity_contention_average`|Percent of time the virtual machine is unable to run because it is contending for access to the physical CPU(s).|float|percent|
|`cpu_capacity_demand_average`|The amount of CPU resources a virtual machine would use if there were no CPU contention or CPU limit.|int|-|
|`cpu_capacity_usage_average`|CPU usage as a percent during the interval.|int|-|
|`cpu_costop_sum`|Time the virtual machine is ready to run, but is unable to run due to co-scheduling constraints.|int|ms|
|`cpu_demandEntitlementRatio_latest`|CPU resource entitlement to CPU demand ratio (in percents).|float|percent|
|`cpu_demand_average`|The amount of CPU resources a virtual machine would use if there were no CPU contention or CPU limit.|int|-|
|`cpu_entitlement_latest`|CPU resources devoted by the ESXi scheduler.|int|-|
|`cpu_idle_sum`|Total time that the CPU spent in an idle state.|int|ms|
|`cpu_latency_average`|Percent of time the virtual machine is unable to run because it is contending for access to the physical CPU(s).|int|percent|
|`cpu_maxlimited_sum`|Time the virtual machine is ready to run, but is not running because it has reached its maximum CPU limit setting.|int|ms|
|`cpu_overlap_sum`|Time the virtual machine was interrupted to perform system services on behalf of itself or other virtual machines.|int|ms|
|`cpu_readiness_average`|Percentage of time that the virtual machine was ready, but could not get scheduled to run on the physical CPU.|int|percent|
|`cpu_ready_sum`|Milliseconds of CPU time spent in ready state.|int|ms|
|`cpu_run_sum`|Time the virtual machine is scheduled to run.|int|ms|
|`cpu_swapwait_sum`|CPU time spent waiting for swap-in.|int|ms|
|`cpu_system_sum`|Amount of time spent on system processes on each virtual CPU in the virtual machine. This is the host view of the CPU usage, not the guest operating system view.|int|ms|
|`cpu_usage_average`|Percentage of CPU capacity being used.|float|percent|
|`cpu_usagemhz_average`|CPU usage, as measured in megahertz.|float|-|
|`cpu_used_sum`|Time accounted to the virtual machine. If a system service runs on behalf of this virtual machine, the time spent by that service (represented by cpu.system) should be charged to this virtual machine. If not, the time spent (represented by cpu.overlap) should not be charged against this virtual machine.|int|ms|
|`cpu_wait_sum`|Total CPU time spent in wait state.The wait total includes time spent the CPU Idle, CPU Swap Wait, and CPU I/O Wait states.|int|ms|
|`datastore_maxTotalLatency_latest`|Highest latency value across all datastores used by the host.|int|ms|
|`datastore_numberReadAveraged_average`|Average number of read commands issued per second to the datastore.|float|-|
|`datastore_numberWriteAveraged_average`|Average number of write commands issued per second to the datastore during the collection interval.|float|-|
|`datastore_read_average`|Rate of reading data from the datastore.|float|KB|
|`datastore_totalReadLatency_average`|Average amount of time for a read operation from the datastore.|float|ms|
|`datastore_totalWriteLatency_average`|Average amount of time for a write operation from the datastore.|float|ms|
|`datastore_write_average`|Rate of writing data to the datastore.|float|KB|
|`disk_busResets_sum`|Number of SCSI-bus reset commands issued.|int|-|
|`disk_commandsAborted_sum`|Number of SCSI commands aborted.|int|-|
|`disk_commandsAveraged_average`|Average number of SCSI commands issued per second.|int|-|
|`disk_commands_sum`|Number of SCSI commands issued|int|-|
|`disk_maxTotalLatency_latest`|Highest latency value across all disks used by the host.|int|ms|
|`disk_numberReadAveraged_average`|Average number of read commands issued per second to the datastore.|int|-|
|`disk_numberRead_sum`|Number of disk reads during the collection interval.|int|-|
|`disk_numberWriteAveraged_average`|Average number of write commands issued per second to the datastore.|float|-|
|`disk_numberWrite_sum`|Number of disk writes during the collection interval.|int|-|
|`disk_read_average`|Average number of kilobytes read from the disk each second.|float|KB|
|`disk_usage_average`|Aggregated disk I/O rate.|float|KB|
|`disk_write_average`|Average number of kilobytes written to the disk each second.|float|KB|
|`hbr_hbrNetRx_average`|Kilobytes per second of outgoing host-based replication network traffic (for this virtual machine or host).|float|KB|
|`hbr_hbrNetTx_average`|Average amount of data transmitted per second.|float|KB|
|`mem_active_average`|Amount of memory that is actively used, as estimated by VMkernel based on recently touched memory pages.|float|KB|
|`mem_activewrite_average`|Estimate for the amount of memory actively being written to by the virtual machine.|float|KB|
|`mem_capacity_contention_average`|Percentage of time VMs are waiting to access swapped, compressed or ballooned memory.|int|KB|
|`mem_capacity_usage_average`|Amount of physical memory actively used.|int|KB|
|`mem_compressed_average`|Amount of memory reserved by `userworlds`.|float|KB|
|`mem_compressionRate_average`|Rate of memory compression for the virtual machine.|float|KB|
|`mem_consumed_average`|Amount of host physical memory consumed by a virtual machine, host, or cluster.|float|KB|
|`mem_decompressionRate_average`|Rate of memory decompression for the virtual machine.|float|KB|
|`mem_entitlement_average`|Amount of host physical memory the virtual machine is entitled to, as determined by the ESX scheduler.|float|KB|
|`mem_granted_average`|Amount of host physical memory or physical memory that is mapped for a virtual machine or a host.|float|KB|
|`mem_latency_average`|Percentage of time the virtual machine is waiting to access swapped or compressed memory.|float|percent|
|`mem_llSwapInRate_average`|Rate at which memory is being swapped from host cache into active memory.|float|KB|
|`mem_llSwapOutRate_average`|Rate at which memory is being swapped from active memory to host cache.|float|KB|
|`mem_llSwapUsed_average`|Space used for caching swapped pages in the host cache.|float|KB|
|`mem_overheadMax_average`|Host physical memory reserved for use as the virtualization overhead for the virtual machine.|float|KB|
|`mem_overheadTouched_average`|Actively touched overhead host physical memory (KB) reserved for use as the virtualization overhead for the virtual machine.|float|KB|
|`mem_overhead_average`|Host physical memory consumed by the virtualization infrastructure for running the virtual machine.|float|KB|
|`mem_shared_average`|Amount of guest physical memory that is shared with other virtual machines, relative to a single virtual machine or to all powered-on virtual machines on a host.|float|KB|
|`mem_swapinRate_average`|Rate at which memory is swapped from disk into active memory.|float|KB|
|`mem_swapin_average`|Amount of memory swapped-in from disk.|float|KB|
|`mem_swapoutRate_average`|Rate at which memory is being swapped from active memory to disk.|float|KB|
|`mem_swapout_average`|Amount of memory swapped-out to disk.|float|KB|
|`mem_swapped_average`|Current amount of guest physical memory swapped out to the virtual machine swap file by the VMkernel. Swapped memory stays on disk until the virtual machine needs it. This statistic refers to VMkernel swapping and not to guest OS swapping.|float|KB|
|`mem_swaptarget_average`|Target size for the virtual machine swap file. The VMkernel manages swapping by comparing `swaptarget` against swapped.|float|KB|
|`mem_usage_average`|Memory usage as percent of total configured or available memory|float|percent|
|`mem_vmmemctl_average`|Amount of memory allocated by the virtual machine memory control driver (`vmmemctl`).|int|KB|
|`mem_vmmemctltarget_average`|Target value set by `VMkernal` for the virtual machine's memory balloon size. In conjunction with `vmmemctl` metric, this metric is used by VMkernel to inflate and deflate the balloon for a virtual machine.|int|KB|
|`mem_zero_average`|Memory that contains 0s only. Included in shared amount. Through transparent page sharing, zero memory pages can be shared among virtual machines that run the same operating system.|int|KB|
|`mem_zipSaved_latest`|Memory saved due to memory zipping.|int|KB|
|`mem_zipped_latest`|Memory zipped|int|KB|
|`net_broadcastRx_sum`|Number of broadcast packets received.|int|-|
|`net_broadcastTx_sum`|Number of broadcast packets transmitted.|int|-|
|`net_bytesRx_average`|Average amount of data received per second.|int|KB|
|`net_bytesTx_average`|Average amount of data transmitted per second.|int|KB|
|`net_droppedRx_sum`|Number of received packets dropped.|int|-|
|`net_droppedTx_sum`|Number of transmitted packets dropped.|int|-|
|`net_multicastRx_sum`|Number of multicast packets received.|int|-|
|`net_multicastTx_sum`|Number of multicast packets transmitted.|int|-|
|`net_packetsRx_sum`|Number of packets received.|int|-|
|`net_packetsTx_sum`|Number of packets transmitted.|int|-|
|`net_pnicBytesRx_average`|Average number of bytes received per second by a physical network interface card (`PNIC`) on an ESXi host.|float|B|
|`net_pnicBytesTx_average`|Average number of bytes transmitted per second by a physical network interface card (`PNIC`) on an ESXi host.|float|B|
|`net_received_average`|Average rate at which data was received during the interval. This represents the bandwidth of the network.|float|KB|
|`net_throughput_usage_average`|The current network bandwidth usage for the host.|float|KB|
|`net_transmitted_average`|Average rate at which data was transmitted during the interval. This represents the bandwidth of the network.|float|KB|
|`net_usage_average`|Network utilization (combined transmit- and receive-rates).|float|KB|
|`power_energy_sum`|Total energy (in joule) used since last stats reset.|int|-|
|`power_power_average`|Current power usage.|int|-|
|`rescpu_actav15_latest`|CPU active average over 15 minutes.|int|percent|
|`rescpu_actav1_latest`|CPU active average over 1 minute.|int|percent|
|`rescpu_actav5_latest`|CPU active average over 5 minutes.|int|percent|
|`rescpu_actpk15_latest`|CPU active peak over 15 minutes.|int|percent|
|`rescpu_actpk1_latest`|CPU active peak over 1 minute.|int|percent|
|`rescpu_actpk5_latest`|CPU active peak over 5 minutes.|int|percent|
|`rescpu_maxLimited15_latest`|Amount of CPU resources over the limit that were refused, average over 15 minutes.|int|percent|
|`rescpu_maxLimited1_latest`|Amount of CPU resources over the limit that were refused, average over 1 minute.|int|percent|
|`rescpu_maxLimited5_latest`|Amount of CPU resources over the limit that were refused, average over 5 minutes.|int|percent|
|`rescpu_runav15_latest`|CPU running average over 15 minutes.|int|percent|
|`rescpu_runav1_latest`|CPU running average over 1 minute.|int|percent|
|`rescpu_runav5_latest`|CPU running average over 5 minutes.|int|percent|
|`rescpu_runpk15_latest`|CPU running peak over 15 minutes.|int|percent|
|`rescpu_runpk1_latest`|CPU running peak over 1 minute.|int|percent|
|`rescpu_runpk5_latest`|CPU running peak over 5 minutes.|int|percent|
|`rescpu_sampleCount_latest`|Group CPU sample count.|int|-|
|`rescpu_samplePeriod_latest`|Group CPU sample period.|int|ms|
|`sys_heartbeat_latest`|Number of heartbeats issued per virtual machine.|int|-|
|`sys_heartbeat_sum`|Number of heartbeats issued per virtual machine.|int|-|
|`sys_osUptime_latest`|Total time elapsed, in seconds, since last operating system boot-up.|int|s|
|`sys_uptime_latest`|Total time elapsed since last system startup|int|s|
|`virtualDisk_busResets_sum`|Number of SCSI-bus reset commands issued.|int|-|
|`virtualDisk_commandsAborted_sum`|Number of SCSI commands aborted|int|-|
|`virtualDisk_largeSeeks_latest`|Number of seeks during the interval that were greater than 8192 LBNs apart.|int|-|
|`virtualDisk_mediumSeeks_latest`|Number of seeks during the interval that were between 64 and 8192 LBNs apart.|int|-|
|`virtualDisk_numberReadAveraged_average`|Average number of read commands issued per second to the virtual disk.|int|-|
|`virtualDisk_numberWriteAveraged_average`|Average number of write commands issued per second to the virtual disk.|int|-|
|`virtualDisk_readIOSize_latest`|Average read request size in bytes.|int|B|
|`virtualDisk_readLatencyUS_latest`|Read latency in microseconds.|int|μs|
|`virtualDisk_readLoadMetric_latest`|Storage DRS virtual disk metric for the read workload model.|int|-|
|`virtualDisk_readOIO_latest`|Average number of outstanding read requests to the virtual disk.|int|-|
|`virtualDisk_read_average`|Average number of kilobytes read from the virtual disk each second.|int|-|
|`virtualDisk_smallSeeks_latest`|Number of seeks during the interval that were less than 64 LBNs apart.|int|-|
|`virtualDisk_totalReadLatency_average`|Average amount of time for a read operation from the virtual disk.|int|ms|
|`virtualDisk_totalWriteLatency_average`|Average amount of time for a write operation from the virtual disk.|int|ms|
|`virtualDisk_writeIOSize_latest`|Average write request size in bytes.|int|B|
|`virtualDisk_writeLatencyUS_latest`|Write latency in microseconds.|int|μs|
|`virtualDisk_writeLoadMetric_latest`|Storage DRS virtual disk metric for the write workload model.|int|-|
|`virtualDisk_writeOIO_latest`|Average number of outstanding write requests to the virtual disk.|int|-|
|`virtualDisk_write_average`|Average number of kilobytes written to the virtual disk each second.|int|KB|
























<!-- markdownlint-disable MD024 -->
## 对象 {#object}





















### `vsphere_cluster`

The object of the cluster.

- 标签


| Tag | Description |
|  ----  | --------|
|`name`|The name of the cluster|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`effective_cpu`|Effective CPU resources (in MHz) available to run virtual machines.|int|count|
|`effective_memory`|Effective memory resources (in MB) available to run virtual machines. |int|MB|
|`num_cpu_cores`|Number of physical CPU cores. Physical CPU cores are the processors contained by a CPU package.|int|count|
|`num_cpu_threads`|Aggregated number of CPU threads.|int|count|
|`num_effective_hosts`|Total number of effective hosts.|int|count|
|`num_hosts`|Total number of hosts.|int|count|
|`total_cpu`|Aggregated CPU resources of all hosts, in MHz.|int|-|
|`total_memory`|Aggregated memory resources of all hosts, in bytes.|int|B|






### `vsphere_datastore`

The object of the datastore.

- 标签


| Tag | Description |
|  ----  | --------|
|`name`|The name of the datastore|
|`type`|Type of file system volume, such as `VMFS` or NFS|
|`url`|The unique locator for the datastore|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`free_space`|Free space of this datastore, in bytes. The server periodically updates this value. It can be explicitly refreshed with the Refresh operation.|int|B|
|`max_file_size`|The maximum size of a file that can reside on this file system volume.|int|B|
|`max_memory_file_size`|The maximum size of a snapshot or a swap file that can reside on this file system volume.|int|B|
|`max_virtual_disk_capacity`|The maximum capacity of a virtual disk which can be created on this volume.|int|B|






### `vsphere_host`

The object of the ESXi host.

- 标签


| Tag | Description |
|  ----  | --------|
|`connection_state`|The host connection state|
|`cpu_model`|The CPU model|
|`model`|The system model identification|
|`name`|The name of the ESXi host|
|`vendor`|The hardware vendor identification|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`boot_time`|The time when the host was booted.|int|nsec|
|`memory_size`|The physical memory size in bytes.|int|B|
|`num_cpu_cores`|Number of physical CPU cores on the host. Physical CPU cores are the processors contained by a CPU package.|int|count|
|`num_nics`|The number of network adapters.|int|count|






### `vsphere_vm`

The object of the virtual machine.

- 标签


| Tag | Description |
|  ----  | --------|
|`connection_state`|Indicates whether or not the virtual machine is available for management|
|`guest_full_name`|Guest operating system full name, if known|
|`host_name`|Hostname of the guest operating system, if known|
|`ip_address`|Primary IP address assigned to the guest operating system, if known|
|`name`|The name of the virtual machine|
|`template`|Flag to determine whether or not this virtual machine is a template.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`boot_time`|The timestamp when the virtual machine was most recently powered on.|int|nsec|
|`max_cpu_usage`|Current upper-bound on CPU usage.|int|-|
|`max_memory_usage`|Current upper-bound on memory usage.|int|-|
|`memory_size_mb`|Memory size of the virtual machine, in megabytes.|int|count|
|`num_cpu`|Number of processors in the virtual machine.|int|count|
|`num_ethernet_cards`|Number of virtual network adapters.|int|count|
|`num_virtual_disks`|Number of virtual disks attached to the virtual machine.|int|count|








<!-- markdownlint-enable -->
## 日志 {#logging}





































### `vsphere_event`

The event of the vSphere.

- 标签


| Tag | Description |
|  ----  | --------|
|`change_tag`|The user entered tag to identify the operations and their side effects|
|`event_type_id`|The type of the event|
|`host`|The host of the vCenter|
|`object_name`|The name of the object|
|`resource_type`|The resource type, such as host, vm, datastore|
|`status`|The status of the logging|
|`user_name`|The user who caused the event|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`chain_id`|The parent or group ID.|int|-|
|`event_key`|The event ID.|int|-|
|`message`|A formatted text message describing the event. The message may be localized.|string|-|


