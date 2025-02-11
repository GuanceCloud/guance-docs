# How to Enable Log Monitoring
---

Guance has comprehensive log collection capabilities, including system logs, application logs, security logs, and various other types of logs. Through Guance's custom log collectors, any logs can be collected and aggregated into Guance for unified storage and analysis. Using the text processor (Pipeline) provided by Guance, you can customize the parsing of collected logs and use the parsed fields as attributes. With these attribute fields, we can quickly filter relevant logs, perform data correlation analysis, and help us quickly locate and resolve issues.

This article uses Nginx logs as an example to introduce how to enable log monitoring.

## Prerequisites

You need to first create a [Guance account](https://www.guance.com/), and install [DataKit](../datakit/datakit-install.md) on your host.

## Method/Steps

### Step 1: Enable the Nginx Collector

After installing DataKit on the host, under the `/usr/local/datakit/conf.d/nginx` directory, copy `nginx.conf.sample` and rename it to `nginx.conf`. Edit `nginx.conf` to specify the location of the Nginx logs and enable Pipeline. For example:

- `files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]`
- `Pipeline = "nginx.p"` (the script name within `""` can be left blank; DataKit will automatically match the script file with the same name as the source)

Note: After enabling Pipeline, DataKit will automatically match the Pipeline script file based on the log source. If the log source and Pipeline file names do not match, you need to configure it in the collector settings. For example, if the log source is `nginx`, and the Pipeline file name is `nginx1.p`, then configure `Pipeline = "nginx1.p"`.

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

After completing the configuration, restart DataKit using the command line `datakit --restart` to apply the changes. For more details on Nginx collector configuration, refer to the documentation [Nginx](../integrations/nginx.md).

### Step 2: View and Analyze Log Data in the Guance Workspace

After enabling the Nginx collector, configuring the log file paths, and enabling Pipeline, you can view the collected Nginx logs in the Guance workspace.

![](img/13.log_2.png)

In the log section of the Guance workspace, select the Nginx logs. In the log details page, you can see the host that generated the log along with its attribute metrics view, log source, parsed log attributes via Pipeline, detailed log content, etc. By configuring trace association with logs ([Connect Logs with Traces](../application-performance-monitoring/collection/connect-log/index.md)), you can also view related trace details in the log details page, helping you quickly perform data correlation analysis.

![](img/13.log_1.png)

## Advanced References

### Log Text Processing (Pipeline)

Guance provides two methods for processing log Pipelines:

- [Pipelines](../pipeline/index.md): Supports manually configuring and viewing log Pipeline files in the Guance workspace without logging into the DataKit server, making it easy to use online log Pipeline features to parse your logs.
  
- DataKit: After installing DataKit on the server, configure the log collector and corresponding Pipeline files in the terminal tool to process text data.

### Generating Metrics

Guance supports generating metrics from existing data within the current workspace to create custom metric data. In the Guance workspace, go to the "Logs" - "Generate Metrics" page, click "New Rule" to start creating new generation metric rules. For more details, refer to the documentation [Generate Metrics](../metrics/generate-metrics.md).

![](img/13.log_9.png)

Generated metrics can be viewed uniformly in the "Metrics" section or on the "Generate Metrics" page by clicking "View Metrics" next to the rule, which redirects to the "Metrics" page to view the corresponding metric set and metrics.

![](img/13.log_9.1.png)

Generated metrics can be used to build dashboards in the "Scenes" section of Guance, combining other metrics for comprehensive visualization of collected log data.

![](img/13.log_9.2.png)

### Log Blacklist

Guance supports filtering out logs that match certain criteria by setting up a log blacklist. Once configured, logs matching the criteria will no longer be reported to the Guance workspace, helping users save on log storage costs.

In the Guance workspace, click "Logs" - "Blacklist" - "New Blacklist", select "Log Source", add one or more log filtering rules, and click confirm to enable the log filtering rule by default.

![](img/13.log_3.png)

If you set up a blacklist to filter out all logs from "nginx", after the setting takes effect, you can see that nginx logs are no longer reported to the workspace after "02/24 15:06:28". For more details, refer to the documentation [Log Blacklist](../logs/blacklist.md).

![](img/13.log_4.1.png)

### Log Backup

Basic logs in Guance are stored for up to 60 days. If you need longer storage and viewing periods, you need to back up the basic logs. Log backups support two methods:

- Backup to "Guance": Supports storing backup logs for up to 720 days.
- Backup to external storage: Supports backing up logs to Alibaba Cloud OSS. Refer to the documentation [Best Practices for Backing Up Log Data to OSS](../best-practices/partner/log-backup-to-oss-by-func.md).

On the "Backup Logs" page, click "Log Backup Management" - "New Rule", enter the "Rule Name" to add a new rule. You can use "Filter Conditions" and "Search Keywords" to more precisely target the logs you want to back up, saving on backup log storage costs.

**Note:**

- Backup cycle: Backups occur daily starting at `00:00:00` for logs from the previous day (`00:00:00—23:59:59`).
- Free Plan users: Cannot back up log data.

![](img/13.log_6.png)

After setting up a log backup rule, the data on the "Backup Logs" page will initially be empty. You need to first select the time range for viewing backed-up logs. For more details, refer to the documentation [Log Backup](../management/backup/index.md).

![](img/13.log_10.1.png)