# Log Collection
---


Guance has comprehensive log collection capabilities, mainly divided into <u>host log collection and K8S container log collection</u>. The installation methods of DataKit for both are different, and the log collection methods are also different. The collected log data is centralized in Guance for unified storage, search and analysis, helping us quickly identify and resolve issues.

This article mainly introduces how to collect logs in **host environment**. 


## Preconditions

[Install DataKit](../datakit/datakit-install.md) 

You can also login to [Guance](https://auth.guance.com/login/pwd), In **Integration > DataKit** and select "Linux", "Windows" and "MacOS" according to the host system, and get the DataKit installation instructions and installation steps.

## Log collection 

After the DataKit installation is completed, you can log collect various log data from system logs and application logs such as Nginx, Redis, Docker and ES by turning on standard log collection or custom log collection.

=== "Custom Log Collector" 
 
    Go to the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample` and name it `logging.conf` for configuration. After the configuration is completed, restarting DataKit will take effect. Refer to [Host Log Collection](../datakit/logging.md) for details. 
 
=== "Standard Log Collector" 
 
    You can turn on log collection with one click by turning on standard log collectors supported by Guance, such as [Nginx](../datakit/nginx.md), [Redis](../datakit/redis.md), [ES](../datakit/elasticsearch.md) and so on. 


???+ warning

    When configuring the log collector, you need to turn on the Pipeline function of the log and extract the fields of log time `time` and log level `status`: 
 
    - `time`: the time when the log is generated. If the time field is not extracted or parsing this field fails, the current system time is used by default. 
    - `status`: The level of the log. If the status field is not extracted, the default is to set stats to unknown. 
 
    > See [Pipeline Configuration and Use](../integrations/logging.md#pipeline) for more details. 

After the log collector is configured, restart the DataKit, and the log data can be uniformly reported to the guance workspace. 

## Log Data Storage

Once the configuration of the log collector is completed, restart DataKit, and the log data will be uniformly reported to the Guance workspace.

- For users with a large amount of log data, you can use [log index](multi-index.md) or [log blacklist](../getting-started/function-details/logs-blacklist.md) to save data storage costs; 
- For users who need long-term log storage, you can use [data forward](backup.md) to save log data. 

