# 巧用火焰图分析链路性能
---

本文旨在帮助您了解什么是全链路追踪以及如何使用工具来分析链路中性能瓶颈。

## 基本概念及工具

- 全链路（Trace）追踪
- 分析工具
    - 火焰图
    - Span 列表
    - 服务调用关系图
- 持续时间 / 执行时间

## 全链路追踪

一般来说，单个追踪（Trace）由各个 Span 构成，是一棵树或有向无环图（DAG），每一个 Span 代表 Trace 中被命名并计时的连续性的执行片段，如下图所示。因为 Span 的核心是记录对应程序执行片段的开始时间和结束时间，而程序执行片段之间存在调用的父子关系，因而 Span 逻辑上形成树状结构。

注意：span 的父子关系可以通过子 span 的 parent_id 等于父 Span 的 span_id 来关联

![](../images/flame/flame_graph.001.png)

### 火焰图

火焰图（Flame Graph）是由 Linux 性能优化大师 Brendan Gregg 发明的用于分析性能瓶颈的可视化图表，火焰图以一个全局的视野来看待时间分布，它从顶部往底部列出所有可能导致性能瓶颈 Span。

#### 绘制逻辑

- 纵轴（Y轴）代表调用 Span 的层级深度，用于表示程序执行片段之间的调用关系：上面的 Span 是下面 Span 的父 Span（数据上也可以通过子 span 的 parent_id 等于父 Span 的 span_id 来关联来对应）。
- 横轴（X轴）代表单个 Trace 下 Span 的持续时间（duration），一个格子的宽度越大，越说明该 Span 的从开始到结束的持续时间较长，可能是造成性能瓶颈的原因。

![](../images/flame/flame_graph.002.png)

#### 显示说明

**火焰图**

- 火焰图上的每个 Span 格子的颜色都对应其服务（service）的颜色。

```
所以从火焰图上很直观的可以感知当前的 Trace 中涉及到有哪些服务请求在执行。（服务的颜色生成逻辑：用户登录到工作空间访问应用性能监测模块时，{{{ custom_key.brand_name }}}会根据服务名称自动生成颜色，该颜色的集成会继承到链路查看器等分析页面）
```

- Span 块默认显示：当前 Span 的资源（resource）或操作（operation）、持续时间（duration）以及是否存在错误（status = error）
- 每个 Span 提示都会显示当前 Span 对应的 资源（resource）、持续时间（duration）以及整体耗时占比

**服务列表**

火焰图右侧的服务列表显示当前 Trace 内发生请求调用的服务名称、颜色及该服务执行占总执行时间的比率。

注意：服务名称显示为 None 的情况则表示当前 trace 未找到 parent_id = 0 的顶层 Span

#### 交互说明

![](../images/flame/flame_graph.003.png)

1. 全屏查看/恢复默认大小：点击链路详情右上角全屏查看图标，横向展开查看链路火焰图，点击恢复默认大小图标，即可恢复详情页；
2. 展开/收起小地图：点击链路详情左侧展开/收起小地图图标，通过在小地图上选择区间、拖拽、滚动来快捷查看火焰图；
3. 查看全局 Trace ：点击链路详情左侧查看全局 Trace 图标，在火焰图查看全局链路；
4. 收起下方 Tab 详情：点击收起按钮，下方 Tab 详情页展示区域收起；
5. 双击 Span ：在火焰图中间放大展示该 Span，您可以快速定位查看其上下文关联 Span ；
6. 点击右侧服务名称：高亮展示对应 Span，再次点击服务名称，恢复默认全选 Span ，您可以通过点击服务名称，快速筛选查看服务对应的 Span。

#### 特别说明

由于多线程或者存在异步任务等原因，所以火焰图在实际绘图时会遇到 span 之间的关系可以如下：

- 同属于一个 parent 的兄弟 span 间可能重叠

![](../images/flame/flame_graph.004.png)

因为存在 Span 重叠的情况，为了能更直观的看到每个 Span 及子 Span的执行情况，我们前端在绘制火焰图的时候做了一些显示处理，即根据 时间 + 空间维度计算 Span 及子 Span 在完全不遮挡情况下显示的位置。

示例1：

正常 Trace，同层级 Span 时间上不重叠，但跟下属子 Span 时间有重叠，通过连线的形式关联父子 Span 之间的关系，下面子 Span 存在连线的时候也是按照该逻辑做绘图处理。

![](../images/flame/flame_graph.005.png)

示例 2：

异常 Trace，仍然存在同层级 Span 时间上重叠，但是因为实际数据里发现 Trace 的 顶层 Span（parent_id = 0）的开始时间（start）大于子 Span 的开始时间。

![](../images/flame/flame_graph.006.gif)

分析逻辑：

