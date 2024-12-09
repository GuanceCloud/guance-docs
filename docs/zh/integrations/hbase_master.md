---
title     : 'HBase Master'
summary   : '采集 HBase Master 指标信息'
__int_icon: 'icon/hbase'
dashboard :
  - desc  : 'HBase Master 内置视图'
    path  : 'dashboard/zh/hbase_master'
---

采集 HBase Master 指标信息

## 配置 {#config}

### 1.HBase Master 配置

#### 1.1 下载 jmx-exporter

下载地址：`https://github.com/prometheus/jmx_exporter`

#### 1.2 下载 jmx 脚本

下载地址：`https://github.com/lrwh/jmx-exporter/blob/main/hbase.yaml`

#### 1.3 HBase Master 启动参数调整

在 HBase Master 的启动参数添加

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:9406:/opt/guance/jmx/hbase.yaml

#### 1.4 重启 HBase

### 2. DataKit 采集器配置

#### 2.1 [安装 DataKit](../datakit/datakit-install.md)

#### 2.2 配置采集器

通过 jmx-exporter 可以直接暴露 `metrics` url，所以可以直接通过[prom](./prom.md)采集器进行采集。

进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/prom` ，复制 `prom.conf.sample` 为 `master.conf`。

> `cp prom.conf.sample master.conf`

调整`master.conf`内容如下：

```toml
  urls = ["http://localhost:9406/metrics"]
  source ="hbase-master"
  [inputs.prom.tags]
    component = "hbase-master" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*其他配置按需调整*</font>，调整参数说明 ：
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD004 -->
- urls：`jmx-exporter`指标地址，这里填写对应组件暴露出来的指标 url
- source：采集器别名，建议做区分
- keep_exist_metric_name: 保持指标名称
- interval：采集间隔
- inputs.prom.tags: 新增额外的 tag
<!-- markdownlint-enable -->

### 3. 重启 DataKit

