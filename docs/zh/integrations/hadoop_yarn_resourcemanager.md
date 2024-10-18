---
title     : 'Hadoop Yarn ResourceManager'
summary   : '采集 Yarn ResourceManager 指标信息'
__int_icon: 'icon/hadoop-yarn'
dashboard :
  - desc  : 'Yarn ResourceManager'
    path  : 'dashboard/zh/hadoop_yarn_resourcemanager'
monitor   :
  - desc  : 'Yarn ResourceManager'
    path  : 'monitor/zh/hadoop_yarn_resourcemanager'
---

<!-- markdownlint-disable MD025 -->
# Hadoop Yarn ResourceManager
<!-- markdownlint-enable -->

采集 Yarn ResourceManager 指标信息。

## 安装部署 {#config}

由于 ResourceManager 是 java 语言开发的，所以可以采用 jmx-exporter 的方式采集指标信息。

### 1. ResourceManager 配置

#### 1.1 下载 jmx-exporter

下载地址：`https://github.com/prometheus/jmx_exporter`

#### 1.2 下载 jmx 脚本

下载地址：`https://github.com/lrwh/jmx-exporter/blob/main/hadoop-yarn-resourcemanager.yml`

#### 1.3 ResourceManager 启动参数调整

在 resourcemanager 的启动参数添加

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17109:/opt/guance/jmx/jmx_resource_manager.yml

#### 1.4 重启 ResourceManager

### 2. DataKit 采集器配置

#### 2.1 [安装 DataKit](../datakit/datakit-install.md)

#### 2.2 配置采集器

通过 jmx-exporter 可以直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。

进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/prom` ，复制 `prom.conf.sample` 为 `resourcemanager.conf`。

> `cp prom.conf.sample resourcemanager.conf`

调整`resourcemanager.conf`内容如下：

```toml

  urls = ["http://localhost:17109/metrics"]
  source ="yarn-resourcemanager"
  [inputs.prom.tags]
    component = "yarn-resourcemanager" 
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

