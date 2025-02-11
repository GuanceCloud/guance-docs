# Log Collection
---

Guance has comprehensive log collection capabilities, primarily divided into <u>host log collection and K8S container log collection</u>. The installation methods for DataKit differ between these two environments, as do the methods for collecting logs. Collected log data is uniformly aggregated to Guance for unified storage, search, and analysis, helping us quickly identify and resolve issues.

This article mainly introduces how to collect logs in a **host environment**. For log collection in a K8S environment, please refer to the best practices [Several Approaches to Log Collection in Kubernetes Clusters](../best-practices/cloud-native/k8s-logs.md).

## Prerequisites

[Install DataKit](../datakit/datakit-install.md). 

Alternatively, you can log in to [Guance](https://auth.guance.com/login/pwd), go to **Integration > DataKit**, and choose **Linux, Windows, MacOS** based on your host system to obtain DataKit installation commands and steps.

## Log Collector Configuration

After installing DataKit, you can enable log collection through either standard log collectors or custom log collectors to gather various types of log data from system logs, application logs such as Nginx, Redis, Docker, ES, etc.

=== "Custom Log Collector"

    Enter the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample`, and rename it to `logging.conf` for configuration. After completing the configuration, restart DataKit to apply the changes.
    
    > For more details, refer to [Host Log Collection](../integrations/logging.md).

=== "Standard Log Collector"

    By enabling the standard log collectors supported by Guance, such as [Nginx](../integrations/nginx.md), [Redis](../integrations/redis.md), [ES](../integrations/elasticsearch.md), etc., you can start log collection with one click.

???+ warning "Note"

    When configuring log collectors, ensure that the log Pipeline function is enabled to extract the `time` and `status` fields from the logs:
    
    - `time`: The time when the log was generated. If the `time` field is not extracted or parsed incorrectly, the system's current time is used by default.
    - `status`: The log level. If the `status` field is not extracted, it defaults to `unknown`.
    
    > For more details, refer to the documentation on [Pipeline Configuration and Usage](../integrations/logging.md#pipeline).

## Log Data Storage

After configuring the log collector, restart DataKit, and the log data will be reported to the Guance workspace.

- For users with a large volume of log data, you can configure [Log Indexes](./multi-index/index.md) or [Log Blacklists](../getting-started/function-details/logs-blacklist.md) to reduce data storage costs.
- For users who need long-term log storage, you can use [Log Backup](../management/backup/index.md) to preserve log data.