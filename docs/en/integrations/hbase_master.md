---
title     : 'HBase Master'
summary   : 'Collect HBase Master metric information'
__int_icon: 'icon/hbase'
dashboard :
  - desc  : 'HBase Master Built in Views'
    path  : 'dashboard/en/hbase_master'
---

Collect HBase Master metric information

## Config {#config}

### 1.HBase Master Configuration

#### 1.1 Download jmx-exporter

Download link：`https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx script

Download link：`https://github.com/lrwh/jmx-exporter/blob/main/hbase.yaml`

#### 1.3 HBase Master Start parameter adjustment

Adding startup parameters to HBase Master

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:9406:/opt/guance/jmx/hbase.yaml

#### 1.4 Restart HBase

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure collector

By using jmx exporter, the `metrics` URL can be directly exposed, so it can be collected directly through the [prom](./prom.md) collector.

Go to the `conf.d/prom` directory under the [DataKit installation directory](./datakit-dir.md), and copy `prom.conf.sample` to `master.conf`.

> `cp prom.conf.sample master.conf`

Adjust the content of `master.conf` as follows:

```toml
  urls = ["http://localhost:9406/metrics"]
  source ="hbase-master"
  [inputs.prom.tags]
    component = "hbase-master" 
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

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

### Hadoop Metric Set

The HBase Master metric is located under the Hadoop metric set, and here we mainly introduce the description of HBase Master related metrics

| Metrics | Description |Unit |
|:--------|:-----|:--|
|`hadoop_hbase_appendcount` |`Count of additional operations` | count |
|`hadoop_hbase_appendsize_25th_percentile` |`Add the 25th percentile value of the operation size` | Byte |
|`hadoop_hbase_appendsize_75th_percentile` |`Add the 75th percentile value of the operation size` | Byte |
|`hadoop_hbase_appendsize_90th_percentile` |`Add the 90th percentile value of the operation size` | Byte |
|`hadoop_hbase_appendsize_95th_percentile` |`Add the 95th percentile value of the operation size` | Byte |
|`hadoop_hbase_appendsize_98th_percentile` |`Add the 98th percentile value of the operation size` | Byte |
|`hadoop_hbase_appendsize_99_9th_percentile` |`Add the 99.9th percentile value of the operation size` | Byte |
|`hadoop_hbase_appendsize_99th_percentile` |`Add the 99th percentile value of the operation size` | Byte |
|`hadoop_hbase_appendsize_max` |`Maximum size for append operation` | Byte |
|`hadoop_hbase_appendsize_mean` |`The average size of the append operation` | Byte |
|`hadoop_hbase_appendsize_median` |`Median size of append operation` | Byte |
|`hadoop_hbase_appendsize_min` |`The minimum size for adding operations` | Byte |
|`hadoop_hbase_appendsize_num_ops` |`Number of additional operations` | count |
|`hadoop_hbase_assignfailedcount` |`Count of allocation failures` | count |
|`hadoop_hbase_assignsubmittedcount` |`Submit the allocated count` | count |
|`hadoop_hbase_authenticationfailures` |`Number of authentication failures` | count |
|`hadoop_hbase_authenticationsuccesses` |`Number of successful authentication attempts` | count |
|`hadoop_hbase_authorizationfailures` |`Number of authorization failures` | count |
|`hadoop_hbase_authorizationsuccesses` |`Number of successful authorizations` | count |
|`hadoop_hbase_averageload` |`Average load` | count |
|`hadoop_hbase_balancercluster_25th_percentile` |`25th percentile value of cluster balancing operation` | ms |
|`hadoop_hbase_balancercluster_75th_percentile` |`75th percentile value of cluster balancing operation` | ms |
|`hadoop_hbase_balancercluster_90th_percentile` |`90th percentile value of cluster balancing operation` | ms |
|`hadoop_hbase_balancercluster_95th_percentile` |`95th percentile value of cluster balancing operation` | ms |
|`hadoop_hbase_balancercluster_98th_percentile` |`98th percentile value of cluster balancing operation` | ms |
|`hadoop_hbase_balancercluster_99_9th_percentile` |`99.9th percentile value of cluster balancing operation` | ms |
|`hadoop_hbase_balancercluster_99th_percentile` |`99th percentile value of cluster balancing operation` | ms |
|`hadoop_hbase_balancercluster_max` |`Maximum value for cluster balancing operation` | ms |
|`hadoop_hbase_balancercluster_mean` |`The average value of cluster balancing operation` | ms |
|`hadoop_hbase_balancercluster_median` |`Median of cluster balancing operations` | ms |
|`hadoop_hbase_balancercluster_min` |`Minimum value for cluster balancing operation` | ms |
|`hadoop_hbase_balancercluster_num_ops` |`The number of cluster balancing operations` | ms |
|`hadoop_hbase_closefailedcount` |`Close the failed count` | count |
|`hadoop_hbase_closesubmittedcount` |`Submit closed count` | count |
|`hadoop_hbase_closetime_25th_percentile` |`25th percentile value of closing operation time` | ms |
|`hadoop_hbase_closetime_75th_percentile` |`75th percentile value of closing operation time` | ms |
|`hadoop_hbase_closetime_90th_percentile` |`90th percentile value of closing operation time` | ms |
|`hadoop_hbase_closetime_95th_percentile` |`95th percentile value of closing operation time` | ms |
|`hadoop_hbase_closetime_98th_percentile` |`98th percentile value of closing operation time` | ms |
|`hadoop_hbase_closetime_99_9th_percentile` |`99.9th percentile value of closing operation time.9百分位值` | ms |
|`hadoop_hbase_closetime_max` |`Maximum time for closing operation` | ms |
|`hadoop_hbase_closetime_mean` |`The average time for closing operations` | ms |
|`hadoop_hbase_closetime_median` |`Median time to close operation` | ms |
|`hadoop_hbase_closetime_min` |`Minimum time to close operation` | ms |
|`hadoop_hbase_closetime_num_ops` |`The number of closed operations` | count |
|`hadoop_hbase_clusterrequests` |`The number of cluster requests` | count |
|`hadoop_hbase_deadserveropenregions` |`The number of open areas on the death server` | count |
|`hadoop_hbase_droppedpuball` |`Number of discarded PubAll` | count |
|`hadoop_hbase_errorrollrequest` |`The number of incorrect scrolling requests` | count |
|`hadoop_hbase_exceptions` |`Total number of exceptions` | count |
|`hadoop_hbase_exceptions_callqueuetoobig` |`Number of exceptions caused by a large call queue` | count |
|`hadoop_hbase_exceptions_failedsanitycheckexception` |`Number of failed integrity check exceptions` | count |
|`hadoop_hbase_exceptions_multiresponsetoolarge` |`Excessive response to a large number of anomalies` | count |
|`hadoop_hbase_exceptions_notservingregionexception` |`Number of abnormal services not provided in the region` | count |
|`hadoop_hbase_exceptions_otherexceptions` |`Other abnormal quantities` | count |
|`hadoop_hbase_exceptions_outoforderscannernextexception` |`Scanner next element order error abnormal quantity` | count |
|`hadoop_hbase_exceptions_quotaexceeded` |`Quota exceeds abnormal quantity` | count |
|`hadoop_hbase_exceptions_regionmovedexception` |`The number of abnormal regional movements` | count |
|`hadoop_hbase_exceptions_regiontoobusyexception` |`The number of abnormally busy regions` | count |
|`hadoop_hbase_exceptions_requesttoobig` |`Request too many exceptions` | count |
|`hadoop_hbase_exceptions_rpcthrottling` |`The number of RPC throttling exceptions` | count |
|`hadoop_hbase_exceptions_scannerresetexception` |`Number of scanner reset exceptions` | count |
|`hadoop_hbase_exceptions_unknownscannerexception` |`Unknown number of scanner anomalies` | count |
|`hadoop_hbase_fschecksumfailurecount` |`Count of file system checksum failures` | count |
|`hadoop_hbase_fspreadtime_25th_percentile` |`25th percentile value of file system propagation time` | ms |
|`hadoop_hbase_fspreadtime_75th_percentile` |`75th percentile value of file system propagation time` | ms |
|`hadoop_hbase_fspreadtime_90th_percentile` |`90th percentile value of file system propagation time` | ms |
|`hadoop_hbase_fspreadtime_95th_percentile` |`95th percentile value of file system propagation time` | ms |
|`hadoop_hbase_fspreadtime_98th_percentile` |`98th percentile value of file system propagation time` | ms |
|`hadoop_hbase_fspreadtime_99_9th_percentile` |`99.9th percentile value of file system propagation time.9百分位值` | ms |
|`hadoop_hbase_fspreadtime_99th_percentile` |`99th percentile value of file system propagation time` | ms |
|`hadoop_hbase_fspreadtime_max` |`Maximum time for file system propagation` | ms |
|`hadoop_hbase_fspreadtime_mean` |`The average time for file system propagation` | ms |
|`hadoop_hbase_fspreadtime_median` |`Median time of file system propagation` | ms |
|`hadoop_hbase_fspreadtime_min` |`Minimum time for file system propagation` | ms |
|`hadoop_hbase_fspreadtime_num_ops` |`The number of file system propagation operations` | count |
|`hadoop_hbase_fsreadtime_25th_percentile` |`25th percentile of file system read time` | ms |
|`hadoop_hbase_fsreadtime_75th_percentile` |`75th percentile of file system read time` | ms |
|`hadoop_hbase_fsreadtime_90th_percentile` |`90th percentile of file system read time` | ms |
|`hadoop_hbase_fsreadtime_95th_percentile` |`95th percentile of file system read time` | ms |
|`hadoop_hbase_fsreadtime_98th_percentile` |`98th percentile of file system read time` | ms |
|`hadoop_hbase_fsreadtime_99_9th_percentile` |`99.9th percentile of file system read time.9百分位` | ms |
|`hadoop_hbase_fsreadtime_99th_percentile` |`99th percentile of file system read time` | ms |
|`hadoop_hbase_fsreadtime_max` |`Maximum time for file system read` | ms |
|`hadoop_hbase_fsreadtime_mean` |`The average time for file system read` | ms |
|`hadoop_hbase_fsreadtime_median` |`Median time for file system read` | ms |
|`hadoop_hbase_fsreadtime_min` |`Minimum time for file system read` | ms |
|`hadoop_hbase_fspreadtime_min` |`The number of file system read operations` | ms |
|`hadoop_hbase_fswritetime_25th_percentile` |`25th percentile value of file system write time` | ms |
|`hadoop_hbase_fswritetime_75th_percentile` |`75th percentile value of file system write time` | ms |
|`hadoop_hbase_fswritetime_90th_percentile` |`90th percentile value of file system write time` | ms |
|`hadoop_hbase_fswritetime_95th_percentile` |`95th percentile value of file system write time` | ms |
|`hadoop_hbase_fswritetime_98th_percentile` |`98th percentile value of file system write time` | ms |
|`hadoop_hbase_fswritetime_99_9th_percentile` |`99.9th percentile value of file system write time.9百分位值` | ms |
|`hadoop_hbase_fswritetime_99th_percentile` |`99th percentile value of file system write time` | ms |
|`hadoop_hbase_fswritetime_max` |`The maximum time for writing to the file system` | ms |
|`hadoop_hbase_fswritetime_mean` |`The average time for writing to the file system` | ms |
|`hadoop_hbase_fswritetime_median` |`Median time of file system writing` | ms |
