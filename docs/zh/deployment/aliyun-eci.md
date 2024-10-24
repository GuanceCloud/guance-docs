# 使用阿里云 ECI 弹性伸缩 kodo-x

???+ warning "注意"
     ACK 必须是 Pro 版集群

## 简介 {#intro}

该方案用于流量波动较大的场景，有了虚拟节点后，当您的 ACK 集群需要扩容时，无需规划节点的计算容量，可以直接在虚拟节点下按需创建 ECI，ECI 与集群中真实节点上的 Pod 之间网络互通。建议您将长时间运行的业务负载的弹性流量部分调度至 ECI，这可以缩短弹性扩容的时间，减少扩容成本，并充分利用已有资源。当业务流量下降后，您可以快速释放部署在 ECI 上的 Pod，从而降低使用成本。我们使用Kubernetes 的 HPA 技术实现  kodo-x 扩缩容。


## 前提条件 {#prerequisite}

- Kubernetes 集群为 ACK Pro 且版本为 1.20.11 及以上。关于如何升级，请参见[升级 ACK 集群 K8s 版本](https://help.aliyun.com/zh/ack/ack-managed-and-ack-dedicated/user-guide/configure-priority-based-resource-scheduling#:~:text=%E5%8D%87%E7%BA%A7%EF%BC%8C%E8%AF%B7%E5%8F%82%E8%A7%81-,%E5%8D%87%E7%BA%A7ACK%E9%9B%86%E7%BE%A4K8s%E7%89%88%E6%9C%AC,-%E3%80%82)。
- 需要使用 ECI 资源时，已部署 ack-virtual-node。具体操作，请参见[ACK 使用 ECI](https://help.aliyun.com/zh/eci/use-ecis-in-ack-clusters#topic-1860167)。

## 环境信息 {#info}

| 名称             | 说明                                                         |      |
| ---------------- | ------------------------------------------------------------ | ---- |
| kodo-x 节点数    | 3                                                            |      |
| kodo-x 配置      | 16C 32G                                                      |      |
| kodo-x resouce   | request: <br/>cpu: 15<br/>men: 28G<br/>limit:<br/>cpu: 16<br/>men: 28G |      |
| Kodo-x node 标签 | app: kodo-x                                                  |      |
| hpa 效果         | pod cpu 达到 85 % 时，弹出多个 kodo-x 副本，最多 10 个       |      |



## 操作步骤 {#procedure}


### 步骤一：设置 ResourcePolicy  {#Step-one}

执行以下 yaml:

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
    app: deployment-forethought-kodo-kodo-x # 这个如果是 kodo-x 不需要改
  strategy: prefer
  units:
    - nodeSelector:
        app: kodo-x # 这里设置你的独占机器的标签
      resource: ecs
    - resource: eci 
```

查看状态：

```shell
kubectl get ResourcePolicy -n forethought-kodo
```

结果：

```shell
NAME                    AGE
kodo-x-resourcepolicy   3h6m
```



### 步骤二：设置 HorizontalPodAutoscaler  {#Step-two}

执行以下 yaml：

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: kodo-x-hpa
  namespace: forethought-kodo
spec:
  maxReplicas: 10 # 最大副本数
  metrics:
    - resource:
        name: cpu
        target:
          averageUtilization: 85   #平均利用率到 85%
          type: Utilization
      type: Resource
  minReplicas: 3       #最小副本数，也是 kodo-x 节点的节点数
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: kodo-x
```

查看状态：

```shell
kubectl get hpa -n forethought-kodo
```

### 步骤三：配置 kodo-x   {#Step-three}

- 修改 kodo-x configmap  参数

  修改「forethought-kodo」下的 cm kodo-x，调整 `workers`，`log_workers`，`tracing_workers`。更多参数参考[应用服务配置指南](application-configuration-guide.md)。

  ```shell
  global:
      workers: 16
      log_workers: 64
      tracing_workers: 32
  ```

  

- 修改更新方式

  修改 `strategy` 对象

  ```shell
  ...
    strategy:
      rollingUpdate:
        maxSurge: 2
        maxUnavailable: 0
  ...
  ```

- 添加 eci 的注解

  添加 `alibabacloud.com/burst-resource: eci`

  ```shell
  spec:
  	...
    template:
      metadata:
        annotations:
          alibabacloud.com/burst-resource: eci
  ```

- 修改资源配置

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

  

## 验证以及排错  {#check-misarrange}

- 验证

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

- 排错

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
