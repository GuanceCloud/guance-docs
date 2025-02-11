# Clever Use of Flame Graphs to Analyze Trace Performance

---

This article aims to help you understand what full trace (Trace) is and how to use tools to analyze performance bottlenecks in the trace.

## Basic Concepts and Tools

- Full Trace (Trace) Tracking
- Analysis Tools
  - Flame Graph
  - Span List
  - Service Call Relationship Diagram
- Duration / Execution Time

## Full Trace Tracking

Generally, a single trace (Trace) consists of various Spans, forming a tree or Directed Acyclic Graph (DAG). Each Span represents a named and timed continuous execution segment within the Trace. As shown in the following figure, since the core of Span is to record the start and end times of corresponding program execution segments, and there exists a parent-child relationship between these segments, Spans logically form a tree structure.

Note: The parent-child relationship of Spans can be associated by the child Span's `parent_id` equaling the parent Span's `span_id`.

![](../images/flame/flame_graph.001.png)

### Flame Graph

A Flame Graph is a visualization chart invented by Linux performance optimization expert Brendan Gregg for analyzing performance bottlenecks. It provides a global view of time distribution, listing all Spans that may cause performance bottlenecks from top to bottom.

#### Drawing Logic

- The vertical axis (Y-axis) represents the hierarchical depth of the called Spans, indicating the calling relationships between program execution segments: upper Spans are parent Spans of lower Spans (data can also be associated through `parent_id` and `span_id`).
- The horizontal axis (X-axis) represents the duration of Spans under a single Trace. A wider block indicates a longer duration from start to finish, which could be a potential cause of performance bottlenecks.

![](../images/flame/flame_graph.002.png)

#### Display Explanation

**Flame Graph**

- Each Span block on the Flame Graph corresponds to its service color.

```
So it is very intuitive to perceive which service requests are executing in the current Trace from the Flame Graph. (Service color generation logic: when users log into the workspace to access the APM module, Guance automatically generates colors based on service names, and this color integration will be inherited on analysis pages such as the Explorer.)
```

- By default, each Span block displays: resource (resource) or operation (operation), duration (duration), and whether an error exists (status = error).
- Each Span tooltip shows the corresponding resource (resource), duration (duration), and overall time consumption percentage.

**Service List**

The service list on the right side of the Flame Graph displays the service names, colors, and the ratio of execution time to total execution time involved in the current Trace.

Note: If the service name is displayed as "None," it means that the current trace did not find a top-level Span with `parent_id = 0`.

#### Interaction Explanation

![](../images/flame/flame_graph.003.png)

1. Full-screen View/Restore Default Size: Click the full-screen view icon in the upper-right corner of the trace details to expand the Flame Graph horizontally. Click the restore default size icon to return to the details page.
2. Expand/Collapse Minimap: Click the expand/collapse minimap icon on the left side of the trace details to quickly view the Flame Graph by selecting intervals, dragging, or scrolling on the minimap.
3. View Global Trace: Click the view global Trace icon on the left side of the trace details to see the global trace in the Flame Graph.
4. Collapse Lower Tab Details: Click the collapse button to hide the display area of the lower tab details.
5. Double-click Span: Amplify the display of the Span in the middle of the Flame Graph to quickly locate and view contextually related Spans.
6. Click Service Name on the Right: Highlight the corresponding Span. Clicking the service name again restores the default selection of all Spans. You can quickly filter and view Spans corresponding to the service by clicking the service name.

#### Special Notes

Due to multi-threading or asynchronous tasks, Spans may overlap in actual drawing:

- Sibling Spans under the same parent may overlap.

![](../images/flame/flame_graph.004.png)

Because of Span overlaps, we have made some display adjustments in the front-end when drawing the Flame Graph to ensure each Span and sub-Span is displayed without obstruction based on time and space dimensions.

Example 1:

In a normal Trace, sibling Spans at the same level do not overlap in time but may overlap with subordinate sub-Spans. Parent-child Span relationships are connected via lines, and the drawing logic is applied similarly for sub-Spans with connecting lines.

![](../images/flame/flame_graph.005.png)

Example 2:

In an abnormal Trace, sibling Spans at the same level may still overlap in time, but the start time (`start`) of the top-level Span (`parent_id = 0`) is greater than the start time of the child Span.

![](../images/flame/flame_graph.006.gif)

Analysis Logic:

According to the parent-child relationship of program execution in the trace, the start time of the parent Span should always be less than the start time of the child Span. Therefore, if the parent Span and child Span belong to different services, it suggests that the system times of the servers hosting these services might be inconsistent. This needs to be verified and calibrated before analyzing the actual performance bottleneck.

### Span List

#### Display Explanation

**List Fully Collapsed State**

![](../images/flame/flame_graph.007.png)

- Column 1: Displays service type, service name, service color, and whether there are any Spans with `status = error` under the current service.
- Column 2: Displays the number of Spans under the current service.
- Column 3: Displays the average duration (`duration`) of Spans under the current service.
- Column 4: Displays the total execution time of Spans under the current service.
- Column 5: Displays the ratio of the current service's execution time to the total execution time.

