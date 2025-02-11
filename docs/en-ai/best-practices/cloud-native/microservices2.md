# Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 2)

---

## Introduction

The previous document introduced the deployment of DataKit in a Kubernetes environment, the deployment of the Bookinfo project in an Istio environment, configuring a CICD Pipeline for the reviews microservice, and using canary release for three versions of reviews. This article will cover observability in Kubernetes and Istio.

## 1 Observability in Kubernetes

### 1.1 Docker Monitoring View

In a Kubernetes cluster, a Pod is the smallest scheduling unit, and it can contain one or more containers. In Guance, you can use the **Docker Monitoring View** to monitor these containers.  
Log in to [Guance](https://console.guance.com/), click on **Scenarios** -> **Create Dashboard**, and select **Docker Monitoring View**.

![image](../images/microservices/23.png)

Name the dashboard **Docker Monitoring View 1**; you can customize this name. Click **Confirm**.
		
![image](../images/microservices/24.png)

Enter the monitoring view and select the hostname and container name.

![image](../images/microservices/25.png)

### 1.2 Kubernetes Monitoring View

Log in to [Guance](https://console.guance.com/), click on **Scenarios** -> **Create Dashboard**, and select **Kubernetes Monitoring View**.

![image](../images/microservices/26.png)

Name the dashboard **Kubernetes Monitoring View**; you can customize this name. Click **Confirm**.
		
![image](../images/microservices/27.png)

Enter the monitoring view and select the cluster name and namespace. **Note** that the cluster name dropdown is set during the DataKit deployment in the previous document.
		 
![image](../images/microservices/28.png)

![image](../images/microservices/29.png)

### 1.3 ETCD Monitoring View

#### 1.3.1 Enabling ETCD Collector

In a Kubernetes cluster, enabling collectors requires defining configurations using ConfigMap and then mounting them to the corresponding DataKit directory. The content of `etcd.conf` is as follows:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    #### etcd
    etcd.conf: |-    
        [[inputs.prom]]
          ## Exporter address or file path (include network protocol http or https)
          ## File paths differ across operating systems
          ## Windows example: C:\\Users
          ## UNIX-like example: /usr/local/
          urls = ["https://172.16.0.229:2379/metrics"]

          ## Collector alias
          source = "etcd"

          ## Metric type filtering, optional values are counter, gauge, histogram, summary
          # By default, only counter and gauge types are collected
          # If empty, no filtering is applied
          metric_types = ["counter", "gauge"]

          ## Metric name filtering
          # Supports regex, multiple can be configured, satisfying any one is sufficient
          # If empty, no filtering is applied
          metric_name_filter = ["etcd_server_proposals","etcd_server_leader","etcd_server_has","etcd_network_client"]

          ## Measurement name prefix
          # Configuring this adds a prefix to the measurement name
          measurement_prefix = ""

          ## Measurement name
          # By default, the metric name is split by underscore "_", with the first field as the measurement name and the rest as the current metric name
          # If measurement_name is configured, no splitting occurs
          # The final measurement name will include the measurement_prefix prefix
          # measurement_name = "prom"

          ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
          interval = "60s"

          ## Filtering tags, multiple tags can be configured
          # Matching tags will be ignored
          # tags_ignore = ["xxxx"]

          ## TLS configuration
          tls_open = true
          #tls_ca = "/etc/kubernetes/pki/etcd/ca.crt"
          tls_cert = "/etc/kubernetes/pki/etcd/peer.crt"
          tls_key = "/etc/kubernetes/pki/etcd/peer.key"

          ## Custom measurement names
          # Metrics with a prefix can be grouped into one measurement
          # Custom measurement name configuration takes precedence over measurement_name
          [[inputs.prom.measurements]]
            prefix = "etcd_"
            name = "etcd"

          ## Custom authentication method, currently only supports Bearer Token
          # [inputs.prom.auth]
          # type = "bearer_token"
          # token = "xxxxxxxx"
          # token_file = "/tmp/token"

          ## Custom Tags


```

Log in to **Rancher**, under the browse clusters tab, select the **k8s-solution-cluster** cluster, navigate sequentially into **More Resources** -> **Core** -> **ConfigMaps**, choose the datakit namespace, click on the **Edit Configuration** button next to the datakit.conf row, click **Add**, add the etcd.conf configuration, and click **Save**.
		
![image](../images/microservices/30.png)

![image](../images/microservices/31.png)

Log in to **Rancher**, under the browse clusters tab, select the **k8s-solution-cluster** cluster, navigate sequentially into **Workloads** -> **DaemonSets**, choose the datakit workspace, click **Edit Configuration** next to the datakit column. 
	  
![image](../images/microservices/32.png)

Go to the **Storage** interface, add the mount directory `/usr/local/datakit/conf.d/etcd/etcd.conf`, and click **Save**.
		
![image](../images/microservices/33.png)     

#### 1.3.2 Mounting Certificate Files

To collect ETCD metrics using HTTPS, Kubernetes cluster certificates are required. Specifically, the `/etc/kubernetes/pki/etcd` directory from the Kubeadmin-deployed cluster should be mounted to the `/etc/kubernetes/pki/etcd` directory in DataKit.

```yaml
      volumes:
      - hostPath:
          path: /etc/kubernetes/pki/etcd
        name: dir-etcd
```

```yaml
          volumeMounts:
          - mountPath: /etc/kubernetes/pki/etcd
          name: dir-etcd   
```

Below, we complete the configuration using Rancher. Log in to **Rancher**, under the browse clusters tab, select the **k8s-solution-cluster** cluster, navigate sequentially into **Workloads** -> **DaemonSets**, choose the datakit workspace, click **Edit YAML** next to the datakit column.
		
![image](../images/microservices/34.png)

Add the content as shown in the figure, then click **Save**.
		 
![image](../images/microservices/35.png)

![image](../images/microservices/36.png)


#### 1.3.3 Achieving ETCD Observability

Log in to [Guance](https://console.guance.com/), click on **Scenarios** -> **Create Dashboard**, and select **ETCD Monitoring View**.

Name the dashboard **ETCD Monitoring View**; you can customize this name. Click **Confirm**.
		 
![image](../images/microservices/37.png)

Enter the monitoring view and select the cluster name.
		 
![image](../images/microservices/38.png)

For more information on ETCD integration methods, please refer to the [ETCD](../../integrations/container/etcd.md) integration documentation.

## 2 Observability in Istio

### 2.1 Istio Mesh Monitoring View

Log in to [Guance](https://console.guance.com/), click on **Scenarios** -> **Create Dashboard**, and select **Istio Mesh Monitoring View**.
		
![image](../images/microservices/39.png)

Name the dashboard **Istio Mesh Monitoring View**; you can customize this name. Click **Confirm**.
		
![image](../images/microservices/40.png)

Enter the monitoring view and select the cluster name.
		 
![image](../images/microservices/41.png)

![image](../images/microservices/42.png)


### 2.2 Istio Control Plane Monitoring View

Log in to [Guance](https://console.guance.com/), click on **Scenarios** -> **Create Dashboard**, and select **Istio Control Plane Monitoring View**.
		 
![image](../images/microservices/43.png)

Enter the monitoring view and select the cluster name.
		 
![image](../images/microservices/44.png)

![image](../images/microservices/45.png)

![image](../images/microservices/46.png)

### 2.3 Istio Service Monitoring View

Log in to [Guance](https://console.guance.com/), click on **Scenarios** -> **Create Dashboard**, and select **Istio Service Monitoring View**.

![image](../images/microservices/47.png)

Enter the monitoring view and select the cluster name.

![image](../images/microservices/48.png)

![image](../images/microservices/49.png)

### 2.4 Istio Workload Monitoring View

Log in to [Guance](https://console.guance.com/), click on **Scenarios** -> **Create Dashboard**, and select **Istio Workload Monitoring View**.
		 
![image](../images/microservices/50.png)

Enter the monitoring view and select the cluster name.
		 
![image](../images/microservices/51.png)

![image](../images/microservices/52.png)

![image](../images/microservices/53.png)