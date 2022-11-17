# ddtrace-attach

> *作者： 宋龙奇*
-----

目前项目已经发布在 [GuanceCloud-github](https://github.com/GuanceCloud/agent-attach-java),如果您有需求可以提 Issue.


## 原理
Attach 根本原理是使用文件 Socket 通讯, 就是往一个文件中写入 `load instrument xxx.jar=params`, 再给 jvm 一个 SIGQUIT 信号, 之后 jvm 读取 socket 文件, 加载对应的 agent. 

## 下载
源码编译:
```shell
git clone https://github.com/GuanceCloud/agent-attach-java
mvn  package
```

运行 jar 包
```shell
# 下载 最新版 https://github.com/GuanceCloud/agent-attach-java/releases
java -jar agent-attach-java.jar
```


## 如何在 jvm 运行时动态添加 agent
1. 首先下载***指定***的 ddtrace , 并放到 /usr/local/ddtrace/
```shell
mkdir -p /usr/local/ddtrace
cd /usr/local/ddtrace
wget https://github.com/GuanceCloud/dd-trace-java/releases/download/v0.113.0-attach/dd-java-agent.jar

```
> 注意: 必须使用 GuanceCloud 的 dd-trace-java, 因为会出现参数无法传递的问题. 

2. 启动 java 程序
3. 启动 agent-attach-java.jar
```shell
# 命令的参数有三个 options download agent-jar 没有的话 都是默认值
# options=""
# download ="" 下个版本(指定版本下载)
# agent-jar="/usr/local/ddtrace/dd-java-agent.jar" 
java -jar agent-attach-java.jar -options "dd.agent.port=9529"

```