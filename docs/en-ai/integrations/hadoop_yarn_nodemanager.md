---
title: 'Hadoop Yarn NodeManager'
summary: 'Collect metrics information from Yarn NodeManager'
__int_icon: 'icon/hadoop-yarn'
dashboard:
  - desc: 'Yarn NodeManager'
    path: 'dashboard/en/hadoop_yarn_nodemanager'
monitor:
  - desc: 'Yarn NodeManager'
    path: 'monitor/en/hadoop_yarn_nodemanager'
---

<!-- markdownlint-disable MD025 -->
# Hadoop Yarn NodeManager
<!-- markdownlint-enable -->

Collect metrics information from Yarn NodeManager.

## Installation and Deployment {#config}

Since NodeManager is developed in Java, it can use the jmx-exporter method to collect metrics information.

### 1. NodeManager Configuration

#### 1.1 Download jmx-exporter

Download URL: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx Script

Download URL: `https://github.com/lrwh/jmx-exporter/blob/main/hadoop-yarn-nodemanager.yml`

#### 1.3 Adjust NodeManager Startup Parameters

Add the following parameters to the nodemanager startup:

> {JAVA_GC_ARGS} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17108:/opt/guance/jmx/jmx_node_manager.yml

#### 1.4 Restart NodeManager

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure Collector

The jmx-exporter exposes a `metrics` URL directly, so you can use the [`prom`](./prom.md) collector for collection.

Go to the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, copy `prom.conf.sample` to `nodemanager.conf`.

> `cp prom.conf.sample nodemanager.conf`

Adjust the content of `nodemanager.conf` as follows:

```toml
urls = ["http://localhost:17108/metrics"]
source = "yarn-nodemanager"
[inputs.prom.tags]
  component = "yarn-nodemanager" 
interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations can be adjusted as needed*</font>
<!-- markdownlint-enable -->

Parameter adjustment explanation:

<!-- markdownlint-disable MD004 -->
- urls: The `jmx-exporter` metrics address, fill in the exposed metrics URL of the corresponding component.
- source: Alias for the collector, recommended to differentiate.
- keep_exist_metric_name: Keep metric names.
- interval: Collection interval.
- inputs.prom.tags: Add additional tags.
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Mearsurement Set

NodeManager metrics are located under the Hadoop Mearsurement set. Below is an introduction to the relevant NodeManager metrics.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
| `nodemanager_allocatedcontainers` | Number of containers allocated by the node manager | count |
| `nodemanager_allocatedgb` | Amount allocated by the node manager | count |
| `nodemanager_allocatedopportunisticgb` | Allocatable bytes by the node manager | byte |
| `nodemanager_allocatedopportunisticvcores` | Allocatable opportunistic vcores by the node manager | count |
| `nodemanager_allocatedvcores` | Number of allocated vcores by the node manager | count |
| `nodemanager_availablegb` | Available bytes by the node manager | count |
| `nodemanager_availablevcores` | Available vcores by the node manager | count |
| `nodemanager_badlocaldirs` | Number of bad local directories managed by the node manager | count |
| `nodemanager_badlogdirs` | Number of bad log directories managed by the node manager | count |
| `nodemanager_blocktransferratebytes_count` | Block transfer bytes managed by the node manager | byte |
| `nodemanager_blocktransferratebytes_rate1` | Block transfer byte rate 1 managed by the node manager | B/s |
| `nodemanager_blocktransferratebytes_rate15` | Block transfer byte rate 15 managed by the node manager | B/s |
| `nodemanager_blocktransferratebytes_rate5` | Block transfer byte rate 5 managed by the node manager | B/s |
| `nodemanager_blocktransferratebytes_ratemean` | Mean block transfer byte rate managed by the node manager | byte |
| `nodemanager_cachesizebeforeclean` | Cache size before cleaning managed by the node manager | byte |
| `nodemanager_callqueuelength` | Call queue length managed by the node manager | count |
| `nodemanager_containerlaunchdurationavgtime` | Average container launch time managed by the node manager | s |
| `nodemanager_containerlaunchdurationnumops` | Number of container launch operations managed by the node manager | count |
| `nodemanager_containerscompleted` | Number of completed containers managed by the node manager | count |
| `nodemanager_containersfailed` | Number of failed containers managed by the node manager | count |
| `nodemanager_containersiniting` | Number of exiting containers managed by the node manager | count |
| `nodemanager_containerskilled` | Number of running containers managed by the node manager | count |
| `nodemanager_containerslaunched` | Number of launched containers managed by the node manager | count |
| `nodemanager_containersreiniting` | Number of restarting containers managed by the node manager | count |
| `nodemanager_containersrolledbackonfailure` | Number of rollback failures on containers managed by the node manager | count |
| `nodemanager_containersrunning` | Number of running containers managed by the node manager | ms |
| `nodemanager_deferredrpcprocessingtimeavgtime` | Average deferred RPC processing time managed by the node manager | s |
| `nodemanager_deferredrpcprocessingtimenumops` | Number of deferred RPC operations managed by the node manager | count |
| `nodemanager_droppedpuball` | Number of dropped puball managed by the node manager | count |
| `nodemanager_gccount` | Garbage collection count managed by the node manager | count |
| `nodemanager_gccountconcurrentmarksweep` | Concurrent mark-sweep garbage collection count managed by the node manager | count |
| `nodemanager_gccountparnew` | ParNew garbage collection count managed by the node manager | count |
| `nodemanager_gcnuminfothresholdexceeded` | Number of times garbage collection info exceeded threshold managed by the node manager | count |
| `nodemanager_gcnumwarnthresholdexceeded` | Number of times garbage collection warnings exceeded threshold managed by the node manager | count |
| `nodemanager_gctimemillis` | Garbage collection time in milliseconds managed by the node manager | ms |
| `nodemanager_gctimemillisconcurrentmarksweep` | Concurrent mark-sweep garbage collection time in milliseconds managed by the node manager | ms |
| `nodemanager_gctimemillisparnew` | ParNew garbage collection time in milliseconds managed by the node manager | ms |
| `nodemanager_gctotalextrasleeptime` | Total extra sleep time for garbage collection managed by the node manager | s |
| `nodemanager_getgroupsavgtime` | Average group retrieval time managed by the node manager | s |
| `nodemanager_getgroupsnumops` | Number of group retrieval operations managed by the node manager | count |
| `nodemanager_goodlocaldirsdiskutilizationperc` | Percentage of healthy local disk utilization managed by the node manager | count |
| `nodemanager_logerror` | Number of log errors managed by the node manager | count |
| `nodemanager_logfatal` | Number of fatal log entries managed by the node manager | count |
| `nodemanager_loginfailureavgtime` | Average login failure time managed by the node manager | ms |
| `nodemanager_loginfailurenumops` | Number of login failure operations managed by the node manager | count |
| `nodemanager_loginfo` | Number of log info entries managed by the node manager | count |
| `nodemanager_loginsuccessavgtime` | Average successful login time managed by the node manager | count |
| `nodemanager_loginsuccessnumops` | Number of successful login operations managed by the node manager | count |
| `nodemanager_logwarn` | Number of log warnings managed by the node manager | count |
| `nodemanager_memheapcommittedm` | Committed heap memory managed by the node manager | count |
| `nodemanager_memheapmaxm` | Maximum heap memory managed by the node manager | count |
| `nodemanager_memheapusedm` | Used heap memory managed by the node manager | count |
| `nodemanager_memmaxm` | Maximum memory managed by the node manager | byte |
| `nodemanager_memnonheapcommittedm` | Non-committed heap memory managed by the node manager | count |
| `nodemanager_memnonheapmaxm` | Maximum non-committed heap memory managed by the node manager | count |
| `nodemanager_memnonheapusedm` | Unused non-committed heap memory managed by the node manager | count |
| `nodemanager_numactiveconnections` | Number of active connections managed by the node manager | count |
| `nodemanager_numactivesinks` | Number of active sinks managed by the node manager | count |
| `nodemanager_numactivesources` | Number of active sources managed by the node manager | count |
| `nodemanager_numallsinks` | Total number of sinks managed by the node manager | count |
| `nodemanager_numallsources` | Total number of sources managed by the node manager | count |
| `nodemanager_numdroppedconnections` | Number of dropped connections managed by the node manager | count |
| `nodemanager_numopenconnections` | Number of open connections managed by the node manager | count |
| `nodemanager_numregisteredconnections` | Number of registered connections managed by the node manager | count |
| `nodemanager_openblockrequestlatencymillis_count` | Number of open block latency requests managed by the node manager | count |
| `nodemanager_openblockrequestlatencymillis_rate1` | Rate of open block latency requests 1 managed by the node manager | B/s |
| `nodemanager_openblockrequestlatencymillis_rate15` | Rate of open block latency requests 15 managed by the node manager | B/s |
| `nodemanager_openblockrequestlatencymillis_rate5` | Rate of open block latency requests 5 managed by the node manager | B/s |
| `nodemanager_openblockrequestlatencymillis_ratemean` | Mean rate of open block latency requests managed by the node manager | B/s |
| `nodemanager_privatebytesdeleted` | Number of deleted private bytes managed by the node manager | byte |
| `nodemanager_publicbytesdeleted` | Number of deleted public bytes managed by the node manager | byte |
| `nodemanager_publishavgtime` | Average publish time managed by the node manager | s |
| `nodemanager_publishnumops` | Number of publish operations managed by the node manager | ms |
| `nodemanager_receivedbytes` | Number of received bytes managed by the node manager | byte |
| `nodemanager_registeredexecutorssize` | Size of registered executor tables managed by the node manager | count |
| `nodemanager_registerexecutorrequestlatencymillis_count` | Number of register executor request latency milliseconds managed by the node manager | count |
| `nodemanager_registerexecutorrequestlatencymillis_rate1` | Rate of register executor request latency 1 managed by the node manager | B/s |
| `nodemanager_registerexecutorrequestlatencymillis_rate15` | Rate of register executor request latency 15 managed by the node manager | B/s |
| `nodemanager_registerexecutorrequestlatencymillis_rate5` | Rate of register executor request latency 5 managed by the node manager | B/s |
| `nodemanager_registerexecutorrequestlatencymillis_ratemean` | Mean rate of register executor request latency managed by the node manager | count |
| `nodemanager_renewalfailures` | Number of renewal failures managed by the node manager | count |
| `nodemanager_renewalfailurestotal` | Total number of renewal failures managed by the node manager | count |
| `nodemanager_rpcauthenticationfailures` | Number of RPC authentication failures managed by the node manager | count |
| `nodemanager_rpcauthorizationsuccesses` | Number of successful RPC authentications managed by the node manager | count |
| `nodemanager_rpcclientbackoff` | Number of RPC client backoffs managed by the node manager | count |
| `nodemanager_rpcprocessingtimeavgtime` | Average RPC processing time managed by the node manager | s |
| `nodemanager_rpcprocessingtimenumops` | Number of RPC processing operations managed by the node manager | count |
| `nodemanager_rpcqueuetimeavgtime` | Average RPC queue time managed by the node manager | count |
| `nodemanager_rpcqueuetimenumops` | Number of RPC queue operations managed by the node manager | count |
| `nodemanager_rpcslowcalls` | Number of slow RPC calls managed by the node manager | count |
| `nodemanager_runningopportunisticcontainers` | Number of running opportunistic containers managed by the node manager | count |
| `nodemanager_securityenabled` | Number of enabled security settings managed by the node manager | count |
| `nodemanager_sentbytes` | Number of sent bytes managed by the node manager | byte |
| `nodemanager_shuffleconnections` | Number of shuffle reconnections managed by the node manager | count |
| `nodemanager_shuffleoutputbytes` | Number of shuffle output bytes managed by the node manager | byte |
| `nodemanager_shuffleoutputsfailed` | Number of failed shuffle outputs managed by the node manager | count |
| `nodemanager_shuffleoutputsok` | Number of successful shuffle outputs managed by the node manager | count |
| `nodemanager_snapshotavgtime` | Average snapshot time managed by the node manager | s |
| `nodemanager_snapshotnumops` | Number of snapshot operations managed by the node manager | count |
| `nodemanager_threadsblocked` | Number of blocked threads managed by the node manager | count |
| `nodemanager_threadsnew` | Number of new threads managed by the node manager | count |
| `nodemanager_threadsrunnable` | Number of runnable threads managed by the node manager | count |
| `nodemanager_threadsterminated` | Number of terminated threads managed by the node manager | count |
| `nodemanager_threadstimedwaiting` | Thread waiting time managed by the node manager | s |
| `nodemanager_threadswaiting` | Number of waiting threads managed by the node manager | count |
| `nodemanager_totalbytesdeleted` | Total number of deleted bytes managed by the node manager | byte |

</input_content>
</input>
</instruction>
</xml>