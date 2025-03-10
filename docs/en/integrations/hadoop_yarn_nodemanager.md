---
title: 'Hadoop Yarn NodeManager'
summary: 'Collect Yarn NodeManager Metrics information'
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

Collect Yarn NodeManager Metrics information.

## Installation and Deployment {#config}

Since NodeManager is developed in Java, it can use the jmx-exporter method to collect metrics information.

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

The jmx-exporter can directly expose `metrics` URL, so you can collect data using the [`prom`](./prom.md) collector.

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
- urls: The `jmx-exporter` metrics address, fill in the metrics URL exposed by the corresponding component.
- source: Alias for the collector, it's recommended to differentiate them.
- keep_exist_metric_name: Keep metric names unchanged.
- interval: Collection interval.
- inputs.prom.tags: Add extra tags.
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Metrics Set

NodeManager metrics are located under the Hadoop Metrics set. This section mainly introduces the related metrics for NodeManager.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
| `nodemanager_allocatedcontainers` | Number of containers allocated by the node manager | count |
| `nodemanager_allocatedgb` | GB allocated by the node manager | count |
| `nodemanager_allocatedopportunisticgb` | Opportunistic GB allocated by the node manager | count |
| `nodemanager_allocatedopportunisticvcores` | Opportunistic vCores allocated by the node manager | count |
| `nodemanager_allocatedvcores` | vCores allocated by the node manager | count |
| `nodemanager_availablegb` | Available GB on the node manager | count |
| `nodemanager_availablevcores` | Available vCores on the node manager | count |
| `nodemanager_badlocaldirs` | Number of bad local directories on the node manager | count |
| `nodemanager_badlogdirs` | Number of bad log directories on the node manager | count |
| `nodemanager_blocktransferratebytes_count` | Block transfer bytes on the node manager | byte |
| `nodemanager_blocktransferratebytes_rate1` | Block transfer byte rate 1 on the node manager | B/s |
| `nodemanager_blocktransferratebytes_rate15` | Block transfer byte rate 15 on the node manager | B/s |
| `nodemanager_blocktransferratebytes_rate5` | Block transfer byte rate 5 on the node manager | B/s |
| `nodemanager_blocktransferratebytes_ratemean` | Mean block transfer byte rate on the node manager | byte |
| `nodemanager_cachesizebeforeclean` | Cache size before cleaning on the node manager | byte |
| `nodemanager_callqueuelength` | Call queue length on the node manager | count |
| `nodemanager_containerlaunchdurationavgtime` | Average container launch duration on the node manager | s |
| `nodemanager_containerlaunchdurationnumops` | Number of container launch operations on the node manager | count |
| `nodemanager_containerscompleted` | Number of completed containers on the node manager | count |
| `nodemanager_containersfailed` | Number of failed containers on the node manager | count |
| `nodemanager_containersiniting` | Number of initializing containers on the node manager | count |
| `nodemanager_containerskilled` | Number of killed containers on the node manager | count |
| `nodemanager_containerslaunched` | Number of launched containers on the node manager | count |
| `nodemanager_containersreiniting` | Number of reinitializing containers on the node manager | count |
| `nodemanager_containersrolledbackonfailure` | Number of containers rolled back on failure on the node manager | count |
| `nodemanager_containersrunning` | Number of running containers on the node manager | ms |
| `nodemanager_deferredrpcprocessingtimeavgtime` | Average deferred RPC processing time on the node manager | s |
| `nodemanager_deferredrpcprocessingtimenumops` | Number of deferred RPC operations on the node manager | count |
| `nodemanager_droppedpuball` | Number of dropped puball on the node manager | count |
| `nodemanager_gccount` | Garbage collection count on the node manager | count |
| `nodemanager_gccountconcurrentmarksweep` | Concurrent mark sweep garbage collection count on the node manager | count |
| `nodemanager_gccountparnew` | ParNew garbage collection count on the node manager | count |
| `nodemanager_gcnuminfothresholdexceeded` | Number of garbage collection info threshold exceeded on the node manager | count |
| `nodemanager_gcnumwarnthresholdexceeded` | Number of garbage collection warning threshold exceeded on the node manager | count |
| `nodemanager_gctimemillis` | Garbage collection time in milliseconds on the node manager | ms |
| `nodemanager_gctimemillisconcurrentmarksweep` | Concurrent mark sweep garbage collection time in milliseconds on the node manager | ms |
| `nodemanager_gctimemillisparnew` | ParNew garbage collection time in milliseconds on the node manager | ms |
| `nodemanager_gctotalextrasleeptime` | Total extra sleep time for garbage collection on the node manager | s |
| `nodemanager_getgroupsavgtime` | Average time to get groups on the node manager | s |
| `nodemanager_getgroupsnumops` | Number of operations to get groups on the node manager | count |
| `nodemanager_goodlocaldirsdiskutilizationperc` | Percentage of good local disk utilization on the node manager | count |
| `nodemanager_logerror` | Number of log errors on the node manager | count |
| `nodemanager_logfatal` | Number of fatal logs on the node manager | count |
| `nodemanager_loginfailureavgtime` | Average login failure time on the node manager | ms |
| `nodemanager_loginfailurenumops` | Number of login failures on the node manager | count |
| `nodemanager_loginfo` | Number of log information entries on the node manager | count |
| `nodemanager_loginsuccessavgtime` | Average login success time on the node manager | count |
| `nodemanager_loginsuccessnumops` | Number of successful logins on the node manager | count |
| `nodemanager_logwarn` | Number of log warnings on the node manager | count |
| `nodemanager_memheapcommittedm` | Committed heap memory on the node manager | count |
| `nodemanager_memheapmaxm` | Maximum heap memory on the node manager | count |
| `nodemanager_memheapusedm` | Used heap memory on the node manager | count |
| `nodemanager_memmaxm` | Maximum memory on the node manager | byte |
| `nodemanager_memnonheapcommittedm` | Non-committed heap memory on the node manager | count |
| `nodemanager_memnonheapmaxm` | Maximum non-committed heap memory on the node manager | count |
| `nodemanager_memnonheapusedm` | Non-used heap memory on the node manager | count |
| `nodemanager_numactiveconnections` | Number of active connections on the node manager | count |
| `nodemanager_numactivesinks` | Number of active sinks on the node manager | count |
| `nodemanager_numactivesources` | Number of active sources on the node manager | count |
| `nodemanager_numallsinks` | Total number of sinks on the node manager | count |
| `nodemanager_numallsources` | Total number of sources on the node manager | count |
| `nodemanager_numdroppedconnections` | Number of dropped connections on the node manager | count |
| `nodemanager_numopenconnections` | Number of open connections on the node manager | count |
| `nodemanager_numregisteredconnections` | Number of registered connections on the node manager | count |
| `nodemanager_openblockrequestlatencymillis_count` | Number of open block request latencies on the node manager | count |
| `nodemanager_openblockrequestlatencymillis_rate1` | Open block request latency rate 1 on the node manager | B/s |
| `nodemanager_openblockrequestlatencymillis_rate15` | Open block request latency rate 15 on the node manager | B/s |
| `nodemanager_openblockrequestlatencymillis_rate5` | Open block request latency rate 5 on the node manager | B/s |
| `nodemanager_openblockrequestlatencymillis_ratemean` | Mean open block request latency rate on the node manager | B/s |
| `nodemanager_privatebytesdeleted` | Private bytes deleted on the node manager | byte |
| `nodemanager_publicbytesdeleted` | Public bytes deleted on the node manager | byte |
| `nodemanager_publishavgtime` | Average publish time on the node manager | s |
| `nodemanager_publishnumops` | Number of publish operations on the node manager | ms |
| `nodemanager_receivedbytes` | Received bytes on the node manager | byte |
| `nodemanager_registeredexecutorssize` | Number of registered executors on the node manager | count |
| `nodemanager_registerexecutorrequestlatencymillis_count` | Number of register executor request latencies on the node manager | count |
| `nodemanager_registerexecutorrequestlatencymillis_rate1` | Register executor request latency rate 1 on the node manager | B/s |
| `nodemanager_registerexecutorrequestlatencymillis_rate15` | Register executor request latency rate 15 on the node manager | B/s |
| `nodemanager_registerexecutorrequestlatencymillis_rate5` | Register executor request latency rate 5 on the node manager | B/s |
| `nodemanager_registerexecutorrequestlatencymillis_ratemean` | Mean register executor request latency on the node manager | count |
| `nodemanager_renewalfailures` | Number of renewal failures on the node manager | count |
| `nodemanager_renewalfailurestotal` | Total number of renewal failures on the node manager | count |
| `nodemanager_rpcauthenticationfailures` | Number of RPC authentication failures on the node manager | count |
| `nodemanager_rpcauthorizationsuccesses` | Number of successful RPC authentications on the node manager | count |
| `nodemanager_rpcclientbackoff` | Number of RPC client backoffs on the node manager | count |
| `nodemanager_rpcprocessingtimeavgtime` | Average RPC processing time on the node manager | s |
| `nodemanager_rpcprocessingtimenumops` | Number of RPC processing operations on the node manager | count |
| `nodemanager_rpcqueuetimeavgtime` | Average RPC queue time on the node manager | count |
| `nodemanager_rpcqueuetimenumops` | Number of RPC queue time operations on the node manager | count |
| `nodemanager_rpcslowcalls` | Number of slow RPC calls on the node manager | count |
| `nodemanager_runningopportunisticcontainers` | Number of running opportunistic containers on the node manager | count |
| `nodemanager_securityenabled` | Security enabled on the node manager | count |
| `nodemanager_sentbytes` | Bytes sent by the node manager | byte |
| `nodemanager_shuffleconnections` | Number of shuffle connections on the node manager | count |
| `nodemanager_shuffleoutputbytes` | Shuffle output bytes on the node manager | byte |
| `nodemanager_shuffleoutputsfailed` | Number of failed shuffle outputs on the node manager | count |
| `nodemanager_shuffleoutputsok` | Number of successful shuffle outputs on the node manager | count |
| `nodemanager_snapshotavgtime` | Average snapshot time on the node manager | s |
| `nodemanager_snapshotnumops` | Number of snapshot operations on the node manager | count |
| `nodemanager_threadsblocked` | Number of blocked threads on the node manager | count |
| `nodemanager_threadsnew` | Number of new threads on the node manager | count |
| `nodemanager_threadsrunnable` | Number of runnable threads on the node manager | count |
| `nodemanager_threadsterminated` | Number of terminated threads on the node manager | count |
| `nodemanager_threadstimedwaiting` | Time spent waiting by threads on the node manager | s |
| `nodemanager_threadswaiting` | Number of waiting threads on the node manager | count |
| `nodemanager_totalbytesdeleted` | Total bytes deleted on the node manager | byte |

</input_content>
</example>
</example>