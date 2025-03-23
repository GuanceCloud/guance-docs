# Best Practices for RUM Data Reporting with DataKit Cluster

---

## Introduction

When using <<< custom_key.brand_name >>> for Real User Monitoring (RUM), if the website traffic is high, the performance cost of collecting user data by DataKit can be significant. In this case, it is necessary to use a DataKit cluster to collect RUM data and improve the performance of data reporting. Since the website uses the HTTPS protocol, we will deploy an HTTPS-enabled DataKit cluster using Alibaba Cloud's SLB (Server Load Balancer) to report the data.

## 1 Deploying DataKit

### 1.1 Linux Deployment of DataKit

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/), click on the 'Integration' module, then click 'DataKit' in the top-left corner, select 'Linux', and copy the command below to execute the installation command on a Linux server.

![1646965753(1).png](../images/rum-datakit-cluster-1.png)

Edit the `datakit.conf` file and change the value of `listen` to `"0.0.0.0:9529"` to enable remote access.

```
vi /usr/local/datakit/conf.d/datakit.conf
```

![1646966054(1).png](../images/rum-datakit-cluster-2.png)

Restart DataKit:

```
systemctl restart datakit
```

### 1.2 Kubernetes Deployment of DataKit

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/), click on the 'Integration' module, then click 'DataKit' in the top-left corner, select 'Kubernetes', and follow the instructions to install DataKit.

## 2 Configuring SLB

### 2.1 Create SLB

Log in to [Alibaba Cloud](https://ecs.console.aliyun.com/), go to 'Load Balancer SLB', create a traditional load balancer CLB, and name the instance "datakit-cluster".

![1646967195(1).png](../images/rum-datakit-cluster-3.png)

### 2.2 Create Virtual Server Group

Enter the newly created load balancer and click 'Create Virtual Server Group'.

![1646967382(1).png](../images/rum-datakit-cluster-4.png)

## 3 Enable RUM

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/), click on the 'Real User Monitoring' module, then click 'Create Application' named https-datakit.

![1646976064(1).png](../images/rum-datakit-cluster-5.png)

Copy the above JS code and paste it into the common `index.html` file's `<head>` section of your website to ensure that every page loads this js. Change `datakitOrigin` to the domain name bound during SLB certificate configuration.

![1646976229(1).png](../images/rum-datakit-cluster-6.png)

Parameter Description:

- `applicationId`: Application ID.
- `datakitOrigin`: DataKit address or domain name.
- `env`: Application environment, required.
- `version`: Application version, required.
- `allowedTracingOrigins`: Connect RUM with APM by configuring backend server addresses or domain names.


## 4 Real User Monitoring

Access the website using a browser. Then log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/), click on the 'Real User Monitoring' module, then click the https-datakit application to view the reported data.

![1646977682(1).png](../images/rum-datakit-cluster-7.png)