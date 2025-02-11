# Nginx Observability Best Practices
---

## Background Introduction

Nginx is an open-source, free, high-performance HTTP and reverse proxy server that can also be used as an IMAP/POP3 proxy server. Due to its asynchronous non-blocking working model, Nginx features high concurrency and low resource consumption. Its highly modular design also makes Nginx very extensible. In handling static files and reverse proxy requests, Nginx demonstrates significant advantages. Additionally, it is simple to deploy and maintain, making it widely used in enterprises. The most common scenarios for Nginx are as follows:

- **WEB Server (Static Resource Server)**

- **Load Balancing (Traffic Distribution)**
- **Reverse Proxy**
- **Others**

Although Nginx is simple, it is relatively important within enterprises due to its wide range of applications. Ensuring the health and stability of Nginx is a matter of great concern to enterprise operations personnel. Nginx's built-in performance metrics module **with-http_stub_status_module** supports direct retrieval of relevant Nginx data, such as the number of request connections and processed connections. Nginx logs (access.log, error.log) can be used for specific request-level analysis, such as PV counts, UV counts, and request error statistics. Combining these two sets of data can quickly provide insight into Nginx's status.

- **Nginx (with-http_stub_status_module)**

- **Nginx Logs:**

For example:

![image.png](../images/nginx-1.png)

While Nginx provides sufficient data sources to reflect its status, text-based or log-based data formats are not only inconvenient and unattractive to view but also cannot provide real-time feedback on changes in request volumes or server request states. Are there any good visualization tools that can quickly display this type of data or metrics? Currently, enterprises often use log processing tools (ELK, Splunk) for Nginx log processing and presentation. Nginx performance data is usually visualized using tools that support visualization. However, these methods may result in data fragmentation or overly costly solutions. To address this issue, DataKit decided to handle data collection from the source, such as using a single configuration item to simultaneously collect Nginx performance status and logs, and presenting the data on the same platform and interface to improve user efficiency.

**DataKit Configuration Interface and Final Monitoring Results Presentation:**

![image.png](../images/nginx-2.png)


## Prerequisites for Nginx Monitoring Integration with Guance

### Account Registration

