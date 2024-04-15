---
icon: zy/best-practices
---

## (2023/08/8)

### 新增最佳实践

- 监控 Monitoring
    - 应用性能监控 (APM) - 调用链 - [使用 datakit-operator 注入 dd-java-agent](./monitoring/datakit-operator.md)。


## (2023/2/10)

### 新增最佳实践

- 云平台接入
    - 阿里云 - [阿里云事件总线 EventBridge 最佳实践](./partner/aliyun_eventbridge.md)
## (2023/1/3)

### 新增最佳实践

- 云平台接入
    - AWS - [EKS 部署 DataKit](./partner/eks.md)。
- 监控 Monitoring
    - 应用性能监控 (APM) - 调用链 - [使用 datakit-operator 注入 dd-java-agent](./monitoring/datakit-operator.md)。


## (2022/12/2)

### 新增最佳实践

- 洞见
    - 场景 (Scene) - [SpringBoot 项目外置 Tomcat 场景链路可观测](./insight/springboot-tomcat.md)。

## (2022/11/18)

### 新增最佳实践

- 洞见
    - 观测云小妙招(Skills) - [DataKit 配置 HTTPS](./insight/datakit-https.md)。

- 监控 Monitoring
    - 应用性能监控 (APM) - 性能优化 - [利用 async-profiler 对应用性能调优](./monitoring/async-profiler.md)。
  
## (2022/10/28)

### 新增最佳实践

- 监控 Monitoring
    - 应用性能监控 (APM) - [Kafka 可观测最佳实践](./monitoring/kafka.md)。



## (2022/10/17)

### 新增最佳实践

- 云原生
    - 日志 - [观测云采集 Amazon ECS 日志](./cloud-native/amazon-ecs.md)。


## (2022/10/08)

### 新增最佳实践

- 监控 Monitoring
    - 基础设施监控 (ITIM) - [Ansible 批处理实战](./monitoring/ansible-batch-processing.md)。


## (2022/09/26)

### 新增最佳实践

- 云原生
    - 其它 - [多个 Kubernetes 集群指标采集最佳实践](./cloud-native/multi-cluster.md)。


## (2022/09/16)

### 新增最佳实践

- 监控 Monitoring
    - 应用性能监控 (APM) - 中间件（Middleware） - [洞见 MySQL](./monitoring/mysql.md)。

### 更新记录

- 监控 Monitoring
    - 应用性能监控 (APM) - [DDtrace 自定义 Instrumentation](./monitoring/ddtrace-instrumentation.md)。<font color="red" > 更新代码，升级后支持dubbo3。</font>

## (2022/09/02)

### 新增最佳实践

- 云原生 
    - 其它 - [使用 CRD 开启您的 Ingress 可观测之路](./cloud-native/ingress-crd.md)。


## (2022/08/26)

### 新增最佳实践

- 监控 Monitoring
    - 应用性能监控 (APM) - [DDtrace 自定义 Instrumentation](./monitoring/ddtrace-instrumentation.md)。

## (2022/08/19)

### 更新记录

- 洞见
    - 数据关联 - [JAVA 应用 RUM-APM-LOG 联动分析](./insight/java-rum-apm-log.md)，<font color="red" > 更新截图。</font>



## (2022/08/12)

### 新增最佳实践

- 洞见
    - 场景 - [内网场景 Dubbo 微服务接入观测云](./insight/scene-dubbo.md)。

### 更新记录

- 云原生
    - 其它 - [Kubernetes 应用的 RUM-APM-LOG 联动分析](./cloud-native/k8s-rum-apm-log.md)，<font color="red" > 升级 DataKit，更新截图。</font>

  
## (2022/08/05)

### 新增最佳实践

- 监控 Monitoring  
    - [使用 extract + TextMapAdapter 实现了自定义 traceId](./monitoring/ddtrace-custom-traceId.md)。

### 更新记录

- 监控 Monitoring  
    - [主机可观测最佳实践 (Linux)](./monitoring/host-linux.md),<font color="red" > 优化指标和采集流程</font>。
	
- 洞见 Insight  
    - [基于观测云，使用 SkyWalking 实现 RUM、APM 和日志联动分析](insight/skywalking-apm-rum-log.md),<font color="red" > 新增skywalking 增加apm-spring-cloud-gateway 的使用说明</font>。

## (2022/07/15)
### 新增最佳实践

- 云平台接入
    - [Rancher 部署 DataKit 最佳实践](./partner/rancher-datakit-install.md)。


## (2022/07/08)
### 新增最佳实践

- 接入（集成）最佳实践
    - [Skywalking 采集 JVM 可观测最佳实践](./monitoring/skywalking-jvm.md)。
  
## (2022/06/24)
### 更新记录
- 云原生
  - [使用 Rancher 部署和管理 Datakit，快速构建 Kubernetes 生态的可观测](./partner/rancher-datakit.md)，<font color="red" > 忽略部分 tag。</font>
  - [service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(上)](./cloud-native/microservices1.md)，<font color="red" > 忽略部分 tag。</font>
  - [基于 Istio 实现微服务可观测最佳实践](./cloud-native/istio.md)，<font color="red" > 忽略部分 tag。</font>

