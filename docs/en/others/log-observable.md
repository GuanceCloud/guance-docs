# How to Enable Log Monitoring
---

<<< custom_key.brand_name >>> possesses comprehensive log collection capabilities, including various types of logs such as system logs, application logs, security logs, and more. Through the custom log collector provided by <<< custom_key.brand_name >>>, any logs can be collected and aggregated into <<< custom_key.brand_name >>> for unified storage and analysis; through the text processor (Pipeline) provided by <<< custom_key.brand_name >>>, the collected logs can be custom-sliced, and the sliced fields can be used as attributes. Through attribute fields, we can quickly filter relevant logs, perform data association analysis, helping us quickly locate and solve problems.

This article uses Nginx logs as an example to introduce how to enable log monitoring.

## Prerequisites

You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/), and install DataKit on your host machine [Install DataKit](../datakit/datakit-install.md).

## Method/Steps

### Step1: Enable the Nginx Collector

After installing Datakit on the host, in the `/usr/local/datakit/conf.d/nginx` directory, copy `nginx.conf.sample` and rename it to `nginx.conf`. Edit `nginx.conf` to specify the location of the Nginx logs and enable Pipeline. For example:

- `files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]`
- `Pipeline = "nginx.p"` (The name inside `""` can be left blank if no specific Pipeline script name is needed; DataKit will automatically match the script file with the same name as the source.)

Note: After enabling the Pipeline, DataKit will automatically match the Pipeline script file based on the log source. If the log source and Pipeline file names do not match, you must configure them accordingly. For instance, if the log source is `nginx` and the Pipeline filename is `nginx1.p`, then configure `Pipeline = "nginx1.p"`.

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

After completing the configuration, use the command line `datakit --restart` to restart DataKit to make the configuration effective. For more Nginx collector configurations, refer to the documentation [Nginx](../integrations/nginx.md).

### Step2: View and Analyze Log Data in the <<< custom_key.brand_name >>> Workspace

After enabling the Nginx collector, configuring the log file path, and enabling the Pipeline, you can view the collected Nginx logs in the <<< custom_key.brand_name >>> workspace.

![](img/13.log_2.png)

Under the "Logs" section in the <<< custom_key.brand_name >>> workspace, select the Nginx logs. In the log details page, you can see the host that generated the logs along with its attribute metrics view, log source, log attributes cut by the Pipeline, detailed log content, etc. By [configuring link-associated logs](../application-performance-monitoring/collection/connect-log/index.md), you can also view related trace details on the log details page, assisting you in performing quick data association analysis.

![](img/13.log_1.png)

## Advanced Reference

### Log Text Processing (Pipeline)

<<< custom_key.brand_name >>> provides two ways for log Pipeline text processing:

- [Pipelines](../pipeline/index.md): Supports manually configuring and viewing log pipeline files within the <<< custom_key.brand_name >>> workspace without logging into the DataKit server, making it convenient to use the online log Pipeline feature to parse your logs.

- DataKit: After installing DataKit on the server, configure the DataKit log collector and corresponding pipeline file in the terminal tool to process the text data.

### Generate Metrics

<<< custom_key.brand_name >>> supports generating custom metric data based on existing data within the current workspace. In the <<< custom_key.brand_name >>> workspace under "Logs" - "Generate Metrics," click "Create" to start creating new generation metric rules. For more details, refer to the documentation [Generate Metrics](../metrics/generate-metrics.md).

![](img/13.log_9.png)

The generated metrics can be viewed uniformly in <<< custom_key.brand_name >>> "Metrics" or on the "Generate Metrics" page by clicking "View Metrics" to the right of the rule to jump to the "Metrics" page to view the corresponding metric sets and metrics.

![](img/13.log_9.1.png)

The generated metrics support building dashboards in <<< custom_key.brand_name >>> "Use Cases" combining other metrics for comprehensive visual monitoring of collected log data.

![](img/13.log_9.2.png)

### Log Blacklist

<<< custom_key.brand_name >>> supports filtering out logs that meet certain criteria by setting up a log blacklist. After configuring the log blacklist, logs that meet the conditions are no longer reported to the "<<< custom_key.brand_name >>>" workspace, helping users save on log data storage costs.

In the <<< custom_key.brand_name >>> workspace, click "Logs" - "Blacklist" - "Create Blacklist," select "Log Source," add one or more log filtering rules, and click confirm to enable the log filtering rule by default.

![](img/13.log_3.png)

After setting the log blacklist to filter out all logs with the source "nginx," after the settings take effect, we can see that nginx logs are no longer reported to the workspace after "02/24 15:06:28." For more details, refer to the documentation [Log Blacklist](../logs/blacklist.md).

![](img/13.log_4.1.png)

### Log Backup

Basic logs in <<< custom_key.brand_name >>> can be stored for up to 60 days. If you need longer storage and viewing, you need to back up the basic logs. Log backup supports two methods:

- Back up to "<<< custom_key.brand_name >>>": Supports storing backed-up logs for up to 720 days.
- Back up to external storage: Supports backing up logs to Alibaba Cloud OSS. Refer to the document [Best Practices for Backing Up Log Data to OSS via Func](../best-practices/partner/log-backup-to-oss-by-func.md).

On the "Backup Logs" page, click "Log Backup Management" - "Create Rule," input the "Rule Name" to add a new rule. You can precisely target the logs to back up by using "Filter Conditions" and "Search Keywords," saving on log backup storage costs.

**Note:**

- Backup cycle: Daily backups starting at `00:00:00` for logs from the previous day `00:00:00—23:59:59`.
- Free Plan users: Cannot back up log data.

![](img/13.log_6.png)

After setting the log backup rule, by default, the data in the "Backup Logs" page is empty. You need to first select the time range for viewing backup logs. For more details, refer to the documentation [Log Backup](../management/backup/index.md).

![](img/13.log_10.1.png)