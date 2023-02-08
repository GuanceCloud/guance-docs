---
icon: zy/integrations
---

# 集成

---

观测云具有全栈数据采集能力，现已支持上百种数据源的采集。<br/>
观测云支持官方出品的标准采集器 [DataKit](../datakit/) ，基于 DataKit 的数据采集能力，也支持接入第三方数据。

集成文档重点介绍，观测云接入各技术栈指标数据的操作指引。


<div class="grid cards" markdown>

-   :material-table-column-plus-after:{ .lg .middle } __主机系统__

    ---

    指导观测 [`CPU`](./host/default/index.md) [`Disk`](./host/default/index.md) [`eBPF`](./host/ebpf.md) [`Processes`](./host/processes.md) 等指标集数据

    <br/>
    [**:octicons-arrow-right-24: Getting more**](./host/index.md)


-   :fontawesome-solid-database:{ .lg .middle } __数据存储__

    ---

    指导观测 [`MySQL`](./datastorage/mysql.md) [`Oracle`](./datastorage/oracle.md) [`Redis`](./datastorage/redis.md) [`MongoDB`](./datastorage/mongodb.md) 等指标集数据

    <br/>
    [**:octicons-arrow-right-24: Getting more**](./datastorage/index.md)

-   :material-middleware:{ .lg .middle } __中间件__

    ---

    指导观测 [`Kafka`](./middleware/kafka.md) [`RocketMQ`](./middleware/rocketmq.md) [`JVM`](./middleware/jvm.md) [`Logstash`](./middleware/logstash-metrics.md) [`Flink`](./middleware/flink.md) 等指标集数据

    <br/>
    [**:octicons-arrow-right-24: Getting more**](./middleware/index.md)

-   :fontawesome-solid-circle-nodes:{ .lg .middle } __容器编排__

    ---

    指导观测 [`Docker`](./container/docker.md) [`K8s API Server`](./container/kubernetes-api-server.md) [`K8s Scheduler`](./container/kube-scheduler.md) 等指标集数据

    <br/>
    [**:octicons-arrow-right-24: Getting more**](./container/index.md)

-   :octicons-cloud-16:{ .lg .middle } __云厂商__

    ---

    指导观测 [`阿里云`](./cloud/aliyun/aliyun-prod-func.md) [`AWS`](./cloud/aws/aws-prod-func.md) [`腾讯云`](./cloud/tencent/tencent-prod-func.md) [`华为云`](./cloud/huawei/huawei-prod-func.md) 等指标集数据

    <br/>
    [**:octicons-arrow-right-24: Getting more**](./cloud/index.md)


-   :material-web:{ .lg .middle } __网络连接__

    ---

    指导观测 [`云拨测`](./network/ping.md) [`SSH`](./network/ssh.md) 等指标集数据

    <br/>
    [**:octicons-arrow-right-24: Getting more**](./network/index.md)

-   :material-server-network:{ .lg .middle } __Web服务__

    ---

    指导观测 [`Apache`](./webserver/apache.md) [`Nginx`](./webserver/nginx.md) [`HAProxy`](./webserver/haproxy.md) 相关指标集数据

    <br/>
    [**:octicons-arrow-right-24: Getting more**](./webserver/index.md)

-   :fontawesome-solid-code-merge:{ .lg .middle } __CI/CD__

    ---

    指导观测 [`GitLab`](./cicd/gitlab.md) [`Jenkins`](./cicd/jenkins.md) 相关指标集数据

    <br/>
    [**:octicons-arrow-right-24: Getting more**](./cicd/index.md)

-   :material-transit-connection-variant:{ .lg .middle } __APM__

    ---

    指导观测 [`JAVA`](./apm/ddtrace-java.md) [`Python`](./apm/ddtrace-python.md) [`Node.js`](./apm/ddtrace-nodejs.md) [`Go`](./apm/ddtrace-golang.md) 等指标集数据

    <br/>
    [**:octicons-arrow-right-24: Getting more**](./apm/index.md)

-   :fontawesome-solid-users:{ .lg .middle } __RUM__

    ---

    指导观测 [`Android`](./rum/rum-android.md) [`iOS`](./rum/rum-ios.md) [`小程序`](./rum/rum-miniapp.md) [`Web页面`](./rum/rum-web-h5.md) 相关指标集数据

    <br/>
    [**:octicons-arrow-right-24: Getting more**](./rum/index.md)

-   :material-math-log:{ .lg .middle } __日志__

    ---

    指导观测 [`Fluentd`](./logs/fluentd.md) [`Logstash`](./logs/logstash.md) [`OpenTelemetry Collector`](./logs/opentelemetry-collector.md) 相关指标集数据

    <br/>
    [**:octicons-arrow-right-24: Getting more**](./logs/index.md)

</div>
