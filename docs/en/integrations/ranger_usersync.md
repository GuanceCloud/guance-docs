---
title     : 'Ranger Usersync'
summary   : 'Collect Ranger Usersync Metrics information'
__int_icon: 'icon/ranger'
dashboard :
  - desc  : 'Built-in views for Ranger Usersync'
    path  : 'dashboard/en/ranger_usersync'
---

Collect Ranger Usersync Metrics information

## Configuration {#config}

### 1. Ranger Usersync Configuration

#### 1.1 Download jmx-exporter

Download address: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx Script

Download address: `https://github.com/lrwh/jmx-exporter/blob/main/common.yml`

#### 1.3 Adjust Ranger Usersync Startup Parameters

Add the following to the startup parameters of Ranger Usersync:

> {JAVA_GC_ARGS} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17145:/opt/guance/jmx/common.yml

#### 1.4 Restart Ranger Usersync

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure the Collector

The jmx-exporter can directly expose a `metrics` URL, so you can use the [Prometheus collector](./prom.md) for collection.

Go to the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, copy `prom.conf.sample` to `ranger-usersync.conf`.

> `cp prom.conf.sample ranger-usersync.conf`

Adjust the content of `ranger-usersync.conf` as follows:

```toml
  urls = ["http://localhost:17145/metrics"]
  source ="ranger-usersync"
  [inputs.prom.tags]
    component = "ranger-usersync" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations should be adjusted as needed*</font>, parameter adjustment explanation:
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD004 -->
- urls: The `jmx-exporter` metrics URL, fill in the metrics URL exposed by the corresponding component.
- source: Alias for the collector, it is recommended to differentiate.
- keep_exist_metric_name: Keep metric names.
- interval: Collection interval.
- inputs.prom.tags: Add additional tags.
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Metrics Set

Ranger Usersync metrics are located under the Hadoop metrics set. Below is an introduction to the relevant metrics for Ranger Usersync.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`hadoop_usersync_addgroupcountsuccess` | Number of successful user group additions | count |
|`hadoop_usersync_addusercountsuccess` | Number of successful user additions | count |
|`hadoop_usersync_auditcountsuccess` | Number of successful audits | count |
|`hadoop_usersync_countgroup` | Total number of user groups | count |
|`hadoop_usersync_countgroupuser` | Total number of users in user groups | count |
|`hadoop_usersync_countuser` | Total number of users | count |
|`hadoop_usersync_droppedpuball` | Total number of dropped publish events | count |
|`hadoop_usersync_gccounttotal` | Total number of garbage collections (GC) | count |
|`hadoop_usersync_gctimemax` | Maximum time spent on garbage collection (GC) | count |
|`hadoop_usersync_gctimetotal` | Total time spent on garbage collection (GC) | count |
|`hadoop_usersync_getgroupsavgtime` | Average time to get user groups | count |
|`hadoop_usersync_getgroupsnumops` | Number of operations to get user groups | count |
|`hadoop_usersync_groupusercountsuccess` | Number of successful counts of users in user groups | count |
|`hadoop_usersync_loginfailureavgtime` | Average time for failed logins | ms |
|`hadoop_usersync_loginfailurenumops` | Number of failed login attempts | count |
|`hadoop_usersync_loginsuccessavgtime` | Average time for successful logins | ms |
|`hadoop_usersync_loginsuccessnumops` | Number of successful login attempts | count |
|`hadoop_usersync_memorycurrent` | Current memory usage | byte |
|`hadoop_usersync_memorymax` | Maximum memory usage | byte |
|`hadoop_usersync_numactivesinks` | Number of active sinks | count |
|`hadoop_usersync_numactivesources` | Number of active sources | count |
|`hadoop_usersync_numallsinks` | Total number of sinks | count |
|`hadoop_usersync_numallsources` | Total number of sources | count |
|`hadoop_usersync_processorsavailable` | Number of available processors | count |
|`hadoop_usersync_publishavgtime` | Average time for publish operations | ms |
|`hadoop_usersync_publishnumops` | Number of publish operations | count |
|`hadoop_usersync_renewalfailures` | Number of renewal failures | count |
|`hadoop_usersync_sink_jsonavgtime` | Average time for JSON sink operations | count |
|`hadoop_usersync_sink_jsondropped` | Number of messages dropped by JSON sink | count |
|`hadoop_usersync_sink_jsonnumops` | Number of JSON sink operations | count |
|`hadoop_usersync_sink_jsonqsize` | Queue size of JSON sink | count |
|`hadoop_usersync_sink_prometheusavgtime` | Average time for Prometheus sink operations | count |
|`hadoop_usersync_sink_prometheusdropped` | Number of messages dropped by Prometheus sink | count |
|`hadoop_usersync_sink_prometheusnumops` | Number of Prometheus sink operations | count |
|`hadoop_usersync_sink_prometheusqsize` | Queue size of Prometheus sink | count |
|`hadoop_usersync_snapshotavgtime` | Average time for snapshot operations | ms |
|`hadoop_usersync_snapshotnumops` | Number of snapshot operations | count |
|`hadoop_usersync_systemloadavg` | System's average load | count |
|`hadoop_usersync_threadsblocked` | Number of blocked threads | count |
|`hadoop_usersync_threadsremaining` | Number of remaining threads | count |
|`hadoop_usersync_threadswaiting` | Number of waiting threads | count |
