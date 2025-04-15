# Log Collection
---


<<< custom_key.brand_name >>> has comprehensive log collection capabilities, primarily divided into <u>HOST log collection and K8S CONTAINERS log collection</u>. The installation methods for DataKit differ between the two, as do the methods of log collection. Collected log data is uniformly aggregated to <<< custom_key.brand_name >>> for unified storage, search, and analysis, helping us quickly identify and resolve issues.

This article mainly introduces how to collect logs in a **HOST environment**. For collecting logs in a K8S environment, refer to the best practices [Several Methods for Log Collection in Kubernetes Clusters](../best-practices/cloud-native/k8s-logs.md).

## Prerequisites

[Install DataKit](../datakit/datakit-install.md).                

Alternatively, you can also log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site_auth >>>/login/pwd), go to **Integrations > DataKit**, and select **Linux, Windows, MacOS** according to your host system to obtain DataKit installation commands and steps.

## Log Collector Configuration

After installing DataKit, you can enable standard log collection or custom log collection in two ways to collect various types of log data such as system logs and application logs like Nginx, Redis, Docker, ES, etc.

=== "Custom Log Collector"

    Enter the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample`, and rename it to `logging.conf` for configuration. After completing the configuration, restart DataKit for it to take effect.
    
    > For more details, refer to [HOST Log Collection](../integrations/logging.md).

=== "Standard Log Collector"

    By enabling the standard log collectors supported by <<< custom_key.brand_name >>>, such as [Nginx](../integrations/nginx.md), [Redis](../integrations/redis.md), [ES](../integrations/elasticsearch.md), you can start log collection with one click.

???+ warning "Note"

    When configuring the log collector, you need to enable the log Pipeline function to extract the `time` and `status` fields from the logs:
    
    - `time`: The time the log was generated. If the `time` field is not extracted or this field parsing fails, the current system time will be used by default;
    - `status`: The level of the log. If the `status` field is not extracted, `stauts` will default to `unknown`.
    
    > For more details, refer to the documentation [Pipeline Configuration and Usage](../integrations/logging.md#pipeline).



## Log Data Storage

After configuring the log collector, restart DataKit, and the log data will be reported uniformly to the <<< custom_key.brand_name >>> workspace.

- For users with a large volume of log data, we can save on data storage costs by configuring [Log Indexes](./multi-index/index.md) or [Log Blacklists](../management/overall-blacklist.md);
- For users needing long-term log storage, we can use [Log Backup](../management/backup/index.md) to preserve log data.