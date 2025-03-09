# Datakit Basic Operation and Performance Description

---

:material-kubernetes: :fontawesome-brands-linux:

---

This document primarily showcases the operational performance of Datakit in real production environments. You can refer to the data presented here to benchmark against your own environment.

## Basic Environment Information {#specs}

- Operating Environment: Kubernetes
- Datakit Version: 1.28.1
- Resource Limits: 2C4G
- Runtime Duration: 1.73d
- Data Sources: A large number of applications are running in the cluster, and Datakit actively collects various application Metrics, logs, and Tracing data

The following lists the Datakit load conditions under high, medium, and low scenarios [^1].

<!-- markdownlint-disable MD046 -->
=== "High Load"

    Under high load conditions, the amount of data collected by Datakit and the complexity of the data itself are higher, consuming more computing resources.
    
    - CPU Usage
    
    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/cpu-usage.png){ width="800" }
    </figure>
    
    Due to the limitation on the number of CPU cores, the CPU usage stabilizes around 200%.

    - Memory Consumption
    
    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/mem-usage.png){ width="800" }
    </figure>
    
    The memory is limited to 4GB, which is already close to the limit. When it exceeds the memory limit, the Datakit POD will be restarted due to OOM.
    
    <!-- The following shows the data collection, Pipeline processing, and data upload situation (the irate interval is 30 seconds). -->
    
    - Data Collection Points
    
    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/collect-pts-irate.png){ width="800" }
    </figure>
    
    The number of data points collected by each collector, with Prometheus Metrics collection being the highest, followed by the Tracing collector.
    
    - Pipeline Processing Points

    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/pl-pts-irate.png){ width="800" }
    </figure>
    
    This shows the data point processing situation for a specific Pipeline, where the *kodo.p* script is particularly busy.
    
    - Network Transmission

    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/upload-bytes-irate.png){ width="800" }
    </figure>
    
    The collected data points are eventually sent over the network to the center. This shows the GZip compressed data point Payload (HTTP Body) upload [^2] situation. Tracing has a particularly large Payload due to its extensive text information.

=== "Medium Load"

    Under medium load conditions, Datakit's resource consumption is significantly reduced.
    
    - CPU Usage
    
    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/mid-cpu-usage.png){ width="800" }
    </figure>

    - Memory Consumption

    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/mid-mem-usage.png){ width="800" }
    </figure>
    
    - Data Collection Points
    
    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/mid-collect-pts-irate.png){ width="800" }
    </figure>
    
    - Pipeline Processing Points

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

    - Data Collection Points
    
    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/low-collect-pts-irate.png){ width="800" }
    </figure>

    - Network Transmission

    <figure markdown>
    ![](https://static.guance.com/images/datakit/performance/low-upload-bytes-irate.png){ width="800" }
    </figure>

<!-- markdownlint-enable -->

<!-- markdownlint-disable MD053 -->
[^1]: All Datakits have enabled [Point Pool](datakit-conf.md#point-pool) and use [V2 encoding](datakit-conf.md#dataway-settings) for uploads.
[^2]: This value may differ from Pod traffic statistics. Pod statistics reflect network traffic information at the Kubernetes level, which will be larger than the traffic shown here.
[^3]: This low-load Datakit was tested on an additional Linux server, enabling only basic collectors. Since no Pipeline was involved, there is no corresponding data.
<!-- markdownlint-enable -->