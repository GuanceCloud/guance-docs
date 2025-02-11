---
title     : 'PinPoint Golang'
summary   : 'PinPoint Golang Integration'
__int_icon: 'icon/pinpoint'
tags      :
  - 'PINPOINT'
  - 'GOLANG'
  - 'Trace Link'
---

- [Pinpoint Golang Agent Code Repository](https://github.com/pinpoint-apm/pinpoint-go-agent){:target="_blank"}
- [Pinpoint Golang Code Examples](https://github.com/pinpoint-apm/pinpoint-go-agent/tree/main/example){:target="_blank"}
- [Pinpoint Golang Agent Configuration Documentation](https://github.com/pinpoint-apm/pinpoint-go-agent/blob/main/doc/config.md){:target="_blank"}

---

## Configure Datakit Agent {#config-datakit-agent}

Refer to [Configuring the Pinpoint Agent in Datakit](pinpoint.md#agent-config)

## Configure Pinpoint Golang Agent {#config-pinpoint-golang-agent}

The Pinpoint Golang Agent can be configured through various methods including command-line arguments, configuration files, environment variables, with the configuration priority from highest to lowest being:

- Command-line arguments
- Environment variables
- Configuration files
- Configuration functions
- Default configuration

The Pinpoint Golang Agent also supports runtime dynamic configuration changes. All configuration items marked as `dynamic` can be dynamically configured during runtime.

Basic parameter descriptions:

Each heading below represents a configuration item in the configuration file, and each description lists the corresponding command-line argument, environment variable, configuration function, value type, and additional information in order.

<!-- markdownlint-disable MD006 MD007 -->
`ConfigFile`

:   The configuration file supports [JSON](https://github.com/pinpoint-apm/pinpoint-go-agent/blob/main/example/pinpoint-config.json){:target="_blank"}, [YAML](https://github.com/pinpoint-apm/pinpoint-go-agent/blob/main/example/pinpoint-config.yaml){:target="_blank"}, and [Properties configuration files](https://github.com/pinpoint-apm/pinpoint-go-agent/blob/main/example/pinpoint-config.prop){:target="_blank"}. Configuration items in the configuration file are case-sensitive.

   - --pinpoint-configfile
   - PINPOINT_GO_CONFIGFILE
   - WithConfigFile()
   - string
   - case-sensitive

   For configuration fields separated by '.', they will appear indented in the configuration file. For example:

   ``` yaml
   applicationName: "MyAppName"
   collector:
     host: "collector.myhost.com"
   sampling:
     type: "percent"
     percentRate: 10
   logLevel: "error"
   ```

`ApplicationName`

:   ApplicationName configures the name of the application. If this item is not configured, the Agent will fail to start.

   - --pinpoint-applicationname
   - PINPOINT_GO_APPLICATIONNAME
   - WithAppName()
   - string
   - case-sensitive
   - max-length: 24

`ApplicationType`

:   ApplicationType configures the type of the application.

   - --pinpoint-applicationtype
   - PINPOINT_GO_APPLICATIONTYPE
   - WithAppType()
   - int
   - default: 1800 (ServiceTypeGoApp)

`AgentId`

:   AgentId is used to configure an ID to distinguish different Agents. It is recommended to include the hostname. If it is not configured or incorrectly configured, the Agent will use an auto-generated ID.

   - --pinpoint-agentid
   - PINPOINT_GO_AGENTID
   - WithAgentId()
   - string
   - case-sensitive
   - max-length: 24

`AgentName`

:   AgentName configures the name of the Agent.

   - --pinpoint-agentname
   - PINPOINT_GO_AGENTNAME
   - WithAgentName()
   - string
   - case-sensitive
   - max-length: 255

`Collector.Host`

:   Collector.Host configures the host address of the Pinpoint Collector.

   - --pinpoint-collector-host
   - PINPOINT_GO_COLLECTOR_HOST
   - WithCollectorHost()
   - string
   - default: "localhost"
   - case-sensitive

`Collector.AgentPort`

:   Collector.AgentPort configures the agent port number of the Pinpoint Collector.

   - --pinpoint-collector-agentport
   - PINPOINT_GO_COLLECTOR_AGENTPORT
   - WithCollectorAgentPort()
   - int
   - default: 9991 (default port for Datakit Pinpoint Agent is 9991)

`Collector.SpanPort`

:   Collector.SpanPort configures the span port number of the Pinpoint Collector.

   - --pinpoint-collector-spanport
   - PINPOINT_GO_COLLECTOR_SPANPORT
   - WithCollectorSpanPort()
   - int
   - default: 9993 (default port for Datakit Pinpoint Agent is 9991)

`Collector.StatPort`

:   Collector.StatPort configures the stat port number of the Pinpoint Collector.

   - --pinpoint-collector-statport
   - PINPOINT_GO_COLLECTOR_STATPORT
   - WithCollectorStatPort()
   - int
   - default: 9992 (default port for Datakit Pinpoint Agent is 9991)

`Sampling.Type`

:   Sampling.Type configures the sampler type, either "COUNTER" or "PERCENT".

   - --pinpoint-sampling-type
   - PINPOINT_GO_SAMPLING_TYPE
   - WithSamplingType()
   - string
   - default: "COUNTER"
   - case-insensitive
   - dynamic

`Sampling.CounterRate`

:   Sampling.CounterRate configures the counter sampler rate. The sampling rate is 1/rate. For example, if rate is set to 1, the sampling rate is 100%; if rate is set to 100, the sampling rate is 1%.

   - --pinpoint-sampling-counterrate
   - PINPOINT_GO_SAMPLING_COUNTERRATE
   - WithSamplingCounterRate()
   - int
   - default: 1
   - valid range: 0 ~ 100
   - dynamic

`Sampling.PercentRate`

:   Sampling.PercentRate configures the percentage sampler rate.

   - --pinpoint-sampling-percentrate
   - PINPOINT_GO_SAMPLING_PERCENTRATE
   - WithSamplingPercentRate()
   - float
   - default: 100
   - valid range: 0.01 ~ 100
   - dynamic

`Span.QueueSize`

:   Span.QueueSize configures the size of the Span Queue.

   - --pinpoint-span-queuesize
   - PINPOINT_GO_SPAN_QUEUESIZE
   - WithSpanQueueSize()
   - type: int
   - default: 1024

`Span.MaxCallStackDepth`

:   Span.MaxCallStackDepth configures the maximum depth of the call stack that Span can detect.

   - --pinpoint-span-maxcallstackdepth
   - PINPOINT_GO_SPAN_MAXCALLSTACKDEPTH
   - WithSpanMaxCallStackDepth()
   - type: int
   - default: 64
   - min: 2
   - ultimate: -1
   - dynamic

`Span.MaxCallStackSequence`

:   Span.MaxCallStackSequence configures the maximum length of the call stack sequence that Span can detect.

   - --pinpoint-span-maxcallstacksequence
   - PINPOINT_GO_SPAN_MAXCALLSTACKSEQUENCE
   - WithSpanMaxCallStackSequence()
   - type: int
   - default: 5000
   - min: 4
   - ultimate: -1
   - dynamic

`Stat.CollectInterval`

:   Stat.CollectInterval configures the collection frequency.

   - --pinpoint-stat-collectinterval
   - PINPOINT_GO_STAT_COLLECTINTERVAL
   - WithStatCollectInterval()
   - type: int
   - default: 5000
   - unit: milliseconds

`Stat.BatchCount`

:   Stat.BatchCount configures the number of statistical data points sent in batches.

   - --pinpoint-stat-batchcount
   - PINPOINT_GO_STAT_BATCHCOUNT
   - WithStatBatchCount()
   - type: int
   - default: 6

`Log.Level`

:   Log.Level configures the logging level for the Agent, must be one of trace/debug/info/warn/error.

   - --pinpoint-log-level
   - PINPOINT_GO_LOG_LEVEL
   - WithLogLevel()
   - type: string
   - default: "info"
   - case-insensitive
   - dynamic

`Log.Output`

:   Log.Output configures the log output, options are stderr/stdout/file path.

   - --pinpoint-log-output
   - PINPOINT_GO_LOG_OUTPUT
   - WithLogOutput()
   - type: string
   - default: "stderr"
   - case-insensitive
   - dynamic

`Log.MaxSize`

:   Log.MaxSize configures the maximum size of the log file.

   - --pinpoint-log-maxsize
   - PINPOINT_GO_LOG_MAXSIZE
   - WithLogMaxSize()
   - type: int
   - default: 10
   - dynamic

<!-- markdownlint-enable -->

## Manually Instrument Applications {#manual-instrumentation}

For languages with virtual machines such as JAVA, you can inject the instrumentation Agent directly into the virtual machine to enable automatic instrumentation. However, for compiled languages like Golang that run independently after compilation, manual instrumentation is required.

The Pinpoint Golang Agent supports two methods for manual instrumentation:

- Using the [Pinpoint Golang Plugin Library](https://github.com/pinpoint-apm/pinpoint-go-agent/tree/main/plugin){:target="_blank"}
- Using the Pinpoint Agent Golang API for manual instrumentation

<!-- markdownlint-disable MD006 MD007  MD038 -->
`Span`

:   In Pinpoint, a Span represents the top-level operation of a service or application, such as creating a Span within an HTTP handler:

   ```golang
   func doHandle(w http.ResponseWriter, r *http.Request) {
     tracer = pinpoint.GetAgent().NewSpanTracerWithReader("HTTP Server", r.URL.Path, r.Header)
     defer tracer.EndSpan()

     span := tracer.Span()
     span.SetEndPoint(r.Host)
   }
   ```

   You can instrument a single-call-stack application and generate a Span. Tracer.EndSpan() must be called to complete the Span and send it to the remote Collector. SpanRecorder and Annotation interfaces can be used to record trace data in the Span.

`SpanEvent`

:   Each SpanEvent in Pinpoint represents an operation within the scope of a Span, such as database access, function calls, or requests to another service. You can report a span using Tracer.NewSpanEvent() and must call Tracer.EndSpanEvent() to complete the span.

   ```golang
   func doHandle(w http.ResponseWriter, r *http.Request) {
       tracer := pinpoint.GetAgent().NewSpanTracerWithReader("HTTP Server", r.URL.Path, r.Header)
       defer tracer.EndSpan()

       span := tracer.Span()
       span.SetEndPoint(r.Host)
       defer tracer.NewSpanEvent("doHandle").EndSpanEvent()

       func() {
           defer tracer.NewSpanEvent("func_1").EndSpanEvent()

           func() {
               defer tracer.NewSpanEvent("func_2").EndSpanEvent()
               time.Sleep(100 * time.Millisecond)
           }()
           time.Sleep(1 * time.Second)
       }()
   }
   ```

`Distribute Tracing Context`

:   If a request comes from another node monitored by Pinpoint, the data exchange will contain a distributed context. Most of this data comes from the previous node and is packaged in the request message body. Pinpoint provides two functions to read and write the distributed context.

   - Tracer.Extract(reader DistributedTracingContextReader) // Extract the distributed context.
   - Tracer.Inject(writer DistributedTracingContextWriter) // Inject the context into the request.

   ```golang
   func externalRequest(tracer pinpoint.Tracer) int {
    req, err := http.NewRequest("GET", "http://localhost:9000/async_wrapper", nil)
    client := &http.Client{}

    tracer.NewSpanEvent("externalRequest")
    defer tracer.EndSpanEvent()

    se := tracer.SpanEvent()
    se.SetEndPoint(req.Host)
    se.SetDestination(req.Host)
    se.SetServiceType(pinpoint.ServiceTypeGoHttpClient)
    se.Annotations().AppendString(pinpoint.AnnotationHttpUrl, req.URL.String())
    tracer.Inject(req.Header)

    resp, err := client.Do(req)
    defer resp.Body.Close()

    tracer.SpanEvent().SetError(err)
    return resp.StatusCode
   }
   ```

`Passing Context Between Function Calls`

:   Passing the tracing context between different APIs within the same service and between different processes is achieved by operating on context.Context. The Pinpoint Golang Agent injects the Tracer into the Context to link the contexts.

   - NewContext() // Inject Tracer into Context.
   - FromContext() // Import a Tracer.

   ```golang
   func tableCount(w http.ResponseWriter, r *http.Request) {
    tracer := pinpoint.FromContext(r.Context())

    db, err := sql.Open("mysql-pinpoint", "root:p123@tcp(127.0.0.1:3306)/information_schema")
    defer db.Close()

    ctx := pinpoint.NewContext(context.Background(), tracer)
    row := db.QueryRowContext(ctx, "SELECT count(*) from tables")
    var count int
    row.Scan(&count)

    fmt.Println("number of tables in information_schema", count)
   }
   ```

`Instrumenting Goroutines`

:   The Pinpoint Tracer is designed to instrument single-call-stack applications, so sharing the same Tracer across different threads can cause resource contention and program crashes. You can create a new Tracer to instrument Goroutines by calling Tracer.NewGoroutineTracer().

   Passing the Tracer between threads can be done in several ways:

   - Function parameter

      ```golang
      func outGoingRequest(ctx context.Context) {
        client := pphttp.WrapClient(nil)

        request, _ := http.NewRequest("GET", "https://github.com/pinpoint-apm/pinpoint-go-agent", nil)
        request = request.WithContext(ctx)

        resp, err := client.Do(request)
        if nil != err {
            log.Println(err.Error())
            return
        }
        defer resp.Body.Close()
        log.Println(resp.Body)
      }

      func asyncWithTracer(w http.ResponseWriter, r *http.Request) {
          tracer := pinpoint.FromContext(r.Context())
          wg := &sync.WaitGroup{}
          wg.Add(1)

          go func(asyncTracer pinpoint.Tracer) {
              defer wg.Done()

              defer asyncTracer.EndSpan() // must be called
              defer asyncTracer.NewSpanEvent("asyncWithTracer_goroutine").EndSpanEvent()

              ctx := pinpoint.NewContext(context.Background(), asyncTracer)
              outGoingRequest(w, ctx)
          }(tracer.NewGoroutineTracer())

          wg.Wait()
      }
      ```

   - Channel

      ```golang
      func asyncWithChan(w http.ResponseWriter, r *http.Request) {
          tracer := pinpoint.FromContext(r.Context())
          wg := &sync.WaitGroup{}
          wg.Add(1)

          ch := make(chan pinpoint.Tracer)

          go func() {
              defer wg.Done()

              asyncTracer := <-ch
              defer asyncTracer.EndSpan() // must be called
              defer asyncTracer.NewSpanEvent("asyncWithChan_goroutine").EndSpanEvent()

              ctx := pinpoint.NewContext(context.Background(), asyncTracer)
              outGoingRequest(w, ctx)
          }()

          ch <- tracer.NewGoroutineTracer()
          wg.Wait()
      }
      ```

   - context.Context

      ```golang
      func asyncWithContext(w http.ResponseWriter, r *http.Request) {
          tracer := pinpoint.FromContext(r.Context())
          wg := &sync.WaitGroup{}
          wg.Add(1)

          go func(asyncCtx context.Context) {
              defer wg.Done()

              asyncTracer := pinpoint.FromContext(asyncCtx)
              defer asyncTracer.EndSpan() // must be called
              defer asyncTracer.NewSpanEvent("asyncWithContext_goroutine").EndSpanEvent()

              ctx := pinpoint.NewContext(context.Background(), asyncTracer)
              outGoingRequest(w, ctx)
          }(pinpoint.NewContext(context.Background(), tracer.NewGoroutineTracer()))

          wg.Wait()
      }
      ```
<!-- markdownlint-enable -->