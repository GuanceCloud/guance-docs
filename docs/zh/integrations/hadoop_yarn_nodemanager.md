---
title     : 'Hadoop Yarn NodeManager'
summary   : '采集 Yarn NodeManager 指标信息'
__int_icon: 'icon/hadoop-yarn'
dashboard :
  - desc  : 'Yarn NodeManager'
    path  : 'dashboard/zh/hadoop_yarn_nodemanager'
monitor   :
  - desc  : 'Yarn NodeManager'
    path  : 'monitor/zh/hadoop_yarn_nodemanager'
---

<!-- markdownlint-disable MD025 -->
# Hadoop Yarn NodeManager
<!-- markdownlint-enable -->

采集 Yarn NodeManager 指标信息。

## 安装部署 {#config}

由于 NodeManager 是 java 语言开发的，所以可以采用 jmx-exporter 的方式采集指标信息。

### 1. NodeManager 配置

#### 1.1 下载 jmx-exporter

下载地址：`https://github.com/prometheus/jmx_exporter`

#### 1.2 下载 jmx 脚本

下载地址：`https://github.com/lrwh/jmx-exporter/blob/main/hadoop-yarn-nodemanager.yml`

#### 1.3 NodeManager 启动参数调整

在 nodemanager 的启动参数添加

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17108:/opt/guance/jmx/jmx_node_manager.yml

#### 1.4 重启 NodeManager

### 2. DataKit 采集器配置

#### 2.1 [安装 DataKit](../datakit/datakit-install.md)

#### 2.2 配置采集器

通过 jmx-exporter 可以直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。

进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/prom` ，复制 `prom.conf.sample` 为 `nodemanager.conf`。

> `cp prom.conf.sample nodemanager.conf`

调整`nodemanager.conf`内容如下：

```toml

  urls = ["http://localhost:17108/metrics"]
  source ="yarn-nodemanager"
  [inputs.prom.tags]
    component = "yarn-nodemanager" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*其他配置按需调整*</font>
<!-- markdownlint-enable -->
，调整参数说明 ：

<!-- markdownlint-disable MD004 -->
- urls：`jmx-exporter`指标地址，这里填写对应组件暴露出来的指标 url
- source：采集器别名，建议做区分
- keep_exist_metric_name: 保持指标名称
- interval：采集间隔
- inputs.prom.tags: 新增额外的 tag
<!-- markdownlint-enable -->

### 3. 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

## 指标 {#metric}

### Hadoop 指标集

