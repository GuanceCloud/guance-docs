# Best Practices for Microservices Observability Based on Istio

---

## Istio

### What is Service Mesh

In the past few years, microservices have rapidly gained popularity in software applications. Large applications are broken down into multiple microservices, and although each microservice can run independently in its own container through containerization, the network topology of communication between services remains very complex. Since network communication between microservices is crucial, it is necessary to have foundational components that implement multiple service proxies to ensure secure and robust communication channels between services.<br />
The service mesh (Service Mesh) is used to describe the network of microservices that make up these applications and their interactions. A single service call manifests as a Sidecar. If there are a large number of services, it will appear as a grid. In the figure below, the green squares represent application microservices, the blue squares represent Sidecars, and the lines indicate the calling relationships between services. The connections between Sidecars form a network.
![image](../images/istio/1.png)

### Introduction to Istio

Istio is an open-source service mesh that transparently layers onto existing distributed applications. It provides insights into and operational control over the behavior of the entire service mesh, along with a complete solution that meets various needs of microservice applications.

### Core Components of Istio

The Istio service mesh consists of a data plane and a control plane.

- The data plane consists of a set of intelligent proxies (Envoy), which are deployed as sidecars. Communication between microservices and Sidecars is achieved through policy control and telemetry collection (Mixer).
- The control plane is responsible for managing and configuring proxies to route traffic. Citadel provides strong service-to-service and end-user authentication through built-in identity and credential management. Pilot is used for service discovery for Envoy sidecars, intelligent routing (such as A/B testing, canary deployments, etc.), traffic management, and error handling (timeouts, retries, and circuit breakers). Galley is the component for Istio configuration validation, acquisition, processing, and distribution.

![image](../images/istio/2.png)

### Istio Trace Tracking

Envoy natively supports Jaeger, and the x-b3 prefixed Headers (`x-b3-traceid`, `x-b3-spanid`, `x-b3-parentspanid`, `x-b3-sampled`, `x-b3-flags`) and x-request-id are passed between different services by business logic and reported to Jaeger by Envoy, ultimately generating complete trace information.<br />
In Istio, the relationship between Envoy and Jaeger is as follows:

![image](../images/istio/3.png)

