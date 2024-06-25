---
icon: zy/logs
---
# 日志
---

<video controls="controls" poster="https://static.guance.com/dataflux/help/video/log.png" >
      <source id="mp4" src="https://static.guance.com/dataflux/help/video/log.mp4" type="video/mp4">
</video>

日志是程序产生的，遵循一定格式（通常包含时间戳）的文本数据。通常日志由服务器生成，输出到不同的文件中，一般会有系统日志、应用日志、安全日志等。这些日志分散地存储在不同的服务器上，当系统发生故障时，需要登录到各个服务器上，在日志里查找故障原因，这对于我们排查故障造成了比较大的麻烦。

因此，如果能集中管理这些日志，并提供集中检索和关联分析功能，不仅可以提供高效率诊断，同时能全面了解系统情况，避免事后救火的被动。

<!--

日志数据在以下几个方面具有非常重要的作用：

- 数据查找：通过检索日志信息，定位相应的问题，找出解决方案；
- 服务诊断：通过对日志信息进行统计、分析，了解服务器的负荷和服务运行状态；
- 数据分析：支持做进一步的数据分析。

-->

观测云提供全面的日志采集能力，通过[日志采集](collection.md)把日志数据统一上报到观测云工作空间，您可以对所采集的日志数据进行统一存储、审计、监控、告警、分析、导出等。

## 在本模块，您将了解：


<div class="grid cards" markdown>

- [<font color="coral"> :material-clipboard-text-search: __日志查询与分析__</font>](explorer.md)：统计各个时间点下产生不同等级的日志数量
- [<font color="coral"> :material-book-arrow-down-outline: __Pipeline__</font>](../pipeline/index.md)：对日志的文本内容进行切割，从而提取出特定的字段作为标签或者日志的时间戳
- [<font color="coral"> :fontawesome-brands-atlassian: __生成指标__</font>](generate-metrics.md)：基于日志，自定义生成监控指标的规则
- [<font color="coral"> :material-calendar-text-outline: __日志索引__</font>](multi-index.md)：筛选符合条件的日志保存在不同的日志索引中，并为日志索引选择数据存储策略
- [<font color="coral"> :material-filter-multiple: __日志黑名单__</font>](../management/overall-blacklist.md)：自定义日志采集的过滤规则，实时过滤日志数据      
- [<font color="coral"> :material-clipboard-check-multiple-outline: __数据转发__</font>](../management/backup.md)：日志、链路和用户访问数据可转发到外部存储
- [<font color="coral"> :fontawesome-solid-photo-film: __保存快照__</font>](../getting-started/function-details/snapshot.md)：保存当前状态的数据集合为副本，便于日后反复查看
- [<font color="coral"> :material-database-check: __数据访问__</font>](../logs/logdata-access.md)：为不同角色配置对应的日志数据访问查询范围
      
</div>

