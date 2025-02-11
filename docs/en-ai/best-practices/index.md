---
icon: zy/best-practices
---

## (2023/08/08)

### New Best Practices Added

- Monitoring
    - Application Performance Monitoring (APM) - Call Chain - [Inject dd-java-agent using datakit-operator](./monitoring/datakit-operator.md).


## (2023/02/10)

### New Best Practices Added

- Cloud Platform Integration
    - Alibaba Cloud - [Alibaba Cloud EventBridge Best Practices](./partner/aliyun_eventbridge.md)
    
## (2023/01/03)

### New Best Practices Added

- Cloud Platform Integration
    - AWS - [Deploy DataKit on EKS](./partner/eks.md).
- Monitoring
    - Application Performance Monitoring (APM) - Call Chain - [Inject dd-java-agent using datakit-operator](./monitoring/datakit-operator.md).

## (2022/12/02)

### New Best Practices Added

- Insights
    - Scenario - [SpringBoot Project External Tomcat Scene Observability](./insight/springboot-tomcat.md).

## (2022/11/18)

### New Best Practices Added

- Insights
    - Guance Tips - [Configure HTTPS for DataKit](./insight/datakit-https.md).

- Monitoring
    - Application Performance Monitoring (APM) - Performance Optimization - [Optimize Application Performance with async-profiler](./monitoring/async-profiler.md).
  
## (2022/10/28)

### New Best Practices Added

- Monitoring
    - Application Performance Monitoring (APM) - [Kafka Observability Best Practices](./monitoring/kafka.md).

## (2022/10/17)

### New Best Practices Added

- Cloud Native
    - Logs - [Collect Amazon ECS Logs with Guance](./cloud-native/amazon-ecs.md).

## (2022/10/08)

### New Best Practices Added

- Monitoring
    - Infrastructure Monitoring (ITIM) - [Ansible Batch Processing in Practice](./monitoring/ansible-batch-processing.md).

## (2022/09/26)

### New Best Practices Added

- Cloud Native
    - Others - [Best Practices for Collecting Metrics from Multiple Kubernetes Clusters](./cloud-native/multi-cluster.md).

## (2022/09/16)

### New Best Practices Added

- Monitoring
    - Application Performance Monitoring (APM) - Middleware - [Insights into MySQL](./monitoring/mysql.md).

### Update Record

- Monitoring
    - Application Performance Monitoring (APM) - [Custom DDtrace Instrumentation](./monitoring/ddtrace-instrumentation.md). <font color="red"> Updated code, now supports dubbo3 after upgrade.</font>

## (2022/09/02)

### New Best Practices Added

- Cloud Native 
    - Others - [Enable Ingress Observability Using CRD](./cloud-native/ingress-crd.md).

## (2022/08/26)

### New Best Practices Added

- Monitoring
    - Application Performance Monitoring (APM) - [Custom DDtrace Instrumentation](./monitoring/ddtrace-instrumentation.md).

## (2022/08/19)

### Update Record

- Insights
    - Data Correlation - [JAVA Application RUM-APM-LOG Joint Analysis](./insight/java-rum-apm-log.md), <font color="red"> Updated screenshots.</font>

## (2022/08/12)

### New Best Practices Added

- Insights
    - Scenario - [Intranet Scenario Dubbo Microservices Access to Guance](./insight/scene-dubbo.md).

### Update Record

- Cloud Native
    - Others - [RUM-APM-LOG Joint Analysis for Kubernetes Applications](./cloud-native/k8s-rum-apm-log.md), <font color="red"> Upgraded DataKit, updated screenshots.</font>

## (2022/08/05)

### New Best Practices Added

- Monitoring  
    - [Implement Custom traceId Using extract + TextMapAdapter](./monitoring/ddtrace-custom-traceId.md).

### Update Record

- Monitoring  
    - [Host Observability Best Practices (Linux)](./monitoring/host-linux.md), <font color="red"> Optimized metrics and collection process</font>.

- Insights  
    - [Joint Analysis of RUM, APM, and Logs Using SkyWalking on Guance](insight/skywalking-apm-rum-log.md), <font color="red"> Added apm-spring-cloud-gateway usage instructions</font>.

## (2022/07/15)
### New Best Practices Added

- Cloud Platform Integration
    - [Deploy DataKit on Rancher Best Practices](./partner/rancher-datakit-install.md).

## (2022/07/08)
### New Best Practices Added

- Integration Best Practices
    - [JVM Observability Best Practices Using Skywalking](./monitoring/skywalking-jvm.md).

## (2022/06/24)
### Update Record
- Cloud Native
  - [Deploy and Manage Datakit with Rancher for Quick Kubernetes Observability](./partner/rancher-datakit.md), <font color="red" > Ignore some tags.</font>
  - [Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 1)](./cloud-native/microservices1.md), <font color="red" > Ignore some tags.</font>
  - [Microservices Observability Best Practices Using Istio](./cloud-native/istio.md), <font color="red" > Ignore some tags.</font>

