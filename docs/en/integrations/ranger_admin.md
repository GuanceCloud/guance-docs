---
title     : 'Ranger Admin'
summary   : 'Collect Ranger Admin Metrics Information'
__int_icon: 'icon/ranger'
dashboard :
  - desc  : 'Built-in Views for Ranger Admin'
    path  : 'dashboard/en/ranger_admin'
---

Collect Ranger Admin Metrics Information

## Configuration {#config}

### 1. Ranger Admin Configuration

#### 1.1 Download jmx-exporter

Download URL: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download JMX Script

Download URL: `https://github.com/lrwh/jmx-exporter/blob/main/common.yml`

#### 1.3 Adjust Ranger Admin Startup Parameters

Add the following to the startup parameters of Ranger Admin:

> {JAVA_GC_ARGS} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17143:/opt/guance/jmx/common.yml

#### 1.4 Restart Ranger Admin

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure Collector

The jmx-exporter can directly expose a `metrics` URL, so it can be collected using the [prom](./prom.md) collector.

Navigate to the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, copy `prom.conf.sample` to `ranger-admin.conf`.

> `cp prom.conf.sample ranger-admin.conf`

Adjust the content of `ranger_admin.conf` as follows:

```toml
  urls = ["http://localhost:17143/metrics"]
  source ="ranger-admin"
  [inputs.prom.tags]
    component = "ranger-admin" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations should be adjusted as needed*</font>, parameter adjustment explanation:
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD004 -->
- urls: The metrics address exposed by `jmx-exporter`, fill in the metrics URL exposed by the corresponding component
- source: Alias for the collector, it is recommended to differentiate
- keep_exist_metric_name: Keep metric names
- interval: Collection interval
- inputs.prom.tags: Add additional tags
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Metrics Set

Ranger Admin metrics are located under the Hadoop metrics set. This section mainly introduces the description of Ranger Admin-related metrics.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`hadoop_admin_contextenrichercount` | Number of context enrichers | count |
|`hadoop_admin_contextenrichercounttag` | Number of context enrichers with specific tags | count |
|`hadoop_admin_denyconditioncount` | Number of deny conditions | count |
|`hadoop_admin_denyconditioncounttag` | Number of deny conditions with specific tags | count |
|`hadoop_admin_droppedpuball` | Total number of dropped publish operations | count |
|`hadoop_admin_gccounttotal` | Total number of garbage collection (GC) occurrences | count |
|`hadoop_admin_gctimemax` | Maximum time spent on garbage collection (GC) | ms |
|`hadoop_admin_gctimetotal` | Total time spent on garbage collection (GC) | ms |
|`hadoop_admin_getgroupsavgtime` | Average time to get user groups | ms |
|`hadoop_admin_getgroupsnumops` | Number of operations to get user groups | count |
|`hadoop_admin_groupcount` | Number of user groups | count |
|`hadoop_admin_loginfailureavgtime` | Average time for login failures | ms |
|`hadoop_admin_loginfailurenumops` | Number of login failures | count |
|`hadoop_admin_loginsuccessavgtime` | Average time for successful logins | ms |
|`hadoop_admin_loginsuccessnumops` | Number of successful logins | count |
|`hadoop_admin_maskingcount` | Number of data masking operations | count |
|`hadoop_admin_memorycurrent` | Current memory usage | count |
|`hadoop_admin_memorymax` | Maximum memory usage | count |
|`hadoop_admin_numactivesinks` | Number of active sinks | count |
|`hadoop_admin_numactivesources` | Number of active sources | count |
|`hadoop_admin_numallsinks` | Total number of all sinks | count |
|`hadoop_admin_numallsources` | Total number of all sources | count |
|`hadoop_admin_processorsavailable` | Number of available processors | count |
|`hadoop_admin_publishavgtime` | Average time for publish operations | ms |
|`hadoop_admin_publishnumops` | Number of publish operations | count |
|`hadoop_admin_renewalfailures` | Number of renewal failures | count |
|`hadoop_admin_renewalfailurestotal` | Total number of renewal failures | count |
|`hadoop_admin_resourceaccesscount` | Number of resource accesses | count |
|`hadoop_admin_resourceaccesscountatlas` | Number of accesses to Atlas resources | count |
|`hadoop_admin_resourceaccesscounthbase` | Number of accesses to HBase resources | count |
|`hadoop_admin_resourceaccesscounthdfs` | Number of accesses to HDFS resources | count |
|`hadoop_admin_resourceaccesscounthive` | Number of accesses to Hive resources | count |
|`hadoop_admin_resourceaccesscountkafka_connect` | Number of accesses to Kafka Connect resources | count |
|`hadoop_admin_resourceaccesscountkms` | Number of accesses to KMS (Key Management System) resources | count |
|`hadoop_admin_resourceaccesscountknox` | Number of accesses to Knox resources | count |
|`hadoop_admin_resourceaccesscountkudu` | Number of accesses to Kudu resources | count |
|`hadoop_admin_resourceaccesscountozone` | Number of accesses to Ozone resources | count |
|`hadoop_admin_resourceaccesscountsolr` | Number of accesses to Solr resources | count |
|`hadoop_admin_resourceaccesscounttag` | Number of accesses to resources with specific tags | count |
|`hadoop_admin_resourceaccesscountyarn` | Number of accesses to resources using ARN (Amazon Resource Name) | count |
|`hadoop_admin_rowfilteringcount` | Number of row filtering operations | count |
|`hadoop_admin_servicecount` | Total number of services | count |
|`hadoop_admin_servicecountatlas` | Number of Atlas services | count |
|`hadoop_admin_servicecounthbase` | Number of HBase services | count |
|`hadoop_admin_servicecounthdfs` | Number of HDFS services | count |
|`hadoop_admin_servicecounthive` | Number of Hive services | count |
|`hadoop_admin_servicecountkafka` | Number of Kafka services | count |
|`hadoop_admin_servicecountkafka_connect` | Number of Kafka Connect services | count |
|`hadoop_admin_servicecountkms` | Number of KMS services | count |
|`hadoop_admin_servicecountknox` | Number of Knox services | count |
|`hadoop_admin_servicecountkudu` | Number of Kudu services | count |
|`hadoop_admin_servicecountsolr` | Number of Solr services | count |
|`hadoop_admin_servicecounttag` | Number of services with specific tags | count |
|`hadoop_admin_servicecountyarn` | Number of services using ARN | count |
|`hadoop_admin_sink_jsonavgtime` | Average time for JSON sink operations | ms |
|`hadoop_admin_sink_jsondropped` | Number of messages dropped by JSON sink | count |
|`hadoop_admin_sink_jsonnumops` | Number of JSON sink operations | count |
|`hadoop_admin_sink_jsonqsize` | Queue size of JSON sink | count |
|`hadoop_admin_sink_prometheusavgtime` | Average time for Prometheus sink operations | count |
|`hadoop_admin_sink_prometheusdropped` | Number of messages dropped by Prometheus sink | count |
|`hadoop_admin_sink_prometheusnumops` | Number of Prometheus sink operations | count |
|`hadoop_admin_sink_prometheusqsize` | Queue size of Prometheus sink | count |
|`hadoop_admin_snapshotavgtime` | Average time for snapshot operations | count |
|`hadoop_admin_snapshotnumops` | Number of snapshot operations | count |
|`hadoop_admin_systemloadavg` | System average load | count |
|`hadoop_admin_threadsblocked` | Number of blocked threads | count |
|`hadoop_admin_threadsbusy` | Number of busy threads | count |
|`hadoop_admin_threadsremaining` | Number of remaining threads | count |
|`hadoop_admin_threadswaiting` | Number of waiting threads | count |
|`hadoop_admin_usercount` | Total number of users | count |
|`hadoop_admin_usercountsysadmin` | Number of system administrator users | count |
|`hadoop_admin_usercountuser` | Number of regular users | count |

Note: The unit "count" refers to a numerical count or occurrence, and "ms" refers to milliseconds.
