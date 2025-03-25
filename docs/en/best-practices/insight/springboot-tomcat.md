# Spring Boot Project with External Tomcat Scenario for Observable Tracing

---

## Introduction

Different enterprises use varying technology stacks when building their enterprise-level frameworks within the Java ecosystem. For instance, some companies use Spring Boot + Spring Cloud, while others use Spring Boot + Dubbo for microservice frameworks.<br/>
<<< custom_key.brand_name >>> supports various APM tools to integrate microservice tracing into <<< custom_key.brand_name >>>, allowing you to choose the appropriate APM tool based on your needs.

Typically, microservices are run as Jar files, but this article focuses on how to build these microservices into WAR packages and deploy them under Tomcat, and then integrate the tracing data into <<< custom_key.brand_name >>>. If it is a traditional WAR package project, the integration method is the same.

## SkyWalking Scenario

### Prerequisites

- Cloud host (CentOS 7.9)
- Install JDK
- Install Zookeeper
- <<< custom_key.brand_name >>> account
- Two Tomcat deployments with paths `/usr/local/df-demo/tomcat8080` and `/usr/local/df-demo/tomcat8081`
- The cloud host has <[DataKit installed](../../datakit/datakit-install.md)>

### Steps

???+ warning

    **This case uses DataKit version `1.4.9`, Spring Cloud `3.1.1`, Spring Boot `2.6.6`, Dubbo `2.7.15`, Zookeeper `3.7.1`, JDK `1.8`, and Tomcat `9.0.48` for testing**

### 1 DataKit Configuration

#### 1.1 Modify http_api (Optional)

Edit the `/usr/local/datakit/conf.d/datakit.conf` file, change the listen value of `http_api` to `0.0.0.0:9529` to ensure that other hosts can access the `9529` port on this host.<br/>
If you do not want other hosts to access DataKit, you can skip this step.

![image](../images/springboot-tomcat-1.png)

#### 1.2 Enable SkyWalking Collector

Log in to the host, copy the sample file, and enable the skywalking collector.

```bash
cd /usr/local/datakit/conf.d/skywalking
cp skywalking.conf.sample skywalking.conf
```

Restart DataKit.

```bash
systemctl restart datakit
```

### 2 APM Integration

##### 2.1 Download SkyWalking

Download [apache-skywalking-java-agent-8.11.0](https://www.apache.org/dyn/closer.cgi/skywalking/java-agent/8.11.0/apache-skywalking-java-agent-8.11.0.tgz), extract the file and name it `agent`, upload it to the directories `/usr/local/df-demo/tomcat8080` and `/usr/local/df-demo/tomcat8081` on the host.

##### 2.2 Configure Tomcat

Modify the `/usr/local/df-demo/tomcat8080/bin/catalina.sh` file and add the following content:

```bash
export CATALINA_OPTS="$CATALINA_OPTS -javaagent:/usr/local/df-demo/tomcat8080/agent/skywalking-agent.jar -Dskywalking.agent.service_name=tomcat-customer -Dskywalking.collector.backend_service=localhost:11800"
```

![image](../images/springboot-tomcat-2.png)

Parameter explanation:

- `-Dskywalking.agent.service_name`: Service name
- `-Dskywalking.collector.backend_service`: DataKit address for trace reporting + SkyWalking collector port

Modify the `/usr/local/df-demo/tomcat8081/bin/catalina.sh` file and add the following content:

```bash
export CATALINA_OPTS="$CATALINA_OPTS -javaagent:/usr/local/df-demo/tomcat8081/agent/skywalking-agent.jar -Dskywalking.agent.service_name=tomcat-provider -Dskywalking.collector.backend_service=localhost:11800"
```

Start Tomcat.

```bash
cd /usr/local/df-demo/tomcat8080/bin
./startup.sh
cd /usr/local/df-demo/tomcat8081/bin
./startup.sh
```

##### 2.3 Deploy the Project

[Download](https://github.com/stevenliu2020/springboot-tomcat) the WAR package, obtain `consumer.war` and `provider.war` from the skywalking directory.

- Place `provider.war` in the `/usr/local/df-demo/tomcat8081/webapps` directory.
- Place `consumer.war` in the `/usr/local/df-demo/tomcat8080/webapps` directory.

### 3 Observable Tracing

Access `http://192.168.0.100:8080/consumer/ping` in the browser; here, the IP is the host's address.<br/>
Log in to 「[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)」-「Application Performance Monitoring」, and you will see the `tomcat-customer` and `tomcat-provider` services.<br/>
Click on a trace to view the flame graph, span list, and call relationships.

![image](../images/springboot-tomcat-3.png)

![image](../images/springboot-tomcat-4.png)