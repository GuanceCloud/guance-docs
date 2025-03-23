# Smart Use of Flame Graphs for Analyzing Trace Performance
---

This article aims to help you understand what full trace tracking is and how to use tools to analyze performance bottlenecks in traces.

## Basic Concepts and Tools

- Full Trace (Trace) Tracking
- Analysis Tools
    - Flame Graph
    - Span List
    - Service Call Relationship Map
- Duration / Execution Time

## Full Trace Tracking

In general, a single trace consists of various spans, forming a tree or Directed Acyclic Graph (DAG). Each span represents a named and timed continuous execution fragment within the trace, as shown in the figure below. Since the core of a span is recording the start and end times of the corresponding program execution fragment, and there is a parent-child relationship between program execution fragments, spans logically form a tree structure.

Note: The parent-child relationship of spans can be associated by the child span's `parent_id` being equal to the parent span's `span_id`.

![](../images/flame/flame_graph.001.png)

### Flame Graph

The Flame Graph was invented by Linux performance optimization expert Brendan Gregg for analyzing performance bottlenecks. A flame graph provides a global view of time distribution, listing all possible performance bottleneck spans from top to bottom.

#### Drawing Logic

- The vertical axis (Y-axis) represents the depth level of the called spans, used to indicate the call relationship between program execution fragments: the spans above are the parent spans of the spans below (this can also be associated by the child span's `parent_id` being equal to the parent span's `span_id`).
- The horizontal axis (X-axis) represents the duration of spans under a single trace. The wider a box is, the longer the span's duration from start to finish, which may be the cause of the performance bottleneck.

![](../images/flame/flame_graph.002.png)

#### Display Explanation

**Flame Graph**

- Each span box on the flame graph corresponds to the color of its service (service).

```
Thus, it is very intuitive to perceive from the flame graph which services are involved in the current trace execution. (Service color generation logic: when users log into their workspace to access the APM module, <<< custom_key.brand_name >>> will automatically generate colors based on the service name, and this color integration will be inherited on pages like the trace Explorer for analysis.)
```

- By default, each span block displays: the resource (resource) or operation (operation), duration (duration), and whether an error exists (status = error).
- Each span hint displays the resource (resource), duration (duration), and overall time consumption percentage.

**Service List**

The service list on the right side of the flame graph shows the service names, colors, and the ratio of execution time for services invoked in the current trace.

Note: If the service name is displayed as "None," it means that no top-level span with `parent_id = 0` was found in the current trace.

#### Interaction Instructions

![](../images/flame/flame_graph.003.png)

1. Full-screen view/restore default size: Click the full-screen view icon in the upper-right corner of the trace details to horizontally expand the flame graph for the trace; click the restore default size icon to return to the details page.
2. Expand/collapse the mini-map: Click the expand/collapse mini-map icon on the left side of the trace details to quickly view the flame graph by selecting intervals, dragging, or scrolling on the mini-map.
3. View global trace: Click the view global trace icon on the left side of the trace details to view the global trace in the flame graph.
4. Collapse the Tab details below: Click the collapse button to hide the Tab details display area below.
5. Double-click Span: In the middle of the flame graph, enlarge the display of the span to quickly locate and view its context-related spans.
6. Click the service name on the right: Highlight the corresponding span, and clicking the service name again restores the default selection of all spans. You can quickly filter and view spans corresponding to the service by clicking the service name.

#### Special Notes

Due to multi-threading or asynchronous tasks, relationships between spans in actual drawing may include:

- Sibling spans under the same parent may overlap.

![](../images/flame/flame_graph.004.png)

Because of overlapping spans, we perform some display processing in the front-end while drawing the flame graph to calculate the position where spans and child spans are fully visible without blocking based on time and space dimensions.

Example 1:

A normal trace where sibling spans at the same level do not overlap in time but overlap with subordinate child spans. Parent-child relationships between spans are connected by lines, and child spans are drawn according to the same logic when they contain connecting lines.

![](../images/flame/flame_graph.005.png)

Example 2:

An abnormal trace still has overlapping sibling spans at the same level, but because the data shows that the start time (start) of the top-level span (`parent_id = 0`) is greater than the start time of the child span.

![](../images/flame/flame_graph.006.gif)

Analysis Logic:

Based on the parent-child relationship of program execution in the trace, the start time of the parent span must be less than the start time of the child span. Therefore, if the parent span and child span belong to different services after seeing the display of the flame graph, it can be inferred that the system time of the servers where the two services are located may not be consistent, requiring calibration before analyzing the actual performance bottleneck.

### Span List

#### Display Explanation

**List Fully Collapsed State**

![](../images/flame/flame_graph.007.png)

