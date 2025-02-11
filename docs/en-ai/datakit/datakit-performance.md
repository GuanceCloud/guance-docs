# Datakit Basic Operation and Performance Description

---

:material-kubernetes: :fontawesome-brands-linux:

---

This document primarily showcases the operational performance of Datakit in a real production environment. You can use the data presented here as a reference to benchmark against your own environment.

## Basic Environment Information {#specs}

- Runtime Environment: Kubernetes
- Datakit Version: 1.28.1
- Resource Limits: 2C4G
- Uptime: 1.73d
- Data Sources: There are numerous applications running in the cluster, and Datakit actively collects various application Metrics, logs, and Tracing data.

The following lists the Datakit load conditions under high, medium, and low scenarios [^1].

<!-- markdownlint-disable MD046 -->
=== "High Load"

    Under high load conditions, the amount of data collected by Datakit and the complexity of the data itself are higher, consuming more computational resources.
    
    - CPU Usage
    
    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/cpu-usage.png){ width="800" }
    </figure>
    
    Due to CPU core limitations, the CPU usage stabilizes around 200%.

    - Memory Consumption
    
    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/mem-usage.png){ width="800" }
    </figure>
    
    Memory is limited to 4GB, which is quite close to the limit. When it exceeds the memory limit, the Datakit POD will be restarted due to OOM.
    
    <!-- The following shows data collection, Pipeline processing, and data upload situations (the irate interval is 30 seconds). -->
    
    - Number of Collection Points
    
    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/collect-pts-irate.png){ width="800" }
    </figure>
    
    The number of data points collected by each collector; the top one is a Prometheus Metrics collector, which collects a large number of data points per collection, followed by the Tracing collector.
    
    - Number of Pipeline Processing Points

    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/pl-pts-irate.png){ width="800" }
    </figure>
    
    This shows the data point processing situation for a specific Pipeline, with one Pipeline script (*kodo.p*) being particularly busy.
    
    - Network Transmission

    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/upload-bytes-irate.png){ width="800" }
    </figure>
    
    The collected data points are ultimately sent over the network to the center. This shows the GZip-compressed data point Payload (HTTP Body) upload [^2] situation. Tracing has a particularly large Payload due to its extensive text information.

=== "Medium Load"

    Under medium load conditions, Datakit's resource consumption significantly decreases.
    
    - CPU Usage
    
    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/mid-cpu-usage.png){ width="800" }
    </figure>

    - Memory Consumption

    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/mid-mem-usage.png){ width="800" }
    </figure>
    
    - Number of Collection Points
    
    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/mid-collect-pts-irate.png){ width="800" }
    </figure>
    
    - Number of Pipeline Processing Points

    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/mid-pl-pts-irate.png){ width="800" }
    </figure>
    
    - Network Transmission

    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/mid-upload-bytes-irate.png){ width="800" }
    </figure>

=== "Low Load"

    Under low load conditions, Datakit only enables basic [default collectors](datakit-input-conf.md#default-enabled-inputs), so the data volume is small, resulting in lower memory usage [^3].

    - CPU Usage
    
    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/low-cpu-usage.png){ width="800" }
    </figure>

    - Memory Consumption

    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/low-mem-usage.png){ width="800" }
    </figure>

    - Number of Collection Points
    
    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/low-collect-pts-irate.png){ width="800" }
    </figure>

    - Network Transmission

    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/low-upload-bytes-irate.png){ width="800" }
    </figure>

<!-- markdownlint-enable -->

<!-- markdownlint-disable MD053 -->
[^1]: Datakit has enabled [Point Pool](datakit-conf.md#point-pool) and uses [V2 encoding](datakit-conf.md#dataway-settings) for uploads.
[^2]: This value may differ from Pod traffic, as Pod statistics reflect Kubernetes-level network traffic information, which will be higher than the traffic shown here.
[^3]: This low-load Datakit was tested on an additional Linux server, enabling only basic collectors. Since no Pipeline was involved, there is no corresponding data.
<!-- markdownlint-enable -->