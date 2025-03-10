# kodo-inner Configuration Query Concurrency

## Introduction {#info}

This article describes an optimization method. When Guance has sufficient underlying resources, and there are no bottlenecks in CPU, memory, disk I/O, etc., on the Doris machines, but log queries and other data responses are still slow, you can improve query speed by adjusting the concurrency of the **kodo-inner** service.

## Modify Configuration

### Method One

On the launcher, navigate to the top-right menu --> Modify Application Configuration --> Namespace: forethought-kodo --> kodoInner (Kodo Inner), and add the following content:

``` shell
# At the same level as global
dql:
    metric_query_workers: 64 # DQL Metrics data query worker count
    log_query_workers: 64 # DQL log text type (logs, traces, RUM, etc., all text-based data) data query worker count
    general_query_workers: 64 # Non-Metrics or log query worker count
```

After adding, check **Automatically Restart Related Services After Configuration Changes**, and click **Confirm Configuration Changes**

### Method Two

Add parameters via command line:

``` shell
kubectl edit deployment -n forethought-kodo kodo-inner
```

Add the following:

``` shell
# At the same level as global
dql:
    metric_query_workers: 64 # DQL Metrics data query worker count
    log_query_workers: 64 # DQL log text type (logs, traces, RUM, etc., all text-based data) data query worker count
    general_query_workers: 64 # Non-Metrics or log query worker count
```

After adding, restart the service:

``` shell
kubectl rollout restart deployment -n forethought-kodo kodo-inner
```

> For other configuration references: [Application Service Configuration Guide](application-configuration-guide.md)