# Best Practices for TAGs in <<< custom_key.brand_name >>>

---

This article is intended to serve as a starting point, encouraging readers to expand on these ideas and create their own unique uses for tags.

## Preface

**Opentelemetry Protocol**, defined by the **CNCF (Cloud Native Computing Foundation)**, represents the latest generation of **observability specifications** (still in incubation). This specification defines the three pillars of observability: **metrics, trace, log**. However, merely collecting data from these three pillars without correlation does not distinguish modern observability from traditional monitoring tools (APM, logs, Zabbix, etc.). Is it just a collection of monitoring tools? Therefore, an important concept arises: **TAG (tag)**. For example, a traceID that connects front-end and back-end can be considered a tag, as can a host that initially correlates metrics, traces, and logs. Other examples include project, environment, version number, all of which are individual tags!

In short, **using TAGs can achieve data correlation and enable more customized observability**, making it crucial. In <<< custom_key.brand_name >>>'s current architecture, all observable items support tag settings, with theoretically no upper limit on the number of tags.

Example: A common real-life scenario is job hunting or HR recruitment, where specific requirements such as programming skills, computer knowledge, a bachelor's degree, and years of experience are like tags. Only candidates meeting these tags can qualify for the position. Similarly, in IT systems, if a server runs a specific application, database, and NGINX in a certain environment with a responsible person, having enough tags allows for quick identification of problematic servers, affected services, and responsible parties, thereby improving problem resolution efficiency.

This article will explore the extensibility and flexibility of tags through four examples using <<< custom_key.brand_name >>>.

## Experiment One: Grouping Servers

### Background

Companies often have **multiple project teams or business units**. Each team or unit may use its own infrastructure for business development. If observability is implemented using <<< custom_key.brand_name >>> from infrastructure to applications, how can resources be distinguished beyond workspace separation?

Of course, there is a way. <<< custom_key.brand_name >>> considered this scenario during design. The default DataKit main configuration file includes a `global_tag` label, which sets tags at the infrastructure level. All components on this infrastructure, such as applications and databases, inherit this tag by default.

### 1 Modify datakit-inputs to Configure global_tag

```xml
$ vim /usr/local/datakit/conf.d/datakit.conf

# Add tags in global_tags, additional tags can be added beyond the default three

[global_tags]
cluster = ""
project = "solution"
site = ""
```

![image.png](../images/tag-1.png)

Similarly, all related hosts' DataKit can be configured with this tag.

### 2 <<< custom_key.brand_name >>> - View Server Groups

![image.png](../images/tag-2.png)

## Experiment Two: Modify Hostname Recognized by DataKit

### Background

DataKit defaults to collecting the hostname at the host level and uses it as a global tag to correlate all metrics, traces, logs, and objects. However, in many enterprise environments, hostnames are random strings without practical meaning. Changing the hostname might affect connections to applications or databases, so companies are hesitant to modify them. To avoid risks, DataKit's built-in `ENV_HOSTNAME` can handle this situation.

???+ warning
    **Note:** After applying this method, data from the new hostname will be uploaded anew, and data from the old hostname will no longer be updated.<br/>
    **Recommendation:** If you need to change the hostname, it is best to do so during the initial installation of DataKit.

### 1 Modify datakit-inputs to Configure [environments]

```xml
$ vim /usr/local/datakit/conf.d/datakit.conf

# Modify ENV_HOSTNAME in [environments] to a recognizable hostname

[environments]
  ENV_HOSTNAME = "118.178.57.79"
```

![image.png](../images/tag-3.png)

### 2 <<< custom_key.brand_name >>> - Compare Data Before and After Changes

![image.png](../images/tag-4.png)

## Experiment Three: Nginx Log Statistics Displayed Per Service

### Background

Internal company NGINX servers typically handle domain forwarding or service forwarding. They may forward frontend requests to multiple backend subdomains or different ports, or directly serve multiple domains. Unified NGINX monitoring cannot meet these needs. How does <<< custom_key.brand_name >>> address this issue?

**Scenario**: NGINX exposes ports 18889 and 80, forwarding to internal server 118.178.57.79 on ports 8999 and 18999 respectively.

**Requirement**: Statistically analyze data for NGINX ports 18889 and 80, such as PV, UV, and error counts.

**Prerequisite**: Access logs for NGINX ports 80 and 18889 are configured in separate directories (or different log file names).

| Port 80 Log Directory | /var/log/nginx/80/    |
| --------------------- | --------------------- |
| Port 18889 Log Directory | /var/log/nginx/18999/ |

