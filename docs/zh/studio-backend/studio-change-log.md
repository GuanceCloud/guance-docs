## 2025-01-08
### OpenAPI
* 【可用性监测 - 拨测任务】增加修改拨测任务接口


## 2024-12-25
### OpenAPI
* 【基础设施 - 资源目录】增加资源查看器相关接口（增加、删除、修改、查询）
* 【指标 - 聚合生成指标】增加指标规则相关接口（增加、删除、修改、查询）
### Hotfix
* 修复 数据访问脱敏, 快照脱敏, 敏感数据脱敏 中的正则环视问题


## 2024-12-11
### OpenAPI
* 外部事件 监控器的 type 由 outer_event_checker 调整为 trigger


## 2024-11-27
### OpenAPI
* 告警策略 成员 类型 参数结构 调整


## 2024-10-30
### OpenAPI
* 静默规则 创建/修改接口新增 name、description、filterString字段
### ExternalAPI
* 新增 DataKit清单列表查询 接口


## 2024-09-04
### OpenAPI
* 「日志 - 索引」创建/修改单个绑定索引配置接口, `accessCfg`内新增了`iamProjectName`、`projectId`、`topicId` 三个参数用以支持 绑定火山引擎TLS。
* 数据访问 创建/修改接口新增 name、desc
* 数据访问 获取详情和列表接口返回结果中新增 name、desc 字段


## 2024-08-07
### OpenAPI
* SLO 创建/修改接口新增 tags、alertPolicyUUIDs 并弃用 alertOpt 参数。
* SLO 获取详情和列表接口返回结果中新增 tagInfo、alertPolicyInfos 字段, 丢弃了 alertOpt 字段
