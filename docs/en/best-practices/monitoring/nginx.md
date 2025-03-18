# Nginx Observability Best Practices
---

## Background Introduction

Nginx is an open-source, free, and high-performance HTTP and reverse proxy server that can also be used as an IMAP/POP3 proxy server. Due to its asynchronous non-blocking working model, Nginx has the characteristics of high concurrency and low resource consumption. Its highly modular design also makes Nginx highly extensible. In handling static files and reverse proxy requests, Nginx shows significant advantages. Additionally, it is easy to deploy and maintain, making it widely used in most enterprises. Currently, the most common use cases for Nginx include:

- **WEB Server (Static Resource Server)**

- **Load Balancer (Traffic Distribution)**
- **Reverse Proxy**
- **Others**

Although Nginx is simple, due to its wide range of application scenarios, it is relatively important within enterprises. Ensuring the health and stability of Nginx is a matter of great concern to internal operations personnel. Nginx's built-in performance metrics module **with-http_stub_status_module** can directly obtain relevant data from Nginx, such as the number of request connections and handled connections. Additionally, Nginx logs (access.log, error.log) can be used for specific request-level analysis, such as PV counts, UV counts, and request error statistics. Combining these two types of data allows for a quick understanding of Nginx's status.

- **Nginx (with-http_stub_status_module)**

- **Nginx Logs:**

For example:

![image.png](../images/nginx-1.png)

Although Nginx provides enough data sources to reflect its own status, textual or log-based data formats are not only inconvenient and unattractive to view but also cannot provide real-time feedback on changes in Nginx's request count or server request status. Are there any good visualization tools that can quickly present this type of data or metrics? Currently, enterprises often use log processing tools (ELK, Splunk) for Nginx log processing and presentation. Performance data from Nginx is typically visualized using tools that support visualization. These two methods can lead to data fragmentation or overly expensive solutions. To address this issue, DataKit decided to handle it at the source, such as collecting both Nginx performance status and logs with a single configuration item, and presenting the data on the same platform and interface, thereby improving user efficiency.

**DataKit Configuration Interface and Final Monitoring Effect Presentation:**

![image.png](../images/nginx-2.png)

## Prerequisites for Nginx Monitoring Integration with <<< custom_key.brand_name >>>

### Account Registration

Go to [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>) to register an account and log in using your registered account/password.

### Install Datakit

#### Obtain Command

Click on the [**Integration**] module, and in the top-right corner, click [**Quickly Get DataKit Installation Command**], then choose the appropriate installation command based on your operating system and system type.

![](../images/nginx-3.png)

#### Execute Installation

Copy the DataKit installation command and run it directly on the server that needs to be monitored.

- Installation directory: `/usr/local/datakit/`
- Log directory: `/var/log/datakit/`
- Main configuration file: `/usr/local/datakit/conf.d/datakit.conf`
- Plugin configuration directory: `/usr/local/datakit/conf.d/`

After DataKit is installed, commonly used Linux host plugins are enabled by default. You can view them under Infrastructure > Built-in Views.

| Collector Name | Description |
| --- | --- |
| cpu | Collects CPU usage on the host |
| disk | Collects disk usage |
| diskio | Collects disk IO usage on the host |
| mem | Collects memory usage on the host |
| swap | Collects Swap memory usage on the host |
| system | Collects host OS load |
| net | Collects network traffic on the host |
| host_process | Collects long-running processes (surviving more than 10 minutes) on the host |
| hostobject | Collects basic host information (e.g., OS information, hardware information) |
| docker | Collects container objects and logs on the host |

Click on the [**Infrastructure**] module to view all hosts where Datakit is installed along with their basic information, such as hostname, CPU, and memory.

![image.png](../images/nginx-4.png)

### Create New Monitoring Scenario:

