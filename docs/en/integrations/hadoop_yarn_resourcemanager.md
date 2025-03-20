---
title     : 'Hadoop Yarn ResourceManager'
summary   : 'Collect metrics information from Yarn ResourceManager'
__int_icon: 'icon/hadoop-yarn'
dashboard :
  - desc  : 'Yarn ResourceManager'
    path  : 'dashboard/zh/hadoop_yarn_resourcemanager'
monitor   :
  - desc  : 'Yarn ResourceManager'
    path  : 'monitor/zh/hadoop_yarn_resourcemanager'
---

<!-- markdownlint-disable MD025 -->
# Hadoop Yarn ResourceManager
<!-- markdownlint-enable -->

Collect metrics information from Yarn ResourceManager.

## Installation and Deployment {#config}

Since ResourceManager is developed in the JAVA languages, it can use the jmx-exporter method to collect metrics information.

### 1. ResourceManager Configuration

#### 1.1 Download jmx-exporter

Download address: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx Script

Download address: `https://github.com/lrwh/jmx-exporter/blob/main/hadoop-yarn-resourcemanager.yml`

#### 1.3 Adjust ResourceManager Startup Parameters

Add to the startup parameters of resourcemanager:

> {JAVA_GC_ARGS} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17109:/opt/guance/jmx/jmx_resource_manager.yml

#### 1.4 Restart ResourceManager

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure Collector

The jmx-exporter can directly expose `metrics` url, so it can be collected directly through the [`prom`](./prom.md) collector.

Enter the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, copy `prom.conf.sample` as `resourcemanager.conf`.

> `cp prom.conf.sample resourcemanager.conf`

Adjust the content of `resourcemanager.conf` as follows:

