---
title     : 'Ranger Usersync'
summary   : 'Collect Ranger Usersync metric information'
__int_icon: 'icon/ranger'
dashboard :
  - desc  : 'Ranger Usersync built-in view'
    path  : 'dashboard/en/ranger_usersync'
---

Collect Ranger Usersync metric information

## Config {#config}

### 1.Ranger Usersync configuration

#### 1.1 Download jmx-exporter

Download link：`https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx script

Download link：`https://github.com/lrwh/jmx-exporter/blob/main/common.yml`

#### 1.3 Ranger Usersync startup parameter adjustment

Add startup parameters to Ranger Usersync

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17145:/opt/guance/jmx/common.yml

#### 1.4 Restart Ranger Usersync

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure collector

By using jmx exporter, the `metrics` URL can be directly exposed, so it can be collected directly through the [prom](./prom.md) collector。

Go to the `conf.d/prom` directory under the [DataKit installation directory](./datakit_dir.md), and copy `prom.conf.sample` to `ranger-usersync.conf`.

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

The Ranger usersync metric is located under the Hadoop metric set, and here we mainly introduce the explanation of Ranger usersync related metrics

| Metric | Description |Unit |
|:--------|:-----|:--------|
|`hadoop_usersync_addgroupcountsuccess` |`The number of times a user group has been successfully added` | count |
|`hadoop_usersync_addusercountsuccess` |`The number of times users have been successfully added` | count |
|`hadoop_usersync_auditcountsuccess` |`The number of successful audit executions` | count |
|`hadoop_usersync_countgroup` |`The total number of user groups` | count |
|`hadoop_usersync_countgroupuser` |`The total number of users in the user group` | count |
|`hadoop_usersync_countuser` |`Total number of users` | count |
|`hadoop_usersync_droppedpuball` |`Total number of lost publishing events` | count |
|`hadoop_usersync_gccounttotal` |`Total frequency of garbage collection (GC)` | count |
|`hadoop_usersync_gctimemax` |`The maximum time required for garbage collection (GC)` | count |
|`hadoop_usersync_gctimetotal` |`Total time spent on garbage collection (GC)` | count |
|`hadoop_usersync_getgroupsavgtime` |`Obtain the average time of user groups` | count |
|`hadoop_usersync_getgroupsnumops` |`Get the number of operations for the user group` | count |
|`hadoop_usersync_groupusercountsuccess` |`The number of times the number of users in the user group has been successfully counted` | count |
|`hadoop_usersync_loginfailureavgtime` |`The average time taken for login failures` | ms |
|`hadoop_usersync_loginfailurenumops` |`Number of login failures` | count |
|`hadoop_usersync_loginsuccessavgtime` |`Average login success time` | ms |
|`hadoop_usersync_loginsuccessnumops` |`Number of successful login attempts` | count |
|`hadoop_usersync_memorycurrent` |`Current memory usage` | byte |
|`hadoop_usersync_memorymax` |`Maximum memory usage` | byte |
|`hadoop_usersync_numactivesinks` |`Number of active sinks` | count |
|`hadoop_usersync_numactivesources` |`Number of active data sources` | count |
|`hadoop_usersync_numallsinks` |`The total number of all sinks` | count |
|`hadoop_usersync_numallsources` |`The total number of all data sources` | count |
|`hadoop_usersync_processorsavailable` |`Number of available processors` | count |
|`hadoop_usersync_publishavgtime` |`The average time taken for publishing operations` | ms |
|`hadoop_usersync_publishnumops` |`Number of publishing operations` | count |
|`hadoop_usersync_renewalfailures` |`Number of failed updates` | count |
|`hadoop_usersync_sink_jsonavgtime` |`Average time consumption of JSON receiver` | count |
|`hadoop_usersync_sink_jsondropped` |`The number of messages discarded by the JSON receiver` | count |
|`hadoop_usersync_sink_jsonnumops` |`JSON receiver operation times` | count |
|`hadoop_usersync_sink_jsonqsize` |`The queue size of the JSON receiver` | count |
|`hadoop_usersync_sink_prometheusavgtime` |`The average time consumption of Prometheus receivers` | count |
|`hadoop_usersync_sink_prometheusdropped` |`The number of messages discarded by Prometheus receivers` | count |
|`hadoop_usersync_sink_prometheusnumops` |`Prometheus receiver operation times` | count |
|`hadoop_usersync_sink_prometheusqsize` |`The queue size of Prometheus receivers` | count |
|`hadoop_usersync_snapshotavgtime` |`The average time consumption of snapshot operations` | ms |
|`hadoop_usersync_snapshotnumops` |`Number of snapshot operations` | count |
|`hadoop_usersync_systemloadavg` |`The average load of the system` | count |
|`hadoop_usersync_threadsblocked` |`Number of blocked threads` | count |
|`hadoop_usersync_threadsremaining` |`Remaining number of threads` | count |
|`hadoop_usersync_threadswaiting` |`Number of waiting threads` | count |