**Expanded Service Row Display**

![](../images/flame/flame_graph.008.png)

- Column 1: Displays resource name (`resource`), corresponding service color, and whether the current Span has `status = error`.
- Column 2: Empty
- Column 3: Displays the current Span's duration (`duration`).
- Column 4: Displays the current Span's execution time.
- Column 5: Displays the ratio of the current Span's execution time to the total execution time.

#### Interaction Explanation

- Search: Supports fuzzy search by resource name (`resource`).
- Supports switching to the Flame Graph to view the context relationship of the selected Span after selecting a Span.

![](../images/flame/flame_graph.009.gif)

### Service Call Relationship Diagram

#### Display Explanation

Displays the call topology between services in the current trace.

- Supports fuzzy matching by resource name (`resource`) to locate upstream and downstream service call relationships.
- When hovering over a service, it shows the number of Spans under the current service, the service execution time, and the ratio.

![](../images/flame/flame_graph.010.png)

### Duration

The start and end times of the program execution segment corresponding to a Span are generally marked in the Trace data using the `duration` field.

### Execution Time

As mentioned in the special notes, there may be inconsistencies in the end times of parent and child Spans. Execution time is calculated according to the following logic.

#### Span Execution Time

1. Child Span ends after the parent Span ends

![](../images/flame/flame_graph.011.png)

Child Span execution time = Children's `duration`

Total execution time = Children's end time - Parent's start time

Parent Span execution time = Total execution time - Child Span execution time

2. Child Span starts after the parent Span ends

![](../images/flame/flame_graph.012.png)

Child Span execution time = Children's `duration`

Total execution time = Children's end time - Parent's start time

Parent Span execution time = Total execution time - Child Span execution time

3. Sibling Spans under the same parent may overlap

![](../images/flame/flame_graph.013.png)

Parent Span execution time = p(1) + p(2)

Children 1 Span execution time = c1(1) + c1(2)

Children 2 Span execution time = c2(1) + c2(2)

Note: Because Children 1 Span and Children 2 Span partially overlap in actual execution, this overlapping time is evenly divided between the two Spans.

**Example Explanation**

In synchronous tasks where Spans execute in the order "Span1 start -> Span1 end -> Span2 start -> Span2 end -> ...", the execution time of each Span and the corresponding parent Span's execution time are calculated as follows:

Example 1:

Parent Span = Couldcare SPAN1

Child Spans = MyDQL SPAN2, MyDQL SPAN3, MyDQL SPAN4, MyDQL SPAN5, MyDQL SPAN6, MyDQL SPAN7, MyDQL SPAN8, MyDQL SPAN9, MyDQL SPAN10, MyDQL SPAN11

Analysis:

Since none of the child Spans have further child Spans, the execution time of all child Spans equals their Span durations. The actual execution time of the parent Span is obtained by subtracting the sum of the execution times of all child Spans from the parent Span's duration.

![](../images/flame/flame_graph.014.png)

#### Service Execution Time

Each service's execution time = Sum of the execution times of all Spans belonging to that service in the Trace.

#### Total Execution Time

Total execution time = Last end time of Spans in the Trace - First start time of Spans in the Trace.

## Trace Analysis Scenarios

### Collector Configuration (Host Installation)

Enter the DataKit installation directory's `conf.d/ddtrace` directory, copy `ddtrace.conf.sample`, and rename it to `ddtrace.conf`. Example configuration:

??? quote "`ddtrace.conf` Example"

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
      ## If some resources are rare enough(not present in 1 hour), those resources will always send
      ## to data center and do not consider samplers and filters.
      # keep_rare_resource = false

      ## By default every error presents in span will be send to data center and omit any filters or
      ## sampler. If you want to get rid of some error status, you can set the error status list here.
      # omit_err_status = ["404"]

      ## Ignore tracing resources map like service:[resources...].
      ## The service name is the full service name in the current application.
      ## The resource list is regular expressions used to block resource names.
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

