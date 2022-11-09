# 容器编排

---

[DataKit](../../datakit/) 是观测云中至关重要的一个数据采集组件，几乎所有观测云中的数据都是来源于 DataKit。

<br/>

[**安装 DataKit**](../../datakit/datakit-daemonset-deploy.md) 之后，对于如下指标集，用户可通过**自定义开启内置插件**采集相关数据：


| **自定义开启**  |    |
| --------- | ---- |
| [Docker](docker.md) | [CoreDNS](coredns.md) |
| [Kubernetes API Server](kubernetes-api-server.md) |  [Etcd](etcd.md)  |
| [Kubernetes Controller Manager](kubernetes-controller-manager.md)|  [Harbor](harbor.md) |
| [Kubernetes Kubelet](kubernetes-kubelet.md)   | [Istio](istio.md)  |
| [Kubernetes Scheduler](kube-scheduler.md)  | [Ingress Nginx (Prometheus)](ingress-nginx-prom.md) |
| [Kube State Metrics](kube-state-metrics.md)  |    |
| [Kubernetes With Metric Server](kube-metric-server.md)  |   |

<br/>

**开始[安装 DataKit](../../datakit/datakit-daemonset-deploy.md)，开启你的观测云之旅！**
