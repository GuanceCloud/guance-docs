# ddtrace 高级用法

---

> *作者： 刘锐*

???+ attention

    **当前案例使用 ddtrace 版本`0.114.0`（最新版本）进行测试**

	

## DataKit ddtrace 采集器开启

开启 [ddtrace 采集器](/datakit/ddtrace/)

## 准备 Shell

```shell
java -javaagent:D:/ddtrace/dd-java-agent-0.114.0.jar \
-Ddd.service=ddtrace-server \
-Ddd.agent.port=9529 \
-jar springboot-ddtrace-server.jar
```

## 参数用法

参见：[ddtrace 常见参数用法](ddtrace-skill-param.md)


## 侵入式埋点

参见：[ddtrace-api 使用指南](ddtrace-skill-ddtrace-api.md)

## 采样

参见：[ddtrace 采样](ddtrace-skill-sampling.md)

## Log

参见：[ddtrace log 关联](ddtrace-skill-log.md)

## 参考文档

[demo 源码地址](https://github.com/lrwh/observable-demo/tree/main/springboot-ddtrace-server)

[ddtrace启动参数](/datakit/ddtrace-java/#start-options)

[ddtrace java 参数文档 ](https://docs.datadoghq.com/tracing/setup_overview/setup/java/)

