---
icon: zy/integrations
---
# 集成
---

## (2022/10/12)
### 新增文档

- AWS
    - EC2
    - ELB
    - RDS MySQL
    - S3

## (2022/06/17)
### 新增文档

- 阿里云
    - 阿里云 NAT
    - 阿里云 CDN
  
### 新增视图

- 阿里云
    - 阿里云 NAT
    - 阿里云 CDN
  
### 更新文档

- Jenkins：" 增加 Jenkins CI Visibility"

### 更新检测库

- 主机检测库
    - 主机文件系统剩余 inode 过低："检测指标新增 by device"

---

## (2022/06/10)
### 更新文档

- 阿里云 Redis 标准版："使用新的脚本集进行数据采集"
- 阿里云 Mongodb 副本集："使用新的脚本集进行数据采集"
- Docker："更新 container.conf 配置文件"
- Kubernetes："更新 container.conf 配置文件"
### 更新视图

- 阿里云 Redis 标准版："添加视图变量阿里云账号名称，变更视图变量实例 ID 为实例名称"
- 阿里云 Mongodb 副本集："添加视图变量阿里云账号名称，变更视图变量实例 ID 为实例名称"
- Istio Mesh："新增 Reporter 下拉框"
- Istio Service："新增 Reporter 下拉框"
- Kubernetes："kubelet_pod 指标集变更为 kube_pod"
- Kubernetes Overview by pods："kubelet_pod 指标集变更为 kube_pod"
- 基础设施 pod："kubelet_pod 指标集变更为 kube_pod"
### 更新检测库

- 阿里云 Redis 标准版检测库："检测标签 instanceId 变更为 InstanceName"
- 阿里云 Mongodb 副本集："检测标签 instanceId 变更为 DBInstanceDescription"

---

## (2022/06/03)
### 新增文档

- 容器编排
    - Kubernetes Kubelet
### 新增视图

- 容器编排
    - Kubernetes Kubelet
- 中间件
    - JVM Kubernetes
### 更新视图

- 中间件
    - JVM："新增 env 标签"
    - Seata："调整指标采集步骤"
- 容器编排
    - Kubernetes API Server："修改线程数单位"

---

## (2022/05/27)
### 新增文档

- 数据采集
    - Opentelemetry Collector
- 容器编排
    - Kubernetes Scheduler
    - Kubernetes Controller Manager
    - Kubernetes API Server
### 新增视图

- 数据采集
    - Opentelemetry Collector
- 容器编排
    - Kubernetes Scheduler
    - Kubernetes Nodes Overview
    - Kubernetes Controller Manager
    - Kubernetes API Server
### 更新文档

- SQLServer/PostgreSQL："按照文档模板重新排版"

---

## (2022/05/20)
### 新增文档

- 主机系统
    - Procstat
### 新增视图

- 主机系统
    - Procstat
### 更新文档

- Kubernetes with Metric Server："删除 ENV_K8S_CLUSTER_NAME 环境变量，视图预览新增 Deployments/DaemonSets/ReplicaSets/Job"
- Port："修改检测库名称为 Port 检测库，视图名称为 Port 监控视图"
### 更新视图

- Port："视图名称端口监控视图变更为 Port 监控视图"
- Kubernetes："新增 Deployments/DaemonSets/ReplicaSets/Job 视图"
### 新增监控器

- Procstat 检测库
    - 主机进程状态异常
### 更新监控器

- 主机检测库
    - 主机进程 CPU 使用率过高："检测字段 cpu_usage 变更为 cpu_usage_top"
- 端口状态检测库："端口状态检测库变更为 Port 检测库"

---

## (2022/05/13)
### 新增文档

- 中间件
    - Resin
    - Beats
### 新增视图

- 中间件
    - Resin
    - Beats
- 容器编排
    - Istio Service
- 阿里云
    - ASM Service
### 更新文档

- SSH："按照文档模板重新排版"
- ASM："新增 ASM Service 视图"
- Istio："新增 Istio Service 视图"
- Nginx："新增域名访问 status 页面方式"
### 更新视图