Log in to [DataFlux](https://console.dataflux.cn/) and enter the specific project space. Click on create new scenario - create blank scenario - view template (it is recommended to directly select the Nginx view template from the system views in DF):

![image.png](../images/nginx-5.png)

**Monitoring View Example:**

![image.png](../images/nginx-6.png)

## Steps to Enable Nginx Collection Configuration:

### Prerequisites for Enabling `datakit.inputs` Nginx .conf:

Verify if the Nginx **with-http_stub_status_module** module is enabled. If this module is not installed, you need to install it.

#### Linux Environment:

For Nginx installed via yum, you can check if the **with-http_stub_status_module** module is enabled by running `nginx -V` in the console. If the module exists, you can proceed directly to the [**Datakit Nginx .inputs**](#datakit-nginx-inputs) section.

```shell
$ nginx -V
```

![image.png](../images/nginx-7.png)

If Nginx is custom-installed, you can check by running `/usr/local/nginx/sbin/nginx -V` in the console. If the module exists, you can proceed directly to the [**Datakit Nginx .inputs**](#datakit-nginx-inputs) section.

```shell
$ /usr/local/nginx/sbin/nginx -V
```

![image.png](../images/nginx-8.png)

#### Windows Environment:

Run `.\nginx.exe -V` in PowerShell to check. If the module exists, you can proceed directly to the [**Datakit Nginx .inputs**](#datakit-nginx-inputs) section.

```shell
$ .\nginx.exe -V
```

![image.png](../images/nginx-9.png)

#### Installing the `with-http_stub_status_module` Module (Linux):

**Skip this step if the module is already installed.**

Enabling this module requires recompiling Nginx. The specific commands are as follows:

**./configure --with-http_stub_status_module**

To find the location of the configure file: `find / | grep configure | grep nginx`

```shell
$ find / | grep configure | grep nginx
$ cd /usr/local/src/nginx-1.20.0/
$ ./configure --with-http_stub_status_module
```

![image.png](../images/nginx-10.png)

---

#### Adding `nginx_status` Location Forwarding in Nginx.conf (Example)

```
$ cd /etc/nginx   
   // Path to nginx may vary depending on actual circumstances
$ vim nginx.conf

$  server {
     listen 80;   
     server_name localhost;
     // Port can be customized
     
      location /nginx_status {
          stub_status  on;
          allow 127.0.0.1;
          deny all;
                             }
                             
          }
```

![image.png](../images/nginx-11.png)

**Next, execute `nginx -s reload` to reload Nginx**

Check if the module is enabled:

Linux environment: `curl http://127.0.0.1/nginx_status`

Windows environment: Access `http://127.0.0.1/nginx_status` via browser

The following data should appear:

![image.png](../images/nginx-12.png)

### Enabling Nginx.inputs in Datakit:

#### Linux Environment:

```shell
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf
```

Modify the following content:

```toml
[[inputs.nginx]]
    url = "http://localhost/nginx_status"
[inputs.nginx.log]
    files = ["/var/log/nginx/access.log", "/var/log/nginx/error.log"]
    
pipeline = "nginx.p"
# The pipeline file is responsible for parsing nginx logs into key-value pairs for easier visualization on the DF platform.
# The default nginx.p pipeline file is placed in /usr/local/datakit/pipeline/, containing predefined access and error format parsing statements.
```

**Restart Datakit after saving the nginx.conf file**

**# For customizing the pipeline, refer to [Text Processing (Pipeline)](/logs/pipelines/text-processing/)**

#### Windows Environment:

**$ Navigate to C:\Program Files\datakit\conf.d\nginx**

**$ Copy nginx.conf.sample and rename it to nginx.conf**

**$ Edit the nginx.conf file**

Modify the following content:

```toml
[[inputs.nginx]]
    url = "http://localhost/nginx_status"
[inputs.nginx.log]
    files = ["C:/logs/access.log", "C:/logs/error.log"]
```

**Save the nginx.conf file and restart Datakit**

## Introduction to Nginx and Related Metrics

### What is Nginx?

Nginx (pronounced "engine X") is a commonly used HTTP server and reverse proxy server. As an HTTP server, Nginx efficiently and reliably serves static content with minimal memory consumption. As a reverse proxy, it can act as a single controlled access point for multiple backend servers or applications like caching and load balancing. Nginx can be downloaded as an open-source version or used through the feature-rich commercial release Nginx Plus. Nginx can also be used as a mail proxy and a generic TCP proxy, though monitoring for these scenarios is not covered in this article.

### Key Nginx Metrics

By monitoring Nginx, you can identify two types of issues: 1) resource problems with Nginx itself, and 2) development issues elsewhere in the web infrastructure. Some of the key metrics that most Nginx users benefit from include **requests per second**, which provides a high-level view of end-user activity; **server error rate**, which indicates the proportion of failed or invalid server requests among total requests; and **request processing time**, which describes how long the server takes to process client requests (which might indicate slower request speeds or other issues in the environment).

In general, at least three key categories of metrics should be watched:

- Basic Activity Metrics
- Error Metrics
- Performance Metrics

Below, we will break down some of the most important Nginx metrics in each category, along with a particularly common use case worth mentioning: using Nginx Plus as a reverse proxy. We will also cover how to monitor all these metrics using your chosen graphing or monitoring tool.

### Basic Activity Metrics

Regardless of which Nginx use case you have, you undoubtedly want to monitor how many client requests the server is receiving and how they are being processed.

Nginx Plus reports basic activity metrics just like open-source Nginx, but it also provides an additional module that reports slightly different metrics. We first discuss open-source Nginx and then move on to the additional reporting capabilities provided by Nginx Plus.

#### Nginx

The following diagram shows the lifecycle of a client connection and how open-source Nginx collects metrics during the connection.

![image.png](../images/nginx-13.png)

Accepts (Accepted), Handled (Handled), and Requests (Requests) increase incrementally. Active (Active), Waiting (Waiting), Reading (Reading), and Writing (Writing) fluctuate based on request volume.

| **Name** | **Description** | **Metric Type** |
| --- | --- | --- |
| Accepts (Accepted) | Count of client connections attempted by Nginx | Resource: Utilization |
| Handled (Handled) | Count of successful client connections | Resource: Utilization |
| Active (Active) | Current active client connections | Resource: Utilization |
| Requests (Requests) | Client request count | Work: Throughput |

![image.png](../images/nginx-14.png)

When Nginx receives a connection request from the operating system, the counter increments. If the worker cannot establish the connection (by creating a new one or reusing an existing one), the connection is dropped. Connections are usually dropped when resource limits (such as Nginx's worker_connections limit) are reached.

- Waiting (Waiting): If there are no active requests, active connections may be in a "waiting" state. New connections can bypass this state and move directly to Reading, especially when using "accept filters" or "deferred accept." In this case, Nginx continues working only once there is enough data to start responding. If connections are set to keep-alive, they remain in the "waiting" state after sending responses.

- Reading (Reading): When a request is received, the connection exits the waiting state, and the request itself is considered in the reading state. At this stage, Nginx reads the client request headers. Request headers are generally lightweight, so this operation is usually quick.
- Writing (Writing): After reading the request, it transitions to the writing state and remains there until the response is sent back to the client. This means while Nginx waits for results from upstream systems (behind Nginx) and operates on the response, the request is in the writing state. Requests typically spend most of their time in the writing state.

Typically, one connection supports one request at a time. In this case, the number of active connections equals the sum of waiting + reading + writing. However, HTTP/2 allows multiplexing multiple concurrent requests/responses over a single connection, so Active may be less than the sum of Waiting, Reading, and Writing.

#### Nginx Plus

As mentioned earlier, Nginx Plus includes all the metrics available in open-source Nginx but also provides additional metrics. This section covers metrics exclusive to Nginx Plus.

![image.png](../images/nginx-15.png)

Accepted (Accepted), Dropped (Dropped), and Total (Total) counters continuously increase. Active (Active), Idle (Idle), and Current (Current) track current connections or request totals in each state, thus fluctuating with request volume.

| **Name** | **Description** | **Metric Type** |
| --- | --- | --- |
| Accepted (Accepted) | Count of client connections attempting to connect to Nginx | Resource: Utilization |
| Dropped (Dropped) | Count of disconnected connections | Work: Error Count |
| Active (Active) | Current active client connections | Resource: Utilization |
| Idle (Idle) | Client connections with zero current requests | Resource: Utilization |
| Total (Total) | Client request count | Work: Throughput |

Strictly speaking, disconnections are a measure of resource saturation, but since saturation causes Nginx to stop serving certain requests (rather than queueing them for later service), it's best to consider "disconnections" as a critical metric.

When Nginx Plus workers receive an **Accepted** connection request from the operating system, the counter increments. If the worker cannot establish the connection (by creating a new one or reusing an open one), the connection is **Dropped**, and the drop count increments. Connections are usually dropped when resource limits (like Nginx Plus' worker_connections limit) are reached.

**Active** and **Idle** states work similarly to "active" and "waiting" states in open-source Nginx, with a key exception: in open-source Nginx, "waiting" is included in "active," while in Nginx Plus, "idle" connections are excluded from the "active" count. **Current** corresponds to the combined "Reading+Writing" state in open-source Nginx.

Total (Total) is the cumulative count of client requests. Note that a single client connection can involve multiple requests, so this count can significantly exceed the cumulative connection count. In practice, (total / accepted) represents the average number of requests per connection.

| Nginx (Open Source) | Nginx Plus |
| --- | --- |
| accepts | accepted |
| dropped (calculated) | dropped (reported directly) |
| reading + writing | current |
| waiting | idle |
| active (includes “waiting” states) | active (excludes “idle” states) |
| requests | total |

#### Alert Metric: Connection Drops

The number of Dropped connections equals the difference between accepts and handled or is directly reported by Nginx Plus. Under normal conditions, drops should be zero. If the rate of dropped connections starts increasing over time, investigate potential factors causing resource saturation.

#### Alert Metric: Requests Per Second

Sampling request data at fixed intervals (**Requests** in the open-source Nginx or **Total** in Nginx Plus) provides the number of requests received per unit time—usually minutes or seconds. Monitoring this metric alerts you to peaks in incoming network traffic, whether legitimate or malicious, or sudden drops, which often indicate issues. Sudden changes in requests per second can signal problems somewhere in your environment, although it won't pinpoint the exact location. Note that all requests are counted regardless of their URL.

#### Collecting Activity Metrics

Open-source Nginx exposes these basic server metrics on a simple status page. Since the status information is presented in a standardized format, almost any graphing or monitoring tool can be configured to parse the relevant data for analysis, visualization, or alerting. Nginx Plus provides a JSON feed with richer data. Refer to the accompanying article on [Nginx Metrics Collection](../../integrations/nginx.md) for instructions on enabling metrics collection.

### Error Metrics

| **Name** | **Description** | **Metric Type** | **Availability** |
| --- | --- | --- | --- |
| 4xx Codes | Count of client errors, e.g., "403 Forbidden" or "404 Not Found" | Work: Error Count | Nginx Logs <br /> Nginx Plus |
| 5xx Codes | Count of server errors, e.g., "500 Internal Server Error" or "502 Bad Gateway" | Work: Error Count | Nginx Logs <br /> Nginx Plus |

![image.png](../images/nginx-16.png)

Nginx error metrics tell you when the server returns an error instead of successfully processing a valid request. Client errors are indicated by 4xx status codes, and server errors by 5xx status codes.

#### Alert Metric: Server Error Rate

Your server error rate is the number of 5xx errors (e.g., "502 Bad Gateway") per unit time (usually 1 to 5 minutes) divided by the total number of requests (including 1xx, 2xx, 3xx, 4xx, 5xx). If your error rate starts climbing over time, investigation may be needed. A sudden increase might require urgent action, as clients could be reporting errors to end-users.

Note on client errors: 4xx errors mostly represent client-side issues, and the information derived from 4xx errors is limited because they primarily indicate client anomalies without providing insight into specific URLs. In other words, changes in 4xx errors might be noise, for instance, from Web scanners blindly looking for vulnerabilities.

#### Collecting Error Metrics

While open-source Nginx does not directly provide an error rate for observability, there are at least two ways to capture this information:

1. Using the extended status module included with commercially supported Nginx Plus
2. Configuring Nginx's log module to write response codes in the access log

Refer to the accompanying article on [Nginx Metrics Collection](../../integrations/nginx.md) for detailed instructions on both methods.

### Performance Metrics

| **Name** | **Description** | **Metric Type** | **Availability** |
| --- | --- | --- | --- |
| Request Time | Time taken to process each request, in seconds | Work: Performance | Nginx Logs |

#### Alert Metric: Request Processing Time

Nginx records request time metrics that document the duration of each request from the first byte read from the client to completing the request. Longer response times may indicate upstream server-side response issues.

#### Collecting Request Processing Time Metrics

Nginx and Nginx Plus users can capture request processing time data by adding the `$request_time` variable to the access log format. For more details on configuring logs for monitoring, see our accompanying article on [Nginx Logs](../../integrations/nginx.md).

### Reverse Proxy Metrics

| **Name** | **Description** | **Metric Type** | **Availability** |
| --- | --- | --- | --- |
| Active Connections to Upstream Servers | Current active client connections | Resource: Utilization | Nginx Plus |
| 5xx Status Codes Generated by Upstream Servers | Server-side errors | Work: Error Count | Nginx Plus |
| Available Servers in Each Upstream Group | Servers passing health checks | Resource: Availability | Nginx Plus |

One of the most common uses of Nginx is as a reverse proxy. The commercial version of Nginx Plus exposes numerous metrics related to backend ("upstream") servers in reverse proxy setups. This section focuses on some key upstream metrics of interest to Nginx Plus users.

Nginx Plus breaks down upstream metrics by group and then by individual servers. For example, if your reverse proxy distributes requests to five upstream Web servers, you can instantly see if any individual server is overloaded and if there are enough healthy servers in the upstream group to ensure good response times.

#### Activity Metrics

The number of active connections per upstream server helps verify whether the reverse proxy is distributing work correctly among the server group. If you're using Nginx as a load balancer and notice significant deviations in the number of connections handled by any server, it may indicate that the server is struggling to handle requests promptly or that the configured load-balancing method (e.g., round-robin or IP hash) needs optimization for your traffic patterns.

#### Error Metrics

Reviewing the error metrics section above, 5xx (server errors) codes like "502 Bad Gateway" or "503 Service Unavailable" are important indicators, especially as a percentage of total response codes. Nginx Plus easily provides the number of 5xx status codes and total responses for each upstream server, allowing you to determine the error rate for specific servers.

#### Availability Metrics

Another perspective on Web server health, Nginx Plus allows you to easily monitor the health of upstream groups by showing the number of currently available servers in each group. In large reverse proxy setups, you may not be overly concerned about the status of individual servers as long as the available server pool can handle the load. However, monitoring the total number of healthy servers in each upstream group provides a comprehensive view of overall Web server health.

#### Collecting Upstream Metrics

Nginx Plus exposes upstream metrics on the Nginx Plus monitoring dashboard and can provide metrics to nearly any external monitoring platform via a JSON interface.

## Conclusion

In this article, we've touched upon some of the most valuable metrics you can monitor on your Nginx server. If you're new to Nginx, monitoring most or all of the following metrics will provide a good visibility into the health and activity level of your network infrastructure:

- Connection Drops
- Requests Per Second
- Server Error Rate
- Request Processing Time

Ultimately, you will recognize other more specialized metrics relevant to your own infrastructure and use case. Of course, what you monitor will depend on the tools you have and the available metrics.

## Learn More:

[How to Collect Nginx Metrics Using DataKit](../../integrations/nginx.md)