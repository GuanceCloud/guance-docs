# Spring Boot 项目外置 Tomcat 场景链路可观测

---

## 简介

不同的企业在使用 Java 生态圈构建自己的企业级框架时，用到的技术栈不一定相同。就拿微服务框架来说，有的企业使用 Spring Boot + Spring Cloud，有的企业使用 Spring Boot + Dubbo。<br/>
观测云支持不同的 APM 工具，把微服务链路接入到观测云，您可以根据需要选择适合自己的 APM 工具。

通常构建出的微服务都是以 Jar 的方式运行，本文重点阐述把这些微服务构建成 war 包并部署在 Tomcat 下，如何把链路数据接入到观测云。如果是传统的 war 包项目，接入方式相同。

## SkyWalking 场景

### 前置条件

- 云主机(Centos 7.9)
- 安装 JDK
- 安装 Zookeeper
- 观测云账号
- Tomcat 部署两个，部署路径 `/usr/local/df-demo/tomcat8080` 和 `/usr/local/df-demo/tomcat8081`
- 云主机已 <[安装 DataKit](../../datakit/datakit-install.md)>

### 操作步骤

???+ warning

    **当前案例使用 DataKit 版本`1.4.9`，Spring Cloud `3.1.1`，Spring Boot `2.6.6`，Dubbo `2.7.15` ，Zookeeper `3.7.1` ，JDK `1.8` ，Tomcat `9.0.48` 进行测试**

### 1 DataKit 配置

#### 1.1 修改 http_api(非必选)

编辑 `/usr/local/datakit/conf.d/datakit.conf` 文件，修改 `http_api` 的 listen 的值是 `0.0.0.0:9529`，确保其它主机可以正常访问这台主机的 `9529` 端口。<br/>
如果不想通过其它主机访问 DataKit，可不修改。

![image](../images/springboot-tomcat-1.png)

#### 1.2 开启 SkyWaking 采集器

登录主机，复制 sample 文件，开通 skywalking 采集器。

```bash
cd /usr/local/datakit/conf.d/skywalking
cp skywalking.conf.sample skywalking.conf
```

重启 DataKit。

```bash
systemctl restart datakit
```

### 2 APM 接入

##### 2.1 下载 SkyWalking

下载 [apache-skywalking-java-agent-8.11.0](https://www.apache.org/dyn/closer.cgi/skywalking/java-agent/8.11.0/apache-skywalking-java-agent-8.11.0.tgz)，解压后把文件命名为 `agent`，上传到主机的 `/usr/local/df-demo/tomcat8080` 和 `/usr/local/df-demo/tomcat8081` 目录。

##### 2.2 配置 Tomcat

修改 `/usr/local/df-demo/tomcat8080/bin/catalina.sh` 文件，增加如下内容：

```bash
export  CATALINA_OPTS="$CATALINA_OPTS -javaagent:/usr/local/df-demo/tomcat8080/agent/skywalking-agent.jar  -Dskywalking.agent.service_name=tomcat-customer  -Dskywalking.collector.backend_service=localhost:11800"
```

![image](../images/springboot-tomcat-2.png)

参数说明：

- -Dskywalking.agent.service_name：服务名称
- -Dskywalking.collector.backend_service：链路上报的 DataKit 地址 + Skywalking 采集器端口

修改 `/usr/local/df-demo/tomcat8081/bin/catalina.sh` 文件，增加如下内容：

```bash
export  CATALINA_OPTS="$CATALINA_OPTS -javaagent:/usr/local/df-demo/tomcat8081/agent/skywalking-agent.jar  -Dskywalking.agent.service_name=tomcat-provider  -Dskywalking.collector.backend_service=localhost:11800"
```

启动 Tomcat。

```bash
 cd /usr/local/df-demo/tomcat8080/bin
 ./startup.sh
 cd /usr/local/df-demo/tomcat8081/bin
 ./startup.sh
```

##### 2.3 部署项目

[下载](https://github.com/stevenliu2020/springboot-tomcat) war 包，获取 skywalking 目录下的 `consumer.war` 和 `provider.war`

- 把 `provider.war` 放到 `/usr/local/df-demo/tomcat8081/webapps` 目录
- 把 `consumer.war` 放到 `/usr/local/df-demo/tomcat8080/webapps` 目录

### 3 链路可观测

浏览器访问 `http://192.168.0.100:8080/consumer/ping` ，这里的 IP 是主机的地址。<br/>
登录 「[观测云](https://console.guance.com/)」-「应用性能监测」，可看到 `tomcat-customer` 和 `tomcat-provider` 服务。<br/>
点击一个链路进去，可以查看火焰图、span 列表、调用关系等。

![image](../images/springboot-tomcat-3.png)

![image](../images/springboot-tomcat-4.png)
