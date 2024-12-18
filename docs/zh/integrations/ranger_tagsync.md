---
title     : 'Ranger Tagsync'
summary   : '采集 Ranger Tagsync 指标信息'
__int_icon: 'icon/ranger'
dashboard :
  - desc  : 'Ranger Tagsync 内置视图'
    path  : 'dashboard/zh/ranger_tagsync'
---

采集 Ranger Tagsync 指标信息

## 配置 {#config}

### 1.Ranger Tagsync 配置

#### 1.1 下载 jmx-exporter

下载地址：`https://github.com/prometheus/jmx_exporter`

#### 1.2 下载 jmx 脚本

下载地址：`https://github.com/lrwh/jmx-exporter/blob/main/common.yml`

#### 1.3 Ranger Tagsync 启动参数调整

在 Ranger Tagsync 的启动参数添加

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17144:/opt/guance/jmx/common.yml

#### 1.4 重启 Ranger Tagsync

### 2. DataKit 采集器配置

#### 2.1 [安装 DataKit](../datakit/datakit-install.md)

#### 2.2 配置采集器

通过 jmx-exporter 可以直接暴露 `metrics` url，所以可以直接通过[prom](./prom.md)采集器进行采集。

进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/prom` ，复制 `prom.conf.sample` 为 `ranger-tagsync.conf`。

> `cp prom.conf.sample ranger-tagsync.conf`

调整`ranger_tagsync.conf`内容如下：

```toml
  urls = ["http://localhost:17144/metrics"]
  source ="ranger-tagsync"
  [inputs.prom.tags]
    component = "ranger-tagsync" 
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

Ranger Tagsync 指标位于 Hadoop 指标集下，这里主要介绍 Ranger Tagsync 相关指标说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`hadoop_tagsync_countevents` |`发生的事件总数` | count |
|`hadoop_tagsync_counteventstime` |`处理这些事件所花费的总时间` | ms |
|`hadoop_tagsync_countuploads` |`上传操作的总数` | count |
|`hadoop_tagsync_countuploadstime` |`处理上传操作所花费的总时间` | count |
|`hadoop_tagsync_droppedpuball` |`丢失的发布（publish）事件总数` | count |
|`hadoop_tagsync_gccounttotal` |`垃圾收集（GC）的总次数` | count |
|`hadoop_tagsync_gctimemax` |`垃圾收集（GC）的最大耗时` | ms |
|`hadoop_tagsync_gctimetotal` |`垃圾收集（GC）的总耗时` | count |
|`hadoop_tagsync_getgroupsavgtime` |`获取用户组的平均时间` | ms |
|`hadoop_tagsync_getgroupsnumops` |`获取用户组的操作次数` | count |
|`hadoop_tagsync_loginfailureavgtime` |`登录失败的平均耗时` | ms |
|`hadoop_tagsync_loginfailurenumops` |`登录失败的次数` | count |
|`hadoop_tagsync_loginsuccessavgtime` |`登录成功平均耗时` | ms |
|`hadoop_tagsync_loginsuccessnumops` |`登录成功的次数` | count |
|`hadoop_tagsync_memorycurrent` |`当前内存使用量` | count |
|`hadoop_tagsync_memorymax` |`最大内存使用量` | count |
|`hadoop_tagsync_numactivesinks` |`活跃的接收器（sinks）数量` | count |
|`hadoop_tagsync_numactivesources` |`活跃的数据源（sources）数量` | count |
|`hadoop_tagsync_numallsinks` |`所有数据源（sources）的总数` | count |
|`hadoop_tagsync_processorsavailable` |`可用的处理器数量` | count |
|`hadoop_tagsync_publishavgtime` |`发布操作的平均耗时` | count |
|`hadoop_tagsync_publishnumops` |`发布操作的次数` | count |
|`hadoop_tagsync_renewalfailures` |`更新失败的次数` | count |
|`hadoop_tagsync_renewalfailurestotal` |`总的更新失败次数` | count |
|`hadoop_tagsync_sink_jsonavgtime` |`JSON接收器的平均耗时` | count |
|`hadoop_tagsync_sink_jsondropped` |`JSON接收器丢弃的消息数` | count |
|`hadoop_tagsync_sink_jsonnumops` |`JSON接收器操作次数` | count |
|`hadoop_tagsync_sink_jsonqsize` |`JSON接收器的队列大小` | count |
|`hadoop_tagsync_sink_prometheusavgtime` |`Prometheus接收器的平均耗时` | count |
|`hadoop_tagsync_sink_prometheusdropped` |`Prometheus接收器丢弃的消息数` | count |
|`hadoop_tagsync_sink_prometheusnumops` |`Prometheus接收器操作次数` | count |
|`hadoop_tagsync_sink_prometheusqsize` |`Prometheus接收器的队列大小` | count |
|`hadoop_tagsync_snapshotavgtime` |`快照操作的平均耗时` | count |
|`hadoop_tagsync_snapshotnumops` |`快照操作次数` | count |
|`hadoop_tagsync_systemloadavg` |`系统的平均负载` | count |
|`hadoop_tagsync_threadsblocked` |`被阻塞的线程数` | count |
|`hadoop_tagsync_threadsbusy` |`忙碌的线程数` | count |
|`hadoop_tagsync_threadsremaining` |`剩余的线程数` | count |
|`hadoop_tagsync_threadswaiting` |`等待的线程数` | count |
