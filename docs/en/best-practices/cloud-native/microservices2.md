# Service Mesh Microservices Architecture from Development to Canary Release Full Process Best Practices (Part 2)

---

## Introduction

The previous document introduced the deployment of DataKit in a Kubernetes environment, the deployment of the Bookinfo project in an Istio environment, the configuration of a CICD Pipeline for the reviews microservice, and the canary release of three versions of reviews. This article will introduce observability for Kubernetes and Istio.

## 1 Kubernetes Observability

### 1.1 Docker Monitoring View

In a Kubernetes cluster, a Pod is the smallest scheduling unit, and one Pod can contain one or more containers. In <<< custom_key.brand_name >>>, you can use the **Docker Monitoring View** to make containers observable.<br />        Log in to『[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)』, click on『Scenarios』->『Create Dashboard』, and select **Docker Monitoring View**.

![image](../images/microservices/23.png)

Fill in the dashboard name as **Docker Monitoring View1**, the name can be customized, and click on『Confirm』.
		
![image](../images/microservices/24.png)

Enter the monitoring view, and select the hostname and container name.

![image](../images/microservices/25.png)

### 1.2 Kubernetes Monitoring View

Log in to『[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)』, click on『Scenarios』->『Create Dashboard』, and select **Kubernetes Monitoring View**.

![image](../images/microservices/26.png)

Fill in the dashboard name as **Kubernetes Monitoring View**, the name can be customized, and click on『Confirm』.
		
![image](../images/microservices/27.png)

Enter the monitoring view, and select the cluster name and namespace.<br />『Note』The dropdown list for the cluster name was set up during the deployment of DataKit in the previous part.
		 
![image](../images/microservices/28.png)

![image](../images/microservices/29.png)

### 1.3 ETCD Monitoring View

#### 1.3.1 Enable ETCD Collector

In a Kubernetes cluster, enabling a collector requires using ConfigMap to define configurations, which are then mounted into the corresponding directory of DataKit. The content of etcd.conf is as follows:

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
          ## Exporter address or file path (Exporter address should include network protocol http or https)
          ## File paths vary across operating systems
          ## Windows example: C:\\Users
          ## UNIX-like example: /usr/local/
          urls = ["https://172.16.0.229:2379/metrics"]

          ## Collector alias
          source = "etcd"

          ## Metric type filtering, optional values are counter, gauge, histogram, summary
          # By default, only counter and gauge types of metrics are collected
          # If empty, no filtering will occur
          metric_types = ["counter", "gauge"]

          ## Metric name filtering
          # Supports regex, multiple can be configured, meaning any match suffices
          # If empty, no filtering will occur
          metric_name_filter = ["etcd_server_proposals","etcd_server_leader","etcd_server_has","etcd_network_client"]

          ## Measurement name prefix
          # Configure this item to add a prefix to measurement names
          measurement_prefix = ""

          ## Measurement name
          # By default, the metric name will be split by underscore "_", the first field after splitting becomes the measurement name, and the remaining fields become the current metric name
          # If measurement_name is configured, the metric name will not be split
          # The final measurement name will have the measurement_prefix prefix added
          # measurement_name = "prom"

          ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
          interval = "60s"

          ## Filter tags, multiple tags can be configured
          # Matching tags will be ignored
          # tags_ignore = ["xxxx"]

          ## TLS Configuration
          tls_open = true
          #tls_ca = "/etc/kubernetes/pki/etcd/ca.crt"
          tls_cert = "/etc/kubernetes/pki/etcd/peer.crt"
          tls_key = "/etc/kubernetes/pki/etcd/peer.key"

          ## Custom measurement name
          # Metrics with the prefix prefix can be grouped into one category of measurements
          # Custom measurement name configuration takes precedence over measurement_name configuration items
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

Log in to『Rancher』, under the browse cluster label, select the『k8s-solution-cluster』cluster, sequentially enter『More Resources』-> 『Core』-> 『ConfigMaps』, choose the datakit space, click on『Edit Configuration』in the datakit.conf row, click on『Add』, add the etcd.conf configuration, then click on『Save』.
		
![image](../images/microservices/30.png)

![image](../images/microservices/31.png)

Log in to『Rancher』, under the browse cluster label, select the『k8s-solution-cluster』cluster, sequentially enter『Workloads』-> 『DaemonSets』, choose the datakit workspace, click on『Edit Configuration』on the right side in the datakit column. 
	  
![image](../images/microservices/32.png)

Enter the **Storage** interface, add the mounted directory /usr/local/datakit/conf.d/etcd/etcd.conf for etcd.conf, then click on『Save』
		
![image](../images/microservices/33.png)     

#### 1.3.2 Mount Certificate Files

To collect etcd metrics using https, Kubernetes cluster certificates are required. That is, the /etc/kubernetes/pki/etcd directory deployed by Kubeadmin needs to be mounted to the /etc/kubernetes/pki/etcd directory of DataKit.

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

Below, complete the configuration using Rancher. Log in to『Rancher』, under the browse cluster label, select the『k8s-solution-cluster』cluster, sequentially enter『Workloads』-> 『DaemonSets』, choose the datakit workspace, click on『Edit YAML』on the right side in the datakit column.
		
![image](../images/microservices/34.png)

Add the content shown in the figure below, then click on Save.
		 
![image](../images/microservices/35.png)

![image](../images/microservices/36.png)


#### 1.3.3 Achieve ETCD Observability

Log in to『[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)』, click on『Scenarios』->『Create Dashboard』, and select **ETCD Monitoring View**.

Fill in the dashboard name as **ETCD Monitoring View**, the name can be customized, and click on『Confirm』.
		 
![image](../images/microservices/37.png)

Enter the monitoring view, and select the cluster name.
		 
![image](../images/microservices/38.png)

For more information about ETCD integration methods, please refer to the [ETCD](../../integrations/container/etcd.md) Integration Documentation.

## 2 Istio Observability

### 2.1 Istio Mesh Monitoring View

Log in to『[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)』, click on『Scenarios』->『Create Dashboard』, and select **Istio Mesh Monitoring View**.
		
![image](../images/microservices/39.png)

Fill in the dashboard name as **Istio Mesh Monitoring View**, the name can be customized, and click on『Confirm』.
		
![image](../images/microservices/40.png)

Enter the monitoring view, and select the cluster name.
		 
![image](../images/microservices/41.png)

![image](../images/microservices/42.png)


### 2.2 Istio Control Plane Monitoring View

Log in to『[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)』, click on『Scenarios』->『Create Dashboard』, and select **Istio Control Plane Monitoring View**.
		 
![image](../images/microservices/43.png)

Enter the monitoring view, and select the cluster name.
		 
![image](../images/microservices/44.png)

![image](../images/microservices/45.png)

![image](../images/microservices/46.png)

### 2.3 Istio Service Monitoring View

Log in to『[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)』, click on『Scenarios』->『Create Dashboard』, and select **Istio Service Monitoring View**.

![image](../images/microservices/47.png)

Enter the monitoring view, and select the cluster name.

![image](../images/microservices/48.png)

![image](../images/microservices/49.png)

### 2.4 Istio Workload Monitoring View

Log in to『[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)』, click on『Scenarios』->『Create Dashboard』, and select **Istio Workload Monitoring View**.
		 
![image](../images/microservices/50.png)

Enter the monitoring view, and select the cluster name.
		 
![image](../images/microservices/51.png)

![image](../images/microservices/52.png)

![image](../images/microservices/53.png)