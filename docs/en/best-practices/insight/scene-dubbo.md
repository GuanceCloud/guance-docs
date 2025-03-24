# Intranet Scenario for Dubbo Microservices Integration with <<< custom_key.brand_name >>>

---

> _Author: Liu Yu Jie_

## Introduction

Some projects have user groups consisting of internal company personnel or group company personnel. For security reasons, these projects are deployed in self-built data centers, and employees access them via the intranet or a VPN. For such scenarios, **<<< custom_key.brand_name >>> provides an offline deployment solution**, meaning deploying DataKit on a host that can connect to the external network, enabling the Proxy collector. Hosts within the intranet install DataKit through this proxy, and all data is reported to <<< custom_key.brand_name >>> via this deployed DataKit.

Below, we will use a microservice architecture project to introduce how to integrate <<< custom_key.brand_name >>>. The project is a front-end and back-end separated one, with the front-end developed using Vue, and the back-end microservices developed using Spring Boot combined with Dubbo. The front-end accesses the back-end services through a Gateway. Users access the front-end website via a browser; clicking a button on the interface triggers a request to the back-end interface, which is forwarded by the Gateway to the Consumer microservice. During processing, the Consumer microservice calls the Provider microservice and records logs. After completing the process, it returns the results to the browser, thus completing one call.

![image](../images/dubbo/01.png)

## Deployment Planning

The entire example project consists of four services, each deployed on four hosts, with an additional host that can connect to the external network. This host is also on the same intranet as the other four hosts.

- First, deploy DataKit on the host with external network access, enabling the Proxy collector;
- Second, install DataKit on the other four hosts through this proxy;
- Third, deploy the Web project on the Web server where Nginx is installed. The 9529 port of this Web host can be accessed by other hosts within the intranet;
- Finally, deploy the Gateway, Consumer, and Provider microservices, and enable the SkyWalking collector.