- Column 1: Displays the service type, service name, service color, and whether there are spans with `status = error` under the current service.
- Column 2: Displays the number of spans under the current service.
- Column 3: Displays the average value of the duration (duration) of spans under the current service.
- Column 4: Displays the total execution time of spans under the current service.
- Column 5: Displays the ratio of the current service's execution time to the total execution time.

**Service Row Expanded Display**

![](../images/flame/flame_graph.008.png)

- Column 1: Displays the resource name (resource), corresponding service color, and whether the current span has `status = error`.
- Column 2: Empty.
- Column 3: Displays the current span's duration (duration).
- Column 4: Displays the current span's execution time.
- Column 5: Displays the ratio of the current span's execution time to the total execution time.

#### Interaction Instructions

- Search: Supports fuzzy search for resource names (resources).
- Allows switching to the flame graph to view the context relationship of the selected span.

![](../images/flame/flame_graph.009.gif)

### Service Call Relationship Map

#### Display Explanation

Displays the topology of service call relationships under the current trace.

- Supports fuzzy matching by resource name (resource) to locate upstream and downstream service call relationships.
- After hovering over a service, it displays: the number of spans under the current service, the service execution time, and the proportion.

![](../images/flame/flame_graph.010.png)

### Duration

The start and end times of the program execution fragment corresponding to a span are generally marked with the `duration` field in the trace data.

### Execution Time

As mentioned in the special notes, there may be inconsistencies in the end times of parent and child spans, so the execution time is calculated using the following logic.

#### Span Execution Time

1. The child span may end after the parent span ends.

![](../images/flame/flame_graph.011.png)

Child Span Execution Time = Children's duration

Total Execution Time = Children's end time - Parent's start time

Parent Span Execution Time = Total Execution Time - Child Span Execution Time

2. The child span may start after the parent span ends.

![](../images/flame/flame_graph.012.png)

Child Span Execution Time = Children's duration

Total Execution Time = Children's end time - Parent's start time

Parent Span Execution Time = Total Execution Time - Child Span Execution Time

3. Sibling spans under the same parent may overlap.

![](../images/flame/flame_graph.013.png)

Parent Span Execution Time = p(1) + p(2)

Children 1 Span Execution Time = c1(1) + c1(2)

Children 2 Span Execution Time = c2(1) + c2(2)

Note: Because Children 1 Span and Children 2 Span actually have partial overlaps in time during execution, this overlapping time is split evenly between the two spans.

**Example Explanation**

In synchronous task scenarios, spans execute in the order "Span1 start -> Span1 end -> Span2 start -> Span2 end -> ...". The execution time of each span and the execution time of the corresponding parent span are calculated as follows:

Example 1:

Parent Span = Couldcare SPAN1

Child Spans = MyDQL SPAN2, MyDQL SPAN3, MyDQL SPAN4, MyDQL SPAN5, MyDQL SPAN6, MyDQL SPAN7, MyDQL SPAN8, MyDQL SPAN9, MyDQL SPAN10, MyDQL SPAN11

Calculation Analysis:

Since none of the child spans have sub-spans at a lower level, the execution time of all child spans in the figure equals their span durations. The actual execution time of the parent span needs to be obtained by subtracting the execution time of all child spans from the duration of the parent span.

![](../images/flame/flame_graph.014.png)

#### Service Execution Time

Each service's execution time = The sum of the execution times of all spans belonging to the service in the trace.

#### Total Execution Time

Total Execution Time = The end time of the last span in the trace - The start time of the first span.

## Trace Analysis Scenario Examples

### Collector Configuration (Host Installation)

Navigate to the DataKit installation directory's `conf.d/ddtrace` folder, copy `ddtrace.conf.sample`, and rename it to `ddtrace.conf`. Example:

??? quote "`ddtrace.conf` example"

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

