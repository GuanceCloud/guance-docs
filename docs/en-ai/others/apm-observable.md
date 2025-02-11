# How to Enable Application Performance Monitoring (APM)
---

Application Performance Monitoring (APM) is primarily used to view the overall operational status, health, external API calls, database invocations, and resource consumption or anomalies in your own code. This helps businesses quickly identify issues at their root cause, ensuring application performance and system stability.

Guance's APM supports all APM tools based on the Opentracing protocol, such as ddtrace, Skywalking, Zipkin, and Jaeger. By enabling the corresponding collectors in DataKit and adding relevant monitoring files to the application code that needs to be monitored, you can view the reported trace data in the Guance workspace after configuration. You can also correlate this data with infrastructure, logs, and RUM for rapid fault detection and resolution, improving user experience.

This document will use a Python application to demonstrate how to achieve observability using ddtrace for APM.
## Prerequisites

You need to first create a [Guance account](https://www.guance.com/) and [install DataKit](../datakit/datakit-install.md) on your host.

## Method/Steps

### Step 1: Enable and Configure the `ddtrace.conf` Collector

Enter the `conf.d/ddtrace` directory under the DataKit installation directory, copy `ddtrace.conf.sample` and rename it to `ddtrace.conf`. Open `ddtrace.conf`, where `inputs` are enabled by default and do not require modification.

```
## Enter the ddtrace directory
cd /usr/local/datakit/conf.d/ddtrace/

## Copy the ddtrace configuration file
cp ddtrace.conf.sample ddtrace.conf

## Open and edit the ddtrace configuration file
vim ddtrace.conf 

# After configuration, restart DataKit to apply the changes 
datakit --restart  or  service datakit restart  or  systemctl restart datakit
```

![](img/5.apm_1.png)

Note: `endpoints` are enabled by default; do not modify them.

Guance supports custom tags for APM to facilitate correlated queries. This can be done via command-line environment variable injection or by enabling `inputs.ddtrace.tags` in `ddtrace.conf` and adding `tags`. Detailed configurations can be found in the [ddtrace Environment Variable Settings](../integrations/ddtrace.md) documentation.

### Step 2: Install ddtrace

To collect trace data using ddtrace, you need to install the appropriate language-specific package for the application you want to monitor. This document uses a Python application as an example; for Java or other languages, refer to the [Distributed Tracing (APM) Best Practices](../best-practices/monitoring/apm.md) documentation.

Install ddtrace using the command `pip install ddtrace` in the terminal.

![](img/5.apm_2.png)

### Step 3: Configure Application Startup Script

#### Method One: Configure DataKit Service Address in Application Initialization Configuration File

1) Configure the DataKit service address. Enter the initialization configuration file of your application and add the following configuration:

```
tracer.configure(
    hostname = "localhost",  # Depending on the specific DataKit address
    port     = "9529",
)
```


2) Configure the application startup script file. Add the command to start the application, such as:

```
ddtrace-run python your_app.py
```

For more details, see the [Python Example](../integrations/ddtrace-python.md) documentation.

#### Method Two: Directly Configure DataKit Service Address in Startup Script

Guance supports configuring the DataKit service address directly in the startup script without modifying your application code. In this example, we have created a Python application named "todoism". Navigate to the script file directory of the application and execute the script file according to your actual application.

1) Configure the execution command in the startup script file (inject environment variables)

```
DD_AGENT_HOST=localhost DATADOG_TRACE_AGENT_PORT=9529 ddtrace-run python your_app.py
```

Diagram illustration:

![](img/5.apm_3.png)

2) Navigate to the startup script file directory and execute the startup script file `./boot.sh` to start the Python application. Diagram illustration:

![](img/5.apm_4.png)

**Note:** For security reasons, DataKit's HTTP service is bound to `localhost:9529` by default. If you wish to allow external network access, you can edit `conf.d/datakit.conf` and change `listen` to `0.0.0.0:9529` (port is optional). The ddtrace access address would then be `http://<datakit-ip>:9529`. If the trace data source is from the local DataKit, you can keep the `listen` configuration unchanged and use `http://localhost:9529`.

![](img/5.apm_5.png)

### Step 4: Analyze Data in the Guance Explorer

After starting the script file, try accessing the Python application and then view the trace data in the "Application Performance Monitoring" section of the Guance workspace for analysis.

1) In "Application Performance Monitoring" - "Services," you can view the collected services, including service type, request count, response time, etc.

![](img/5.apm_6.png)

2) In "Application Performance Monitoring" - "Traces," you can view the creation time, status, duration, etc., of the Flask service traces.

![](img/5.apm_7.png)

3) Click on a trace to view detailed information, including flame graphs, Span lists, service call relationships, and associated logs and hosts. This can help you quickly locate issues, ensure system stability, and improve user experience.

![](img/5.apm_8.png)

