---
title     : 'DDTrace Golang'
summary   : 'Integration of DDTrace with Golang'
tags      :
  - 'DDTRACE'
  - 'GOLANG'
  - 'Tracing'
__int_icon: 'icon/ddtrace'
---

There are currently two ways to instrument code: **compile-time instrumentation** and **manual instrumentation with code changes**.

Intrusive instrumentation **requires modifying existing code**, but in general, common business code does not require significant changes. Only the relevant `import` packages need to be replaced.

To enable APM at compile time with DDTrace, you need to install [orchestrion](https://github.com/DataDog/orchestrion){:target="_blank"}

Below are the instructions for both methods.

## Compile-Time Instrumentation {#compilation-automatically}

Requirements:

- Go version must be **1.18+**
- The project must use **Go Modules**.

Install Orchestrion

```shell
go install github.com/DataDog/orchestrion@latest
```

If installation fails, try cloning the repository locally and then building it.

```shell
git clone https://github.com/DataDog/orchestrion.git
cd orchestrion/
go build
cp orchestrion $GOPATH/bin/
```

Run the command from the root directory of your project to generate a go file locally.

```shell
orchestrion pin
```

You can compile your project using one of the following three methods:

1 **Before the `go build` command**:

```shell
orchestrion go build .
orchestrion go run .
orchestrion go test ./...
```

2 **Using the `-toolexec` method**:

```shell
go build -toolexec="orchestrion toolexec" .
go run -toolexec="orchestrion toolexec" .
go test -toolexec="orchestrion toolexec" ./...
```

3 **Modify the environment variable `$GOFLAGS`**:

```shell
# Make sure to include the quotes as shown below, as these are required for
# the Go toolchain to parse GOFLAGS properly!
export GOFLAGS="${GOFLAGS} '-toolexec=orchestrion toolexec'"
go build .
go run .
go test ./...
```

After compilation, the executable can trigger traces and upload them during runtime.

Modifying various configurations using environment variables is similar to other languages; refer to the documentation below for environment variable configuration.

### Additional Documentation {#docs}

- [Tracing Go Applications](https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/dd_libraries/go/?tab=compiletimeinstrumentation){:target="_blank"}
- [GitHub Orchestrion](https://github.com/DataDog/orchestrion){:target="_blank"}

---

## Manual Instrumentation {#Manual-dependence}

Install the DDTrace Golang SDK:

```shell
go get gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer
```

Install the profiling library

```shell
go get gopkg.in/DataDog/dd-trace-go.v1/profiler
```

Other libraries related to components depend on your needs, for example:

```shell
go get gopkg.in/DataDog/dd-trace-go.v1/contrib/gorilla/mux
go get gopkg.in/DataDog/dd-trace-go.v1/contrib/net/http
go get gopkg.in/DataDog/dd-trace-go.v1/contrib/database/sql
```

You can find more available tracing SDKs from the [Github Plugin Library](https://github.com/DataDog/dd-trace-go/tree/main/contrib){:target="_blank"} or [Datadog Support Documentation](https://docs.datadoghq.com/tracing/trace_collection/compatibility/go/#integrations){:target="_blank"}.

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
    go build http-server.go -o http-server.exe
    $env:DD_AGENT_HOST="localhost"; $env:DD_TRACE_AGENT_PORT="9529"; .\http-server.exe
    ```
<!-- markdownlint-enable -->

### Manual Tracing {#manual-tracing}

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

    // Ensure tracer stops when the app exits
    defer tracer.Stop()

    tick := time.NewTicker(time.Second)
    defer tick.Stop()

    // Your application's main entry point...
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

    // Create a child span to compute the time needed to read a file.
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

    // Create a child span to compute the time needed to read a file.
    child := tracer.StartSpan("read.file", tracer.ChildOf(span.Context()))
    child.SetTag(ext.ResourceName, "somefile-not-found.go")

    defer func() {
        child.Finish(tracer.WithError(err))
        span.Finish(tracer.WithError(err))
    }()

    // Perform an error operation.
    if _, err = ioutil.ReadFile("somefile-not-found.go"); err != nil {
        // Handle error
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

After running the program for some time, you should see trace data similar to the following in Guance:

<figure markdown>
  ![](https://static.guance.com/images/datakit/golang-ddtrace-example.png){ width="800"}
  <figcaption>Display of Golang Program Trace Data</figcaption>
</figure>

## Supported Environment Variables {#start-options}

The following environment variables can be used to specify DDTrace configuration parameters when starting the program. Their basic form is:

```shell
DD_XXX=<env-value> DD_YYY=<env-value> ./my-app
```

For more supported environment variables, see the [DDTrace-Go Documentation](https://docs.datadoghq.com/tracing/trace_collection/library_config/go/){:target="_blank"}

<!-- markdownlint-disable MD046 -->
???+ attention

    These environment variables will be overridden by corresponding fields injected via `WithXXX()` in the code, so configurations injected via code have higher priority. These ENV variables only take effect when the corresponding fields are not specified in the code.
<!-- markdownlint-enable -->

- **`DD_VERSION`**

    Set the application version, e.g., `1.2.3`, `2022.02.13`

- **`DD_SERVICE`**

    Set the service name for the application

- **`DD_ENV`**

    Set the current environment for the application, e.g., `prod`, `pre-prod`

- **`DD_AGENT_HOST`**

    **Default value**: `localhost`

    Set the IP address of DataKit, to which the trace data generated by the application will be sent

- **`DD_TRACE_AGENT_PORT`**

    Set the port that DataKit uses to receive trace data. You need to manually specify the [HTTP port of DataKit][4] (usually 9529)

- **`DD_DOGSTATSD_PORT`**

    Default value: `8125`
    If you want to collect StatsD metrics generated by DDTrace, you need to manually enable the [StatsD collector in DataKit][5]

- **`DD_TRACE_SAMPLING_RULES`**

    **Default value**: `nil`

    This uses a JSON array to represent sampling settings (sampling rates are applied in the order of the array), where `sample_rate` is the sampling rate, with values ranging from `[0.0, 1.0]`.

    **Example 1**: Set global sampling rate to 20%: `DD_TRACE_SAMPLING_RULES='[{"sample_rate": 0.2}]' ./my-app`

    **Example 2**: For services named `app1.*` and spans named `abc`, set the sampling rate to 10%, otherwise set it to 20%: `DD_TRACE_SAMPLING_RULES='[{"service": "app1.*", "name": "b", "sample_rate": 0.1}, {"sample_rate": 0.2}]' ./my-app`

- **`DD_TRACE_SAMPLE_RATE`**

    **Default value**: `nil`

    Enable the above sampling rate setting

- **`DD_TRACE_RATE_LIMIT`**

    Set the number of spans sampled per second for each Golang process. If `DD_TRACE_SAMPLE_RATE` is enabled, the default is 100

- **`DD_TAGS`**

    **Default value**: `[]`

    Inject a set of global tags that will appear in each span and profile data. Multiple tags can be separated by spaces and commas, e.g., `layer:api,team:intake` or `layer:api team:intake`

- **`DD_TRACE_STARTUP_LOGS`**

    **Default value**: `true`

    Enable logs related to DDTrace configuration and diagnostics

- **`DD_TRACE_DEBUG`**

    **Default value**: `false`

    Enable debugging logs related to DDTrace

- **`DD_TRACE_ENABLED`**

    **Default value**: `true`

    Enable the trace switch. If this switch is manually turned off, no trace data will be generated

- **`DD_SERVICE_MAPPING`**

    **Default value**: `null`
    Dynamically rename service names. Service mappings can be separated by spaces and commas, e.g., `mysql:mysql-service-name,postgres:postgres-service-name` or `mysql:mysql-service-name postgres:postgres-service-name`

---

[4]: datakit-conf.md#config-http-server
[5]: ../integrations/statsd.md
