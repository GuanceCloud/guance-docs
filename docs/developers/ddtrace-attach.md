# 自动注入 DDTrace-Java Agent

-----

*Author： 宋龙奇*

---

本 Java 工具主要用于将 DDTrace-java agent 注入到当前已经运行的 Java 进程中，无需手动配置和重启宿主 Java 进程。

目前项目已经发布在 [GuanceCloud-github](https://github.com/GuanceCloud/agent-attach-java)，欢迎[提交 Issue](https://github.com/GuanceCloud/agent-attach-java/issues/new)。

## 原理 {#principle}

Agent 注入的基本原理是通过 */proc/<Java-PID>*（或者 */tmp/*）目录下的一个文件，注入 `load instrument dd-agent.jar=<params...>`，再给 JVM 一个发送一个 SIGQUIT 信号，然后 JVM 就会读取指定的 agent jar 包。

## 下载 {#download}

源码编译:

```shell
git clone https://github.com/GuanceCloud/agent-attach-java
mvn package
```

运行 jar 包，可去 [release 页面](https://github.com/GuanceCloud/agent-attach-java/releases){:target="_blank"} 找到最新的 jar 包：

```shell
java -jar agent-attach-java.jar
```

## 动态注入 dd-java-agent.jar

1. 首先下载[最新的 dd-java-agent.jar](https://github.com/GuanceCloud/dd-trace-java/releases){:target="_blank"}，并放到 */usr/local/ddtrace/* 目录下。

```shell
mkdir -p /usr/local/ddtrace
cd /usr/local/ddtrace
wget https://github.com/GuanceCloud/dd-trace-java/releases/download/v0.113.0-attach/dd-java-agent.jar
```

???+ attention

    必须使用 GuanceCloud 的 dd-trace-java，否则自动注入功能受限（各种 Trace 参数无法设置）。

1. 启动 Java 应用（如果 Java 应用已启动，则忽略）

1. 启动 agent-attach-java.jar 注入 dd-trace-java.jar

```shell
java -jar agent-attach-java.jar -options "dd.agent.port=9529"
```

命令的参数有：

<!-- options download agent-jar 没有的话 都是默认值 -->
<!-- - download：下个版本(指定版本下载) -- >

- `options`：dd-java-agent [有关的参数](../datakit/ddtrace-java.md#start-options)
- `agent-jar`： dd-java-agent 绝对路径，默认为 */usr/local/ddtrace/dd-java-agent.jar*
