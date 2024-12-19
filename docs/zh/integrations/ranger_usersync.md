---
title     : 'Ranger Usersync'
summary   : '采集 Ranger Usersync 指标信息'
__int_icon: 'icon/ranger'
dashboard :
  - desc  : 'Ranger Usersync 内置视图'
    path  : 'dashboard/zh/ranger_usersync'
---

采集 Ranger Usersync 指标信息

## 配置 {#config}

### 1.Ranger Usersync 配置

#### 1.1 下载 jmx-exporter

下载地址：`https://github.com/prometheus/jmx_exporter`

#### 1.2 下载 jmx 脚本

下载地址：`https://github.com/lrwh/jmx-exporter/blob/main/common.yml`

#### 1.3 Ranger Usersync 启动参数调整

在 Ranger Usersync 的启动参数添加

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17145:/opt/guance/jmx/common.yml

#### 1.4 重启 Ranger Usersync

### 2. DataKit 采集器配置

#### 2.1 [安装 DataKit](../datakit/datakit-install.md)

#### 2.2 配置采集器

通过 jmx-exporter 可以直接暴露 `metrics` url，所以可以直接通过[prom](./prom.md)采集器进行采集。

进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/prom` ，复制 `prom.conf.sample` 为 `ranger-usersync.conf`。

> `cp prom.conf.sample ranger-usersync.conf`

调整`ranger_usersync.conf`内容如下：

```toml
  urls = ["http://localhost:17145/metrics"]
  source ="ranger-usersync"
  [inputs.prom.tags]
    component = "ranger-usersync" 
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

Ranger Usersync 指标位于 Hadoop 指标集下，这里主要介绍 Ranger Usersync 相关指标说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`hadoop_usersync_addgroupcountsuccess` |`成功添加用户组的次数` | count |
|`hadoop_usersync_addusercountsuccess` |`成功添加用户的次数` | count |
|`hadoop_usersync_auditcountsuccess` |`成功执行审计的次数` | count |
|`hadoop_usersync_countgroup` |`用户组的总数` | count |
|`hadoop_usersync_countgroupuser` |`用户组中的用户总数` | count |
|`hadoop_usersync_countuser` |`用户的总数` | count |
|`hadoop_usersync_droppedpuball` |`丢失的发布事件总数` | count |
|`hadoop_usersync_gccounttotal` |`垃圾收集（GC）的总次数` | count |
|`hadoop_usersync_gctimemax` |`垃圾收集（GC）的最大耗时` | count |
|`hadoop_usersync_gctimetotal` |`垃圾收集（GC）的总耗时` | count |
|`hadoop_usersync_getgroupsavgtime` |`获取用户组的平均时间` | count |
|`hadoop_usersync_getgroupsnumops` |`获取用户组的操作次数` | count |
|`hadoop_usersync_groupusercountsuccess` |`成功统计用户组用户数的次数` | count |
|`hadoop_usersync_loginfailureavgtime` |`登录失败的平均耗时` | ms |
|`hadoop_usersync_loginfailurenumops` |`登录失败的次数` | count |
|`hadoop_usersync_loginsuccessavgtime` |`登录成功平均耗时` | ms |
|`hadoop_usersync_loginsuccessnumops` |`登录成功的次数` | count |
|`hadoop_usersync_memorycurrent` |`当前内存使用量` | byte |
|`hadoop_usersync_memorymax` |`最大内存使用量` | byte |
|`hadoop_usersync_numactivesinks` |`活跃的接收器（sinks）数量` | count |
|`hadoop_usersync_numactivesources` |`活跃的数据源（sources）数量` | count |
|`hadoop_usersync_numallsinks` |`所有接收器（sinks）的总数` | count |
|`hadoop_usersync_numallsources` |`所有数据源（sources）的总数` | count |
|`hadoop_usersync_processorsavailable` |`可用的处理器数量` | count |
|`hadoop_usersync_publishavgtime` |`发布操作的平均耗时` | ms |
|`hadoop_usersync_publishnumops` |`发布操作的次数` | count |
|`hadoop_usersync_renewalfailures` |`更新失败的次数` | count |
|`hadoop_usersync_sink_jsonavgtime` |`JSON接收器的平均耗时` | count |
|`hadoop_usersync_sink_jsondropped` |`JSON接收器丢弃的消息数` | count |
|`hadoop_usersync_sink_jsonnumops` |`JSON接收器操作次数` | count |
|`hadoop_usersync_sink_jsonqsize` |`JSON接收器的队列大小` | count |
|`hadoop_usersync_sink_prometheusavgtime` |`Prometheus接收器的平均耗时` | count |
|`hadoop_usersync_sink_prometheusdropped` |`Prometheus接收器丢弃的消息数` | count |
|`hadoop_usersync_sink_prometheusnumops` |`Prometheus接收器操作次数` | count |
|`hadoop_usersync_sink_prometheusqsize` |`Prometheus接收器的队列大小` | count |
|`hadoop_usersync_snapshotavgtime` |`快照操作的平均耗时` | ms |
|`hadoop_usersync_snapshotnumops` |`快照操作次数` | count |
|`hadoop_usersync_systemloadavg` |`系统的平均负载` | count |
|`hadoop_usersync_threadsblocked` |`被阻塞的线程数` | count |
|`hadoop_usersync_threadsremaining` |`剩余的线程数` | count |
|`hadoop_usersync_threadswaiting` |`等待的线程数` | count |
