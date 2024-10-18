---
title     : 'Hadoop Yarn NodeManager'
summary   : 'Collect Yarn NodeManager metric information'
__int_icon: 'icon/hadoop-yarn'
dashboard :
  - desc  : 'Yarn NodeManager'
    path  : 'dashboard/en/hadoop_yarn_nodemanager'
monitor   :
  - desc  : 'Yarn NodeManager'
    path  : 'monitor/en/hadoop_yarn_nodemanager'
---

<!-- markdownlint-disable MD025 -->
# Hadoop Yarn NodeManager
<!-- markdownlint-enable -->

Collect Yarn NodeManager metric information.

## Installation and deployment {#config}

Since NodeManager is developed in Java language, it is possible to collect metric information using jmx exporter.

### 1. NodeManager Configuration

#### 1.1 Download jmx-exporter

Download link: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx script

Download link: `https://github.com/lrwh/jmx-exporter/blob/main/hadoop-yarn-nodemanager.yml`

#### 1.3 NodeManager start parameter adjustment

Add startup parameters to nodemanager

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17108:/opt/guance/jmx/jmx_node_manager.yml

#### 1.4 Restart NodeManager

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure collector

By using jmx exporter, the `metrics` URL can be directly exposed, so it can be collected directly through the [`prom`](./prom.md) collector.

Go to the installation directory of [DataKit](./datakit_dir.md) and copy `prom.conf.sample` to `nodemanager.conf`.

> `cp prom.conf.sample nodemanager.conf`

Adjust the content of 'nodemanager. conf' as follows：

