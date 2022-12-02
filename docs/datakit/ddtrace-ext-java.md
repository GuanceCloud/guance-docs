# DDtrace 观测云版本

---

> *作者： 刘锐、宋龙奇*

## 简介 {#intro}

原生 DDTrace 对部分熟知的主流框架支持不够完善，我们在这个基础上，对其做了一些改进，以支持更多的主流框架和关键的数据追踪。

<div class="grid cards" markdown>

-   :material-language-java: __Java__

    ---

    [SDK :material-download:](https://static.guance.com/ddtrace/dd-java-agent.jar){:target="_blank"} ·
    [:material-github:](https://github.com/GuanceCloud/dd-trace-java){:target="_blank"} ·
    [Issue](https://github.com/GuanceCloud/dd-trace-java/issues/new){:target="_blank"} ·
    [:octicons-history-16:](https://github.com/GuanceCloud/dd-trace-java/releases){:target="_blank"}

</div>

## 更新历史 {#changelog}

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

## 更多阅读

- [datakit-ddtrace 采集器配置](ddtrace.md)
