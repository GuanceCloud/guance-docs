# OpenAPI 更新日志

## 2024-10-30
* 静默规则 创建/修改接口新增 name、description、filterString字段

## 2024-09-04
* 「日志 - 索引」创建/修改单个绑定索引配置接口, `accessCfg`内新增了`iamProjectName`、`projectId`、`topicId` 三个参数用以支持 绑定火山引擎TLS。
* 数据访问 创建/修改接口新增 name、desc
* 数据访问 获取详情和列表接口返回结果中新增 name、desc 字段


## 2024-08-07
* SLO 创建/修改接口新增 tags、alertPolicyUUIDs 并弃用 alertOpt 参数。
* SLO 获取详情和列表接口返回结果中新增 tagInfo、alertPolicyInfos 字段, 丢弃了 alertOpt 字段

## 2024-11-27
* 告警策略 成员 类型 参数结构 调整

## 2024-12-11
* 外部事件 监控器的 type 由 outer_event_checker 调整为 trigger
