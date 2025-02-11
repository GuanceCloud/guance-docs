# Kodo-X Split

???+ warning "Note"

    Please read this document carefully and ensure that you have backup measures and a rollback plan in place during implementation to ensure the safety and stability of the system.



## Introduction {#info}

When handling a large number of write requests, the resource consumption of kodo-x may focus on specific types of processing tasks, especially Metrics data processing, leading to delays in consuming other data and causing data accumulation issues.

Solution ideas:

1. Create an independent kodo-x instance dedicated to processing Metrics data to reduce resource usage on existing instances.
2. Modify the existing kodo-x instance to stop processing Metrics data and focus on other tasks.


## Architecture Diagram {#diagram}

Before splitting:

![](img/kodo-x-split-01.png)


After splitting:

![](img/kodo-x-split-02.png)


## Prerequisites {#preconditions}

- Have cluster operation permissions for Guance
- Plan the scheduling resources for kodo-x and the split kodo-x-metric in advance


## Implementation Plan {#plan}

### 1. Service Backup

```shell
kubectl get deploy -n forethought-kodo  kodo-x -o yaml > kodo-x-deploy.yaml
```

### 2. Create kodo-x-metric Service

#### 2.1 Create kodo-x-metric ConfigMap

```shell
kubectl get cm -n forethought-kodo kodo-x -o yaml > kodo-x-metric-cm.yaml
```

Modify the following information:

- Change `name` to kodo-x-metric
- Remove `resourceVersion` and `uid` fields

```shell
kubectl apply -f kodo-x-metric-cm.yaml
```

#### 2.2 Create kodo-x-metric Deployment

```shell
kubectl get deploy -n forethought-kodo  kodo-x -o yaml  > kodo-x-deploy.yaml
```

Modify the following information:

- Change `metadata`-`name` to kodo-x-metric
- Remove `resourceVersion` and `uid` fields under `metadata`
- Change `name` under `volumeMounts` and `volumes` to kodo-x-metric

```shell
...
metadata:
  name: kodo-x-metric    ##### Change to kodo-x-metric
  namespace: forethought-kodo 
  resourceVersion: "129925433"   ##### Remove
  uid: e4f0c541-4d91-47d4-82c8-91eec2757cb2   ##### Remove
...
        volumeMounts:
        - mountPath: /kodo/config/config.yaml
          name: kodo-x-metric  ##### Change to kodo-x-metric
          subPath: config.yaml

      volumes:
      - configMap:
          defaultMode: 420
          name: kodo-x-metric ##### Change to kodo-x-metric
          optional: false
        name: kodo-x-metric ##### Change to kodo-x-metric

```

```shell
kubectl apply -f kodo-x-deploy.yaml
```

### 3. Configure kodo-x-metric Parameters

Configuration file: kodo-x-metric.yaml (other configurations are the same as the existing kodo-x.yaml)

```shell
global:
    metric_workers: 32  # Increase Metrics data processing capability
    object_workers: 8
    keyevent_workers: 8
    workers: 0  # Disable default worker
    log_workers: 0  # Disable log processing
    backup_log_workers: 0  # Disable backup log processing
```

Refer to the [Application Service Configuration Guide](application-configuration-guide.md) for more information.

Restart the service:

```shell
kubectl rollout restart -n forethought-kodo deploy kodo-x-metric
```

#### 3.2 Modify kodo-x Parameters

The existing kodo-x instance will only handle non-Metrics tasks, optimizing resource allocation.

Configuration file: kodo-x.yaml

```shell
global:
    metric_workers: -1  # Disable Metrics data processing
    object_workers: -1  # Disable object processing
    keyevent_workers: -1  # Disable key event processing
```

Restart the service:

```shell
kubectl rollout restart -n forethought-kodo deploy kodo-x
```

### 4. Verification

Run the following commands to check if the configurations have taken effect:

```
kubectl exec -ti -n forethought-kodo  deploy/kodo-x -- cat config/config.yaml | grep -15 global
kubectl exec -ti -n forethought-kodo  deploy/kodo-x-metric -- cat config/config.yaml | grep -15 global
```