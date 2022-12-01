# DDtrace 观测云版本

---

> *作者： 刘锐、宋龙奇*

## 简介
观测云在使用`dd-trace-java`过程中有些功能源码并没有提供，遂决定在源码的基础上进行开发。

开源地址：[GuanceCloud-ddtrace](https://github.com/GuanceCloud/dd-trace-java)， 并持续更新。如您在使用过程中有任务问题或有好的建议可在 [github 上提 Issue](https://github.com/GuanceCloud/dd-trace-java/issues) 或者联系对接人员。 

### 下载
请使用 github 下载

~~ [最新版本下载地址](https://static.guance.com/ddtrace/dd-java-agent.jar) ~~

[观测云 github-releases](https://github.com/GuanceCloud/dd-trace-java/releases)

## 更多

在使用 dd-trace-java 之前，您可事先了解:

- [datakit-ddtrace 采集器配置](../datakit/ddtrace.md)
- [ddtrace 配置](../best-practices/monitoring/apm.md#ddtrace) 
- [ddtrace 高级用法](../integrations/apm/ddtrace/index.md)
- [DDtrace 自定义 Instrumentation](../best-practices/monitoring/ddtrace-instrumentation.md)

---
## 历史版本：

### (2022-10-25) Version:0.113.0

- [github下载地址](https://github.com/GuanceCloud/dd-trace-java/releases/tag/v0.113.0-guance)

#### 功能调整说明

- 以0.113.0 tag 为基准，合并之前的代码

- 修复thrift TMultipexedProtocol 模型支持

---

### (2022-10-14) Version:0.108.1

合并 DataDog v0.108.1版本，进行编译同时保留了0.108.1

- [github下载地址](https://github.com/GuanceCloud/dd-trace-java/releases/tag/v0.108.1)

#### 功能调整说明

- 新增 thrift instrumentation（thrift version >=0.9.3 以上版本）

---

### (2022-09-06) Version:0.108.1

合并 DataDog v0.108.1版本，进行编译。

- [github下载地址](https://github.com/GuanceCloud/dd-trace-java/releases/tag/v0.108.1)


#### 功能调整说明

- 增加 xxl_job 探针( xxl_job 版本 >= 2.3.0)

---


### (2022-08-30) Version:guance-0.107.0

合并 DataDog 107 版本，进行编译。

- [github下载地址](https://github.com/GuanceCloud/dd-trace-java/releases/tag/guance-107)


---

### (2022-08-23) Version:guance-0.105.0

[当前版本下载地址](https://static.guance.com/ddtrace/dd-java-agent-guance-0.106.0-SNAPSHOT.jar)

#### 功能调整说明

- 增加 RocketMq 探针 支持的版本(不低于4.8.0)。
- 增加 Dubbo 探针 支持的版本(不低于2.7.0)。
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