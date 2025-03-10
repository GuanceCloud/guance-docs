# Spring Boot Project with External Tomcat for Observable Tracing

---

## Introduction

Different enterprises use different technology stacks when building their enterprise-level frameworks within the Java ecosystem. For example, some companies use Spring Boot + Spring Cloud, while others use Spring Boot + Dubbo.<br/>
<<< custom_key.brand_name >>> supports various APM tools to integrate microservice tracing into <<< custom_key.brand_name >>>. You can choose the appropriate APM tool based on your needs.

Typically, microservices are run as JAR files. This article focuses on how to build these microservices into WAR packages and deploy them on Tomcat, and then integrate the tracing data into <<< custom_key.brand_name >>>. If it is a traditional WAR package project, the integration method is the same.

## SkyWalking Scenario

### Prerequisites

- Cloud server (CentOS 7.9)
- Install JDK
- Install Zookeeper
- <<< custom_key.brand_name >>> account
- Two Tomcat instances deployed at `/usr/local/df-demo/tomcat8080` and `/usr/local/df-demo/tomcat8081`
- The cloud server has <[DataKit installed](../../datakit/datakit-install.md)>

### Steps

???+ warning

    **This case uses DataKit version `1.4.9`, Spring Cloud `3.1.1`, Spring Boot `2.6.6`, Dubbo `2.7.15`, Zookeeper `3.7.1`, JDK `1.8`, and Tomcat `9.0.48` for testing**

### 1 Configure DataKit

#### 1.1 Modify http_api (Optional)

Edit the `/usr/local/datakit/conf.d/datakit.conf` file and change the `http_api` listen value to `0.0.0.0:9529` to ensure that other hosts can access port `9529` on this host.<br/>
If you do not want other hosts to access DataKit, you can skip this step.

![image](../images/springboot-tomcat-1.png)

#### 1.2 Enable SkyWalking Collector

Log in to the host, copy the sample file, and enable the SkyWalking collector.

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

Download [apache-skywalking-java-agent-8.11.0](https://www.apache.org/dyn/closer.cgi/skywalking/java-agent/8.11.0/apache-skywalking-java-agent-8.11.0.tgz), extract it, and rename the folder to `agent`. Upload it to the directories `/usr/local/df-demo/tomcat8080` and `/usr/local/df-demo/tomcat8081` on the host.

##### 2.2 Configure Tomcat

Modify the `/usr/local/df-demo/tomcat8080/bin/catalina.sh` file and add the following content:

```bash
export CATALINA_OPTS="$CATALINA_OPTS -javaagent:/usr/local/df-demo/tomcat8080/agent/skywalking-agent.jar -Dskywalking.agent.service_name=tomcat-customer -Dskywalking.collector.backend_service=localhost:11800"
```

![image](../images/springboot-tomcat-2.png)

Parameter descriptions:

- `-Dskywalking.agent.service_name`: Service name
- `-Dskywalking.collector.backend_service`: DataKit address + SkyWalking collector port for trace reporting

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

##### 2.3 Deploy Projects

[Download](https://github.com/stevenliu2020/springboot-tomcat) the WAR packages and obtain `consumer.war` and `provider.war` from the `skywalking` directory.

- Place `provider.war` in the `/usr/local/df-demo/tomcat8081/webapps` directory.
- Place `consumer.war` in the `/usr/local/df-demo/tomcat8080/webapps` directory.

### 3 Observable Tracing

Access `http://192.168.0.100:8080/consumer/ping` in your browser, where the IP is the address of the host.<br/>
Log in to 「[<<< custom_key.brand_name >>>](https://console.guance.com/)」-「APM」, and you should see the `tomcat-customer` and `tomcat-provider` services.<br/>
Click on a trace to view flame graphs, span lists, call relationships, etc.

![image](../images/springboot-tomcat-3.png)

![image](../images/springboot-tomcat-4.png)