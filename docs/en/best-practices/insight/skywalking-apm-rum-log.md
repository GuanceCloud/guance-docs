# Based on <<< custom_key.brand_name >>>, Implementing RUM, APM, and Log Correlation Analysis with SkyWalking

---

## Use Cases

In a distributed application environment, issues are often diagnosed using logs and traces. <<< custom_key.brand_name >>> enables user requests made through the web interface to be associated with backend APIs via `traceId`. If the backend API outputs logs, these logs can be correlated with traces using the `traceId`, ultimately forming **RUM, APM, and log correlation**. By leveraging the **<<< custom_key.brand_name >>>** platform for comprehensive analysis, it becomes very convenient and quick to identify and pinpoint issues.

This article uses a simple and easy-to-follow open-source project as an example, step by step implementing full-stack observability.

## Prerequisites

- You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/).
- Spring Boot and Vue applications.
- A Linux server with Nginx installed.

## Procedure

???+ warning

    The version information used in this example is as follows: DataKit `1.4.15`, SkyWalking `8.7.0`, Nginx `1.20.2`, JDK `1.8`, Vue `3.2`

### 1 Deploy DataKit

#### 1.1 Install DataKit

Log in to the «[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)», sequentially enter «Integration» - «DataKit» - «Linux», and click «Copy Icon» to copy the installation command.

![image](../images/skywalking-apm-rum-log/1.png)

Log in to the Linux server and execute the copied command.

![image](../images/skywalking-apm-rum-log/2.png)

#### 1.2 Enable Collectors

To enable RUM, you need to allow remote access to DataKit’s port 9529. Edit the following file:

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

Edit the `skywalking-service-log.conf` file

- Set `logfiles` to the path of the log files. Since the jar will be deployed to `/usr/local/df-demo/skywalking`, the log path here is `/usr/local/df-demo/skywalking/logs/log.log`
- Set `source` to `skywalking-service-log`

![image](../images/skywalking-apm-rum-log/4.png)

#### 1.3 Restart DataKit

```shell
systemctl restart datakit
```

### 2 Deploy Application

#### 2.1 Deploy Backend Service

Download the [skywalking-demo](https://github.com/stevenliu2020/skywalking-demo) project, open it with Idea, and click «package» on the right to generate the `skywalking-user-service.jar` file.

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

> 2. Output logs, including `traceId`.
![image](../images/skywalking-apm-rum-log/7.png)


#### 2.2 Deploy Web

Enter the web project directory and run `cnpm install` in the command line.

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

Reload the Nginx configuration.

```shell
nginx -s reload
```

Enter the Linux service IP in the browser to access the frontend interface.

![image](../images/skywalking-apm-rum-log/13.png)

### 3 Enable APM

Download [SkyWalking](https://archive.apache.org/dist/skywalking/8.7.0/)

Upload the agent directory to the `/usr/local/df-demo/skywalking` directory on the Linux server.

![image](../images/skywalking-apm-rum-log/14.png)

![image](../images/skywalking-apm-rum-log/15.png)

If your microservice uses Spring Cloud Gateway, you must copy the `apm-spring-cloud-gateway-2.1.x-plugin-8.7.0.jar` and `apm-spring-webflux-5.x-plugin-8.7.0.jar` from the `agent/optional-plugins/` directory to the `skywalking-agent/plugins/` directory.

> **Note:** The version of `apm-spring-cloud-gateway` must match the specific version of the Spring Cloud Gateway you are using.

```shell
cp /usr/local/df-demo/skywalking/agent/optional-plugins/apm-spring-cloud-gateway-2.1.x-plugin-8.7.0.jar /usr/local/df-demo/skywalking/agent/plugins/
cp /usr/local/df-demo/skywalking/agent/optional-plugins/apm-spring-webflux-5.x-plugin-8.7.0.jar /usr/local/df-demo/skywalking/agent/plugins/
```

Run the following command to start the backend service and click the button on the frontend interface to call the backend service.

```shell
cd /usr/local/df-demo/skywalking
java  -javaagent:agent/skywalking-agent.jar -Dskywalking.agent.service_name=skywalking-log  -Dskywalking.collector.backend_service=localhost:11800 -jar skywalking-user-service.jar
```

Log in to «[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)», enter «Application Performance Monitoring», and view services, traces, and topology maps.

![image](../images/skywalking-apm-rum-log/16.png)

### 4 Enable RUM

Log in to «[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)», enter «User Access Monitoring», create a new application named **skywalking-web-demo**, and copy the JS code below.

![image](../images/skywalking-apm-rum-log/17.png)

Modify `/usr/local/web/index.html` and paste the JS code into the `<head>` section.

- Change `datakitOrigin` to the address of DataKit, which is the Linux IP address plus port 9529.
- Set `allowedTracingOrigins` to the backend API address, which is the Linux IP address plus port 8090.

![image](../images/skywalking-apm-rum-log/18.png)

Parameter Description

- `datakitOrigin`: Data transmission address, which is the domain name or IP of DataKit, required.
- `env`: Environment to which the application belongs, required.
- `version`: Version to which the application belongs, required.
- `trackInteractions`: Whether to enable user interaction tracking, such as clicking buttons or submitting information, required.
- `traceType`: Type of trace, defaults to `ddtrace`, optional.
- `allowedTracingOrigins`: To achieve correlation between APM and RUM traces, fill in the domain name or IP of the backend service, optional.

Click the button on the frontend interface. Log in to «[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)» - «User Access Monitoring», click on «skywalking-web-demo», and view UV, PV, session count, visited pages, etc.

![image](../images/skywalking-apm-rum-log/19.png)

![image](../images/skywalking-apm-rum-log/20.png)

### 5 Full-Stack Observability

Log in to «[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)» - «User Access Monitoring», click on «skywalking-web-demo», then click «Explorer», select «View», view page calls, and then click «route_change».

![image](../images/skywalking-apm-rum-log/21.png)

Select «Trace»

![image](../images/skywalking-apm-rum-log/22.png)

Click on a request record to observe the "Flame Graph", "Span List", "Service Call Relationships", and logs generated by this trace.

![image](../images/skywalking-apm-rum-log/23.png)