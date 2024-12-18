---
title     : 'Ranger Admin'
summary   : '采集 Ranger Admin 指标信息'
__int_icon: 'icon/ranger'
dashboard :
  - desc  : 'Ranger Admin 内置视图'
    path  : 'dashboard/zh/ranger_admin'
---

采集 Ranger Admin 指标信息

## 配置 {#config}

### 1.Ranger Admin 配置

#### 1.1 下载 jmx-exporter

下载地址：`https://github.com/prometheus/jmx_exporter`

#### 1.2 下载 jmx 脚本

下载地址：`https://github.com/lrwh/jmx-exporter/blob/main/common.yml`

#### 1.3 Ranger Admin 启动参数调整

在 Ranger Admin 的启动参数添加

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17143:/opt/guance/jmx/common.yml

#### 1.4 重启 Ranger Admin

### 2. DataKit 采集器配置

#### 2.1 [安装 DataKit](../datakit/datakit-install.md)

#### 2.2 配置采集器

通过 jmx-exporter 可以直接暴露 `metrics` url，所以可以直接通过[prom](./prom.md)采集器进行采集。

进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/prom` ，复制 `prom.conf.sample` 为 `ranger-admin.conf`。

> `cp prom.conf.sample ranger-admin.conf`

调整`ranger_admin.conf`内容如下：

```toml
  urls = ["http://localhost:17143/metrics"]
  source ="ranger-admin"
  [inputs.prom.tags]
    component = "ranger-admin" 
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