```toml
  urls = ["http://localhost:17108/metrics"]
  source ="yarn-nodemanager"
  [inputs.prom.tags]
    component = "yarn-nodemanager" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Adjust other configurations as needed*</font>
<!-- markdownlint-enable -->
，parameter adjustment instructions ：

<!-- markdownlint-disable MD004 -->
- Urls: `jmx exporter` metric address, fill in the corresponding metric URL exposed by the component here
- Source: Collector alias, it is recommended to distinguish it
- Keep.exe ist_stricic_name: Keep indicator name
- Interval: collection interval
- Inputsprom.tags: Add additional tags
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

### Hadoop Metric Set

The NodeManager metric is located under the Hadoop metric set, and here we mainly introduce the description of NodeManager related metrics.

| Metrics | Description | Unit |
|:--------|:-----|:--|
|`nodemanager_allocatedcontainers` |`Node Manager allocates container quantity` | count |
|`nodemanager_allocatedgb` |`Node Manager has allocated quantity` | count |
|`nodemanager_allocatedopportunisticgb`|`The number of bytes that can be allocated by the node manager` | count |
|`nodemanager_allocatedopportunisticvcores` |`Node Manager can allocate the number of opportunities` | count |
|`nodemanager_allocatedvcores` |`The number of CPU cores allocated by the node manager` | count |
|`nodemanager_availablegb` |Number of bytes available for node manager` | count |
|`nodemanager_availablevcores` |`Number of available CPU cores for node manager` | count |
|`nodemanager_badlocaldirs` |`Number of damaged local directories in the node manager` | count |
|`nodemanager_badlogdirs` |`Number of damaged log directories in the node manager` | count |
|`nodemanager_blocktransferratebytes_count` |`Node Manager block transfer byte count` | byte |
|`nodemanager_blocktransferratebytes_rate1` |`Node Manager block transfer byte rate 1` | B/s |
|`nodemanager_blocktransferratebytes_rate15` | `Node Manager block transfer byte rate 15` | B/s |
|`nodemanager_blocktransferratebytes_rate5` |`Node Manager block transfer byte rate 5` | B/s |
|`nodemanager_blocktransferratebytes_ratemean` |`Node Manager Block Transfer Byte Average` | byte |
|`nodemanager_cachesizebeforeclean` |`Node Manager cache size before cleaning` | byte |
|`nodemanager_callqueuelength` |`Node Manager Call Queue Length` | count |
|`nodemanager_containerlaunchdurationavgtime` |`Average startup time of node manager container` | s |
|`nodemanager_containerlaunchdurationnumops` | `Number of node manager container startup operations`| count |
|`nodemanager_containerscompleted` |`Node Manager has completed container count` | count |
|`nodemanager_containersfailed` |`Number of failed node manager containers` | count |
|`nodemanager_containersiniting` | `Number of Node Manager Container Exits` | count |
|`nodemanager_containerskilled` |`Number of running node manager containers` | count |
|`nodemanager_containerslaunched` |`Number of started node manager containers` | count |
|`nodemanager_containersreiniting` |`Number of restarts of node manager container` | count |
|`nodemanager_containersrolledbackonfailure` |`Number of failed rollback of node manager container` | count |
|`nodemanager_containersrunning` |`Number of running node manager containers` | ms |
|`nodemanager_deferredrpcprocessingtimeavgtime` |`Node Manager Delay PC Processing Average Time` | s |
|`nodemanager_deferredrpcprocessingtimenumops` |`Node Manager Delay RPC Operation Processing Time` | count |
|`nodemanager_droppedpuball` |`Puball discarded by node manager` | count |
|`nodemanager_gccount` |`Node Manager Garbage Collection Count` | count |
|`nodemanager_gccountconcurrentmarksweep` |`The number of garbage collections counted and marked by the node manager` | count |
|`nodemanager_gccountparnew` |`Node Manager Garbage Collection Copy Quantity` | count |
|`nodemanager_gcnuminfothresholdexceeded` |`The number of garbage collection messages in the node manager exceeds the threshold` | count |
|`nodemanager_gcnumwarnthresholdexceeded` |`Node Manager garbage collection warning exceeds threshold quantity` | count |
|`nodemanager_gctimemillis` |`Node Manager garbage collection time in milliseconds` | ms |
|`nodemanager_gctimemillisconcurrentmarksweep` |`Node Manager Garbage Collection Tag Milliseconds` | ms |
|`nodemanager_gctimemillisparnew` |`Node Manager Garbage Collection Copy Time in milliseconds` | ms |
|`nodemanager_gctotalextrasleeptime` |`Node Manager Garbage Collection Total Sleep Time` | s |
|`nodemanager_getgroupsavgtime` |`Node Manager retrieves the average group time` | s |
|`nodemanager_getgroupsnumops` |`Node Manager retrieves the number of group operations` | count |
|`nodemanager_goodlocaldirsdiskutilizationperc` |`Node Manager Local Health Disk Usage` | count |
|`nodemanager_logerror` |`Node Manager Log Error Count` | count |
|`nodemanager_logfatal` |`Number of deleted node manager logs` | count |
|`nodemanager_loginfailureavgtime` |`Node Manager Log Write Failure Average Time` | ms |
|`nodemanager_loginfailurenumops` |`Number of failed write operations to the node manager log` | count |
|`nodemanager_loginfo` |`Number of node manager log information` | count |
|`nodemanager_loginsuccessavgtime` |`The average time for successful writing of node manager logs` | count |
|`nodemanager_loginsuccessnumops` |`Number of successful log writing operations by node manager` | count |
|`nodemanager_logwarn` |`Number of node manager log warnings` | count |
|`nodemanager_memheapcommittedm` |`Node Manager submits the number of memory heaps` | count |
|`nodemanager_memheapmaxm` |`Maximum memory heap count for node manager` | count |
|`nodemanager_memheapusedm` |`Number of memory heap used by node manager` | count |
|`nodemanager_memmaxm` |`Maximum Memory Value of Node Manager` | byte |
|`nodemanager_memnonheapcommittedm` |`Node Manager has not submitted the number of memory heaps` | count |
|`nodemanager_memnonheapmaxm` |`Node Manager has not committed the maximum number of memory heaps` | count |
|`nodemanager_memnonheapusedm` |`Node Manager Memory Heap Unused Maximum Quantity` | count |
|`nodemanager_numactiveconnections` |`Number of node manager connections` | count |
|`nodemanager_numactivesinks` |`Number of activated sinks in the node manager` | count |
|`nodemanager_numactivesources` |`Number of active resources in the node manager` | count |
|`nodemanager_numallsinks` |`Total number of node manager pools` | count |
|`nodemanager_numallsources` |`Total resources` | count |
|`nodemanager_numdroppedconnections` |`Number of dropped connections by node manager` | count |
|`nodemanager_numopenconnections` |`Number of open connections in Node Manager` | count |
|`nodemanager_numregisteredconnections` |`Number of registered connections in Node Manager` | count |
|`nodemanager_openblockrequestlatencymillis_count` |`Node Manager Open Block Delay Times` | count |
|`nodemanager_openblockrequestlatencymillis_rate1` |`Node Manager Open Block Delay Request Rate 1` | B/s |
|`nodemanager_openblockrequestlatencymillis_rate15` |`Node Manager Open Block Delay Request Rate 15` | B/s |
| `nodemanager_openblockrequestlatencymillis_rate5` | `Node Manager Open Block Delay Request Rate 5` | B/s |
|`nodemanager_openblockrequestlatencymillis_ratemean` |`Node Manager Open Block Delay Request Rate` | B/s  |
|`nodemanager_privatebytesdeleted` |`Number of private bytes deleted by node manager` | byte |
|`nodemanager_publicbytesdeleted` |`Node Manager has deleted byte count` | byte |
|`nodemanager_publishavgtime` |`The average time for publishing node manager` | s |
| `nodemanager_publishnumops` | `Number of data operations published by the node manager` | ms |
| `nodemanager_receivedbytes` | `Node manager receives byte count` | byte |
|`nodemanager_registeredexecutorssize` |`Number of actuator classification tables registered in the node manager` | count |
|`nodemanager_registerexecutorrequestlatencymillis_count` |`Node Manager - Registration Executor Request Delay in Milliseconds` | count  |
|`nodemanager_registerexecutorrequestlatencymillis_rate1` |`节点管理器注册执行器请求延迟速率1` | B/s |
|`nodemanager_registerexecutorrequestlatencymillis_rate15` |`Node Manager Registration Executor Request Delay Rate 15` | B/s |
|`nodemanager_registerexecutorrequestlatencymillis_rate5` |`Node Manager Registration Executor Request Delay Rate 5` | B/s |
|`nodemanager_registerexecutorrequestlatencymillis_ratemean` |`Node Manager Registration Executor Delay in Milliseconds Average` | ms |
|`nodemanager_renewalfailures` |`Number of updates reported by Node Manager` | count |
|`nodemanager_renewalfailurestotal` |`Total number of node manager update failures` | count |
|`nodemanager_rpcauthenticationfailures` |`Node Manager Verification Failure Count` | count |
|`nodemanager_rpcauthorizationsuccesses` |`Number of successful node manager verifications` | count |
|`nodemanager_rpcclientbackoff` |`Node Manager RPC Client Rollback Times` | count |
|`nodemanager_rpcprocessingtimeavgtime` |`The average processing time of the node manager` | s |
|`nodemanager_rpcprocessingtimenumops` |`Node Manager RPC Processing Procedure Operation Times` | count |
|`nodemanager_rpcqueuetimeavgtime` |`Node Manager RPC Queue Time Average Time` | count |
|`nodemanager_rpcqueuetimenumops` |`Node Manager RPC Queue Time Operation Times` | count |
|`nodemanager_rpcslowcalls` |`Slow call count of node manager` | count |
|`nodemanager_runningopportunisticcontainers` |`Node Manager Running Opportunity Container Count` | count |
|`nodemanager_securityenabled` |`Node Manager has enabled safe numbers` | count |
|`nodemanager_sentbytes` |`Byte manager has sent byte count` | byte |
|`nodemanager_shuffleconnections` |`The number of reconnections for the byte manager` | count |
|`nodemanager_shuffleoutputbytes` |`Byte manager re outputs byte count` | byte |
|`nodemanager_shuffleoutputsfailed` |`Node Manager re outputs the number of failed attempts` | count |
|`nodemanager_shuffleoutputsok` |`Node Manager successfully shuffled output quantity` | count |
|`nodemanager_snapshotavgtime` |`Node Manager snapshot average time` | s |
|`nodemanager_snapshotnumops` |`Number of snapshot operations for node manager` | count |
|`nodemanager_threadsblocked` |`Node Manager thread lock count` | count |
|`nodemanager_threadsnew` |`Number of newly created threads for node management` | count |
|`nodemanager_threadsrunnable` |`Number of non runnable threads in the node manager` | count |
|`nodemanager_threadsterminated` |`Node Manager initialized thread count` | count |
|`nodemanager_threadstimedwaiting` |`Node Manager Thread Waiting Time` | s |
|`nodemanager_threadswaiting` |`Number of thread switches in node manager` | count |
|`nodemanager_totalbytesdeleted` |`Node Manager has deleted the total number of bytes` | byte |



