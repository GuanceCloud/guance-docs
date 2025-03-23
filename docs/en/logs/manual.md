# LOG Pipeline User Manual
---

The Pipeline supports text parsing of log data in different formats. By writing Pipeline scripts, you can customize the extraction of structured logs that meet requirements and use the extracted fields as attributes. Through these attribute fields, we can quickly filter related logs, perform data correlation analysis, helping us to quickly locate and solve problems.

<<< custom_key.brand_name >>> provides an official Pipeline script library with built-in log parsing Pipelines. It also supports users creating custom Pipeline scripts. The following will introduce how to use the custom Pipeline feature.

## Prerequisites

1. You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/), and install DataKit on your host [Install DataKit](../../datakit/datakit-install.md);
1. Enable the log collector and turn on the Pipeline function in the configuration file;

## Custom Pipeline Script File

### Step One: Enable the Log Collector (using DataKit logs as an example)

After installing DataKit on the host, under the `/usr/local/datakit/conf.d/log` directory, copy `logging.conf.sample` and rename it to `logging.conf`. Edit `logging.conf`, configure the path for storing DataKit logs and the log source. For example:

- `logfiles = ["/var/log/datakit/log"]`
- `source = "datakit"`

**Note**: In the log collector, the Pipeline function is enabled by default. In `Pipeline = ""`, you don't need to fill in the specific Pipeline script name. We will automatically match a script file with the same name as the source. If the log source and the Pipeline file name do not match, then specify the Pipeline in the log collector configuration `Pipeline = "xxxxxx.p"`.

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
  ## glob filteer
  ignore = [""]

  ## your logging source, if it's empty, use 'default'
  source = "datakit"

  ## add service tag, if it's empty, use $source.
  service = ""

  ## grok pipeline script name
  ## If pipeline does not specify a concrete one, it will automatically look for a script with the same name as the source
  pipeline = ""
```

After completing the configuration, restart DataKit using the command line `datakit --restart` to make the configuration take effect.

### Step Two: Determine Fields to Parse Based on Collected Logs

After enabling the log collector, you can view the collected DataKit logs in the <<< custom_key.brand_name >>> workspace. Observe and analyze DataKit logs to determine the log parsing fields, such as the time the log was generated, the log level, the log module, the module content, and the log content, etc.

![](../img/12.pipeline_4.png)

### Step Three: Create a Custom Pipeline

In the <<< custom_key.brand_name >>> workspace **LOG > Pipelines**, click **Create Pipeline** to create a new Pipeline file.
#### Filter Logs

Select the log source as “datakit”. A Pipeline with the same name as the selected log source will be automatically generated.

#### Define Parsing Rules

Define the parsing rules for the logs. Multiple script functions are supported, and you can directly view their syntax format through the script function list provided by <<< custom_key.brand_name >>>.

In this example, based on the observation results of the logs, you can write a Pipeline script file. We can use the `add_pattern()` script function to first define a pattern and reference the custom pattern in Grok to parse the logs. As shown below, where `rename` and `default_time` optimize the parsed fields.

```
add_pattern('_dklog_date', '%{YEAR}-%{MONTHNUM}-%{MONTHDAY}T%{HOUR}:%{MINUTE}:%{SECOND}%{INT}')
add_pattern('_dklog_level', '(DEBUG|INFO|WARN|ERROR|FATAL)')
add_pattern('_dklog_mod', '%{WORD}')
add_pattern('_dklog_source_file', '(/?[\\w_%!$@:.,-]?/?)(\\S+)?')
add_pattern('_dklog_msg', '%{GREEDYDATA}')

