---
title     : 'Ranger Admin'
summary   : 'Collect Ranger Admin metric information'
__int_icon: 'icon/ranger'
dashboard :
  - desc  : 'Ranger Admin built-in view'
    path  : 'dashboard/en/ranger_admin'
---

Collect Ranger Admin metric information

## Config {#config}

### 1.Ranger Admin configuration

#### 1.1 Download jmx-exporter

Download link：`https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx script

Download link：`https://github.com/lrwh/jmx-exporter/blob/main/common.yml`

#### 1.3 Ranger Admin startup parameter adjustment

在 Ranger Admin 的启动参数添加

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17143:/opt/guance/jmx/common.yml

#### 1.4 Restart Ranger Admin

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure collector

By using jmx exporter, the `metrics` URL can be directly exposed, so it can be collected directly through the [prom](./prom.md) collector.

Go to the `conf.d/prom` directory under the [DataKit installation directory](./datakit_dir.md), and copy `prom.conf.sample` to `ranger-admin.conf`.

> `cp prom.conf.sample ranger-admin.conf`

Adjust the content of `ranger-admin.conf` as follows:

```toml
  urls = ["http://localhost:17143/metrics"]
  source ="ranger-admin"
  [inputs.prom.tags]
    component = "ranger-admin" 
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

### Hadoop Metric set

The Ranger Admin metric is located under the Hadoop metric set, and here we mainly introduce the explanation of Ranger Admin related metrics

| Metrics | Description |Unit |
|:--------|:-----|:--------|
|`hadoop_admin_contextenrichercount` |`Number of Context Enrichers` | count |
|`hadoop_admin_contextenrichercounttag` |`The number of context enriches with specific tags` | count |
|`hadoop_admin_denyconditioncount` |`The number of rejection conditions` | count |
|`hadoop_admin_denyconditioncounttag` |`The number of rejection conditions with specific labels` | count |
|`hadoop_admin_droppedpuball` |`Total number of discarded publishing operations` | count |
|`hadoop_admin_gccounttotal` |`Total frequency of garbage collection (GC)` | count |
|`hadoop_admin_gctimemax` |`The maximum time required for garbage collection (GC)` | ms |
|`hadoop_admin_gctimetotal` |`Total time spent on garbage collection (GC)` | ms |
|`hadoop_admin_getgroupsavgtime` |`Obtain the average time of user groups` | ms |
|`hadoop_admin_getgroupsnumops` |`Get the number of operations for the user group` | count |
|`hadoop_admin_groupcount` |`Number of user groups` | count |
|`hadoop_admin_loginfailureavgtime` |`The average time taken for login failures` | ms |
|`hadoop_admin_loginfailurenumops` |`Number of login failures` | count |
|`hadoop_admin_loginsuccessavgtime` |`Average login success time` | ms |
|`hadoop_admin_loginsuccessnumops` |`Number of successful login attempts` | count |
|`hadoop_admin_maskingcount` |`The frequency of data desensitization` | count |
|`hadoop_admin_memorycurrent` |`Current memory usage` | count |
|`hadoop_admin_memorymax` |`Maximum memory usage` | count |
|`hadoop_admin_numactivesinks` |`Number of active sinks` | count |
|`hadoop_admin_numactivesources` |`Number of active data sources` | count |
|`hadoop_admin_numallsinks` |`The total number of all sinks` | count |
|`hadoop_admin_numallsources` |`The total number of all data sources` | count |
|`hadoop_admin_processorsavailable` |`Number of available processors` | count |
|`hadoop_admin_publishavgtime` |`The average time taken for publishing operations` | ms |
|`hadoop_admin_publishnumops` |`Number of publishing operations` | count |
|`hadoop_admin_renewalfailures` |`Number of failed updates` | count |
|`hadoop_admin_renewalfailurestotal` |`Total number of update failures` | count |
|`hadoop_admin_resourceaccesscount` |`Number of resource visits` | count |
|`hadoop_admin_resourceaccesscountatlas` |`Number of visits to Atlas resources` | count |
|`hadoop_admin_resourceaccesscounthbase` |`Number of visits to HBase resources` | count |
|`hadoop_admin_resourceaccesscounthdfs` |`The number of times HDFS resources are accessed` | count |
|`hadoop_admin_resourceaccesscounthive` |`Number of visits to Hive resources` | count |
|`hadoop_admin_resourceaccesscountkafka_connect` |`Number of visits to Kafka Connect resources` | count |
|`hadoop_admin_resourceaccesscountkms` |`The number of times KMS (Key Management System) resources are accessed` | count |
|`hadoop_admin_resourceaccesscountknox` |`Number of visits to Knox resources` | count |
|`hadoop_admin_resourceaccesscountkudu` |`Number of visits to Kudu resources` | count |
|`hadoop_admin_resourceaccesscountozone` |`Number of visits to Ozone resources` | count |
|`hadoop_admin_resourceaccesscountsolr` |`Number of visits to Solr resources` | count |
|`hadoop_admin_resourceaccesscounttag` |`Number of visits to resources with specific tags` | count |
|`hadoop_admin_resourceaccesscountyarn` |`The number of resource visits using ARN (Amazon Resource Name)` | count |
|`hadoop_admin_rowfilteringcount` |`The number of times the line is filtered` | count |
|`hadoop_admin_servicecount` |`Total number of services provided` | count |
|`hadoop_admin_servicecountatlas` |`Number of Atlas services` | count |
|`hadoop_admin_servicecounthbase` |`The number of HBase services` | count |
|`hadoop_admin_servicecounthdfs` |`The number of HDFS services` | count |
|`hadoop_admin_servicecounthive` |`Number of Hive services` | count |
|`hadoop_admin_servicecountkafka` |`Number of Kafka services` | count |
|`hadoop_admin_servicecountkafka_connect` |`Number of Kafka Connect services` | count |
|`hadoop_admin_servicecountkms` |`Number of KMS services` | count |
|`hadoop_admin_servicecountknox` |`The quantity of Knox services` | count |
|`hadoop_admin_servicecountozone` |`Number of Ozone services` | count |
|`hadoop_admin_servicecountkudu` |`The quantity of Kudu services` | count |
|`hadoop_admin_servicecountsolr` |`Number of solr services` | count |
|`hadoop_admin_servicecounttag` |`Number of services with specific tags` | count |
|`hadoop_admin_servicecountyarn` |`Number of services using ARN` | count |
|`hadoop_admin_sink_jsonavgtime` |`Average time consumption of JSON receiver` | ms |
|`hadoop_admin_sink_jsondropped` |`The number of messages discarded by the JSON receiver` | count |
|`hadoop_admin_sink_jsonnumops` |`JSON receiver operation times` | count |
|`hadoop_admin_sink_jsonqsize` |`The queue size of the JSON receiver` | count |
|`hadoop_admin_sink_prometheusavgtime` |`The average time consumption of Prometheus receivers` | count |
|`hadoop_admin_sink_prometheusdropped` |`Messages discarded by Prometheus receiver数` | count |
|`hadoop_admin_sink_prometheusnumops` |`Prometheus receiver operation times` | count |
|`hadoop_admin_sink_prometheusqsize` |`The queue size of Prometheus receivers` | count |
|`hadoop_admin_snapshotavgtime` |`The average time consumption of snapshot operations` | count |
|`hadoop_admin_snapshotnumops` |`Number of snapshot operations` | count |
|`hadoop_admin_systemloadavg` |`System average load` | count |
|`hadoop_admin_threadsblocked` |`Number of blocked threads` | count |
|`hadoop_admin_threadsbusy` |`Number of busy threads` | count |
|`hadoop_admin_threadsremaining` |`Remaining number of threads` | count |
|`hadoop_admin_threadswaiting` |`Number of waiting threads` | count |
|`hadoop_admin_usercount` |`Total number of users` | count |
|`hadoop_admin_systemloadavg` |`System average load` | count |
|`hadoop_admin_usercountsysadmin` |`Number of system administrator users` | count |
|`hadoop_admin_usercountuser` |`Number of ordinary users` | count |