NodeManager 指标位于 Hadoop 指标集下，这里主要介绍 NodeManager 相关指标说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`nodemanager_allocatedcontainers` |`节点管理器分配容器数量` | count |
|`nodemanager_allocatedgb` |`节点管理器已分配数量` | count |
|`nodemanager_allocatedopportunisticgb`|`节点管理器可分配的字节数` | count |
|`nodemanager_allocatedopportunisticvcores` |`节点管理器可分配机会数量` | count |
|`nodemanager_allocatedvcores` |`节点管理器已分配的vcores数量` | count |
|`nodemanager_availablegb` |`节点管理器可用字节数量` | count |
|`nodemanager_availablevcores` |`节点管理器可用vcores数量` | count |
|`nodemanager_badlocaldirs` |`节点管理器损坏本地目录数量` | count |
|`nodemanager_badlogdirs` |`节点管理器损坏日志目录数量` | count |
|`nodemanager_blocktransferratebytes_count` |`节点管理器块传输字节数` | byte |
|`nodemanager_blocktransferratebytes_rate1` |`节点管理器块传输字节速率1` | B/s |
|`nodemanager_blocktransferratebytes_rate15` | `节点管理器块传输字节速率15` | B/s |
|`nodemanager_blocktransferratebytes_rate5` |`节点管理器块传输字节速率5` | B/s |
|`nodemanager_blocktransferratebytes_ratemean` |`节点管理器块传输字节平均值` | byte |
|`nodemanager_cachesizebeforeclean` |`节点管理器缓存清理前大小` | byte |
|`nodemanager_callqueuelength` |`节点管理器调用队列长度` | count |
|`nodemanager_containerlaunchdurationavgtime` |`节点管理器容器启动平均时间` | s |
|`nodemanager_containerlaunchdurationnumops` | `节点管理器容器启动操作次数`| count |
|`nodemanager_containerscompleted` |`节点管理器已完成容器数量` | count |
|`nodemanager_containersfailed` |`节点管理器容器失败数量` | count |
|`nodemanager_containersiniting` | `节点管理器容器退出数量` | count |
|`nodemanager_containerskilled` |`节点管理器容器运行数量` | count |
|`nodemanager_containerslaunched` |`节点管理器容器已启动数量` | count |
|`nodemanager_containersreiniting` |`节点管理器容器重启数量` | count |
|`nodemanager_containersrolledbackonfailure` |`节点管理器容器回滚失败数量` | count |
|`nodemanager_containersrunning` |`节点管理器容器运行中数量` | ms |
|`nodemanager_deferredrpcprocessingtimeavgtime` |`节点管理器延迟pc处理平均时间` | s |
|`nodemanager_deferredrpcprocessingtimenumops` |`节点管理器延迟rpc操作数` | count |
|`nodemanager_droppedpuball` |`节点管理器丢弃的puball` | count |
|`nodemanager_gccount` |`节点管理器垃圾回收计数` | count |
|`nodemanager_gccountconcurrentmarksweep` |`节点管理器垃圾回收计数并标记的数量` | count |
|`nodemanager_gccountparnew` |`节点管理器垃圾回收复制数量` | count |
|`nodemanager_gcnuminfothresholdexceeded` |`节点管理器垃圾回收信息数超过阈值数` | count |
|`nodemanager_gcnumwarnthresholdexceeded` |`节点管理器垃圾回收警告超过阈值数量` | count |
|`nodemanager_gctimemillis` |`节点管理器垃圾回收时间毫秒` | ms |
|`nodemanager_gctimemillisconcurrentmarksweep` |`节点管理器垃圾回收标记毫秒` | ms |
|`nodemanager_gctimemillisparnew` |`节点管理器复制毫秒时间` | ms |
|`nodemanager_gctotalextrasleeptime` |`节点管理器垃圾回收总休眠时间` | s |
|`nodemanager_getgroupsavgtime` |`节点管理器获取组平均时间` | s |
|`nodemanager_getgroupsnumops` |`节点管理器获取组操作次数` | count |
|`nodemanager_goodlocaldirsdiskutilizationperc` |`节点管理器本地健康磁盘使用率` | count |
|`nodemanager_logerror` |`节点管理器日志错误数` | count |
|`nodemanager_logfatal` |`节点管理器日志删除数` | count |
|`nodemanager_loginfailureavgtime` |`节点管理器日志写入失败平均时间` | ms |
|`nodemanager_loginfailurenumops` |`节点管理器日志写入失败操作次数` | count |
|`nodemanager_loginfo` |`节点管理器日志信息数` | count |
|`nodemanager_loginsuccessavgtime` |`节点管理器日志写入成功平均时间` | count |
|`nodemanager_loginsuccessnumops` |`节点管理器写入日志成功操作次数` | count |
|`nodemanager_logwarn` |`节点管理器日志警告数量` | count |
|`nodemanager_memheapcommittedm` |`节点管理器提交内存堆数量` | count |
|`nodemanager_memheapmaxm` |`节点管理器最大内存堆数` | count |
|`nodemanager_memheapusedm` |`节点管理器已使用内存堆数量` | count |
|`nodemanager_memmaxm` |`节点管理器内存最大值` | byte |
|`nodemanager_memnonheapcommittedm` |`节点管理器未提交内存堆数量` | count |
|`nodemanager_memnonheapmaxm` |`节点管理器未提交内存堆最大数量` | count |
|`nodemanager_memnonheapusedm` |`节点管理器内存堆未使用最大数量` | count |
|`nodemanager_numactiveconnections` |`节点管理器连接数量` | count |
|`nodemanager_numactivesinks` |`节点管理器活跃池数量` | count |
|`nodemanager_numactivesources` |`节点管理器活跃资源数量` | count |
|`nodemanager_numallsinks` |`节点管理器池总数量` | count |
|`nodemanager_numallsources` |`总资源数` | count |
|`nodemanager_numdroppedconnections` |`节点管理器丢弃连接数` | count |
|`nodemanager_numopenconnections` |`节点管理器打开连接数` | count |
|`nodemanager_numregisteredconnections` |`节点管理器注册连接数` | count |
|`nodemanager_openblockrequestlatencymillis_count` |`节点管理器开放块延迟次数` | count |
|`nodemanager_openblockrequestlatencymillis_rate1` |`节点管理器开放块延迟请求速率1` | B/s |
|`nodemanager_openblockrequestlatencymillis_rate15` |`节点管理器开放块延迟请求速率15` | B/s |
| `nodemanager_openblockrequestlatencymillis_rate5` | `节点管理器开放块延迟请求速率5` | B/s |
|`nodemanager_openblockrequestlatencymillis_ratemean` |`节点管理器开放块平均请求延迟率` | B/s  |
|`nodemanager_privatebytesdeleted` |`节点管理器已删除的私有字节数` | byte |
|`nodemanager_publicbytesdeleted` |`节点管理器已删除字节数` | byte |
|`nodemanager_publishavgtime` |`节点管理器发布时平均时间` | s |
|`nodemanager_publishnumops` | `节点管理器发布数据操作次数` | ms |
|`nodemanager_receivedbytes` | `节点管理器接收字节数` | byte |
|`nodemanager_registeredexecutorssize` |`节点管理器注册执行器分类表数` | count |
|`nodemanager_registerexecutorrequestlatencymillis_count` |`节点管理器_注册执行器请求延迟毫秒数` | count  |
|`nodemanager_registerexecutorrequestlatencymillis_rate1` |`节点管理器注册执行器请求延迟速率1` | B/s |
|`nodemanager_registerexecutorrequestlatencymillis_rate15` |`节点管理器注册执行器请求延迟速率15` | B/s |
|`nodemanager_registerexecutorrequestlatencymillis_rate5` |`节点管理器注册执行器请求延迟速率5` | B/s |
|`nodemanager_registerexecutorrequestlatencymillis_ratemean` |`节点管理器注册执行器延迟毫秒平均值` | count |
|`nodemanager_renewalfailures` |`节点管理器更新时报次数` | count |
|`nodemanager_renewalfailurestotal` |`节点管理器更新失败总数` | count |
|`nodemanager_rpcauthenticationfailures` |`节点管理器验证失败数` | count |
|`nodemanager_rpcauthorizationsuccesses` |`节点管理器验证成功数` | count |
|`nodemanager_rpcclientbackoff` |`节点管理器rpc客户回退次数` | count |
|`nodemanager_rpcprocessingtimeavgtime` |`节点管理器处理时间的平均时间` | s |
|`nodemanager_rpcprocessingtimenumops` |`节点管理器rpc处理过程操作次数` | count |
|`nodemanager_rpcqueuetimeavgtime` |`节点管理器rpc队列时间平均时间` | count |
|`nodemanager_rpcqueuetimenumops` |`节点管理器rpc队列时间操作次数` | count |
|`nodemanager_rpcslowcalls` |`节点管理器慢调用数` | count |
|`nodemanager_runningopportunisticcontainers` |`节点管理器正在运行机会容器树` | count |
|`nodemanager_securityenabled` |`节点管理器已启用安全数` | count |
|`nodemanager_sentbytes` |`字节管理器已发送字节数` | byte |
|`nodemanager_shuffleconnections` |`字节管理器重新连接次数` | count |
|`nodemanager_shuffleoutputbytes` |`字节管理器重新输出字节数` | byte |
|`nodemanager_shuffleoutputsfailed` |`节点管理器重新输出失败次数` | count |
|`nodemanager_shuffleoutputsok` |`节点管理器成功shuffle输出数量` | count |
|`nodemanager_snapshotavgtime` |`节点管理器快照平均时间` | s |
|`nodemanager_snapshotnumops` |`节点管理器快照操作次数` | count |
|`nodemanager_threadsblocked` |`节点管理器线程锁定数` | count |
|`nodemanager_threadsnew` |`节点管理新建线程数` | count |
|`nodemanager_threadsrunnable` |`节点管理器不可运行线程数` | count |
|`nodemanager_threadsterminated` |`节点管理器已初始化线程数` | count |
|`nodemanager_threadstimedwaiting` |`节点管理器线程等待时间` | s |
|`nodemanager_threadswaiting` |`节点管理器线程切换数` | count |
|`nodemanager_totalbytesdeleted` |`节点管理器已删除总字节数` | byte |



