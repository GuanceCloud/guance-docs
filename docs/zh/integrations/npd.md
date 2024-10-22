---
title     : 'Node Problem Detector'
summary   : '通过 NPD 采集集群节点指标、事件'
__int_icon: 'icon/kubernetes'
dashboard :
  - desc  : 'Node Problem Detector 监控视图'
    path  : 'dashboard/zh/npd'
monitor   :
  - desc  : 'Node Problem Detector 检测库'
    path  : 'monitor/zh/npd'
  - desc  : 'Node Problem Detector (Log)检测库'
    path  : 'monitor/zh/npd_log'
---

<!-- markdownlint-disable MD025 -->
# Node Problem Detector
<!-- markdownlint-enable -->

**Node Problem Detector** 简称 **NPD**，是 Kubernetes 开源的集群节点监控插件，用于节点故障检查。

**NPD** 功能：

- 产生事件信息，上报给 APIServer。
- 检测指标信息，输出为 Metrics。


## 配置 {#config}

### 前置条件

- [x] 安装 K8S 环境
- [x] 安装 [DataKit](../datakit/datakit-daemonset-deploy.md)

### 安装 NPD

可以参考[安装文档](https://github.com/kubernetes/node-problem-detector#installation)，这里采用 `yaml` 的方式进行安装。

- 下载相关 yaml

1. [node-problem-detector.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/node-problem-detector.yaml)

2. [node-problem-detector-config.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/node-problem-detector-config.yaml)

3. [rbac.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/rbac.yaml)

- 执行

```shell
kubectl apply -f rbac.yaml
kubectl apply -f node-problem-detector-config.yaml
kubectl apply -f node-problem-detector.yaml
```

### 日志事件模式

默认安装 NPD 后，无需其他配置，Datakit 默认采集 Kubernetes 事件，存储至数据来源是 `Kubernetes_events` 的日志`reason`（tag）中。

### 指标模式

除了事件模式外，NPD 也支持输出指标

#### 准备工作

- [x] 安装 [Prometheus Operator](kubernetes-prometheus-operator-crd.md)

#### DataKit 开启 `ServiceMonitor`

[自动发现 Pod/Service 的 Prometheus 指标](kubernetes-prom.md#auto-discovery-metrics-with-prometheus)

以下通过`ServiceMonitor`方式采集 `NPD` 指标信息

- 调整 node-problem-detector.yaml

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

- 创建 `npd-service.yaml`

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

- 创建 `npd-server-monitor.yaml`

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

- 执行

```shell
kubectl apply -f rbac.yaml
kubectl apply -f node-problem-detector-config.yaml
kubectl apply -f node-problem-detector.yaml
kubectl apply -f npd-service.yaml
kubectl apply -f npd-server-monitor.yaml
```

## 指标 {#metric}

### problem_gauge

|Tag| 描述|
| -- | -- |
| `type="ConntrackFullProblem"`| 节点链接跟踪表故障 |
| type="EmptyDirVolumeGroupStatusError" | 临时卷存储池故障 |
| type="MemoryProblem" | 节点内存故障 |
| type="LocalPvVolumeGroupStatusError" | 节点上持久卷存储池故障 |
| type="MountPointProblem" | 节点挂载点故障 |
| type="FDProblem" | 系统关键资源FD文件句柄数故障 |
| type="DiskHung" | 节点磁盘是否存在卡 IO |
| type="DiskReadonly" | 节点磁盘是否只读 |
| type="DiskProblem" | 节点系统盘故障 |
| type="DiskSlow" | 节点磁盘是否存在慢 IO 故障 |
| type="FrequentCRIRestart" | CRI 频繁重启 |
| type="FrequentDockerRestart" | Docker 频繁重启 |
| type="FrequentKubeletRestart" | Kubelet 频繁重启|
| type="FrequentContainerdRestart" | Containerd 频繁重启|
| type="NTPProblem" | `ntpd` 同步异常 |
| type="PIDProblem" | 系统关键资源 PID 进程资源不足 |
| type="`ResolvConfFileProblem`" | `ResolvConf` 配置异常 |
| type="CNIProblem" | CNI（容器网络）组件异常 |
| type="CRIProblem" | 组件CRI（容器运行时组件）Docker 或 Containerd 的运行状态异常 |
| type="`KUBEPROXYProblem`" | Kube-proxy 运行异常 |
| type="`KUBELETProblem`" | Kubelet 状态异常 |
| type="ScheduledEvent" | 点是否存在主机计划事件 |
| type="ProcessD" | 节点存在 D 进程 |
| type="ProcessZ" | 节点存在 Z 进程 |

## 日志 {#logging}

以下列表包含但不限于默认配置下 NPD 能够检测的事件，事件写入至数据来源为`Kubernetes_events`的日志中：

| **原因** | **持久性** | **描述** |
| --- | --- | --- |
| `DockerHung` | 是 | Docker 挂起或无响应 |
| `ReadonlyFilesystem` | 是 | 文件系统被挂载为只读模式，通常是一种保护机制，在某些情况下防止文件系统损坏 |
| `CorruptDockerOverlay2` | 是 | Overlay2 存储驱动存在问题 |
| `ContainerdUnhealthy` | 是 | Containerd 处于非健康状态 |
| `KubeletUnhealthy` | 是 | Kubelet 处于非健康状态 |
| `DockerUnhealthy` | 是 | Docker 处于非健康状态 |
| `OOMKilling` | 否 | Kubernetes 因 OOM 结束 Pod |
| `TaskHung` | 否 | 任务挂起 |
| `UnregisterNetDevice` | 否 | 网络接口异常 |
| `KernelOops` | 否 | 内核检测到的异常行为，例如：空指针、设备错误 |
| `Ext4Error` | 否 | Ext4 文件系统问题 |
| `Ext4Warning` | 否 | Ext4 文件系统问题 |
| `IOError` | 否 | 缓冲区问题 |
| `MemoryReadError` | 否 | 可被修复的内存错误，频繁发生意味着内存硬件可能出现问题 |
| `KubeletStart` | 否 | Kubelet 启动，频繁出现意味 Kubelet 频繁重启 |
| `DockerStart` | 否 | Docker 启动，频繁出现意味 Docker 频繁重启 |
| `ContainerdStart` | 否 | Containerd 启动，频繁出现意味 Containerd 频繁重启 |
| `CorruptDockerImage` | 否 | Docker registry 使用的目录不为空 |
| `DockerContainerStartupFailure` | 否 | Docker 无法启动 |
| `ConntrackFull` | 否 | 网络连接跟踪数满，将影响 NAT、防火墙等网络功能 |
| `NTPIsDown` | 否 | NTP时间同步异常 |