按照链路中根据程序执行的父子关系判断，父 Span 的开始时间一定是小于子 Span的开始时间的，所以看到该火焰图的显示后，发现父 Span 跟子 Span 的服务不是一个时，可以判断两个服务所在服务器的系统时间可能存在不一致的情况，需要先去校验校准后再来分析实际的性能瓶颈。

### Span 列表

#### 显示说明

**列表全收起状态**

![](../images/flame/flame_graph.007.png)

- 列1：显示服务类型、服务名称、服务颜色及当前服务下是否存在 status = error 的 Span
- 列2：显示当前服务下面的 Span 数量
- 列3：显示当前服务下 Span 持续时间（duration）的平均值
- 列4：显示当前服务下 Span 的执行时间总和
- 列5：显示当前服务的执行时间占总执行时间的比例

**服务行展开显示**

![](../images/flame/flame_graph.008.png)

- 列1：显示资源名称（resource）、对应服务颜色及当前 span 是否存在 status = error
- 列2：空
- 列3：显示当前 Span 持续时间（duration）
- 列4：显示当前 Span 的执行时间
- 列5：显示当前Span 的执行时间占总执行时间的比例

#### 交互说明

- 搜索：支持资源名称（resource）模糊搜索
- 支持选中 Span 后切换到火焰图查看对应 Span 的上下文关系

![](../images/flame/flame_graph.009.gif)

### 服务调用关系图

#### 显示说明

显示当前 trace 下的服务之间的调用关系拓扑

- 支持按资源名称（resource）模糊匹配，定位某个资源的上下游服务调用关系
- 服务 hover 后显示：当前服务下的 Span 数量、服务执行时间及占比

![](../images/flame/flame_graph.010.png)

### 持续时间

Span 对应程序执行片段的开始时间和结束时间，一般在 Trace 的数据中用 duration 字段来做标记。

### 执行时间

上述的特别说明中有提及到可能会存在父子 Span 的结束时间不一致的情况，那么执行时间则参考以下逻辑计算得出。

#### Span 执行时间

1.子 span 可能在父 span 结束后才结束

![](../images/flame/flame_graph.011.png)

子 Span 的执行时间 = Children 的 duration

总执行时间 = Children 的结束时间 - Parent 的开始时间

父 Span 的执行时间 = 总执行时间 - 子 Span 的执行时间

2.子 span 可能在父 span 结束后才开始

![](../images/flame/flame_graph.012.png)

子 Span 的执行时间 = Children 的 duration

总执行时间 = Children 的结束时间 - Parent 的开始时间

父 Span 的执行时间 = 总执行时间 - 子 Span 的执行时间

3.同属于一个 parent 的兄弟 span 间可能重叠

![](../images/flame/flame_graph.013.png)

父 Span 执行时间 = p(1) +p(2)

Children 1 Span 执行时间 = c1(1) + c1(2)

Children 2 Span 执行时间 = c2(1) + c2(2)

注意：因为 Children 1 Span、Children 2 Span 实际执行中时间上存在部分重叠，所以这部分时间由两个 Span 平分。

**示例说明**

同步任务情况下，Span 按照 "Span1开始->Span1结束->Span2开始->Span2结束->..."顺序执行时，每个 Span 的执行时间及对应父 Span 的执行时间计算如下：

示例1：

父 Span = Couldcare SPAN1

子 Span = MyDQL SPAN2、MyDQL SPAN3、MyDQL SPAN4、MyDQL SPAN5、MyDQL SPAN6、MyDQL SPAN7、MyDQL SPAN8、MyDQL SPAN9、MyDQL SPAN10、MyDQL SPAN11

计算分析：

因为所有的子 Span 都没有再下层级的子 Span，所以下图所有的子 Span 的执行时间等于他们的 Span 持续时间。父 Span 因为下面存在子 Span 的调用所以实际父 Span 的执行时间需要通过父 Span 的持续时间减去所有子 Span 的执行时间获得。

![](../images/flame/flame_graph.014.png)

#### 服务执行时间

每个服务的执行时间 = Trace 内所有属于该服务的 Span 执行时间总和

#### 总执行时间

总执行时间 = Trace 内 Span 最后结束的时间 - Span 最开始的时间

## 链路查看分析场景示例

### 采集器配置（主机安装）

进入 DataKit 安装目录下的 conf.d/ddtrace 目录，复制 ddtrace.conf.sample 并命名为 ddtrace.conf。示例如下：