Ranger Admin 指标位于 Hadoop 指标集下，这里主要介绍 Ranger Admin 相关指标说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`hadoop_admin_contextenrichercount` |`上下文富化器的数量` | count |
|`hadoop_admin_contextenrichercounttag` |`带有特定标签的上下文富化器的数量` | count |
|`hadoop_admin_denyconditioncount` |`拒绝条件的数量` | count |
|`hadoop_admin_denyconditioncounttag` |`带有特定标签的拒绝条件的数量` | count |
|`hadoop_admin_droppedpuball` |`丢弃的发布操作总数` | count |
|`hadoop_admin_gccounttotal` |`垃圾收集（GC）的总次数` | count |
|`hadoop_admin_gctimemax` |`垃圾收集（GC）的最大耗时` | ms |
|`hadoop_admin_gctimetotal` |`垃圾收集（GC）的总耗时` | ms |
|`hadoop_admin_getgroupsavgtime` |`获取用户组的平均时间` | ms |
|`hadoop_admin_getgroupsnumops` |`获取用户组的操作次数` | count |
|`hadoop_admin_groupcount` |`用户组的数量` | count |
|`hadoop_admin_loginfailureavgtime` |`登录失败的平均耗时` | ms |
|`hadoop_admin_loginfailurenumops` |`登录失败的次数` | count |
|`hadoop_admin_loginsuccessavgtime` |`登录成功平均耗时` | ms |
|`hadoop_admin_loginsuccessnumops` |`登录成功的次数` | count |
|`hadoop_admin_maskingcount` |`数据脱敏的次数` | count |
|`hadoop_admin_memorycurrent` |`当前内存使用量` | count |
|`hadoop_admin_memorymax` |`最大内存使用量` | count |
|`hadoop_admin_numactivesinks` |`活跃的接收器（sinks）数量` | count |
|`hadoop_admin_numactivesources` |`活跃的数据源（sources）数量` | count |
|`hadoop_admin_numallsinks` |`所有接收器（sinks）的总数` | count |
|`hadoop_admin_numallsources` |`所有数据源（sources）的总数` | count |
|`hadoop_admin_processorsavailable` |`可用的处理器数量` | count |
|`hadoop_admin_publishavgtime` |`发布操作的平均耗时` | ms |
|`hadoop_admin_publishnumops` |`发布操作的次数` | count |
|`hadoop_admin_renewalfailures` |`更新失败的次数` | count |
|`hadoop_admin_renewalfailurestotal` |`总的更新失败次数` | count |
|`hadoop_admin_resourceaccesscount` |`资源访问次数` | count |
|`hadoop_admin_resourceaccesscountatlas` |`访问Atlas资源的次数` | count |
|`hadoop_admin_resourceaccesscounthbase` |`访问HBase资源的次数` | count |
|`hadoop_admin_resourceaccesscounthdfs` |`访问HDFS资源的次数` | count |
|`hadoop_admin_resourceaccesscounthive` |`访问Hive资源的次数` | count |
|`hadoop_admin_resourceaccesscountkafka_connect` |`访问Kafka Connect资源的次数` | count |
|`hadoop_admin_resourceaccesscountkms` |`访问KMS（密钥管理系统）资源的次数` | count |
|`hadoop_admin_resourceaccesscountknox` |`访问Knox资源的次数` | count |
|`hadoop_admin_resourceaccesscountkudu` |`访问Kudu资源的次数` | count |
|`hadoop_admin_resourceaccesscountozone` |`访问Ozone资源的次数` | count |
|`hadoop_admin_resourceaccesscountsolr` |`访问Solr资源的次数` | count |
|`hadoop_admin_resourceaccesscounttag` |`带有特定标签的资源访问次数` | count |
|`hadoop_admin_resourceaccesscountyarn` |`使用ARN（亚马逊资源名称）的资源访问次数` | count |
|`hadoop_admin_rowfilteringcount` |`行过滤的次数` | count |
|`hadoop_admin_servicecount` |`服务的总数` | count |
|`hadoop_admin_servicecountatlas` |`Atlas服务的数量` | count |
|`hadoop_admin_servicecounthbase` |`HBase服务的数量` | count |
|`hadoop_admin_servicecounthdfs` |`HDFS服务的数量` | count |
|`hadoop_admin_servicecounthive` |`Hive服务的数量` | count |
|`hadoop_admin_servicecountkafka` |`Kafka服务的数量` | count |
|`hadoop_admin_servicecountkafka_connect` |`Kafka Connect服务的数量` | count |
|`hadoop_admin_servicecountkms` |`KMS服务的数量` | count |
|`hadoop_admin_servicecountknox` |`Knox服务的数量` | count |
|`hadoop_admin_servicecountkudu` |`Kudu服务的数量` | count |
|`hadoop_admin_servicecountsolr` |`Solr服务的数量` | count |
|`hadoop_admin_servicecounttag` |`带有特定标签的服务数量` | count |
|`hadoop_admin_servicecountyarn` |`使用ARN的服务数量` | count |
|`hadoop_admin_sink_jsonavgtime` |`JSON接收器的平均耗时` | ms |
|`hadoop_admin_sink_jsondropped` |`JSON接收器丢弃的消息数` | count |
|`hadoop_admin_sink_jsonnumops` |`JSON接收器操作次数` | count |
|`hadoop_admin_sink_jsonqsize` |`JSON接收器的队列大小` | count |
|`hadoop_admin_sink_prometheusavgtime` |`Prometheus接收器的平均耗时` | count |
|`hadoop_admin_sink_prometheusdropped` |`Prometheus接收器丢弃的消息数` | count |
|`hadoop_admin_sink_prometheusnumops` |`Prometheus接收器操作次数` | count |
|`hadoop_admin_sink_prometheusqsize` |`Prometheus接收器的队列大小` | count |
|`hadoop_admin_snapshotavgtime` |`快照操作的平均耗时` | count |
|`hadoop_admin_snapshotnumops` |`快照操作次数` | count |
|`hadoop_admin_systemloadavg` |`系统平均负载` | count |
|`hadoop_admin_threadsblocked` |`被阻塞的线程数` | count |
|`hadoop_admin_threadsbusy` |`忙碌的线程数` | count |
|`hadoop_admin_threadsremaining` |`剩余的线程数` | count |
|`hadoop_admin_threadswaiting` |`等待的线程数` | count |
|`hadoop_admin_usercount` |`用户总数` | count |
|`hadoop_admin_systemloadavg` |`系统平均负载` | count |
|`hadoop_admin_usercountsysadmin` |`系统管理员用户数` | count |
|`hadoop_admin_usercountuser` |`普通用户数` | count |
