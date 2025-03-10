# Nginx Ingress Observability Best Practices

---

## Introduction

Kubernetes provides a Layer 4 proxy to access applications deployed in Pods. This type of Service with a Layer 4 proxy, Kubernetes offers four ways to access services:

1. ClusterIP: Available for other applications within the cluster, not accessible externally.
2. NodePort: Opens a specified port on all nodes, external access can be achieved via IP+port. If no specific NodePort port is defined, it defaults to randomly assigning a port between 30000–32767.
3. LoadBalancer: On top of NodePort, using a load balancer provided by cloud service providers to forward traffic to the service.
4. ExternalName: By returning a CNAME and its value, you can map the service to the content of the externalName field.

None of these four methods allow access to applications within the cluster via domain names. To access applications deployed in Kubernetes through a domain name, the simplest way is to deploy a Layer 7 proxy like Nginx in the cluster, which forwards requests to the corresponding Service based on the domain name. When new deployments occur, the Nginx configuration needs to be updated. To ensure that updates to the configuration do not affect other applications, Ingress was introduced.

![image](../images/ingress-nginx-1.png)

Ingress can forward HTTP and HTTPS requests to internal services within the Kubernetes cluster, ultimately accessing the backend Pods of the Service. It can provide external accessible URLs for Services, balance traffic, and offer virtual hosting based on domain names.

![image](../images/ingress-nginx-2.png)

Ingress consists of two main components: Ingress Controller and Ingress. Common Ingresses include Traefik Ingress and Nginx Ingress. This article uses Nginx Ingress as an example. The Ingress Controller interacts with the Kubernetes API to dynamically detect changes in Ingress service rules within the Kubernetes cluster, then reads these rules and forwards them to the corresponding Services according to the Ingress rules. Ingress configures these rules, specifying which domain corresponds to which Service in the Kubernetes cluster. Based on the Nginx configuration template in the Ingress Controller, a corresponding Nginx configuration is generated. The Ingress Controller dynamically loads these configurations and writes them into the Nginx service running inside the Ingress Controller Pod, then reloads to make the configuration effective.

For Kubernetes clusters with deployed Ingress, it becomes very important to observe resources such as CPU usage, memory consumption, configuration file loading, and forwarding success rate of the Ingress Controller.

**Ingress Working Principle:**