??? quote "`ddtrace.conf` 示例"

    ```Shell
    [[inputs.ddtrace]]
      ## DDTrace Agent endpoints register by version respectively.
      ## Endpoints can be skipped listen by remove them from the list.
      ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
      endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]

      ## customer_tags is a list of keys contains keys set by client code like span.SetTag(key, value)
      ## that want to send to data center. Those keys set by client code will take precedence over
      ## keys in [inputs.ddtrace.tags]. DOT(.) IN KEY WILL BE REPLACED BY DASH(_) WHEN SENDING.
      # customer_tags = ["key1", "key2", ...]

      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough(not presend in 1 hour), those resource will always send
      ## to data center and do not consider samplers and filters.
      # keep_rare_resource = false

      ## By default every error presents in span will be send to data center and omit any filters or
      ## sampler. If you want to get rid of some error status, you can set the error status list here.
      # omit_err_status = ["404"]

      ## Ignore tracing resources map like service:[resources...].
      ## The service name is the full service name in current application.
      ## The resource list is regular expressions uses to block resource names.
      ## If you want to block some resources universally under all services, you can set the
      ## service name as "*". Note: double quotes "" cannot be omitted.
      # [inputs.ddtrace.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...

      ## Sampler config uses to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.ddtrace.sampler]
        # sampling_rate = 1.0

      # [inputs.ddtrace.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...

      ## Threads config controls how many goroutines an agent cloud start.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number fo goroutines at running time.
      # [inputs.ddtrace.threads]
        # buffer = 100
        # threads = 8

      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.ddtrace.storage]
        # path = "./ddtrace_storage"
        # capacity = 5120
    ```

