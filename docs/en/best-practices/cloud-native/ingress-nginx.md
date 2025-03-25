# Nginx Ingress Observability Best Practices

---

## Introduction

Kubernetes provides a four-layer proxy to access applications deployed in Pods. This type of Service with a four-layer proxy, Kubernetes offers 4 access methods:

1. ClusterIP: For access by other applications within the cluster; external access is not possible.
2. NodePort: A specified port is open on all nodes, and external services can be accessed via IP+port. If no specific NodePort port is defined, a random port between 30000–32767 will be assigned.
3. LoadBalancer: On top of NodePort, using cloud service provider's load balancer to forward traffic to the service.
4. ExternalName: By returning CNAME and its value, you can map the service to the content of the externalName field.

None of these four methods allow access to applications in the cluster via domain name. To access applications deployed in Kubernetes through a domain name, the simplest way is to deploy a seven-layer proxy Nginx in the cluster, which forwards requests based on the domain name to the corresponding Service. When there are new deployments, Nginx configuration needs to be updated. To ensure updates occur without affecting other applications, Ingress was introduced.

![image](../images/ingress-nginx-1.png)

Ingress can forward http and https requests to internal services within the Kubernetes cluster, ultimately accessing the backend Pods of the Service. Ingress can provide an externally accessible URL for the Service, balance traffic, and offer virtual hosting based on domain names.

![image](../images/ingress-nginx-2.png)

Ingress consists of two major components: Ingress Controller and Ingress. Common Ingress options include traefik Ingress and Nginx Ingress. This article uses Nginx Ingress as an example. The Ingress Controller interacts with Kubernetes' API to dynamically perceive changes in Ingress service rules within the Kubernetes cluster, then reads these rules and forwards them to the corresponding Services in the Kubernetes cluster according to the Ingress rules. Ingress configures these rules, specifying which domain corresponds to which Service in the Kubernetes cluster, then generates a corresponding Nginx configuration based on the Nginx template in the Ingress Controller. The Ingress Controller dynamically loads these configurations, writes them into the Nginx service running inside the Ingress Controller Pod, and reloads it to make the configuration effective.

For Kubernetes clusters that have deployed Ingress, observing resources such as CPU usage, memory consumption, configuration file loading, and forwarding success rate of the Ingress Controller becomes very necessary.

**How Ingress Works:**

1. The client initiates a [http://myNginx.com](http://mynginx.com) request.
2. The client’s DNS server returns the IP of the Ingress controller.
3. The client sends an HTTP request to the Ingress controller, specifying [myNginx.com](http://mynginx.com) in the Host header.
4. After receiving the request, the controller determines which service the client is trying to access from the header, and looks up the pod’s IP through the endpoint object associated with that service.
5. The client’s request is forwarded to the specific pod for execution.

![image](../images/ingress-nginx-3.png)

## Prerequisites

- [Install Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/)
- Install DataKit: Log in to [<<< custom_key.brand_name >>> Console](https://<<< custom_key.studio_main_site >>>/), click 「Integration」 - 「DataKit」 - 「Kubernetes」

### Deploy Ingress

It is recommended to use DaemonSet for deployment in production environments, and set `hostNetwork` to `true` so that Nginx can directly use the host machine's network, then access Ingress via the load balancer provided by the cloud vendor.

#### 1 Download deploy.yaml

```shell
wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/baremetal/deploy.yaml
```

#### 2 Edit deploy.yaml

##### 2.1 Replace Image

Replace the images used in the `deploy.yaml` file with the following:

```
registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-ingress-controller:v1.1.1
registry.cn-hangzhou.aliyuncs.com/google_containers/kube-webhook-certgen:v1.1.1
```

##### 2.2 Modify Deployment Resource File

Find the kind: Deployment section and modify as follows:

```yaml
kind: DaemonSet # Modify

---
hostNetwork: true # Add
dnsPolicy: ClusterFirstWithHostNet # Modify
```

```shell
kubectl apply -f deploy.yaml
```

## Metrics Collection

### Enable Input

To connect Ingress metrics data with <<< custom_key.brand_name >>>, the datakit must enable the prom plugin. In the prom plugin configuration, specify the exporter's URL to collect Ingress Controller metrics in the Kubernetes cluster. It is recommended to use annotations to add notes. Open the deploy.yaml file where Ingress is deployed, find the DaemonSet part modified in the previous step, and add annotations.

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

- url: Exporter URLs, multiple urls separated by commas, example ["[http://127.0.0.1:9100/metrics",](http://127.0.0.1:9100/metrics",) "[http://127.0.0.1:9200/metrics"]](http://127.0.0.1:9200/metrics"])
- source: Collector alias.
- metric_types: Metric types, optional values are counter, gauge, histogram, summary.
- measurement_name: Measurement name.
- interval: Collection frequency.
- inputs.prom.measurements: Metrics with the prefix are grouped into the name measurement set.
- tags_ignore: Ignored tags.
- metric_name_filter: Metric filtering, only collects required metric items.

Annotations support the following wildcards:

- `$NAMESPACE`: Pod Namespace

### Restart Ingress Controller

```shell
kubectl delete -f deploy.yaml
kubectl apply -f deploy.yaml
```

### Demonstration Case

Write the Nginx deployment file `nginx-deployment.yaml`

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

Write the corresponding `nginx-ingress.yaml`, according to this rule, if the domain name is mynginx.com, then forward to the Nginx - Service service.

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

- `8.136.204.98` is the node ip where Ingress is deployed in the Kubernetes cluster
- `mynginx.com` is the host corresponding to `nginx-ingress.yaml`

```shell
curl -v http://8.136.204.98 -H 'host: mynginx.com'
```

### View Metrics Data

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/) and find the prom_ingress metric under 「Metrics」. Here, prom_ingress is the value of the measurement_name parameter in the annotations.

![image](../images/ingress-nginx-6.png)

## Monitoring Ingress

### Ingress Monitoring Views

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/), go to 「Scenes」 - 「Create Dashboard」, search for 「Ingress Nginx Monitoring View」 in the template library, and click 「Confirm」.

Ingress performance metrics are displayed, including average CPU usage of the Ingress Controller, average memory usage, total network requests/responses, number of Ingress Config loads, result of the last Ingress Config load, and Ingress forwarding success rate, etc.

![image](../images/ingress-nginx-7.png)