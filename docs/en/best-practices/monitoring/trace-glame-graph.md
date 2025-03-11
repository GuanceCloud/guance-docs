# Clever Use of Flame Graphs to Analyze Chain Performance

---

This article aims to help you understand what full-chain tracing is and how to use tools to analyze performance bottlenecks in the chain.

## Basic Concepts and Tools

- Full Trace (Trace) Tracing
- Analysis Tools
    - Flame Graph
    - Span List
    - Service Call Relationship Diagram
- Duration / Execution Time

## Full Trace Tracing

In general, a single trace (Trace) is composed of various Spans, forming a tree or directed acyclic graph (DAG). Each Span represents a named and timed continuous execution segment within the Trace, as shown in the figure below. Since the core of a Span is recording the start and end times of corresponding program execution segments, and there exists a parent-child relationship between these execution segments, Spans logically form a tree structure.

Note: The parent-child relationship of spans can be associated by the child span's `parent_id` equaling the parent Span's `span_id`.

![](../images/flame/flame_graph.001.png)

### Flame Graph

A Flame Graph is a visualization chart invented by Linux performance optimization expert Brendan Gregg for analyzing performance bottlenecks. The Flame Graph provides a global view of time distribution, listing all potential performance bottleneck Spans from top to bottom.

#### Drawing Logic

- The vertical axis (Y-axis) represents the hierarchical depth of called Spans, indicating the call relationship between program execution segments: Spans above are parent Spans of Spans below (data can also be associated through `child_span.parent_id` equaling `parent_Span.span_id`).
- The horizontal axis (X-axis) represents the duration of Spans under a single Trace. The wider a block, the longer the duration from start to finish, potentially indicating a performance bottleneck.

![](../images/flame/flame_graph.002.png)

#### Display Explanation

**Flame Graph**

- Each Span block on the Flame Graph corresponds to its service color.

```
Thus, it is very intuitive to perceive which service requests are currently executing in the Trace from the Flame Graph. (Service color generation logic: when users log into the workspace to access the APM module, <<< custom_key.brand_name >>> automatically generates colors based on the service name, and this color integration will inherit to the link Explorer and other analysis pages)
```

- Span blocks default display: current Span resource (resource) or operation (operation), duration (duration), and whether there is an error (status = error).
- Each Span tooltip displays the corresponding resource (resource), duration (duration), and overall time consumption ratio.

**Service List**

The service list on the right side of the Flame Graph shows the service names, colors, and the ratio of execution time to total execution time for services involved in the current Trace.

Note: If the service name is displayed as None, it indicates that the current trace did not find a top-level Span with `parent_id = 0`.

#### Interaction Explanation

![](../images/flame/flame_graph.003.png)

1. Full-screen viewing/restoring default size: Click the full-screen icon in the upper-right corner of the trace details to expand horizontally and view the flame graph. Click the restore default size icon to return to the details page.
2. Expand/collapse mini-map: Click the expand/collapse mini-map icon on the left side of the trace details to quickly view the flame graph by selecting intervals, dragging, or scrolling in the mini-map.
3. View global Trace: Click the view global Trace icon on the left side of the trace details to view the global trace in the flame graph.
4. Collapse lower Tab details: Click the collapse button to hide the lower Tab details area.
5. Double-click Span: Amplify the display of the selected Span in the middle of the flame graph to quickly locate and view contextually related Spans.
6. Click service name on the right: Highlight the corresponding Span; clicking again restores the default selection of all Spans. You can click the service name to quickly filter and view Spans corresponding to the service.

#### Special Notes

Due to multi-threading or asynchronous tasks, spans may overlap in actual drawing:

- Sibling spans under the same parent may overlap.

![](../images/flame/flame_graph.004.png)

Since spans may overlap, to more intuitively see each Span and its sub-Spans, we perform some display processing on the front end when drawing the flame graph. This involves calculating the position of Spans and their sub-Spans in both time and space dimensions to ensure they do not obscure each other.

Example 1:

Normal Trace, sibling Spans at the same level do not overlap in time but have overlapping durations with subordinate sub-Spans. Parent-child Span relationships are connected via lines. Sub-Spans with connections follow this logic during drawing.

![](../images/flame/flame_graph.005.png)

Example 2:

Abnormal Trace, sibling Spans at the same level still overlap in time, but the start time (`start`) of the top-level Span (`parent_id = 0`) is greater than the start time of the child Span.

![](../images/flame/flame_graph.006.gif)

Analysis Logic:

Based on the parent-child relationship in the chain according to program execution, the start time of the parent Span must be less than the start time of the child Span. Therefore, if the parent Span and child Span belong to different services, it suggests that the system times of the servers hosting these services may be inconsistent. Calibration should be performed before analyzing the actual performance bottleneck.

### Span List

