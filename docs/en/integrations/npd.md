---
title     : 'Node Problem Detector'
summary   : 'Collecting cluster node metics and events through NPD'
__int_icon: 'icon/kubernetes'
dashboard :
  - desc  : 'No'
    path  : '-'
monitor   :
  - desc  : 'Node Problem Detector Detection Library'
    path  : 'monitor/zh/npd'
---

<!-- markdownlint-disable MD025 -->
# Node Problem Detector
<!-- markdownlint-enable -->

**Node Problem Detector** , abbreviated as NPD, is an open-source cluster node monitoring plugin for Kubernetes, used for node fault detection.


**NPD** Function:

- Generate event information and report it to APIServer.

- Detect indicator information, output as Metrics.


## Installation Configuration{#config}

### Preconditions{#requirement}

- [x] Installed K8S
- [x] Installed [DataKit](../datakit/datakit-daemonset-deploy.md)
- [x] Installed [Prometheus Operator](kubernetes-prometheus-operator-crd.md)

### DataKit 开启 `ServiceMonitor`

[Automatically Discover the Service Exposure Metrics Interface](kubernetes-prom.md#auto-discovery-metrics-with-prometheus)

Collect `NPD` indicator information through the `ServiceMonitor` method below.

### Installed NPD


Can [install documentation](https://github.com/kubernetes/node-problem-detector#installation) Here, the `yaml` method is used for installation.


- Download yaml

1. [node-problem-detector.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/node-problem-detector.yaml)

2. [node-problem-detector-config.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/node-problem-detector-config.yaml)

3. [rbac.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/rbac.yaml)

- Modify node-problem-detector.yaml

```yaml

...
      - name: node-problem-detector
        command:
        - /node-problem-detector
        - --logtostderr
        - --config.system-log-monitor=/config/kernel-monitor.json,/config/docker-monitor.json
        - --address=0.0.0.0
        - --prometheus-address=0.0.0.0
...
        ports:
        - containerPort: 20257
          hostPort: 20257
          name: man-port

```

- Created `npd-service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: node-problem-detector
  namespace: kube-system
  labels:
    app: node-problem-detector
spec:
  selector:
    app: node-problem-detector
  ports:
    - protocol: TCP
      port: 20257
      targetPort: 20257
      name: metrics

```

- Created `npd-server-monitor.yaml`

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: npd-server-metrics
  labels:
    app: node-problem-detector
  namespace: kube-system
spec:
  selector:
    matchLabels:
      app: node-problem-detector
  endpoints:
  - port: metrics
    params:
      measurement:
        - node-problem-detector
```

- Run

```shell
kubectl apply -f rbac.yaml
kubectl apply -f node-problem-detector-config.yaml
kubectl apply -f node-problem-detector.yaml
kubectl apply -f npd-service.yaml
kubectl apply -f npd-server-metrics.yaml
```

## Metric {#metric}

### problem_gauge

|Tag| Description|
| -- | -- |
| `type="ConntrackFullProblem"`| Node link tracking table failure |
| type="EmptyDirVolumeGroupStatusError" | Temporary volume storage pool failure |
| type="MemoryProblem" | Node memory failure |
| type="LocalPvVolumeGroupStatusError" | Persistent volume storage pool failure on node |
| type="MountPointProblem" | Node mount point failure |
| type="FDProblem" | System critical resource FD file handle count failure |
| type="DiskHung" | Is there card IO present on the node disk |
| type="DiskReadonly" | Is the node disk read-only |
| type="DiskProblem" | Node system disk failure |
| type="DiskSlow" | Is there a slow IO fault on the node disk |
| type="FrequentCRIRestart" | CRI frequently restarts |
| type="FrequentDockerRestart" | Docker frequently restarts |
| type="FrequentKubeletRestart" | Kubelet frequently restarts|
| type="FrequentContainerdRestart" | Containerd frequently restarts|
| type="NTPProblem" | `ntpd` synchronization exception |
| type="PIDProblem" | Insufficient PID process resources for system critical resources |
| type="`ResolvConfFileProblem`" | `ResolvConf` configuration exception |
| type="CNIProblem" | CNI (Container Network) component exception |
| type="CRIProblem" | Abnormal running status of component CRI (container runtime component) Docker or Container |
| type="`KUBEPROXYProblem`" | Kube proxy running abnormally |
| type="`KUBELETProblem`" | Kubelet status is abnormal |
| type="ScheduledEvent" | Does the node have host schedule events |
| type="ProcessD" | Node has D processes present |
| type="ProcessZ" | Node has Z processes present |
