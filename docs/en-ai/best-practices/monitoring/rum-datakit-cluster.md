# Best Practices for RUM Data Reporting with DataKit Cluster

---

## Introduction

When using <<< custom_key.brand_name >>> for real user monitoring (RUM), if the website traffic is substantial, the performance overhead of collecting user data with DataKit can be significant. In this case, it's necessary to use a DataKit cluster to collect RUM data and improve the performance of data reporting. Since the website uses HTTPS protocol, we will deploy an HTTPS-based DataKit cluster using Alibaba Cloud's Load Balancer SLB for data reporting.

## 1 Deploy DataKit

### 1.1 Deploy DataKit on Linux

Log in to [<<< custom_key.brand_name >>>](https://console.guance.com/), click on the 'Integration' module, then click 'DataKit' in the top-left corner, select 'Linux', and copy the installation command to execute on your Linux server.

![1646965753(1).png](../images/rum-datakit-cluster-1.png)

Edit the `datakit.conf` file to change the `listen` value to `"0.0.0.0:9529"` to enable remote access.

```
vi /usr/local/datakit/conf.d/datakit.conf
```

![1646966054(1).png](../images/rum-datakit-cluster-2.png)

Restart DataKit:

```
systemctl restart datakit
```

### 1.2 Deploy DataKit on Kubernetes

Log in to [<<< custom_key.brand_name >>>](https://console.guance.com/), click on the 'Integration' module, then click 'DataKit' in the top-left corner, select 'Kubernetes', and follow the instructions to install DataKit.

## 2 Configure SLB

### 2.1 Create SLB

Log in to [Alibaba Cloud](https://ecs.console.aliyun.com/), go to 'Load Balancer SLB', and create a traditional load balancer CLB with the instance name "datakit-cluster".

![1646967195(1).png](../images/rum-datakit-cluster-3.png)

### 2.2 Create Virtual Server Group

Enter the newly created load balancer and click 'Create Virtual Server Group'.

![1646967382(1).png](../images/rum-datakit-cluster-4.png)

## 3 Enable RUM

Log in to [<<< custom_key.brand_name >>>](https://console.guance.com/), click on the 'User Analysis' module, then click 'Create Application' for https-datakit.

![1646976064(1).png](../images/rum-datakit-cluster-5.png)

Copy the provided JS code and paste it into the common `index.html` file's `<head>` section of your website to ensure every page loads this JS. Modify `datakitOrigin` to the domain name bound during SLB certificate configuration.

![1646976229(1).png](../images/rum-datakit-cluster-6.png)

Parameter Description:

- `applicationId`: Application ID.
- `datakitOrigin`: DataKit address or domain name.
- `env`: Application environment, required.
- `version`: Application version, required.
- `allowedTracingOrigins`: To connect RUM with APM, configure backend server addresses or domain names.

## 4 User Analysis

Access the website using a browser. Then log in to [<<< custom_key.brand_name >>>](https://console.guance.com/), click on the 'User Analysis' module, and click on the https-datakit application to view the reported data.

![1646977682(1).png](../images/rum-datakit-cluster-7.png)