- SSH："重新排版，删除状态概览"

---

## (2022/05/07)
### 新增文档

- 数据存储
    - Redis Sentinel
### 新增视图

- 数据存储
    - Redis Sentinel
### 更新文档

- MongoDB："配置文件路径变更为 /usr/local/datakit/conf.d/db"
- PHP-FPM/NtpQ："按照文档模板重新排版"
- Aerospike："新增异常检测库说明"

---

## (2022/04/29)
### 新增文档

- 应用性能监测 (APM)
    - 阿里云 EDAS
### 新增视图

- 容器编排
    - Kubernetes Services
### 更新视图

- Rocketmq："top5 视图添加分组条件 cluster，topic"
- Seata："视图重新排版"
- 阿里云 ASM Control Plane/Mesh/Workload："视图重新排版"
- Kubernetes/Kubernetes Overview with Kube State Metrics/Kubernetes Overview by Pods："将 cluster_name 变更为 cluster_name_k8s"
- Istio Workload/Control Plane/Mesh："视图重新排版"
### 更新文档

- MongoDB/Memcached："按照文档模板重新排版"
- Seata："调整了 seata 视图、新增指标详解"
- Kubernetes："增加 ENV_K8S_CLUSTER_NAME 环境变量使用说明"
- Gitlab/Gitlab CI："文档合并，适配最新版的 DataKit"
### 新增监控器

- Aerospike 检测库
    - Aerospike 空间 Storage 剩余空间不足
    - Aerospike 空间 Memory 剩余空间不足
### 更新监控器

- Kubernetes 检测库
    - 移除节点磁盘使用率
    - 移除节点内存使用率

---

## (2022/04/22)
### 新增文档

- 应用性能监测 (APM)
    - Node.JS
    - Ruby
- 中间件
    - RocketMQ
- 容器编排
    - Istio
    - Kube State Metrics
- 数据存储
    - Aerospike
### 新增视图

- 容器编排
    - Kubernetes Overview by Pods
    - Istio Mesh
    - Istio Control Plane
- 阿里云
    - 阿里云 ASM Mesh
    - 阿里云 ASM Control Plane
    - 阿里云 ASM Workload
- 中间件
    - RocketMQ
- 数据存储
    - Aerospike Monitoring Stack Node
    - Aerospike Namespace Overview
### 更新视图

- Istio Workload Dashboard： "删除视图变量默认值"
- Kubernetes Overview with Kube State Metrics："删除视图变量默认值，Node 分布三个相关视图过滤了cluster_name 为空"
### 更新文档

- AcitveMQ/Consul/DNS Query："按照文档模板重新排版"
- Kubernetes："增加 metric-server，node-expoter 部署"
- 阿里云 ASM："增加 asm 的三个视图创建步骤"
### 新增监控器

- RocketMQ 检测库
    - RocketMQ 集群发送 tps 过高
    - RocketMQ 集群发送 tps 过低
    - RocketMQ 集群消费 tps 过高
    - RocketMQ 集群消费 tps 过低
    - RocketMQ 集群消费延迟过高
    - RocketMQ 集群消费堆积过高
- Kubernetes 检测库
    - 节点磁盘使用率
    - 节点内存使用率
    - Job 执行失败
    - Pod 频繁重启
    - Pod 启动超时失败
    - Pod 状态异常

---

## (2022/04/15)
### 新增文档

- 阿里云
    - 阿里云 ASM
### 更新视图

- Kubernetes："增加 Service、Replica Sets、Pod、Jobs 对象视图"
- 阿里云 ECS/RDS/OSS/SLB："添加视图变量阿里云账号名称，变更视图变量实例 ID 为实例名称"
- Processes："变更指标 cpu_usage 为 cpu_usage_top"
- Mysql："概览图不支持求导函数 derivative，QPS/TPS/慢查询变更为折线图"
- Istio："新增 General 指标，视图位置调整，变更视图名称为 Istio Workload Dashboard"
### 更新文档