After configuration, [restart DataKit](../../datakit/datakit-service-how-to.md#manage-service).

#### HTTP Settings

If Trace data is sent across machines, configure [DataKit's HTTP settings](../../datakit/datakit-conf.md#config-http-server).

If ddtrace data is sent to DataKit, it will appear on [DataKit's monitor](../../datakit/datakit-monitor.md):

![](../images/flame/flame_graph.015.png)

*DDtrace sends data to the `/v0.4/traces` endpoint*

### SDK Integration (Go Example)

#### Install Dependencies

Install the ddtrace golang library in your development directory:

```shell
go get -v github.com/DataDog/dd-trace-go
```

#### Set Up DataKit

Ensure you have [installed](../../datakit/datakit-install.md), [started DataKit](../../datakit/datakit-service-how-to.md), and enabled the [ddtrace collector](../../integrations/ddtrace.md#config).

#### Code Example

The following code demonstrates collecting trace data for a file opening operation.

In the main() entry point, set up basic trace parameters and start the trace:

??? quote "Example Code"

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

        // Ensure tracer stops at app exit
        defer tracer.Stop()

        tick := time.NewTicker(time.Second)
        defer tick.Stop()

        // Your app's main entry...
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

#### Compile and Run

Linux/Mac Environment:

```Shell
go build main.go -o my-app
DD_AGENT_HOST=localhost DD_TRACE_AGENT_PORT=9529 ./my-app
```

Windows Environment:

```Shell
go build main.go -o my-app.exe
$env:DD_AGENT_HOST="localhost"; $env:DD_TRACE_AGENT_PORT="9529"; .\my-app.exe
```

After running the program for some time, you can view similar trace data in Guance:

![](../images/flame/flame_graph.016.png)

*Golang Program Trace Data Display*

#### Supported Environment Variables

The following environment variables support specifying ddtrace configuration parameters when starting the program. Their basic form is:

```Shell
DD_XXX=<env-value> DD_YYY=<env-value> ./my-app
```

**Note**: These environment variables will be overridden by fields injected with WithXXX() in the code, so the code-injected configurations have higher priority. ENV only takes effect when the corresponding fields are not specified in the code.

| **Key**                 | **Default Value** | **Description**                                                     |
| :---------------------- | :--------- | :----------------------------------------------------------- |
| DD_VERSION              | -          | Set the application version, e.g., *1.2.3*, *2022.02.13*                   |
| DD_SERVICE              | -          | Set the application service name                                               |
| DD_ENV                  | -          | Set the current environment of the application, e.g., prod, pre-prod                     |
| DD_AGENT_HOST           | localhost  | Set the IP address of DataKit, where the application's trace data will be sent to DataKit |
| DD_TRACE_AGENT_PORT     | -          | Set the port for DataKit to receive trace data. Manually specify [DataKit's HTTP port](https://docs.guance.com/datakit/datakit-conf/#config-http-server) (usually 9529) |
| DD_DOGSTATSD_PORT       | -          | If you need to receive statsd data generated by ddtrace, enable the [statsd collector on DataKit](https://docs.guance.com/datakit/statsd/) |
| DD_TRACE_SAMPLING_RULES | -          | Use a JSON array to represent sampling settings (sampling rates apply in the order of the array), where `sample_rate` is the sampling rate, ranging from [0.0, 1.0]. **Example One**: Set a global sampling rate of 20%: `DD_TRACE_SAMPLE_RATE='[{"sample_rate": 0.2}]' ./my-app` **Example Two**: For services matching `app1.*` and Spans named `abc`, set the sampling rate to 10%, otherwise set it to 20%: `DD_TRACE_SAMPLE_RATE='[{"service": "app1.*", "name": "b", "sample_rate": 0.1}, {"sample_rate": 0.2}]' ./my-app` |
| DD_TRACE_SAMPLE_RATE    | -          | Enable the above sampling rate setting                                         |
| DD_TRACE_RATE_LIMIT     | -          | Set the number of Spans sampled per second for each Go process. Defaults to 100 if `DD_TRACE_SAMPLE_RATE` is enabled |
| DD_TAGS                 | -          | Inject a set of global tags, which will appear in each Span and profile data. Multiple tags can be separated by spaces and commas, e.g., `layer:api,team:intake` or `layer:api team:intake` |
| DD_TRACE_STARTUP_LOGS   | true       | Enable ddtrace configuration and diagnostic logs                            |
| DD_TRACE_DEBUG          | false      | Enable ddtrace debug logs                                  |
| DD_TRACE_ENABLED        | true       | Enable trace collection. If manually turned off, no trace data will be generated |
| DD_SERVICE_MAPPING      | -          | Dynamically rename service names, separated by spaces and commas, e.g., `mysql:mysql-service-name,postgres:postgres-service-name` |

### Actual Trace Data Analysis

1. Log in to the Guance workspace, view the service list in the APM module. From the service page, you can already see that the P90 response time for the browser service is relatively long.

![](../images/flame/flame_graph.017.png)

2. Click on the browser service name to view the overview analysis view of the service. It can be seen that the most critical resource affecting the current service's response time is the `query_data` interface. Since this is a data query interface of Guance, let's examine why it takes so long during the query process.

![](../images/flame/flame_graph.018.png)

3. Click on the resource name, navigate to the Explorer, and sort by duration in descending order to view the maximum response time.

![](../images/flame/flame_graph.019.png)

4. Click on the Span data to analyze the execution performance and other related information of the current Span within the entire trace.

![](../images/flame/flame_graph.020.png)

5. Click the [Full Screen] mode button in the upper-right corner to magnify and view the Flame Graph information. Combining the overall trace view, it can be observed that the browser service accounts for 96.26% of the execution time in the entire trace. From the Span list, this conclusion can also be drawn. Based on the Flame Graph ratio and the corresponding trace detail information, it can be summarized that the `query_data` Span of the browser took about 400 milliseconds for `resource_ttfb` (resource loading request response time) and 1.46 seconds for `resource_first_byte` (resource loading first byte time). Considering the geographical location of `province` is Singapore, while our site is deployed in Hangzhou, it can be concluded that the geographical distance led to longer data transmission times, thus affecting the overall latency.

![](../images/flame/flame_graph.021.png)

![](../images/flame/flame_graph.022.png)