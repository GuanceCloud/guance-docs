# Deployment on Hosts
---

## Install DataKit Agent

Before performing link data analysis for systems and applications, it is necessary to [deploy <<< custom_key.brand_name >>> DataKit collector](../../../datakit/datakit-install.md) on each target host to collect the required tracing data.

## Enable DDTrace Collector

DDTrace is used to receive, process, and analyze Tracing protocol data. Execute the following command to enable the DDTrace collector. For configurations of other third-party tracing collectors, refer to [Integration](../../../integrations/integration-index.md).

```
cp /usr/local/datakit/conf.d/ddtrace/ddtrace.conf.sample /usr/local/datakit/conf.d/ddtrace/ddtrace.conf
```

After configuration is complete, restart DataKit:

```
datakit service -R
```


## Select Language

### Java

Install dependencies:

```
wget -O dd-java-agent.jar 'https://<<< custom_key.static_domain >>>/dd-image/dd-java-agent.jar'
```

Run the application:

You can run your Java code through various methods, such as IDE, Maven, Gradle, or directly using the `java -jar` command. Below is an example using the `java` command to start the application:

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
4. Set sampling rate: After enabling, this can reduce the actual amount of data generated; the range is from 0.0(0%) ~ 1.0(100%);
5. Collect Profiling data: After enabling, you can see more runtime information about the application;
6. Enable JVM Metrics collection: Requires enabling the [statsd collector](../../integrations/statsd.md) simultaneously.

> For more parameter configurations, refer to [here](../../../integrations/ddtrace-java.md#start-options).

### Python

Install dependencies:

```
pip install ddtrace
```

Run the application:

You can run your Java code through various methods, such as IDE, Maven, Gradle, or directly using the `java -jar` command. Below is an example using the `java` command to start the application:

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
4. Set sampling rate: After enabling, this can reduce the actual amount of data generated; the range is from 0.0(0%) ~ 1.0(100%);
5. Collect Profiling data: After enabling, you can see more runtime information about the application;
6. Enable Python Metrics collection: Requires enabling the [statsd collector](../../integrations/statsd.md) simultaneously.

> For more parameter configurations, refer to [here](../../../integrations/ddtrace-java.md#start-options).

### Golang

Install dependencies:

```
go get gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer
```

Run the application:

You can run your Java code through various methods, such as IDE, Maven, Gradle, or directly using the `java -jar` command. Below is an example using the `java` command to start the application:

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
4. Set sampling rate: After enabling, this can reduce the actual amount of data generated; the range is from 0.0(0%) ~ 1.0(100%);
5. Collect Profiling data: After enabling, you can see more runtime information about the application.

> For more parameter configurations, refer to [here](../../../integrations/ddtrace-java.md#start-options).

### Node.JS

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Refer to</font>](../../../integrations/ddtrace-nodejs.md)

</div>

</font>

### C++

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Refer to</font>](../../../integrations/ddtrace-cpp.md)

</div>

</font>

### PHP

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Refer to</font>](../../../integrations/ddtrace-php.md)

</div>

</font>