- Ebpf："增加 ebpf 安装方式 (默认不安装)，增加 http 协议采集"
- CPU："增加 load5s 指标"
- Processes："增加 cpu_usage_top 指标"
- 阿里云 ECS/RDS/OSS/SLB："使用新的脚本集进行数据采集"
### 更新监控器

- 阿里云 ECS 检测库："检测标签 instanceId 变更为 InstanceName"
- 阿里云 RDS Mysql 检测库："检测标签 instanceId 变更为 DBInstanceDescription"
- 阿里云 SLB 检测库："检测标签 instanceId 变更为 LoadBalancerName"

---

## (2022/04/08)
### 新增文档

- 阿里云
    - 阿里云 PolarDB Oracle
    - 阿里云 RDS SQLServer
- 中间件
    - Seata
### 新增视图

- 阿里云
    - 阿里云 PolarDB Oracle
    - 阿里云 RDS SQLServer
- 中间件
    - Seata
### 更新文档

- Apache/Haproxy/Ping/Port："按照文档模板重新排版"
### 更新视图

- Kubernetes："修改适配最新版的 DataKit"
### 新增监控器

- 阿里云 PolarDB Oracle 检测库
    - 阿里云 PolarDB Oracle 连接数使用率过高
    - 阿里云 PolarDB Oracle 内存使用率过高
    - 阿里云 PolarDB Oracle CPU 使用率过高
- 阿里云 RDS SQLServer
    - 阿里云 RDS SQLServer CPU 使用率过高
    - 阿里云 RDS SQLServer 磁盘使用率过高

---

## (2022/04/01)
### 新增文档

- 主机系统
    - Datakit
- 阿里云
    - 阿里云 PolarDB PostgreSQL
- 中间件
    - Nacos
### 新增视图

- 主机系统
    - Datakit
- 阿里云
    - 阿里云 PolarDB PostgreSQL
- 中间件
    - Nacos
### 更新文档

- CPU/Conntrack/Diretory/Disk/Diskio/Ebpf/EthTool/Mem/Net/Netstat/Processes/Swap/System/Scheck："按照文档模板重新排版"
- Kubernetes："修改适配最新版的 DataKit"
- Etcd："增加 k8s 集群采集 etcd 的方式"
### 更新视图

- Processes："表格图 username 变更为 host"
### 新增监控器

- 主机系统
    - 主机 Datakit CPU 使用率过高
- 阿里云 PolarDB PostgreSQL 检测库
    - 阿里云 PolarDB PostgreSQL 连接数使用率过高
    - 阿里云 PolarDB PostgreSQL 内存使用率过高
    - 阿里云 PolarDB PostgreSQL CPU 使用率过高

---

## (2022/03/25)
### 新增文档

- 阿里云
    - 阿里云 PolarDB Mysql
### 新增视图

- 阿里云
    - 阿里云 PolarDB Mysql
### 更新文档

- 阿里云 ECS/RDS Mysql/EIP/Elasticsearch/MongoDB/SLS/Redis/SLB/OSS："按照文档模板重新排版"
### 新增监控器

- 阿里云 PolarDB Mysql 检测库
    - 阿里云 PolarDB Mysql 只读节点复制延迟过高
    - 阿里云 PolarDB Mysql 每秒慢查询过高
    - 阿里云 PolarDB Mysql IOPS 使用率过高
    - 阿里云 PolarDB Mysql 内存命中率过低
    - 阿里云 PolarDB Mysql 连接数使用率过高
    - 阿里云 PolarDB Mysql 内存使用率过高
    - 阿里云 PolarDB Mysql CPU 使用率过高

---

## (2022/03/18)
### 新增文档

- 主机系统
    - Chrony
### 新增视图

- 主机系统
    - Chrony
### 更新视图

- Disk："单位百分比 0 - 100 变更为百分比 0.0 - 1.0"
### 更新文档

