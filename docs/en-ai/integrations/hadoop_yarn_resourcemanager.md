---
title     : 'Hadoop Yarn ResourceManager'
summary   : 'Collect Metrics information from Yarn ResourceManager'
__int_icon: 'icon/hadoop-yarn'
dashboard :
  - desc  : 'Yarn ResourceManager'
    path  : 'dashboard/en/hadoop_yarn_resourcemanager'
monitor   :
  - desc  : 'Yarn ResourceManager'
    path  : 'monitor/en/hadoop_yarn_resourcemanager'
---

<!-- markdownlint-disable MD025 -->
# Hadoop Yarn ResourceManager
<!-- markdownlint-enable -->

Collect Metrics information from Yarn ResourceManager.

## Installation and Deployment {#config}

Since ResourceManager is developed in Java, it can use the jmx-exporter method to collect metrics information.

### 1. ResourceManager Configuration

#### 1.1 Download jmx-exporter

Download link: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx Script

Download link: `https://github.com/lrwh/jmx-exporter/blob/main/hadoop-yarn-resourcemanager.yml`

#### 1.3 Adjust ResourceManager Startup Parameters

Add the following to the resourcemanager startup parameters:

> {JAVA_GC_ARGS} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17109:/opt/guance/jmx/jmx_resource_manager.yml

#### 1.4 Restart ResourceManager

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure the Collector

The jmx-exporter exposes a `metrics` URL directly, so the [`prom`](./prom.md) collector can be used for collection.

Navigate to the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, copy `prom.conf.sample` to `resourcemanager.conf`.

> `cp prom.conf.sample resourcemanager.conf`

Adjust the contents of `resourcemanager.conf` as follows:

