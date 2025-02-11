# Nginx Ingress Observability Best Practices

---

## Introduction

Kubernetes provides a Layer 4 proxy for accessing applications deployed in Pods. This type of Layer 4 proxy Service offers four access methods:

1. ClusterIP: Accessible by other applications within the cluster, not externally accessible.
2. NodePort: Opens a specified port on all nodes, allowing external access via IP+port. If no specific NodePort is defined, Kubernetes will randomly assign a port from 30000–32767.
3. LoadBalancer: Built on top of NodePort, it uses cloud provider load balancers to forward traffic to services.
4. ExternalName: By returning a CNAME and its value, it maps services to the content of the `externalName` field.

None of these four methods support accessing applications within the cluster via domain names. To access applications deployed in Kubernetes using domain names, the simplest approach is to deploy a Layer 7 proxy, Nginx, which forwards requests based on domain names. When new deployments occur, the Nginx configuration needs to be updated. To ensure that updates to the configuration are transparent to other applications, Ingress was introduced.

![image](../images/ingress-nginx-1.png)

Ingress can route HTTP and HTTPS requests to internal services within the Kubernetes cluster, ultimately accessing the backend Pods of the Service. It can provide an external accessible URL for the Service, balance traffic, and offer virtual hosting based on domain names.

![image](../images/ingress-nginx-2.png)

Ingress consists of two main components: Ingress Controller and Ingress. Common Ingress implementations include Traefik Ingress and Nginx Ingress. This article focuses on Nginx Ingress. The Ingress Controller interacts with the Kubernetes API to dynamically detect changes in Ingress service rules within the cluster, reads these rules, and forwards them to the corresponding Services in the Kubernetes cluster according to the Ingress rules. Ingress configurations define these rules, specifying which domains correspond to which Services in the Kubernetes cluster. Based on the Nginx configuration template in the Ingress Controller, a corresponding Nginx configuration is generated, dynamically loaded by the Ingress Controller, written into the running Nginx service inside the Ingress Controller Pod, and reloaded to make the configuration effective.

For Kubernetes clusters deploying Ingress, it becomes crucial to monitor resources such as CPU usage, memory consumption, configuration file loading, and forwarding success rates of the Ingress Controller.

**Ingress Working Principle:**

1. A client initiates a request to [http://myNginx.com](http://mynginx.com).
2. The client's DNS server returns the IP address of the Ingress controller.
3. The client sends an HTTP request to the Ingress controller with the Host header set to [myNginx.com](http://mynginx.com).
4. Upon receiving the request, the controller determines which service the client is trying to access from the headers, identifies the pod's IP through the associated endpoint object.
5. The client's request is forwarded to the specific pod for execution.

![image](../images/ingress-nginx-3.png)

## Prerequisites

- [Install Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/)
- Install DataKit: Log in to the [Guance Console](https://console.guance.com/), click on 「Integration」 - 「DataKit」 - 「Kubernetes」

### Deploy Ingress

It is recommended to deploy Ingress using DaemonSet in production environments and set `hostNetwork` to `true` to allow Nginx to use the host machine's network directly, then access Ingress via the cloud provider's load balancer.

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

Find the part where `kind: Deployment` and modify as follows:

```yaml
kind: DaemonSet # Modify

---
hostNetwork: true # Add
dnsPolicy: ClusterFirstWithHostNet # Modify
```

```shell
kubectl apply -f deploy.yaml
```

## Metric Collection

### Enable Input

To collect Ingress metrics data in Guance, enable the prom plugin in DataKit. Specify the exporter's URL in the prom plugin configuration. For collecting Ingress Controller metrics in the Kubernetes cluster, it is recommended to add annotations. Open the `deploy.yaml` file where Ingress is deployed, find the DaemonSet section modified in the previous step, and add annotations.

```yaml
annotations:
  datakit/prom.instances: |
    [[inputs.prom]]
      url = "http://$IP:10254/metrics"
      source = "prom-ingress"
      metric_types = ["counter", "gauge", "histogram"]
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

Parameter Explanation:

- url: Exporter URLs, multiple URLs separated by commas, example ["[http://127.0.0.1:9100/metrics",](http://127.0.0.1:9100/metrics",) "[http://127.0.0.1:9200/metrics"]](http://127.0.0.1:9200/metrics"])
- source: Collector alias.
- metric_types: Metric types, options are counter, gauge, histogram, summary.
- measurement_name: Mearsurement name.
- interval: Collection frequency.
- inputs.prom.measurements: Metrics with the prefix are grouped under the name measurement set.
- tags_ignore: Ignored tags.
- metric_name_filter: Filters for metrics, only collects necessary metric items.

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

Write the corresponding `nginx-ingress.yaml`, according to this rule, if the domain is mynginx.com, it will forward to the Nginx - Service.

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
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-ingress.yaml
```

Test Request, where

- `8.136.204.98` is the IP of the node in the Kubernetes cluster where Ingress is deployed
- `mynginx.com` is the host in `nginx-ingress.yaml`

```shell
curl -v http://8.136.204.98 -H 'host: mynginx.com'
```

### View Metric Data

Log in to [Guance](https://console.guance.com/), in 「Metrics」 find the `prom_ingress` metric. `prom_ingress` is the value of the `measurement_name` parameter in annotations.

![image](../images/ingress-nginx-6.png)

## Monitor Ingress

### Ingress Monitoring View

Log in to [Guance](https://console.guance.com/), go to 「Scenarios」 - 「Create Dashboard」, search for 「Ingress Nginx Monitoring View」 in the template library, and click 「Confirm」.

The Ingress performance metrics displayed include the average CPU usage, average memory usage, total network requests/responses, number of Ingress Config loads, result of the last Ingress Config load, and Ingress forwarding success rate.

![image](../images/ingress-nginx-7.png)