Trace-related terminology is explained as follows. For more details on trace analysis, refer to the [Trace Analysis](../application-performance-monitoring/explorer/explorer-analysis.md) documentation.

| Keyword | Explanation |
| --- | --- |
| Service | Refers to `service_name`, which can be customized when adding Trace monitoring |
| Resource | Refers to the entry point of a single independent request in the Application |
| Duration | Refers to the response time, covering the entire request process from when the Application receives the request until it returns a response |
| Status | Divided into OK and ERROR, errors include error rate and error count |
| Span | A single operation method call throughout the entire process is called a Trace link, composed of multiple Span units |

## Advanced Reference

### Configure Correlated Logs

1) Navigate to the `/usr/local/datakit/conf.d/log/` directory under the DataKit installation directory, copy `logging.conf.sample` and rename it to `logging.conf`. Edit the `logging.conf` file, enter your application's service log storage path in `logfiles`, and enter the log source name in `source`. Save and restart DataKit. For more details on log collectors and log pipeline slicing, refer to the [Logs](../integrations/logging.md) documentation.

```
## Enter the log directory
cd /usr/local/datakit/conf.d/log/

## Copy the logging configuration file
cp logging.conf.sample logging.conf

## Open and edit the logging configuration file
vim logging.conf 

# After configuration, restart DataKit to apply the changes 
datakit --restart  or  service datakit restart  or  systemctl restart datakit
```

2) In the startup script file, configure the execution command (inject environment variables to associate trace logs). For more details, refer to the [APM Correlated Logs](../application-performance-monitoring/collection/connect-log/index.md) documentation.

```
DD_LOGS_INJECTION="true" DD_AGENT_HOST=localhost DATADOG_TRACE_AGENT_PORT=9529 ddtrace-run python your_app.py
```

Diagram illustration:

![](img/5.apm_10.png)

3) Start the script file, try accessing the Python application, and then view the trace flame graph and Span list in the log details of the Guance workspace. In the APM details, view related logs to assist with quick data correlation analysis. Diagrams are as follows:

- Log Details

![](img/5.apm_11.png)

- APM Details

![](img/5.apm_12.png)

### Configure Correlated Web Applications (RUM)

User performance monitoring through `ddtrace` and `RUM` collectors can track complete front-end to back-end request data for web applications. Using user access data from the front end and injected `trace_id` into the back end, you can quickly pinpoint call stacks and improve troubleshooting efficiency.

1) In the initialization file of the Python application, add the following configuration to set the white list of headers allowed for tracking front-end requests to the target server. For more details, refer to the [Correlating Web Application Access](../application-performance-monitoring/collection/connect-web-app.md) documentation.

```
@app.after_request
def after_request(response):
 ...
 response.headers.add('Access-Control-Allow-Headers', 'x-datadog-parent-id,x-datadog-sampled,x-datadog-sampling-priority,x-datadog-trace-id')
 ....
 return response
 ....
```

Diagram illustration:

![](img/5.apm_13.png)

2) In the `<head>` section of the front-end page `index.html`, add the following user access observability configuration (obtained from creating an application in the Guance workspace's user access monitoring).

```
<script src="https://static.guance.com/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'appid_68fa6ec4f56f4b78xxxxxxxxxxxxxxxx',
      datakitOrigin: '<DATAKIT ORIGIN>', // Protocol (including: //), domain name (or IP address)[and port number]
      env: 'production',
      version: '1.0.0',
      trackInteractions: true,
      allowedTracingOrigins: ["https://api.example.com", /https:\/\/.*\.my-api-domain\.com/]
    })
</script>
```

The `allowedTracingOrigins` setting is used to connect the front-end and back-end (RUM and APM). It should be configured with the domain names or IPs of backend servers that interact with the front-end page. Other settings are used to collect user access data. For more details on user access monitoring configuration, refer to the [Web Application Monitoring (RUM) Best Practices](../best-practices/monitoring/web.md) documentation.

Diagram illustration:

![](img/5.apm_13.1.png)

3) After configuration, start the script file, try accessing the Python application, and then view the associated trace data in the user access monitoring explorer details in the Guance workspace. This will help with quick data correlation analysis. Diagram illustration:

![](img/5.apm_14.png)

### Configure Sampling

Guance's "Application Performance Monitoring" feature supports analyzing and managing trace data collected by collectors like ddtrace that conform to the Opentracing protocol. By default, it collects application performance data comprehensively, meaning every call generates data. Without restrictions, this can lead to excessive data storage usage. You can reduce data storage and lower costs by configuring sampling. For more configuration details, refer to the [How to Configure APM Sampling](../application-performance-monitoring/collection/sampling.md) documentation.

## Additional References

### [Collect Application Performance Data via Skywalking](../integrations/skywalking.md)
### [Collect Application Performance Data via Jaeger](../integrations/jaeger.md)