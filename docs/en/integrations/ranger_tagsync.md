---
title     : 'Ranger Tagsync'
summary   : 'Collect Ranger Tagsync Metrics information'
__int_icon: 'icon/ranger'
dashboard :
  - desc  : 'Built-in views for Ranger Tagsync'
    path  : 'dashboard/en/ranger_tagsync'
---

Collect Ranger Tagsync Metrics information

## Configuration {#config}

### 1. Ranger Tagsync Configuration

#### 1.1 Download jmx-exporter

Download address: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx Script

Download address: `https://github.com/lrwh/jmx-exporter/blob/main/common.yml`

#### 1.3 Adjust Ranger Tagsync Startup Parameters

Add the following to the Ranger Tagsync startup parameters:

> {JAVA_GC_ARGS} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17144:/opt/guance/jmx/common.yml

#### 1.4 Restart Ranger Tagsync

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure the Collector

The jmx-exporter can directly expose a `metrics` URL, so you can use the [Prometheus](./prom.md) collector for collection.

Navigate to the `conf.d/prom` directory under the [DataKit installation directory](./datakit_dir.md), and copy `prom.conf.sample` to `ranger-tagsync.conf`.

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
<font color="red">*Other configurations can be adjusted as needed*</font>, parameter adjustment description:
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD004 -->
- urls: The `jmx-exporter` metrics URL, fill in the metrics URL exposed by the corresponding component
- source: Alias for the collector, it is recommended to differentiate
- keep_exist_metric_name: Keep metric names
- interval: Collection interval
- inputs.prom.tags: Add additional tags
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Measurement Set

Ranger Tagsync metrics are located under the Hadoop Measurement set. Below is an introduction to the relevant metrics for Ranger Tagsync.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`hadoop_tagsync_countevents` | Total number of events occurred | count |
|`hadoop_tagsync_counteventstime` | Total time spent processing these events | ms |
|`hadoop_tagsync_countuploads` | Total number of upload operations | count |
|`hadoop_tagsync_countuploadstime` | Total time spent processing upload operations | ms |
|`hadoop_tagsync_droppedpuball` | Total number of dropped publish events | count |
|`hadoop_tagsync_gccounttotal` | Total number of garbage collection (GC) operations | count |
|`hadoop_tagsync_gctimemax` | Maximum time spent on garbage collection (GC) | ms |
|`hadoop_tagsync_gctimetotal` | Total time spent on garbage collection (GC) | ms |
|`hadoop_tagsync_getgroupsavgtime` | Average time to get user groups | ms |
|`hadoop_tagsync_getgroupsnumops` | Number of operations to get user groups | count |
|`hadoop_tagsync_loginfailureavgtime` | Average time for login failures | ms |
|`hadoop_tagsync_loginfailurenumops` | Number of login failures | count |
|`hadoop_tagsync_loginsuccessavgtime` | Average time for successful logins | ms |
|`hadoop_tagsync_loginsuccessnumops` | Number of successful logins | count |
|`hadoop_tagsync_memorycurrent` | Current memory usage | bytes |
|`hadoop_tagsync_memorymax` | Maximum memory usage | bytes |
|`hadoop_tagsync_numactivesinks` | Number of active sinks | count |
|`hadoop_tagsync_numactivesources` | Number of active sources | count |
|`hadoop_tagsync_numallsinks` | Total number of sinks | count |
|`hadoop_tagsync_processorsavailable` | Number of available processors | count |
|`hadoop_tagsync_publishavgtime` | Average time for publish operations | ms |
|`hadoop_tagsync_publishnumops` | Number of publish operations | count |
|`hadoop_tagsync_renewalfailures` | Number of renewal failures | count |
|`hadoop_tagsync_renewalfailurestotal` | Total number of renewal failures | count |
|`hadoop_tagsync_sink_jsonavgtime` | Average time for JSON sink operations | ms |
|`hadoop_tagsync_sink_jsondropped` | Number of messages dropped by JSON sink | count |
|`hadoop_tagsync_sink_jsonnumops` | Number of JSON sink operations | count |
|`hadoop_tagsync_sink_jsonqsize` | Queue size of JSON sink | count |
|`hadoop_tagsync_sink_prometheusavgtime` | Average time for Prometheus sink operations | ms |
|`hadoop_tagsync_sink_prometheusdropped` | Number of messages dropped by Prometheus sink | count |
|`hadoop_tagsync_sink_prometheusnumops` | Number of Prometheus sink operations | count |
|`hadoop_tagsync_sink_prometheusqsize` | Queue size of Prometheus sink | count |
|`hadoop_tagsync_snapshotavgtime` | Average time for snapshot operations | ms |
|`hadoop_tagsync_snapshotnumops` | Number of snapshot operations | count |
|`hadoop_tagsync_systemloadavg` | System average load | count |
|`hadoop_tagsync_threadsblocked` | Number of blocked threads | count |
|`hadoop_tagsync_threadsbusy` | Number of busy threads | count |
|`hadoop_tagsync_threadsremaining` | Number of remaining threads | count |
|`hadoop_tagsync_threadswaiting` | Number of waiting threads | count |
</input_content>
</example>
</example>