配置好后，[重启 DataKit](../../datakit/datakit-service-how-to.md#manage-service) 即可。

#### HTTP 设置

如果 Trace 数据是跨机器发送过来的，那么需要设置 [DataKit 的 HTTP 设置](../../datakit/datakit-conf.md#config-http-server)。

如果有 ddtrace 数据发送给 DataKit，那么在 [DataKit 的 monitor](../../datakit/datakit-monitor.md) 上能看到：

![](../images/flame/flame_graph.015.png)

*DDtrace 将数据发送给了 /v0.4/traces 接口*

### SDK 接入（Go 示例）

#### 安装依赖

安装 ddtrace golang library 在开发目录下运行

```shell
go get -v github.com/DataDog/dd-trace-go
```

#### 设置 DataKit

需先[安装](../../datakit/datakit-install.md)、[启动 datakit](../../datakit/datakit-service-how-to.md)，并开启 [ddtrace 采集器](../../integrations/ddtrace.md#config)

#### 代码示例

以下代码演示了一个文件打开操作的 trace 数据收集。

在 main() 入口代码中，设置好基本的 trace 参数，并启动 trace：

??? quote "示例如下"

    ```Go
    package main

    import (
        "io/ioutil"
        "os"
        "time"

        "gopkg.in/DataDog/dd-trace-go.v1/ddtrace/ext"
        "gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer"
    )

    func main() {
        tracer.Start(
            tracer.WithEnv("prod"),
            tracer.WithService("test-file-read"),
            tracer.WithServiceVersion("1.2.3"),
            tracer.WithGlobalTag("project", "add-ddtrace-in-golang-project"),
        )

        // end of app exit, make sure tracer stopped
        defer tracer.Stop()

        tick := time.NewTicker(time.Second)
        defer tick.Stop()

        // your-app-main-entry...
        for {
            runApp()
            runAppWithError()

            select {
            case <-tick.C:
            }
        }
    }

    func runApp() {
        var err error
        // Start a root span.
        span := tracer.StartSpan("get.data")
        defer span.Finish(tracer.WithError(err))

        // Create a child of it, computing the time needed to read a file.
        child := tracer.StartSpan("read.file", tracer.ChildOf(span.Context()))
        child.SetTag(ext.ResourceName, os.Args[0])

        // Perform an operation.
        var bts []byte
        bts, err = ioutil.ReadFile(os.Args[0])
        span.SetTag("file_len", len(bts))
        child.Finish(tracer.WithError(err))
    }
    ```

#### 编译运行

Linux/Mac 环境：

```Shell
go build main.go -o my-app
DD_AGENT_HOST=localhost DD_TRACE_AGENT_PORT=9529 ./my-app
```

Windows 环境：

```Shell
go build main.go -o my-app.exe
$env:DD_AGENT_HOST="localhost"; $env:DD_TRACE_AGENT_PORT="9529"; .\my-app.exe
```

程序运行一段时间后，即可在{{{ custom_key.brand_name }}}看到类似如下 trace 数据：

![](../images/flame/flame_graph.016.png)

*Golang 程序 trace 数据展示*

#### 支持的环境变量

以下环境变量支持在启动程序的时候指定 ddtrace 的一些配置参数，其基本形式为：

```Shell
DD_XXX=<env-value> DD_YYY=<env-value> ./my-app
```

**注意事项**：这些环境变量将会被代码中用 WithXXX() 注入的对应字段覆盖，故代码注入的配置，优先级更高，这些 ENV 只有在代码未指定对应字段时才生效。

| **Key**                 | **默认值** | **说明**                                                     |
| :---------------------- | :--------- | :----------------------------------------------------------- |
| DD_VERSION              | -          | 设置应用程序版本，如 *1.2.3*、*2022.02.13*                   |
| DD_SERVICE              | -          | 设置应用服务名                                               |
| DD_ENV                  | -          | 设置应用当前的环境，如 prod、pre-prod 等                     |
| DD_AGENT_HOST           | localhost  | 设置 DataKit 的 IP 地址，应用产生的 trace 数据将发送给 DataKit |
| DD_TRACE_AGENT_PORT     | -          | 设置 DataKit trace 数据的接收端口。这里需手动指定 [DataKit 的 HTTP 端口](https://docs.guance.com/datakit/datakit-conf/#config-http-server)（一般为 9529） |
| DD_DOGSTATSD_PORT       | -          | 如果要接收 ddtrace 产生的 statsd 数据，需在 DataKit 上手动开启 [statsd 采集器](https://docs.guance.com/datakit/statsd/) |
| DD_TRACE_SAMPLING_RULES | -          | 这里用 JSON 数组来表示采样设置（采样率应用以数组顺序为准），其中 sample_rate 为采样率，取值范围为 [0.0, 1.0]。 **示例一**：设置全局采样率为 20%：DD_TRACE_SAMPLE_RATE='[{"sample_rate": 0.2}]' ./my-app **示例二**：服务名通配 app1.*、且 span 名称为 abc的，将采样率设置为 10%，除此之外，采样率设置为 20%：DD_TRACE_SAMPLE_RATE='[{"service": "app1.*", "name": "b", "sample_rate": 0.1}, {"sample_rate": 0.2}]' ./my-app |
| DD_TRACE_SAMPLE_RATE    | -          | 开启上面的采样率开关                                         |
| DD_TRACE_RATE_LIMIT     | -          | 设置每个 golang 进程每秒钟的 span 采样数。如果 DD_TRACE_SAMPLE_RATE 已经打开，则默认为 100 |
| DD_TAGS                 | -          | 这里可注入一组全局 tag，这些 tag 会出现在每个 span 和 profile 数据中。多个 tag 之间可以用空格和英文逗号分割，例如 layer:api,team:intake、layer:api team:intake |
| DD_TRACE_STARTUP_LOGS   | true       | 开启 ddtrace 有关的配置和诊断日志                            |
| DD_TRACE_DEBUG          | false      | 开启 ddtrace 有关的调试日志                                  |
| DD_TRACE_ENABLED        | true       | 开启 trace 开关。如果手动将该开关关闭，则不会产生任何 trace 数据 |
| DD_SERVICE_MAPPING      | -          | 动态重命名服务名，各个服务名映射之间可用空格和英文逗号分割，如 mysql:mysql-service-name,postgres:postgres-service-name，mysql:mysql-service-name postgres:postgres-service-name |

### 实际链路数据分析

1.登录{{{ custom_key.brand_name }}}工作空间，查看应用性能监测模块的服务列表，从服务页面已经可以看出 browser 服务的 P90 响应时间是比较长的。

![](../images/flame/flame_graph.017.png)

2.点击 browser 服务名称，查看该服务的概览分析视图，可以看出影响当前服务响应时间的最关键的资源是 query_data 这个接口，因为这个接口是{{{ custom_key.brand_name }}}的一个数据查询接口，所以接下来我们看下这个接口在查询过程当中，到底是因为什么导致耗时较长。

![](../images/flame/flame_graph.018.png)

3.点击资源名称，跳转到查看器，通过点击 持续时间 倒序查看响应时间的最大值。

![](../images/flame/flame_graph.019.png)

4.点击 Span 数据，查看分析当前 Span 在整个链路里面的执行性能和其他相关信息。

![](../images/flame/flame_graph.020.png)

5.点击右上角 [全屏] 模式按钮，放大查看火焰图相关信息。结合整体链路查看，可以看出 browser服务在整个链路中的执行时间占比高达 96.26%，从 Span 列表也可以得出此结论。根据火焰图的占比和对应的链路详情信息，我们可以总和得出 browser 的这个 query_data Span 在整个执行过程中可以看到 resource_ttfb（资源加载请求响应时间）耗时 400 多毫秒， resource_first_byte（资源加载首包时间）耗时 1.46 秒，再结合查看 province 的地理位置定位是 Singapore（新加坡），而我们的站点部署在杭州节点，则可以得出是因为地理位置问题导致数据传输的时间变长从而影响了整个的耗时。

![](../images/flame/flame_graph.021.png)

![](../images/flame/flame_graph.022.png)
