# DDtrace 观测云二次开发历史版本

---

> *联合作者： 刘锐、宋龙奇*

## 简介
观测云在使用`dd-trace-java`过程中有些功能源码并没有提供，遂决定在源码的基础上进行二次开发。

开源地址：[GuanceCloud-ddtrace](https://github.com/GuanceCloud/dd-trace-java)，并持续更新。如您在使用过程中有任务问题或有好的建议可在 github 上提 Issue 或者联系对接人员。 


最新版本下载地址 : https://static.guance.com/ddtrace/dd-java-agent.jar

## 说明
在使用 dd-trace-java 之前，您可事先了解:

- [datakit-ddtrace 采集器配置](../integrations/ddtrace.md)
- [ddtrace 配置](../best-practices/monitoring/apm.md/#ddtrace) 
- [ddtrace 高级用法](../best-practices/monitoring/ddtrace-skill.md)

---
## (2022-08-30) Version:guance-0.107.0

合并 DataDog 107版本，进行编译。

- 下载地址 github： https://github.com/GuanceCloud/dd-trace-java/releases

- 下载地址 guance: https://static.guance.com/ddtrace/dd-java-agent.jar

---

## (2022-08-23) Version:guance-0.105.0

当前版本下载地址: https://static.guance.com/ddtrace/dd-java-agent-guance-0.106.0-SNAPSHOT.jar

### 新增功能说明
- 增加 RocketMq 探针。
- 增加 Dubbo 探针。
- 增加 Sql 脱敏功能：开启后将原始的 sql 语句添加到链路中以方便排查问题，启动 Agent 时增加配置参数 `-Ddd.jdbc.sql.obfuscation=true`
 
脱敏功能使用方式 

1. Tomcat
```shell
## 在Tomcat/bin 目录下， 修改catalina.sh 增加参数 -Ddd.jdbc.sql.obfuscation=true 
CATALINA_OPTS="$CATALINA_OPTS -javaagent:/path/to/ddtrace/dd-java-agent.jar -Ddd.jdbc.sql.obfuscation=true"; export CATALINA_OPTS
```

2. 命令行启动
``` shell
java -javaagent:/path/to/ddtrace/dd-java-agent.jar -Ddd.jdbc.sql.obfuscation=true ...  -jar yourApp.jar
```