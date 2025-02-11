# Use Alibaba Cloud ECI for Elastic Scaling of kodo-x

???+ warning "Note"
     ACK must be a Pro edition cluster.

## Introduction {#intro}

This solution is suitable for scenarios with significant traffic fluctuations. With virtual nodes, when your ACK cluster needs to scale out, you no longer need to plan the computational capacity of nodes; instead, you can create ECI instances on-demand under virtual nodes. ECIs have network connectivity with Pods on real nodes within the cluster. It is recommended that you schedule the elastic traffic portion of long-running business workloads to ECI. This can shorten the time required for elastic scaling, reduce scaling costs, and fully utilize existing resources. When business traffic decreases, you can quickly release Pods deployed on ECI to lower usage costs. We use Kubernetes HPA technology to achieve kodo-x scaling.

## Prerequisites {#prerequisite}

- The Kubernetes cluster must be ACK Pro and version 1.20.11 or higher. For upgrade instructions, see [Upgrading ACK Cluster K8s Version](https://help.aliyun.com/zh/ack/ack-managed-and-ack-dedicated/user-guide/configure-priority-based-resource-scheduling#:~:text=%E5%8D%87%E7%BA%A7%EF%BC%8C%E8%AF%B7%E5%8F%82%E8%A7%81-,%E5%8D%87%E7%BA%A7ACK%E9%9B%86%E7%BE%A4K8s%E7%89%88%E6%9C%AC,-%E3%80%82).
- When using ECI resources, `ack-virtual-node` must be deployed. For specific operations, see [Using ECI in ACK](https://help.aliyun.com/zh/eci/use-ecis-in-ack-clusters#topic-1860167).

## Environment Information {#info}

| Name               | Description                                                   |      |
| ------------------ | ------------------------------------------------------------- | ---- |
| Number of kodo-x nodes | 3                                                            |      |
| kodo-x configuration | 16C 32G                                                       |      |
| kodo-x resource     | request:<br/>cpu: 15<br/>memory: 28G<br/>limit:<br/>cpu: 16<br/>memory: 28G |      |
| kodo-x node label   | app: kodo-x                                                   |      |
| HPA effect         | When Pod CPU reaches 85%, multiple kodo-x replicas are launched, up to a maximum of 10 |      |

## Procedures {#procedure}

### Step One: Set ResourcePolicy {#Step-one}

Execute the following YAML:

```yaml
apiVersion: scheduling.alibabacloud.com/v1alpha1
kind: ResourcePolicy
metadata:
  name: kodo-x-resourcepolicy
  namespace: forethought-kodo
spec:
  ignorePreviousPod: false
  ignoreTerminatingPod: true
  preemptPolicy: AfterAllUnits
  selector:
    app: deployment-forethought-kodo-kodo-x # No change needed if this is kodo-x
  strategy: prefer
  units:
    - nodeSelector:
        app: kodo-x # Set the label for your exclusive machine here
      resource: ecs
    - resource: eci 
```

Check status:

```shell
kubectl get ResourcePolicy -n forethought-kodo
```

Result:

```shell
NAME                    AGE
kodo-x-resourcepolicy   3h6m
```

### Step Two: Set HorizontalPodAutoscaler {#Step-two}

Execute the following YAML:

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: kodo-x-hpa
  namespace: forethought-kodo
spec:
  maxReplicas: 10 # Maximum number of replicas
  metrics:
    - resource:
        name: cpu
        target:
          averageUtilization: 85   # Average utilization to 85%
          type: Utilization
      type: Resource
  minReplicas: 3       # Minimum number of replicas, also the number of kodo-x nodes
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: kodo-x
```

Check status:

```shell
kubectl get hpa -n forethought-kodo
```

### Step Three: Configure kodo-x {#Step-three}

- Modify kodo-x configmap parameters

  Modify the cm `kodo-x` under `forethought-kodo`, adjust `workers`, `log_workers`, `tracing_workers`. Refer to more parameters in the [Application Service Configuration Guide](application-configuration-guide.md).

  ```shell
  global:
      workers: 16
      log_workers: 64
      tracing_workers: 32
  ```

- Modify update strategy

  Modify the `strategy` object

  ```shell
  ...
    strategy:
      rollingUpdate:
        maxSurge: 2
        maxUnavailable: 0
  ...
  ```

- Add ECI annotations

  Add `alibabacloud.com/burst-resource: eci`

  ```shell
  spec:
  	...
    template:
      metadata:
        annotations:
          alibabacloud.com/burst-resource: eci
  ```

- Modify resource allocation

  ```yaml
  spec:
    template:
      spec:
        containers:
           ...
            ports:
              - containerPort: 9527
                name: 9527tcp02
                protocol: TCP
            resources:
              limits:
                cpu: '16'
                memory: 28G
              requests:
                cpu: '15'
                memory: 28G
            ...
  ```

## Verification and Troubleshooting {#check-misarrange}

- Verification

  ```shell
  kubectl get hpa -n forethought-kodo
  
  NAME         REFERENCE           TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
  kodo-x-hpa   Deployment/kodo-x   83%/90%   3         10        5          3h26m
  
  kubectl get pod -n forethought-kodo -o wide -l app=deployment-forethought-kodo-kodo-x 
  NAME                     READY   STATUS    RESTARTS   AGE    IP             NODE                            NOMINATED NODE   READINESS GATES
  kodo-x-d89f78cf4-69j5l   1/1     Running   0          3h5m   10.103.4.233   cn-hangzhou.172.16.23.172       <none>           <none>
  kodo-x-d89f78cf4-g5hx5   1/1     Running   0          3h8m   172.16.8.212   virtual-kubelet-cn-hangzhou-i   <none>           <none>
  kodo-x-d89f78cf4-hrhpx   1/1     Running   0          3h8m   172.16.8.211   virtual-kubelet-cn-hangzhou-i   <none>           <none>
  kodo-x-d89f78cf4-s7zsd   1/1     Running   0          3h5m   10.103.4.171   cn-hangzhou.172.16.23.173       <none>           <none>
  kodo-x-d89f78cf4-txqh8   1/1     Running   0          3h5m   10.103.5.107   cn-hangzhou.172.16.23.174       <none>           <none>
  
  
  ```

- Troubleshooting

  ```shell
  kubectl describe -n forethought-kodo hpa kodo-x-hpa 
  
  Name:                     kodo-x-hpa
  Namespace:                forethought-kodo
  Labels:                   <none>
  Annotations:              autoscaling.alpha.kubernetes.io/conditions:
                              [{"type":"AbleToScale","status":"True","lastTransitionTime":"2024-06-05T09:04:35Z","reason":"ReadyForNewScale","message":"recommended size...
                            autoscaling.alpha.kubernetes.io/current-metrics:
                              [{"type":"Resource","resource":{"name":"cpu","currentAverageUtilization":79,"currentAverageValue":"9481m"}}]
  CreationTimestamp:        Wed, 05 Jun 2024 09:04:20 +0000
  Reference:                Deployment/kodo-x
  Target CPU utilization:   90%
  Current CPU utilization:  79%
  Min replicas:             3
  Max replicas:             10
  Deployment pods:          5 current / 5 desired
  Events:
    Type    Reason             Age   From                       Message
    ----    ------             ----  ----                       -------
    Normal  SuccessfulRescale  35m   horizontal-pod-autoscaler  New size: 8; reason: All metrics below target
    Normal  SuccessfulRescale  34m   horizontal-pod-autoscaler  New size: 7; reason: All metrics below target
    Normal  SuccessfulRescale  33m   horizontal-pod-autoscaler  New size: 6; reason: All metrics below target
    Normal  SuccessfulRescale  15m   horizontal-pod-autoscaler  New size: 5; reason: All metrics below target
  ```