- 集成文档模板更新："新增进一步阅读，奥布斯二维码，其他目录格式重构 (Nginx)"
- Ebpf："配置文件 net_ebpf.conf 变更为 ebpf.conf"

---

## (2022/03/11)
### 新增文档

- 主机系统
    - EthTool
    - Conntrack
### 新增视图

- 主机系统
    - EthTool
    - Conntrack
### 更新视图

- Gitlab CI："持续时间单位 ms 变更为 s"

---

## (2022/03/04)
### 新增文档

- 容器编排
    - Node
- 中间件
    - ActiveMQ
### 新增视图

- 容器编排
    - Node
- 中间件
    - ActiveMQ
### 更新文档

- 所有文档指标详情 (Datakit 链接) 变更为 "表格展示"
- Fluentd："新增 Windows 和 Kubernetes sidecar 方式采集"
- .Net Core："新增 6.0 版本支持"

---

## (2022/02/25)
### 新增文档

- 阿里云
    - 阿里云 SLS
- 主机系统
    - Netstat
- 中间件
    - Zookeeper
### 新增视图

- 阿里云
    - 阿里云 SLS
- 主机系统
    - Netstat
- 中间件
    - Zookeeper
### 新增监控器

- 主机检测库
    - 主机进程内存使用率过高
    - 主机进程 CPU 使用率过高
- Zookeeper 检测库
    - Zookeeper 服务器宕机
    - Zookeeper 平均响应延迟过高
    - Zookeeper 堆积请求数过大

---

## (2022/02/18)
### 新增文档

- 主机系统
    - Directory
    - Processes
- 容器编排
    - Harbor
### 新增视图

- 主机系统
    - Directory
    - Processes
- 容器编排
    - Harbor
### 更新视图

- 容器编排
    - Kubernetes："增加 pod cpu 和 pod memory 时序图，删除集群数量概览图"
### 更新文档

- CPU/Mem/Disk/Diskio/Net/SWAP/System："场景视图变更为内置模板库，异常检测变更为监控"

---

## (2022/02/11)
### 新增文档

- 中间件
    - NtpQ
    - DNS Query
- CICD
    - Gitlab CI
### 新增视图

- 中间件
    - NtpQ
    - DNS Query
    - Logstash
- CICD
    - Gitlab CI
### 新增监控器

- Ping 状态检测库
    - 检测地址 Ping 不通
    - 检测地址 Ping 响应时间过长
    - 检测地址 Ping 丢包率过高
- PHP-FPM 检测库
    - PHP-FPM 请求等待队列过高
    - PHP-FPM 进程最大限制次数过多
- Logstash 检测库
    - Logstash 配置重新加载失败
    - Logstash Pipeline配置重新加载失败
    - Logstash Java 堆内存使用率过高

---

## (2022/01/30)
### 新增文档

- 网络连接
    - Ping
- 中间件
    - PHP-FPM
    - Logstash
- Web 服务
    - HAProxy
- 容器编排
    - Ingress Nginx (Prometheus)
### 新增视图

- 网络连接
    - Ping
    - Port
- 中间件
    - PHP-FPM
- Web 服务
    - HAProxy
- 容器编排
    - Ingress Nginx (Prometheus)
### 新增监控器

- 端口状态检测库
    - 主机端口状态异常
    - 主机端口响应时间过慢

---

## (2022/01/21)
### 新增文档

- 阿里云
    - 阿里云 OSS
- 中间件
    - Fluentd
### 更新文档

- Web 服务
    - Nginx：重新排版，添加数据验证，更新视图
### 新增视图

- 阿里云
    - 阿里云 OSS
- 中间件
    - Fluentd
### 更新视图

- Web 服务
    - Nginx："移除日志视图，添加速率函数 non_negative_derivative，添加视图变量 host"
### 新增监控器

