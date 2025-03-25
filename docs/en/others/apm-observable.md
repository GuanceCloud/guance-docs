# How to Enable Application Performance Monitoring
---

Application Performance Monitoring (APM) is mainly used to view the overall operation status, health level, external APIs, database calls, and the consumption or abnormal issues of your own code and its called resources. It helps enterprises quickly locate problems at their root cause, ensuring application performance and system stability.

<<< custom_key.brand_name >>>'s APM supports all APM tools based on the Opentracing protocol, such as ddtrace, Skywalking, Zipkin, Jaege, etc. By enabling the corresponding collector in DataKit and adding relevant monitoring files to the application code that needs monitoring, you can view the reported tracing data in <<< custom_key.brand_name >>> workspace after configuration. This data can be associated with infrastructure, logs, and RUM for analysis, allowing for quick fault location and resolution, enhancing user experience.

This document will use a Python application to introduce how to achieve APM observability through ddtrace.
## Prerequisites

You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/) and [install DataKit](../datakit/datakit-install.md) on your host.

## Method/Steps

### Step1: Enable and Configure ddtrace.conf Collector

Navigate to the `conf.d/ddtrace` directory under the DataKit installation directory, copy `ddtrace.conf.sample` and rename it to `ddtrace.conf`. Open `ddtrace.conf`, where `inputs` are enabled by default and no modification is required.

```
## Navigate to the ddtrace directory
cd /usr/local/datakit/conf.d/ddtrace/

## Copy the ddtrace configuration file
cp ddtrace.conf.sample ddtrace.conf

## Open and edit the ddtrace configuration file
vim ddtrace.conf 

# After configuration, restart DataKit to make the settings effective 
datakit --restart  or  service datakit restart  or systemctl restart datakit
```

![](img/5.apm_1.png)

Note: `endpoints` are enabled by default; do not modify them.

<<< custom_key.brand_name >>> supports custom tags for APM correlation queries, which can be injected via command-line environment variables or by enabling `inputs.ddtrace.tags` in `ddtrace.conf` and adding `tags`. For detailed configurations, refer to the documentation [ddtrace Environment Variable Settings](../integrations/ddtrace.md).

### Step2: Install ddtrace

To collect tracing data using ddtrace, you need to choose the appropriate language for the application being monitored. In this article, we'll use a Python application as an example. For Java or other languages, refer to the documentation [Best Practices for Distributed Tracing (APM)](../best-practices/monitoring/apm.md).

Run the command `pip install ddtrace` in the terminal to install ddtrace.

![](img/5.apm_2.png)

### Step3: Configure Application Startup Script

#### Method One: Configure DataKit Service Address in the Application Initialization Configuration File

1) Configure the DataKit service address. You need to enter the initialization configuration file of the application and add the following configuration content:

```
tracer.configure(
    hostname = "localhost",  # Depending on the specific DataKit address
    port     = "9529",
)
```


2) Configure the application service startup script file. You need to add the startup script file command, such as:

```
ddtrace-run python your_app.py
```

For more details, see the documentation [Python Example](../integrations/ddtrace-python.md).

#### Method Two: Directly Configure DataKit Service Address in the Startup Script File

<<< custom_key.brand_name >>> supports configuring the DataKit service address directly via the startup script file without modifying your application code. In this example, a Python application named "todoism" has been created. Navigate to the script file directory of this application and execute its script file according to your actual application.

1) Configure the execution command in the startup script file (inject environment variables)

```
DD_AGENT_HOST=localhost DATADOG_TRACE_AGENT_PORT=9529 ddtrace-run python your_app.py
```

The schematic diagram is as follows:

![](img/5.apm_3.png)

2) Navigate to the startup script file directory and execute the startup script file `./boot.sh` to start the Python application. The schematic diagram is as follows:

![](img/5.apm_4.png)

**Note:** For security reasons, DataKit's HTTP service is bound to `localhost:9529` by default. If you wish to enable external network access, you can edit `conf.d/datakit.conf` and change `listen` to `0.0.0.0:9529` (port is optional). At this point, ddtrace's access address would be `http://<datakit-ip>:9529`. If the trace data originates from the same machine as DataKit, there’s no need to modify the `listen` configuration; simply use `http://localhost:9529`.

![](img/5.apm_5.png)

### Step4: Analyze Data in <<< custom_key.brand_name >>> Explorer

After starting the script file, you can try accessing the Python application and then analyze the tracing data in the "Application Performance Monitoring" section of the <<< custom_key.brand_name >>> workspace.

1) In "Application Performance Monitoring" - "Services," you can view the two services collected. Includes service type, request count, response time, etc.

![](img/5.apm_6.png)

2) In "Application Performance Monitoring" - "Traces," you can view the creation time, status, duration, etc., of the flask service traces.

![](img/5.apm_7.png)

3) Click on the trace to view the trace details, including flame graphs, Span lists, service call relationships, and associated logs and hosts. This can help you quickly locate issues, ensure system stability, and improve user experience.

![](img/5.apm_8.png)

