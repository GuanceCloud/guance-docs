---
icon: zy/best-practices
---

## (2023/08/08)

### New Best Practices Added

- Monitoring
    - APM - Call Chain - [Inject dd-java-agent using datakit-operator](./monitoring/datakit-operator.md).


## (2023/02/10)

### New Best Practices Added

- Cloud Platform Integration
    - Alibaba Cloud - [Alibaba Cloud EventBridge Best Practices](./partner/aliyun_eventbridge.md)
    
## (2023/01/03)

### New Best Practices Added

- Cloud Platform Integration
    - AWS - [Deploy DataKit on EKS](./partner/eks.md).
- Monitoring
    - APM - Call Chain - [Inject dd-java-agent using datakit-operator](./monitoring/datakit-operator.md).


## (2022/12/02)

### New Best Practices Added

- Insights
    - Scene - [SpringBoot Project External Tomcat Scene Observable](./insight/springboot-tomcat.md).

## (2022/11/18)

### New Best Practices Added

- Insights
    - <<< custom_key.brand_name >>> Tips - [Configure HTTPS for DataKit](./insight/datakit-https.md).

- Monitoring
    - APM - Performance Optimization - [Optimize Application Performance with async-profiler](./monitoring/async-profiler.md).
  
## (2022/10/28)

### New Best Practices Added

- Monitoring
    - APM - [Kafka Observability Best Practices](./monitoring/kafka.md).


## (2022/10/17)

### New Best Practices Added

- Cloud Native
    - Logs - [Collect Amazon ECS Logs with <<< custom_key.brand_name >>>](./cloud-native/amazon-ecs.md).


## (2022/10/08)

### New Best Practices Added

- Monitoring
    - ITIM - [Ansible Batch Processing in Practice](./monitoring/ansible-batch-processing.md).


## (2022/09/26)

### New Best Practices Added

- Cloud Native
    - Others - [Best Practices for Collecting Metrics from Multiple Kubernetes Clusters](./cloud-native/multi-cluster.md).


## (2022/09/16)

### New Best Practices Added

- Monitoring
    - APM - Middleware - [Insights into MySQL](./monitoring/mysql.md).

### Update Records

- Monitoring
    - APM - [Custom Instrumentation with DDtrace](./monitoring/ddtrace-instrumentation.md). <font color="red" > Updated code, now supports dubbo3 after upgrade.</font>

## (2022/09/02)

### New Best Practices Added

- Cloud Native 
    - Others - [Enable Ingress Observability with CRD](./cloud-native/ingress-crd.md).


## (2022/08/26)

### New Best Practices Added

- Monitoring
    - APM - [Custom Instrumentation with DDtrace](./monitoring/ddtrace-instrumentation.md).

## (2022/08/19)

### Update Records

- Insights
    - Data Correlation - [JAVA Application RUM-APM-LOG Linked Analysis](./insight/java-rum-apm-log.md), <font color="red" > Updated screenshots.</font>



## (2022/08/12)

### New Best Practices Added

- Insights
    - Scene - [Integrate Dubbo Microservices into <<< custom_key.brand_name >>> in Intranet Scenarios](./insight/scene-dubbo.md).

### Update Records

- Cloud Native
    - Others - [RUM-APM-LOG Linked Analysis for Kubernetes Applications](./cloud-native/k8s-rum-apm-log.md), <font color="red" > Upgraded DataKit, updated screenshots.</font>

  
## (2022/08/05)

### New Best Practices Added

- Monitoring  
    - [Implement Custom traceId Using extract + TextMapAdapter](./monitoring/ddtrace-custom-traceId.md).

### Update Records

- Monitoring  
    - [Host Observability Best Practices (Linux)](./monitoring/host-linux.md),<font color="red" > Optimized metrics and collection process</font>.
	
- Insights  
    - [Use SkyWalking to Achieve RUM, APM, and Log Linked Analysis Based on <<< custom_key.brand_name >>>](insight/skywalking-apm-rum-log.md),<font color="red" > Added apm-spring-cloud-gateway usage instructions for skywalking</font>.

