# Based on Guance, Implementing RUM, APM, and Log Correlation Analysis with SkyWalking

---

## Application Scenarios

In a distributed application environment, issues are often diagnosed through logs and traces. Guance can correlate requests made by users through the web interface with backend APIs via traceId. If the backend API outputs logs, these logs can be correlated with traces using traceId, ultimately forming a **correlation between RUM, APM, and logs**. Comprehensive analysis on the **Guance** platform can conveniently and quickly identify and locate problems.

This article uses an easy-to-follow open-source project to demonstrate step-by-step how to achieve full-stack observability.

## Prerequisites

- You need to create a [Guance account](https://www.guance.com/) first.
- Spring Boot and Vue applications.
- A Linux server with Nginx deployed.

## Procedure

???+ warning

    The version information used in this example is as follows: DataKit `1.4.15`, SkyWalking `8.7.0`, Nginx `1.20.2`, JDK `1.8`, Vue `3.2`

### 1 Deploy DataKit

#### 1.1 Install DataKit

Log in to the「[Guance](https://console.guance.com/)」platform, sequentially navigate to「Integration」 - 「DataKit」 - 「Linux」, and click「Copy Icon」to copy the installation command.

![image](../images/skywalking-apm-rum-log/1.png)

Log in to the Linux server and execute the copied command.

![image](../images/skywalking-apm-rum-log/2.png)

#### 1.2 Enable Collectors

To enable RUM, you need to allow remote access to DataKit's port 9529. Edit the following file:

```shell
vi /usr/local/datakit/conf.d/datakit.conf
```

Set the `listen` value to `0.0.0.0:9529`.

![image](../images/skywalking-apm-rum-log/3.png)

Copy the configuration file to enable the SkyWalking collector.

```shell
cd /usr/local/datakit/conf.d/skywalking
cp skywalking.conf.sample skywalking.conf
```

Enable the log collector.

```shell
cd /usr/local/datakit/conf.d/log
cp logging.conf.sample skywalking-service-log.conf
```

Edit the `skywalking-service-log.conf` file:

- Set `logfiles` to the log file path. Since the jar will be deployed to `/usr/local/df-demo/skywalking`, set the log path to `/usr/local/df-demo/skywalking/logs/log.log`.
- Set `source` to `skywalking-service-log`.

![image](../images/skywalking-apm-rum-log/4.png)

#### 1.3 Restart DataKit

```shell
systemctl restart datakit
```

### 2 Deploy Applications

#### 2.1 Deploy Backend Service

Download the [skywalking-demo](https://github.com/stevenliu2020/skywalking-demo) project, open it with Idea, and click 「package」 to generate the `skywalking-user-service.jar` file.

![image](../images/skywalking-apm-rum-log/5.png)

Upload the `skywalking-user-service.jar` file to the `/usr/local/df-demo/skywalking` directory.

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

> 2. Output logs, including traceId.
![image](../images/skywalking-apm-rum-log/7.png)


#### 2.2 Deploy Web

Navigate to the web project directory and run `cnpm install` in the command line.

![image](../images/skywalking-apm-rum-log/8.png)

Run `npm run build` to generate deployment files.

![image](../images/skywalking-apm-rum-log/9.png)

Copy the files under the `dist` directory to the `/usr/local/web` directory on the server.

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

If your microservice uses springcloud gateway, you must copy `apm-spring-cloud-gateway-2.1.x-plugin-8.7.0.jar` and `apm-spring-webflux-5.x-plugin-8.7.0.jar` from the `agent/optional-plugins/` directory to the `skywalking-agent/plugins/` directory.

> **Note:** The version of `apm-spring-cloud-gateway` should match the specific version of springcloud gateway being used.

```shell
cp /usr/local/df-demo/skywalking/agent/optional-plugins/apm-spring-cloud-gateway-2.1.x-plugin-8.7.0.jar /usr/local/df-demo/skywalking/agent/plugins/
cp /usr/local/df-demo/skywalking/agent/optional-plugins/apm-spring-webflux-5.x-plugin-8.7.0.jar /usr/local/df-demo/skywalking/agent/plugins/
```

Execute the following command to start the backend service and call it from the frontend interface.

```shell
cd /usr/local/df-demo/skywalking
java  -javaagent:agent/skywalking-agent.jar -Dskywalking.agent.service_name=skywalking-log  -Dskywalking.collector.backend_service=localhost:11800 -jar skywalking-user-service.jar
```

Log in to the「[Guance](https://console.guance.com/)」platform, enter 「APM」, and view services, traces, and topology diagrams.

![image](../images/skywalking-apm-rum-log/16.png)

### 4 Enable RUM

Log in to the「[Guance](https://console.guance.com/)」platform, enter 「RUM」, create a new application named **skywalking-web-demo**, and copy the JS code below.

![image](../images/skywalking-apm-rum-log/17.png)

Modify `/usr/local/web/index.html` and add the JS code inside the `<head>` tag.

- Change `datakitOrigin` to the DataKit address, which is the Linux IP address plus port 9529.
- Set `allowedTracingOrigins` to the backend API address, which is the Linux IP address plus port 8090.

![image](../images/skywalking-apm-rum-log/18.png)

Parameter descriptions:

- `datakitOrigin`: Data transmission address, either the DataKit domain or IP (required).
- `env`: Application environment (required).
- `version`: Application version (required).
- `trackInteractions`: Whether to enable user interaction tracking, such as button clicks and form submissions (required).
- `traceType`: Trace type, default is `ddtrace` (optional).
- `allowedTracingOrigins`: To link APM and RUM traces, fill in the backend service domain or IP (optional).

Click the button on the frontend interface. Log in to the「[Guance](https://console.guance.com/)」platform - 「RUM」, click on 「skywalking-web-demo」, and view UV, PV, session count, visited pages, etc.

![image](../images/skywalking-apm-rum-log/19.png)

![image](../images/skywalking-apm-rum-log/20.png)

### 5 Full-Stack Observability

Log in to the「[Guance](https://console.guance.com/)」platform - 「RUM」, click on 「skywalking-web-demo」, then click 「Explorer」, select 「View」, and check page calls. Then click 「route_change」 to enter.

![image](../images/skywalking-apm-rum-log/21.png)

Select 「Trace」

![image](../images/skywalking-apm-rum-log/22.png)

Click on a request record to observe the "flame graph", "Span list", "service invocation relationship", and logs generated by this trace.

![image](../images/skywalking-apm-rum-log/23.png)