```toml

  urls = ["http://localhost:17109/metrics"]
  source ="yarn-resourcemanager"
  [inputs.prom.tags]
    component = "yarn-resourcemanager" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations should be adjusted as needed*</font>
<!-- markdownlint-enable -->
, parameter adjustment description:

<!-- markdownlint-disable MD004 -->
- urls: The `jmx-exporter` metrics address, fill in the corresponding component's exposed metrics url here.
- source: Collector alias, it is recommended to make distinctions.
- keep_exist_metric_name: Keep the metric name unchanged.
- interval: Collection interval.
- inputs.prom.tags: Add additional tags.
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Measurement

ResourceManager metrics are located under the Hadoop Measurement set, this mainly introduces the descriptions for ResourceManager-related metrics.

| Metrics | Description | Unit |
|:--------|:-----|:--|
|`resourcemanager_activeapplications` |`Number of active applications in the resource manager` | count |
|`resourcemanager_activeusers` |`Number of active users in the resource manager` | count |
|`resourcemanager_aggregatecontainersallocated`|`Number of containers allocated by the resource manager`| count |
|`resourcemanager_aggregatecontainerspreempted`|`Number of containers preempted by the resource manager`|count |
|`resourcemanager_aggregatecontainersreleased`|`Number of containers released by the resource manager`| count |
|`resourcemanager_aggregatememorymbsecondspreempted`|`Amount of memory consumed per second by preempted containers` | B/s |
|`resourcemanager_aggregatenodelocalcontainersallocated` |`Number of containers running locally on all nodes` | count |
|`resourcemanager_aggregateoffswitchcontainersallocated` |`Number of containers aggregated switch allocations by the resource manager` | count |
|`resourcemanager_aggregateracklocalcontainersallocated` |`Number of aggregated local container racks` | count |
|`resourcemanager_aggregatevcoresecondspreempted` |`Number of CPU cores used by the resource manager` | byte |
|`resourcemanager_allocatedcontainers` |`Number of containers allocated by the resource manager to applications` | count |
|`resourcemanager_allocatedmb` | `Amount of memory allocated by the resource manager` | B/s |
|`resourcemanager_allocatedvcores` |`Number of CPU cores allocated by the resource manager` | count |
|`resourcemanager_amlaunchdelayavgtime` |`Average application launch delay time` | ms |
|`resourcemanager_amlaunchdelaynumops` |`Number of application launch delays` | count |
|`resourcemanager_amregisterdelayavgtime` |`Average registration delay time for the resource manager` | ms |
|`resourcemanager_amregisterdelaynumops` |`Number of registration delays for the resource manager` | s |
|`resourcemanager_amresourceusagemb` | `Number of container start operations by the node manager`| count |
|`resourcemanager_amresourceusagevcores` |`Number of completed containers by the node manager` | count |
|`resourcemanager_appattemptfirstcontainerallocationdelayavgtime` |`Number of failed containers by the node manager` | count |
|`resourcemanager_appattemptfirstcontainerallocationdelaynumops` | `Number of exited containers by the node manager` | count |
|`resourcemanager_appscompleted` |`Number of running containers by the node manager` | count |
|`resourcemanager_appsfailed` |`Number of failed applications in the resource manager` | count |
|`resourcemanager_appskilled` |`Number of terminated applications in the resource manager` | count |
|`resourcemanager_appspending` |`Number of pending applications awaiting execution` | count |
|`resourcemanager_appsrunning` |`Number of currently running applications` | count |
|`resourcemanager_appssubmitted` |`Number of submitted applications in the resource manager` | count |
|`resourcemanager_availablemb` |`Total available memory in the resource manager` | count |
|`resourcemanager_availablevcores` |`Number of available CPU cores in the resource manager` | count |
|`resourcemanager_callqueuelength` |`Length of the call queue in the resource management area` | count |
|`resourcemanager_continuousschedulingrunavgtime` |`Average continuous scheduling run time in the resource manager` | ms |
|`resourcemanager_continuousschedulingrunimaxtime` |`Maximum continuous scheduling run time in the resource manager` | ms |
|`resourcemanager_continuousschedulingrunimintime` |`Minimum continuous scheduling run time in the resource manager` | ms |
|`resourcemanager_continuousschedulingruninumops` |`Number of continuous scheduling operations in the resource manager` | count |
|`resourcemanager_continuousschedulingrunmaxtime` |`Maximum continuous scheduling run time in the resource manager` | ms |
|`resourcemanager_continuousschedulingrunmintime` |`Minimum continuous scheduling run time in the resource manager` | ms |
|`resourcemanager_continuousschedulingrunnumops` |`Number of continuous scheduling operations in the resource manager` | count |
|`resourcemanager_deferredrpcprocessingtimenumops` |`Number of deferred RPC processing time operations in the resource manager` | count |
|`resourcemanager_droppedpuball` |`Number of times puball was dropped in the resource manager` | count |
|`resourcemanager_fairsharemb` |`Memory allocation in the resource manager` | count |
|`resourcemanager_fairsharevcores` |`Number of CPU core allocations in the resource manager` | count |
|`resourcemanager_gccount` |`Number of garbage collections in the resource manager` | count |
|`resourcemanager_gccountconcurrentmarksweep` |`Number of concurrent mark-sweep garbage collections` | count |
|`resourcemanager_gccountparnew` |`Number of parnew garbage collectors` | ms |
|`resourcemanager_gcnuminfothresholdexceeded` |`Number of times GC collection information exceeds threshold in the resource manager`| count |
|`resourcemanager_gcnumwarnthresholdexceeded` |`Number of times GC pause exceeds threshold in the resource manager` | count |
|`resourcemanager_gctimemillis` |`Time from last GC start to finish` | ms |
|`resourcemanager_gctimemillisconcurrentmarksweep` |`Number of successful log write operations by the node manager` | count |
|`resourcemanager_gctimemillisparnew` |`Time from parnew start to finish` | ms |
|`resourcemanager_gctotalextrasleeptime` |`Total extra sleep time in the resource manager` | ms |
|`resourcemanager_getgroupsavgtime` |`Average time to get groups in the resource manager` | count |
|`resourcemanager_logerror` |`Number of used memory heaps by the node manager` | count |
|`resourcemanager_logfatal` |`Maximum memory value of the node manager` | byte |
|`resourcemanager_loginfailureavgtime` |`Average login failure time in the resource manager` | ms |
|`resourcemanager_loginfailurenumops` |`Number of login failures in the resource manager` | count |
|`resourcemanager_loginfo` |`Number of login information entries in the resource manager` | count |
|`resourcemanager_loginsuccessavgtime` |`Average successful login time in the resource manager` | ms |
|`resourcemanager_loginsuccessnumops` |`Number of successful logins in the resource manager` | count |
|`resourcemanager_logwarn` |`Number of warning logs in the resource manager` | count |
|`resourcemanager_maxamsharemb` |`Maximum AM resource usage in the resource manager` | byte |
|`resourcemanager_maxamsharevcores` |`Maximum shared CPU core number in the resource manager` | count |
|`resourcemanager_maxapps` |`Maximum number of applications in the resource manager` | count |
|`resourcemanager_memheapcommittedm` |`Amount of memory allocated by the resource manager` | byte |
|`resourcemanager_memheapmaxm` |`Maximum amount of memory in the resource manager` | byte |
|`resourcemanager_memheapusedm` |`Amount of memory used by the resource manager` | byte |
|`resourcemanager_memmaxm` |`Maximum memory value in the resource manager` | byte |
|`resourcemanager_memnonheapcommittedm` |`Amount of memory declared to be allocated by the resource manager` | byte |
|`resourcemanager_memnonheapmaxm` | `Maximum amount of memory declared by the resource manager` | byte |
|`resourcemanager_memnonheapusedm` |`Amount of memory declared to be used by the resource manager` | byte  |
|`resourcemanager_minsharemb` |`Minimum resource amount in the resource manager` | count |
|`resourcemanager_minsharevcores` |`Minimum CPU core number in the resource manager` | byte |
|`resourcemanager_nodeheartbeatavgtime` |`Average node heartbeat time in the resource manager` | s |
|`resourcemanager_nodeheartbeatnumops` |`Number of node heartbeats in the resource manager` | count |
|`resourcemanager_nodeupdatecallavgtime` |`Average response time for node updates in the resource manager` | s |
|`resourcemanager_nodeupdatecallimaxtime` |`Maximum response time for nodes in the resource manager` | s |
|`resourcemanager_nodeupdatecallimintime` |`Minimum response time for node updates in the resource manager` | s  |
|`resourcemanager_nodeupdatecallinumops` |`Number of node update responses in the resource manager` | count |
|`resourcemanager_numactivenms` |`Number of currently active NodeManagers in the resource manager` | count |
|`resourcemanager_numactivesinks` |`Number of currently active sinks in the resource manager` | count |
|`resourcemanager_numactivesources` |`Number of active resources in the resource manager` | count |
|`resourcemanager_numallsinks` |`Total number of sinks in the resource manager` | count |
|`resourcemanager_numallsources` |`Total amount of resource data in the resource manager` | count |
|`resourcemanager_numdecommissionednms` |`Number of decommissioned nodes in the resource manager` | count |
|`resourcemanager_numdecommissioningnms` |`Number of nodes being decommissioned in the resource manager` | count |
|`resourcemanager_numdroppedconnections` |`Number of dropped connections in the resource manager` | count |
|`resourcemanager_numlostnms` |`Number of lost nodes in the resource manager` | count |
|`resourcemanager_numopenconnections` |`Number of open connections in the resource manager` | count |
|`resourcemanager_numrebootednms` |`Number of rebooted nodes in the resource manager` | count |
|`resourcemanager_numshutdownnms` |`Number of shutdown nodes in the resource manager` | count |
|`resourcemanager_numunhealthynms` |`Number of healthy nodes in the resource manager` | count |
|`resourcemanager_pendingcontainers` |`Number of containers waiting to be allocated in the resource manager` | count |
|`resourcemanager_pendingmb` |`Number of resources waiting to be allocated in the resource manager` | count |
|`resourcemanager_pendingvcores` |`Number of CPU cores waiting to be allocated in the resource manager` | count |
|`resourcemanager_publishavgtime` |`Average data publishing time in the resource manager` | s |
|`resourcemanager_rpcprocessingtimeavgtime` |`Average RPC execution time in the resource manager` | s |
|`resourcemanager_rpcprocessingtimenumops` |`Number of executions in the resource manager` | count |
|`resourcemanager_rpcqueuetimeavgtime` |`Average RPC response time in the resource manager` | count |
|`resourcemanager_rpcqueuetimenumops` |`Number of RPC response operations in the resource manager` | count |
|`resourcemanager_rpcslowcalls` |`Slow RPC call time in the resource manager` | s |
|`resourcemanager_running_0` |`Number of applications running for 0 seconds` | count |
|`resourcemanager_running_1440` |`Number of applications running for 1440 seconds` | count |
|`resourcemanager_running_300` |`Number of applications running for 300 seconds` | count |
|`resourcemanager_running_60` |`Number of applications running for 60 seconds` | count |
|`resourcemanager_securityenabled` |`Number of security mechanisms enabled in the resource manager` | count |
|`resourcemanager_sentbytes` |`Number of bytes sent by the resource manager` | byte |
|`resourcemanager_snapshotavgtime` |`Average snapshot time of data in the resource manager` | s |
|`resourcemanager_snapshotnumops` |`Number of snapshot operations in the resource manager`| count |
|`resourcemanager_steadyfairsharemb` |`Weighted shared memory in the resource manager`| byte |
|`resourcemanager_steadyfairsharevcores` |`Weighted shared CPU cores in the resource manager`| count |
|`resourcemanager_threadsblocked` |`Number of city locks in the resource manager`| count |
|`resourcemanager_threadsnew` |`Number of newly created threads in the resource manager`| count |
|`resourcemanager_threadsrunnable` |`Number of running threads in the resource manager`| count |
|`resourcemanager_threadsterminated` |`Number of terminated threads in the resource manager`| count |
|`resourcemanager_threadstimedwaiting` |`Number of timed-waiting threads in the resource manager`| count |
|`resourcemanager_threadswaiting` |`Number of waiting threads in the resource manager`| count |
|`resourcemanager_updatethreadrunavgtime` |`Average update thread time in the resource manager`| s |
|`resourcemanager_updatethreadrunimaxtime` |`Maximum thread update time in the resource manager`| s |
|`resourcemanager_updatethreadrunimintime` |`Minimum thread update time in the resource manager`| s |
|`resourcemanager_updatethreadruninumops` |`Number of thread update operations in the resource manager`| count |
|`resourcemanager_updatethreadrunmaxtime` |`Maximum thread update time in the resource manager`| s |
|`resourcemanager_updatethreadrunmintime` |`Minimum thread update time in the resource manager`| s |
|`resourcemanager_updatethreadrunnumops` |`Number of thread update operations in the resource manager`| count |