# Jenkins Observability Best Practices
---

## Account Registration
Go to the official website [https://<<< custom_key.brand_main_domain >>>/](https://<<< custom_key.studio_main_site_auth >>>/) to register an account, and log in using your registered account/password.

![1631932979(1).png](../images/jenkins-1.png)

---

## Install DataKit

### Obtain the OpenWay Address Token 

Click on the 『Integration』 module, top-left 『DataKit』, and choose the appropriate installation command based on your operating system and system type.

![1631933996(1).png](../images/jenkins-2.png)
### Execute Installation
Copy the DataKit installation command and run it directly on the server that needs to be monitored.

- Installation directory /usr/local/datakit/

- Log directory /var/log/datakit/
- Main configuration file /usr/local/datakit/conf.d/datakit.conf
- Plugin configuration directory /usr/local/datakit/conf.d/

After DataKit is installed, Linux host common plugins are enabled by default. You can view them in DF ——Infrastructure——Built-in Views.

| Collector Name | Description |
| --- | --- |
| cpu | Collects CPU usage of the host |
| disk | Collects disk usage |
| diskio | Collects disk IO usage of the host |
| mem | Collects memory usage of the host |
| swap | Collects Swap memory usage |
| system | Collects operating system load of the host |
| net | Collects network traffic of the host |
| host_process | Collects long-running (surviving more than 10 minutes) process lists on the host |
| hostobject | Collects basic information about the host (such as OS information, hardware information, etc.) |
| docker | Collects possible container objects and container logs on the host |

Click on the [**Infrastructure**] module to view a list of all hosts with DataKit installed, along with basic information such as hostname, CPU, and memory.

![image.png](../images/jenkins-3.png)

## Monitoring Scenarios
### Create a New Scenario

Click on the 『Scenario』 module -> 『Create Scenario』

![1631934272(1).png](../images/jenkins-4.png)

### View Scenario Views
![image.png](../images/jenkins-5.png)



## Enable Jenkins Collection in DataKit

### Get Jenkins Access Keys

『Log into Jenkins』 -> 『System Management』 -> 『Plugin Management』 -> 『Available Plugins』 -> Input metrics, click Install without restart.

After installation, click 『System Management』 -> 『System Configuration』 -> Find Metrics, click the 『Generate...』 button on the right, then click 『Save』.

![image.png](../images/jenkins-7.png)
### Configure DataKit
Create a jenkins.conf file, modify the url to the Jenkins url, and set the key to the Metrics key.
```
$ cd /usr/local/datakit/conf.d/jenkins
$ cp jenkins.conf.sample jenkins.conf
$ vim jenkins.conf
```
![image.png](../images/jenkins-6.png)
### Restart DataKit

```
$ Datakit --restart
```

## Jenkins Related Introduction
### Jenkins Overview
Jenkins is the leader in open-source CI&CD software, providing over 1000 plugins to support building, deploying, and automating, meeting the needs of any project.
### Jenkins Performance Metrics

| Metric | Description | Data Type | Unit |
| --- | --- | --- | --- |
| executor_count | Number of valid builds | int | count |
| executor_free_count | Number of idle builds | int | count |
| executor_in_use_count | Number of builds currently executing | int | count |
| node_offline_count | Number of offline build nodes | int | count |
| node_online_count | Number of online build nodes | int | count |
| plugins_active | Number of successfully started plugins | int | count |
| plugins_failed | Number of failed plugin starts | int | count |
| project_count | Number of projects | int | count |
| job_count | Number of jobs | int | count |
| queue_blocked | Number of blocked jobs | int | count |
| queue_buildable | Number of buildable jobs | int | count |
| queue_pending | Number of pending jobs | int | count |
| queue_size | Number of jobs in the build queue | int | count |
| queue_stuck | Number of stuck jobs | int | count |
| system_cpu_load | Jenkins system load | float | % |
| vm_blocked_count | Number of blocked threads in Jenkins JVM | int | count |
| vm_count | Total number of threads in Jenkins JVM | int | count |
| vm_cpu_load | Jenkins CPU usage rate | float | % |
| vm_memory_total_used | Total memory used by Jenkins | int | Byte |