[重启Datakit](../datakit/datakit-service-how-to.md#manage-service)

## 指标 {#metric}

### Hadoop 指标集

HBase Master 指标位于 Hadoop 指标集下，这里主要介绍 Hbase Master 相关指标说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`hadoop_hbase_appendcount` |`追加操作的计数` | count |
|`hadoop_hbase_appendsize_25th_percentile` |`追加操作大小的第25百分位值` | Byte |
|`hadoop_hbase_appendsize_75th_percentile` |`追加操作大小的第75百分位值` | Byte |
|`hadoop_hbase_appendsize_90th_percentile` |`追加操作大小的第90百分位值` | Byte |
|`hadoop_hbase_appendsize_95th_percentile` |`追加操作大小的第95百分位值` | Byte |
|`hadoop_hbase_appendsize_98th_percentile` |`追加操作大小的第98百分位值` | Byte |
|`hadoop_hbase_appendsize_99_9th_percentile` |`追加操作大小的第99.9百分位值` | Byte |
|`hadoop_hbase_appendsize_99th_percentile` |`追加操作大小的第99百分位值` | Byte |
|`hadoop_hbase_appendsize_max` |`追加操作的最大大小` | Byte |
|`hadoop_hbase_appendsize_mean` |`追加操作的平均大小` | Byte |
|`hadoop_hbase_appendsize_median` |`追加操作的中位数大小` | Byte |
|`hadoop_hbase_appendsize_min` |`追加操作的最小大小` | Byte |
|`hadoop_hbase_appendsize_num_ops` |`追加操作的数量` | count |
|`hadoop_hbase_assignfailedcount` |`分配失败的计数` | count |
|`hadoop_hbase_assignsubmittedcount` |`提交分配的计数` | count |
|`hadoop_hbase_authenticationfailures` |`认证失败的次数` | count |
|`hadoop_hbase_authenticationsuccesses` |`认证成功的次数` | count |
|`hadoop_hbase_authorizationfailures` |`授权失败的次数` | count |
|`hadoop_hbase_authorizationsuccesses` |`授权成功的次数` | count |
|`hadoop_hbase_averageload` |`平均负载` | count |
|`hadoop_hbase_balancercluster_25th_percentile` |`集群平衡操作的第25百分位值` | ms |
|`hadoop_hbase_balancercluster_75th_percentile` |`集群平衡操作的第75百分位值` | ms |
|`hadoop_hbase_balancercluster_90th_percentile` |`集群平衡操作的第90百分位值` | ms |
|`hadoop_hbase_balancercluster_95th_percentile` |`集群平衡操作的第95百分位值` | ms |
|`hadoop_hbase_balancercluster_98th_percentile` |`集群平衡操作的第98百分位值` | ms |
|`hadoop_hbase_balancercluster_99_9th_percentile` |`集群平衡操作的第99.9百分位值` | ms |
|`hadoop_hbase_balancercluster_99th_percentile` |`集群平衡操作的第99百分位值` | ms |
|`hadoop_hbase_balancercluster_max` |`集群平衡操作的最大值` | ms |
|`hadoop_hbase_balancercluster_mean` |`集群平衡操作的平均值` | ms |
|`hadoop_hbase_balancercluster_median` |`集群平衡操作的中位数` | ms |
|`hadoop_hbase_balancercluster_min` |`集群平衡操作的最小值` | ms |
|`hadoop_hbase_balancercluster_num_ops` |`集群平衡操作的数量` | ms |
|`hadoop_hbase_closefailedcount` |`关闭失败的计数` | count |
|`hadoop_hbase_closesubmittedcount` |`提交关闭的计数` | count |
|`hadoop_hbase_closetime_25th_percentile` |`关闭操作时间的第25百分位值` | ms |
|`hadoop_hbase_closetime_75th_percentile` |`关闭操作时间的第75百分位值` | ms |
|`hadoop_hbase_closetime_90th_percentile` |`关闭操作时间的第90百分位值` | ms |
|`hadoop_hbase_closetime_95th_percentile` |`关闭操作时间的第95百分位值` | ms |
|`hadoop_hbase_closetime_98th_percentile` |`关闭操作时间的第98百分位值` | ms |
|`hadoop_hbase_closetime_99_9th_percentile` |`关闭操作时间的第99.9百分位值` | ms |
|`hadoop_hbase_closetime_max` |`关闭操作的最大时间` | ms |
|`hadoop_hbase_closetime_mean` |`关闭操作的平均时间` | ms |
|`hadoop_hbase_closetime_median` |`关闭操作的中位数时间` | ms |
|`hadoop_hbase_closetime_min` |`关闭操作的最小时间` | ms |
|`hadoop_hbase_closetime_num_ops` |`关闭操作的数量` | count |
|`hadoop_hbase_clusterrequests` |`集群请求的数量` | count |
|`hadoop_hbase_deadserveropenregions` |`死亡服务器上打开区域的数量` | count |
|`hadoop_hbase_droppedpuball` |`丢弃的PubAll数量` | count |
|`hadoop_hbase_errorrollrequest` |`错误滚动请求的数量` | count |
|`hadoop_hbase_exceptions` |`异常的总数` | count |
|`hadoop_hbase_exceptions_callqueuetoobig` |`由于调用队列过大导致的异常数量` | count |
|`hadoop_hbase_exceptions_failedsanitycheckexception` |`失败的完整性检查异常数量` | count |
|`hadoop_hbase_exceptions_multiresponsetoolarge` |`多响应过大异常数量` | count |
|`hadoop_hbase_exceptions_notservingregionexception` |`区域不提供服务异常数量` | count |
|`hadoop_hbase_exceptions_otherexceptions` |`其他异常数量` | count |
|`hadoop_hbase_exceptions_outoforderscannernextexception` |`扫描器下一个元素顺序错误异常数量` | count |
|`hadoop_hbase_exceptions_quotaexceeded` |`配额超出异常数量` | count |
|`hadoop_hbase_exceptions_regionmovedexception` |`区域移动异常的数量` | count |
|`hadoop_hbase_exceptions_regiontoobusyexception` |`区域太忙异常的数量` | count |
|`hadoop_hbase_exceptions_requesttoobig` |`请求太大异常的数量` | count |
|`hadoop_hbase_exceptions_rpcthrottling` |`RPC节流异常的数量` | count |
|`hadoop_hbase_exceptions_scannerresetexception` |`扫描器重置异常的数量` | count |
|`hadoop_hbase_exceptions_unknownscannerexception` |`未知扫描器异常的数量` | count |
|`hadoop_hbase_fschecksumfailurecount` |`文件系统校验和失败的计数` | count |
|`hadoop_hbase_fspreadtime_25th_percentile` |`文件系统传播时间的第25百分位值` | ms |
|`hadoop_hbase_fspreadtime_75th_percentile` |`文件系统传播时间的第75百分位值` | ms |
|`hadoop_hbase_fspreadtime_90th_percentile` |`文件系统传播时间的第90百分位值` | ms |
|`hadoop_hbase_fspreadtime_95th_percentile` |`文件系统传播时间的第95百分位值` | ms |
|`hadoop_hbase_fspreadtime_98th_percentile` |`文件系统传播时间的第98百分位值` | ms |
|`hadoop_hbase_fspreadtime_99_9th_percentile` |`文件系统传播时间的第99.9百分位值` | ms |
|`hadoop_hbase_fspreadtime_99th_percentile` |`文件系统传播时间的第99百分位值` | ms |
|`hadoop_hbase_fspreadtime_max` |`文件系统传播的最大时间` | ms |
|`hadoop_hbase_fspreadtime_mean` |`文件系统传播的平均时间` | ms |
|`hadoop_hbase_fspreadtime_median` |`文件系统传播的中位数时间` | ms |
|`hadoop_hbase_fspreadtime_min` |`文件系统传播的最小时间` | ms |
|`hadoop_hbase_fspreadtime_num_ops` |`文件系统传播操作的数量` | count |
|`hadoop_hbase_fsreadtime_25th_percentile` |`文件系统读取时间的第25百分位` | ms |
|`hadoop_hbase_fsreadtime_75th_percentile` |`文件系统读取时间的第75百分位` | ms |
|`hadoop_hbase_fsreadtime_90th_percentile` |`文件系统读取时间的第90百分位` | ms |
|`hadoop_hbase_fsreadtime_95th_percentile` |`文件系统读取时间的第95百分位` | ms |
|`hadoop_hbase_fsreadtime_98th_percentile` |`文件系统读取时间的第98百分位` | ms |
|`hadoop_hbase_fsreadtime_99_9th_percentile` |`文件系统读取时间的第99.9百分位` | ms |
|`hadoop_hbase_fsreadtime_99th_percentile` |`文件系统读取时间的第99百分位` | ms |
|`hadoop_hbase_fsreadtime_max` |`文件系统读取的最大时间` | ms |
|`hadoop_hbase_fsreadtime_mean` |`文件系统读取的平均时间` | ms |
|`hadoop_hbase_fsreadtime_median` |`文件系统读取的中位数时间` | ms |
|`hadoop_hbase_fsreadtime_min` |`文件系统读取的最小时间` | ms |
|`hadoop_hbase_fspreadtime_min` |`文件系统读取操作的数量` | ms |
|`hadoop_hbase_fswritetime_25th_percentile` |`文件系统写入时间的第25百分位值` | ms |
|`hadoop_hbase_fswritetime_75th_percentile` |`文件系统写入时间的第75百分位值` | ms |
|`hadoop_hbase_fswritetime_90th_percentile` |`文件系统写入时间的第90百分位值` | ms |
|`hadoop_hbase_fswritetime_95th_percentile` |`文件系统写入时间的第95百分位值` | ms |
|`hadoop_hbase_fswritetime_98th_percentile` |`文件系统写入时间的第98百分位值` | ms |
|`hadoop_hbase_fswritetime_99_9th_percentile` |`文件系统写入时间的第99.9百分位值` | ms |
|`hadoop_hbase_fswritetime_99th_percentile` |`文件系统写入时间的第99百分位值` | ms |
|`hadoop_hbase_fswritetime_max` |`文件系统写入的最大时间` | ms |
|`hadoop_hbase_fswritetime_mean` |`文件系统写入的平均时间` | ms |
|`hadoop_hbase_fswritetime_median` |`文件系统写入的中位数时间` | ms |