## (2022/06/17)
### New Best Practices Added
- APM
    - [Achieve Observability for GraalVM and Spring Native Projects](./monitoring/spring-native.md)
- Integration Best Practices
    - [Host Observability Best Practices (Linux)](./monitoring/host-linux.md)

### Update Record

- Integration Best Practices
    - [Nginx Ingress Observability Best Practices](./cloud-native/ingress-nginx.md), <font color="red" > Default ignore build, le, method tags.</font>

## (2022/06/10)
### Update Record
- Cloud Native
    - [Deploy and Manage Datakit with Rancher for Quick Kubernetes Observability](./partner/rancher-datakit.md), <font color="red" > Add ingressgateway, egressgateway metric collection, update container.conf configuration.</font>
    - [Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 1)](./cloud-native/microservices1.md), <font color="red" > Add ingressgateway, egressgateway metric collection, update container.conf configuration.</font>
    - [Microservices Observability Best Practices Using Istio](./cloud-native/istio.md), <font color="red" > Add ingressgateway, egressgateway metric collection.</font>

- Logs
    - [Pod Log Collection Best Practices](./cloud-native/pod-log.md), <font color="red" > Add remarks for Logfwd port.</font>
    - [Logback Socket Log Collection Best Practices in K8s](./cloud-native/k8s-logback-socket.md), <font color="red" > Update container.conf configuration.</font>
    - [Several Ways to Collect Logs in Kubernetes Cluster](./cloud-native/k8s-logs.md), <font color="red" > Update container.conf configuration.</font>

## (2022/06/03)
### New Best Practices Added

- Guance Tips
   
     - [OpenTelemetry Sampling Best Practices](./cloud-native/opentelemetry-simpling.md)

## (2022/05/27)
### New Best Practices Added

- APM
   
    - [Joint Analysis of RUM, APM, and Logs Using SkyWalking on Guance](./insight/skywalking-apm-rum-log.md)

- Monitoring Best Practices
    - [Building Observability with OpenTelemetry](./cloud-native/opentelemetry-observable.md)

    - [OpenTelemetry to Jaeger, Grafana, ELK](./cloud-native/opentelemetry-elk.md)
    - [OpenTelemetry to Grafana](./cloud-native/opentelemetry-grafana.md)
    - [OpenTelemetry to Guance](./cloud-native/opentelemetry-guance.md)
### Update Record

- Cloud Native
    - [Deploy and Manage Datakit with Rancher for Quick Kubernetes Observability](./partner/rancher-datakit.md), <font color="red" > Upgrade DataKit to 1.4.0, default install metrics-server.</font>

## (2022/05/20)
### New Best Practices Added

- Cloud Native
    - [Deploy and Manage Datakit with Rancher for Quick Kubernetes Observability](./partner/rancher-datakit.md)

### Update Record

- APM
    - [Web Application Monitoring (RUM) Best Practices](./monitoring/web.md), <font color="red" > Modify the JS used for synchronous loading.</font>
- Cloud Native
    - [RUM-APM-LOG Joint Analysis for Kubernetes Applications](./cloud-native/k8s-rum-apm-log.md), <font color="red" > Modify the JS used for synchronous loading.</font>
   
    - [Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 1)](./cloud-native/microservices1.md), <font color="red" > Modify the JS used for synchronous loading.</font>
    - [Best Practices for Reporting Kubernetes Cluster Logs to the Same Node's DataKit](./cloud-native/log-report-one-node.md), <font color="red" > Remove ENV_K8S_CLUSTER_NAME environment variable.</font>

## (2022/05/13)

### New Best Practices Added

- Cloud Native
    - [Using SkyWalking to Collect Tracing Data for Kubernetes Applications](./cloud-native/k8s-skywalking.md)
   
    - [Best Practices for Reporting Kubernetes Cluster Logs to the Same Node's DataKit](./cloud-native/log-report-one-node.md)
  
### Update Record

- Cloud Native
    - [Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 1)](./cloud-native/microservices1.md), <font color="red" > Change Gitlab CI observability to built-in product feature.</font>
   
    - [Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 2)](./cloud-native/microservices2.md), <font color="red" > Add Istio Mesh monitoring view, Istio Control Plane monitoring view, Istio Service monitoring view, Istio Workload monitoring view.</font>
    - [Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 3)](./cloud-native/microservices3.md), <font color="red" > Add versioned topology diagram.</font>

## (2022/05/07)
### Update Record

- Gitlab-CI Observability Best Practices
    - [Gitlab-CI Observability Best Practices](./monitoring/gitlab-ci.md) ,<font style="color:red"> Reintegrate with gitlab-ci using datakit 1.2.13, simplify integration process.</font>

## (2022/04/29)
### New Best Practices Added

- Microservices Observability Best Practices
    - [Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 1)](./cloud-native/microservices1.md)
    - [Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 2)](./cloud-native/microservices2.md)   
    - [Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 3)](./cloud-native/microservices3.md)

