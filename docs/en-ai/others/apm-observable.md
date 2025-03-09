# How to Enable Application Performance Monitoring
---

Application Performance Monitoring (APM) is primarily used to view the overall operation status, health, external API calls, database invocations, and resource consumption or anomalies in your own code. It helps businesses quickly pinpoint issues from their root cause and ensures application performance and system stability.

<<< custom_key.brand_name >>>'s APM supports all APM tools based on the Opentracing protocol, such as ddtrace, Skywalking, Zipkin, Jaege, etc. By enabling the corresponding collector in DataKit and adding monitoring files to the application code that needs monitoring, you can view the reported trace data in <<< custom_key.brand_name >>> workspace after configuration. You can also correlate this data with infrastructure, logs, and RUM for rapid fault detection and resolution, enhancing user experience.

This document will use a Python application to illustrate how to achieve observability using ddtrace for APM.
## Prerequisites

You need to first create a [<<< custom_key.brand_name >>> account](https://www.guance.com/) and install DataKit on your host [Install DataKit](../datakit/datakit-install.md).

## Method/Steps

### Step1: Enable and Configure ddtrace.conf Collector

Navigate to the `conf.d/ddtrace` directory under the DataKit installation path, copy `ddtrace.conf.sample` and rename it to `ddtrace.conf`. Open `ddtrace.conf`, where `inputs` are enabled by default and do not require changes.

```
## Navigate to the ddtrace directory
cd /usr/local/datakit/conf.d/ddtrace/

## Copy the ddtrace configuration file
cp ddtrace.conf.sample ddtrace.conf

## Open and edit the ddtrace configuration file
vim ddtrace.conf 

# After configuring, restart DataKit to apply the changes 
datakit --restart  or service datakit restart or systemctl restart datakit
```

![](img/5.apm_1.png)

Note: `endpoints` are enabled by default; do not modify them.

<<< custom_key.brand_name >>> supports custom tags for APM correlation queries, which can be injected via environment variables on the command line or by enabling `inputs.ddtrace.tags` in `ddtrace.conf` and adding `tag`. For detailed configuration, refer to the documentation [ddtrace Environment Variable Settings](../integrations/ddtrace.md).

### Step2: Install ddtrace

To collect trace data using ddtrace, you need to choose the appropriate language for the application being monitored. This document uses a Python application as an example. For Java or other languages, refer to the document [Distributed Tracing (APM) Best Practices](../best-practices/monitoring/apm.md).

Run the command `pip install ddtrace` in the terminal to install ddtrace.

![](img/5.apm_2.png)

### Step3: Configure Application Startup Script

#### Method One: Configure DataKit Service Address in the Application Initialization Configuration File

1) Configure the DataKit service address. Add the following configuration to the initialization configuration file of the application:

```
tracer.configure(
    hostname = "localhost",  # Depending on the specific DataKit address
    port     = "9529",
)
```


2) Configure the application startup script file. Add the startup script command, such as:

```
ddtrace-run python your_app.py
```

Refer to the documentation [Python Example](../integrations/ddtrace-python.md).

#### Method Two: Directly Configure DataKit Service Address in the Startup Script File

<<< custom_key.brand_name >>> supports configuring the DataKit service address directly through the startup script file without modifying your application code. In this example, a Python application named “todoism” has been created. Navigate to the script file directory of this application and execute its script file, adjusting according to your own application.

1) Configure the execution command in the startup script file (inject environment variables)

```
DD_AGENT_HOST=localhost DATADOG_TRACE_AGENT_PORT=9529 ddtrace-run python your_app.py
```

Diagram as follows:

![](img/5.apm_3.png)

2) Navigate to the startup script file directory and execute the startup script file `./boot.sh` to start the Python application. Diagram as follows:

![](img/5.apm_4.png)

**Note:** For security reasons, DataKit's HTTP service is bound to `localhost:9529` by default. If you want to enable external network access, edit `conf.d/datakit.conf` and change `listen` to `0.0.0.0:9529` (port optional). At this point, the ddtrace access address becomes `http://<datakit-ip>:9529`. If the trace data originates from the same machine as DataKit, you can leave `listen` unchanged and use `http://localhost:9529`.

![](img/5.apm_5.png)

### Step4: Analyze Data in <<< custom_key.brand_name >>> Explorer

After starting the script file, try accessing the Python application. You can then view and analyze trace data in the "Application Performance Monitoring" section of the <<< custom_key.brand_name >>> workspace.

1) In "Application Performance Monitoring" - "Services," you can see two collected services, including service type, request count, response time, etc.

![](img/5.apm_6.png)

