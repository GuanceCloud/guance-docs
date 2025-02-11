# Log Pipeline User Manual
---

The Pipeline supports parsing log data of different formats through writing Pipeline scripts, allowing users to customize structured logs that meet requirements. The fields extracted can be used as attributes for quick log filtering and data correlation analysis, helping to quickly locate and resolve issues.

Guance provides an official Pipeline script library with built-in log parsing Pipelines. It also supports the creation of custom Pipeline scripts by users. Below is an introduction on how to use the custom Pipeline feature.

## Prerequisites

1. You need to first create a [Guance account](https://www.guance.com/), and install DataKit on your host machine according to [these instructions](../../datakit/datakit-install.md);
2. Enable the log collector and turn on the Pipeline function in the configuration file;

## Custom Pipeline Script File

### Step One: Enable Log Collector (Using DataKit Logs as an Example)

After installing DataKit on your host machine, navigate to the `/usr/local/datakit/conf.d/log` directory. Copy `logging.conf.sample` and rename it to `logging.conf`. Edit `logging.conf` to specify the path where DataKit logs are stored and the source of the logs. For example:

- `logfiles = ["/var/log/datakit/log"]`
- `source = "datakit"`

**Note**: In the log collector, the Pipeline function is enabled by default. In `Pipeline = ""`, you do not need to specify a particular Pipeline script name; we will automatically match a script file with the same name as the source. If the log source and Pipeline file names do not match, then configure `Pipeline = "xxxxxx.p"` in the log collector.

```
[[inputs.logging]]
  ## required
  logfiles = [
    "/var/log/datakit/log",
  ]
  # only two protocols are supported: TCP and UDP
  # sockets = [
  #      "tcp://0.0.0.0:9530",
  #      "udp://0.0.0.0:9531",
  # ]
  ## glob filter
  ignore = [""]

  ## your logging source, if it's empty, use 'default'
  source = "datakit"

  ## add service tag, if it's empty, use $source.
  service = ""

  ## grok pipeline script name
  ## if no specific pipeline is specified, it will automatically look for a script with the same name as the source
  pipeline = ""
```

After completing the configuration, use the command line `datakit --restart` to restart DataKit and apply the changes.

### Step Two: Determine Fields for Parsing Based on Collected Logs

After enabling the log collector, you can view the collected DataKit logs in the Guance workspace. Observe and analyze the DataKit logs to determine the fields to parse, such as the time the log was generated, log level, log module, module content, and log content.

![](../img/12.pipeline_4.png)

### Step Three: Create a Custom Pipeline

In the Guance workspace **Logs > Pipelines**, click **Create New Pipeline** to create a new Pipeline file.
#### Filter Logs

Select "datakit" as the log source, which will automatically generate a Pipeline with the same name as the source.

#### Define Parsing Rules

Define parsing rules for logs, supporting multiple script functions. You can directly check the syntax format of these functions from the list provided by Guance.

Based on the observed results of the logs, you can write a Pipeline script file. Using the `add_pattern()` script function, define patterns and reference them in Grok to parse logs. The following example includes `rename` and `default_time` optimizations for parsed fields.

```
add_pattern('_dklog_date', '%{YEAR}-%{MONTHNUM}-%{MONTHDAY}T%{HOUR}:%{MINUTE}:%{SECOND}%{INT}')
add_pattern('_dklog_level', '(DEBUG|INFO|WARN|ERROR|FATAL)')
add_pattern('_dklog_mod', '%{WORD}')
add_pattern('_dklog_source_file', '(/?[\\w_%!$@:.,-]?/?)(\\S+)?')
add_pattern('_dklog_msg', '%{GREEDYDATA}')

grok(_, '%{_dklog_date:log_time}%{SPACE}%{_dklog_level:level}%{SPACE}%{_dklog_mod:module}%{SPACE}%{_dklog_source_file:code}%{SPACE}%{_dklog_msg:msg}')
rename("time", log_time) # Rename log_time to time
default_time(time)       # Use the time field as the timestamp for output data
```

> For more Pipeline parsing rules, refer to the documentation [Text Data Processing (Pipeline)](../pipeline/use-pipeline/index.md).

#### Test Log Samples
After writing the script rules, you can input log sample data for testing to verify whether the configured parsing rules are correct.

**Note**:

- Testing log samples is optional;
- After saving the custom Pipeline, the log sample test data will be saved synchronously.

![](../img/12.pipeline_5.1.png)

### Step Four: Save the Pipeline File

After completing all mandatory configurations, save the Pipeline file. You can then see the custom Pipeline file in the list of log Pipelines.

![](../img/12.pipeline_5.png)

Custom Pipeline files created in the Guance workspace are uniformly saved in the `/usr/local/datakit/Pipeline_remote` directory.

![](../img/12.pipeline_5.0.png)

**Note**: DataKit has two Pipeline directories, and it will automatically match Pipeline files under these directories.

- `Pipeline`: Directory for official Pipeline files;
- `Pipeline_remote`: Directory for custom Pipeline files in the Guance workspace;
- If there are Pipeline files with the same name in both directories, DataKit will prioritize matching the Pipeline files in the `Pipeline_remote` directory.

### Step Five: View Parsed Fields in Guance

In the Guance workspace logs, select datakit logs, and in the log details page, you can see the fields and their values under "Attributes." These are the fields and their values displayed after parsing the logs. For example:

- `code: container/input.go:167`
- `level: ERROR`
- `module: container`

![](../img/12.pipeline_3.png)

## Clone Official Library Pipeline Script Files

### Step One: Enable Nginx Collector

After installing DataKit on your host machine, navigate to the `/usr/local/datakit/conf.d/nginx` directory. Copy `nginx.conf.sample` and rename it to `nginx.conf`. Edit `nginx.conf` to specify the paths for storing Nginx logs and enable the Pipeline. For example:

- `files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]`
- `Pipeline = "nginx.p"` (You can leave `""` blank, and DataKit will automatically match a script file with the same name as the source)

**Note**: After enabling the Pipeline, DataKit will automatically match the Pipeline script file based on the log source. If the log source and Pipeline file names do not match, you need to configure it in the collector, such as using `nginx` as the log source and `nginx1.p` as the Pipeline filename, requiring `Pipeline = "nginx1.p"`.

```
[[inputs.nginx]]
        url = "http://localhost/server_status"
        # ##(optional) collection interval, default is 30s
        # interval = "30s"
        use_vts = false
        ## Optional TLS Config
        # tls_ca = "/xxx/ca.pem"
        # tls_cert = "/xxx/cert.cer"
        # tls_key = "/xxx/key.key"
        ## Use TLS but skip chain & host verification
        insecure_skip_verify = false
        # HTTP response timeout (default: 5s)
        response_timeout = "20s"

        [inputs.nginx.log]
                files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]
        #       # grok pipeline script path
                pipeline = "nginx.p"
        [inputs.nginx.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
        # ...
```

After completing the configuration, use the command line `datakit --restart` to restart DataKit and apply the changes.

> For more Nginx collector configurations, refer to [Nginx](../../integrations/nginx.md).

### Step Two: Determine Fields for Parsing Based on Collected Logs

Enable the Nginx collector, configure the log file paths, and enable the Pipeline. You can then view the collected Nginx logs in the Guance workspace. In the log details, you can check the fields parsed according to the Pipeline file. Observe and analyze the logs to determine if any optimization of the parsed fields is needed.

![](../img/12.pipeline_12.png)

### Step Three: Clone and Customize Official Library Pipeline

In the Guance workspace **Logs > Pipelines**, click **Official Pipeline Library**, and choose to view and clone the `nginx.p` Pipeline file.

- Select "nginx" in **Filter Logs**;
- Optimize the [parsing rules](../pipeline/use-pipeline/index.md) in **Define Parsing Rules**;
- Input Nginx log data in **Test Log Samples** according to the configured parsing rules.

**Note**:

- The official Pipeline library comes with multiple log sample test data. Before cloning, you can choose the log sample test data that fits your needs;
- After modifying and saving the cloned Pipeline, the log sample test data will be saved synchronously.

```
2022/02/23 14:26:19 [error] 632#632: *62 connect() failed (111: Connection refused) while connecting to upstream, client: ::1, server: _, request: "GET /server_status HTTP/1.1", upstream: "http://127.0.0.1:5000/server_status", host: "localhost"
```

![](../img/12.pipeline_9.1.png)

### Step Four: Save the Pipeline File

After completing all mandatory configurations, save the Pipeline file. You can then see the custom Pipeline file in the list of log Pipelines.

![](../img/12.pipeline_9.png)

Custom Pipeline files created in the Guance workspace are uniformly saved in the `/usr/local/datakit/Pipeline_remote` directory.

![](../img/12.pipeline_10.png)

**Note**: DataKit has two Pipeline directories, and it will automatically match Pipeline files under these directories.

- `Pipeline`: Directory for official Pipeline files;
- `Pipeline_remote`: Directory for custom Pipeline files in the Guance workspace;
- If there are Pipeline files with the same name in both directories, DataKit will prioritize matching the Pipeline files in the `Pipeline_remote` directory.

### Step Five: View Parsed Fields in Guance

In the Guance workspace logs, select `nginx` logs, and in the log details page, you can see the fields and their values under "Attributes." These are the fields and their values displayed after parsing the logs. For example:

- `http_method: GET`
- `http_url: /server_status`
- `http_version: 1.1`

![](../img/12.pipeline_11.png)

## Further Reading

<font size=3>

For more information about the Guance workspace log Pipeline user manual, including more details on Pipeline and log collection and parsing, refer to the following documents:

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Text Data Processing (Pipeline)**</font>](../pipeline/index.md)
- 
</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **How to Write Pipeline Scripts**</font>](../pipeline/use-pipeline/pipeline-quick-start.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Logs**</font>](../integrations/logging.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Third-party Log Integration**</font>](../integrations/logstreaming.md)

</div>


</font>