- Monitoring Best Practices
    - [JAVA OOM Exception Observability Best Practices](./monitoring/java-oom.md)
### Update Record

- Microservices Observability Best Practices
    - [Microservices Observability Best Practices Using Istio](./cloud-native/istio.md), <font color="red" > Update istiod pod metric collection.</font>
   
## (2022/04/15)
### Update Record

- Cloud Native
    - [RUM-APM-LOG Joint Analysis for Kubernetes Applications](./cloud-native/k8s-rum-apm-log.md), <font color="red" > Update ConfigMap usage, description of dd-java-agent image.</font>

## (2022/04/01)
### New Best Practices Added

- Guance Tips
    - [Performance Observability Practices for Multi-Microservice Projects](./cloud-native/mutil-micro-service.md)
   
    - [Mapping DataKit Service in Kubernetes Cluster Using ExternalName](./cloud-native/kubernetes-external-name.md)

   
### Update Record

- Log Best Practices
    - [Pod Log Collection Best Practices](./cloud-native/pod-log.md), <font color="red" > Update logfwd collector version, add logfwd tag usage.</font>
   
- Microservices Observability Best Practices
    - [Microservices Observability Best Practices Using Istio](./cloud-native/istio.md), <font color="red" > Use external-name to connect Istio with DataKit for trace data reporting.</font>

## (2022/03/18)
### New Best Practices Added

- Scenario Best Practices
    - [Best Practices for Reporting RUM Data to DataKit Cluster](./monitoring/rum-datakit-cluster.md)
- Guance Tips
    - [Data Correlation Best Practices](./insight/data-ship.md)
### Update Record

- Log Best Practices
    - [Pod Log Collection Best Practices](./cloud-native/pod-log.md), <font color="red" > Add ConfigMap usage in Logfwd solution.</font>
   
    - All Documents <font color="red" > Optimize formatting between letters, numbers, and Chinese characters in documents.</font>

## (2022/03/04)
### New Best Practices Added

- Custom Integration Best Practices
    - [Quick Start with Pythond Collector Best Practices](./insight/pythond.md)
   
- Log Best Practices
    - [Logback Socket Log Collection Best Practices](./cloud-native/logback-socket.md)
### Update Record

- Microservices Observability Best Practices
    - [RUM-APM-LOG Joint Analysis for Kubernetes Applications](./cloud-native/k8s-rum-apm-log.md), <font color="red" > Change to logfwd for log collection.</font>
   
- Integration Best Practices
    - Nginx Ingress Observability Best Practices, <font color="red" > Updated to latest Ingress deployment, added production-level deployment solutions.</font>

## (2022/02/18)
### New Best Practices Added

- Integration Best Practices
    - [Gitlab-CI Observability Best Practices](./monitoring/gitlab-ci.md)  
- Log Best Practices
    - [Logback Socket Log Collection Best Practices](./cloud-native/logback-socket.md)
- Guance Tips
    - [Page Channel Traffic Observability Best Practices](./monitoring/page.md)
### Update Record

- Integration Best Practices
    - Nginx Ingress Observability Best Practices, <font color="red" > Added wildcard description and updated Ingress deployment screenshots.</font>

## (2022/01/21)
### New Best Practices Added

- Scenario Best Practices
    - [E-commerce Order Full Process Observability Best Practices](./insight/order.md)
### Update Record

- Microservices Observability Best Practices
    - [RUM-APM-LOG Joint Analysis for Kubernetes Applications](./cloud-native/k8s-rum-apm-log.md), <font color="red" > Added example of adding dd-java-agent.jar to business image.</font>
    - [Building Observability for Spring Cloud Services from 0 to 1](./monitoring/spring-cloud-sample.md), <font color="red" > Adjusted product terminology to align with Guance product naming.</font>
- Log Best Practices
    - [Pod Log Collection Best Practices](./cloud-native/pod-log.md), <font color="red" > Adjusted solution order, prioritizing popular use cases.</font>

## (2022/01/07)
### New Best Practices Added

- Scenario Best Practices
    - [E-commerce Order Monitoring View Best Practices](./insight/order.md)

- Technical Understanding
    - Influxdb Time Series Simplified Analysis
### Update Record

- Integration Best Practices
    - [JVM Observability Best Practices](./monitoring/jvm.md), <font color="red" > Changed datakit version to datakit:1.2.1, used latest container.conf configuration.</font>
- Microservices Observability Best Practices
    - [RUM-APM-LOG Joint Analysis for Kubernetes Applications](./cloud-native/k8s-rum-apm-log.md), <font color="red" > Changed datakit version to datakit:1.2.1, used latest container.conf configuration.</font>
- Technical Understanding
    - Springboot, OTEL and Tempo Observability, <font color="red" > Added OpenTelemetry Guance data ingestion architecture diagram and processing flow.</font>