The services used in the example can be downloaded from [https://github.com/stevenliu2020/vue3-dubbo](https://github.com/stevenliu2020/vue3-dubbo), which includes `provider.jar`, `consumer.jar`, `gateway.jar`, and the `dist` directory (the Vue project). Below is the correspondence between the project and the hosts, as well as the overall deployment architecture diagram.

- Correspondence between projects and hosts

| IP           | Deployed Project          | Description                    |
| ------------ | ------------------------- | ----------------------------- |
| 172.16.0.245 | DataKit (Proxy)         | Can connect to the external network |
| 172.16.0.29  | Web/DataKit             | Intranet, Web server (Nginx) |
| 172.16.0.51  | Gateway/DataKit         | Intranet, gateway service deployment |
| 172.16.0.52  | Consumer/DataKit        | Intranet, consumer service deployment |
| 172.16.0.53  | Provider/DataKit       | Intranet, producer service deployment |

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

Log in to 「[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)」, enter the 「Integration」 module, click 「DataKit」 - 「Linux」, copy the installation command, and execute it on the host 172.16.0.245. Note that the installation command includes a token, which will be used in subsequent operations.

![image](../images/dubbo/03.png)

After installation, execute the following commands to enable the Proxy collector.

```shell
cd /usr/local/datakit/conf.d/proxy
cp proxy.conf.sample proxy.conf
```

Edit the `/usr/local/datakit/conf.d/datakit.conf` file, modify the value of `http_api`'s listen to `0.0.0.0:9529`, ensuring that other hosts can normally access port 9529 on this host.

![image](../images/dubbo/04.png)

Restart DataKit.

```shell
systemctl restart datakit
```

#### 1.2 Deploy DataKit Through Proxy

Log in to the `172.16.0.29` host and execute the following command to install DataKit.

Here `172.16.0.245` is the IP address of the host where DataKit was installed in the previous step. This step involves installing DataKit through the DataKit proxy, and the token used in the command is the same as the one mentioned above.

```shell
export HTTPS_PROXY=http://172.16.0.245:9530; DK_DATAWAY=https://openway.<<< custom_key.brand_main_domain >>>?token=tkn_9a1111123412341234123412341113bb bash -c "$(curl -L https://static.<<< custom_key.brand_main_domain >>>/datakit/install.sh)"
```

Execute the following command to test whether data can be reported to <<< custom_key.brand_name >>>.

```shell
curl -x http://172.16.0.245:9530 -v -X POST https://openway.<<< custom_key.brand_main_domain >>>/v1/write/metrics?token=tkn_9a1111123412341234123412341113bb -d "proxy_test,name=test c=123i"
```

A return code of 200 indicates successful data reporting.

![image](../images/dubbo/05.png)

Use the same steps to deploy DataKit on the `172.16.0.51`, `172.16.0.52`, and `172.16.0.53` hosts. At this point, DataKit has been deployed on all four hosts.

### 2 APM Integration

#### 2.1 Enable SkyWalking Collector

Log in to the `172.16.0.51` host, copy the sample file, and enable the skywalking collector.

```shell
cd /usr/local/datakit/conf.d/skywalking
cp skywalking.conf.sample skywalking.conf
```

Restart DataKit.

```shell
systemctl restart datakit
```

Use the same operation to enable the SkyWalking collectors for DataKit deployed on the `172.16.0.52` and `172.16.0.53` hosts.

#### 2.2 Upload SkyWalking Probe

There are many APM tools available on the market. Since the microservices use the Dubbo framework, SkyWalking is recommended here.

Download [apache-skywalking-java-agent-8.11.0](https://www.apache.org/dyn/closer.cgi/skywalking/java-agent/8.11.0/apache-skywalking-java-agent-8.11.0.tgz), extract it, rename the files as `agent`, and upload them to the `/usr/local/df-demo/` directories on the `172.16.0.51`, `172.16.0.52`, and `172.16.0.53` hosts.

> **Note:** On the `172.16.0.51` host where the gateway is deployed, copy the `apm-spring-cloud-gateway-3.x-plugin-8.11.0.jar` and `apm-spring-webflux-5.x-plugin-8.11.0.jar` packages from the `agent\optional-plugins` directory to the `agent\plugins` directory.

![image](../images/dubbo/06.png)

#### 2.3 Deploy Provider Microservice

Upload `provider.jar` to the `/usr/local/df-demo/` directory on the `172.16.0.53` host, ensuring that `provider.jar` is in the same directory as the agent folder. Start the provider service.

```shell
cd /usr/local/df-demo/
java -javaagent:agent/skywalking-agent.jar -Dskywalking.agent.service_name=dubbo-provider -Dskywalking.collector.backend_service=localhost:11800 -jar provider.jar
```

#### 2.4 Deploy Consumer Microservice

Upload `consumer.jar` to the `/usr/local/df-demo/` directory on the `172.16.0.52` host. Start the consumer service.

```shell
cd /usr/local/df-demo/
java -javaagent:agent/skywalking-agent.jar -Dskywalking.agent.service_name=dubbo-consumer -Dskywalking.collector.backend_service=localhost:11800 -jar consumer.jar
```

#### 2.5 Deploy Gateway Microservice

Upload `gateway.jar` to the `/usr/local/df-demo/` directory on the `172.16.0.51` host. Start the gateway service.

```shell
cd /usr/local/df-demo/
java -javaagent:agent/skywalking-agent.jar -Dskywalking.agent.service_name=dubbo-gateway -Dskywalking.collector.backend_service=localhost:11800 -jar gateway.jar
```

### 3 RUM Integration

Upload the `dist` directory to the `/usr/local/df-demo/` directory on the `172.16.0.29` host. The URL for the front-end connection to the back-end interface is inside the `dist\js\app.ec288764.js` file, where the URL for the back-end gateway is [http://172.16.0.51:9000/api](http://172.16.0.51:9000/api).

Log in to 「[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)」, enter the 「User Analysis」 module, create a new dubbo-web application, and copy the command below.

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

Access the front-end interface via a browser at [http://172.16.0.29/](http://172.16.0.29/). Clicking buttons on the interface will trigger back-end interface calls.

Log in to 「[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)」, enter 「User Analysis」 - 「dubbo-web」, where various features can be used for performance analysis of the front-end application.

![image](../images/dubbo/09.png)

### 4 LOG Integration

Using SkyWalking's `apm-toolkit-log4j-2.x` package, the traceId generated by SkyWalking can be output via log4j2 into logs.

DataKit's pipeline can extract the traceId from the logs and associate it with the chain.

#### 4.1 Add Dependencies

To output the traceId in the logs of the provider microservice, you need to add dependencies in the `pom.xml` file of the provider. Use the same version as the javaagent, which is 8.11.0 here.

```xml
<dependency>
    <groupId>org.apache.skywalking</groupId>
    <artifactId>apm-toolkit-log4j-2.x</artifactId>
    <version>8.11.0</version>
</dependency>
```

#### 4.2 Enable Log Collector

Log in to the server where the Provider service is deployed (`172.16.0.53`) and copy the sample file.

```shell
cd /usr/local/datakit/conf.d/log
cp logging.conf.sample logging.conf
```

Edit the `logging.conf` file. Input `log-dubbo-provider` as the source name, which will be used in log queries or pipeline configurations. Fill in the path to the log files under `logfiles`.

![image](../images/dubbo/10.png)

Restart DataKit.

```shell
systemctl restart datakit
```

#### 4.3 Pipeline

Log in to 「[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)」, enter 「LOGS」 - 「Pipelines」.<br/>
Click 「Create Pipeline」, filter and select the source defined by enabling the log collector, i.e., `log-dubbo-provider`. Define the parsing rules as shown below, then click 「Save」.

```toml
# 2022-08-03 10:55:50.818 [DubboServerHandler-172.16.0.29:20880-thread-2] INFO dubbo.service.StockAPIService - [decreaseStorage,21] - [TID: 1bc41dfa-3c2c-4917-9da7-0f48b4bcf4b7] - User ID：-4972683369271453960 ，initiating process approval：-1133938638

grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] - \\[TID: %{DATA:trace_id}\\] - %{GREEDYDATA:msg}")
default_time(time)
```

![image](../images/dubbo/11.png)

Trigger a call to the provider service from the front-end so that the logs generated by the provider are collected by DataKit and reported to <<< custom_key.brand_name >>>.

Log in to 「[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)」, enter the viewer in the 「LOGS」 module. Find the data source `log-dubbo-provider`, click on a log entry, and you will see that the traceId is already tagged. You can later use this traceId in APM to link to the logs, helping us quickly locate issues.

![image](../images/dubbo/12.png)

### 5 Linked Analysis

Through the steps above, the integration of Rum, Apm, and logs has been completed.

Log in to 「[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)」 - 「User Analysis」, click 「dubbo-web」, then click 「Viewer」, choose 「View」 to check the page invocation situation.<br/>
Then click 「route_change」 to enter, and in the Fetch/XHR tab, you can view the status of interface invocations triggered by the front-end. Clicking on one will allow you to view flame graphs, span lists, service invocation relationships, and associated logs of the provider service.

![image](../images/dubbo/13.png)

![image](../images/dubbo/14.png)