- 阿里云 Redis 标准版检测库
    - 阿里云 Redis (标准版) 命中率过低
    - 阿里云 Redis (标准版) 平均响应时间过高
    - 阿里云 Redis (标准版) QPS 使用率过高
    - 阿里云 Redis (标准版) 连接数使用率过高
    - 阿里云 Redis (标准版) 内存使用率过高
    - 阿里云 Redis (标准版) CPU 使用率过高
- 阿里云 MongoDB 副本集检测库
    - 阿里云 MongoDB (副本集) CPU 使用率过高
    - 阿里云 MongoDB (副本集) 内存使用率过高
    - 阿里云 MongoDB (副本集) 磁盘使用率过高
    - 阿里云 MongoDB (副本集) IOPS 使用率过高
    - 阿里云 MongoDB (副本集) 连接数使用率过高
- Fluentd 检测库
    - Fluentd 剩余缓冲区的可用空间
    - Fluentd 的 plugin 重试数过多

---

## (2022/01/14)
### 新增文档

- 阿里云
    - 阿里云 Elasticsearch
### 新增视图

- 阿里云
    - 阿里云 Elasticsearch
- 数据存储
    - ClickHouse
### 新增监控器

- 阿里云 ECS 检测库
    - 阿里云 ECS CPU 负载过高
    - 阿里云 ECS Inode 使用率过高
    - 阿里云 ECS 磁盘使用率过高
    - 阿里云 ECS 内存使用率过高
    - 阿里云 ECS CPU 使用率过高
- 阿里云 Elasticsearch 检测库
    - 阿里云 Elasticsearch 实例节点 CPU 使用率过高
    - 阿里云 Elasticsearch 实例节点磁盘使用率过高
    - 阿里云 Elasticsearch 实例节点内存使用率过高
    - 阿里云 Elasticsearch 实例节点 CPU 负载过高
    - 阿里云 Elasticsearch 集群状态异常
- 阿里云 EIP 检测库
    - 阿里云 EIP 网络流入带宽利用率过高
    - 阿里云 EIP 网络流出带宽利用率过高

---

## (2022/01/07)
### 新增文档

- 阿里云
    - 阿里云 MongoDB 副本集
- 数据存储
    - ClickHouse
### 新增视图

- 阿里云
    - 阿里云 MongoDB 副本集
- 容器编排
    - Kubernetes
### 新增监控器

- 阿里云 SLB 检测库
    - 阿里云 SLB 实例 QPS 使用率过高
    - 阿里云 SLB 后端 ECS 异常
- 阿里云 RDS Mysql 检测库
    - 阿里云 RDS Mysql 每秒慢查询数过高
    - 阿里云 RDS Mysql 磁盘使用率过高
    - 阿里云 RDS Mysql IOPS 使用率过高
    - 阿里云 RDS Mysql 连接数使用率过高
    - 阿里云 RDS Mysql 内存使用率过高
    - 阿里云 RDS Mysql CPU 使用率过高
### 更新监控器

- 主机："修改分组为主机检测库，选取范围5m"
- Docker："修改分组为 Docker检测库，选取范围5m"

---

## (2021/12/31)
### 新增文档

- 阿里云
    - 阿里云 Redis 标准版
- 中间件
    - Flink
### 新增视图

- 阿里云
    - 阿里云 Redis 标准版
- 中间件
    - Flink
### 新增监控器

- Flink
    - 输出缓冲池中的所有缓冲区已满
    - TaskManager 堆内存不足

---

## (2021/12/24)
### 新增文档

- 阿里云
    - 阿里云 EIP
- 数据采集
    - Logstash
- 中间件
    - Consul
### 新增视图

- 阿里云
    - 阿里云 EIP
- 中间件
    - Consul
### 更新视图

- Web 服务
    - Apache："新增 ScoreBoard 指标"

---

## (2021/12/17)
### 新增文档

- 阿里云
    - 阿里云 RDS Mysql
    - 阿里云 SLB
    - 阿里云费用
### 新增视图

- 阿里云
    - 阿里云 RDS Mysql
    - 阿里云 SLB

---