![image.png](../images/tag-5.png)

### 1 Configure Nginx Performance Metrics Monitoring

> Refer to the integration documentation <[Nginx](../../integrations/nginx.md)> for detailed configuration.

1. Enable the `nginx.conf` performance metrics module

Check if the `http_stub_status_module` is enabled in nginx.

(This example already has it enabled.)

![image.png](../images/tag-6.png)

2. Add `nginx_status` location in `nginx.conf`

```
$ cd /etc/nginx
   // Adjust nginx path as needed
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

![image.png](../images/tag-7.png)

3. Execute `nginx -s reload` to reload nginx

4. Enable `nginx.inputs` in DataKit

```
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf
```

5. Modify as follows:

```
[[inputs.nginx]]
    url = http://localhost/nginx_status
```

![image.png](../images/tag-8.png)

6. Save the `nginx.conf` file and restart DataKit

```xml
$ service datakit restart
```

### 2 Configure Log Monitoring for Services on Ports 80 and 18889

```xml
$ cd /usr/local/datakit/conf.d/log/
$ cp logging.conf.sample nginx80.conf

$ vim nginx80.conf

## Modify log paths to correct application log paths
## source, service, pipeline are mandatory fields and can directly use the application name to distinguish different log names
## Add tag domainname

## Modify as follows:
[[inputs.logging]]

  logfiles = ["/var/log/nginx/80/access.log","/var/log/nginx/80/error.log" ]

  source = "nginx"

  service = "nginx"

  pipeline = "nginx.p"

  [inputs.logging.tags]

  domainname = "118.178.226.149:80"
```

```xml

$ cd /usr/local/datakit/conf.d/log/
$ cp logging.conf.sample nginx18889.conf
$ vim nginx18889.conf

## Modify log paths to correct application log paths
## source, service, pipeline are mandatory fields and can directly use the application name to distinguish different log names
## Add tag domainname

## Modify as follows:
[[inputs.logging]]

  logfiles = ["/var/log/nginx/18889/access.log","/var/log/nginx/18889/error.log" ]

  source = "nginx"

  service = "nginx"

  pipeline = "nginx.p"

  [inputs.logging.tags]

  domainname = "118.178.226.149:18889"
```

![image.png](../images/tag-9.png)

### 3 Configure Custom Views (Using Tags to Distinguish Domains)

**Steps**: Log in to <<< custom_key.brand_name >>> - 「Scene」 - 「Create Scene」 - 「Create Blank Scene」 - 「System View」 (Create NGINX)

**Key Point**: Modify NGINX view-related configurations in the system template

1. Enter view editing mode, click 「Modify View Variables」 - 「Add View Variable」

```
L::nginx:(distinct(`domainname`)){host='#{host}'}
```

> **Explanation**: Inherit the host from NGINX metrics, query different domainnames in L (logs) from NGINX logs.

![image.png](../images/tag-10.png)

2. Modify specific view parameters

![image.png](../images/tag-11.png)

### 4 <<< custom_key.brand_name >>> - Display Data Per Service

![image.png](../images/tag-12.png)

![image.png](../images/tag-13.png)

**Similarly, different tags can be used to distinguish different projects, different owners, different business modules, different environments, etc. The specific capabilities of tags depend on your imagination.**

## Experiment Four: Confirm Specific Service Owner via Tag for Alert Notifications

### Background

As businesses grow, microservices and containers are widely used, increasing the number of service components and corresponding development and operations personnel. With finer divisions of labor, the best alert practice is to directly notify the responsible person when a business or IT system fails, thus improving alert closure efficiency. This can be achieved by sending alerts only to relevant individuals or assigning tickets in Jira. How does <<< custom_key.brand_name >>> handle this? In <<< custom_key.brand_name >>>, simply add a tag in specific observable inputs (unlimited tags supported), for example, adding a custom tag `owner = "xxx"` in `nginx-inputs`, then set owner as a variable in anomaly detection. Anomaly detection will automatically recognize this field and send notifications to DingTalk or WeCom groups, as shown below:

For example, add the following in the custom NGINX logs:

### 1 Add Tag in Inputs

![image.png](../images/tag-14.png)

### 2 Configure Anomaly Detection

![image.png](../images/tag-15.png)

### 3 Trigger Alert and View Alert Events

![lALPDiCpvp_bnqjNAyvNBeQ_1508_811.png](../images/tag-16.png)