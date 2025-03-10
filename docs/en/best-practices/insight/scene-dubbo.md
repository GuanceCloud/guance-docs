# Internal Network Scenario for Dubbo Microservices Integration with <<< custom_key.brand_name >>>

---

> _Author: Liu Yuje_

## Introduction

Some projects target internal company employees or personnel within a corporate group. For security reasons, these projects are deployed in self-built data centers, and employees access them via the intranet or VPN. For this scenario, **<<< custom_key.brand_name >>> provides an offline deployment solution**, which involves deploying DataKit on a host that can connect to the internet and enabling the Proxy collector. The internal network hosts install DataKit through this proxy, and all data is reported to <<< custom_key.brand_name >>> via the DataKit deployed on this host.

The following describes how to integrate a microservices architecture project into <<< custom_key.brand_name >>>. This project is a front-end and back-end separated application, with the front-end developed using Vue and the back-end microservices using Spring Boot combined with Dubbo. The front-end accesses the back-end services through a Gateway. Users visit the front-end website via a browser, and clicking buttons on the interface triggers backend API requests. These requests are forwarded by the Gateway to the Consumer microservice, which processes the request and calls the Provider microservice during processing. After completing the process, it returns the result to the browser, thus completing one call.

![image](../images/dubbo/01.png)

## Deployment Planning

The entire example project consists of four services deployed on four hosts, plus one host that can connect to the internet, which is also on the same internal network as the other four hosts.

- First, deploy DataKit on the host with internet access and enable the Proxy collector.
- Second, install DataKit on the other four hosts through this proxy.
- Third, deploy the Web project on a Web server with Nginx installed, ensuring that port 9529 on this Web host can be accessed by other hosts within the internal network.
- Finally, deploy the Gateway, Consumer, and Provider microservices and enable the SkyWalking collector.

