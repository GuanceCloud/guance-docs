# Deploy on Hosts
---

## Install DataKit Agent

Before performing link data analysis for systems and applications, you need to [deploy the Guance DataKit collector on each target host](../../../datakit/datakit-install.md) to collect necessary trace data.

### Choose Language

#### Java

Install dependencies:

```
wget -O dd-java-agent.jar 'https://static.guance.com/dd-image/dd-java-agent.jar'
```

Run the application:

You can run your Java code through various methods such as IDE, Maven, Gradle, or directly using the `java -jar` command. The following example starts the application using the `java` command:

```
java \ 
    -javaagent:/path/to/dd-java-agent.jar \ 
    -Ddd.logs.injection=true \ 
    -Ddd.agent.host=<YOUR-DATAKIT-HOST> \ 
    -Ddd.trace.agent.port=9529 \ 
    -jar path/to/your/app.jar
```

Parameter configuration:

1. `service.name`: Service name;
2. `env`: Environment information of the application service;
3. `version`: Version number;
4. Set sampling rate: When enabled, it can reduce the actual amount of generated data; range from 0.0(0%) ~ 1.0(100%);
5. Collect Profiling data: When enabled, more runtime information about the application can be seen;
6. Enable JVM Metrics collection: Requires enabling the [statsd collector](../../integrations/statsd.md).

> For more parameter configurations, refer to [here](../../../integrations/ddtrace-java.md#start-options).

#### Python

Install dependencies:

```
pip install ddtrace
```

Run the application:

You can run your Java code through various methods such as IDE, Maven, Gradle, or directly using the `java -jar` command. The following example starts the application using the `java` command:

```
DD_LOGS_INJECTION=true \ 
DD_AGENT_HOST=localhost \ 
DD_AGENT_PORT=9529 \ 
ddtrace-run python my_app.py
```

Parameter configuration:

1. `service.name`: Service name;
2. `env`: Environment information of the application service;
3. `version`: Version number;
4. Set sampling rate: When enabled, it can reduce the actual amount of generated data; range from 0.0(0%) ~ 1.0(100%);
5. Collect Profiling data: When enabled, more runtime information about the application can be seen;
6. Enable Python Metrics collection: Requires enabling the [statsd collector](../../integrations/statsd.md).

> For more parameter configurations, refer to [here](../../../integrations/ddtrace-java.md#start-options).

#### Golang

Install dependencies:

```
go get gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer
```

Run the application:

You can run your Java code through various methods such as IDE, Maven, Gradle, or directly using the `java -jar` command. The following example starts the application using the `java` command:

```go
package main 

import ( 
   "io/ioutil" 
   "os" 
   "time" 
   httptrace "gopkg.in/DataDog/dd-trace-go.v1/contrib/net/http" 
   "gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer" 
) 

func main() { 
  tracer.Start( 
  ) 
  defer tracer.Stop() 
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

Parameter configuration:

1. `service.name`: Service name;
2. `env`: Environment information of the application service;
3. `version`: Version number;
4. Set sampling rate: When enabled, it can reduce the actual amount of generated data; range from 0.0(0%) ~ 1.0(100%);
5. Collect Profiling data: When enabled, more runtime information about the application can be seen.

> For more parameter configurations, refer to [here](../../../integrations/ddtrace-java.md#start-options).

#### Node.JS

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Refer to</font>](../../../integrations/ddtrace-nodejs.md)

</div>

</font>

#### C++

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Refer to</font>](../../../integrations/ddtrace-cpp.md)

</div>

</font>

#### PHP

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Refer to</font>](../../../integrations/ddtrace-php.md)

</div>

</font>