ResourceManager 指标位于 Hadoop 指标集下，这里主要介绍 ResourceManager 相关指标说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`resourcemanager_activeapplications` |`资源管理器应用程序数量` | count |
|`resourcemanager_activeusers` |`资源管理器活跃用户数量` | count |
|`resourcemanager_aggregatecontainersallocated`|`资源管理器已分配的容器数`| count |
|`resourcemanager_aggregatecontainerspreempted`|`资源管理器被占用的容器数量`|count |
|`resourcemanager_aggregatecontainersreleased`|`资源管理器释放容器数量`| count |
|`resourcemanager_aggregatememorymbsecondspreempted`|`被占用容器每秒消耗的内存量` | B/s |
|`resourcemanager_aggregatenodelocalcontainersallocated` |`所有节点上本地运行的容器数量` | count |
|`resourcemanager_aggregateoffswitchcontainersallocated` |`资源管理器将容器分配聚合开关数量` | count |
|`resourcemanager_aggregateracklocalcontainersallocated` |`聚合本地容器机架的数量` | count |
|`resourcemanager_aggregatevcoresecondspreempted` |`资源管理器cpu占用的数量` | byte |
|`resourcemanager_allocatedcontainers` |`资源管理器已分配给应用程序的容器数量` | count |
|`resourcemanager_allocatedmb` | `资源管理器已分配的内存大小` | B/s |
|`resourcemanager_allocatedvcores` |`资源管理器已分配的cpu核心数` | count |
|`resourcemanager_amlaunchdelayavgtime` |`应用程序启动延迟平均时间` | ms |
|`resourcemanager_amlaunchdelaynumops` |`应用程序启动延迟次数` | count |
|`resourcemanager_amregisterdelayavgtime` |`资源管理器注册平均延迟时间` | ms |
|`resourcemanager_amregisterdelaynumops` |`资源管理器注册延迟次数` | s |
|`resourcemanager_amresourceusagemb` | `节点管理器容器启动操作次数`| count |
|`resourcemanager_amresourceusagevcores` |`节点管理器已完成容器数量` | count |
|`resourcemanager_appattemptfirstcontainerallocationdelayavgtime` |`节点管理器容器失败数量` | count |
|`resourcemanager_appattemptfirstcontainerallocationdelaynumops` | `节点管理器容器退出数量` | count |
|`resourcemanager_appscompleted` |`节点管理器容器运行数量` | count |
|`resourcemanager_appsfailed` |`资源管理器应用程序失败数量` | count |
|`resourcemanager_appskilled` |`资源管理器应用程序终止数量` | count |
|`resourcemanager_appspending` |`等待执行的应用程序数量` | count |
|`resourcemanager_appsrunning` |`正在运行的应用程序数量` | count |
|`resourcemanager_appssubmitted` |`资源管理器已提交的应用程序数量` | count |
|`resourcemanager_availablemb` |`资源管理器可用内存总量` | count |
|`resourcemanager_availablevcores` |`资源管理器可用CPU核心数` | count |
|`resourcemanager_callqueuelength` |`资源管理区调用队列长度` | count |
|`resourcemanager_continuousschedulingrunavgtime` |`资源管理器连续调度运行平均时间` | ms |
|`resourcemanager_continuousschedulingrunimaxtime` |`资源管理器连续调度运行最大时间` | ms |
|`resourcemanager_continuousschedulingrunimintime` |`资源管理器连续调度运行最小时间` | ms |
|`resourcemanager_continuousschedulingruninumops` |`资源管理器连续调度操作次数` | count |
|`resourcemanager_continuousschedulingrunmaxtime` |`资源管理器连续调度运行最大时间` | ms |
|`resourcemanager_continuousschedulingrunmintime` |`资源管理器连续调度运行最小时间` | ms |
|`resourcemanager_continuousschedulingrunnumops` |`资源管理器连续调度操作次数` | count |
|`resourcemanager_deferredrpcprocessingtimenumops` |`资源管理器延迟rpc处理时间的操作次数` | count |
|`resourcemanager_droppedpuball` |`资源管理器丢弃puball的次数` | count |
|`resourcemanager_fairsharemb` |`资源管理器内存量分配` | count |
|`resourcemanager_fairsharevcores` |`资源管理器CPU核心数分配数量` | count |
|`resourcemanager_gccount` |`资源管理器垃圾回收次数` | count |
|`resourcemanager_gccountconcurrentmarksweep` |`垃圾回收标记清除次数` | count |
|`resourcemanager_gccountparnew` |`parnew垃圾收集器数量` | ms |
|`resourcemanager_gcnuminfothresholdexceeded` |`资源管理器GC采集信息超过阈值次数`| count |
|`resourcemanager_gcnumwarnthresholdexceeded` |`资源管理器GC暂停超过阈值次数` | count |
|`resourcemanager_gctimemillis` |`GC最后一次启动到完成的时间` | ms |
|`resourcemanager_gctimemillisconcurrentmarksweep` |`节点管理器写入日志成功操作次数` | count |
|`resourcemanager_gctimemillisparnew` |`parnew启动到完成的时间` | ms |
|`resourcemanager_gctotalextrasleeptime` |`资源管理器额外总休眠时间` | ms |
|`resourcemanager_getgroupsavgtime` |`资源管理器获取组的平均时间` | count |
|`resourcemanager_logerror` |`节点管理器已使用内存堆数量` | count |
|`resourcemanager_logfatal` |`节点管理器内存最大值` | byte |
|`resourcemanager_loginfailureavgtime` |`资源管理器登录失败平均时间` | ms |
|`resourcemanager_loginfailurenumops` |`资源管理器登录失败次数` | count |
|`resourcemanager_loginfo` |`资源管理器登录信息数` | count |
|`resourcemanager_loginsuccessavgtime` |`资源管理器登录成功平均时间` | ms |
|`resourcemanager_loginsuccessnumops` |`资源管理器登录成功次数` | count |
|`resourcemanager_logwarn` |`资源管理器日志警告数量` | count |
|`resourcemanager_maxamsharemb` |`资源管理器最大AM资源使用量` | byte |
|`resourcemanager_maxamsharevcores` |`资源管理器最大共享CPU核心数` | count |
|`resourcemanager_maxapps` |`资源管理器应用程序最大数量` | count |
|`resourcemanager_memheapcommittedm` |`资源管理器已分配的内存大小` | byte |
|`resourcemanager_memheapmaxm` |`资源管理器最大内存量` | byte |
|`resourcemanager_memheapusedm` |`资源管理器已使用的内存量` | byte |
|`resourcemanager_memmaxm` |`资源管理器内存最大值` | byte |
|`resourcemanager_memnonheapcommittedm` |`资源管理器申报要分配的内存大小` | byte |
|`resourcemanager_memnonheapmaxm` | `资源管理器申报最大内存量` | byte |
|`resourcemanager_memnonheapusedm` |`资源管理器申报已使用的内存量` | byte  |
|`resourcemanager_minsharemb` |`资源管理器最小资源量` | count |
|`resourcemanager_minsharevcores` |`资源管理器最小CPU核心数` | byte |
|`resourcemanager_nodeheartbeatavgtime` |`资源管理器节点心跳平均时间` | s |
|`resourcemanager_nodeheartbeatnumops` |`资源管理器节点心跳次数` | count |
|`resourcemanager_nodeupdatecallavgtime` |`资源管理器节点更新响应平均时间` | s |
|`resourcemanager_nodeupdatecallimaxtime` |`资源管理器节点响应最大时间` | s |
|`resourcemanager_nodeupdatecallimintime` |`资源管理器节点更新响应最小时间` | s  |
|`resourcemanager_nodeupdatecallinumops` |`资源管理器节点更新响应次数` | count |
|`resourcemanager_numactivenms` |`资源管理器当前存活的NodeManager个数` | count |
|`resourcemanager_numactivesinks` |`资源管理器当前存活的sink个数` | count |
|`resourcemanager_numactivesources` |`资源管理器存活的资源数量` | count |
|`resourcemanager_numallsinks` |`资源管理器所有的sink数量` | count |
|`resourcemanager_numallsources` |`资源管理器所有的资源数据量` | count |
|`resourcemanager_numdecommissionednms` |`资源管理器已退役的节点个数` | count |
|`resourcemanager_numdecommissioningnms` |`资源管理器正在退役的节点个数` | count |
|`resourcemanager_numdroppedconnections` |`资源管理器被丢弃的连接数` | count |
|`resourcemanager_numlostnms` |`资源管理器丢失的节点个数` | count |
|`resourcemanager_numopenconnections` |`资源管理器开放的连接数` | count |
|`resourcemanager_numrebootednms` |`资源管理器重启的节点数` | count |
|`resourcemanager_numshutdownnms` |`资源管理器关闭的节点数` | count |
|`resourcemanager_numunhealthynms` |`资源管理器健康的节点数` | count |
|`resourcemanager_pendingcontainers` |`资源管理器中等待分配的容器数` | count |
|`resourcemanager_pendingmb` |`资源管理器等待分配的资源数` | count |
|`resourcemanager_pendingvcores` |`资源管理器等待分配的CPU核心数` | count |
|`resourcemanager_publishavgtime` |`资源管理器数据发布平均时间` | s |
|`resourcemanager_rpcprocessingtimeavgtime` |`资源管理器rpc执行平均时间` | s |
|`resourcemanager_rpcprocessingtimenumops` |`资源管理器执行次数` | count |
|`resourcemanager_rpcqueuetimeavgtime` |`资源管理器rpc响应平均时间` | count |
|`resourcemanager_rpcqueuetimenumops` |`资源管理器rpc响应操作次数` | count |
|`resourcemanager_rpcslowcalls` |`资源管理器rpc慢调用时间` | s |
|`resourcemanager_running_0` |`运行0秒的应用程序数量` | count |
|`resourcemanager_running_1440` |`运行1400秒的应用程序数量` | count |
|`resourcemanager_running_300` |`运行300秒的应用程序数量` | count |
|`resourcemanager_running_60` |`运行60秒的应用程序数量` | count |
|`resourcemanager_securityenabled` |`资源管理器安全机制启用数` | count |
|`resourcemanager_sentbytes` |`资源管理器已发送的字节数` | byte |
|`resourcemanager_snapshotavgtime` |`资源管理器数据快照平均时间` | s |
|`resourcemanager_snapshotnumops` |`资源管理器数据快照操作次数`| count |
|`resourcemanager_steadyfairsharemb` |`资源管理器加权共享内存量`| byte |
|`resourcemanager_steadyfairsharevcores` |`资源管理器加权共享CPU核心数`| count |
|`resourcemanager_threadsblocked` |`资源管理器县城锁数量`| count |
|`resourcemanager_threadsnew` |`资源管理器线程新建数量`| count |
|`resourcemanager_threadsrunnable` |`资源管理器线程运行数量`| count |
|`resourcemanager_threadsterminated` |`资源管理器线程终止数量`| count |
|`resourcemanager_threadstimedwaiting` |`资源管理器超时等待的线程数量`| count |
|`resourcemanager_threadswaiting` |`资源管理器线程等待数量`| count |
|`resourcemanager_updatethreadrunavgtime` |`资源管理器更新线程平均时间`| s |
|`resourcemanager_updatethreadrunimaxtime` |`资源管理器线程更新最大时间`| s |
|`resourcemanager_updatethreadrunimintime` |`资源管理器线程更新最小时间`| s |
|`resourcemanager_updatethreadruninumops` |`资源管理器线程更新操作次数`| count |
|`resourcemanager_updatethreadrunmaxtime` |`资源管理器线程更新最大时间`| s |
|`resourcemanager_updatethreadrunmintime` |`资源管理器线程更新最小时间`| s |
|`resourcemanager_updatethreadrunnumops` |`资源管理器线程更新操作次数`| count |

