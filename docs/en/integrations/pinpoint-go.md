---
title     : 'PinPoint Golang'
summary   : 'PinPoint Golang Integration'
__int_icon: 'icon/pinpoint'
tags      :
  - 'PINPOINT'
  - 'GOLANG'
  - 'APM'
---

- [Pinpoint Golang Agent Code Repository](https://github.com/pinpoint-apm/pinpoint-go-agent){:target="_blank"}
- [Pinpoint Golang Code Examples](https://github.com/pinpoint-apm/pinpoint-go-agent/tree/main/example){:target="_blank"}
- [Pinpoint Golang Agent Configuration Documentation](https://github.com/pinpoint-apm/pinpoint-go-agent/blob/main/doc/config.md){:target="_blank"}

---

## Configure Datakit Agent {#config-datakit-agent}

Refer to [Configure Pinpoint Agent in Datakit](pinpoint.md#agent-config)

## Configure Pinpoint Golang Agent {#config-pinpoint-golang-agent}

The Pinpoint Golang Agent can be configured in multiple ways, including command-line arguments, configuration files, environment variables. The configuration priority from high to low is:

- Command-line arguments
- Environment variables
- Configuration files
- Configuration functions
- Default configurations

The Pinpoint Golang Agent also supports runtime dynamic changes of configurations. All configuration items marked as dynamic can be dynamically configured during runtime.

Basic parameter descriptions:

Each heading below represents a configuration item in the configuration file, and each configuration item description lists the corresponding command-line argument, environment variable, configuration function, value type, and additional information.

<!-- markdownlint-disable MD006 MD007 -->
`ConfigFile`

:   Supports [JSON](https://github.com/pinpoint-apm/pinpoint-go-agent/blob/main/example/pinpoint-config.json){:target="_blank"}, [YAML](https://github.com/pinpoint-apm/pinpoint-go-agent/blob/main/example/pinpoint-config.yaml){:target="_blank"}, [Properties Configuration File](https://github.com/pinpoint-apm/pinpoint-go-agent/blob/main/example/pinpoint-config.prop){:target="_blank"}. Configuration items in the configuration file are case-sensitive.

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

:   AgentId is used to configure an ID to distinguish different Agents. It is recommended to include the hostname. If it is not configured or incorrectly configured, the Agent will use an automatically generated ID.

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
   - default: 9991 (Default port number for Datakit Pinpoint Agent is 9991)

`Collector.SpanPort`

:   Collector.SpanPort configures the span port number of the Pinpoint Collector.

   - --pinpoint-collector-spanport
   - PINPOINT_GO_COLLECTOR_SPANPORT
   - WithCollectorSpanPort()
   - int
   - default: 9993 (Default port number for Datakit Pinpoint Agent is 9991)

`Collector.StatPort`

:   Collector.StatPort configures the stat port number of the Pinpoint Collector.

   - --pinpoint-collector-statport
   - PINPOINT_GO_COLLECTOR_STATPORT
   - WithCollectorStatPort()
   - int
   - default: 9992 (Default port number for Datakit Pinpoint Agent is 9991)

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

:   Sampling.CounterRate configures the sampling rate for the counter sampler. The sampling rate is 1/rate. For example, if the rate is set to 1, the sampling rate is 100%, and if the rate is set to 100, the sampling rate is 1%.

   - --pinpoint-sampling-counterrate
   - PINPOINT_GO_SAMPLING_COUNTERRATE
   - WithSamplingCounterRate()
   - int
   - default: 1
   - valid range: 0 ~ 100
   - dynamic

`Sampling.PercentRate`

:   Sampling.PercentRate configures the sampling rate for the percentage sampler.

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

:   Span.MaxCallStackDepth configures the maximum depth of the call stack that Span can probe.

   - --pinpoint-span-maxcallstackdepth
   - PINPOINT_GO_SPAN_MAXCALLSTACKDEPTH
   - WithSpanMaxCallStackDepth()
   - type: int
   - default: 64
   - min: 2
   - ultimate: -1
   - dynamic

`Span.MaxCallStackSequence`

:   Span.MaxCallStackDepth configures the maximum sequence length of the calls that Span can probe.

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

:   Stat.BatchCount configures the number of statistics sent in batches.

   - --pinpoint-stat-batchcount
   - PINPOINT_GO_STAT_BATCHCOUNT
   - WithStatBatchCount()
   - type: int
   - default: 6

`Log.Level`

:   Log.Level configures the log level of the Agent, trace/debug/info/warn/error must be configured.

   - --pinpoint-log-level
   - PINPOINT_GO_LOG_LEVEL
   - WithLogLevel()
   - type: string
   - default: "info"
   - case-insensitive
   - dynamic

`Log.Output`

:   Log.Output configures the log output, stderr/stdout/file path.

   - --pinpoint-log-output
   - PINPOINT_GO_LOG_OUTPUT
   - WithLogOutput()
   - type: string
   - default: "stderr"
   - case-insensitive
   - dynamic

`Log.MaxSize`

:   Log.MaxSize configures the maximum capacity of the log file.

   - --pinpoint-log-maxsize
   - PINPOINT_GO_LOG_MAXSIZE
   - WithLogMaxSize()
   - type: int
   - default: 10
   - dynamic

<!-- markdownlint-enable -->

## Manually Instrument Applications {#manual-instrumentation}

For virtual machine-based programming languages such as JAVA, automatic instrumentation can be achieved by injecting an instrumentation agent directly into the virtual machine. However, for compiled programming languages like Golang that run independently after compilation, manual instrumentation is required.

The Pinpoint Golang Agent provides two methods for manual instrumentation:

- Using the [Pinpoint Golang Plugin Library](https://github.com/pinpoint-apm/pinpoint-go-agent/tree/main/plugin){:target="_blank"}
- Using the Pinpoint Agent Golang API for manual instrumentation

<!-- markdownlint-disable MD006 MD007  MD038 -->
`Span`

:   In Pinpoint, a Span represents the top-level program operation of a service or application, such as creating a Span in an HTTP handler:

   ```golang
   func doHandle(w http.ResponseWriter, r *http.Request) {
     tracer = pinpoint.GetAgent().NewSpanTracerWithReader("HTTP Server", r.URL.Path, r.Header)
     defer tracer.EndSpan()

     span := tracer.Span()
     span.SetEndPoint(r.Host)
   }
   ```

   You can instrument single-call-stack applications and generate a Span. Tracer.EndSpan() must be called to complete the Span and send it to the remote Collector. The SpanRecorder and Annotation interfaces can be used to record link data in the Span.

`SpanEvent`

:   Each SpanEvent in Pinpoint represents a program operation within the scope of a Span, such as accessing a database, calling a function, or making a request to another service. You can report a span using Tracer.NewSpanEvent(), and you must call Tracer.EndSpanEvent() to complete the span.

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

` Distribute Tracing Context`

:   If a request comes from another node monitored by Pinpoint, the data exchange will include a distributed tracing context. Most of this data comes from the previous node and is packaged in the request message body. Pinpoint provides two functions to handle the reading and writing of the distributed tracing context.

   - Tracer.Extract(reader DistributedTracingContextReader) // Extracts the distributed context.
   - Tracer.Inject(writer DistributedTracingContextWriter) // Injects the context into the request.

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

` Pass Context Between Function Calls `

:   Passing the call context between different APIs within the same service and across processes is achieved through operations on context.Context. The Pinpoint Golang Agent injects the Tracer into the Context to achieve context linking.

   - NewContext() // Injects the Tracer into the Context.
   - FromContext() // Imports a Tracer.

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

` Instrument Goroutines`

:   The Pinpoint Tracer was designed to instrument single-call-stack applications, so sharing the same Tracer across different threads will cause resource contention and lead to program crashes. You can create a new Tracer to instrument Goroutines by calling Tracer.NewGoroutineTracer().

   Passing the Tracer between threads can be done in several ways:

   - function parameter

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

   - channel

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