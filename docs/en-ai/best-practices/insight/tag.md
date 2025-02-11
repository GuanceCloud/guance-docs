# Best Practices for TAGs in Guance

---

This document is intended to spark imagination and encourage users to create their own unique tag usage scenarios.

## Preface

The **Opentelemetry Protocol**, defined by the **CNCF (Cloud Native Computing Foundation)**, represents the latest generation of **observability specifications** (currently still in incubation). This specification defines the three pillars of observability: **metrics, trace, log (indicators, traces, logs)**. However, if these three pillars are merely collected without correlation, how does this so-called observability differ from traditional monitoring tools (APM, logs, Zabbix, etc.)? Is it just a collection of monitoring tools? Therefore, this leads to an important concept: **TAG (tag)**. For example, a traceID that connects front-end and back-end can be considered a tag, as can a host that initially correlates metrics, traces, and logs. Other examples include project, environment, version numbers, etc., all of which are tags!

In summary, **using TAGs can achieve data correlation and enable more customized observability practices**, making them crucial. In Guance's current architecture, all observable items support tag settings, with theoretically no upper limit on the number of tags.

For example, in real life, job hunting or HR recruitment often have specific requirements such as programming skills, computer knowledge, a bachelor’s degree, years of experience, etc. These requirements are like tags, and only candidates who meet these tags can get the position. Similarly, in IT systems, servers running specific applications, databases, environments, and responsible persons can be tagged. When issues arise, if there are enough tags, it can quickly identify problematic servers, affected services, and responsible components, enabling rapid problem resolution.

This article will use four examples to demonstrate the extensibility and versatility of tags in Guance.

## Experiment One: Grouping Servers

### Background

Companies often have **multiple project teams or divisions**. Each team or division uses its own infrastructure for business development. If all infrastructure and applications are integrated into Guance for observability, besides using separate workspaces, what other methods can distinguish project resources?

Certainly, Guance considered this scenario during its design phase. The default DataKit main configuration file includes a `global_tag` label, which sets tags at the infrastructure level. Components on this infrastructure, such as applications and databases, will automatically inherit this tag.

### 1 Modify datakit-inputs and configure global_tag

```bash
$ vim /usr/local/datakit/conf.d/datakit.conf

# Add tags under global_tags, in addition to the default three, you can add other tags

[global_tags]
cluster = ""
project = "solution"
site = ""
```

![image.png](../images/tag-1.png)

Similarly, all related hosts' DataKits can be configured with these tags.

### 2 View Server Groups in Guance

![image.png](../images/tag-2.png)

## Experiment Two: Modifying DataKit Recognized Hostname

### Background

DataKit defaults to collecting the hostname at the host level and uses the recognized hostname as a global tag to correlate all metrics, traces, logs, and objects. However, in many enterprise environments, hostnames are random strings with no practical meaning. Additionally, changing the hostname might affect application connections or database management, leading companies to avoid modifying hostnames due to potential risks. To address this, DataKit provides the built-in `ENV_HOSTNAME` setting.

???+ warning
    **Note:** After applying this method, data from the new hostname will be re-uploaded, and data from the original hostname will no longer be updated.
    **Recommendation:** If you need to change the hostname, it is best to do so during the initial installation of DataKit.

### 1 Modify datakit-inputs and configure [environments]

```bash
$ vim /usr/local/datakit/conf.d/datakit.conf

# Modify ENV_HOSTNAME in [environments] to a recognizable hostname

[environments]
ENV_HOSTNAME = "118.178.57.79"
```

![image.png](../images/tag-3.png)

### 2 Compare Data Before and After Changes in Guance

![image.png](../images/tag-4.png)

## Experiment Three: Nginx Log Statistics Displayed Per Service

### Background

Nginx within enterprises typically handles domain forwarding or service forwarding. Often, nginx forwards frontend requests to multiple backend subdomains or different port services, or directly serves multiple domains. Unified nginx monitoring cannot satisfy these needs. How does Guance solve this problem?

**Scenario**: Nginx exposes ports 18889 and 80, forwarding to internal server 118.178.57.79 on ports 8999 and 18999 respectively.

**Requirement**: Statistically analyze data for nginx ports 18889 and 80, such as PV, UV, and error counts.

**Prerequisite**: Nginx access logs for ports 80 and 18889 are configured in different directories (or named differently).