## (2022/07/15)
### New Best Practices Added

- Cloud Platform Integration
    - [Best Practices for Deploying DataKit on Rancher](./partner/rancher-datakit-install.md).


## (2022/07/08)
### New Best Practices Added

- Integration Best Practices
    - [JVM Observability Best Practices with Skywalking](./monitoring/skywalking-jvm.md).
  
## (2022/06/24)
### Update Records
- Cloud Native
  - [Deploy and Manage Datakit Using Rancher to Quickly Build Kubernetes Observability](./partner/rancher-datakit.md),<font color="red" > Ignore some tags.</font>
  - [Service Mesh Microservice Architecture from Development to Canary Release Full Process Best Practices (Part 1)](./cloud-native/microservices1.md),<font color="red" > Ignore some tags.</font>
  - [Achieve Microservice Observability Best Practices Based on Istio](./cloud-native/istio.md),<font color="red" > Ignore some tags.</font>

## (2022/06/17)
### New Best Practices Added
- APM
    - [Achieve Trace Observability for GraalVM and Spring Native Projects](./monitoring/spring-native.md)
- Integration
    - [Host Observability Best Practices (Linux)](./monitoring/host-linux.md)
### Update Records

- Integration Best Practices
    - [Nginx Ingress Observability Best Practices](./cloud-native/ingress-nginx.md)，<font color="red" > Default ignore build, le, method tags.</font>


## (2022/06/10)
### Update Records
- Cloud Native
    - [Deploy and Manage Datakit Using Rancher to Quickly Build Kubernetes Observability](./partner/rancher-datakit.md)，<font color="red" > Add ingressgateway, egressgateway metric collection, update container.conf configuration.</font>
    - [Service Mesh Microservice Architecture from Development to Canary Release Full Process Best Practices (Part 1)](./cloud-native/microservices1.md)，<font color="red" > Add ingressgateway, egressgateway metric collection, container.conf update.</font>
    - [Achieve Microservice Observability Best Practices Based on Istio](./cloud-native/istio.md)，<font color="red" > Add ingressgateway, egressgateway metric collection.</font>

- Logs
    - [Pod Log Collection Best Practices](./cloud-native/pod-log.md)，<font color="red" > Add remarks to Logfwd port.</font>
    - [Logback Socket Log Collection Best Practices for K8s](./cloud-native/k8s-logback-socket.md)，<font color="red" > Update container.conf configuration.</font>
    - [Several Ways to Collect Logs in a Kubernetes Cluster](./cloud-native/k8s-logs.md)，<font color="red" > Update container.conf configuration.</font>

## (2022/06/03)
### New Best Practices Added

- <<< custom_key.brand_name >>> Tips
   
     - [OpenTelemetry Sampling Best Practices](./cloud-native/opentelemetry-simpling.md)

## (2022/05/27)
### New Best Practices Added

- APM
   
    - [Use SkyWalking to Achieve RUM, APM, and Log Linked Analysis Based on <<< custom_key.brand_name >>>](./insight/skywalking-apm-rum-log.md)

- Monitoring Best Practices
    - [Building Observability with OpenTelemetry](./cloud-native/opentelemetry-observable.md)

    - [Send OpenTelemetry Data to Jaeger, Grafana, ELK](./cloud-native/opentelemetry-elk.md)
    - [Send OpenTelemetry Data to Grafana](./cloud-native/opentelemetry-grafana.md)
    - [Send OpenTelemetry Data to <<< custom_key.brand_name >>>](./cloud-native/opentelemetry-guance.md)
### Update Records

- Cloud Native
    - [Deploy and Manage Datakit Using Rancher to Quickly Build Kubernetes Observability](./partner/rancher-datakit.md)，<font color="red" > Upgrade DataKit to 1.4.0, default install metrics-server.</font>
## (2022/05/20)
### New Best Practices Added