After configuration, [restart DataKit](../../datakit/datakit-service-how-to.md#manage-service).

#### HTTP Settings

If trace data is sent across machines, then [DataKit's HTTP settings](../../datakit/datakit-conf.md#config-http-server) need to be configured.

If ddtrace data is sent to DataKit, you will see it in [DataKit's monitor](../../datakit/datakit-monitor.md):

![](../images/flame/flame_graph.015.png)

*DDtrace sends data to the /v0.4/traces interface.*

### SDK Integration (Go Example)

#### Install Dependencies

Install the ddtrace golang library in your development directory:

```shell
go get -v github.com/DataDog/dd-trace-go
```

#### Set Up DataKit

First [install](../../datakit/datakit-install.md), [start DataKit](../../datakit/datakit-service-how-to.md), and enable the [ddtrace collector](../../integrations/ddtrace.md#config).

#### Code Example

The following code demonstrates collecting trace data for a file open operation.

Set up basic trace parameters and start the trace in the `main()` entry point:

??? quote "Example Below"

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

        // Your-app-main-entry...
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

After running the program for a while, similar trace data can be seen in <<< custom_key.brand_name >>>:

![](../images/flame/flame_graph.016.png)

*Golang Program Trace Data Display*

#### Supported Environment Variables

The following environment variables allow specifying some ddtrace configuration parameters when starting the program. Their basic format is:

```Shell
DD_XXX=<env-value> DD_YYY=<env-value> ./my-app
```

**Notes**: These environment variables will be overridden by corresponding fields injected via WithXXX() in the code, so configurations injected in the code have higher priority. These ENV only take effect when the corresponding fields are not specified in the code.

| **Key**                 | **Default Value** | **Description**                                                     |
| :---------------------- | :--------------- | :------------------------------------------------------------------ |
| DD_VERSION              | -                | Sets the application version, such as *1.2.3*, *2022.02.13*.           |
| DD_SERVICE              | -                | Sets the application service name.                                    |
| DD_ENV                  | -                | Sets the application's current environment, such as prod, pre-prod, etc. |
| DD_AGENT_HOST           | localhost       | Sets the IP address of DataKit. Trace data generated by the application will be sent to DataKit. |
| DD_TRACE_AGENT_PORT     | -               | Sets the receiving port for DataKit trace data. Manually specify [DataKit's HTTP port](<<< homepage >>>/datakit/datakit-conf/#config-http-server) (usually 9529). |
| DD_DOGSTATSD_PORT       | -               | If you want to receive statsd data generated by ddtrace, manually enable the [statsd collector on DataKit](<<< homepage >>>/datakit/statsd/). |
| DD_TRACE_SAMPLING_RULES | -               | This uses a JSON array to represent sampling settings (sampling rates apply in the order of the array), where sample_rate is the sampling rate, ranging from [0.0, 1.0]. **Example One**: Set the global sampling rate to 20%: DD_TRACE_SAMPLE_RATE='[{"sample_rate": 0.2}]' ./my-app **Example Two**: For services matching the pattern app1.* and spans named abc, set the sampling rate to 10%, otherwise set it to 20%: DD_TRACE_SAMPLE_RATE='[{"service": "app1.*", "name": "b", "sample_rate": 0.1}, {"sample_rate": 0.2}]' ./my-app |
| DD_TRACE_SAMPLE_RATE    | -               | Enable the sampling rate switch above.                              |
| DD_TRACE_RATE_LIMIT     | -               | Sets the number of span samples per second for each Golang process. Defaults to 100 if DD_TRACE_SAMPLE_RATE is already enabled. |
| DD_TAGS                 | -               | Inject a set of global tags that appear in each span and profile data. Multiple tags can be separated by spaces and commas, e.g., layer:api,team:intake or layer:api team:intake. |
| DD_TRACE_STARTUP_LOGS   | true           | Enable ddtrace-related configuration and diagnostic logs.              |
| DD_TRACE_DEBUG          | false          | Enable ddtrace-related debug logs.                                  |
| DD_TRACE_ENABLED        | true           | Enable the trace switch. If manually turned off, no trace data will be generated. |
| DD_SERVICE_MAPPING      | -              | Dynamically rename service names. Service name mappings can be separated by spaces and commas, e.g., mysql:mysql-service-name,postgres:postgres-service-name or mysql:mysql-service-name postgres:postgres-service-name |

### Actual Trace Data Analysis

1. Log into the <<< custom_key.brand_name >>> workspace and check the service list in the APM module. From the service page, you can already see that the P90 response time for the browser service is relatively long.

![](../images/flame/flame_graph.017.png)

2. Click on the browser service name to view the overview analysis view of the service. It can be observed that the most critical resource affecting the current service response time is the query_data interface. Since this is a data query interface of <<< custom_key.brand_name >>>, let's next examine why it takes so long during this query process.

![](../images/flame/flame_graph.018.png)

3. Click on the resource name to navigate to the Explorer, and sort by duration descending to view the maximum response time.

![](../images/flame/flame_graph.019.png)

4. Click on the Span data to analyze the execution performance and other related information of the current Span in the entire trace.

![](../images/flame/flame_graph.020.png)

5. Click the [Full Screen] mode button in the upper-right corner to zoom in and view the relevant information in the flame graph. Combining the overall trace view, it can be seen that the browser service accounts for as high as 96.26% of the execution time in the entire trace. This conclusion can also be derived from the Span list. Based on the proportions in the flame graph and the corresponding trace detail information, it can be summarized that for the query_data Span of the browser, the resource_ttfb (resource load request response time) takes more than 400 milliseconds, and the resource_first_byte (resource load first byte time) takes 1.46 seconds. Furthermore, combining the geographical location identification of province as Singapore (Singapore), and considering our site deployment in Hangzhou node, it can be concluded that the data transmission time becomes longer due to the geographical distance, thus affecting the overall response time.

![](../images/flame/flame_graph.021.png)

![](../images/flame/flame_graph.022.png)