| Directory for 80 Port Logs | /var/log/nginx/80/    |
| -------------------------- | --------------------- |
| Directory for 18889 Port Logs | /var/log/nginx/18999/ |

![image.png](../images/tag-5.png)

### 1 Configure Nginx Performance Metrics Monitoring

> Refer to the integration documentation <[Nginx](../../integrations/nginx.md)> for detailed configuration.

1. Enable the `nginx.conf` performance metrics module

Check if the `http_stub_status_module` is enabled in nginx.

(This example already has it enabled.)

![image.png](../images/tag-6.png)

2. Add `nginx_status` location forwarding in `nginx.conf`

```nginx
server {
    listen 80;
    server_name localhost;

    location /nginx_status {
        stub_status on;
        allow 127.0.0.1;
        deny all;
    }
}
```

![image.png](../images/tag-7.png)

3. Execute `nginx -s reload` to reload nginx.

4. Enable `nginx.inputs` in DataKit

```bash
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf
```

5. Modify the following content

```toml
[[inputs.nginx]]
url = "http://localhost/nginx_status"
```

![image.png](../images/tag-8.png)

6. Save the `nginx.conf` file and restart DataKit

```bash
$ service datakit restart
```

### 2 Configure Log Monitoring for Services on Ports 80 and 18889

```bash
$ cd /usr/local/datakit/conf.d/log/
$ cp logging.conf.sample nginx80.conf

$ vim nginx80.conf

## Modify log paths to correct application log paths
## source, service, pipeline are required fields, can use application names to distinguish different log names
## Add tag domainname

## Modify as follows:
[[inputs.logging]]

logfiles = ["/var/log/nginx/80/access.log", "/var/log/nginx/80/error.log"]

source = "nginx"

service = "nginx"

pipeline = "nginx.p"

[inputs.logging.tags]

domainname = "118.178.226.149:80"
```

```bash
$ cd /usr/local/datakit/conf.d/log/
$ cp logging.conf.sample nginx18889.conf
$ vim nginx18889.conf

## Modify log paths to correct application log paths
## source, service, pipeline are required fields, can use application names to distinguish different log names
## Add tag domainname

## Modify as follows:
[[inputs.logging]]

logfiles = ["/var/log/nginx/18889/access.log", "/var/log/nginx/18889/error.log"]

source = "nginx"

service = "nginx"

pipeline = "nginx.p"

[inputs.logging.tags]

domainname = "118.178.226.149:18889"
```

![image.png](../images/tag-9.png)

### 3 Configure Custom Views (Distinguish Domains via Tags)

**Steps**: Login to Guance - 「Scene」 - 「Create New Scene」 - 「Create Blank Scene」 - 「System View」 (Create NGINX)

**Key Point**: Modify nginx view-related configurations in the system template.

1. Enter view editing mode, click 「Modify View Variables」 - 「Add View Variable」

```
L::nginx:(distinct(`domainname`)){host='#{host}'}
```

> **Explanation**: Inherit the host from nginx metrics and query different domainnames in L (logs) of nginx logs.

![image.png](../images/tag-10.png)

2. Modify specific view parameters

![image.png](../images/tag-11.png)

### 4 View Data Display per Service in Guance

![image.png](../images/tag-12.png)

![image.png](../images/tag-13.png)

**Similarly, different tags can be used to distinguish different projects, responsible persons, business modules, environments, etc. The capability of tags depends on your imagination.**

## Experiment Four: Confirming Service Owners via Tags for Alert Notifications

### Background

As businesses grow, microservices and containers are widely adopted, increasing the number of service components and development and operations personnel. Divisions become finer, and when business or IT systems fail, the best alert practice is to directly notify the responsible personnel to improve the efficiency of closing alerts. Common methods include sending alerts only to relevant individuals or assigning Jira tickets. How does Guance operate?

In Guance, simply add custom tags to specific observable inputs (with theoretically unlimited tag support), such as adding a custom tag `owner = "xxx"` in `nginx-inputs`. Then, set owner as a variable in anomaly detection, allowing automatic recognition and sending notifications to DingTalk or corporate WeChat groups. The effect is as follows:

For example, add the following in the aforementioned nginx custom logs:

### 1 Add Tags in Inputs

![image.png](../images/tag-14.png)

### 2 Configure Anomaly Detection

![image.png](../images/tag-15.png)

### 3 Trigger Alerts and View Alert Events

![lALPDiCpvp_bnqjNAyvNBeQ_1508_811.png](../images/tag-16.png)