## (2022/06/17)
### 新增最佳实践
- APM
    - [GraalVM 与 Spring Native 项目实现链路可观测](./monitoring/spring-native.md)
- 接入集成
    - [主机可观测最佳实践 (Linux)](./monitoring/host-linux.md)
### 更新记录

- 接入（集成）最佳实践
    - [Nginx Ingress可观测最佳实践](./cloud-native/ingress-nginx.md)，<font color="red" > 默认忽略  build、le、method 等 tag。</font>


## (2022/06/10)
### 更新记录
- 云原生
    - [使用 Rancher 部署和管理 Datakit，快速构建 Kubernetes 生态的可观测](./partner/rancher-datakit.md)，<font color="red" > 增加 ingressgateway、egressgateway 指标采集，更新 container.conf 配置。</font>
    - [service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(上)](./cloud-native/microservices1.md)，<font color="red" > 增加 ingressgateway、egressgateway 指标采集，container.conf 更新。</font>
    - [基于 Istio 实现微服务可观测最佳实践](./cloud-native/istio.md)，<font color="red" > 增加 ingressgateway、egressgateway  指标采集。</font>

- 日志
    - [Pod 日志采集最佳实践](./cloud-native/pod-log.md)，<font color="red" > Logfwd 端口增加备注。</font>
    - [K8s 日志采集之 logback socket 最佳实践](./cloud-native/k8s-logback-socket.md)，<font color="red" > 更新 container.conf 配置。</font>
    - [Kubernetes 集群中日志采集的几种玩法](./cloud-native/k8s-logs.md)，<font color="red" > 更新 container.conf 配置。</font>

## (2022/06/03)
### 新增最佳实践

- 观测云小妙招
   
     - [OpenTelemetry 采样最佳实践](./cloud-native/opentelemetry-simpling.md)

## (2022/05/27)
### 新增最佳实践

- APM
   
    - [基于观测云，使用 SkyWalking 实现 RUM、APM 和日志联动分析](./insight/skywalking-apm-rum-log.md)

- 监控最佳实践
    - [OpenTelemetry 可观测建设](./cloud-native/opentelemetry-observable.md)

    - [OpenTelemetry to Jaeger 、Grafana、ELK](./cloud-native/opentelemetry-elk.md)
    - [OpenTelemetry to Grafana](./cloud-native/opentelemetry-grafana.md)
    - [OpenTelemetry to 观测云](./cloud-native/opentelemetry-guance.md)
### 更新记录

- 云原生
    - [使用 Rancher 部署和管理 Datakit，快速构建 Kubernetes 生态的可观测](./partner/rancher-datakit.md)，<font color="red" >DataKit 升级到 1.4.0，默认安装 metrics-server。</font>
## (2022/05/20)
### 新增最佳实践

- 云原生
    - [使用 Rancher 部署和管理 Datakit，快速构建 Kubernetes 生态的可观测](./partner/rancher-datakit.md)
### 更新记录

- APM
    - [web 应用监控（RUM）最佳实践](./monitoring/web.md)，<font color="red" > 修改同步载入使用的 JS。</font>
- 云原生
    - [Kubernetes 应用的 RUM-APM-LOG 联动分析](./cloud-native/k8s-rum-apm-log.md)，<font color="red" > 修改同步载入使用的 JS。</font>
   
    - [service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(上)](./cloud-native/microservices1.md)，<font color="red" > 修改 RUM 同步载入使用的 JS。</font>
    - [Kubernetes 集群日志上报到同节点的 DataKit 最佳实践](./cloud-native/log-report-one-node.md)，<font color="red" > 去掉 ENV_K8S_CLUSTER_NAME 环境变量。</font>

## (2022/05/13)

### 新增最佳实践

- 云原生
    - [Kubernetes 集群 应用使用 SkyWalking 采集链路数据](./cloud-native/k8s-skywalking.md)
   
    - [Kubernetes 集群日志上报到同节点的 DataKit 最佳实践](./cloud-native/log-report-one-node.md)
  
### 更新记录

- 云原生
    - [service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(上)](./cloud-native/microservices1.md)，<font color="red" > Gitlab CI 可观测改成产品自带功能。</font>
   
    - [service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(中)](./cloud-native/microservices2.md)，<font color="red" > 增加 Istio Mesh 监控视图、Istio Control Plane 监控视图、 Istio Service 监控视图、Istio Workload 监控视图。</font>
    - [service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(下) ](./cloud-native/microservices3.md)，<font color="red" > 增加带版本的拓扑图。</font>

## (2022/05/07)
### 更新记录

- Gitlab-CI 可观测最佳实践
    - [Gitlab-CI 可观测最佳实践](./monitoring/gitlab-ci.md) ,<font style="color:red"> 以datakit 1.2.13版本重新接入gitlab-ci，简化接入流程。</font>

## (2022/04/29)
### 新增最佳实践