Visit [Guance](https://www.guance.com) to register an account and log in using your registered credentials.

### Installing Datakit

#### Obtain Command

Click on the [**Integration**] module, then [**Quickly Get DataKit Installation Command**] in the top-right corner. Choose the appropriate installation command based on your operating system and type.

![](../images/nginx-3.png)

#### Execute Installation

Copy the DataKit installation command and run it directly on the server you wish to monitor.

- Installation directory: `/usr/local/datakit/`

- Log directory: `/var/log/datakit/`
- Main configuration file: `/usr/local/datakit/conf.d/datakit.conf`
- Plugin configuration directory: `/usr/local/datakit/conf.d/`

After DataKit installation, default Linux host plugins are enabled. You can view them under Infrastructure > Built-in Views.

| Collector Name | Description |
| --- | --- |
| cpu | Collects CPU usage information |
| disk | Collects disk usage information |
| diskio | Collects disk I/O information |
| mem | Collects memory usage information |
| swap | Collects Swap memory usage information |
| system | Collects operating system load information |
| net | Collects network traffic information |
| host_process | Collects resident processes (surviving over 10 minutes) |
| hostobject | Collects basic host information (such as OS and hardware details) |
| docker | Collects container objects and container logs |

Click on the [**Infrastructure**] module to view all installed Datakit hosts and basic information, such as hostname, CPU, and memory.

![image.png](../images/nginx-4.png)

### Creating a New Monitoring Scenario:

Log into [DataFlux](https://console.dataflux.cn/) and enter the project workspace. Click on Create Scenario - New Blank Scenario - View Template (it is recommended to choose the Nginx view template from the DF system views):

![image.png](../images/nginx-5.png)

**Monitoring View Example:**

![image.png](../images/nginx-6.png)

## Steps to Enable Nginx Collection Configuration:

### Pre-requisites for Enabling `datakit.inputs` Nginx.conf:

Verify if the **with-http_stub_status_module** module is enabled in Nginx. If not installed, you need to install it.

#### Linux Environment:

For Nginx installed via yum, you can check if the **with-http_stub_status_module** module is enabled by entering **nginx -V** in the console. If the module exists, proceed to [**Enabling Nginx.inputs in Datakit**](#datakit-nginx-inputs).

```shell
$ nginx -V
```

![image.png](../images/nginx-7.png)

For custom-installed Nginx, you can check by entering **/usr/local/nginx/sbin/nginx -V** in the console. If the module exists, proceed to [**Enabling Nginx.inputs in Datakit**](#datakit-nginx-inputs).

```shell
$ /usr/local/nginx/sbin/nginx -V
```

![image.png](../images/nginx-8.png)

#### Windows Environment:

In PowerShell, execute **.\nginx.exe -V** to check. If the module exists, proceed to [**Enabling Nginx.inputs in Datakit**](#datakit-nginx-inputs).

```shell
$ .\nginx.exe -V
```

![image.png](../images/nginx-9.png)

#### Installing the **with-http_stub_status_module** Module (Linux):

**Skip this step if the module is already installed.**

To enable this module, recompile Nginx using the following commands:

**./configure --with-http_stub_status_module**

Locate the configure file using: **find / | grep configure | grep nginx**

```shell
$ find / | grep configure | grep nginx
$ cd /usr/local/src/nginx-1.20.0/
$ ./configure --with-http_stub_status_module
```

![image.png](../images/nginx-10.png)

---

#### Adding the Nginx_status Location Block in Nginx.conf (Example)

```shell
$ cd /etc/nginx   
   // Path to Nginx may vary depending on your setup
$ vim nginx.conf

server {
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

**Next, reload Nginx using `nginx -s reload` to apply the changes**

Check if the module is functioning correctly:

Linux environment: **curl http://127.0.0.1/nginx_status**

Windows environment: **Access http://127.0.0.1/nginx_status via browser**

You should see data similar to:

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
# Pipeline configuration handles parsing Nginx logs into key-value pairs for easier visualization on the DF platform
# Default nginx.p pipeline configuration is located at /usr/local/datakit/pipeline/, containing predefined parsing rules for access and error logs

```

**Restart Datakit after saving the Nginx.conf file**

**# For customized pipeline modifications, refer to [Text Processing (Pipeline)](/logs/pipelines/text-processing/)**

#### Windows Environment:

**Navigate to C:\Program Files\datakit\conf.d\Nginx**

**Copy Nginx.conf.sample and rename it to Nginx.conf**

**Edit the Nginx.conf file**

Modify the following content:

```toml
[[inputs.nginx]]
    url = "http://localhost/nginx_status"
[inputs.nginx.log]
    files = ["C:\\logs\\access.log", "C:\\logs\\error.log"]
```

**Restart Datakit after saving the Nginx.conf file**

## Introduction to Nginx and Related Metrics

### What is Nginx?

Nginx (pronounced “engine X”) is a commonly used HTTP server and reverse proxy server. As an HTTP server, Nginx efficiently serves static content with minimal memory usage. As a reverse proxy, it acts as a single controlled access point for multiple backend servers or other applications like caching and load balancing. Nginx can be downloaded as an open-source version for use or through the more feature-rich commercial edition Nginx Plus. Nginx can also function as a mail proxy and general TCP proxy, though this article will not cover monitoring for these specific scenarios.

### Key Nginx Metrics

By monitoring Nginx, you can identify two types of issues: 1) Nginx resource issues, and 2) development issues elsewhere in the web infrastructure. Some key metrics that most Nginx users benefit from include **requests per second**, which provides a high-level overview of end-user activity; **server error rate**, which indicates the percentage of failed or invalid server requests out of total requests; and **request processing time**, which describes how long your server takes to process client requests (this could indicate slower request speeds or other problems in the environment). Generally, at least three critical categories of metrics should be monitored:

- Basic Activity Metrics

- Error Metrics
- Performance Metrics

Below we will break down some of the most important Nginx metrics in each category, along with a notable use case metric: using Nginx Plus for reverse proxying. We will also discuss how to monitor all these metrics using your preferred graphing or monitoring tool.

### Basic Activity Metrics

Regardless of your Nginx use case, you will undoubtedly want to monitor how many client requests the server is receiving and how they are being handled.

Nginx Plus reports basic activity metrics similarly to open-source Nginx but includes an additional module that reports slightly different metrics. We first discuss open-source Nginx and then the additional reporting features provided by Nginx Plus.

#### Nginx

The diagram below shows the lifecycle of a client connection and how open-source Nginx collects metrics during the connection.

![image.png](../images/nginx-13.png)

Accepts (Accepted), Handled (Handled), and Requests (Requests) increase continuously. Active (Active), Waiting (Waiting), Reading (Reading), and Writing (Writing) fluctuate with request volume.

| **Name** | **Description** | **Metric Type** |
| --- | --- | --- |
| Accepts (Accepted) | Number of attempted client connections by Nginx | Resource: Utilization |
| Handled (Handled) | Number of successful client connections | Resource: Utilization |
| Active (Active) | Current active client connections | Resource: Utilization |
| Requests (Requests) | Number of client requests | Work: Throughput |

![image.png](../images/nginx-14.png)

When Nginx receives a connection request from the operating system, the counter increments. If the worker cannot obtain the connection (by establishing a new one or reusing an open connection), the connection is dropped. This usually happens when resource limits (e.g., Nginx's worker_connections limit) are reached.

- Waiting (Waiting): An active connection can be in a "waiting" state if there are no active requests. New connections can bypass this state and move directly to Reading, especially with "accept filters" or "deferred accept," where Nginx continues only when enough data is available to start responding. If keep-alive is set, connections remain in the "waiting" state after sending a response.

- Reading (Reading): When a request is received, the connection exits the waiting state, and the request itself is considered to be in the reading state. In this state, Nginx reads the client request headers, which are generally lightweight and fast.

- Writing (Writing): After reading the request, it is considered to be in the writing state until the response is returned to the client. This means that while Nginx waits for upstream systems (behind Nginx) or processes the response, the request remains in the writing state. Requests typically spend most of their time in the writing state.

Usually, a connection supports only one request at a time. In this case, active connections == waiting + reading + writing. However, HTTP/2 allows multiplexing multiple concurrent requests/responses over a single connection, so Active might be less than the sum of Waiting, Reading, and Writing.

#### Nginx Plus

As mentioned earlier, Nginx Plus provides all the metrics available in open-source Nginx but also offers additional metrics. This section covers the metrics exclusive to Nginx Plus.

![image.png](../images/nginx-15.png)

Accepted (Accepted), Dropped (Dropped), and Total (Total) counters increment continuously. Active (Active), Idle (Idle), and Current (Current) track the current number of connections or requests in each state, increasing or decreasing with request volume.

| **Name** | **Description** | **Metric Type** |
| --- | --- | --- |
| Accepted (Accepted) | Number of client connections attempting to connect to Nginx | Resource: Utilization |
| Dropped (Dropped) | Number of disconnected connections | Work: Error Count |
| Active (Active) | Current active client connections | Resource: Utilization |
| Idle (Idle) | Client connections with zero current requests | Resource: Utilization |
| Total (Total) | Cumulative count of client requests | Work: Throughput |

When Nginx Plus workers receive connection requests from the operating system, the counter increments. If the worker cannot obtain the connection, the connection is dropped, and the drop counter increments. Drops usually occur when resource limits (e.g., Nginx Plus' worker_connections limit) are reached.

Active (Active) and Idle (Idle) behave similarly to "active" and "waiting" states in open-source Nginx, with a key exception: in open-source Nginx, "waiting" is included in "active," while in Nginx Plus, "idle" connections are excluded from "active." Current (Current) corresponds to the combined "Reading + Writing" state in open-source Nginx.

Total (Total) is the cumulative count of client requests. Note that a single client connection can involve multiple requests, so this count can significantly exceed the cumulative connection count. In practice, (total / accepted) represents the average number of requests per connection.

| Nginx (Open Source) | Nginx Plus |
| --- | --- |
| accepts | accepted |
| dropped (calculated) | dropped (reported as a metric) |
| reading + writing | current |
| waiting | idle |
| active (includes "waiting") | active (excludes "idle") |
| requests | total |

#### Alert Metric: Connection Drops

The number of dropped connections equals the difference between accepts and handled, or directly reported by Nginx Plus. Under normal circumstances, drops should be zero. If the rate of dropped connections starts rising per unit time, investigate potential factors causing resource saturation.

#### Alert Metric: Requests Per Second

Sampling request data at fixed intervals (Requests in Nginx Open Source or Total in Nginx Plus) can provide the number of requests received per unit time—usually minutes or seconds. Monitoring this metric can alert you to traffic spikes, whether legitimate or malicious, or sudden drops, which often indicate issues. Significant changes in requests per second can signal problems occurring somewhere in your environment, though it won't pinpoint the exact location. Note that all requests are counted regardless of their URL.

#### Collecting Activity Metrics

Open-source Nginx exposes these basic server metrics on a simple status page. Since the status information is displayed in a standardized format, almost any graphing or monitoring tool can be configured to parse the relevant data for analysis, visualization, or alerts. Nginx Plus provides richer data via a JSON feed. Refer to the accompanying article on [Nginx Metric Collection](../../integrations/nginx.md) for instructions on enabling metric collection.

### Error Metrics

| **Name** | **Description** | **Metric Type** | **Availability** |
| --- | --- | --- | --- |
| 4xx Codes | Client error count, e.g., "403 Forbidden" or "404 Not Found" | Work: Error Count | Nginx Logs<br />Nginx Plus |
| 5xx Codes | Server error count, e.g., "500 Internal Server Error" or "502 Bad Gateway" | Work: Error Count | Nginx Logs<br />Nginx Plus |

![image.png](../images/nginx-16.png)

Nginx error metrics tell you when the server returns errors instead of successfully processing valid requests. Client errors are indicated by 4xx status codes, and server errors by 5xx status codes.

#### Alert Metric: Server Error Rate

Your server error rate equals the number of 5xx errors (e.g., "502 Bad Gateway") per unit time (typically 1 to 5 minutes) divided by the total number of requests (including 1xx, 2xx, 3xx, 4xx, 5xx). If your error rate starts climbing over time, it may require investigation. A sudden increase may necessitate urgent action because clients may report errors to end-users.

Note on client errors: 4xx errors primarily represent client-side issues and provide limited insight into specific URLs. In other words, changes in 4xx errors may be noise, such as from web scanners blindly looking for vulnerabilities.

#### Collecting Error Metrics

While open-source Nginx does not directly provide an error rate suitable for observability, there are at least two ways to capture this information:

1. Use the extended status module available with commercially supported Nginx Plus.

2. Configure Nginx's log module to write response codes in the access log.

Refer to the accompanying article on [Nginx Metric Collection](../../integrations/nginx.md) for detailed instructions on both methods.

### Performance Metrics

| **Name** | **Description** | **Metric Type** | **Availability** |
| --- | --- | --- | --- |
| Request Time | Time taken to process each request, in seconds | Work: Performance | Nginx Logs |

#### Alert Metric: Request Processing Time

Nginx records the request time metric, which measures the time from reading the first byte from the client to completing the request. Longer response times may indicate upstream server-side response issues.

#### Collecting Processing Time Metrics

Nginx and Nginx Plus users can capture processing time data by adding the `$request_time` variable to the access log format. For more details on configuring logs for monitoring, refer to our accompanying article on [Nginx Logs](../../integrations/nginx.md).

### Reverse Proxy Metrics

| **Name** | **Description** | **Metric Type** | **Availability** |
| --- | --- | --- | --- |
| Active Connections to Upstream Servers | Current active client connections | Resource: Utilization | Nginx Plus |
| 5xx Status Codes Generated by Upstream Servers | Server-side errors | Work: Error Count | Nginx Plus |
| Available Servers in Each Upstream Group | Servers passing health checks | Resource: Availability | Nginx Plus |

One of the most common uses of Nginx is as a reverse proxy. The commercial version, Nginx Plus, exposes extensive metrics about backend ("upstream") servers relevant to reverse proxy setups. This section focuses on key upstream metrics of interest to Nginx Plus users.

Nginx Plus segments upstream metrics by group and then by individual server. For instance, if your reverse proxy distributes requests to five upstream web servers, you can easily spot if any server is overloaded or if there are enough healthy servers in the upstream group to ensure good response times.

#### Activity Metrics

The number of active connections per upstream server helps verify if the reverse proxy is distributing work evenly across the server group. If you use Nginx as a load balancer, significant deviations in the number of connections handled by any server may indicate that the server is struggling to process requests promptly or that your load-balancing method (e.g., round-robin or IP hash) needs optimization for your traffic patterns.

#### Error Metrics

Reviewing the error metrics section, 5xx (server errors) codes like "502 Bad Gateway" or "503 Service Unavailable" are valuable indicators, especially as a percentage of total response codes. Nginx Plus makes it easy to get the number of 5xx status codes and the total number of responses for each upstream server to determine the error rate for specific servers.

#### Availability Metrics

Another perspective on web server health is the number of currently available servers in each upstream group. In large reverse proxy setups, you may not care much about individual server statuses as long as the pool of available servers can handle the load. However, monitoring the total number of healthy servers in each upstream group provides a comprehensive view of overall web server health.

#### Collecting Upstream Metrics

Nginx Plus upstream metrics are exposed on the Nginx Plus monitoring dashboard and can be provided to almost any external monitoring platform via a JSON interface.

## Conclusion

In this article, we have covered some of the most valuable metrics you can monitor on an Nginx server. If you're just starting with Nginx, monitoring most or all of the following metrics will provide good visibility into your web infrastructure's health and activity levels:

- Connection Drops

- Requests Per Second
- Server Error Rate
- Request Processing Time

Ultimately, you will identify other more specialized metrics related to your own infrastructure and use case. Of course, what you monitor will depend on the tools you have and the available metrics.

## Further Reading:

[How to Collect Nginx Metrics Using DataKit](../../integrations/nginx.md)