In the diagram, Front [Envoy](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#envoy) refers to the first [Envoy](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#envoy) [Sidecar](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#sidecar) that receives the request. It is responsible for creating the Root Span and appending it to the request Header. When the request reaches different services, [Envoy](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#envoy) [Sidecar](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#sidecar) reports the trace information.<br />
Envoy's trace tracking natively supports Jaeger. Envoy supports integration with external tracing services, supporting zipkin and zipkin-compatible backends (jaeger). Istio's trace tracking provides global configuration zipkinAddress, and [Envoy](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#envoy)'s reporting address is passed via the --zipkinAddress parameter of proxy_init.

### Istio Observability

Istio's robust tracing, monitoring, and logging features allow you to gain deep insights into the deployment of the service mesh. Through Istio's monitoring capabilities, you can truly understand how service performance affects upstream and downstream processes; its customizable dashboards provide visualizations of the performance of all services and show how they impact other processes. All these features enable you to more effectively set, monitor, and strengthen the SLOs of your services.

### BookInfo Overview

This example deploys an application that demonstrates several Istio features. The application consists of four separate microservices. This application mimics a category in an online bookstore, displaying information about a book. The page shows the book's description, details (ISBN, number of pages, etc.), and some reviews about the book.<br />
The Bookinfo application is divided into four separate microservices:

- productpage: The productpage (python) microservice calls the details and reviews microservices to populate the page.
- details: The details (ruby) microservice contains book details.
- reviews: The reviews (java) microservice contains reviews, and it also calls the ratings microservice.
- ratings: The ratings (node js) microservice contains book ranking information.

The reviews microservice has three versions:

- Version v1 does not call the ratings service.
- Version v2 calls the ratings service and displays each rating as 1 to 5 black stars.
- Version v3 calls the ratings service and displays each rating as 1 to 5 red stars.

![image](../images/istio/4.png)

To push the trace data of Bookinfo to DataKit, simply modify the zipkin.address in Istio's configmap to the DataKit address, and enable the zipkin collector in DataKit.

![image](../images/istio/5.png)

## Environment Deployment

### Prerequisites

#### Kubernetes

This example uses a Kubernetes cluster version 1.21.2 created via minikube on CentOS 7.9.

#### Deploying DataKit

Refer to <[Daemonset Deployment of DataKit](../insight/datakit-daemonset.md)>.

#### Enabling Collectors

Use the `datakit.yaml` file from [Daemonset Deployment of DataKit](../insight/datakit-daemonset.md), upload it to the master node of the Kubernetes cluster at `/usr/local/df-demo/datakit.yaml`. Modify the `datakit.yaml` file, add ConfigMap and mount files to enable Zipkin and Prom collectors, resulting in the final deployment of DataKit.

- Add the file `/usr/local/datakit/conf.d/zipkin/zipkin.conf` to enable the Zipkin metrics collector
- Add the file `/usr/local/datakit/conf.d/prom/prom_istiod.conf` to enable the Istiod pod metrics collector
- Add the file `/usr/local/datakit/conf.d/prom/prom-ingressgateway.conf` to enable the Ingressgateway metrics collector
- Add the file `/usr/local/datakit/conf.d/prom/prom-egressgateway.conf` to enable the Egressgateway metrics collector

![image](../images/istio/6.png)

Since ingressgateway and egressgateway use Services to access port `15020`, create new Services for ingressgateway and egressgateway.

??? quote "`istio-ingressgateway-service-ext.yaml`"

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: istio-ingressgateway-ext
      namespace: istio-system
    spec:
      ports:
        - name: http-monitoring
          port: 15020
          protocol: TCP
          targetPort: 15020
      selector:
        app: istio-ingressgateway
        istio: ingressgateway
      type: ClusterIP
    ```

??? quote "`istio-egressgateway-service-ext.yaml`"

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: istio-egressgateway-ext
      namespace: istio-system
    spec:
      ports:
        - name: http-monitoring
          port: 15020
          protocol: TCP
          targetPort: 15020
      selector:
        app: istio-egressgateway
        istio: egressgateway
      type: ClusterIP
    ```

Create the Services

```bash
kubectl apply -f istio-ingressgateway-service-ext.yaml
kubectl apply -f istio-egressgateway-service-ext.yaml
```

Below is the modified part of the `datakit.yaml` file:

??? quote "ConfigMap Addition"

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: datakit-conf
      namespace: datakit
    data:
      zipkin.conf: |-
        [[inputs.zipkin]]
          pathV1 = "/api/v1/spans"
          pathV2 = "/api/v2/spans"

      prom_istiod.conf: |-
        [[inputs.prom]] 
          url = "http://istiod.istio-system.svc.cluster.local:15014/metrics"
          source = "prom-istiod"
          metric_types = ["counter", "gauge"]
          interval = "60s"
          tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
          metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
          #measurement_prefix = ""
          measurement_name = "istio_prom"
          #[[inputs.prom.measurements]]
          # prefix = "cpu_"
          # name ="cpu"
          [inputs.prom.tags]
            app_id="istiod"

      prom-ingressgateway.conf: |-
        [[inputs.prom]] 
          url = "http://istio-ingressgateway-ext.istio-system.svc.cluster.local:15020/stats/prometheus"
          source = "prom-ingressgateway"
          metric_types = ["counter", "gauge"]
          interval = "60s"
          tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
          metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
          #measurement_prefix = ""
          measurement_name = "istio_prom"
          #[[inputs.prom.measurements]]
          # prefix = "cpu_"
          # name ="cpu"

      prom-egressgateway.conf: |-
        [[inputs.prom]] 
          url = "http://istio-egressgateway-ext.istio-system.svc.cluster.local:15020/stats/prometheus"
          source = "prom-egressgateway"
          metric_types = ["counter", "gauge"]
          tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
          interval = "60s"
          metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
          #measurement_prefix = ""
          measurement_name = "istio_prom"
          #[[inputs.prom.measurements]]
          # prefix = "cpu_"
          # name ="cpu"
    ```

??? quote "Mount `zipkin.conf` and `prom_istiod.conf`"

    ```yaml
    apiVersion: apps/v1
    kind: DaemonSet
    ...
    spec:
      template
        spec:
          containers:
          - env:
            volumeMounts: # Below is the added part
            - mountPath: /usr/local/datakit/conf.d/zipkin/zipkin.conf
              name: datakit-conf
              subPath: zipkin.conf
            - mountPath: /usr/local/datakit/conf.d/prom/prom_istiod.conf
              name: datakit-conf
              subPath: prom_istiod.conf
            - mountPath: /usr/local/datakit/conf.d/prom/prom-ingressgateway.conf
              name: datakit-conf
              subPath: prom-ingressgateway.conf
            - mountPath: /usr/local/datakit/conf.d/prom/prom-egressgateway.conf
              name: datakit-conf
              subPath: prom-egressgateway.conf
    ```

#### Replace Token

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/), under "Integration" - "DataKit", copy the token and replace `<your-token>` in `datakit.yaml`.

![image](../images/istio/7.png)

![image](../images/istio/8.png)

#### Re-deploy DataKit

```bash
cd /usr/local/df-demo
kubectl apply -f datakit.yaml
```

![image](../images/istio/9.png)

### Deploy Istio

#### Download Istio

[Download](https://github.com/istio/istio/releases) **Source Code** and `istio-1.11.2-linux-amd64.tar.gz`

#### Install Istio

Upload `istio-1.11.2-linux-amd64.tar.gz` to `/usr/local/df-demo/` directory, check that the internal IP address of the server where Kubernetes resides is `172.16.0.15`, please replace `172.16.0.15` with your IP.

```bash
su minikube
cd /usr/local/df-demo/
tar zxvf istio-1.11.2-linux-amd64.tar.gz
cd /usr/local/df-demo/istio-1.11.2
export PATH=$PWD/bin:$PATH$
cp -ar /usr/local/df-demo/istio-1.11.2/bin/istioctl /usr/bin/

istioctl install --set profile=demo

```

#### Verify Installation

After successful deployment, ingressgateway, egressgateway, and istiod will be in Running state.

```bash
kubectl get pods -n istio-system
```

![image](../images/istio/10.png)

### Deploy BookInfo

#### Copy Files

Unpack the source code, copy the `/usr/local/df-demo/istio-1.11.2/samples/bookinfo/src/productpage` directory to `/usr/local/df-demo/bookinfo` directory. Copy the yaml files needed to deploy bookInfo.

```bash
cp /usr/local/df-demo/istio-1.11.2/samples/bookinfo/networking/bookinfo-gateway.yaml /usr/local/df-demo/bookinfo/bookinfo-gateway.yaml
cp /usr/local/df-demo/istio-1.11.2/samples/bookinfo/networking/virtual-service-ratings-test-delay.yaml /usr/local/df-demo/bookinfo/virtual-service-ratings-test-delay.yaml
cp /usr/local/df-demo/istio-1.11.2/samples/bookinfo/platform/kube/bookinfo.yaml /usr/local/df-demo/bookinfo/bookinfo.yaml
```

![image](../images/istio/11.png)

#### Enable Automatic Injection

Create a new prod namespace, enable automatic injection of Sidecar for Pods created in this namespace, allowing Pod traffic to be handled by Sidecar.

```bash
kubectl create namespace prod
kubectl label namespace prod istio-injection=enabled
```

#### Enable RUM

- 1 Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/), under "User Analysis" - "Create Application", input bookinfo,<br />
  copy the js to `/usr/local/df-demo/bookinfo/productpage/templates/productpage.html`, and change <DATAKIT ORIGIN> to `http://<your-external ip>:9529`.

![image](../images/istio/12.png)

![image](../images/istio/13.png)

- 2 Modify `/usr/local/df-demo/bookinfo/productpage/Dockerfile`

![image](../images/istio/14.png)

- 3 Build Image

```bash
cd /usr/local/df-demo/bookinfo/productpage
eval $(minikube docker-env)
docker build -t product-page:v1 .
```

- 4 Replace Image

Replace `image: docker.io/istio/examples-bookinfo-productpage-v1:1.16.2` with `image: product-page:v1` in `/usr/local/df-demo/bookinfo/bookinfo.yaml`.

![image](../images/istio/15.png)

#### Connect APM and DataKit

```bash
kubectl edit configmap istio -n istio-system -o yaml
```

![image](../images/istio/16.png)

In the above figure, you can see that the trace data is pushed to the default address `zipkin.istio-system:9411`. Since the namespace for the DataKit service is datakit, and the port is 9529, a conversion is required here.

> For details, refer to <[Kubernetes Cluster Using ExternalName to Map DataKit Service](./kubernetes-external-name.md)>

#### Add Namespace

Modify the yaml of bookinfo, add `namespace: prod` under all resource metadatas.

```bash
vi /usr/local/df-demo/bookinfo/bookinfo.yaml
vi /usr/local/df-demo/bookinfo/bookinfo-gateway.yaml
vi /usr/local/df-demo/bookinfo/virtual-service-ratings-test-delay.yaml
```

![image](../images/istio/17.png)

#### Enable Custom Pod Collection

Modify `bookinfo.yaml`

```bash
vi /usr/local/df-demo/bookinfo/bookinfo.yaml
```

Add annotations to all Pod templates controlled by Deployment controllers.<br />

Parameter Explanation

- url: Exporter address
- source: Collector name
- metric_types: Metric type filtering
- measurement_name: Name of the collected Measurement
- interval: Metric collection frequency, in seconds
- $IP: Wildcard for Pod's internal IP
- $NAMESPACE: Namespace where the Pod resides
- tags_ignore: Ignored tags.

```yaml
annotations:
  datakit/prom.instances: |
    [[inputs.prom]]
      url = "http://$IP:15020/stats/prometheus"
      source = "minik8s-istio-product"
      metric_types = ["counter", "gauge"]
      interval = "60s"
      tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
      metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
      #measurement_prefix = ""
      measurement_name = "istio_prom"
      #[[inputs.prom.measurements]]
      # prefix = "cpu_"
      # name = "cpu"         
      [inputs.prom.tags]
      namespace = "$NAMESPACE"
      pod_name = "$PODNAME"
```

![image](../images/istio/18.png)

- Complete `bookinfo.yaml` as follows

??? quote "`bookinfo.yaml`"

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: details
      namespace: prod
      labels:
        app: details
        service: details
    spec:
      ports:
      - port: 9080
        name: http
      selector:
        app: details
    ---
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: bookinfo-details
      namespace: prod
      labels:
        account: details
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: details-v1
      namespace: prod
      labels:
        app: details
        version: v1
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: details
          version: v1
      template:
        metadata:
          labels:
            app: details
            version: v1
          annotations:
            datakit/prom.instances: |
              [[inputs.prom]]
                url = "http://$IP:15020/stats/prometheus"
                source = "minik8s-istio-details"
                metric_types = ["counter", "gauge"]
                interval = "60s"
          tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
                metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
                #measurement_prefix = ""
                measurement_name = "istio_prom"
                #[[inputs.prom.measurements]]
                # prefix = "cpu_"
                # name = "cpu"
                [inputs.prom.tags]
                namespace = "$NAMESPACE"
        spec:
          serviceAccountName: bookinfo-details
          containers:
          - name: details
            image: docker.io/istio/examples-bookinfo-details-v1:1.16.2
            imagePullPolicy: IfNotPresent
            ports:
            - containerPort: 9080
            securityContext:
              runAsUser: 1000
    ---
    ##################################################################################################
    # Ratings service
    ##################################################################################################
    apiVersion: v1
    kind: Service
    metadata:
      name: ratings
      namespace: prod
      labels:
        app: ratings
        service: ratings
    spec:
      ports:
      - port: 9080
        name: http
      selector:
        app: ratings
    ---
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: bookinfo-ratings
      namespace: prod
      labels:
        account: ratings
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: ratings-v1
      namespace: prod
      labels:
        app: ratings
        version: v1
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: ratings
          version: v1
      template:
        metadata:
          labels:
            app: ratings
            version: v1
          annotations:
            datakit/prom.instances: |
              [[inputs.prom]]
                url = "http://$IP:15020/stats/prometheus"
                source = "minik8s-istio-ratings"
                metric_types = ["counter", "gauge"]
                interval = "60s"
          tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
                metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
                #measurement_prefix = ""
                measurement_name = "istio_prom"
                #[[inputs.prom.measurements]]
                # prefix = "cpu_"
                # name = "cpu"
                [inputs.prom.tags]
                namespace = "$NAMESPACE"
        spec:
          serviceAccountName: bookinfo-ratings
          containers:
          - name: ratings
            image: docker.io/istio/examples-bookinfo-ratings-v1:1.16.2
            imagePullPolicy: IfNotPresent
            ports:
            - containerPort: 9080
            securityContext:
              runAsUser: 1000
    ---
    ##################################################################################################
    # Reviews service
    ##################################################################################################
    apiVersion: v1
    kind: Service
    metadata:
      name: reviews
      namespace: prod
      labels:
        app: reviews
        service: reviews
    spec:
      ports:
      - port: 9080
        name: http
      selector:
        app: reviews
    ---
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: bookinfo-reviews
      namespace: prod
      labels:
        account: reviews
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: reviews-v1
      namespace: prod
      labels:
        app: reviews
        version: v1
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: reviews
          version: v1
      template:
        metadata:
          labels:
            app: reviews
            version: v1
          annotations:
            datakit/prom.instances: |
              [[inputs.prom]]
                url = "http://$IP:15020/stats/prometheus"
                source = "minik8s-istio-review1"
                metric_types = ["counter", "gauge"]
                interval = "60s"
          tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
                #measurement_prefix = ""
                metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
                measurement_name = "istio_prom"
                #[[inputs.prom.measurements]]
                # prefix = "cpu_"
                # name = "cpu"
                [inputs.prom.tags]
                namespace = "$NAMESPACE"
        spec:
          serviceAccountName: bookinfo-reviews
          containers:
          - name: reviews
            image: docker.io/istio/examples-bookinfo-reviews-v1:1.16.2
            imagePullPolicy: IfNotPresent
            env:
            - name: LOG_DIR
              value: "/tmp/logs"
            ports:
            - containerPort: 9080
            volumeMounts:
            - name: tmp
              mountPath: /tmp
            - name: wlp-output
              mountPath: /opt/ibm/wlp/output
            securityContext:
              runAsUser: 1000
          volumes:
          - name: wlp-output
            emptyDir: {}
          - name: tmp
            emptyDir: {}
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: reviews-v2
      namespace: prod
      labels:
        app: reviews
        version: v2
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: reviews
          version: v2
      template:
        metadata:
          labels:
            app: reviews
            version: v2
          annotations:
            datakit/prom.instances: |
              [[inputs.prom]]
                url = "http://$IP:15020/stats/prometheus"
                source = "minik8s-istio-review2"
                metric_types = ["counter", "gauge"]
                interval = "60s"
          tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
                #measurement_prefix = ""
                metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
                measurement_name = "istio_prom"
                #[[inputs.prom.measurements]]
                # prefix = "cpu_"
                # name = "cpu"
                [inputs.prom.tags]
                namespace = "$NAMESPACE"
        spec:
          serviceAccountName: bookinfo-reviews
          containers:
          - name: reviews
            image: docker.io/istio/examples-bookinfo-reviews-v2:1.16.2
            imagePullPolicy: IfNotPresent
            env:
            - name: LOG_DIR
              value: "/tmp/logs"
            ports:
            - containerPort: 9080
            volumeMounts:
            - name: tmp
              mountPath: /tmp
            - name: wlp-output
              mountPath: /opt/ibm/wlp/output
            securityContext:
              runAsUser: 1000
          volumes:
          - name: wlp-output
            emptyDir: {}
          - name: tmp
            emptyDir: {}
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: reviews-v3
      namespace: prod
      labels:
        app: reviews
        version: v3
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: reviews
          version: v3
      template:
        metadata:
          labels:
            app: reviews
            version: v3
          annotations:
            datakit/prom.instances: |
              [[inputs.prom]]
                url = "http://$IP:15020/stats/prometheus"
                source = "minik8s-istio-review3"
                metric_types = ["counter", "gauge"]
                interval = "60s"
          tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
                metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
                #measurement_prefix = ""
                measurement_name = "istio_prom"
                #[[inputs.prom.measurements]]
                # prefix = "cpu_"
                # name = "cpu"
                [inputs.prom.tags]
                namespace = "$NAMESPACE"
        spec:
          serviceAccountName: bookinfo-productpage
          containers:
          - name: productpage
            #image: docker.io/istio/examples-bookinfo-productpage-v1:1.16.2
            image: image: product-page:v1
            imagePullPolicy: IfNotPresent
            ports:
            - containerPort: 9080
            volumeMounts:
            - name: tmp
              mountPath: /tmp
            securityContext:
              runAsUser: 1000
          volumes:
          - name: tmp
            emptyDir: {}
    ---

    ```

- Complete `bookinfo-gateway.yaml`

??? quote "`bookinfo-gateway.yaml`"

    ```yaml
    kind: Gateway
    metadata:
      name: bookinfo-gateway
      namespace: prod
    spec:
      selector:
        istio: ingressgateway # use istio default controller
      servers:
        - port:
            number: 80
            name: http
            protocol: HTTP
          hosts:
            - "*"
    ---
    apiVersion: networking.istio.io/v1alpha3
    kind: VirtualService
    metadata:
      name: bookinfo
      namespace: prod
    spec:
      hosts:
        - "*"
      gateways:
        - bookinfo-gateway
      http:
        - match:
            - uri:
                exact: /productpage
            - uri:
                prefix: /static
            - uri:
                exact: /login
            - uri:
                exact: /logout
            - uri:
                prefix: /api/v1/products
          route:
            - destination:
                host: productpage
                port:
                  number: 9080
    ```

#### Deploy Services

```bash
cd /usr/local/df-demo/bookinfo
kubectl apply -f bookinfo.yaml
kubectl apply -f bookinfo-gateway.yaml
```

#### Nginx Proxy for Productpage Service

Since this example uses minikube, the cluster internal services are proxied via nginx, so you need to configure nginx.

- Check the minikube http2 URL:

```
minikube service istio-ingressgateway -n istio-system
```

![image](../images/istio/19.png)

- Log in as root on the server and modify `proxy_pass` to the http2 service address

```bash
vim  /etc/nginx/nginx.conf
```

![image](../images/istio/20.png)

- Restart nginx

```bash
systemctl restart nginx
```

#### Access Productpage

[http://121.43.225.226/productpage](http://121.43.226.226/productpage)

## Observability Exercise

### Metrics

When deploying BookInfo, Pod custom collection was enabled with the configuration `measurement_name = "istio_prom"`.

Log in to '<<< custom_key.brand_name >>>' - 'Metrics', and view the istio_prom Measurement.

![image](../images/istio/21.png)

### Traces

#### RUM

Through the user analysis module, view information such as UV, PV, session count, and visited pages.

![image](../images/istio/22.png)

![image](../images/istio/23.png)

#### APM

Through application performance monitoring, view trace data.

![image](../images/istio/24.png)

![image](../images/istio/25.png)

### Logs

#### stdout

DataKit defaults to collecting logs output to `/dev/stdout`. For more advanced features, refer to <[Container Log Collection](../../integrations/container.md)>.

![image](../images/istio/26.png)

#### Log Files

This example does not involve log file collection; if needed, refer to <[Kubernetes Application's RUM-APM-LOG Joint Analysis](./k8s-rum-apm-log.md)>

### Trace Timeout Analysis

- Execute `virtual-service-ratings-test-delay.yaml`

```bash
cd /usr/local/df-demo/bookinfo
kubectl apply -f virtual-service-ratings-test-delay.yaml
```

- Log in using jason, with an empty password, and access the productpage interface

![image](../images/istio/27.png)

- Click on the timeout trace, observe the flame graph, and identify the timeout call.

![image](../images/istio/28.png)

![image](../images/istio/29.png)