- 微服务可观测最佳实践
    - [service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(上)](./cloud-native/microservices1.md)
    - [service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(中)](./cloud-native/microservices2.md)   
    - [service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(下)](./cloud-native/microservices3.md)

- 监控最佳实践
    - [JAVA OOM异常可观测最佳实践](./monitoring/java-oom.md)
### 更新记录

- 微服务可观测最佳实践
    - [基于 Istio 实现微服务可观测最佳实践](./cloud-native/istio.md)，<font color="red" >更新 istiod pod 的指标采集。</font>
   
## (2022/04/15)
### 更新记录

- 云原生
    - [Kubernetes 应用的 RUM-APM-LOG 联动分析](./cloud-native/k8s-rum-apm-log.md)，<font color="red" >更新 ConfigMap 的使用方式，dd-java-agent 镜像的描述。</font>
## (2022/04/01)
### 新增最佳实践

- 观测云小妙招
    - [多微服务项目的性能可观测实践](./cloud-native/mutil-micro-service.md)
   
    - [Kubernetes 集群使用 ExternalName 映射 DataKit 服务](./cloud-native/kubernetes-external-name.md)

   
### 更新记录

- 日志最佳实践
    - [Pod 日志采集最佳实践](./cloud-native/pod-log.md)，<font color="red" >更新logfwd采集器版本，增加logfwd 的 tag使用方式</font>
   
- 微服务可观测最佳实践
    - [基于 Istio 实现微服务可观测最佳实践](./cloud-native/istio.md)，<font color="red" >使用 external-name 打通 Istio 与 DataKit 的链路数据上报</font>

## (2022/03/18)
### 新增最佳实践

- 场景最佳实践
    - [RUM 数据上报 DataKit 集群最佳实践](./monitoring/rum-datakit-cluster.md)
- 观测云小妙招
    - [数据关联最佳实践](./insight/data-ship.md)
### 更新记录

- 日志最佳实践
    - [Pod 日志采集最佳实践](./cloud-native/pod-log.md)，<font color="red" >Logfwd 方案中增加 ConfigMap 如何使用</font>
   
    - 全部文档 <font color="red" > 优化文档中字母、数字与汉字之间的格式 </font>

## (2022/03/04)
### 新增最佳实践

- 自定义接入最佳实践
    - [快速上手 pythond 采集器的最佳实践](./insight/pythond.md)
   
- 日志最佳实践
    - [logback socket 日志采集最佳实践](./cloud-native/logback-socket.md)
### 更新记录

- 微服务可观测最佳实践
    - [Kubernetes 应用的 RUM-APM-LOG 联动分析](./cloud-native/k8s-rum-apm-log.md)，<font color="red" >修改为 logfwd 进行日志采集</font>
   
- 接入（集成）最佳实践
    - Nginx Ingress可观测最佳实践，<font color="red" >修改成最新版本Ingress部署，增加了生产级部署方案</font>


## (2022/02/18)
### 新增最佳实践

- 接入（集成）最佳实践
    - [Gitlab-CI 可观测最佳实践](./monitoring/gitlab-ci.md)  
- 日志最佳实践
    - [logback socket 日志采集最佳实践](./cloud-native/logback-socket.md)
- 观测云小妙招
    - [页面渠道引流可观测最佳实践](./monitoring/page.md)
### 更新记录

- 接入（集成）最佳实践
    - Nginx Ingress 可观测最佳实践，<font color="red" >增加了通配符的描述并修改了部署 Ingress 的截图</font>

## (2022/01/21)
### 新增最佳实践

- 场景最佳实践
    - [电商订单全流程可观测最佳实践](./insight/order.md)
### 更新记录

- 微服务可观测最佳实践
    - [Kubernetes 应用的 RUM-APM-LOG 联动分析](./cloud-native/k8s-rum-apm-log.md)，<font color="red" >增加自己打 dd-java-agent.jar 到业务镜像的示例</font>
    - [从 0 到 1 利用观测云构建 Spring cloud 服务的可观测性](./monitoring/spring-cloud-sample.md)，<font color="red" >调整了部分产品名词叫法跟观测云产品保持一致</font>
- 日志最佳实践
    - [Pod 日志采集最佳实践](./cloud-native/pod-log.md) ，<font color="red" >调整方案循序，将热门使用方案置顶</font>

## (2022/01/07)
### 新增最佳实践

- 场景最佳实践
    - [电商订单监控视图最佳实践](./insight/order.md)

- 技术理解
    - Influxdb 时间线简析
### 更新记录

- 接入（集成）最佳实践
    - [JVM 可观测最佳实践](./monitoring/jvm.md)，<font color="red" >修改 datakit 版本为 datakit:1.2.1，container.conf 使用最新配置</font>
- 微服务可观测最佳实践
    - [Kubernetes 应用的 RUM-APM-LOG 联动分析](./cloud-native/k8s-rum-apm-log.md)，<font color="red" >修改 datakit 版本为datakit:1.2.1，container.conf 使用最新配置</font>
- 技术理解
    - Springboot, OTEL and Tempo 可观测，<font color="red" >新增 OpenTelemetry 观测云接入数据架构图及处理流程</font>
