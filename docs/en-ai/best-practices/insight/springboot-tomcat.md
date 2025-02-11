# Spring Boot Project with External Tomcat for Trace Observability

---

## Introduction

Different enterprises use varying technology stacks when building their enterprise-level frameworks within the Java ecosystem. For example, some enterprises use Spring Boot + Spring Cloud, while others opt for Spring Boot + Dubbo.<br/>
Guance supports different APM tools to integrate microservice traces into Guance. You can choose an APM tool that best suits your needs.

Typically, microservices are run as JAR files. This article focuses on building these microservices into WAR packages and deploying them under Tomcat, explaining how to integrate trace data into Guance. The integration method is the same for traditional WAR package projects.

## SkyWalking Scenario

### Prerequisites

- Cloud server (CentOS 7.9)
- Install JDK
- Install Zookeeper
- Guance account
- Two Tomcat deployments at paths `/usr/local/df-demo/tomcat8080` and `/usr/local/df-demo/tomcat8081`
- The cloud server has already <[installed DataKit](../../datakit/datakit-install.md)>

### Steps

???+ warning

    **This case uses DataKit version `1.4.9`, Spring Cloud `3.1.1`, Spring Boot `2.6.6`, Dubbo `2.7.15`, Zookeeper `3.7.1`, JDK `1.8`, and Tomcat `9.0.48` for testing**

### 1 DataKit Configuration

#### 1.1 Modify http_api (Optional)

Edit the `/usr/local/datakit/conf.d/datakit.conf` file and set the `http_api` listen value to `0.0.0.0:9529` to ensure other hosts can access this host's `9529` port.<br/>
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

Parameter explanations:

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

### 3 Trace Observability

Access `http://192.168.0.100:8080/consumer/ping` in a browser, where the IP address is the host's address.<br/>
Log in to 「[Guance](https://console.guance.com/)」-「APM」, and you will see the `tomcat-customer` and `tomcat-provider` services.<br/>
Click on a trace to view flame graphs, span lists, and call relationships.

![image](../images/springboot-tomcat-3.png)

![image](../images/springboot-tomcat-4.png)