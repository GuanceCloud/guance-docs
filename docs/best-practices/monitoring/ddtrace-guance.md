# DDtrace 观测云二次开发历史版本

---

> *联合作者： 刘锐、宋龙奇*

## 简介
观测云在使用`dd-trace-java`过程中有些功能源码并没有提供，遂决定在源码的基础上进行二次开发。

开源地址：[GuanceCloud-ddtrace](https://github.com/GuanceCloud/dd-trace-java)，并持续更新。如您在使用过程中有任务问题或有好的建议可在 github 上提 Issue 或者联系对接人员。 


最新版本下载地址 : https://static.guance.com/ddtrace/dd-java-agent.jar

## 说明
在使用 dd-trace-java 之前，您可事先了解:
- [datakit-ddtrace 采集器配置](../../integrations/ddtrace.md)
- [链路追踪（APM）介绍及配置](apm.md/#apm_2) 
- [ddtrace 高级用法](ddtrace-skill.md)

---

## (2022-08-23) Version:guance-0.106.0

当前版本下载地址: https://static.guance.com/ddtrace/dd-java-agent-guance-0.106.0-SNAPSHOT.jar

### 新增功能说明
- 增加 RocketMq 探针。
- 增加 Dubbo 探针。
- 增加 Sql 脱敏功能：开启后将原始的 sql 语句添加到链路中以方便排查问题，启动 Agent 时增加配置参数 `-Ddd.jdbc.sql.obfuscation=true`