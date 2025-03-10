# How to Enable Application Performance Monitoring
---

Application Performance Monitoring (APM) is primarily used to view the overall operating status, health, external API calls, database invocations, and resource consumption or anomalies in your own code. It helps businesses quickly pinpoint issues from their root cause, ensuring application performance and system stability.

Guance's APM supports all APM tools based on the Opentracing protocol, such as ddtrace, Skywalking, Zipkin, and Jaeger. By enabling the corresponding collector in DataKit and adding monitoring files to the application code that needs monitoring, you can view the reported trace data in the Guance workspace after configuration. You can also correlate this data with infrastructure, logs, and RUM for rapid fault detection and resolution, enhancing user experience.

This document will use a Python application to introduce how to achieve observability using ddtrace for APM.
## Prerequisites

You need to first create a [Guance account](https://www.guance.com/), and install DataKit on your host [Install DataKit](../datakit/datakit-install.md).

## Method/Steps

### Step 1: Enable and Configure `ddtrace.conf` Collector

Enter the `conf.d/ddtrace` directory under the DataKit installation directory, copy `ddtrace.conf.sample` and rename it to `ddtrace.conf`. Open `ddtrace.conf`, where `inputs` are enabled by default and do not need modification.

```
## Enter the ddtrace directory
cd /usr/local/datakit/conf.d/ddtrace/

## Copy the ddtrace configuration file
cp ddtrace.conf.sample ddtrace.conf

## Open and edit the ddtrace configuration file
vim ddtrace.conf 

# After configuring, restart DataKit to apply the changes 
datakit --restart  or  service datakit restart  or systemctl restart datakit
```

![](img/5.apm_1.png)

Note: `endpoints` are enabled by default; do not modify them.

Guance supports custom tags for APM queries through environment variables injected via command line or by enabling `inputs.ddtrace.tags` in `ddtrace.conf` and adding `tag`. Refer to the [ddtrace Environment Variable Configuration](../integrations/ddtrace.md) for detailed settings.

### Step 2: Install ddtrace

To collect trace data using ddtrace, you need to install the appropriate language-specific package for the application you want to monitor. This document uses a Python application as an example. For Java or other languages, refer to [Distributed Tracing (APM) Best Practices](../best-practices/monitoring/apm.md).

Install ddtrace by running the command `pip install ddtrace` in the terminal.

![](img/5.apm_2.png)

### Step 3: Configure Application Startup Script

#### Method One: Configure DataKit Service Address in Application Initialization File

1) Configure the DataKit service address. Add the following configuration content to the application initialization file:

```
tracer.configure(
    hostname = "localhost",  # Adjust according to your specific DataKit address
    port     = "9529",
)
```

2) Configure the application startup script file. Add the startup script command, such as:

```
ddtrace-run python your_app.py
```

Refer to the [Python Example](../integrations/ddtrace-python.md) documentation for more details.

#### Method Two: Directly Configure DataKit Service Address in Startup Script

Guance supports configuring the DataKit service address directly in the startup script without modifying your application code. In this example, we have created a Python application named "todoism". Navigate to the script file directory of this application and execute its script file, adjusting according to your actual application.

1) Configure the execution command in the startup script file (inject environment variables)

```
DD_AGENT_HOST=localhost DATADOG_TRACE_AGENT_PORT=9529 ddtrace-run python your_app.py
```

Diagram as follows:

![](img/5.apm_3.png)

2) Navigate to the startup script file directory and execute the startup script file `./boot.sh` to start the Python application. Diagram as follows:

![](img/5.apm_4.png)

**Note:** For security reasons, DataKit's HTTP service is bound to `localhost:9529` by default. If you want to enable external network access, edit `conf.d/datakit.conf` and change `listen` to `0.0.0.0:9529` (port optional). At this point, the ddtrace access address would be `http://<datakit-ip>:9529`. If the trace data source is the local DataKit machine, you can keep the `listen` configuration unchanged and use `http://localhost:9529`.

![](img/5.apm_5.png)

### Step 4: Analyze Data in Guance Explorer

After starting the script file, try accessing the Python application. You can then view and analyze the trace data in the "Application Performance Monitoring" section of the Guance workspace.

1) In "Application Performance Monitoring" - "Services," you can see the two services collected, including service type, request count, response time, etc.

![](img/5.apm_6.png)

2) In "Application Performance Monitoring" - "Traces," you can view the creation time, status, duration, etc., of the Flask service traces.

![](img/5.apm_7.png)

3) Click on a trace to view detailed information, including flame graphs, Span lists, service call relationships, and associated logs and hosts. This can help you quickly identify issues, ensure system stability, and enhance user experience.

![](img/5.apm_8.png)

