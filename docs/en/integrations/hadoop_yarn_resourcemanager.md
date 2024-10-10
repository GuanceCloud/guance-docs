---
title     : 'Hadoop Yarn ResourceManager'
summary   : 'Collect Yarn ResourceManager metric information'
__int_icon: 'icon/hadoop-yarn'
dashboard :
  - desc  : 'Yarn ResourceManager'
  - path  : 'dashboard/en/hadoop-yarn-resourcemanager'
monitor   :
  - desc  : 'Yarn ResourceManager'
  - path  : 'monitor/en/hadoop-yarn-resourcemanager'
---

<!-- markdownlint-disable MD025 -->
# Hadoop Yarn ResourceManager
<!-- markdownlint-enable -->

Collect Yarn ResourceManager metric information.

## Installation and deployment {#config}

Since ResourceManager is developed in Java language, it can collect metric information using jmx exporter.

### 1. ResourceManager Configuration

#### 1.1 Download jmx-exporter

Download link：`https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx script

Download link：`https://github.com/lrwh/jmx-exporter/blob/main/hadoop-yarn-resourcemanager.yml`

#### 1.3 ResourceManager startup parameter adjustment

Add startup parameters to resourcemanager

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17109:/opt/guance/jmx/jmx_resource_manager.yml

#### 1.4 Restart ResourceManager

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure collector

By using jmx exporter, the `metrics` URL can be directly exposed, so it can be collected directly through the [`prom`](./prom.md) collector.

Go to the installation directory of [DataKit](./datakit_dir.md) `conf.d/prom` and copy `prom.conf.sample` to `resourcemanager.conf`.

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
<font color="red">*Adjust other configurations as needed*</font>
<!-- markdownlint-enable -->
，parameter adjustment instructions ：

<!-- markdownlint-disable MD004 -->
- urls：`jmx-exporter`metric address, fill in the URL of the metric exposed by the corresponding component here
- source：Collector alias, it is recommended to make a distinction
- keep_exist_metric_name: Maintain metric name
- interval：Collection interval
- inputs.prom.tags: Add additional tags
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

### Hadoop Metric Set

The ResourceManager metric is located under the Hadoop metric set, and here we mainly introduce the specifications of the ResourceManager related metrics.

