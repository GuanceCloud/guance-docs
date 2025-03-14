# Quick Start
---

## Step 1: Register and Login to the Account {#step-1}

Enter [Guance official site](https://en.guance.com/) and refer to [Registration Guide](../billing/commercial-register.md) to become Guance users.

## Step 2: Install DataKit {#step-2}

[DataKit](../datakit/datakit-arch.md) is an official data collection application released by Guance, which supports the collection of hundreds of kinds of data, and can collect a variety of data such as host, process, container, log, application performance and user access in real time.

After the account registration is successful, log in to the [Guance studio](https://auth.guance.com/en/) to start the installation.

???+ info "Example"

    Here, take the example of installing DataKit on Linux host. 
    
    > For more details, please refer to the documentation [Host Install DataKit](../datakit/datakit-install.md) and [K8s Install DataKit](../datakit/datakit-daemonset-deploy.md).

### 1. Get the installation command

Log in to studio, click **Integrations** on the left, and select **DataKit** at the top to see the installation commands of various platforms.

![](img/getting-guance-1.png)

### 2. Execute the install command

Copy the corresponding installation command and execute it. If the installation is successful, you will see the following prompt on the terminal.

![](img/getting-guance-2.png)

### 3. View the running status

<div class="grid" markdown>

=== ":material-numeric-1-circle-outline: View in Guance"

    Enter the studio and click **Infrastructure** on the left to view the list of hosts with DataKit installed.

    ![](img/getting-guance-3.png)

=== ":material-numeric-2-circle-outline: View in Terminal"

    > More reading: [DataKit Service Management](../datakit/datakit-service-how-to.md), [DataKit Status Query](../datakit/datakit-monitor.md) and [DataKit Troubleshooting](../datakit/why-no-data.md).

    Execute the following command to get the basic operation of the native DataKit.

    ```
    datakit monitor
    ```

    ![基础Monitor信息展示](https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/images/datakit/monitor-basic-v1.gif) 

</div>

## Step 3: Start Guance {#step-3}

After the datakit is successfully installed, [a batch of data metrics collectors are turned on by default](../datakit/datakit-input-conf.md#default-enabled-inputs) without having to be turned on manually. According to the collected data metrics, Guance has various functions to help you observe.

### [Infrastructure](../infrastructure/index.md)

Guance supports collecting object data including hosts, cloud hosts, containers, processes and other cloud services and actively reporting them to the workspace.

![](img/getting-guance-6.png)

### [Scenes](../scene/index.md)

In Guance, you can build **Scenes** that satisfy different businesses from different perspectives, including dashboards, notes and explorers.

<u>Take adding a Linux dashboard here as an example:</u>

<div class="grid" markdown>

=== ":material-numeric-1-circle-outline: Add Dashboards"

    Click **Scenes** on the left, click **Dashboards > Create** in turn, search for **Linux** in **System View**, select `Host Overview _ Linux Monitoring View` and click **Confirm** to add it.

    ![](img/getting-guance-4.png)

=== ":material-numeric-2-circle-outline: View Dashboards"

    System view is a standard template provided by Guance, which helps users intuitively track, analyze and display key performance metrics and monitor the overall performance. Click **[Add Charts](../scene/visual-chart/index.md)** to customize the addition of a variety of visual charts.

    ![](img/getting-guance-5.png)

</div>


### [Metrics](../metrics/index.md)

Guance has the ability of collecting global data, and the metric data obtained by the collector will be automatically reported to the studio. You can analyze and manage the metric data in space uniformly through **Metrics**.

<div class="grid" markdown>

=== ":material-numeric-2-circle-outline: Metric Analysis"
    Metric Analysis can query and analyze metrics and other data types (Logs, basic objects, custom objects, events, APM, RUM, Security Check, network, Profile, etc.).

    The following example shows a comparative analysis of CPU utilization of different host ip in the current workspace in the last 15 minutes.

    ![](img/getting-guance-8.png)

=== ":material-numeric-1-circle-outline: Metric Management"
    You can view all the metrics reported to the workspace, the number of timelines and data storage policy information.

    ![](img/getting-guance-7.png)


</div>

### [Monitors](../monitoring/index.md)

Guance has powerful anomaly monitoring capability, which not only provides a series of monitoring templates including Docker, ElasticSearch and Host, but also supports custom monitors. With the alarm notification function, it can find problems in time to help you quickly find, locate and solve problems.

<div class="grid" markdown>

=== ":material-numeric-1-circle-outline: Create Monitors"

    In **Monitors**, you can choose **Create** or **Import template**.

    ![](img/getting-guance-9.png)

=== ":material-numeric-2-circle-outline: Configure Monitor Information"

    The following example shows that in the current workspace, once every 1 minute, whether there is the maximum memory utilization value of a host ip in the past 15 minutes triggers different levels of threshold detection conditions.

    ![](img/getting-guance-10.png)

=== ":material-numeric-3-circle-outline: Configure Alarm Policy and Notification Object"

    If it is necessary to send alarm information to a specific notification object when the monitor triggers the condition, relevant configuration can be carried out in the corresponding module.

    ![](img/getting-guance-11.png)

    ![](img/getting-guance-12.png)

</div>

### [Billing](../billing/index.md)

In **Billing**, you can view the plan information, usage statistics, billing list and other information of the current workspace.

The following figure shows the <u>perspective of the owner of the commercial workspace</u>:

![](img/12.billing_1.png)


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Feature Guide: Learn More Operation Tips</font>](./function-details/explorer-search.md)

<br/>

</div>

## Advanced Settings

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **DataKit Collector: Middleware, APM, LOG, etc**</font>](../datakit/datakit-input-conf.md)

</div>




<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **DQL: Query Language through Guance**</font>](../dql/query.md)

</div>

