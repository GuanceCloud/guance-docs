## Overview

This document addresses the issue of significant data write delays and outlines the troubleshooting approach.

## Infrastructure Configuration Check

### 1. Time Check

Check if the machine time for **<<< custom_key.brand_name >>> related services** is normal. If there are delays, adjust the machine's timezone and time.

### 2. Data Node Configuration Review

Review whether the configuration of the **storage engine's data nodes** has been modified according to actual resource conditions.

1) Review the machine configuration of the data nodes

```shell
# View server CPU and memory configuration
cat /proc/cpuinfo
free -g
```

2) Review the relevant configurations of the storage engine to see if any changes were made during deployment.

3) If no changes were made, modify the configuration according to the following guidelines.

Assuming the resource status from the above queries is 8c32g.

```yaml
        # Generally set to half of the limits
        ## If resources are sufficiently large, the maximum can be set to 32g; exceeding this will waste resources.
        - name: OPENSEARCH_JAVA_OPTS
          value: -Xmx14g -Xms14g
        # Limits should not be fully utilized; some CPU and memory must be reserved for other programs and the system.
        resources:
          limits:
            cpu: "7"
            memory: 28Gi
          requests:
            cpu: "7"
            memory: 7Gi
```

## Business Logic Troubleshooting

Below is a mind map of the troubleshooting logic, which can help determine the order of investigation.

![](img/data-write-delay_1.png)

### 1. Check if kodo-x Service Frequently Restarts

```shell
kubectl get pods -n forethought-kodo
```

### 2. Review Redis Middleware

Check if Redis performance has reached its bottleneck. If CPU or memory usage is too high, consider vertical scaling.

### 3. Determine Storage Engine Based on Topic

1) Modify the service configuration of nsqadmin under the middleware Namespace to NodePort.

```shell
kubectl patch svc nsqadmin -n middleware -p '{"spec": {"type": "NodePort"}}'
```

> Access via browser using node_IP + port.

2) Identify the type of storage engine based on the topic name.

Topics starting with `df_metric_xxx` are for the time series engine, while all other topics belong to the log engine.

3) Review data node performance

If resource usage is too high, refer to [Engine Exception Handling](#exception-handling).

4) Review corresponding service data

![](img/data-write-delay_2.png)

| Field Name | Field Explanation                                      |
| ---------- | ------------------------------------------------------- |
| Topic      | The name of the message queue                           |
| Depth      | Number of unprocessed messages in the queue             |
| In-Flight  | Number of messages being processed but not yet confirmed|
| Deferred   | Messages re-enqueued or explicitly delayed              |
| Connections| Maximum concurrent consumption connections              |

### 4. Engine Exception Handling {#exception-handling}

#### 4.1 Single Node Overload

All indices in <<< custom_key.brand_name >>> have a default configuration of 1 shard, meaning only one data node processes them. This can lead to performance bottlenecks. Log in to the backend management to adjust the number of shards, increasing parallel processing capabilities.

![](img/data-write-delay_3.png)

![](img/data-write-delay_4.png)

![](img/data-write-delay_5.png)

Frequently refresh the nsq admin page. If you notice a significant decrease in Channel Depth accumulation, the issue is resolved.

#### 4.2 Cluster Overload

If the entire cluster is under heavy load, consider horizontal or vertical scaling.

Refer to [Log Engine Capacity Planning](logengine-capacity-planning.md)

### 5. Insufficient Consumption Capacity, Scale kodo-x Service

If the above methods do not resolve the data backlog issue, it may be due to too few connections in the nsq management interface's Channel. Expand the number of kodo-x service instances.

Assuming sufficient machine resources, generally scale up by doubling until the Depth accumulation in the nsq management page shows a clear reduction.

```shell
kubectl scale -n forethought-kodo deployment kodo-x --replicas=<kodo-x * 2>
```