Explanation of related trace terms. For more information about traces, refer to the documentation [Trace Analysis](../application-performance-monitoring/explorer/explorer-analysis.md).

| Keyword | Definition |
| --- | --- |
| Services | i.e., service_name, customizable when adding Trace monitoring |
| Resources | Refers to the request entry point in handling independent visit requests within the Application |
| Duration | i.e., response time, the complete request process starts when the Application receives the request and ends when it returns the response |
| Status | Divided into OK and ERROR, errors include error rates and error counts |
| Spans | A single operation method call throughout the process constitutes a Trace link, consisting of multiple Span units |

## Advanced References

### Configuring Associated Logs

1) Navigate to the `/usr/local/datakit/conf.d/log/` directory under the DataKit installation directory on the host, copy `logging.conf.sample` and name it `logging.conf`. Edit the `logging.conf` file and fill in the storage path of your application's service logs in `logfiles` and the log source name in `source`. Save and restart DataKit. For more details about the log collector and log pipeline slicing, refer to the documentation [Logs](../integrations/logging.md).

```
## Navigate to the log directory
cd /usr/local/datakit/conf.d/log/

## Copy the logging configuration file
cp logging.conf.sample logging.conf

## Open and edit the logging configuration file
vim logging.conf 

# After configuration, restart DataKit to make the settings effective 
datakit --restart  or  service datakit restart  or systemctl restart datakit
```

2) In the startup script file, configure the execution command (inject environment variables associated with trace logs). For more detailed configurations, refer to the documentation [Associate Logs with Application Performance Monitoring](../application-performance-monitoring/collection/connect-log/index.md).

```
DD_LOGS_INJECTION="true" DD_AGENT_HOST=localhost DATADOG_TRACE_AGENT_PORT=9529 ddtrace-run python your_app.py
```

The schematic diagram is as follows:

![](img/5.apm_10.png)

3) Start the script file, try accessing the Python application, and then you can view the trace flame graph and span list in the log details in the <<< custom_key.brand_name >>> workspace, as well as related logs in the application performance monitoring details, helping you quickly perform data association analysis. Schematic diagrams are as follows:

- Log Details

![](img/5.apm_11.png)

- Application Performance Details

![](img/5.apm_12.png)

### Configuring Web Application Association (User Access Monitoring)

User performance monitoring through `ddtrace` and `RUM` collectors can track the full request data from the frontend to the backend of a web application. Using user access data from the frontend and the injected `trace_id` into the backend allows for quick stack trace positioning, improving troubleshooting efficiency.

1) In the initialization file of the Python application, add the following configuration to set the whitelist of allowed headers for tracking frontend requests to the target server. For more details, refer to the documentation [Associate Web Application Access](../application-performance-monitoring/collection/connect-web-app.md).

```
@app.after_request
def after_request(response):
 ...
 response.headers.add('Access-Control-Allow-Headers', 'x-datadog-parent-id,x-datadog-sampled,x-datadog-sampling-priority,x-datadog-trace-id')
 ....
 return response
 ....
```

The schematic diagram is as follows:

![](img/5.apm_13.png)

2) Add the following user access observability configuration in the head of the front-end page index.html (acquired by creating an application in the User Access Monitoring viewer in the <<< custom_key.brand_name >>> workspace).

```
<script src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'appid_68fa6ec4f56f4b78xxxxxxxxxxxxxxxx',
      datakitOrigin: '<DATAKIT ORIGIN>', // Protocol (including ://), domain name (or IP address) [and port number]
      env: 'production',
      version: '1.0.0',
      trackInteractions: true,
      allowedTracingOrigins: ["https://api.example.com", /https:\/\/.*\.my-api-domain\.com/]
    })
</script>
```

`allowedTracingOrigins` is the configuration item used to connect the frontend and backend (rum and apm). Set it as needed, filling in the domain names or IPs of the backend servers interacting with the front-end pages. Other configuration items are used to collect user access data. For more user access monitoring configurations, refer to the documentation [Best Practices for Web Application Monitoring (RUM)](../best-practices/monitoring/web.md).

The schematic diagram is as follows:

![](img/5.apm_13.1.png)

3) After configuration, start the script file, try accessing the Python application, and then you can view the associated traces in the User Access Monitoring explorer details in the <<< custom_key.brand_name >>> workspace, helping you quickly perform data association analysis. The schematic diagram is as follows:

![](img/5.apm_14.png)

### Configuring Sampling

<<< custom_key.brand_name >>>'s "Application Performance Monitoring" feature supports analyzing and managing trace data collected by collectors like ddtrace that comply with the Opentracing protocol. By default, it collects application performance data in full volume mode, meaning data is generated with every call. If left unrestricted, the amount of collected data could be large, consuming excessive data storage. You can save on data storage and reduce costs by setting sampling methods to collect application performance data. For more configuration details, refer to the documentation [How to Configure Application Performance Monitoring Sampling](../application-performance-monitoring/collection/sampling.md).

## More References

### [Collect Application Performance Data via Skywalking](../integrations/skywalking.md)
### [Collect Application Performance Data via Jaeger](../integrations/jaeger.md)