# 容器编排

---

[DataKit](../../datakit/) 是观测云中至关重要的一个数据采集组件，几乎所有观测云中的数据都是来源于 DataKit。

[**安装 DataKit**](../../datakit/datakit-daemonset-deploy.md) 之后，用户可以根据实际需求，**自定义开启**丰富的数据采集插件：

| 指标集名称                                                        | 指标举例                                                                     |
| ----------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Docker](docker.md)                                               | CPU 、内存使用信息、容器网络流量、文件系统读写信息等                         |
| [Kubernetes API Server](kubernetes-api-server.md)                 | 请求数量、工作队列信息、CPU 、内存、 Goroutines 等                           |
| [Kubernetes Controller Manager](kubernetes-controller-manager.md) | 多类型控制器速率信息、CPU 、内存、 Goroutines 等                             |
| [Kubernetes Kubelet](kubernetes-kubelet.md)                       | 运行 Pod 及容器信息、CPU 、内存、 Goroutines 等                              |
| [Kubernetes Scheduler](kube-scheduler.md)                         | 调度队列 Pending Pod 数量、进入调度队列 Pod 速率、CPU 、内存、 Goroutines 等 |
| [Kube State Metrics](kube-state-metrics.md)                       | 容器状态、部署信息、内存、磁盘、流量信息等                                   |
| [Kubernetes With Metric Server](kube-metric-server.md)            | Pod/Deployment/Job/Endpoint/Service 数量、 CPU、内存、Pod 分布等             |
| [CoreDNS](coredns.md)                                             | 服务数量、节点健康度、集群成员状态信息等                                     |
| [Etcd](etcd.md)                                                   | 接发 gRPC 客户端总字节数、领导者信息、提案信息等                             |
| [Harbor](harbor.md)                                               | 项目数、镜像仓库数、服务组件监控状态分布等                                   |
| [Ingress Nginx (Prometheus)](ingress-nginx-prom.md)          | 客户端数量、请求长度、CPU 、内存信息等                                       |
| [Istio](istio.md)                                                 | 输入请求数量及速率、输出请求信息等                                           |


**开始[安装 DataKit](../../datakit/datakit-daemonset-deploy.md)，开启你的观测云之旅！**
