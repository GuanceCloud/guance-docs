---
title: 'HBase Master'
summary: 'Collect HBase Master Metrics Information'
__int_icon: 'icon/hbase'
dashboard:
  - desc: 'Built-in View of HBase Master'
    path: 'dashboard/en/hbase_master'
---

Collect HBase Master Metrics Information

## Configuration {#config}

### 1. HBase Master Configuration

#### 1.1 Download jmx-exporter

Download URL: `https://github.com/prometheus/jmx_exporter`

#### 1.2 Download JMX Script

Download URL: `https://github.com/lrwh/jmx-exporter/blob/main/hbase.yaml`

#### 1.3 Adjust HBase Master Startup Parameters

Add the following to the HBase Master startup parameters:

> {JAVA_GC_ARGS} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:9406:/opt/guance/jmx/hbase.yaml

#### 1.4 Restart HBase

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure Collector

The jmx-exporter can directly expose a `metrics` URL, so you can use the [Prometheus collector](./prom.md) for collection.

Navigate to the `conf.d/prom` directory under the [DataKit installation directory](./datakit_dir.md), and copy `prom.conf.sample` to `master.conf`.

> `cp prom.conf.sample master.conf`

Adjust the content of `master.conf` as follows:

```toml
urls = ["http://localhost:9406/metrics"]
source = "hbase-master"
[inputs.prom.tags]
  component = "hbase-master" 
interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations should be adjusted as needed*</font>, parameter adjustment instructions:
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD004 -->
- urls: The URL for the `jmx-exporter` metrics, fill in the exposed metrics URL for the corresponding component.
- source: Alias for the collector, it is recommended to differentiate.
- keep_exist_metric_name: Keep the metric name unchanged.
- interval: Collection interval.
- inputs.prom.tags: Add additional tags.
<!-- markdownlint-enable -->

### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Hadoop Mearsurement Set

HBase Master metrics are located under the Hadoop Mearsurement set. This section primarily introduces relevant metrics for HBase Master.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`hadoop_hbase_appendcount` | Count of append operations | count |
|`hadoop_hbase_appendsize_25th_percentile` | 25th percentile value of append operation size | Byte |
|`hadoop_hbase_appendsize_75th_percentile` | 75th percentile value of append operation size | Byte |
|`hadoop_hbase_appendsize_90th_percentile` | 90th percentile value of append operation size | Byte |
|`hadoop_hbase_appendsize_95th_percentile` | 95th percentile value of append operation size | Byte |
|`hadoop_hbase_appendsize_98th_percentile` | 98th percentile value of append operation size | Byte |
|`hadoop_hbase_appendsize_99_9th_percentile` | 99.9th percentile value of append operation size | Byte |
|`hadoop_hbase_appendsize_99th_percentile` | 99th percentile value of append operation size | Byte |
|`hadoop_hbase_appendsize_max` | Maximum size of append operations | Byte |
|`hadoop_hbase_appendsize_mean` | Average size of append operations | Byte |
|`hadoop_hbase_appendsize_median` | Median size of append operations | Byte |
|`hadoop_hbase_appendsize_min` | Minimum size of append operations | Byte |
|`hadoop_hbase_appendsize_num_ops` | Number of append operations | count |
|`hadoop_hbase_assignfailedcount` | Count of assignment failures | count |
|`hadoop_hbase_assignsubmittedcount` | Count of submitted assignments | count |
|`hadoop_hbase_authenticationfailures` | Number of authentication failures | count |
|`hadoop_hbase_authenticationsuccesses` | Number of successful authentications | count |
|`hadoop_hbase_authorizationfailures` | Number of authorization failures | count |
|`hadoop_hbase_authorizationsuccesses` | Number of successful authorizations | count |
|`hadoop_hbase_averageload` | Average load | count |
|`hadoop_hbase_balancercluster_25th_percentile` | 25th percentile value of cluster balancing operations | ms |
|`hadoop_hbase_balancercluster_75th_percentile` | 75th percentile value of cluster balancing operations | ms |
|`hadoop_hbase_balancercluster_90th_percentile` | 90th percentile value of cluster balancing operations | ms |
|`hadoop_hbase_balancercluster_95th_percentile` | 95th percentile value of cluster balancing operations | ms |
|`hadoop_hbase_balancercluster_98th_percentile` | 98th percentile value of cluster balancing operations | ms |
|`hadoop_hbase_balancercluster_99_9th_percentile` | 99.9th percentile value of cluster balancing operations | ms |
|`hadoop_hbase_balancercluster_99th_percentile` | 99th percentile value of cluster balancing operations | ms |
|`hadoop_hbase_balancercluster_max` | Maximum value of cluster balancing operations | ms |
|`hadoop_hbase_balancercluster_mean` | Average value of cluster balancing operations | ms |
|`hadoop_hbase_balancercluster_median` | Median value of cluster balancing operations | ms |
|`hadoop_hbase_balancercluster_min` | Minimum value of cluster balancing operations | ms |
|`hadoop_hbase_balancercluster_num_ops` | Number of cluster balancing operations | ms |
|`hadoop_hbase_closefailedcount` | Count of close failures | count |
|`hadoop_hbase_closesubmittedcount` | Count of submitted closes | count |
|`hadoop_hbase_closetime_25th_percentile` | 25th percentile value of close operation time | ms |
|`hadoop_hbase_closetime_75th_percentile` | 75th percentile value of close operation time | ms |
|`hadoop_hbase_closetime_90th_percentile` | 90th percentile value of close operation time | ms |
|`hadoop_hbase_closetime_95th_percentile` | 95th percentile value of close operation time | ms |
|`hadoop_hbase_closetime_98th_percentile` | 98th percentile value of close operation time | ms |
|`hadoop_hbase_closetime_99_9th_percentile` | 99.9th percentile value of close operation time | ms |
|`hadoop_hbase_closetime_max` | Maximum time of close operations | ms |
|`hadoop_hbase_closetime_mean` | Average time of close operations | ms |
|`hadoop_hbase_closetime_median` | Median time of close operations | ms |
|`hadoop_hbase_closetime_min` | Minimum time of close operations | ms |
|`hadoop_hbase_closetime_num_ops` | Number of close operations | count |
|`hadoop_hbase_clusterrequests` | Number of cluster requests | count |
|`hadoop_hbase_deadserveropenregions` | Number of open regions on dead servers | count |
|`hadoop_hbase_droppedpuball` | Number of dropped PubAll | count |
|`hadoop_hbase_errorrollrequest` | Number of error rolling requests | count |
|`hadoop_hbase_exceptions` | Total number of exceptions | count |
|`hadoop_hbase_exceptions_callqueuetoobig` | Number of exceptions due to call queue being too large | count |
|`hadoop_hbase_exceptions_failedsanitycheckexception` | Number of failed sanity check exceptions | count |
|`hadoop_hbase_exceptions_multiresponsetoolarge` | Number of multi-response too large exceptions | count |
|`hadoop_hbase_exceptions_notservingregionexception` | Number of region not serving exceptions | count |
|`hadoop_hbase_exceptions_otherexceptions` | Number of other exceptions | count |
|`hadoop_hbase_exceptions_outoforderscannernextexception` | Number of scanner next out-of-order exceptions | count |
|`hadoop_hbase_exceptions_quotaexceeded` | Number of quota exceeded exceptions | count |
|`hadoop_hbase_exceptions_regionmovedexception` | Number of region moved exceptions | count |
|`hadoop_hbase_exceptions_regiontoobusyexception` | Number of region too busy exceptions | count |
|`hadoop_hbase_exceptions_requesttoobig` | Number of request too big exceptions | count |
|`hadoop_hbase_exceptions_rpcthrottling` | Number of RPC throttling exceptions | count |
|`hadoop_hbase_exceptions_scannerresetexception` | Number of scanner reset exceptions | count |
|`hadoop_hbase_exceptions_unknownscannerexception` | Number of unknown scanner exceptions | count |
|`hadoop_hbase_fschecksumfailurecount` | Count of filesystem checksum failures | count |
|`hadoop_hbase_fspreadtime_25th_percentile` | 25th percentile value of filesystem propagation time | ms |
|`hadoop_hbase_fspreadtime_75th_percentile` | 75th percentile value of filesystem propagation time | ms |
|`hadoop_hbase_fspreadtime_90th_percentile` | 90th percentile value of filesystem propagation time | ms |
|`hadoop_hbase_fspreadtime_95th_percentile` | 95th percentile value of filesystem propagation time | ms |
|`hadoop_hbase_fspreadtime_98th_percentile` | 98th percentile value of filesystem propagation time | ms |
|`hadoop_hbase_fspreadtime_99_9th_percentile` | 99.9th percentile value of filesystem propagation time | ms |
|`hadoop_hbase_fspreadtime_99th_percentile` | 99th percentile value of filesystem propagation time | ms |
|`hadoop_hbase_fspreadtime_max` | Maximum time of filesystem propagation | ms |
|`hadoop_hbase_fspreadtime_mean` | Average time of filesystem propagation | ms |
|`hadoop_hbase_fspreadtime_median` | Median time of filesystem propagation | ms |
|`hadoop_hbase_fspreadtime_min` | Minimum time of filesystem propagation | ms |
|`hadoop_hbase_fspreadtime_num_ops` | Number of filesystem propagation operations | count |
|`hadoop_hbase_fsreadtime_25th_percentile` | 25th percentile value of filesystem read time | ms |
|`hadoop_hbase_fsreadtime_75th_percentile` | 75th percentile value of filesystem read time | ms |
|`hadoop_hbase_fsreadtime_90th_percentile` | 90th percentile value of filesystem read time | ms |
|`hadoop_hbase_fsreadtime_95th_percentile` | 95th percentile value of filesystem read time | ms |
|`hadoop_hbase_fsreadtime_98th_percentile` | 98th percentile value of filesystem read time | ms |
|`hadoop_hbase_fsreadtime_99_9th_percentile` | 99.9th percentile value of filesystem read time | ms |
|`hadoop_hbase_fsreadtime_99th_percentile` | 99th percentile value of filesystem read time | ms |
|`hadoop_hbase_fsreadtime_max` | Maximum time of filesystem read | ms |
|`hadoop_hbase_fsreadtime_mean` | Average time of filesystem read | ms |
|`hadoop_hbase_fsreadtime_median` | Median time of filesystem read | ms |
|`hadoop_hbase_fsreadtime_min` | Minimum time of filesystem read | ms |
|`hadoop_hbase_fspreadtime_min` | Number of filesystem read operations | ms |
|`hadoop_hbase_fswritetime_25th_percentile` | 25th percentile value of filesystem write time | ms |
|`hadoop_hbase_fswritetime_75th_percentile` | 75th percentile value of filesystem write time | ms |
|`hadoop_hbase_fswritetime_90th_percentile` | 90th percentile value of filesystem write time | ms |
|`hadoop_hbase_fswritetime_95th_percentile` | 95th percentile value of filesystem write time | ms |
|`hadoop_hbase_fswritetime_98th_percentile` | 98th percentile value of filesystem write time | ms |
|`hadoop_hbase_fswritetime_99_9th_percentile` | 99.9th percentile value of filesystem write time | ms |
|`hadoop_hbase_fswritetime_99th_percentile` | 99th percentile value of filesystem write time | ms |
|`hadoop_hbase_fswritetime_max` | Maximum time of filesystem write | ms |
|`hadoop_hbase_fswritetime_mean` | Average time of filesystem write | ms |
|`hadoop_hbase_fswritetime_median` | Median time of filesystem write | ms |

Note: Some metrics descriptions were corrected for clarity and consistency.