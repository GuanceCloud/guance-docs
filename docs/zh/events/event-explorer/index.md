# 查看器

进入观测云**事件 > 查看器**，您可以一站式查看和审计监控事件信息，实现对监控器、智能巡检、SLO 等来源触发的事件进行实时监控、统一查询。

查看器主要包括：

- [未恢复事件查看器](./unrecovered-events.md)：当前工作空间内持续被触发的全部未恢复事件；
- [事件列表](./event-list.md)：所有等级的事件的统计列表；
- [事件详情](./event-details.md)：包括事件的基础属性、扩展字段、历史记录、关联事件等详情信息。

## 事件来源

- 基于配置的 [监控器](../../monitoring/monitor/index.md) 触发的全部告警事件；
- 基于配置的 [智能巡检](../../monitoring/bot-obs/index.md) 触发的全部告警事件；  
- 基于配置的 [SLO](../../monitoring/slo.md) 触发的全部告警事件；  
- 基于系统操作触发的[审计事件](../../management/operation-audit.md)；  
- 支持通过事件的 [OpenAPI 写入的自定义事件](../../open-api/keyevent/create.md)。