2) In "Application Performance Monitoring" - "Traces," you can see creation time, status, duration, etc., for the Flask service traces.

![](img/5.apm_7.png)

3) Clicking on a trace allows you to view detailed information, including flame graphs, Span lists, service call relationships, and associated logs and hosts. This helps you quickly identify issues, ensure system stability, and improve user experience.

![](img/5.apm_8.png)

Explanation of key terms related to traces. For more details on trace analysis, refer to the documentation [Trace Analysis](../application-performance-monitoring/explorer/explorer-analysis.md).

| Keyword | Explanation |
| --- | --- |
| Service | The service name, customizable when adding Trace monitoring |
| Resource | The entry point for handling independent access requests in the Application |
| Duration | Response time, the complete request process from when the Application receives the request until it returns a response |
| Status | Status can be OK or ERROR, including error rate and error count |
| Span | A single operation method call throughout the entire Trace path, composed of multiple Span units |

## Advanced References

### Configure Associated Logs

1) Navigate to the `conf.d/log` directory under the DataKit installation directory `/usr/local/datakit`, copy `logging.conf.sample` and rename it to `logging.conf`. Edit the `logging.conf` file, enter the service log storage path of your application in `logfiles`, and enter the log source name in `source`. Save and restart DataKit. For more details on log collectors and log pipeline splitting, refer to the documentation [Logs](../integrations/logging.md).

```
## Navigate to the log directory
cd /usr/local/datakit/conf.d/log/

## Copy the logging configuration file
cp logging.conf.sample logging.conf

## Open and edit the logging configuration file
vim logging.conf 

# After configuring, restart DataKit to apply the changes 
datakit --restart  or service datakit restart  or systemctl restart datakit
```

2) In the startup script file, configure the execution command (inject environment variables to associate trace logs). For more details, refer to the documentation [Associate Logs with APM](../application-performance-monitoring/collection/connect-log/index.md).

```
DD_LOGS_INJECTION="true" DD_AGENT_HOST=localhost DATADOG_TRACE_AGENT_PORT=9529 ddtrace-run python your_app.py
```

Diagram as follows:

![](img/5.apm_10.png)

3) Execute the startup script file, try accessing the Python application, and then you can view the trace flame graph and span list in the log details of the <<< custom_key.brand_name >>> workspace. You can also view related logs in the APM details to help you quickly perform data correlation analysis. Diagram as follows:

- Log Details

![](img/5.apm_11.png)

- APM Details

![](img/5.apm_12.png)

### Configure Associated Web Applications (User Access Monitoring)

User Performance Monitoring tracks complete front-end to back-end request data for web applications using `ddtrace` and `RUM` collectors. Using frontend user access data and the injected `trace_id` into the backend, you can quickly locate the call stack and improve troubleshooting efficiency.

1) In the initialization file of the Python application, add the following configuration to set the whitelist of allowed headers for tracking frontend requests to the target server. For more details, refer to the documentation [Connect Web Application Access](../application-performance-monitoring/collection/connect-web-app.md).

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

2) In the `<head>` of the front-end page `index.html`, add the following user access observability configuration (obtained from creating an application in <<< custom_key.brand_name >>> workspace User Access Monitoring).

```
<script src="https://<<< custom_key.static_domain >>>/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
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

The `allowedTracingOrigins` setting is used to connect frontend and backend (RUM and APM) tracing. Set it according to your needs, filling in the domain names or IPs of backend servers that interact with the frontend page. Other settings are used to collect user access data. For more user access monitoring configurations, refer to the documentation [Web Application Monitoring (RUM) Best Practices](../best-practices/monitoring/web.md).

Diagram as follows:

![](img/5.apm_13.1.png)

3) After configuration, execute the startup script file, try accessing the Python application, and then you can view the associated traces in the User Access Monitoring Explorer details of the <<< custom_key.brand_name >>> workspace to help you quickly perform data correlation analysis. Diagram as follows:

![](img/5.apm_14.png)

### Configure Sampling

<<< custom_key.brand_name >>>'s "Application Performance Monitoring" feature supports analyzing and managing trace data collected by collectors like ddtrace that comply with the Opentracing protocol. By default, it collects all application performance data, meaning every call generates data. Without restrictions, this can result in large volumes of data, consuming significant storage. You can save on data storage and reduce costs by configuring sampling for application performance data collection. For more configuration details, refer to the documentation [How to Configure Application Performance Monitoring Sampling](../application-performance-monitoring/collection/sampling.md).

## Additional References

### [Collect Application Performance Data Using Skywalking](../integrations/skywalking.md)
### [Collect Application Performance Data Using Jaeger](../integrations/jaeger.md)