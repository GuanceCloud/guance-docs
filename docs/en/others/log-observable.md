# How to Enable Log Monitoring
---

<<< custom_key.brand_name >>> offers comprehensive log collection capabilities, including system logs, application logs, security logs, and various other types of logs. Through the custom log collectors provided by <<< custom_key.brand_name >>>, any logs can be collected and aggregated into <<< custom_key.brand_name >>> for unified storage and analysis. Using the text processor (Pipeline) provided by <<< custom_key.brand_name >>>, you can customize the parsing of collected logs and use the parsed fields as attributes. With these attribute fields, we can quickly filter related logs, perform data correlation analysis, and help us quickly locate and resolve issues.

This article uses Nginx logs as an example to introduce how to enable log monitoring.

## Prerequisites

You need to first create a [<<< custom_key.brand_name >>> account](https://www.guance.com/), and install DataKit on your host machine [Install DataKit](../datakit/datakit-install.md).

## Method/Steps

### Step 1: Enable Nginx Collector

After installing DataKit on the host, under the `/usr/local/datakit/conf.d/nginx` directory, copy `nginx.conf.sample` and rename it to `nginx.conf`. Edit `nginx.conf` to specify the location where Nginx logs are stored and enable Pipeline. For example:

- `files = ["/var/log/nginx/access.log", "/var/log/nginx/error.log"]`
- `Pipeline = "nginx.p"` (the script name within `""` can be left blank, and DataKit will automatically match a script file with the same name as the source)

Note: After enabling Pipeline, DataKit will automatically match the Pipeline script file based on the log source. If the log source and Pipeline file names do not match, you need to configure it in the collector settings. For example, if the log source is `nginx` and the Pipeline file name is `nginx1.p`, then you should configure `Pipeline = "nginx1.p"`.

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
                files = ["/var/log/nginx/access.log", "/var/log/nginx/error.log"]
        #       # grok pipeline script path
                pipeline = "nginx.p"
        [inputs.nginx.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
        # ...
```

After completing the configuration, restart DataKit using the command line `datakit --restart` to apply the changes. For more Nginx collector configurations, refer to the [Nginx](../integrations/nginx.md) documentation.

### Step 2: View and Analyze Log Data in <<< custom_key.brand_name >>> Workspace

After enabling the Nginx collector, configuring the log file paths, and enabling Pipeline, you can view the collected Nginx logs in the <<< custom_key.brand_name >>> workspace.

![](img/13.log_2.png)

In the <<< custom_key.brand_name >>> workspace's log section, select the nginx logs. In the log details page, you can see the host that generated the log and its attribute metrics, log sources, parsed log attributes through Pipeline, detailed log content, etc. By [configuring trace association logs](../application-performance-monitoring/collection/connect-log/index.md), you can also view related trace details on the log details page, helping you quickly perform data correlation analysis.

![](img/13.log_1.png)

## Advanced References

### Log Text Processing (Pipeline)

<<< custom_key.brand_name >>> provides two methods for log Pipeline text processing:

- [Pipelines](../pipeline/index.md): Supports manual configuration and viewing of log pipeline files in the <<< custom_key.brand_name >>> workspace without logging into the DataKit server, making it easy to use online log Pipeline features to parse your logs.

- DataKit: After installing DataKit on the server, configure the DataKit log collector and corresponding Pipeline files in the terminal tool to process text data.

### Generating Metrics

<<< custom_key.brand_name >>> supports generating metrics from existing data within the current workspace to create custom metric data. In the <<< custom_key.brand_name >>> workspace under "Logs" - "Generate Metrics," click "Create" to start creating new generation rules. Refer to the [Generate Metrics](../metrics/generate-metrics.md) documentation for more details.

![](img/13.log_9.png)

Generated metrics can be viewed uniformly in the <<< custom_key.brand_name >>> "Metrics" section or by clicking "View Metrics" next to the rule in the "Generate Metrics" page to navigate to the "Metrics" page and view the corresponding Measurement and metrics.

![](img/13.log_9.1.png)

Generated metrics support building dashboards in <<< custom_key.brand_name >>> "Scenarios," combining other metrics for comprehensive visualization of collected log data.

![](img/13.log_9.2.png)

### Log Blacklist

<<< custom_key.brand_name >>> supports filtering out logs that meet certain criteria by setting up a log blacklist. Once configured, logs that meet the criteria will no longer be reported to the <<< custom_key.brand_name >>> workspace, helping users save on log storage costs.

In the <<< custom_key.brand_name >>> workspace, click "Logs" - "Blacklist" - "Create," select "Log Source," add one or more log filtering rules, and click confirm to enable the log filtering rule by default.

![](img/13.log_3.png)

If you set up a rule to filter out all logs from "nginx," after the setting takes effect, you will see that nginx logs are no longer reported to the workspace after "02/24 15:06:28." For more details, refer to the [Log Blacklist](../logs/blacklist.md) documentation.

![](img/13.log_4.1.png)

### Log Backup

<<< custom_key.brand_name >>> retains basic logs for up to 60 days. If you need longer-term storage and viewing, you must back up the basic logs. Log backup supports two methods:

- Back up to <<< custom_key.brand_name >>>: Supports storing backed-up logs for up to 720 days.
- Back up to external storage: Supports backing up logs to Alibaba Cloud OSS. Refer to the [Best Practices for Backing Up Logs to OSS](../best-practices/partner/log-backup-to-oss-by-func.md) documentation.

In the "Backup Logs" page, click "Log Backup Management" - "Create," input the "Rule Name" to add a new rule. You can use "Filter Conditions" and "Search Keywords" to more accurately target logs for backup, saving backup storage costs.

**Note:**

- Backup cycle: Backups occur daily at `00:00:00`, covering logs from the previous day (`00:00:00—23:59:59`).
- Free Plan users: Cannot back up log data.

![](img/13.log_6.png)

After setting up a log backup rule, the "Backup Logs" page will initially show no data. You need to first select the time range for viewing backup logs. For more details, refer to the [Log Backup](../management/backup/index.md) documentation.

![](img/13.log_10.1.png)