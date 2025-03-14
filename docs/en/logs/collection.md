# Log Collection
---

<<< custom_key.brand_name >>> has comprehensive log collection capabilities, primarily divided into <u>host log collection and K8S container log collection</u>. The installation methods for DataKit differ between the two, as do the methods of log collection. Collected log data is uniformly aggregated to <<< custom_key.brand_name >>> for unified storage, search, and analysis, helping us quickly identify and resolve issues.

This article mainly introduces how to collect logs in a **host environment**. For collecting logs in a K8S environment, refer to the best practices [Several Methods of Log Collection in Kubernetes Clusters](../best-practices/cloud-native/k8s-logs.md).

## Prerequisites

[Install DataKit](../datakit/datakit-install.md).                

Or you can log in to [<<< custom_key.brand_name >>>](https://auth.guance.com/login/pwd), go to **Integration > DataKit**, and choose **Linux, Windows, MacOS** based on your host system to obtain DataKit installation commands and steps.

## Log Collector Configuration

After installing DataKit, you can enable log collection through either standard log collectors or custom log collectors to gather various types of log data from system logs and application logs such as Nginx, Redis, Docker, ES, etc.

=== "Custom Log Collector"

    Navigate to the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample`, and rename it to `logging.conf` for configuration. After completing the configuration, restart DataKit for changes to take effect.
    
    > Refer to [Host Log Collection](../integrations/logging.md) for more details.

=== "Standard Log Collector"

    By enabling <<< custom_key.brand_name >>> supported standard log collectors, such as [Nginx](../integrations/nginx.md), [Redis](../integrations/redis.md), [ES](../integrations/elasticsearch.md), etc., you can start log collection with one click.

???+ warning "Note"

    When configuring log collectors, ensure that the Pipeline feature is enabled to extract the `time` and `status` fields from logs:
    
    - `time`: The time when the log was generated. If the `time` field is not extracted or parsing this field fails, the current system time will be used by default;
    - `status`: The log level. If the `status` field is not extracted, it will default to `unknown`.
    
    > Refer to the documentation [Pipeline Configuration and Usage](../integrations/logging.md#pipeline) for more details.



## Log Data Storage

After configuring the log collector, restart DataKit, and the log data will be reported to the <<< custom_key.brand_name >>> workspace.

- For users with a large volume of log data, we can configure [Log Indexes](./multi-index/index.md) or [Log Blacklist](../getting-started/function-details/logs-blacklist.md) to reduce data storage costs;
- For users requiring long-term log storage, we can use [Log Backup](../management/backup/index.md) to preserve log data.