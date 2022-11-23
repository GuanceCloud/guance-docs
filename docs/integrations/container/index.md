---
icon: fontawesome/solid/circle-nodes
---
# 容器编排

---

[DataKit](../../datakit/) 是观测云中至关重要的一个数据采集组件，几乎所有观测云中的数据都是来源于 DataKit。

<br/>

[**安装 DataKit**](../../datakit/datakit-daemonset-deploy.md) 之后，对于如下指标集，用户可通过**自定义开启内置插件**采集相关数据：


| **自定义开启**  |    |
| --------- | ---- |
| [:fontawesome-brands-docker: Docker](docker.md){ .md-button .md-button--primary } | [:integrations-coredns: CoreDNS](coredns.md){ .md-button .md-button--primary } |
| [:integrations-k8s-api: Kubernetes API Server](kubernetes-api-server.md){ .md-button .md-button--primary } |  [:integrations-etcd: Etcd](etcd.md){ .md-button .md-button--primary }  |
| [:integrations-k8s-cm: Kubernetes Controller Manager](kubernetes-controller-manager.md){ .md-button .md-button--primary }|  [:integrations-harbor: Harbor](harbor.md){ .md-button .md-button--primary } |
| [:integrations-k8s-kubelet: Kubernetes Kubelet](kubernetes-kubelet.md){ .md-button .md-button--primary }   | [:integrations-istio: Istio](istio.md){ .md-button .md-button--primary }  |
| [:integrations-k8s-sched: Kubernetes Scheduler](kube-scheduler.md){ .md-button .md-button--primary }  | [:integrations-ng-ingress: Ingress Nginx (Prometheus)](ingress-nginx-prom.md){ .md-button .md-button--primary } |
| [:material-kubernetes: Kube State Metrics](kube-state-metrics.md){ .md-button .md-button--primary }  |    |
| [:material-kubernetes: Kubernetes With Metric Server](kube-metric-server.md){ .md-button .md-button--primary }  |   |

<br/>

**开始[安装 DataKit](../../datakit/datakit-daemonset-deploy.md)，开启你的观测云之旅！**