Explanation of trace-related terms. More details about trace analysis can be found in the [Trace Analysis](../application-performance-monitoring/explorer/explorer-analysis.md) documentation.

| Keyword | Explanation |
| --- | --- |
| Service | The `service_name` can be customized when adding Trace monitoring |
| Resource | Refers to the entry point of a request in the Application handling an independent visit |
| Duration | The response time, which is the complete process from receiving the request to returning the response |
| Status | Status is divided into OK and ERROR, including error rate and error count |
| Span | A single operation method call throughout the entire process forms a Trace, which consists of multiple Span units |

## Advanced References

### Configure Associated Logs

1) Navigate to the `conf.d/log` directory under the DataKit installation directory `/usr/local/datakit`, copy `logging.conf.sample` and rename it to `logging.conf`. Edit the `logging.conf` file, add your application's service log storage path in `logfiles`, and specify the log source name in `source`. Save and restart DataKit. For more details on log collectors and log pipeline splitting, refer to the [Logging](../integrations/logging.md) documentation.

```
## Enter the log directory
cd /usr/local/datakit/conf.d/log/

## Copy the logging configuration file
cp logging.conf.sample logging.conf

## Open and edit the logging configuration file
vim logging.conf 

# After configuring, restart DataKit to apply the changes 
datakit --restart  or  service datakit restart  or systemctl restart datakit
```

2) In the startup script file, configure the execution command (inject environment variables to associate trace logs). For more details, refer to the [APM Log Association](../application-performance-monitoring/collection/connect-log/index.md) documentation.

```
DD_LOGS_INJECTION="true" DD_AGENT_HOST=localhost DATADOG_TRACE_AGENT_PORT=9529 ddtrace-run python your_app.py
```

Diagram as follows:

![](img/5.apm_10.png)

3) Execute the startup script file, try accessing the Python application, and then you can view the trace flame graph and span list in the log details of the Guance workspace. In the APM details, you can view related logs to perform quick data correlation analysis. Diagrams as follows:

- Log Details

![](img/5.apm_11.png)

- APM Details

![](img/5.apm_12.png)

### Configure Associated Web Applications (User Access Monitoring)

User performance monitoring through `ddtrace` and `RUM` collectors can track complete front-end to back-end request data for a web application. Using frontend user access data and the injected `trace_id`, you can quickly locate the call stack, improving troubleshooting efficiency.

1) In the Python application's initialization file, add the following configuration to set up the whitelist of allowed frontend request headers for tracking target server responses. Refer to the [Associated Web Application Access](../application-performance-monitoring/collection/connect-web-app.md) documentation for more details.

```
@app.after_request
def after_request(response):
 ...
 response.headers.add('Access-Control-Allow-Headers', 'x-datadog-parent-id,x-datadog-sampled,x-datadog-sampling-priority,x-datadog-trace-id')
 ....
 return response
 ....
```

Diagram as follows:

![](img/5.apm_13.png)

2) Add the following user access observability configuration in the `<head>` of the front-end page `index.html` (obtained from creating an application in the User Access Monitoring section of the Guance workspace).

```
<script src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'appid_68fa6ec4f56f4b78xxxxxxxxxxxxxxxx',
      datakitOrigin: '<DATAKIT ORIGIN>', // Protocol (including: //), domain name (or IP address) [and port number]
      env: 'production',
      version: '1.0.0',
      trackInteractions: true,
      allowedTracingOrigins: ["https://api.example.com", /https:\/\/.*\.my-api-domain\.com/]
    })
</script>
```

The `allowedTracingOrigins` setting is used to connect frontend and backend (RUM and APM) configurations. Fill in the domain names or IPs of backend servers that interact with the frontend page as needed. Other configuration items are used to collect user access data. Refer to the [Web Application Monitoring (RUM) Best Practices](../best-practices/monitoring/web.md) documentation for more details on user access monitoring configuration.

Diagram as follows:

![](img/5.apm_13.1.png)

3) After completing the configuration, execute the startup script file, try accessing the Python application, and you can view the associated trace details in the User Access Monitoring explorer of the Guance workspace, helping you perform quick data correlation analysis. Diagram as follows:

![](img/5.apm_14.png)

### Configure Sampling

Guance's "Application Performance Monitoring" feature supports analyzing and managing trace data collected by collectors like ddtrace that comply with the Opentracing protocol. By default, it collects all application performance data, meaning every call generates data. Without restrictions, this can result in large data volumes and excessive storage usage. You can reduce storage costs by configuring sampling to collect application performance data. Refer to the [How to Configure Application Performance Monitoring Sampling](../application-performance-monitoring/collection/sampling.md) documentation for more details.

## Additional References

### [Collect Application Performance Data via Skywalking](../integrations/skywalking.md)
### [Collect Application Performance Data via Jaeger](../integrations/jaeger.md)