# Nginx Observability Best Practices
---

## Background Introduction

Nginx is an open-source, free, high-performance HTTP and reverse proxy server that can also be used as an IMAP/POP3 proxy server. Because Nginx uses an asynchronous non-blocking working model, it has the characteristics of high concurrency and low resource consumption. Its highly modularized design also makes Nginx very extensible in handling static files, reverse proxy requests, etc., showing significant advantages. Additionally, its simple deployment and maintenance make it widely used by most enterprises. The current most common use cases for Nginx are as follows:

- **WEB Server (Static Resource Server)**

- **Load Balancing (Traffic Distribution)**
- **Reverse Proxy**
- **Others**

Although Nginx is simple, due to its wide range of application scenarios, it is relatively important within enterprises. To ensure the health and stability of Nginx is something enterprise operations personnel care about very much. Nginx's built-in performance metrics module **with-http_stub_status_module** supports directly obtaining relevant data from Nginx, such as the number of request connections, the number of processed connections, etc. Simultaneously, Nginx logs (access.log, error.log) can be used for specific request-level analysis, such as PV counts, UV counts, and request error statistics. Combining these two types of data allows for a quick understanding of Nginx's own status.

- **Nginx (with-http_stub_status_module)**

- **Nginx Logs:**

For example:

![image.png](../images/nginx-1.png)

Although Nginx itself provides sufficient data sources to reflect its own status, textual or log-like data formats are inconvenient and unattractive to view. Furthermore, these data formats cannot provide real-time feedback on changes in Nginx-related request counts or server request states. Is there a good visualization tool that can quickly display this type of data or metric? Currently, enterprises often use log processing tools (ELK, Splunk) to handle and present Nginx logs. Performance data from Nginx is usually presented using visualization-supporting tools. These two methods tend to result in data fragmentation or overly costly solutions. To address this issue, DataKit decided to handle things at the source, such as collecting both Nginx performance status and logs using the same configuration item, and presenting the data on the same platform and interface, thereby improving user efficiency.

**DataKit Configuration Interface and Final Monitoring Results Display:**

![image.png](../images/nginx-2.png)


## Nginx Monitoring Access <<< custom_key.brand_name >>> Prerequisites

### Account Registration

Go to [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>) to register an account, then log in with your registered account/password.

### Install Datakit

#### Obtain Command

Click the [**Integration**] module, then select [**Quickly Get DataKit Installation Command**] in the top-right corner. Choose the appropriate installation command based on your operating system and system type.

![](../images/nginx-3.png)

#### Execute Installation

Copy the DataKit installation command and run it directly on the server you want to monitor.

- Installation Directory /usr/local/datakit/

- Log Directory /var/log/datakit/
- Main Configuration File /usr/local/datakit/conf.d/datakit.conf
- Plugin Configuration Directory /usr/local/datakit/conf.d/

After installing DataKit, default Linux host plugins are enabled, which can be viewed under Infrastructure - Built-in Views.

| Collector Name | Description |
| --- | --- |
| cpu | Collects CPU usage of the host |
| disk | Collects disk usage |
| diskio | Collects disk IO conditions of the host |
| mem | Collects memory usage of the host |
| swap | Collects Swap memory usage |
| system | Collects host operating system load |
| net | Collects host network traffic conditions |
| host_process | Collects resident processes (alive for more than 10min) on the host |
| hostobject | Collects basic information about the host (such as OS information, hardware information, etc.) |
| docker | Collects possible container objects and container logs on the host |

Click the [**Infrastructure**] module to view the list of all hosts where Datakit is installed along with basic information such as hostname, CPU, and memory.

![image.png](../images/nginx-4.png)

### Create Monitoring Scenario:

Log into [DataFlux](https://console.dataflux.cn/) and enter the specific project space. Click Create Scenario - Create Blank Scenario - View Template (it is recommended to directly choose the Nginx view template in the system views of DF):

![image.png](../images/nginx-5.png)

**Monitoring View as Follows:**

![image.png](../images/nginx-6.png)

## Steps to Enable Nginx Collection Related Configurations:

### Prerequisites for Enabling Nginx.conf in Datakit.inputs:

Verify if the Nginx (**with-http_stub_status_module**) module is enabled. If this module is not installed, you will need to install it.

#### Linux Environment:

If Nginx was installed via yum, you can check in the console by entering **nginx -V** to see if the **with-http_stub_status_module** module is enabled. If this module exists, you can skip directly to the [**Datakit Enable Nginx.inputs**](#datakit-nginx-inputs) section.

```shell
$ nginx -V
```

![image.png](../images/nginx-7.png)

If you have a custom-installed Nginx, you can check by entering **/usr/local/nginx/sbin/nginx -V** in the console. If this module exists, you can skip directly to the [**Datakit Enable Nginx.inputs**](#datakit-nginx-inputs) section.

```shell
$ /usr/local/nginx/sbin/nginx -V
```

![image.png](../images/nginx-8.png)

#### Windows Environment:

In PowerShell, execute **.\nginx.exe -V** to check. If this module exists, you can skip directly to the [**Datakit Enable Nginx.inputs**](#datakit-nginx-inputs) section.

```shell
$ .\nginx.exe -V
```

![image.png](../images/nginx-9.png)


#### Installing with-http_stub_status_module Module (Linux):

**If this module is already installed, please skip this step.**

Enabling this module requires recompiling Nginx. The specific commands are as follows:

**./configure --with-http_stub_status_module**

The method to find the configure file location: **find / | grep configure | grep nginx**

```shell
$ find / | grep configure | grep nginx
$ cd /usr/local/src/nginx-1.20.0/
$ ./configure --with-http_stub_status_module
```

![image.png](../images/nginx-10.png)

---

#### Adding Nginx_status Location Forwarding in Nginx.conf (Example)

```
$ cd /etc/nginx   
   // Nginx path should be adjusted according to actual circumstances
$ vim nginx.conf

$ server {
     listen 80;   
     server_name localhost;
     // Port can be customized
     
      location /nginx_status {
          stub_status on;
          allow 127.0.0.1;
          deny all;
                             }
                             
          }
```

![image.png](../images/nginx-11.png)

**Next, execute nginx -s reload to reload Nginx**

Check if the module has been successfully enabled:

Linux Environment: **curl http://127.0.0.1/nginx_status**

Windows Environment: **Access http://127.0.0.1/nginx_status via browser**

You should see the following data:

![image.png](../images/nginx-12.png)


### Enabling Nginx.inputs in Datakit:

#### Linux Environment:

```shell
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf
```

Modify the following content

```toml
[[inputs.nginx]]
    url = "http://localhost/nginx_status"
[inputs.nginx.log]
    files = ["/var/log/nginx/access.log", "/var/log/nginx/error.log"]
    
pipeline = "nginx.p"
# The pipeline file is responsible for splitting and processing nginx logs, converting complete text files into key-value pairs for easier visualization on the DF platform.
# The nginx.p pipeline configuration is placed by default in /usr/local/datakit/pipeline/, containing pre-configured splitting statements for access and error formats.

```

**Save the nginx.conf file and restart datakit**

**# If you need to customize modifications to the pipeline, refer to [Text Processing (Pipeline)](/logs/pipelines/text-processing/)**

#### Windows Environment:

**$ Navigate to C:\Program Files\datakit\conf.d\Nginx**

**$ Copy nginx.conf.sample and rename it to nginx.conf**

**$ Edit the nginx.conf file**

Modify the following content

```toml
[[inputs.nginx]]
    url = "http://localhost/nginx_status"
[inputs.nginx.log]
    files = ["/logs/access.log", "/logs/error.log"]
```

**Save the nginx.conf file and restart datakit**

## Nginx and Related Metrics Introduction

### What is Nginx?

Nginx (pronounced “engine X”) is a commonly used HTTP server and reverse proxy server. As an HTTP server, Nginx can serve static content effectively and reliably with minimal memory consumption. As a reverse proxy, it can act as a single controlled access point for multiple backend servers or other applications like caching and load balancing. Nginx can be downloaded as an open-source version for use, or through the more feature-rich commercial release Nginx Plus. Nginx can also be used as a mail proxy and general TCP proxy, though monitoring for these scenarios won't be directly discussed in this article.

### Key Nginx Metrics

By monitoring Nginx, you can discover two types of issues: 1) Nginx's own resource issues, 2) development issues elsewhere in the Web infrastructure. Some of the metrics most beneficial to Nginx users include **requests per second** (RPS), which provides a high-level view of end-user activity combinations; **server error rate**, which refers to the ratio of failed or invalid server requests out of total requests; and **request processing time**, which describes how long your server takes to process client requests (this may indicate slower request speeds or other problems in your environment). <br /> Generally, at least three key categories of metrics should be monitored:

- Basic Activity Metrics

- Error Metrics
- Performance Metrics

Below, we will break down some of the most important Nginx metrics in each category, as well as a quite common use case worth special mention: using Nginx Plus as a reverse proxy. We'll also discuss how to monitor all these metrics using your chosen graphing or monitoring tools.

### Basic Activity Metrics

Regardless of the Nginx use case you employ, you will undoubtedly want to monitor how many client requests the server receives and how they are handled.

Nginx Plus reports basic activity metrics just like open-source Nginx does, but it also provides an auxiliary module that reports slightly different metrics. We'll first discuss open-source Nginx, then move on to additional reporting features provided by Nginx Plus.

#### Nginx

The diagram below shows the lifecycle of a client connection and how the open-source version of Nginx collects metrics during the connection.

![image.png](../images/nginx-13.png)

Accepts (Accepted), Handled (Handled), and Requests (Requests) increase continuously as counters. Active (Active), Waiting (Waiting), Reading (Reading), and Writing (Writing) vary depending on the volume of requests.

| **Name** | **Description** | **Metric Type** |
| --- | --- | --- |
| Accepts (Accepted) | Count of client connections attempted by Nginx | Resource: Utilization |
| Handled (Handled) | Successful client connections | Resource: Utilization |
| Active (Active) | Current active client connections | Resource: Utilization |
| Requests (Requests) | Number of client requests | Work: Throughput |

![image.png](../images/nginx-14.png)

When Nginx receives a connection request from the operating system, the counter increases. If the worker cannot obtain the connection for the request (either by establishing a new connection or reusing an open one), the connection will be dropped. Typically, this happens due to reaching resource limits (for example, Nginx’s worker_connections limit).

- waiting (Waiting): If there are no active requests currently, active connections may also be in the "waiting" state. New connections can bypass this state and directly move to Reading, most commonly when using "accept filters" or "delayed accept." In this case, Nginx only continues working once enough data is available to start responding. If the connection is set to keep-alive, after sending a response, the connection will also remain in the "waiting" state.

- reading (Reading): When a request is received, the connection exits the waiting state, and the request itself is considered to be in the reading state. In this state, Nginx is reading the client request headers. Request headers are generally lightweight, so this is typically a fast operation.
- writing (Writing): After reading the request, the request is considered to be in the writing state and remains in that state until the response is returned to the client. This means that while Nginx waits for results from upstream systems (the systems behind Nginx) and operates on the response, the request is in the writing state. Typically, the request spends most of its time in the writing state.

Usually, a connection supports only one request at a time. In this case, the number of active connections == waiting connections + reading requests + writing requests. However, HTTP/2 allows multiplexing multiple concurrent requests/responses over a single connection, so Active might be less than the sum of Waiting, Reading, and Writing.

#### Nginx Plus

As mentioned above, Nginx Plus includes all the metrics available in open-source Nginx, but Nginx Plus also exposes additional metrics. This section will introduce metrics that are only available from Nginx Plus.

![image.png](../images/nginx-15.png)

The Accepted (Received), Dropped (Dropped), and Total (Total) counters are constantly increasing. Active (Active), Idle (Idle), and Current (Current) track the number of current connections or the total number of requests in each state, so they increase or decrease with the volume of requests.

| **Name** | **Description** | **Metric Type** |
| --- | --- | --- |
| Accepted (Received) | Number of client connections attempting Nginx requests | Resource: Utilization |
| Dropped (Dropped) | Number of disconnected connections | Work: Error count |
| Active (Active) | Current active client connections | Resource: Utilization |
| Idle (Idle) | Client connections with zero current requests | Resource: Utilization |
| Total (Total) | Number of client requests | Work: Throughput |
| _*Strictly speaking, disconnections are a measure of resource saturation, but since saturation causes Nginx to stop servicing certain tasks (rather than queuing them for later service), it is best to consider "disconnections" as critical indicators._ |  |  |


When an Nginx Plus worker receives a connection request from the operating system (Accepted), the counter increases. If the worker cannot obtain the connection for the request (either by establishing a new connection or reusing an open one), the connection will be Dropped, and the drop count will increment. Typically, this happens due to reaching resource limits (for example, Nginx Plus’s worker_connections limit).

**Active** (Active) and **Idle** (Idle) are similar to "active" and "waiting" states in open-source Nginx, except for one key difference: in open-source Nginx, "waiting" belongs to the "active" scope, whereas in Nginx Plus, "idle" connections are excluded from the "active" count. **Current** (Current) is equivalent to the combined "Reading+Writing" state in open-source Nginx.

Total (Total) is the cumulative count of client requests. Note that a single client connection may involve multiple requests, so this number can be much larger than the cumulative count of connections. In fact, (total / accepted) represents the average number of requests per connection.

| Nginx (Open Source) | Nginx Plus |
| --- | --- |
| accepts | accepted |
| dropped (requires calculation) | dropped (reported directly as a metric) |
| reading + writing | current |
| waiting | idle |
| active (includes "waiting" states) | active (excludes "idle" states) |
| requests | total |


#### Alert Metric: Connection Drops

The number of Dropped (Dropped) connections equals the difference between Accepts (Accepted) and Handled (Handled), or can be directly obtained from Nginx Plus metrics. Under normal circumstances, dropped connections should be zero. If the rate of dropped connections per unit time starts to rise, look for factors causing resource saturation.

#### Alert Metric: Requests Per Second

Sampling request data at fixed intervals (**Requests from Nginx Open Source or Total from Nginx Plus**) can give you the number of requests received per unit time—usually minutes or seconds. Monitoring this metric can alert you to peaks in incoming network traffic, whether legitimate or malicious, or sudden drops, which often indicate issues. Significant changes in requests per second can alert you to something happening somewhere in your environment, although it cannot exactly tell you where those issues occur. Note that all requests are counted, regardless of their URL.

#### Collecting Activity Metrics
Open-source Nginx exposes these basic server metrics on a simple status page. Since the status information is displayed in a standardized format, almost any graphing or monitoring tool can be configured to parse the relevant data for analysis, visualization, or alerts. Nginx Plus provides a JSON feed with richer data. For more details on enabling metric collection, read our accompanying article on [Nginx Metric Collection](../../integrations/nginx.md).

### Error Metrics

| **Name** | **Description** | **Metric Type** | **Availability** |
| --- | --- | --- | --- |
| 4xx Codes | Client error count, e.g., "403 Forbidden" or "404 Not Found" | Work: Error count | Nginx Logs<br />Nginx Plus |
| 5xx Codes | Server error count, e.g., "500 Internal Server Error" or "502 Bad Gateway" | Work: Error count | Nginx Logs<br />Nginx Plus |

![image.png](../images/nginx-16.png)

Nginx error metrics inform you when the server returns errors instead of processing valid requests. Client errors are indicated by 4xx status codes, while server errors are indicated by 5xx status codes.

#### Alert Metric: Server Error Rate

Your server error rate equals the number of 5xx errors (e.g., "502 Bad Gateway") per unit time (typically 1 to 5 minutes) divided by the total number of requests (including 1xx, 2xx, 3xx, 4xx, 5xx). If your error rate starts climbing over time, investigation may be necessary. A sudden increase may require urgent action, as clients may be reporting errors to end-users.

Note on client errors: 4xx mostly represents client-side errors, and the information gained from 4xx is limited because it mainly indicates client anomalies without providing detailed insights into specific URLs. In other words, variations in 4xx could be noise, such as web scanning programs blindly looking for vulnerabilities.

#### Collecting Error Metrics

Although open-source Nginx does not directly provide an error rate usable for observability, there are at least two ways to capture this information:

1. Using the extended status module included with commercially supported Nginx Plus

2. Configuring Nginx's log module to write response codes in the access log

Refer to our accompanying article on Nginx Metric Collection for detailed instructions on both methods.

### Performance Metrics

| **Name** | **Description** | **Metric Type** | **Availability** |
| --- | --- | --- | --- |
| Request Time | Time taken to process each request, in seconds | Work: Performance | Nginx Logs |

#### Alert Metric: Request Processing Time

Nginx records request time metrics that record the time taken to process each request, from reading the first client byte to completing the request. Longer response times may indicate issues with upstream, i.e., server-side responses.

#### Collecting Processing Time Metrics

Nginx and Nginx Plus users can capture processing time data by adding the $request_time variable to the access log format. For more details on configuring logs for monitoring, see our accompanying article on [Nginx Logs](../../integrations/nginx.md).

### Reverse Proxy Metrics

| **Name** | **Description** | **Metric Type** | **Availability** |
| --- | --- | --- | --- |
| Active Connections to Upstream Servers | Current active client connections | Resource: Utilization | Nginx Plus |
| 5xx Status Codes Generated by Upstream Servers | Server-side errors | Work: Error count | Nginx Plus |
| Available Upstream Server Groups | Servers passing health checks | Resource: Availability | Nginx Plus |


One of the most common uses of Nginx is as a reverse proxy. The commercial version of Nginx Plus exposes a large number of metrics related to backend ("upstream") servers concerning reverse proxy settings. This section will focus on some key upstream metrics of interest to Nginx Plus users.

Nginx Plus first segments upstream metrics by group, then by individual server. Thus, for example, if your reverse proxy distributes requests among five upstream web servers, you can easily see if any of these individual servers are overloaded and if there are enough healthy servers in the upstream group to ensure good response times.

#### Activity Metrics

The number of active connections per upstream server helps you verify if the reverse proxy correctly distributes work within the server group. If you use Nginx as a load balancer and notice a significant deviation in the number of connections processed by any server, it may indicate that the server is struggling to handle requests promptly, or that the load-balancing method you configured (such as round-robin or IP hashing) needs optimization for your traffic pattern.

#### Error Metrics

Reviewing the error metrics section above, 5xx (server errors) codes like "502 Bad Gateway" or "503 Service Temporarily Unavailable" are worth monitoring, especially as a proportion of total response codes. Nginx Plus makes it easy to get the number of 5xx status codes and total responses per upstream server to determine the error rate for specific servers.

#### Availability Metrics

Another perspective on web server health, Nginx also enables you to easily monitor the health of upstream groups: the number of currently available servers per group. In large reverse proxy setups, as long as your pool of available servers can handle the load, you may not be overly concerned with the status of a single server. However, monitoring the total number of running servers in each upstream group gives a comprehensive view of overall web server health.

#### Collecting Upstream Metrics

Nginx Plus upstream metrics are exposed on the Nginx Plus monitoring dashboard and can also be provided to almost any external monitoring platform via a JSON interface.

## Conclusion

In this article, we touched on some of the most valuable metrics. In this article, we've explored some of the most useful metrics you can monitor on Nginx servers. If you're just starting with Nginx, monitoring most or all of the following metrics will provide good visibility into the health and activity level of your network infrastructure:

- Connection Drops

- Requests Per Second
- Server Error Rate
- Request Processing Time

Ultimately, you will recognize other more specialized metrics that are particularly relevant to your own infrastructure and use case. Of course, what you monitor will depend on the tools you have and the available metrics.

## For More Information:

[How to Use DataKit to Collect Nginx Metrics](../../integrations/nginx.md)