#### Display Explanation

**List Fully Collapsed State**

![](../images/flame/flame_graph.007.png)

- Column 1: Displays service type, service name, service color, and whether there are any Spans with `status = error`.
- Column 2: Displays the number of Spans under the current service.
- Column 3: Displays the average duration of Spans under the current service.
- Column 4: Displays the total execution time of Spans under the current service.
- Column 5: Displays the ratio of the service's execution time to the total execution time.

**Expanded Service Row Display**

![](../images/flame/flame_graph.008.png)

- Column 1: Displays resource name (resource), corresponding service color, and whether the current Span has `status = error`.
- Column 2: Empty
- Column 3: Displays the duration of the current Span.
- Column 4: Displays the execution time of the current Span.
- Column 5: Displays the ratio of the current Span's execution time to the total execution time.

#### Interaction Explanation

- Search: Supports fuzzy search by resource name (resource).
- Supports switching to the flame graph to view the context relationship of the selected Span.

![](../images/flame/flame_graph.009.gif)

### Service Call Relationship Diagram

#### Display Explanation

Displays the topology of service call relationships within the current trace.

- Supports fuzzy matching by resource name (resource) to locate upstream and downstream service call relationships.
- Hovering over a service displays: number of Spans under the current service, service execution time, and ratio.

![](../images/flame/flame_graph.010.png)

### Duration

The start and end times of the program execution segment corresponding to a Span are generally marked with the `duration` field in the Trace data.

### Execution Time

As mentioned in the special notes, the end times of parent and child Spans may differ. Execution time is calculated based on the following logic.

#### Span Execution Time

1. Child Span ends after the parent Span ends

![](../images/flame/flame_graph.011.png)

Child Span execution time = Children's duration

Total execution time = Children's end time - Parent's start time

Parent Span execution time = Total execution time - Child Span execution time

2. Child Span starts after the parent Span ends

![](../images/flame/flame_graph.012.png)

Child Span execution time = Children's duration

Total execution time = Children's end time - Parent's start time

Parent Span execution time = Total execution time - Child Span execution time

3. Sibling Spans under the same parent may overlap

![](../images/flame/flame_graph.013.png)

Parent Span execution time = p(1) + p(2)

Children 1 Span execution time = c1(1) + c1(2)

Children 2 Span execution time = c2(1) + c2(2)

Note: Because Children 1 Span and Children 2 Span partially overlap in actual execution time, this overlapping time is split equally between the two Spans.

**Example Explanation**

For synchronous tasks, Spans execute in the order "Span1 start -> Span1 end -> Span2 start -> Span2 end -> ...". The execution time of each Span and the corresponding parent Span's execution time are calculated as follows:

Example 1:

Parent Span = Couldcare SPAN1

Child Spans = MyDQL SPAN2, MyDQL SPAN3, MyDQL SPAN4, MyDQL SPAN5, MyDQL SPAN6, MyDQL SPAN7, MyDQL SPAN8, MyDQL SPAN9, MyDQL SPAN10, MyDQL SPAN11

Analysis:

Since all child Spans do not have further child Spans, the execution time of all child Spans equals their Span duration. The actual execution time of the parent Span is obtained by subtracting the execution time of all child Spans from the parent Span's duration.

![](../images/flame/flame_graph.014.png)

#### Service Execution Time

Each service's execution time = Sum of execution times of all Spans belonging to the service in the Trace.

#### Total Execution Time

Total execution time = Last end time of Spans in the Trace - First start time of Spans in the Trace.

## Chain Analysis Scenarios

### Collector Configuration (Host Installation)

Enter the DataKit installation directory's `conf.d/ddtrace` directory, copy `ddtrace.conf.sample`, and rename it to `ddtrace.conf`. Example:

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

