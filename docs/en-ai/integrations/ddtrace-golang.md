---
title     : 'DDTrace Golang'
summary   : 'DDTrace Golang Integration'
tags      :
  - 'DDTRACE'
  - 'GOLANG'
  - 'Tracing'
__int_icon: 'icon/ddtrace'
---


The integration of APM in Golang is somewhat intrusive, **requiring modifications to existing code**, but overall, common business code does not require many changes. Only the relevant import packages need to be replaced.

## Install Dependencies {#dependence}

Install the DDTrace Golang SDK:

```shell
go get gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer
```

Install the profiling library

```shell
go get gopkg.in/DataDog/dd-trace-go.v1/profiler
```

Other libraries related to components, depending on the situation, for example:

```shell
go get gopkg.in/DataDog/dd-trace-go.v1/contrib/gorilla/mux
go get gopkg.in/DataDog/dd-trace-go.v1/contrib/net/http
go get gopkg.in/DataDog/dd-trace-go.v1/contrib/database/sql
```

We can find more available tracing SDKs from the [Github plugin repository](https://github.com/DataDog/dd-trace-go/tree/main/contrib){:target="_blank"} or [Datadog support documentation](https://docs.datadoghq.com/tracing/trace_collection/compatibility/go/#integrations){:target="_blank"}.

## Code Examples {#examples}

### Simple HTTP Service {#sample-http-server}

``` go hl_lines="8-10 15-16 20-38" linenums="1" title="http-server.go"
package main

import (
  "log"
  "net/http"
  "time"

  httptrace "gopkg.in/DataDog/dd-trace-go.v1/contrib/net/http"
  "gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer"
  "gopkg.in/DataDog/dd-trace-go.v1/profiler"
)

func main() {
  tracer.Start(
    tracer.WithService("test"),
    tracer.WithEnv("test"),
  )
  defer tracer.Stop()

  err := profiler.Start(
    profiler.WithService("test"),
    profiler.WithEnv("test"),
    profiler.WithProfileTypes(
      profiler.CPUProfile,
      profiler.HeapProfile,

      // The profiles below are disabled by
      // default to keep overhead low, but
      // can be enabled as needed.
      // profiler.BlockProfile,
      // profiler.MutexProfile,
      // profiler.GoroutineProfile,
    ),
  )
  if err != nil {
    log.Fatal(err)
  }
  defer profiler.Stop()

  // Create a traced mux router
  mux := httptrace.NewServeMux()
  // Continue using the router as you normally would.
  mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    time.Sleep(time.Second)
    w.Write([]byte("Hello World!"))
  })
  if err := http.ListenAndServe(":18080", mux); err != nil {
    log.Fatal(err)
  }
}
```

Compile and run

<!-- markdownlint-disable MD046 -->
=== "Linux/Mac"

    ```shell
    go build http-server.go -o http-server
    DD_AGENT_HOST=localhost DD_TRACE_AGENT_PORT=9529 ./http-server
    ```

=== "Windows"

    ```powershell
    go build http-server.go -o http-server
    $env:DD_AGENT_HOST="localhost"; $env:DD_TRACE_AGENT_PORT="9529"; .\http-server.exe
    ```
<!-- markdownlint-enable -->

### Manual Instrumentation {#manual-tracing}

The following code demonstrates collecting trace data for a file opening operation.

In the `main()` entry point, set up basic trace parameters and start tracing:

``` go hl_lines="8-9 14-17 40-45 57-66" linenums="1" title="main.go"
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

func runAppWithError() {
    var err error
    // Start a root span.
    span := tracer.StartSpan("get.data")

    // Create a child of it, computing the time needed to read a file.
    child := tracer.StartSpan("read.file", tracer.ChildOf(span.Context()))
    child.SetTag(ext.ResourceName, "somefile-not-found.go")

    defer func() {
        child.Finish(tracer.WithError(err))
        span.Finish(tracer.WithError(err))
    }()

    // Perform an error operation.
    if _, err = ioutil.ReadFile("somefile-not-found.go"); err != nil {
        // error handle
    }
}
```

Compile and run

<!-- markdownlint-disable MD046 -->
=== "Linux/Mac"

    ```shell
    go build main.go -o my-app
    DD_AGENT_HOST=localhost DD_TRACE_AGENT_PORT=9529 ./my-app
    ```

=== "Windows"

    ```powershell
    go build main.go -o my-app.exe
    $env:DD_AGENT_HOST="localhost"; $env:DD_TRACE_AGENT_PORT="9529"; .\my-app.exe
    ```
<!-- markdownlint-enable -->

After running the program for some time, you can see similar trace data in Guance:

<figure markdown>
  ![](https://static.guance.com/images/datakit/golang-ddtrace-example.png){ width="800"}
  <figcaption>Display of trace data from a Golang program</figcaption>
</figure>

## Supported Environment Variables {#start-options}

The following environment variables can be specified when starting the program to configure DDTrace settings. Their basic form is:

```shell
DD_XXX=<env-value> DD_YYY=<env-value> ./my-app
```

For more environment variable support, refer to the [DDTrace-Go documentation](https://docs.datadoghq.com/tracing/trace_collection/library_config/go/){:target="_blank"}

<!-- markdownlint-disable MD046 -->
???+ attention

    These environment variables will be overridden by corresponding fields injected with `WithXXX()` in the code, so configuration injected via code has higher priority. These ENVs only take effect if the corresponding fields are not specified in the code.
<!-- markdownlint-enable -->

- **`DD_VERSION`**

    Set the application version, e.g., `1.2.3`, `2022.02.13`

- **`DD_SERVICE`**

    Set the application service name

- **`DD_ENV`**

    Set the current environment of the application, such as `prod`, `pre-prod`, etc.

- **`DD_AGENT_HOST`**

    **Default Value**: `localhost`

    Set the IP address of DataKit, where the trace data generated by the application will be sent to DataKit

- **`DD_TRACE_AGENT_PORT`**

    Set the port for receiving trace data from DataKit. You need to manually specify the [HTTP port of DataKit][4] (usually 9529)

- **`DD_DOGSTATSD_PORT`**

    Default Value: `8125`
    If you want to receive StatsD data generated by DDTrace, you need to manually enable the [StatsD collector on DataKit][5]

- **`DD_TRACE_SAMPLING_RULES`**

    **Default Value**: `nil`

    Use a JSON array to represent sampling settings (sampling rates are applied in the order of the array), where `sample_rate` is the sampling rate, with values ranging from `[0.0, 1.0]`.

    **Example One**: Set the global sampling rate to 20%: `DD_TRACE_SAMPLING_RULES='[{"sample_rate": 0.2}]' ./my-app`

    **Example Two**: For services matching `app1.*` and spans named `abc`, set the sampling rate to 10%, otherwise set it to 20%: `DD_TRACE_SAMPLING_RULES='[{"service": "app1.*", "name": "b", "sample_rate": 0.1}, {"sample_rate": 0.2}]' ./my-app`

- **`DD_TRACE_SAMPLE_RATE`**

    **Default Value**: `nil`

    Enable the above sampling rate switch

- **`DD_TRACE_RATE_LIMIT`**

    Set the number of spans sampled per second for each Golang process. If `DD_TRACE_SAMPLE_RATE` is already enabled, the default is 100

- **`DD_TAGS`**

    **Default Value**: `[]`

    Inject a set of global tags here, which will appear in each span and profile data. Multiple tags can be separated by spaces and commas, such as `layer:api,team:intake`, `layer:api team:intake`

- **`DD_TRACE_STARTUP_LOGS`**

    **Default Value**: `true`

    Enable DDTrace configuration and diagnostic logs

- **`DD_TRACE_DEBUG`**

    **Default Value**: `false`

    Enable DDTrace debug logs

- **`DD_TRACE_ENABLED`**

    **Default Value**: `true`

    Enable the trace switch. If this switch is manually turned off, no trace data will be generated

- **`DD_SERVICE_MAPPING`**

    **Default Value**: `null`
    Dynamically rename service names, separated by spaces and commas, such as `mysql:mysql-service-name,postgres:postgres-service-name`, `mysql:mysql-service-name postgres:postgres-service-name`

---

[4]: datakit-conf.md#config-http-server
[5]: ../integrations/statsd.md