1. A client initiates a request to [http://myNginx.com](http://mynginx.com).
2. The client's DNS server returns the IP address of the Ingress controller.
3. The client sends an HTTP request to the Ingress controller, specifying [myNginx.com](http://mynginx.com) in the Host header.
4. Upon receiving the request, the controller determines which service the client is trying to access from the headers, checks the pod's IP via the endpoint object associated with that service.
5. The client's request is forwarded to the specific pod for processing.

![image](../images/ingress-nginx-3.png)

## Prerequisites

- [Install Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/)
- Install DataKit: Log in to the [<<< custom_key.brand_name >>> Console](https://console.guance.com/), click 「Integration」 - 「DataKit」 - 「Kubernetes」

### Deploy Ingress

In production environments, it is recommended to deploy Ingress using DaemonSet and set `hostNetwork` to `true`, allowing Nginx to directly use the host network, then access Ingress via a load balancer provided by the cloud provider.

#### 1 Download deploy.yaml

```shell
wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/baremetal/deploy.yaml
```

#### 2 Edit deploy.yaml

##### 2.1 Replace Images

Replace the images used in the `deploy.yaml` file with the following images:

```
registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-ingress-controller:v1.1.1
registry.cn-hangzhou.aliyuncs.com/google_containers/kube-webhook-certgen:v1.1.1
```

##### 2.2 Modify Deployment Resource File

Find the kind: Deployment section and modify it as follows:

```yaml
kind: DaemonSet # Modified

---
hostNetwork: true # Added
dnsPolicy: ClusterFirstWithHostNet # Modified
```

```shell
kubectl apply -f deploy.yaml
```

## Metrics Collection

### Enable Input

To collect Ingress metrics data in <<< custom_key.brand_name >>>, you need to enable the prom plugin in DataKit and specify the exporter's URL in the prom plugin configuration. For collecting Ingress Controller metrics in a Kubernetes cluster, it is recommended to add annotations using annotations. Open the deploy.yaml file where Ingress is deployed, find the DaemonSet section modified in the previous step, and add annotations.

```yaml
annotations:
  datakit/prom.instances: |
    [[inputs.prom]]
      url = "http://$IP:10254/metrics"
      source = "prom-ingress"
      metric_types = ["counter", "gauge", "histogram"]
      # metric_name_filter = ["cpu"]
      # measurement_prefix = ""
      measurement_name = "prom_ingress"
      interval = "60s"
      tags_ignore = ["build","le","path","method","release","repository"]
      metric_name_filter = ["nginx_process_cpu_seconds_total","nginx_process_resident_memory_bytes","request_size","response_size","requests","success","config_last_reload_successful"]
      [[inputs.prom.measurements]]
        prefix = "nginx_ingress_controller_"
        name = "prom_ingress"
      [inputs.prom.tags]
      namespace = "$NAMESPACE"
```

![image](../images/ingress-nginx-4.png)

Parameter Explanation

- url: Exporter URLs, multiple URLs are separated by commas, e.g., ["[http://127.0.0.1:9100/metrics",](http://127.0.0.1:9100/metrics",) "[http://127.0.0.1:9200/metrics"]](http://127.0.0.1:9200/metrics"])
- source: Collector alias.
- metric_types: Metric types, options are counter, gauge, histogram, summary.
- measurement_name: Measurement set name.
- interval: Collection frequency.
- inputs.prom.measurements: Metrics with the specified prefix are grouped into the named measurement set.
- tags_ignore: Ignored tags.
- metric_name_filter: Filters metrics, only collecting necessary items.

Annotations support the following wildcards:

- `$NAMESPACE`: Pod Namespace

### Restart Ingress Controller

```shell
kubectl delete -f deploy.yaml
kubectl apply -f deploy.yaml
```

### Demonstration Case

Write the deployment file for Nginx `nginx-deployment.yaml`

??? quote "`nginx-deployment.yaml`"

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      selector:
        matchLabels:
          app: backend
      replicas: 1
      template:
        metadata:
          labels:
            app: backend
        spec:
          # nodeName: df-k8s-node2
          containers:
            - name: nginx
              image: nginx:latest
              resources:
                limits:
                  memory: "128Mi"
                  cpu: "128m"
              ports:
                - containerPort: 80

    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: nginx-service
    spec:
      selector:
        app: backend
      ports:
        - port: 80
          targetPort: 80
    ```

Write the corresponding `nginx-ingress.yaml`, based on this rule, if the domain is mynginx.com, it will forward to the Nginx - Service Service.

??? quote "`nginx-ingress.yaml`"

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: nodeport-ingress
      namespace: default
    spec:
      rules:
        - host: mynginx.com
          http:
            paths:
              - pathType: Prefix
                path: /
                backend:
                  service:
                    name: nginx-service
                    port:
                      number: 80
    ```

Deployment Example

```shell
kubectl apply -f  nginx-deployment.yaml
kubectl apply -f  nginx-ingress.yaml
```

Test Request, where

- `8.136.204.98` is the IP of the node in the Kubernetes cluster where Ingress is deployed
- `mynginx.com` is the host defined in `nginx-ingress.yaml`

```shell
curl -v http://8.136.204.98 -H 'host: mynginx.com'
```

### View Metrics Data

Log in to [<<< custom_key.brand_name >>>](https://console.guance.com/), under 「Metrics」 find the prom_ingress metric. The prom_ingress is the value of the measurement_name parameter in the annotations.

![image](../images/ingress-nginx-6.png)

## Observing Ingress

### Ingress Monitoring View

Log in to [<<< custom_key.brand_name >>>](https://console.guance.com/), go to 「Scenes」 - 「Create Dashboard」, search for 「Ingress Nginx Monitoring View」 in the template library, and click 「Confirm」.

The Ingress performance metrics displayed include the average CPU usage, average memory usage, total network requests/responses, number of Ingress Config loads, result of the last Ingress Config load, and the forwarding success rate of Ingress.

![image](../images/ingress-nginx-7.png)