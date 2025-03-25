---
title     : 'Hadoop Yarn NodeManager'
summary   : 'Collect Yarn NodeManager metrics information'
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

Collect Yarn NodeManager metrics information.

## Installation and Deployment {#config}

Since NodeManager is developed in the LANGUAGE of Java, it can use the jmx-exporter method to collect metrics information.

### 1. NodeManager Configuration

#### 1.1 Download jmx-exporter

Download address: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx Script

Download address: `https://github.com/lrwh/jmx-exporter/blob/main/hadoop-yarn-nodemanager.yml`

#### 1.3 Adjust NodeManager Startup Parameters

Add to nodemanager startup parameters:

> {JAVA_GC_ARGS} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17108:/opt/guance/jmx/jmx_node_manager.yml

#### 1.4 Restart NodeManager

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure Collector

The jmx-exporter can directly expose `metrics` url, so it can be collected via the [`prom`](./prom.md) collector.

Enter the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, copy `prom.conf.sample` to `nodemanager.conf`.

> `cp prom.conf.sample nodemanager.conf`

Adjust the content of `nodemanager.conf` as follows:

```toml

  urls = ["http://localhost:17108/metrics"]
  source ="yarn-nodemanager"
  [inputs.prom.tags]
    component = "yarn-nodemanager" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations should be adjusted as needed*</font>
<!-- markdownlint-enable -->
, parameter adjustment instructions:

<!-- markdownlint-disable MD004 -->
- urls: The `jmx-exporter` metrics address; fill in the metrics url exposed by the corresponding component here.
- source: Collector alias, it is recommended to differentiate.
- keep_exist_metric_name: Keep the metric name.
- interval: Collection interval.
- inputs.prom.tags: Add extra tags.
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Measurement Set

NodeManager metrics are located under the Hadoop measurement set; this section mainly introduces the relevant descriptions of NodeManager metrics.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`nodemanager_allocatedcontainers` |`Number of containers allocated by the node manager` | count |
|`nodemanager_allocatedgb` |`Amount allocated by the node manager` | count |
|`nodemanager_allocatedopportunisticgb`|`Bytes available for allocation by the node manager` | count |
|`nodemanager_allocatedopportunisticvcores` |`Opportunities available for allocation by the node manager` | count |
|`nodemanager_allocatedvcores` |`Number of vcores allocated by the node manager` | count |
|`nodemanager_availablegb` |`Number of bytes available by the node manager` | count |
|`nodemanager_availablevcores` |`Number of vcores available by the node manager` | count |
|`nodemanager_badlocaldirs` |`Number of damaged local directories managed by the node manager` | count |
|`nodemanager_badlogdirs` |`Number of damaged log directories managed by the node manager` | count |
|`nodemanager_blocktransferratebytes_count` |`Number of block transfer bytes by the node manager` | byte |
|`nodemanager_blocktransferratebytes_rate1` |`Rate of block transfer bytes 1 by the node manager` | B/s |
|`nodemanager_blocktransferratebytes_rate15` |`Rate of block transfer bytes 15 by the node manager` | B/s |
|`nodemanager_blocktransferratebytes_rate5` |`Rate of block transfer bytes 5 by the node manager` | B/s |
|`nodemanager_blocktransferratebytes_ratemean` |`Average rate of block transfer bytes by the node manager` | byte |
|`nodemanager_cachesizebeforeclean` |`Cache size before cleaning by the node manager` | byte |
|`nodemanager_callqueuelength` |`Length of call queue by the node manager` | count |
|`nodemanager_containerlaunchdurationavgtime` |`Average time for container launch by the node manager` | s |
|`nodemanager_containerlaunchdurationnumops` |`Number of operations for container launch by the node manager` | count |
|`nodemanager_containerscompleted` |`Number of completed containers by the node manager` | count |
|`nodemanager_containersfailed` |`Number of failed containers by the node manager` | count |
|`nodemanager_containersiniting` |`Number of exiting containers by the node manager` | count |
|`nodemanager_containerskilled` |`Number of running containers by the node manager` | count |
|`nodemanager_containerslaunched` |`Number of launched containers by the node manager` | count |
|`nodemanager_containersreiniting` |`Number of restarted containers by the node manager` | count |
|`nodemanager_containersrolledbackonfailure` |`Number of rollback failures by the node manager` | count |
|`nodemanager_containersrunning` |`Number of running containers by the node manager` | ms |
|`nodemanager_deferredrpcprocessingtimeavgtime` |`Average deferred RPC processing time by the node manager` | s |
|`nodemanager_deferredrpcprocessingtimenumops` |`Number of deferred RPC operations by the node manager` | count |
|`nodemanager_droppedpuball` |`Number of dropped puballs by the node manager` | count |
|`nodemanager_gccount` |`Garbage collection count by the node manager` | count |
|`nodemanager_gccountconcurrentmarksweep` |`Garbage collection count with concurrent marking by the node manager` | count |
|`nodemanager_gccountparnew` |`Garbage collection count with copying by the node manager` | count |
|`nodemanager_gcnuminfothresholdexceeded` |`Number of garbage collection info exceeding threshold by the node manager` | count |
|`nodemanager_gcnumwarnthresholdexceeded` |`Number of garbage collection warnings exceeding threshold by the node manager` | count |
|`nodemanager_gctimemillis` |`Garbage collection time in milliseconds by the node manager` | ms |
|`nodemanager_gctimemillisconcurrentmarksweep` |`Garbage collection marking time in milliseconds by the node manager` | ms |
|`nodemanager_gctimemillisparnew` |`Copying time in milliseconds by the node manager` | ms |
|`nodemanager_gctotalextrasleeptime` |`Total garbage collection sleep time by the node manager` | s |
|`nodemanager_getgroupsavgtime` |`Average time to get groups by the node manager` | s |
|`nodemanager_getgroupsnumops` |`Number of operations to get groups by the node manager` | count |
|`nodemanager_goodlocaldirsdiskutilizationperc` |`Percentage of healthy disk utilization by the node manager` | count |
|`nodemanager_logerror` |`Number of log errors by the node manager` | count |
|`nodemanager_logfatal` |`Number of deleted logs by the node manager` | count |
|`nodemanager_loginfailureavgtime` |`Average time for log write failure by the node manager` | ms |
|`nodemanager_loginfailurenumops` |`Number of operations for log write failure by the node manager` | count |
|`nodemanager_loginfo` |`Number of log informations by the node manager` | count |
|`nodemanager_loginsuccessavgtime` |`Average time for successful log write by the node manager` | count |
|`nodemanager_loginsuccessnumops` |`Number of successful log write operations by the node manager` | count |
|`nodemanager_logwarn` |`Number of log warnings by the node manager` | count |
|`nodemanager_memheapcommittedm` |`Number of committed heap memory by the node manager` | count |
|`nodemanager_memheapmaxm` |`Maximum number of heap memory by the node manager` | count |
|`nodemanager_memheapusedm` |`Number of used heap memory by the node manager` | count |
|`nodemanager_memmaxm` |`Maximum memory by the node manager` | byte |
|`nodemanager_memnonheapcommittedm` |`Number of non-committed heap memory by the node manager` | count |
|`nodemanager_memnonheapmaxm` |`Maximum number of non-committed heap memory by the node manager` | count |
|`nodemanager_memnonheapusedm` |`Maximum number of unused heap memory by the node manager` | count |
|`nodemanager_numactiveconnections` |`Number of connections by the node manager` | count |
|`nodemanager_numactivesinks` |`Number of active pools by the node manager` | count |
|`nodemanager_numactivesources` |`Number of active resources by the node manager` | count |
|`nodemanager_numallsinks` |`Total number of pools by the node manager` | count |
|`nodemanager_numallsources` |`Total number of resources` | count |
|`nodemanager_numdroppedconnections` |`Number of dropped connections by the node manager` | count |
|`nodemanager_numopenconnections` |`Number of open connections by the node manager` | count |
|`nodemanager_numregisteredconnections` |`Number of registered connections by the node manager` | count |
|`nodemanager_openblockrequestlatencymillis_count` |`Number of open block latencies by the node manager` | count |
|`nodemanager_openblockrequestlatencymillis_rate1` |`Rate of open block latency requests 1 by the node manager` | B/s |
|`nodemanager_openblockrequestlatencymillis_rate15` |`Rate of open block latency requests 15 by the node manager` | B/s |
|`nodemanager_openblockrequestlatencymillis_rate5` |`Rate of open block latency requests 5 by the node manager` | B/s |
|`nodemanager_openblockrequestlatencymillis_ratemean` |`Average request latency rate for open blocks by the node manager` | B/s |
|`nodemanager_privatebytesdeleted` |`Number of private bytes deleted by the node manager` | byte |
|`nodemanager_publicbytesdeleted` |`Number of bytes deleted by the node manager` | byte |
|`nodemanager_publishavgtime` |`Average publish time by the node manager` | s |
|`nodemanager_publishnumops` |`Number of data publish operations by the node manager` | ms |
|`nodemanager_receivedbytes` |`Number of received bytes by the node manager` | byte |
|`nodemanager_registeredexecutorssize` |`Number of registered executor categories by the node manager` | count |
|`nodemanager_registerexecutorrequestlatencymillis_count` |`Number of registration delays for executors by the node manager` | count |
|`nodemanager_registerexecutorrequestlatencymillis_rate1` |`Rate of registration delays for executors 1 by the node manager` | B/s |
|`nodemanager_registerexecutorrequestlatencymillis_rate15` |`Rate of registration delays for executors 15 by the node manager` | B/s |
|`nodemanager_registerexecutorrequestlatencymillis_rate5` |`Rate of registration delays for executors 5 by the node manager` | B/s |
|`nodemanager_registerexecutorrequestlatencymillis_ratemean` |`Average delay for executor registrations by the node manager` | count |
|`nodemanager_renewalfailures` |`Number of update failures by the node manager` | count |
|`nodemanager_renewalfailurestotal` |`Total number of update failures by the node manager` | count |
|`nodemanager_rpcauthenticationfailures` |`Number of authentication failures by the node manager` | count |
|`nodemanager_rpcauthorizationsuccesses` |`Number of successful authentications by the node manager` | count |
|`nodemanager_rpcclientbackoff` |`Number of client backoffs by the node manager` | count |
|`nodemanager_rpcprocessingtimeavgtime` |`Average processing time by the node manager` | s |
|`nodemanager_rpcprocessingtimenumops` |`Number of RPC processing operations by the node manager` | count |
|`nodemanager_rpcqueuetimeavgtime` |`Average queue time for RPC by the node manager` | count |
|`nodemanager_rpcqueuetimenumops` |`Number of RPC queue time operations by the node manager` | count |
|`nodemanager_rpcslowcalls` |`Number of slow calls by the node manager` | count |
|`nodemanager_runningopportunisticcontainers` |`Number of running opportunistic containers by the node manager` | count |
|`nodemanager_securityenabled` |`Number of enabled securities by the node manager` | count |
|`nodemanager_sentbytes` |`Number of sent bytes by the byte manager` | byte |
|`nodemanager_shuffleconnections` |`Number of reconnections by the byte manager` | count |
|`nodemanager_shuffleoutputbytes` |`Number of reshuffled output bytes by the byte manager` | byte |
|`nodemanager_shuffleoutputsfailed` |`Number of shuffle output failures by the node manager` | count |
|`nodemanager_shuffleoutputsok` |`Number of successful shuffle outputs by the node manager` | count |
|`nodemanager_snapshotavgtime` |`Average snapshot time by the node manager` | s |
|`nodemanager_snapshotnumops` |`Number of snapshot operations by the node manager` | count |
|`nodemanager_threadsblocked` |`Number of blocked threads by the node manager` | count |
|`nodemanager_threadsnew` |`Number of newly created threads by the node manager` | count |
|`nodemanager_threadsrunnable` |`Number of non-runnable threads by the node manager` | count |
|`nodemanager_threadsterminated` |`Number of initialized threads by the node manager` | count |
|`nodemanager_threadstimedwaiting` |`Thread waiting time by the node manager` | s |
|`nodemanager_threadswaiting` |`Number of thread switches by the node manager` | count |
|`nodemanager_totalbytesdeleted` |`Total number of deleted bytes by the node manager` | byte |