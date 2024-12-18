---
title     : 'Ranger Tagsync'
summary   : 'Collect Ranger Tagsync metric information'
__int_icon: 'icon/ranger'
dashboard :
  - desc  : 'Ranger Tagsync built-in view'
    path  : 'dashboard/en/ranger_tagsync'
---

Collect Ranger Tagsync metric information

## Config {#config}

### 1.Ranger Tagsync configuration

#### 1.1 Download jmx-exporter

Download link：`https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx script

Download link：`https://github.com/lrwh/jmx-exporter/blob/main/common.yml`

#### 1.3 Ranger Tagsync startup parameter adjustment

Add startup parameters to Ranger Tagsync

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17144:/opt/guance/jmx/common.yml

#### 1.4 Restart Ranger Tagsync

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure collector

By using jmx exporter, the `metrics` URL can be directly exposed, so it can be collected directly through the [prom](./prom.md) collector。

Go to the `conf.d/prom` directory under the [DataKit installation directory](./datakit_dir.md), and copy `prom.conf.sample` to `ranger-tagsync.conf`.

> `cp prom.conf.sample ranger-tagsync.conf`

Adjust the content of `ranger-tagsync.conf` as follows:

```toml
  urls = ["http://localhost:17144/metrics"]
  source ="ranger-tagsync"
  [inputs.prom.tags]
    component = "ranger-tagsync" 
  interval = "10s"
```
<!-- markdownlint-disable MD033 -->
<font color="red">*Adjust other configurations as needed*</font>，parameter adjustment instructions ：
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD004 -->
- urls：`jmx-exporter` metric address, fill in the URL of the metric exposed by the corresponding component here
- source：Collector alias, it is recommended to make a distinction
- keep_exist_metric_name: Maintain metric name
- interval：Collection interval
- inputs.prom.tags: Add additional tags
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart Datakit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

### Hadoop metric set

The Ranger tagsync metric is located under the Hadoop metric set, and here we mainly introduce the explanation of Ranger tagsync related metrics

| Metric | Description |Unit |
|:--------|:-----|:--------|
|`hadoop_tagsync_countevents` |`Total number of events that occurred` | count |
|`hadoop_tagsync_counteventstime` |`The total time spent handling these events` | ms |
|`hadoop_tagsync_countuploads` |`The total number of upload operations` | count |
|`hadoop_tagsync_countuploadstime` |`The total time spent on processing upload operations` | count |
|`hadoop_tagsync_droppedpuball` |`Total number of lost publish events` | count |
|`hadoop_tagsync_gccounttotal` |`Total frequency of garbage collection (GC)` | count |
|`hadoop_tagsync_gctimemax` |`The maximum time required for garbage collection (GC)` | ms |
|`hadoop_tagsync_gctimetotal` |`Total time spent on garbage collection (GC)` | count |
|`hadoop_tagsync_getgroupsavgtime` |`Obtain the average time of user groups` | ms |
|`hadoop_tagsync_getgroupsnumops` |`Get the number of operations for the user group` | count |
|`hadoop_tagsync_loginfailureavgtime` |`The average time taken for login failures` | ms |
|`hadoop_tagsync_loginfailurenumops` |`Number of login failures` | count |
|`hadoop_tagsync_loginsuccessavgtime` |`Average login success time` | ms |
|`hadoop_tagsync_loginsuccessnumops` |`Number of successful login attempts` | count |
|`hadoop_tagsync_memorycurrent` |`Current memory usage` | count |
|`hadoop_tagsync_memorymax` |`Maximum memory usage` | count |
|`hadoop_tagsync_numactivesinks` |`Number of active sinks` | count |
|`hadoop_tagsync_numactivesources` |`Number of active data sources` | count |
|`hadoop_tagsync_numallsinks` |`The total number of all data sources` | count |
|`hadoop_tagsync_processorsavailable` |`Number of available processors` | count |
|`hadoop_tagsync_publishavgtime` |`The average time taken for publishing operations` | count |
|`hadoop_tagsync_publishnumops` |`Number of publishing operations` | count |
|`hadoop_tagsync_renewalfailures` |`Number of failed updates` | count |
|`hadoop_tagsync_renewalfailurestotal` |`Total number of update failures` | count |
|`hadoop_tagsync_sink_jsonavgtime` |`Average time consumption of JSON receiver` | count |
|`hadoop_tagsync_sink_jsondropped` |`The number of messages discarded by the JSON receiver` | count |
|`hadoop_tagsync_sink_jsonnumops` |`JSON receiver operation times` | count |
|`hadoop_tagsync_sink_jsonqsize` |`The queue size of the JSON receiver` | count |
|`hadoop_tagsync_sink_prometheusavgtime` |`The average time consumption of Prometheus receivers` | count |
|`hadoop_tagsync_sink_prometheusdropped` |`The number of messages discarded by Prometheus receivers` | count |
|`hadoop_tagsync_sink_prometheusnumops` |`Prometheus receiver operation times` | count |
|`hadoop_tagsync_sink_prometheusqsize` |`The queue size of Prometheus receivers` | count |
|`hadoop_tagsync_snapshotavgtime` |`The average time consumption of snapshot operations` | count |
|`hadoop_tagsync_snapshotnumops` |`Number of snapshot operations` | count |
|`hadoop_tagsync_systemloadavg` |`The average load of the system` | count |
|`hadoop_tagsync_threadsblocked` |`Number of blocked threads` | count |
|`hadoop_tagsync_threadsbusy` |`Number of busy threads` | count |
|`hadoop_tagsync_threadsremaining` |`Remaining number of threads` | count |
|`hadoop_tagsync_threadswaiting` |`Number of waiting threads` | count |