```toml

  urls = ["http://localhost:17109/metrics"]
  source ="yarn-resourcemanager"
  [inputs.prom.tags]
    component = "yarn-resourcemanager" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations can be adjusted as needed*</font>
<!-- markdownlint-enable -->
Parameter adjustment explanation:

<!-- markdownlint-disable MD004 -->
- urls: The `jmx-exporter` metrics address, fill in the metrics URL exposed by the corresponding component
- source: Alias for the collector, suggested for differentiation
- keep_exist_metric_name: Keep metric names
- interval: Collection interval
- inputs.prom.tags: Add additional tags
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Metrics Set

ResourceManager metrics are located under the Hadoop Metrics set, primarily introducing relevant metrics descriptions for ResourceManager.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`resourcemanager_activeapplications` | Number of active applications in ResourceManager | count |
|`resourcemanager_activeusers` | Number of active users in ResourceManager | count |
|`resourcemanager_aggregatecontainersallocated`| Total number of containers allocated by ResourceManager| count |
|`resourcemanager_aggregatecontainerspreempted`| Number of preempted containers in ResourceManager|count |
|`resourcemanager_aggregatecontainersreleased`| Number of released containers in ResourceManager| count |
|`resourcemanager_aggregatememorymbsecondspreempted`| Memory consumption per second of preempted containers | B/s |
|`resourcemanager_aggregatenodelocalcontainersallocated` | Total number of containers running locally on all nodes | count |
|`resourcemanager_aggregateoffswitchcontainersallocated` | Number of containers allocated by ResourceManager aggregated switch | count |
|`resourcemanager_aggregateracklocalcontainersallocated` | Number of aggregated local container racks | count |
|`resourcemanager_aggregatevcoresecondspreempted` | Number of CPU cores preempted by ResourceManager | byte |
|`resourcemanager_allocatedcontainers` | Number of containers allocated to applications by ResourceManager | count |
|`resourcemanager_allocatedmb` | Amount of memory allocated by ResourceManager | B/s |
|`resourcemanager_allocatedvcores` | Number of CPU cores allocated by ResourceManager | count |
|`resourcemanager_amlaunchdelayavgtime` | Average application launch delay time | ms |
|`resourcemanager_amlaunchdelaynumops` | Number of application launch delays | count |
|`resourcemanager_amregisterdelayavgtime` | Average registration delay time in ResourceManager | ms |
|`resourcemanager_amregisterdelaynumops` | Number of registration delays in ResourceManager | s |
|`resourcemanager_amresourceusagemb` | Number of container start operations performed by NodeManager | count |
|`resourcemanager_amresourceusagevcores` | Number of completed containers by NodeManager | count |
|`resourcemanager_appattemptfirstcontainerallocationdelayavgtime` | Number of failed containers by NodeManager | count |
|`resourcemanager_appattemptfirstcontainerallocationdelaynumops` | Number of exited containers by NodeManager | count |
|`resourcemanager_appscompleted` | Number of running containers by NodeManager | count |
|`resourcemanager_appsfailed` | Number of failed applications in ResourceManager | count |
|`resourcemanager_appskilled` | Number of terminated applications in ResourceManager | count |
|`resourcemanager_appspending` | Number of pending applications | count |
|`resourcemanager_appsrunning` | Number of running applications | count |
|`resourcemanager_appssubmitted` | Number of submitted applications in ResourceManager | count |
|`resourcemanager_availablemb` | Total available memory in ResourceManager | count |
|`resourcemanager_availablevcores` | Available CPU cores in ResourceManager | count |
|`resourcemanager_callqueuelength` | Length of the call queue in resource management area | count |
|`resourcemanager_continuousschedulingrunavgtime` | Average continuous scheduling run time in ResourceManager | ms |
|`resourcemanager_continuousschedulingrunimaxtime` | Maximum continuous scheduling run time in ResourceManager | ms |
|`resourcemanager_continuousschedulingrunimintime` | Minimum continuous scheduling run time in ResourceManager | ms |
|`resourcemanager_continuousschedulingruninumops` | Number of continuous scheduling operations in ResourceManager | count |
|`resourcemanager_continuousschedulingrunmaxtime` | Maximum continuous scheduling run time in ResourceManager | ms |
|`resourcemanager_continuousschedulingrunmintime` | Minimum continuous scheduling run time in ResourceManager | ms |
|`resourcemanager_continuousschedulingrunnumops` | Number of continuous scheduling operations in ResourceManager | count |
|`resourcemanager_deferredrpcprocessingtimenumops` | Number of deferred RPC processing time operations in ResourceManager | count |
|`resourcemanager_droppedpuball` | Number of times ResourceManager drops puball | count |
|`resourcemanager_fairsharemb` | Amount of memory allocation in ResourceManager | count |
|`resourcemanager_fairsharevcores` | Number of allocated CPU cores in ResourceManager | count |
|`resourcemanager_gccount` | Number of garbage collections in ResourceManager | count |
|`resourcemanager_gccountconcurrentmarksweep` | Number of concurrent mark-sweep garbage collections | count |
|`resourcemanager_gccountparnew` | Number of ParNew garbage collectors | ms |
|`resourcemanager_gcnuminfothresholdexceeded` | Number of times GC collection information exceeds threshold | count |
|`resourcemanager_gcnumwarnthresholdexceeded` | Number of times GC pause exceeds threshold | count |
|`resourcemanager_gctimemillis` | Time from last GC start to completion | ms |
|`resourcemanager_gctimemillisconcurrentmarksweep` | Number of successful log write operations by NodeManager | count |
|`resourcemanager_gctimemillisparnew` | Time from ParNew start to completion | ms |
|`resourcemanager_gctotalextrasleeptime` | Total extra sleep time in ResourceManager | ms |
|`resourcemanager_getgroupsavgtime` | Average time to get groups in ResourceManager | count |
|`resourcemanager_logerror` | Number of used heap memory by NodeManager | count |
|`resourcemanager_logfatal` | Maximum memory of NodeManager | byte |
|`resourcemanager_loginfailureavgtime` | Average login failure time in ResourceManager | ms |
|`resourcemanager_loginfailurenumops` | Number of login failures in ResourceManager | count |
|`resourcemanager_loginfo` | Number of login information entries in ResourceManager | count |
|`resourcemanager_loginsuccessavgtime` | Average successful login time in ResourceManager | ms |
|`resourcemanager_loginsuccessnumops` | Number of successful logins in ResourceManager | count |
|`resourcemanager_logwarn` | Number of log warnings in ResourceManager | count |
|`resourcemanager_maxamsharemb` | Maximum AM resource usage in ResourceManager | byte |
|`resourcemanager_maxamsharevcores` | Maximum shared CPU cores in ResourceManager | count |
|`resourcemanager_maxapps` | Maximum number of applications in ResourceManager | count |
|`resourcemanager_memheapcommittedm` | Amount of allocated memory in ResourceManager | byte |
|`resourcemanager_memheapmaxm` | Maximum amount of memory in ResourceManager | byte |
|`resourcemanager_memheapusedm` | Used memory in ResourceManager | byte |
|`resourcemanager_memmaxm` | Maximum memory in ResourceManager | byte |
|`resourcemanager_memnonheapcommittedm` | Amount of memory declared for allocation in ResourceManager | byte |
|`resourcemanager_memnonheapmaxm` | Maximum amount of declared memory in ResourceManager | byte |
|`resourcemanager_memnonheapusedm` | Declared used memory in ResourceManager | byte |
|`resourcemanager_minsharemb` | Minimum resource amount in ResourceManager | count |
|`resourcemanager_minsharevcores` | Minimum CPU cores in ResourceManager | byte |
|`resourcemanager_nodeheartbeatavgtime` | Average node heartbeat time in ResourceManager | s |
|`resourcemanager_nodeheartbeatnumops` | Number of node heartbeats in ResourceManager | count |
|`resourcemanager_nodeupdatecallavgtime` | Average response time for node updates in ResourceManager | s |
|`resourcemanager_nodeupdatecallimaxtime` | Maximum response time for node updates in ResourceManager | s |
|`resourcemanager_nodeupdatecallimintime` | Minimum response time for node updates in ResourceManager | s |
|`resourcemanager_nodeupdatecallinumops` | Number of node update responses in ResourceManager | count |
|`resourcemanager_numactivenms` | Number of currently active NodeManagers | count |
|`resourcemanager_numactivesinks` | Number of currently active sinks | count |
|`resourcemanager_numactivesources` | Number of active resources in ResourceManager | count |
|`resourcemanager_numallsinks` | Total number of sinks in ResourceManager | count |
|`resourcemanager_numallsources` | Total data volume of resources in ResourceManager | count |
|`resourcemanager_numdecommissionednms` | Number of decommissioned nodes in ResourceManager | count |
|`resourcemanager_numdecommissioningnms` | Number of nodes being decommissioned in ResourceManager | count |
|`resourcemanager_numdroppedconnections` | Number of dropped connections in ResourceManager | count |
|`resourcemanager_numlostnms` | Number of lost nodes in ResourceManager | count |
|`resourcemanager_numopenconnections` | Number of open connections in ResourceManager | count |
|`resourcemanager_numrebootednms` | Number of rebooted nodes in ResourceManager | count |
|`resourcemanager_numshutdownnms` | Number of shutdown nodes in ResourceManager | count |
|`resourcemanager_numunhealthynms` | Number of unhealthy nodes in ResourceManager | count |
|`resourcemanager_pendingcontainers` | Number of pending containers in ResourceManager | count |
|`resourcemanager_pendingmb` | Number of pending resources in ResourceManager | count |
|`resourcemanager_pendingvcores` | Number of pending CPU cores in ResourceManager | count |
|`resourcemanager_publishavgtime` | Average data publishing time in ResourceManager | s |
|`resourcemanager_rpcprocessingtimeavgtime` | Average RPC execution time in ResourceManager | s |
|`resourcemanager_rpcprocessingtimenumops` | Number of executions in ResourceManager | count |
|`resourcemanager_rpcqueuetimeavgtime` | Average RPC response time in ResourceManager | count |
|`resourcemanager_rpcqueuetimenumops` | Number of RPC response operations in ResourceManager | count |
|`resourcemanager_rpcslowcalls` | Slow RPC call time in ResourceManager | s |
|`resourcemanager_running_0` | Number of applications running for 0 seconds | count |
|`resourcemanager_running_1440` | Number of applications running for 1440 seconds | count |
|`resourcemanager_running_300` | Number of applications running for 300 seconds | count |
|`resourcemanager_running_60` | Number of applications running for 60 seconds | count |
|`resourcemanager_securityenabled` | Number of enabled security mechanisms in ResourceManager | count |
|`resourcemanager_sentbytes` | Number of bytes sent by ResourceManager | byte |
|`resourcemanager_snapshotavgtime` | Average snapshot time in ResourceManager | s |
|`resourcemanager_snapshotnumops` | Number of snapshot operations in ResourceManager | count |
|`resourcemanager_steadyfairsharemb` | Weighted shared memory in ResourceManager | byte |
|`resourcemanager_steadyfairsharevcores` | Weighted shared CPU cores in ResourceManager | count |
|`resourcemanager_threadsblocked` | Number of blocked threads in ResourceManager | count |
|`resourcemanager_threadsnew` | Number of newly created threads in ResourceManager | count |
|`resourcemanager_threadsrunnable` | Number of running threads in ResourceManager | count |
|`resourcemanager_threadsterminated` | Number of terminated threads in ResourceManager | count |
|`resourcemanager_threadstimedwaiting` | Number of timed waiting threads in ResourceManager | count |
|`resourcemanager_threadswaiting` | Number of waiting threads in ResourceManager | count |
|`resourcemanager_updatethreadrunavgtime` | Average thread update time in ResourceManager | s |
|`resourcemanager_updatethreadrunimaxtime` | Maximum thread update time in ResourceManager | s |
|`resourcemanager_updatethreadrunimintime` | Minimum thread update time in ResourceManager | s |
|`resourcemanager_updatethreadruninumops` | Number of thread update operations in ResourceManager | count |
|`resourcemanager_updatethreadrunmaxtime` | Maximum thread update time in ResourceManager | s |
|`resourcemanager_updatethreadrunmintime` | Minimum thread update time in ResourceManager | s |
|`resourcemanager_updatethreadrunnumops` | Number of thread update operations in ResourceManager | count |

</input_content>
<target_language>英语</target_language>
</input>
</instruction>
</example>