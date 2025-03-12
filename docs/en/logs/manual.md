# Log Pipeline User Manual
---

The Pipeline supports parsing log data of different formats through writing Pipeline scripts, allowing users to customize structured logs that meet requirements. The fields extracted can be used as attributes. Using these attribute fields, we can quickly filter related logs and perform data correlation analysis, helping us rapidly locate and solve issues.

<<< custom_key.brand_name >>> provides an official Pipeline script library with built-in log parsing Pipelines. It also supports the creation of custom Pipeline scripts by users. Next, we will introduce how to use the custom Pipeline feature.

## Prerequisites

1. You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/), and install DataKit on your host [Install DataKit](../../datakit/datakit-install.md);
2. Enable the log collector and turn on the Pipeline function in the configuration file;

## Custom Pipeline Script File

### Step One: Enable Log Collector (Using DataKit Logs as an Example)

After installing DataKit on the host, under the `/usr/local/datakit/conf.d/log` directory, copy `logging.conf.sample` and rename it to `logging.conf`. Edit `logging.conf` to configure the path for storing DataKit logs and the log source. For example:

- `logfiles = ["/var/log/datakit/log"]`
- `source = "datakit"`

**Note**: In the log collector, the Pipeline function is enabled by default. In `Pipeline = ""`, you do not need to specify a specific Pipeline script name; it will automatically match the script file with the same name as the source. If the log source and Pipeline file names do not match, you need to configure `Pipeline = "xxxxxx.p"` in the log collector.

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
  ## if pipeline is not specified, it will automatically look for a script with the same name as the source
  pipeline = ""
