# 关联链接说明
---

观测云支持在事件通知内容中快速添加内置的跳转链接，用于查看当前告警通知事件相关日志、链路、错误追踪、Profile、容器、Pod、进程数据以及关联的仪表板。

## 链接配置说明

链接配置分成两个部分：

- 默认的内置链接：如 `/logIndi/log/all?ime={{ date * 1000 - 900000}},{{date *  1000}}`
- 基于监控器查询语句的分组变量值以及筛选条件：如 `&tags={host:{{host}},service:mysql}`

假设监控器的 DQL 查询语句为：

 `T::RE('.*'):(COUNT('error_stack')) { 'service' = 'mysql' } BY 'host'` 

对应的跳转链接详情如下：

| 关联数据 | 默认查询时间范围 | 链接配置 |
| --- | --- | --- |
| 查看相关日志 | 事件产生时间向前15分钟 | `[查看相关日志](/logIndi/log/all?ime={{ date * 1000 - 900000}},{{date *  1000}}&tags={host:{{host}},service:mysql})` |
| 查看相关链路 | 事件产生时间向前15分钟 | `[查看相关链路](/tracing/link/all?time={{ date * 1000 - 900000}},{{date *  1000}}&tags={host:{{host}},service:mysql})` |
| 查看相关错误追踪 | 事件产生时间向前15分钟 | `[查看相关错误追踪](/tracing/profile?time={{ date * 1000 - 900000}},{{date *  1000}}&tags={host:{{host}},service:mysql})` |
| 查看相关Profile | 事件产生时间向前15分钟 | `[查看相关Profile](/tracing/errorTrack?time={{ date * 1000 - 900000}},{{date *  1000}}&tags={host:{{host}},service:mysql})` |
| 查看相关容器 | 不带时间 | `[查看相关容器](/objectadmin/docker_containers?routerTabActive=ObjectadminDocker&tags={host:{{host}},service:mysql})` |
| 查看相关Pod | 不带时间 | `[查看相关Pod](/objectadmin/kubelet_pod?routerTabActive=ObjectadminDocker&tags={host:{{host}},service:mysql})` |
| 查看相关进程 | 事件产生时间向前5分钟 | `[查看相关进程](/objectadmin/host_processes?routerTabActive=ObjectadminProcesses&time={{ date * 1000 - 300000}},{{date *  1000}}&tags={host:{{host}},service:mysql})` |
| 查看关联仪表板 | 事件产生时间向前15分钟；将筛选条件带入视图变量 | `[查看相关仪表板](/scene/dashboard/dashboardDetail?dashboard_id= &name= &time={{ date * 1000 - 900000}},{{date *  1000}}&variable={host:{{host}},service:mysql})` |

