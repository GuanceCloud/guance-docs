# Introduction to the Overall Architecture of DataKit
---

DataKit is a fundamental data collection tool that runs on users' local machines. It primarily collects various metrics and logs from system operations and sends them to [Guance](https://guance.com){:target="_blank"}. In Guance, users can view and analyze their various metrics, logs, and other data.

DataKit is a crucial data collection component in Guance. Almost all data in Guance originates from DataKit.

## Basic Network Model of DataKit {#network-arch}

The DataKit network model mainly consists of three layers, which can be summarized as user environment, DataWay, and the Guance center, as shown in the following figure:

<figure markdown>
  ![](https://static.guance.com/images/datakit/dk-network-arch.png){ width="800" }
  <figcaption> Basic Network Model of DataKit </figcaption>
</figure>

1. DataKit primarily collects different metrics periodically and sends the data to DataWay at regular intervals via HTTP(s). Each DataKit is configured with a corresponding token to identify different users.

> Note: If the user's internal network environment does not allow external requests, you can use [Nginx as a proxy layer](../integrations/proxy.md#nginx-proxy) or implement traffic proxying using the built-in [Proxy collector](../integrations/proxy.md) in DataKit.

2. After receiving the data, DataWay forwards it to Guance, including an API signature in the data sent to Guance.
3. Upon receiving valid data, Guance writes the data into different storage systems based on the data type.

For data collection services, partial data loss is generally allowed (since the data itself is collected intermittently, data within the intermittent period can be considered lost). Currently, the entire data transmission chain has implemented the following loss protection measures:

1. If DataKit fails to send data to DataWay due to network issues, it caches up to one thousand data points. When the cached data exceeds this limit, the cache will be cleared.
2. If DataWay fails to send data to Guance for any reason or cannot send it in time due to high traffic, DataWay persists the data to disk. Once traffic decreases or the network recovers, DataWay resends the data to Guance. Delayed data does not affect timeliness, as timestamps are attached to the cached data.

On DataWay, to protect the disk, the maximum disk usage can be configured to prevent overloading the node's storage. DataWay discards data exceeding the usage limit, but this capacity is generally set to a large value.

## Internal Architecture of DataKit {#internal-arch}

The internal architecture of DataKit is relatively simple, as shown in the following figure:

<figure markdown>
  ![](https://static.guance.com/images/datakit/dk-internal-arch.png){ width="800" }
  <figcaption> Internal Collection Architecture of DataKit </figcaption>
</figure>

From top to bottom, the internal structure of DataKit is divided into three layers:

- Top Layer: Includes entry modules and some common modules
    - Configuration Loading Module: In addition to its main configuration (`conf.d/datakit.conf`), DataKit configures each collector separately. Combining all configurations would result in a very large file, making editing inconvenient.
    - Service Management Module: Responsible for managing the entire DataKit service.
    - Toolchain Module: As a client program, DataKit provides many additional functionalities beyond data collection, such as viewing documentation, restarting services, updating, etc., all implemented in the toolchain module.
    - Pipeline Module: In log processing, [Pipeline scripts](../pipeline/use-pipeline/index.md) are used to parse logs, converting unstructured log data into structured data. Similar data processing can also be performed for non-log data types.
    - Election Module: When deploying a large number of DataKits, users can unify all DataKit configurations and deploy them in batches through [automated batch deployment](datakit-batch-deploy.md). The election module ensures that only one DataKit collects specific data (such as Kubernetes cluster metrics) to avoid data duplication and reduce pressure on the target system. In a cluster with identical DataKit configurations, the election module ensures that at most one DataKit performs the collection at any given time.
    - Documentation Module: DataKit's documentation is generated from its own code, facilitating automatic publishing.

- Transport Layer: Responsible for almost all data input and output

    - HTTP Service Module: DataKit supports third-party data integration, such as [Telegraf](../integrations/telegraf.md)/[Prometheus](../integrations/prom.md), with plans to support more data sources. These data sources currently integrate via HTTP.
    - IO Module: After each data collection by plugins, the data is sent to the IO module. This module encapsulates unified data construction, processing, and sending interfaces, facilitating integration with various collectors. Additionally, the IO module sends data to DataWay at regular intervals via HTTP(s).

- Collection Layer: Responsible for collecting various types of data. Based on the collection method, it is divided into two categories:

    - Active Collection Type: These collectors gather data at fixed frequencies as configured, such as [CPU](../integrations/cpu.md), [Network Traffic](../integrations/net.md), [Dial Testing](../integrations/dialtesting.md), etc.
    - Passive Collection Type: These collectors typically collect data through external inputs, such as [RUM](../integrations/rum.md), [Tracing](../integrations/ddtrace.md), etc. They usually run outside DataKit and upload data to Guance via DataKit's [data upload API](apis.md) after standardization.

Each collector runs independently in its own goroutine with outer-layer protection. Even if a single collector crashes (with a maximum of six crashes allowed per collector), it does not affect the overall operation of DataKit.

To prevent unexpected performance impacts on the user environment, such as excessively high collection frequencies (e.g., mistakenly setting `1m` to `1ms`), DataKit has a global protection mode (similar to a system firewall) that automatically adjusts erroneous settings to more reasonable ones.

Over 98% of DataKit's code is developed in Golang, supporting mainstream platforms like [Linux/Mac/Windows](datakit-service-how-to.md#install-dir). Since DataKit runs as a service in the user environment, it should have minimal dependencies and not significantly impact the user environment's performance. The current basic operational characteristics of DataKit are as follows:

- Minimal Environment Dependencies: Most collectors are integrated with the main DataKit program (all developed in Golang), with only a few having dynamic library or environment dependencies (e.g., Python environment). Users can easily meet these dependencies with simple operations.
- Resource Control: Resident memory consumption is approximately 30MB, CPU consumption is around 3% (tested on an Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz, with room for optimization). Disk consumption is negligible. Network traffic depends on the amount of data collected; DataKit compresses data in [line protocol](apis.md) format before sending it, keeping the data volume small while maintaining readability.

In theory, any observable data can be collected by DataKit. As user demand for observed data increases, DataKit will gradually add more types of data collection. Thanks to the high extensibility of DataKit's plugin model, achieving this goal is exceptionally straightforward.