```

After completing the configuration, restart DataKit using the command line `datakit --restart` to apply the changes.

### Step Two: Determine Fields to Extract Based on Collected Logs

After enabling the log collector, you can view the collected DataKit logs in the <<< custom_key.brand_name >>> workspace. Observe and analyze the DataKit logs to determine the fields to extract, such as log generation time, log level, log module, module content, and log content.

![](../img/12.pipeline_4.png)

### Step Three: Create a Custom Pipeline

In the <<< custom_key.brand_name >>> workspace **Logs > Pipelines**, click **Create Pipeline** to create a new Pipeline file.
#### Filter Logs

Select the log source as “datakit”, and the Pipeline with the same name as the selected log source will be auto-generated.

#### Define Parsing Rules

Define the parsing rules for the logs. Multiple script functions are supported, and you can directly view their syntax format from the list of script functions provided by <<< custom_key.brand_name >>>.

Based on the observed results of the logs, you can write a Pipeline script file. We can use the `add_pattern()` script function to define custom patterns and reference them in Grok to parse the logs. For example, `rename` and `default_time` optimize the extracted fields.

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
- After saving the custom Pipeline, the log sample test data is synchronized and saved.

![](../img/12.pipeline_5.1.png)

### Step Four: Save the Pipeline File

After completing all mandatory configurations, save the Pipeline file. You can then view the custom Pipeline file in the log Pipelines list.

![](../img/12.pipeline_5.png)

Custom Pipeline files created in the <<< custom_key.brand_name >>> workspace are uniformly saved in the `/usr/local/datakit/Pipeline_remote` directory.

![](../img/12.pipeline_5.0.png)

**Note**: DataKit has two Pipeline directories, and it will automatically match the Pipeline files under these directories.

- `Pipeline`: Directory for official Pipeline files;
- `Pipeline_remote`: Directory for custom Pipeline files created in the <<< custom_key.brand_name >>> workspace;
- If there are Pipeline files with the same name in both directories, DataKit will prioritize matching the Pipeline file in the `Pipeline_remote` directory.

### Step Five: View Extracted Fields in <<< custom_key.brand_name >>>

In the <<< custom_key.brand_name >>> workspace logs, select datakit logs, and in the log details page, you can see the fields and field values under "Attributes". These are the fields and field values displayed after log parsing. For example:

- `code: container/input.go:167`
- `level: ERROR`
- `module: container`

![](../img/12.pipeline_3.png)

## Clone Official Library Pipeline Script Files

### Step One: Enable Nginx Collector

After installing DataKit on the host, under the `/usr/local/datakit/conf.d/nginx` directory, copy `nginx.conf.sample` and rename it to `nginx.conf`. Edit `nginx.conf` to enable the storage location for Nginx logs and the Pipeline. For example:

- `files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]`
- `Pipeline = "nginx.p"` (In `""`, you do not need to specify a specific Pipeline script name; DataKit will automatically match the script file with the same name as the source)

**Note**: After enabling the Pipeline, DataKit will automatically match the Pipeline script file based on the log source. If the log source and Pipeline file names do not match, you need to configure it in the collector, such as for the log source `nginx` and Pipeline file name `nginx1.p`, you need to configure `Pipeline = "nginx1.p"`.

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

After completing the configuration, use the command line `datakit --restart` to restart DataKit to apply the changes.

> For more Nginx collector configurations, refer to [Nginx](../../integrations/nginx.md).

### Step Two: Determine Fields to Extract Based on Collected Logs

After enabling the Nginx collector, configuring the log file path, and enabling the Pipeline, you can view the collected Nginx logs in the <<< custom_key.brand_name >>> workspace. In the log details, you can view the field attributes parsed according to the Pipeline file. Observe and analyze the logs to determine whether optimization of the parsed fields is needed.

![](../img/12.pipeline_12.png)

### Step Three: Clone and Customize Official Library Pipeline

In the <<< custom_key.brand_name >>> workspace **Logs > Pipelines**, click **Official Pipeline Library**, select and clone the `nginx.p` Pipeline file.

- Select “nginx” in **Filter Logs**;
- Optimize the [parsing rules](../pipeline/use-pipeline/index.md) in **Define Parsing Rules**;
- Input Nginx log data in **Test Log Samples** and test based on the configured parsing rules.

**Note**:

- The official Pipeline library includes multiple log sample test data. Before cloning, you can choose the log sample test data that fits your needs;
- After modifying and saving the cloned Pipeline, the log sample test data is synchronized and saved.

```
2022/02/23 14:26:19 [error] 632#632: *62 connect() failed (111: Connection refused) while connecting to upstream, client: ::1, server: _, request: "GET /server_status HTTP/1.1", upstream: "http://127.0.0.1:5000/server_status", host: "localhost"
```

![](../img/12.pipeline_9.1.png)

### Step Four: Save the Pipeline File

After completing all mandatory configurations, save the Pipeline file. You can then view the custom Pipeline file in the log Pipelines list.

![](../img/12.pipeline_9.png)

Custom Pipeline files created in the <<< custom_key.brand_name >>> workspace are uniformly saved in the `/usr/local/datakit/Pipeline_remote` directory.

![](../img/12.pipeline_10.png)

**Note**: DataKit has two Pipeline directories, and it will automatically match the Pipeline files under these directories.

- `Pipeline`: Directory for official Pipeline files;
- `Pipeline_remote`: Directory for custom Pipeline files created in the <<< custom_key.brand_name >>> workspace;
- If there are Pipeline files with the same name in both directories, DataKit will prioritize matching the Pipeline file in the `Pipeline_remote` directory.

### Step Five: View Extracted Fields in <<< custom_key.brand_name >>>

In the <<< custom_key.brand_name >>> workspace logs, select `nginx` logs, and in the log details page, you can see the fields and field values under "Attributes". These are the fields and field values displayed after log parsing. For example:

- `http_method: GET`
- `http_url: /server_status`
- `http_version: 1.1`

![](../img/12.pipeline_11.png)

## Further Reading

<font size=3>

For more information about Pipeline and log collection and parsing in the <<< custom_key.brand_name >>> workspace, refer to the following documents:

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Text Data Processing (Pipeline)**</font>](../pipeline/index.md)
- 
</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **How to Write a Pipeline Script**</font>](../pipeline/use-pipeline/pipeline-quick-start.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Logs**</font>](../integrations/logging.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Third-party Log Integration**</font>](../integrations/logstreaming.md)

</div>


</font>