## (2021/12/10)
### 新增文档

- 阿里云
    - 阿里云 ECS
### 新增视图

- 阿里云
    - 阿里云 ECS
### 更新文档

- 所有文档添加故障排查 "无数据上报排查"

---

## (2021/12/03)
### 新增文档

- 网络连接
    - Port

---

## (2021/11/26)
### 新增文档

- 数据采集
    - Flunted
### 更新文档

- 主机系统
    - Ebpf (网络观测)："修改内核版本要求为 "CentOS 7.6+ 和 Ubuntu 16.04 以外，其他发行版本需要 Linux 内核版本高于 4.0.0"

---

## (2021/11/19)
### 新增文档

- 应用性能监测 (APM)
    - C# (.net)
    - Python
    - .NET Core

---

## (2021/11/12)
### 新增文档

- 应用性能监测 (APM)
    - Go
    - Java
    - PHP

---

## (2021/09/30)
### 新增文档

- 主机系统
    - Ebpf (网络观测)
- 容器编排
    - Etcd
    - CoreDNS

---

## (2021/09/24)
### 新增文档

- 主机系统
    - Scheck

---

## (2021/09/18)
### 新增文档

- 容器编排
    - Docker
- 数据存储
    - PostgreSQL
### 新增视图

- 容器编排
    - Docker
### 新增监控器

- Docker
    - Docker 容器状态检测
    - Docker 容器内存使用率过高
    - Docker 容器 CPU 使用率过高

---

## (2021/09/10)
### 新增文档

- 数据存储
    - Redis
    - Mongodb
    - SQLServer
- 中间件
    - Kafka
    - Solr
    - RabbitMQ
- 容器编排
    - Kubernetes
    - 用户访问监测 (RUM)
    - Web 页面 (H5)
### 新增视图

- 数据存储
    - Redis
    - Mongodb
    - SQLServer
- 中间件
    - Kafka
    - RabbitMQ
### 新增监控器

- Redis
    - Redis 等待阻塞命令的客户端连接数异常增加

---

## (2021/09/03)
### 新增文档

- 主机系统
    - CPU
    - Disk
    - Diskio
    - Mem
    - Net
    - Swap
- 数据存储
    - Mysql
    - Elasticsearch
    - Memcached
- 中间件
    - JVM
    - Tomcat
- 网络连接
    - SSH
    - Dialtesting (云拨测)
- Web 服务
    - Apache
    - Nginx
- CICD
    - Gitlab
    - Jenkins
- 用户访问监测 (RUM)
    - MiniAPP (小程序)
    - Android
    - IOS
### 新增视图

- 主机系统
    - CPU
    - Disk
    - Diskio
    - Mem
    - Net
    - Swap
- 数据存储
    - Mysql
    - Elasticsearch
    - Memcached
- 中间件
    - JVM
    - Tomcat
- 网络连接
    - SSH
- Web 服务
    - Apache
    - Nginx
- CICD
    - Gitlab
    - Jenkins
### 新增监控器

- 主机
    - 主机 CPU IOwait 过高
    - 主机文件系统剩余 inode 过低
    - 主机内存 Swap 使用率过高
    - 主机剩余磁盘空间过低
    - 主机 CPU 平均负载过高
    - 主机内存小于 100M
    - 主机 CPU 使用率过高
    - 主机内存使用率过高
    - 主机存在僵尸进程
- Elasticsearch
    - Elasticsearch 查询拒绝率过高
    - Elasticsearch 平均 CPU 使用率过高
    - Elasticsearch 集群状态异常
    - Elasticsearch 合并线程池中被拒绝的线程数异常增加
    - Elasticsearch 搜索线程池中被拒绝的线程数异常增加
    - Elasticsearch 转换索引线程池中被拒绝的线程数异常增加
    - Elasticsearch 合并索引线程池中被拒绝的线程数异常增加
    - Elasticsearch 搜索查询负载异常
    - Elasticsearch 平均 JVM 堆内存的使用量过高
