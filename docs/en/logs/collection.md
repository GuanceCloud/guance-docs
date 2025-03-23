# Log Collection
---


<<< custom_key.brand_name >>> has comprehensive log collection capabilities, primarily divided into <u>HOST log collection and K8S CONTAINERS log collection</u>. The installation methods for DataKit differ between the two, as do the methods of log collection. Collected log data is uniformly aggregated to <<< custom_key.brand_name >>> for unified storage, search, and analysis, helping us quickly identify and resolve issues.

This article mainly introduces how to collect logs in a **HOST environment**. For information on collecting logs in a K8S environment, refer to the best practices [Several Playbooks for Log Collection in Kubernetes Clusters](../best-practices/cloud-native/k8s-logs.md).

## Prerequisites

[Install DataKit](../datakit/datakit-install.md).                

Alternatively, you can also log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site_auth >>>/login/pwd), go to **Integrations > DataKit**, select **Linux, Windows, MacOS** based on your host system, and obtain the DataKit installation command and steps.

## Log Collector Configuration

After installing DataKit, you can enable standard log collection or custom log collection to gather various types of log data from system logs and application logs such as Nginx, Redis, Docker, ES, etc.

=== "Custom Log Collector"

    Navigate to the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample`, and rename it to `logging.conf` for configuration. After completing the configuration, restart DataKit to apply the changes.
    
    > For more details, refer to [HOST Log Collection](../integrations/logging.md).

=== "Standard Log Collector"

    By enabling the standard log collectors supported by <<< custom_key.brand_name >>>, such as [Nginx](../integrations/nginx.md), [Redis](../integrations/redis.md), [ES](../integrations/elasticsearch.md), you can start log collection with one click.

???+ warning "Note"

    When configuring the log collector, ensure that the Pipeline feature for logs is enabled to extract the `time` and `status` fields:
    
    - `time`: The generation time of the log. If the `time` field is not extracted or if parsing this field fails, the current system time will be used by default;
    - `status`: The level of the log. If the `status` field is not extracted, `stauts` will default to `unknown`.
    
    > For more details, refer to the documentation [Pipeline Configuration and Usage](../integrations/logging.md#pipeline).



## Log Data Storage

After configuring the log collector, restart DataKit, and the log data will be reported to the <<< custom_key.brand_name >>> workspace.

- For users with a large volume of log data, we can save on data storage costs by configuring [Log Indexes](./multi-index/index.md) or [Log Blacklists](../getting-started/function-details/logs-blacklist.md);
- For users who need long-term log storage, we can use [Log Backup](../management/backup/index.md) to preserve log data.