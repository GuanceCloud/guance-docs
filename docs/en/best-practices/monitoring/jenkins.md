# Jenkins Observability Best Practices
---

## Account Registration
Go to the official website [https://guance.com/](https://auth.guance.com/) to register an account, and log in using your registered account/password.

![1631932979(1).png](../images/jenkins-1.png)

---

## Install DataKit

### Obtain the OpenWay Address Token 

Click on the『Integration』module, then『DataKit』in the top left corner. Choose the appropriate installation command based on your operating system and type.

![1631933996(1).png](../images/jenkins-2.png)
### Execute Installation
Copy the DataKit installation command and run it directly on the server you wish to monitor.

- Installation directory: `/usr/local/datakit/`
- Log directory: `/var/log/datakit/`
- Main configuration file: `/usr/local/datakit/conf.d/datakit.conf`
- Plugin configuration directory: `/usr/local/datakit/conf.d/`

After DataKit is installed, common Linux host plugins are enabled by default. You can view them in DF —— Infrastructure —— Built-in Views.

| Collector Name | Description |
| --- | --- |
| cpu | Collects CPU usage of the host |
| disk | Collects disk usage |
| diskio | Collects disk IO statistics of the host |
| mem | Collects memory usage of the host |
| swap | Collects swap memory usage |
| system | Collects operating system load |
| net | Collects network traffic statistics of the host |
| host_process | Collects a list of resident processes (alive for more than 10 minutes) on the host |
| hostobject | Collects basic information about the host (such as OS and hardware details) |
| docker | Collects container objects and logs from Docker |

Click on the [**Infrastructure**] module to view the list of all hosts with installed DataKit along with basic information such as hostname, CPU, memory, etc.

![image.png](../images/jenkins-3.png)

## Monitoring Scenarios
### Create a New Scenario

Click on the『Scenarios』module ->『Create』

![1631934272(1).png](../images/jenkins-4.png)

### View Scenario Views
![image.png](../images/jenkins-5.png)

## Enable Jenkins Collection in DataKit

### Obtain Jenkins Access Keys

『Log in to Jenkins』->『Manage Jenkins』->『Manage Plugins』->『Available』-> Enter "metrics" and click Install without restart.

After installation, go to『Manage Jenkins』->『Configure System』-> Find Metrics and click『Generate...』on the right side, then click『Save』.

![image.png](../images/jenkins-7.png)
### Configure DataKit
Create the `jenkins.conf` file and modify the URL to your Jenkins URL and the key to the Metrics key.
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

## Jenkins Overview
### Jenkins Introduction
Jenkins is the leader in open-source CI/CD software, providing over 1000 plugins to support building, deploying, and automating to meet the needs of any project.
### Jenkins Performance Metrics

| Metric | Description | Data Type | Unit |
| --- | --- | --- | --- |
| executor_count | Number of active builds | int | count |
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
| vm_cpu_load | Jenkins CPU usage | float | % |
| vm_memory_total_used | Total memory used by Jenkins | int | Byte |