- Cloud Native
    - [Deploy and Manage Datakit Using Rancher to Quickly Build Kubernetes Observability](./partner/rancher-datakit.md)
### Update Records

- APM
    - [Web Application Monitoring (RUM) Best Practices](./monitoring/web.md)，<font color="red" > Modify JS used for synchronous loading.</font>
- Cloud Native
    - [RUM-APM-LOG Linked Analysis for Kubernetes Applications](./cloud-native/k8s-rum-apm-log.md)，<font color="red" > Modify JS used for synchronous loading.</font>
   
    - [Service Mesh Microservice Architecture from Development to Canary Release Full Process Best Practices (Part 1)](./cloud-native/microservices1.md)，<font color="red" > Modify JS used for synchronous loading.</font>
    - [Best Practices for Reporting Kubernetes Cluster Logs to the Same Node's DataKit](./cloud-native/log-report-one-node.md)，<font color="red" > Remove ENV_K8S_CLUSTER_NAME environment variable.</font>

## (2022/05/13)

### New Best Practices Added

- Cloud Native
    - [Application Use of SkyWalking to Collect Tracing Data in Kubernetes Clusters](./cloud-native/k8s-skywalking.md)
   
    - [Best Practices for Reporting Kubernetes Cluster Logs to the Same Node's DataKit](./cloud-native/log-report-one-node.md)
  
### Update Records

- Cloud Native
    - [Service Mesh Microservice Architecture from Development to Canary Release Full Process Best Practices (Part 1)](./cloud-native/microservices1.md)，<font color="red" > Change Gitlab CI observability to built-in product feature.</font>
   
    - [Service Mesh Microservice Architecture from Development to Canary Release Full Process Best Practices (Part 2)](./cloud-native/microservices2.md)，<font color="red" > Add Istio Mesh monitoring view, Istio Control Plane monitoring view, Istio Service monitoring view, Istio Workload monitoring view.</font>
    - [Service Mesh Microservice Architecture from Development to Canary Release Full Process Best Practices (Part 3)](./cloud-native/microservices3.md)，<font color="red" > Add versioned topology diagram.</font>

## (2022/05/07)
### Update Records

- Gitlab-CI Observability Best Practices
    - [Gitlab-CI Observability Best Practices](./monitoring/gitlab-ci.md) ,<font style="color:red"> Reintegrate gitlab-ci using datakit 1.2.13 version, simplify integration process.</font>

## (2022/04/29)
### New Best Practices Added

- Microservice Observability Best Practices
    - [Service Mesh Microservice Architecture from Development to Canary Release Full Process Best Practices (Part 1)](./cloud-native/microservices1.md)
    - [Service Mesh Microservice Architecture from Development to Canary Release Full Process Best Practices (Part 2)](./cloud-native/microservices2.md)   
    - [Service Mesh Microservice Architecture from Development to Canary Release Full Process Best Practices (Part 3)](./cloud-native/microservices3.md)

- Monitoring Best Practices
    - [JAVA OOM Exception Observability Best Practices](./monitoring/java-oom.md)
### Update Records

- Microservice Observability Best Practices
    - [Achieve Microservice Observability Best Practices Based on Istio](./cloud-native/istio.md)，<font color="red" > Update istiod pod metric collection.</font>
   
## (2022/04/15)
### Update Records

- Cloud Native
    - [RUM-APM-LOG Linked Analysis for Kubernetes Applications](./cloud-native/k8s-rum-apm-log.md)，<font color="red" > Update ConfigMap usage, description of dd-java-agent image.</font>
## (2022/04/01)
### New Best Practices Added

- <<< custom_key.brand_name >>> Tips
    - [Performance Observability Practices for Multi-Microservice Projects](./cloud-native/mutil-micro-service.md)
   
    - [Use ExternalName to Map DataKit Services in Kubernetes Clusters](./cloud-native/kubernetes-external-name.md)

   
### Update Records

- Log Best Practices
    - [Pod Log Collection Best Practices](./cloud-native/pod-log.md)，<font color="red" > Update logfwd collector version, add tag usage methods for logfwd</font>
   
- Microservice Observability Best Practices
    - [Achieve Microservice Observability Best Practices Based on Istio](./cloud-native/istio.md)，<font color="red" > Use external-name to connect Istio with DataKit trace data reporting</font>

## (2022/03/18)
### New Best Practices Added

- Scene Best Practices
    - [Best Practices for Reporting RUM Data to DataKit Clusters](./monitoring/rum-datakit-cluster.md)
- <<< custom_key.brand_name >>> Tips
    - [Data Association Best Practices](./insight/data-ship.md)
### Update Records

- Log Best Practices
    - [Pod Log Collection Best Practices](./cloud-native/pod-log.md)，<font color="red" > Add ConfigMap usage in Logfwd solution</font>
   
    - All Documents <font color="red" > Optimize formatting between letters, numbers, and Chinese characters in documents </font>

## (2022/03/04)
### New Best Practices Added

- Custom Integration Best Practices
    - [Best Practices for Getting Started with Python Collector](./insight/pythond.md)
   
- Log Best Practices
    - [Logback Socket Log Collection Best Practices](./cloud-native/logback-socket.md)
### Update Records

- Microservice Observability Best Practices
    - [RUM-APM-LOG Linked Analysis for Kubernetes Applications](./cloud-native/k8s-rum-apm-log.md)，<font color="red" > Modify to use logfwd for log collection</font>
   
- Integration Best Practices
    - Nginx Ingress Observability Best Practices，<font color="red" > Modify to latest version Ingress deployment, add production-level deployment solutions</font>


## (2022/02/18)
### New Best Practices Added

- Integration Best Practices
    - [Gitlab-CI Observability Best Practices](./monitoring/gitlab-ci.md)  
- Log Best Practices
    - [Logback Socket Log Collection Best Practices](./cloud-native/logback-socket.md)
- <<< custom_key.brand_name >>> Tips
    - [Page Channel Traffic Observability Best Practices](./monitoring/page.md)
### Update Records

- Integration Best Practices
    - Nginx Ingress Observability Best Practices，<font color="red" > Add wildcard descriptions and modify Ingress deployment screenshots</font>

## (2022/01/21)
### New Best Practices Added

- Scene Best Practices
    - [E-commerce Order Full Process Observability Best Practices](./insight/order.md)
### Update Records

- Microservice Observability Best Practices
    - [RUM-APM-LOG Linked Analysis for Kubernetes Applications](./cloud-native/k8s-rum-apm-log.md)，<font color="red" > Add example of building dd-java-agent.jar into business image</font>
    - [Build Spring Cloud Service Observability from 0 to 1 with <<< custom_key.brand_name >>>](./monitoring/spring-cloud-sample.md)，<font color="red" > Adjust product name calls to align with <<< custom_key.brand_name >>> products</font>
- Log Best Practices
    - [Pod Log Collection Best Practices](./cloud-native/pod-log.md) ，<font color="red" > Adjust solution order, prioritize popular usage solutions</font>

## (2022/01/07)
### New Best Practices Added

- Scene Best Practices
    - [E-commerce Order Monitoring View Best Practices](./insight/order.md)

- Technical Understanding
    - Influxdb Time Series Simplified Analysis
### Update Records

- Integration Best Practices
    - [JVM Observability Best Practices](./monitoring/jvm.md)，<font color="red" > Modify datakit version to datakit:1.2.1, use latest container.conf configuration</font>
- Microservice Observability Best Practices
    - [RUM-APM-LOG Linked Analysis for Kubernetes Applications](./cloud-native/k8s-rum-apm-log.md)，<font color="red" > Modify datakit version to datakit:1.2.1, use latest container.conf configuration</font>
- Technical Understanding
    - Springboot, OTEL and Tempo Observability，<font color="red" > Add OpenTelemetry <<< custom_key.brand_name >>> data architecture diagram and processing flow</font>