If Trace data is sent across machines, then you need to configure [DataKit's HTTP settings](../../datakit/datakit-conf.md#config-http-server).

If ddtrace data is sent to DataKit, you will see it on [DataKit's monitor](../../datakit/datakit-monitor.md):

![](../images/flame/flame_graph.015.png)

*DDtrace sends data to the /v0.4/traces endpoint*

### SDK Integration (Go Example)

#### Install Dependencies

Install the ddtrace golang library in your development directory:

```shell
go get -v github.com/DataDog/dd-trace-go
```

#### Configure DataKit

First [install](../../datakit/datakit-install.md), [start DataKit](../../datakit/datakit-service-how-to.md), and enable the [ddtrace collector](../../integrations/ddtrace.md#config).

#### Code Example

The following code demonstrates collecting trace data for a file open operation.

In the `main()` entry point, set up basic trace parameters and start the trace:

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

        // Ensure tracer stops at the end of app exit
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

#### Compilation and Execution

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

After running the program for a while, you can see similar trace data in <<< custom_key.brand_name >>>:

![](../images/flame/flame_graph.016.png)

*Golang program trace data display*

#### Supported Environment Variables

The following environment variables support specifying some ddtrace configuration parameters when starting the program. Their basic form is:

```Shell
DD_XXX=<env-value> DD_YYY=<env-value> ./my-app
```

**Note**: These environment variables will be overridden by fields injected with WithXXX() in the code. Therefore, configurations injected in the code have higher priority, and these ENV only take effect when the corresponding fields are not specified in the code.

| **Key**                 | **Default Value** | **Description**                                                     |
| :---------------------- | :--------- | :----------------------------------------------------------- |
| DD_VERSION              | -          | Set the application version, such as *1.2.3*, *2022.02.13*                   |
| DD_SERVICE              | -          | Set the application service name                                               |
| DD_ENV                  | -          | Set the current environment of the application, such as prod, pre-prod                     |
| DD_AGENT_HOST           | localhost  | Set the IP address of DataKit, where the application-generated trace data will be sent to DataKit |
| DD_TRACE_AGENT_PORT     | -          | Set the receiving port for DataKit trace data. Here, specify the [DataKit HTTP port](https://docs.guance.com/datakit/datakit-conf/#config-http-server) (usually 9529) |
| DD_DOGSTATSD_PORT       | -          | If you want to receive statsd data generated by ddtrace, manually enable the [statsd collector on DataKit](https://docs.guance.com/datakit/statsd/) |
| DD_TRACE_SAMPLING_RULES | -          | Sampling settings represented by a JSON array (sampling rates apply in array order), where `sample_rate` is the sampling rate, ranging from [0.0, 1.0]. **Example One**: Set global sampling rate to 20%: `DD_TRACE_SAMPLE_RATE='[{"sample_rate": 0.2}]' ./my-app` **Example Two**: For services matching `app1.*` and Spans named `abc`, set the sampling rate to 10%, otherwise set it to 20%: `DD_TRACE_SAMPLE_RATE='[{"service": "app1.*", "name": "b", "sample_rate": 0.1}, {"sample_rate": 0.2}]' ./my-app` |
| DD_TRACE_SAMPLE_RATE    | -          | Enable the above sampling rate setting                                         |
| DD_TRACE_RATE_LIMIT     | -          | Set the number of Spans sampled per second for each Go process. If `DD_TRACE_SAMPLE_RATE` is enabled, the default is 100 |
| DD_TAGS                 | -          | Inject a set of global tags that appear in each Span and profile data. Multiple tags can be separated by spaces and commas, e.g., `layer:api,team:intake` or `layer:api team:intake` |
| DD_TRACE_STARTUP_LOGS   | true       | Enable ddtrace configuration and diagnostic logs                            |
| DD_TRACE_DEBUG          | false      | Enable ddtrace debugging logs                                  |
| DD_TRACE_ENABLED        | true       | Enable the trace switch. If manually disabled, no trace data will be generated |
| DD_SERVICE_MAPPING      | -          | Dynamically rename service names, separated by spaces and commas, e.g., `mysql:mysql-service-name,postgres:postgres-service-name`, `mysql:mysql-service-name postgres:postgres-service-name`

### Actual Chain Data Analysis

1. Log in to the <<< custom_key.brand_name >>> workspace, check the service list in the APM module. From the service page, you can already see that the P90 response time for the browser service is relatively long.

![](../images/flame/flame_graph.017.png)

2. Click the browser service name to view the overview analysis view of the service. It can be seen that the most critical resource affecting the current service response time is the `query_data` interface. Since this interface is a data query interface of <<< custom_key.brand_name >>>, let's see why it takes so long during the query process.

![](../images/flame/flame_graph.018.png)

3. Click the resource name and navigate to the Explorer. Sort by duration in descending order to view the maximum response time.

![](../images/flame/flame_graph.019.png)

4. Click the Span data to view and analyze the execution performance and other relevant information of the current Span within the entire chain.

![](../images/flame/flame_graph.020.png)

5. Click the [Full Screen] mode button in the upper-right corner to enlarge and view the flame graph information. Combining the overall chain view, it can be seen that the browser service accounts for 96.26% of the execution time in the entire chain. From the Span list, this conclusion can also be drawn. According to the proportion in the flame graph and the corresponding chain details, it can be summarized that for the `query_data` Span of the browser, the `resource_ttfb` (resource load request response time) took more than 400 milliseconds, and the `resource_first_byte` (resource load first byte time) took 1.46 seconds. Considering the geographical location of the province is Singapore, while our site is deployed in the Hangzhou node, it can be concluded that the data transmission time was prolonged due to geographical distance, affecting the overall latency.

![](../images/flame/flame_graph.021.png)

![](../images/flame/flame_graph.022.png)