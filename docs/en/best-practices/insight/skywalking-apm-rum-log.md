# Based on <<< custom_key.brand_name >>>, Achieving RUM, APM, and Log Correlation Analysis with SkyWalking

---

## Use Cases

In a distributed application environment, issues are often diagnosed through logs and traces. <<< custom_key.brand_name >>> enables users to associate requests made via the Web interface with backend interfaces using traceId. If the backend interface outputs logs, the traceId links the trace and the log together, ultimately forming **RUM, APM, and log correlation**. Utilizing the **<<< custom_key.brand_name >>>** platform for comprehensive analysis allows for convenient and quick identification and localization of problems.

This article uses an easy-to-follow open-source project as an example to achieve full-chain observability step by step.

## Prerequisites

- You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/).
- Spring Boot and Vue applications.
- A Linux server with Nginx installed.

## Steps

???+ warning

    The version information used in this example is as follows: DataKit `1.4.15`, SkyWalking `8.7.0`, Nginx `1.20.2`, JDK `1.8`, Vue `3.2`

### 1 Deploy DataKit

#### 1.1 Install DataKit

Log in to «[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)», navigate sequentially to «Integration» - «DataKit» - «Linux», and click «Copy Icon» to copy the installation command.

![image](../images/skywalking-apm-rum-log/1.png)

Log in to the Linux server and execute the copied command.

![image](../images/skywalking-apm-rum-log/2.png)

#### 1.2 Enable Collector

To enable RUM, allow remote access to port 9529 of DataKit by editing the following file.

```shell
vi /usr/local/datakit/conf.d/datakit.conf
```

Change the listen value to `0.0.0.0:9529` 

![image](../images/skywalking-apm-rum-log/3.png)

Copy the conf file to enable the SkyWalking collector.

```shell
cd /usr/local/datakit/conf.d/skywalking
cp skywalking.conf.sample skywalking.conf
```

Enable the log collector.

```shell
cd /usr/local/datakit/conf.d/log
cp logging.conf.sample skywalking-service-log.conf
```

Edit the `skywalking-service-log.conf` file.

- Set logfiles to the log file path; since the jar will be deployed to `/usr/local/df-demo/skywalking`, the log path here is `/usr/local/df-demo/skywalking/logs/log.log`
- Source should be `skywalking-service-log`

![image](../images/skywalking-apm-rum-log/4.png)

#### 1.3 Restart DataKit

```shell
systemctl restart datakit
```

### 2 Deploy Application

#### 2.1 Deploy Backend Service

Download the [skywalking-demo ](https://github.com/stevenliu2020/skywalking-demo) project, open it with Idea, and click «package» to generate the `skywalking-user-service.jar` file.

![image](../images/skywalking-apm-rum-log/5.png)

Upload `skywalking-user-service.jar` to the `/usr/local/df-demo/skywalking` directory.

![image](../images/skywalking-apm-rum-log/6.png)

> **Note:**<br/>
> 1. Add dependencies to the project<br/>

    ```xml
            <dependency>
                <groupId>org.apache.skywalking</groupId>
                <artifactId>apm-toolkit-logback-1.x</artifactId>
                <version>8.7.0</version>
            </dependency>
    ```

> 2. Output logs, ensuring that the traceId is included.
![image](../images/skywalking-apm-rum-log/7.png)


#### 2.2 Deploy Web

Navigate to the web project directory and run `cnpm install` from the command line.

![image](../images/skywalking-apm-rum-log/8.png)

Run `npm run build` to generate deployment files.

![image](../images/skywalking-apm-rum-log/9.png)

Copy the files under the disk directory to the `/usr/local/web` directory on the server.

![image](../images/skywalking-apm-rum-log/10.png)

![image](../images/skywalking-apm-rum-log/11.png)

Edit the `/etc/nginx/nginx.conf` file and add the following content.

```toml
   location / {
            root   /usr/local/web;
            try_files $uri $uri/ /index.html;
            index  index.html index.htm;

        }

```

![image](../images/skywalking-apm-rum-log/12.png)

Reload the nginx configuration.

```shell
nginx -s reload
```

Input the Linux service IP in the browser to access the frontend interface.

![image](../images/skywalking-apm-rum-log/13.png)

### 3 Enable APM

Download [SkyWalking](https://archive.apache.org/dist/skywalking/8.7.0/)

Upload the agent directory to the `/usr/local/df-demo/skywalking` directory on Linux.

![image](../images/skywalking-apm-rum-log/14.png)

![image](../images/skywalking-apm-rum-log/15.png)

If the microservice uses springcloud gateway, you must copy `agent/optional-plugins/`'s `apm-spring-cloud-gateway-2.1.x-plugin-8.7.0.jar` and `apm-spring-webflux-5.x-plugin-8.7.0.jar` to the `skywalking-agent/plugins/` directory.

> **Note:** The version of apm-spring-cloud-gateway must correspond to the specific version of the springcloud gateway being used.

```shell
cp /usr/local/df-demo/skywalking/agent/optional-plugins/apm-spring-cloud-gateway-2.1.x-plugin-8.7.0.jar /usr/local/df-demo/skywalking/agent/plugins/
cp /usr/local/df-demo/skywalking/agent/optional-plugins/apm-spring-webflux-5.x-plugin-8.7.0.jar /usr/local/df-demo/skywalking/agent/plugins/
```

Execute the following command to start the backend service, click the button on the frontend interface to call the backend service.

```shell
cd /usr/local/df-demo/skywalking
java  -javaagent:agent/skywalking-agent.jar -Dskywalking.agent.service_name=skywalking-log  -Dskywalking.collector.backend_service=localhost:11800 -jar skywalking-user-service.jar
```

Log in to «[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)», navigate to «Application Performance Monitoring», and check the services, traces, and topology diagram.

![image](../images/skywalking-apm-rum-log/16.png)

### 4 Enable RUM

Log in to «[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)», navigate to «User Access Monitoring», create a new application named **skywalking-web-demo**, and copy the JS code below.

![image](../images/skywalking-apm-rum-log/17.png)

Modify `/usr/local/web/index.html` and paste the JS into the head section.

- Change datakitOrigin to the address of DataKit, which is the Linux IP address plus port 9529
- allowedTracingOrigins is the address of the backend interface, which is the Linux IP address plus port 8090

![image](../images/skywalking-apm-rum-log/18.png)

Parameter descriptions:

- datakitOrigin: Data transmission address, which is the domain name or IP of datakit, required.
- env: Application's environment, required.
- version: Application's version, required.
- trackInteractions: Whether to enable user behavior statistics, such as clicking buttons, submitting information, etc., required.
- traceType: Trace type, default is ddtrace, optional.
- allowedTracingOrigins: To connect APM and RUM chains, fill in the domain name or IP of the backend service, optional.

Click the button on the frontend interface. Log in to «[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)» - «User Access Monitoring», click «skywalking-web-demo», and view UV, PV, session count, visited pages, and other information.

![image](../images/skywalking-apm-rum-log/19.png)

![image](../images/skywalking-apm-rum-log/20.png)

### 5 Full Chain Observability

Log in to «[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)» - «User Access Monitoring», click «skywalking-web-demo», then enter and click «Explorer», select «View», and check the page invocation situation. Then click «route_change» to proceed.

![image](../images/skywalking-apm-rum-log/21.png)

Select «Service Map»

![image](../images/skywalking-apm-rum-log/22.png)

Click on a request record, where you can observe the "Flame Graph", "Span List", "Service Call Relationship", and the logs generated by this chain invocation.

![image](../images/skywalking-apm-rum-log/23.png)