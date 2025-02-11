## Overview

This document addresses the issue of significant data write latency and outlines troubleshooting steps.

## Infrastructure Configuration Check

### 1. Check Time

Check if the machine time for **Guance-related services** is correct. If there is a delay, adjust the machine's timezone and time.

### 2. Review Data Node Configuration

Check if the configuration of the **storage engine's data nodes** has been modified according to actual resource conditions.

1) Review the machine configuration of the data nodes

```shell
# Check server CPU and memory configuration
cat /proc/cpuinfo
free -g
```

2) Review the relevant configurations of the storage engine to see if they were modified during deployment.

3) If no modifications have been made, follow the configuration guidelines below.

Assuming the queried resource status is 8c32g:

```yaml
        # Generally set to half of limits
        ## If resources are sufficiently large, the maximum can be set to 32g; exceeding this will waste resources.
        - name: OPENSEARCH_JAVA_OPTS
          value: -Xmx14g -Xms14g
        # Limits should not be fully utilized; some CPU and memory should be reserved for other programs and the system.
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

### 1. Check if the kodo-x Service Frequently Restarts

```shell
kubectl get pods -n forethought-kodo
```

### 2. Review Redis Middleware

Check if Redis performance has reached its bottleneck. If CPU or memory usage is too high, consider vertical scaling.

### 3. Determine the Type of Storage Engine Based on Topic

1) Change the service configuration of nsqadmin in the middleware Namespace to NodePort.

```shell
kubectl patch svc nsqadmin -n middleware -p '{"spec": {"type": "NodePort"}}'
```

> Access via browser using node_IP + port.

2) Identify the storage engine type based on the topic name.

Topics starting with `df_metric_xxx` belong to the Time Series engine; all other topics are from the Log engine.

3) Review data node performance

If resource usage is excessively high, refer to the following [Engine Exception Handling](#exception-handling).

4) Review data from the corresponding service

![](img/data-write-delay_2.png)

| Field Name | Field Explanation                                      |
| ---------- | ------------------------------------------------------- |
| Topic      | Name of the message queue                               |
| Depth      | Number of unprocessed messages in the queue             |
| In-Flight  | Number of messages retrieved but not yet acknowledged   |
| Deferred   | Number of messages delayed for redistribution           |
| Connections| Maximum concurrent consumption connections              |

### 4. Engine Exception Handling {#exception-handling}

#### 4.1 Single Node Under Heavy Load

All index configurations in Guance default to one shard, meaning only one data node handles the processing. This can lead to performance bottlenecks. Therefore, log in to the backend management to adjust the number of shards, increasing parallel processing capabilities.

![](img/data-write-delay_3.png)

![](img/data-write-delay_4.png)

![](img/data-write-delay_5.png)

Frequently refresh the nsq admin page. If you notice a significant decrease in the Channel Depth backlog, the issue is resolved.

#### 4.2 Cluster Under Heavy Load

If the entire cluster is under heavy load, consider horizontal or vertical scaling.

Refer to [Log Engine Capacity Planning](logengine-capacity-planning.md)

### 5. Insufficient Consumption Capacity, Scale kodo-x Service

If the above methods do not resolve the data backlog, it may be due to insufficient connections in the nsq admin interface. Increase the number of kodo-x service instances.

Assuming sufficient machine resources, generally scale by doubling until the Depth backlog in the nsq admin page shows a clear reduction.

```shell
kubectl scale -n forethought-kodo deployment kodo-x --replicas=<kodo-x * 2>
```