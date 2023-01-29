---
icon: material/language-go
---
# Go

---

## 视图预览

![image](../imgs/input-ddtrace-golang-1.png)

![image](../imgs/input-ddtrace-golang-2.png)

![image](../imgs/input-ddtrace-golang-3.png)

![image](../imgs/input-ddtrace-golang-4.png)

![image](../imgs/input-ddtrace-golang-5.png)

![image](../imgs/input-ddtrace-golang-6.png)

### 前置条件

- 需要进行链路追踪的应用服务器<[安装 DataKit](../../datakit/datakit-install.md)>

### Go Redis APM 完整示例

这里以 Go 中访问 Redis 并 Set 数据为例。示例中引用 go-redis 后引用 ddtrace redis 进行覆盖并且引用 ddtrace 进行 trace 数据收集上报。

首先开启 Tracer 设置上报地址和服务名称以及版本号等信息然后创建新的根 span(StartSpanFromContext) 进行 trace 写入发送 trace(WithContext) 数据并结束 span(Finish) 完成一次 trace 数据写入并上报。

> 更多 ddtrace 使用请参考：[https://pkg.go.dev/gopkg.in/DataDog/dd-trace-go.v1/ddtrace](https://pkg.go.dev/gopkg.in/DataDog/dd-trace-go.v1/ddtrace) <br/>
更多 ddtrace 类库案例请参考：[https://github.com/DataDog/dd-trace-go/tree/v1/contrib](https://github.com/DataDog/dd-trace-go/tree/v1/contrib)

```go
package main

import (
        "context"

        "github.com/go-redis/redis"

        redistrace "gopkg.in/DataDog/dd-trace-go.v1/contrib/go-redis/redis"
        "gopkg.in/DataDog/dd-trace-go.v1/ddtrace/ext"
        "gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer"
)

// To start tracing Redis, simply create a new client using the library and continue
// using as you normally would.
func main() {
        tracer.Start(
                tracer.WithEnv("prod"),
                tracer.WithService("go_gin"),
                tracer.WithServiceVersion("v1"),
                tracer.WithAgentAddr("0.0.0.0:9529"),
        )
        defer tracer.Stop()
        // create a new Client
        opts := &redis.Options{Addr: "xxx.xxx.xxx.xxx", Password: "xxxxxx", DB: x}
        c := redistrace.NewClient(opts)

        // any action emits a span
        c.Set("test_key2", "test_value2", 0)

        // optionally, create a new root span
        root, ctx := tracer.StartSpanFromContext(context.Background(), "parent.request",
                tracer.SpanType(ext.SpanTypeRedis),
                tracer.ServiceName("go_gin"),
                tracer.ResourceName("/home"),
        )

        // set the context on the client
        c = c.WithContext(ctx)

        // commit further commands, which will inherit from the parent in the context.
        c.Set("food1", "cheese1", 0)
        root.Finish()
}

// You can also trace Redis Pipelines. Simply use as usual and the traces will be
// automatically picked up by the underlying implementation.
```

#### 可以通过 [DQL](../../dql/define.md) 验证上报的数据：

```shell
dql > T::go_gin LIMIT 1
-----------------[ 1.go_gin ]-----------------
    span_id '5548104073514274807'
  span_type 'entry'
create_time 1631502841700
       time 2021-09-13 11:13:59 +0800 CST
  parent_id '0'
    service 'go_gin'
     source 'ddtrace'
   trace_id '5548104073514274807'
       type 'cache'
    version 'v1'
    __docid 'T_c4vc3u95h8a1t7kvnh50'
        env 'prod'
   resource '/home'
    date_ns 348059
       host 'solrserver.lianglab.cn'
     status 'ok'
      start 1631502839178348
   duration 37
    message '{"service":"go_gin","name":"parent.request","resource":"/home","trace_id":5548104073514274807,"span_id":5548104073514274807,"parent_id":0,"start":1631502839178348059,"duration":37960,"error":0,"meta":{"env":"prod","runtime-id":"7bb7e7da-0de8-424d-b3d0-cac81a4e4d4f","system.pid":"1992280","version":"v1"},"metrics":{"_dd.agent_psr":1,"_dd.top_level":1,"_sampling_priority_v1":1},"type":"redis"}'
  operation 'parent.request'
---------
1 rows, cost 2ms
```

#### 链路分析

<[服务](../../application-performance-monitoring/service.md)><br />
<[链路分析](../../application-performance-monitoring/explorer.md)>

## 场景视图

观测云平台已内置 应用性能监测模块，无需手动创建

## 监控规则

暂无

## 相关术语说明

<[链路追踪-字段说明](../../../application-performance-monitoring/collection)>

## 最佳实践

<[链路追踪（APM）最佳实践](../../best-practices/monitoring/apm.md)>

## 故障排查

暂无
