---
icon: zy/logs
---
# 日志
---

<video controls="controls" poster="https://static.guance.com/dataflux/help/video/log.png" >
      <source id="mp4" src="https://static.guance.com/dataflux/help/video/log.mp4" type="video/mp4">
</video>

在现代基础设施中，每分钟可能产生数千条日志事件，这些日志遵循特定格式，通常包含时间戳，并由服务器生成。它们被输出到不同的文件中，如系统日志、应用日志和安全日志等。然而，这些日志目前分散存储在各个服务器上，导致在系统发生故障时，需要分别登录到每个服务器去查阅日志，以确定故障原因，这一过程增加了故障排查的复杂性。

面对如此庞大的数据量，您需要决定哪些日志应该发送到日志管理解决方案，哪些应该被存档。如果在发送前对日志进行过滤，可能会遗漏关键信息或不小心删除有价值的数据。

为了提高故障诊断的效率并全面掌握系统状态，避免在紧急情况下被动应对，实现日志的集中管理和提供集中检索与关联分析功能变得至关重要。

观测云通过其强大的日志采集功能，允许您将日志数据统一上报至观测云工作空间。这样，您可以对采集的日志数据进行集中的存储、审计、监控、告警、分析和导出等操作，从而简化了日志管理流程。

通过这种方式，观测云帮助您避免在发送日志前进行过滤可能带来的问题，确保所有关键信息都能被妥善处理和分析。


## 功能模块


<div class="grid cards" markdown>

- [:material-clipboard-text-search:{ .lg .middle } __查询与分析__](explorer.md)

    ---
    
    自动识别日志状态，快速筛选和关联日志，聚合相似文本，帮助迅速发现并分析异常，加速故障排除

- [:material-book-arrow-down-outline:{ .lg .middle } __Pipelines__](../pipeline/index.md)

    ---

    对日志的文本内容进行切割，将其转换成结构化数据，包括提取时间戳、状态和特定字段作为标签

- [:fontawesome-brands-atlassian:{ .lg .middle } __生成指标__](generate-metrics.md)

    ---

    基于当前空间内的现有数据生成新的指标数据，以便于依据需求设计并实现新的技术指标

- [:material-calendar-text-outline:{ .lg .middle } __日志索引__](./multi-index/index.md)

    ---

    筛选符合条件的日志数据归档在不同的索引中，并为日志索引选择数据存储策略

- [:material-filter-multiple:{ .lg .middle } __日志黑名单__](../management/overall-blacklist.md)  

    ---

    自定义日志采集的过滤规则，符合条件的日志数据不再上报到观测云，帮助节约日志数据存储费用

- [:material-clipboard-check-multiple-outline:{ .lg .middle } __数据转发__](../management/backup/index.md)
    
    ---

    将日志、链路和用户访问数据保存到观测云的对象存储或转发到外部存储，灵活管理数据转发数据

- [:material-database-check:{ .lg .middle } __数据访问__](../logs/logdata-access.md)

    ---

    通过设定角色访问权限和数据脱敏规则，可以更精细地控制日志数据的访问，同时妥善处理敏感信息
      
</div>