grok(_, '%{_dklog_date:log_time}%{SPACE}%{_dklog_level:level}%{SPACE}%{_dklog_mod:module}%{SPACE}%{_dklog_source_file:code}%{SPACE}%{_dklog_msg:msg}')
rename("time", log_time) # Rename log_time to time
default_time(time)       # Use the time field as the timestamp for the output data
```

> For more Pipeline parsing rules, refer to the documentation [Text Data Processing (Pipeline)](../pipeline/use-pipeline/index.md).

#### Log Sample Testing
After writing the script rules, you can input log sample data for testing to verify whether the configured parsing rules are correct.

**Note**:

- Log sample testing is optional;
- After saving the custom Pipeline, the log sample test data will be saved synchronously.

![](../img/12.pipeline_5.1.png)

### Step Four: Save the Pipeline File

After completing all mandatory configurations, save the Pipeline file. You can then view the custom Pipeline file in the LOG Pipelines list.

![](../img/12.pipeline_5.png)

Custom Pipeline files created in the <<< custom_key.brand_name >>> workspace are uniformly saved in the `/usr/local/datakit/Pipeline_remote` directory.

![](../img/12.pipeline_5.0.png)

**Note**: DataKit has two Pipeline directories, and DataKit will automatically match the Pipeline files in these directories.

- `Pipeline`: Directory for official library Pipeline files;
- `Pipeline_remote`: Directory for <<< custom_key.brand_name >>> workspace custom Pipeline files;
- If there are Pipeline files with the same name in both directories, DataKit will prioritize matching the Pipeline files in the `Pipeline_remote` directory.

### Step Five: View the Parsed Fields in <<< custom_key.brand_name >>>

Under the LOG section in the <<< custom_key.brand_name >>> workspace, select the datakit logs, and in the log details page, you can see the fields and field values under "Attributes". These are the fields and field values displayed after the log parsing. For example:

- `code: container/input.go:167`
- `level: ERROR`
- `module: container`

![](../img/12.pipeline_3.png)

## Clone Official Library Pipeline Script Files

### Step One: Enable Nginx Collector

After installing DataKit on the host, under the `/usr/local/datakit/conf.d/nginx` directory, copy `nginx.conf.sample` and rename it to `nginx.conf`. Edit `nginx.conf` to enable the location for storing Nginx logs and the Pipeline. For example:

- `files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]`
- `Pipeline = "nginx.p"` (in `""`, you don’t need to fill in the specific Pipeline script name; DataKit will automatically match a script file with the same name as the source.)

**Note**: After enabling the Pipeline, DataKit will automatically match the Pipeline script file according to the log source. If the log source and the Pipeline file name do not match, then configure it in the collector, such as the log source `nginx`, and the Pipeline filename `nginx1.p`, then configure `Pipeline = "nginx1.p"`.

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

After completing the configuration, use the command line `datakit --restart` to restart DataKit and make the configuration take effect.

> For more Nginx collector configurations, refer to [Nginx](../../integrations/nginx.md).

### Step Two: Determine Parsing Fields Based on Collected Logs

After enabling the Nginx collector and configuring the log file paths and Pipeline, you can view the collected Nginx logs in the <<< custom_key.brand_name >>> workspace. In the log details, you can check the fields parsed according to the Pipeline file. Observe and analyze the logs to determine whether optimization of the parsed fields is needed.

![](../img/12.pipeline_12.png)

### Step Three: Clone and Customize the Official Library Pipeline

In the <<< custom_key.brand_name >>> workspace **LOG > Pipelines**, click **Official Pipeline Library**, select and clone the `nginx.p` Pipeline file.

- In **Filter Logs**, choose “nginx”;
- In **Define Parsing Rules**, optimize the [parsing rules](../pipeline/use-pipeline/index.md);
- In **Log Sample Testing**, input nginx log data and test according to the configured parsing rules.

**Note**:

- The official Pipeline library includes multiple log sample test data sets. Before cloning, you can select log sample test data that meets your needs;
- After modifying and saving the cloned Pipeline, the log sample test data will be saved synchronously.


```
2022/02/23 14:26:19 [error] 632#632: *62 connect() failed (111: Connection refused) while connecting to upstream, client: ::1, server: _, request: "GET /server_status HTTP/1.1", upstream: "http://127.0.0.1:5000/server_status", host: "localhost"
```

![](../img/12.pipeline_9.1.png)

### Step Four: Save the Pipeline File

After completing all mandatory configurations, save the Pipeline file. You can then view the customized Pipeline file in the LOG Pipelines list.

![](../img/12.pipeline_9.png)

Custom Pipeline files created in the <<< custom_key.brand_name >>> workspace are uniformly saved in the `/usr/local/datakit/Pipeline_remote` directory.

![](../img/12.pipeline_10.png)

**Note**: DataKit has two Pipeline directories, and DataKit will automatically match the Pipeline files in these directories.

- `Pipeline`: Directory for official library Pipeline files;
- `Pipeline_remote`: Directory for <<< custom_key.brand_name >>> workspace custom Pipeline files;
- If there are Pipeline files with the same name in both directories, DataKit will prioritize matching the Pipeline files in the `Pipeline_remote` directory.

### Step Five: View the Parsed Fields in <<< custom_key.brand_name >>>

Under the LOG section in the <<< custom_key.brand_name >>> workspace, select the `nginx` logs, and in the log details page, you can see the fields and field values under "Attributes". These are the fields and field values displayed after the log parsing. For example:

- `http_method: GET`
- `http_url: /server_status`
- `http_version: 1.1`

![](../img/12.pipeline_11.png)

## Further Reading

<font size=3>

For more about the <<< custom_key.brand_name >>> workspace LOG Pipeline user manual, and additional content on Pipeline and log collection and parsing, refer to the following documents:

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Text Data Processing (Pipeline)**</font>](../pipeline/index.md)
- 
</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **How to Write Pipeline Scripts**</font>](../pipeline/use-pipeline/pipeline-quick-start.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **LOG**</font>](../integrations/logging.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Third-party Log Integration**</font>](../integrations/logstreaming.md)

</div>


</font>