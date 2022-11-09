# ddtrace 采样

---

???+ attention

    **当前案例使用 ddtrace 版本`0.114.0`（最新版本）进行测试**

## 采集器 ddtrace.conf 采样部分配置

```toml
  ## Sampler config uses to set global sampling strategy.
  ## sampling_rate used to set global sampling rate.
  [inputs.ddtrace.sampler]
    sampling_rate = 0.1
```

## 测试脚本
```shell
for ((i=1;i<=100;i++)); 
do
	curl http://localhost:8080/counter
done
```

## 采集器端开启采样

`sampling_rate`范围 (0,1)，不在范围内，trace 丢弃。如果需要全采，则不需要配置`[inputs.ddtrace.sampler]`


## 应用端开启采样

应用端通过`-Ddd.trace.sample.rate`开启采样，范围为(0,1)。属于标记采样，即 trace 全采，同时进行采样标记。

## 采样优先级

两种采样方式效果一样，如果同时配置，则采集器端开启采样不生效。即

???+ note "总结"

    `-Ddd.trace.sample.rate`  > `sampling_rate`


## 参考文档
[ddtrace 高级用法](ddtrace-skill.md)

[demo 源码地址](https://github.com/lrwh/observable-demo/tree/main/springboot-ddtrace-server)

[ddtrace启动参数](/datakit/ddtrace-java/#start-options)
