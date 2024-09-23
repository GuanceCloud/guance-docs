# OpenAPI 更新日志

## 2024-09-04
* 「日志 - 索引」创建/修改单个绑定索引配置接口, `accessCfg`内新增了`iamProjectName`、`projectId`、`topicId` 三个参数用以支持 绑定火山引擎TLS。


## 2024-08-07
* SLO 创建/修改接口新增 tags、alertPolicyUUIDs 并弃用 alertOpt 参数。
* SLO 获取详情和列表接口返回结果中新增 tagInfo、alertPolicyInfos 字段, 丢弃了 alertOpt 字段

## 2024-09-04
* 数据访问 创建/修改接口新增 name、desc
* 数据访问 获取详情和列表接口返回结果中新增 name、desc 字段