| Metrics | Description | Unit |
|:--------|:-----|:--|
|`resourcemanager_activeapplications` |`Number of Resource Manager applications` | count |
|`resourcemanager_activeusers` |`Number of active users in the resource manager` | count |
|`resourcemanager_aggregatecontainersallocated`|`Number of containers allocated by the resource manager`| count |
|`resourcemanager_aggregatecontainerspreempted`|`The number of containers occupied by the resource manager`|count |
|`resourcemanager_aggregatecontainersreleased`|`Number of containers released by the resource manager`| count |
|`resourcemanager_aggregatememorymbsecondspreempted`|`The amount of memory consumed per second by the occupied container` | B/s |
|`resourcemanager_aggregatenodelocalcontainersallocated` |`Number of containers running locally on all nodes` | count |
|`resourcemanager_aggregateoffswitchcontainersallocated` |`Resource Manager allocates container aggregation switch quantity` | count |
|`resourcemanager_aggregateracklocalcontainersallocated` |`Aggregate the number of local container racks` | count |
|`resourcemanager_aggregatevcoresecondspreempted` |`The amount of CPU usage in the resource manager` | byte |
|`resourcemanager_allocatedcontainers` |`The number of containers allocated by the resource manager to the application` | count |
|`resourcemanager_allocatedmb` | `The allocated memory size of the resource manager` | B/s |
|`resourcemanager_allocatedvcores` |`The number of CPU cores allocated by the resource manager` | count |
|`resourcemanager_amlaunchdelayavgtime` |`Average latency of application startup` | ms |
|`resourcemanager_amlaunchdelaynumops` |`Number of application startup delays` | count |
|`resourcemanager_amregisterdelayavgtime` |`The average delay time for registering the resource manager` | ms |
|`resourcemanager_amregisterdelaynumops` |`Number of registration delays for the resource manager` | s |
|`resourcemanager_amresourceusagemb` | `Number of node manager container startup operations`| count |
|`resourcemanager_amresourceusagevcores` |`Node Manager has completed container count` | count |
|`resourcemanager_appattemptfirstcontainerallocationdelayavgtime` |`Number of failed node manager containers` | count |
|`resourcemanager_appattemptfirstcontainerallocationdelaynumops` | `Number of Node Manager Container Exits` | count |
|`resourcemanager_appscompleted` |`Number of running node manager containers` | count |
|`resourcemanager_appsfailed` |`Number of Resource Manager application failures` | count |
|`resourcemanager_appskilled` |`Number of terminated applications in the resource manager` | count |
|`resourcemanager_appspending` |`Number of applications waiting to be executed` | count |
|`resourcemanager_appsrunning` |`Number of running applications` | count |
|`resourcemanager_appssubmitted` |`The number of applications submitted by the resource manager` | count |
|`resourcemanager_availablemb` |`Total available memory of the resource manager` | count |
|`resourcemanager_availablevcores` |`Number of available CPU cores in the resource manager` | count |
|`resourcemanager_callqueuelength` |`Resource management area call queue length` | count |
|`resourcemanager_continuousschedulingrunavgtime` |`The average time for continuous scheduling and running of the resource manager` | ms |
|`resourcemanager_continuousschedulingrunimaxtime` |`The maximum continuous scheduling running time of the resource manager` | ms |
|`resourcemanager_continuousschedulingrunimintime` |`The minimum time for continuous scheduling and running of the resource manager` | ms |
|`resourcemanager_continuousschedulingruninumops` |`The number of consecutive scheduling operations by the resource manager` | count |
|`resourcemanager_continuousschedulingrunmaxtime` |`The maximum continuous scheduling running time of the resource manager` | ms |
|`resourcemanager_continuousschedulingrunmintime` |`The minimum time for continuous scheduling and running of the resource manager` | ms |
|`resourcemanager_continuousschedulingrunnumops` |`The number of consecutive scheduling operations by the resource manager` | count |
|`resourcemanager_deferredrpcprocessingtimenumops` |`The number of operations that delay RPC processing time in the resource manager` | count |
|`resourcemanager_droppedpuball` |`The number of times the resource manager discards puball` | count |
|`resourcemanager_fairsharemb` |`Resource Manager Memory Allocation` | count |
|`resourcemanager_fairsharevcores` |`Resource Manager CPU Core Allocation Quantity` | count |
|`resourcemanager_gccount` |`Resource Manager Garbage Collection Times` | count |
|`resourcemanager_gccountconcurrentmarksweep` |`Number of times the garbage collection mark has been cleared` | count |
|`resourcemanager_gccountparnew` |`Number of Parnew garbage collectors` | ms |
|`resourcemanager_gcnuminfothresholdexceeded` |`The number of times the resource manager GC collects information exceeds the threshold`| count |
|`resourcemanager_gcnumwarnthresholdexceeded` |`The resource manager GC pauses more than the threshold number of times` | count |
|`resourcemanager_gctimemillis` |`The time from the last startup to completion of GC` | ms |
|`resourcemanager_gctimemillisconcurrentmarksweep` |`Number of successful log writing operations by node manager` | count |
|`resourcemanager_gctimemillisparnew` |`The time from Parnew startup to completion` | ms |
|`resourcemanager_gctotalextrasleeptime` |`Extra total sleep time for the resource manager` | ms |
|`resourcemanager_getgroupsavgtime` |`The average time for the resource manager to retrieve groups` | count |
|`resourcemanager_logerror` |`Number of memory heap used by node manager` | count |
|`resourcemanager_logfatal` |`Maximum Memory Value of Node Manager` | byte |
|`resourcemanager_loginfailureavgtime` |`The average time for login failures in the resource manager` | ms |
|`resourcemanager_loginfailurenumops` |`Number of login failures in the resource manager` | count |
|`resourcemanager_loginfo` |`Number of login information for the resource manager` | count |
|`resourcemanager_loginsuccessavgtime` |`The average time for successful login to the resource manager` | ms |
|`resourcemanager_loginsuccessnumops` |`Number of successful login attempts to the resource manager` | count |
|`resourcemanager_logwarn` |`Number of Resource Manager log warnings` | count |
|`resourcemanager_maxamsharemb` |`Maximum AM resource usage of the resource manager` | byte |
|`resourcemanager_maxamsharevcores` |`Maximum number of shared CPU cores in the resource manager` | count |
|`resourcemanager_maxapps` |`Maximum number of resource manager applications` | count |
|`resourcemanager_memheapcommittedm` |`The allocated memory size of the resource manager` | byte |
|`resourcemanager_memheapmaxm` |`Maximum memory capacity of the resource manager` | byte |
|`resourcemanager_memheapusedm` |`The amount of memory used by the resource manager` | byte |
|`resourcemanager_memmaxm` |`Maximum Memory Value of Resource Manager` | byte |
|`resourcemanager_memnonheapcommitted` |`The resource manager declares the size of memory to be allocated` | byte |
|`resourcemanager_memnonheapmaxm` | `The resource manager declares the maximum memory capacity` | byte |
|`resourcemanager_memnonheapusedm` |`The resource manager declares the amount of memory used` | byte  |
|`resourcemanager_minsharemb` |`Minimum Resource Quantity for Resource Manager` | count |
|`resourcemanager_minsharevcores` |`Minimum number of CPU cores in the resource manager` | byte |
|`resourcemanager_nodeheartbeatavgtime` |`Average heartbeat time of resource manager node` | s |
|`resourcemanager_nodeheartbeatnumops` |`Number of resource manager node heartbeats` | count |
|`resourcemanager_nodeupdatecallavgtime` |`Average response time for resource manager node updates` | s |
|`resourcemanager_nodeupdatecallimaxtime` |`Maximum response time of resource manager nodes` | s |
|`resourcemanager_nodeupdatecallimintime` |`Minimum response time for resource manager node updates` | s  |
|`resourcemanager_nodeupdatecallinumops` |`Resource Manager Node Update Response Times` | count |
|`resourcemanager_numactivenms` |`The current number of surviving NodeManagers in the resource manager` | count |
|`resourcemanager_numactivesinks` |`The current number of surviving sinks in the resource manager` | count |
|`resourcemanager_numactivesources` |`The number of surviving resources in the resource manager` | count |
|`resourcemanager_numallsinks` |`The total number of sinks in the resource manager` | count |
|`resourcemanager_numallsources` |`The total amount of resource data in the resource manager` | count |
|`resourcemanager_numdecommissionednms` |`Number of retired nodes in the resource manager` | count |
|`resourcemanager_numdecommissioningnms` |`Number of nodes being retired by the resource manager` | count |
|`resourcemanager_numdroppedconnections` |`The number of connections discarded by the resource manager` | count |
|`resourcemanager_numlostnms` |`Number of nodes lost in the resource manager` | count |
|`resourcemanager_numopenconnections` |`Number of open connections in the resource manager` | count |
|`resourcemanager_numrebootednms` |`Number of nodes restarted by the resource manager` | count |
|`resourcemanager_numshutdownnms` |`Number of nodes closed by the resource manager` | count |
|`resourcemanager_numunhealthynms` |`Number of healthy nodes in the resource manager` | count |
|`resourcemanager_pendingcontainers` |`The number of containers waiting to be allocated in the resource manager` | count |
|`resourcemanager_pendingmb` |`The number of resources waiting to be allocated by the resource manager` | count |
|`resourcemanager_pendingvcores` |`The number of CPU cores waiting for allocation in the resource manager` | count |
|`resourcemanager_publishavgtime` |`The average time for publishing data in the resource manager` | s |
|`resourcemanager_rpcprocessingtimeavgtime` |`Resource Manager RPC Execution Average Time` | s |
|`resourcemanager_rpcprocessingtimenumops` |`Number of resource manager executions` | count |
|`resourcemanager_rpcqueuetimeavgtime` |`Resource Manager RPC average response time` | count |
|`resourcemanager_rpcqueuetimenumops` |`Resource Manager RPC Response Operation Times` | count |
|`resourcemanager_rpcslowcalls` |`Resource Manager RPC Slow Call Time` | s |
|`resourcemanager_running_0` |`Number of running resource managers_0` | count |
|`resourcemanager_running_1440` |`The number of running resource managers is 1400` | count |
|`resourcemanager_running_300` |`The number of running resource managers is 300` | count |
|`resourcemanager_running_60` |`Number of running resource managers: 60` | count |
|`resourcemanager_securityenabled` |`Number of enabled resource manager security mechanisms` | count |
|`resourcemanager_sentbytes` |`The number of bytes sent by the resource manager` | byte |
|`resourcemanager_snapshotavgtime` |`Average time of resource manager data snapshot` | s |
|`resourcemanager_snapshotnumops` |`Number of resource manager data snapshot operations`| count |
|`resourcemanager_steadyfairsharemb` |`Weighted shared memory amount of resource manager`| byte |
|`resourcemanager_steadyfairsharevcores` |`Resource Manager Weighted Shared CPU Core Count`| count |
|`resourcemanager_threadsblocked` |`Number of County Locks in Resource Manager`| count |
|`resourcemanager_threadsnew` |`Number of newly created threads in the resource manager`| count |
|`resourcemanager_threadsrunnable` |`Number of threads running in the resource manager`| count |
|`resourcemanager_threadsterminated` |`Number of terminated threads in the resource manager`| count |
|`resourcemanager_threadstimedwaiting` |`Resource Manager thread waiting time`| s |
|`resourcemanager_threadswaiting` |`Number of resource manager threads waiting`| count |
|`resourcemanager_updatethreadrunavgtime` |`The average time for updating threads in the resource manager`| s |
|`resourcemanager_updatethreadrunimaxtime` |`Maximum time for resource manager thread updates`| s |
|`resourcemanager_updatethreadrunimintime` |`Minimum time for resource manager thread updates`| s |
|`resourcemanager_updatethreadruninumops` |`Number of thread update operations in the resource manager`| count |
|`resourcemanager_updatethreadrunmaxtime` |`Maximum time for resource manager thread updates`| s |
|`resourcemanager_updatethreadrunmintime` |`Minimum time for resource manager thread updates`| s |
|`resourcemanager_updatethreadrunnumops` |`Number of thread update operations in the resource manager`| count |