The services used in the example can be downloaded from [https://github.com/stevenliu2020/vue3-dubbo](https://github.com/stevenliu2020/vue3-dubbo), which includes `provider.jar`, `consumer.jar`, `gateway.jar`, and the `dist` directory for the Vue project. Below is the mapping between the project and the hosts and the overall deployment architecture diagram.

- Project-to-host mapping

| IP           | Deployed Projects       | Description                 |
| ------------ | ----------------------- | --------------------------- |
| 172.16.0.245 | DataKit (Proxy)         | Can connect to the internet |
| 172.16.0.29  | Web/DataKit             | Intranet, Web server (Nginx)|
| 172.16.0.51  | Gateway/DataKit         | Intranet, gateway service   |
| 172.16.0.52  | Consumer/DataKit        | Intranet, consumer service  |
| 172.16.0.53  | Provider/DataKit        | Intranet, producer service  |

- Overall deployment architecture diagram

![image](../images/dubbo/02.png)

## Prerequisites

- Centos 7.9
- Install Nginx
- Install JDK
- Install Zookeeper
- <<< custom_key.brand_name >>> account

## Environment Versions

???+ warning

    The versions used in this example are as follows: DataKit `1.4.9`, Nginx `1.22.0`, Spring Cloud `3.1.1`, Spring Boot `2.6.6`, Dubbo `2.7.15`, Zookeeper `3.7.1`, Vue `3.2`, JDK `1.8`

## Operation Steps

### 1 Deploy DataKit

#### 1.1 Online Deployment of DataKit

Log in to the 「[<<< custom_key.brand_name >>>](https://console.guance.com/)」 console, go to the 「Integration」 module, click 「DataKit」 - 「Linux」, copy the installation command, and execute it on the host `172.16.0.245`. Note that the installation command contains a token, which will be used in subsequent operations.

![image](../images/dubbo/03.png)

After installation, execute the following commands to enable the Proxy collector.

```shell
cd /usr/local/datakit/conf.d/proxy
cp proxy.conf.sample proxy.conf
```

Edit the `/usr/local/datakit/conf.d/datakit.conf` file, change the `http_api` listen value to `0.0.0.0:9529` to ensure other hosts can access port 9529 on this host.

![image](../images/dubbo/04.png)

Restart DataKit.

```shell
systemctl restart datakit
```

#### 1.2 Deploy DataKit via Proxy

Log in to the host `172.16.0.29` and execute the following command to install DataKit.

Here, `172.16.0.245` is the IP address of the host where DataKit was installed in the previous step. This step installs DataKit via the DataKit proxy, using the same token mentioned earlier.

```shell
export HTTPS_PROXY=http://172.16.0.245:9530; DK_DATAWAY=https://openway.guance.com?token=tkn_9a1111123412341234123412341113bb bash -c "$(curl -L https://static.<<< custom_key.brand_main_domain >>>/datakit/install.sh)"
```

Execute the following command to test whether data can be reported to <<< custom_key.brand_name >>>.

```shell
curl -x http://172.16.0.245:9530 -v -X POST https://openway.guance.com/v1/write/metrics?token=tkn_9a1111123412341234123412341113bb -d "proxy_test,name=test c=123i"
```

A return code of 200 indicates successful data reporting.

![image](../images/dubbo/05.png)

Use the same steps to deploy DataKit on the hosts `172.16.0.51`, `172.16.0.52`, and `172.16.0.53`. At this point, DataKit has been deployed on all four hosts.

### 2 APM Integration

#### 2.1 Enable SkyWalking Collector

Log in to the host `172.16.0.51`, copy the sample file, and enable the SkyWalking collector.

```shell
cd /usr/local/datakit/conf.d/skywalking
cp skywalking.conf.sample skywalking.conf
```

Restart DataKit.

```shell
systemctl restart datakit
```

Perform the same operation to enable the SkyWalking collector on the DataKit instances deployed on the hosts `172.16.0.52` and `172.16.0.53`.

#### 2.2 Upload SkyWalking Agent

There are many APM tools available on the market. Since the microservices use the Dubbo framework, we recommend using SkyWalking.

Download [apache-skywalking-java-agent-8.11.0](https://www.apache.org/dyn/closer.cgi/skywalking/java-agent/8.11.0/apache-skywalking-java-agent-8.11.0.tgz), extract the files, rename the folder to `agent`, and upload it to the `/usr/local/df-demo/` directory on the hosts `172.16.0.51`, `172.16.0.52`, and `172.16.0.53`.

> **Note:** On host `172.16.0.51`, which deploys the Gateway, copy the `apm-spring-cloud-gateway-3.x-plugin-8.11.0.jar` and `apm-spring-webflux-5.x-plugin-8.11.0.jar` from the `agent\optional-plugins` directory to the `agent\plugins` directory.

![image](../images/dubbo/06.png)

#### 2.3 Deploy Provider Microservice

Upload `provider.jar` to the `/usr/local/df-demo/` directory on the host `172.16.0.53`, ensuring that `provider.jar` is in the same directory as the agent folder. Start the provider service.

```shell
cd /usr/local/df-demo/
java -javaagent:agent/skywalking-agent.jar -Dskywalking.agent.service_name=dubbo-provider -Dskywalking.collector.backend_service=localhost:11800 -jar provider.jar
```

#### 2.4 Deploy Consumer Microservice

Upload `consumer.jar` to the `/usr/local/df-demo/` directory on the host `172.16.0.52`. Start the consumer service.

```shell
cd /usr/local/df-demo/
java -javaagent:agent/skywalking-agent.jar -Dskywalking.agent.service_name=dubbo-consumer -Dskywalking.collector.backend_service=localhost:11800 -jar consumer.jar
```

#### 2.5 Deploy Gateway Microservice

Upload `gateway.jar` to the `/usr/local/df-demo/` directory on the host `172.16.0.51`. Start the gateway service.

```shell
cd /usr/local/df-demo/
java -javaagent:agent/skywalking-agent.jar -Dskywalking.agent.service_name=dubbo-gateway -Dskywalking.collector.backend_service=localhost:11800 -jar gateway.jar
```

### 3 RUM Integration

Upload the `dist` directory to the `/usr/local/df-demo/` directory on the host `172.16.0.29`. The URL for connecting to the backend interface is in the `dist\js\app.ec288764.js` file, where the backend Gateway URL is [http://172.16.0.51:9000/api](http://172.16.0.51:9000/api).  
Log in to the 「[<<< custom_key.brand_name >>>](https://console.guance.com/)」 console, go to the 「User Access Monitoring」 module, create a new dubbo-web application, and copy the following command.

![image](../images/dubbo/07.png)

![image](../images/dubbo/08.png)

Modify the `/etc/nginx/nginx.conf` file and add the following content:

```toml
server {
        listen       80;
        #add_header Access-Control-Allow-Origin '*';
        #add_header Access-Control-Allow-Headers Origin,X-Requested-Width,Content-Type,Accept;

        location / {
            proxy_set_header   Host    $host:$server_port;
            proxy_set_header   X-Real-IP   $remote_addr;
            proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
            root   /usr/local/df-demo/dist;
            index  index.html index.htm;
        }
        #location /nginx_status{
        #        stub_status on;
        #}

    }

```

Reload the configuration.

```shell
 nginx -s reload
```

Access [http://172.16.0.29/](http://172.16.0.29/) in the browser to view the front-end interface. Clicking buttons on the interface will trigger backend API calls.

Log in to the 「[<<< custom_key.brand_name >>>](https://console.guance.com/)」 console, go to the 「User Access Monitoring」 - 「dubbo-web」 section, where various features can be used to analyze the performance of the front-end application.

![image](../images/dubbo/09.png)

### 4 Log Integration

Using the `apm-toolkit-log4j-2.x` package from SkyWalking, traceId generated by SkyWalking can be output to logs via log4j2.

DataKit's pipeline can extract traceId from logs and associate it with traces.

#### 4.1 Add Dependencies

To output traceId in the logs of the provider microservice, add dependencies to the `pom.xml` file of the provider, using the same version as the javaagent, which is 8.11.0 here.

```xml
<dependency>
    <groupId>org.apache.skywalking</groupId>
    <artifactId>apm-toolkit-log4j-2.x</artifactId>
    <version>8.11.0</version>
</dependency>
```

#### 4.2 Enable Log Collector

Log in to the server hosting the Provider service at `172.16.0.53` and copy the sample file.

```shell
cd /usr/local/datakit/conf.d/log
cp logging.conf.sample logging.conf
```

Edit the `logging.conf` file, set the source to `log-dubbo-provider`, which will be used in log queries or pipeline configurations. Set the logfiles path to the log files you want to collect.

![image](../images/dubbo/10.png)

Restart DataKit.

```shell
systemctl restart datakit
```

#### 4.3 Pipeline Configuration

Log in to the 「[<<< custom_key.brand_name >>>](https://console.guance.com/)」 console, go to the 「Logs」 - 「Pipelines」 section.<br/>
Click 「Create Pipeline」, filter and select the source defined by the log collector, i.e., `log-dubbo-provider`.<br/>
Define the parsing rules with the following content and click 「Save」.

```toml
# 2022-08-03 10:55:50.818 [DubboServerHandler-172.16.0.29:20880-thread-2] INFO dubbo.service.StockAPIService - [decreaseStorage,21] - [TID: 1bc41dfa-3c2c-4917-9da7-0f48b4bcf4b7] - 用户ID：-4972683369271453960 ，发起流程审批：-1133938638

grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] - \\[TID: %{DATA:trace_id}\\] - %{GREEDYDATA:msg}")
default_time(time)
```

![image](../images/dubbo/11.png)

Trigger a call to the provider service using the front-end, so that the logs generated by the provider service are collected by DataKit and reported to <<< custom_key.brand_name >>>.

Log in to the 「[<<< custom_key.brand_name >>>](https://console.guance.com/)」 console, go to the 「Logs」 module's Explorer, find the data source `log-dubbo-provider`, click on a log entry, and you can see that the traceId is added as a tag. Later, you can use this traceId in APM to correlate with logs, helping you quickly identify issues.

![image](../images/dubbo/12.png)

### 5 Linked Analysis

Through the above steps, RUM, APM, and logs have been integrated.

Log in to 「[<<< custom_key.brand_name >>>](https://console.guance.com/)」 - 「User Access Monitoring」, click 「dubbo-web」, enter the Explorer, select 「View」 to check page call situations.<br/>
Then click 「route_change」, and under the Fetch/XHR tab, you can view the interface call situations triggered by the front-end. Clicking on an entry allows you to view flame graphs, span lists, service call relationships, and associated logs from the provider service.

![image](../images/dubbo/13.png)

![image](../images/dubbo/14.png)