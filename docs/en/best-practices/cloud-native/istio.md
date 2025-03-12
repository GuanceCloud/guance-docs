# Best Practices for Implementing Observability with Istio

---

## Istio

### What is Service Mesh

In recent years, microservices have rapidly gained popularity in software applications. Large applications are broken down into multiple microservices, and while each microservice can run independently within its own container, the network topology of inter-service communication remains very complex. Since network communication between microservices is critical, it's essential to implement a foundational component that ensures secure and robust communication channels between services through multiple service proxies.<br />
A service mesh (Service Mesh) is used to describe the network of microservices that make up these applications and their interactions. Individual service calls are represented as Sidecars. If there are a large number of services, they form a mesh, where green squares represent application microservices, blue squares represent Sidecars, and lines indicate the call relationships between services. Connections between Sidecars form a network.
![image](../images/istio/1.png)

### Introduction to Istio

Istio is an open-source service mesh that transparently layers on top of existing distributed applications. It provides insights into the behavior of the entire service mesh and operational control capabilities, along with a comprehensive solution that meets various needs of microservice applications.

### Core Components of Istio

The Istio service mesh consists of a data plane and a control plane.

- The data plane comprises a set of intelligent proxies (Envoy), which are deployed as sidecars. Communication between microservices via Sidecars is achieved through policy control and telemetry collection (Mixer).
- The control plane manages and configures proxies to route traffic. Citadel provides strong service-to-service and end-user authentication through built-in identity and credential management. Pilot provides service discovery, intelligent routing (such as A/B testing, canary deployments), traffic management, and error handling (timeouts, retries, and circuit breakers) for Envoy sidecars. Galley is the component responsible for configuration validation, acquisition, processing, and distribution in Istio.

![image](../images/istio/2.png)

### Istio Tracing

Envoy natively supports Jaeger. Headers starting with x-b3 (`x-b3-traceid`, `x-b3-spanid`, `x-b3-parentspanid`, `x-b3-sampled`, `x-b3-flags`) and `x-request-id` are passed between different services by business logic and reported to Jaeger by Envoy, ultimately generating complete trace information.<br />
In Istio, the relationship between Envoy and Jaeger is as follows:

![image](../images/istio/3.png)

In the diagram, Front [Envoy](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#envoy) refers to the first [Envoy](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#envoy) [Sidecar](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#sidecar) that receives the request. It is responsible for creating the Root Span and appending it to the request headers. When requests reach different services, [Envoy](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#envoy) [Sidecar](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#sidecar) reports tracing information.<br />
Envoy natively supports Jaeger for link tracing. Envoy supports integrating external tracing services and is compatible with Zipkin and Zipkin-compatible backends (Jaeger). Istio link tracing provides global configuration zipkinAddress, which is passed to Envoy's reporting address through the --zipkinAddress parameter of proxy_init.

### Istio Observability

Istio's robust tracing, monitoring, and logging features provide deep insights into your service mesh deployment. Through Istio's monitoring capabilities, you can truly understand how service performance impacts upstream and downstream processes; its custom dashboards offer visualization of all service performance metrics and show how they affect other processes. All these features enable you to more effectively set up, monitor, and enforce service SLOs.

### Introduction to BookInfo

This example deploys an application to demonstrate various Istio features. The application consists of four separate microservices and mimics a category in an online bookstore, displaying information about a book. The page shows the book's description, details (ISBN, pages, etc.), and reviews.<br />
The Bookinfo application is divided into four separate microservices:

- productpage: The productpage (python) microservice calls the details and reviews microservices to populate the page.
- details: The details (ruby) microservice contains the book's detailed information.
- reviews: The reviews (java) microservice contains book reviews and also calls the ratings microservice.
- ratings: The ratings (node js) microservice contains book rating information.

The reviews microservice has three versions:

- Version v1 does not call the ratings service.
- Version v2 calls the ratings service and displays each rating as 1 to 5 black stars.
- Version v3 calls the ratings service and displays each rating as 1 to 5 red stars.

![image](../images/istio/4.png)

To send Bookinfo's trace data to DataKit, simply modify the istio's configmap and set zipkin.address to the DataKit address. Ensure DataKit has the Zipkin collector enabled to achieve pushing trace data to DataKit.

![image](../images/istio/5.png)

## Environment Deployment

### Prerequisites

#### Kubernetes

This example uses minikube to create a Kubernetes cluster version 1.21.2 on CentOS 7.9.

#### Deploy DataKit

Refer to < [Daemonset Deploy DataKit](../insight/datakit-daemonset.md) >.

#### Enable Collectors

Using the `datakit.yaml` file from [Daemonset Deploy DataKit](../insight/datakit-daemonset.md), upload it to the master node `/usr/local/df-demo/datakit.yaml` of the Kubernetes cluster, edit the `datakit.yaml` file, add ConfigMap and mount files to enable Zipkin and Prom collectors. The final result is a successfully deployed DataKit.

- Add file `/usr/local/datakit/conf.d/zipkin/zipkin.conf` to enable the Zipkin metric collector
- Add file `/usr/local/datakit/conf.d/prom/prom_istiod.conf` to enable the Istiod pod metric collector
- Add file `/usr/local/datakit/conf.d/prom/prom-ingressgateway.conf` to enable the Ingressgateway metric collector
- Add file `/usr/local/datakit/conf.d/prom/prom-egressgateway.conf` to enable the Egressgateway metric collector

![image](../images/istio/6.png)

Access ingressgateway and egressgateway using Service to access port `15020`, so you need to create Services for ingressgateway and egressgateway.

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

Create Services

```bash
kubectl apply -f istio-ingressgateway-service-ext.yaml
kubectl apply -f istio-egressgateway-service-ext.yaml
```

Below are the modified parts of the `datakit.yaml` file:

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
            volumeMounts: # Below are the added parts
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

Log in to [<<< custom_key.brand_name >>>](https://console.guance.com/), under 「Integration」 - 「DataKit」 copy the token and replace `<your-token>` in `datakit.yaml`.

![image](../images/istio/7.png)

![image](../images/istio/8.png)

#### Redeploy DataKit

```bash
cd /usr/local/df-demo
kubectl apply -f datakit.yaml
```

![image](../images/istio/9.png)

### Deploy Istio

#### Download Istio

Download **Source Code** and `istio-1.11.2-linux-amd64.tar.gz` from [here](https://github.com/istio/istio/releases).

#### Install Istio

Upload `istio-1.11.2-linux-amd64.tar.gz` to the `/usr/local/df-demo/` directory and check the internal IP address of the server running Kubernetes is `172.16.0.15`. Replace `172.16.0.15` with your IP.

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

After successful deployment, ingressgateway, egressgateway, and istiod will be in Running status.

```bash
kubectl get pods -n istio-system
```

![image](../images/istio/10.png)

### Deploy BookInfo

#### File Copy

Unpack the source code and copy the `/usr/local/df-demo/istio-1.11.2/samples/bookinfo/src/productpage` directory to `/usr/local/df-demo/bookinfo`. Copy the required YAML files for deploying BookInfo.

```bash
cp /usr/local/df-demo/istio-1.11.2/samples/bookinfo/networking/bookinfo-gateway.yaml /usr/local/df-demo/bookinfo/bookinfo-gateway.yaml
cp /usr/local/df-demo/istio-1.11.2/samples/bookinfo/networking/virtual-service-ratings-test-delay.yaml /usr/local/df-demo/bookinfo/virtual-service-ratings-test-delay.yaml
cp /usr/local/df-demo/istio-1.11.2/samples/bookinfo/platform/kube/bookinfo.yaml /usr/local/df-demo/bookinfo/bookinfo.yaml
```

![image](../images/istio/11.png)

#### Enable Automatic Injection

Create a new prod namespace and enable automatic Sidecar injection for Pods created in this namespace to route inbound and outbound Pod traffic through the Sidecar.

```bash
kubectl create namespace prod
kubectl label namespace prod istio-injection=enabled
```

#### Enable RUM

- 1 Log in to [<<< custom_key.brand_name >>>](https://console.guance.com/), under 「User Access Monitoring」 - 「Create Application」, enter bookinfo,<br />
  copy the JS code to `/usr/local/df-demo/bookinfo/productpage/templates/productpage.html` and change <DATAKIT ORIGIN> to `http://<your-public-ip>:9529`.

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

In the above image, the trace data is pushed to `zipkin.istio-system:9411` by default. Since the DataKit service namespace is datakit and the port is 9529, some conversion is needed here.

> For more details, refer to <[Kubernetes Cluster Using ExternalName to Map DataKit Service](./kubernetes-external-name.md)>

#### Add Namespace

Modify the BookInfo YAML files to add `namespace: prod` under all resource metadata.

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

Add annotations to all Deployment controllers and Pod templates.<br />

Parameter Description

- url: Exporter address
- source: Collector name
- metric_types: Metric type filter
- measurement_name: Name of the collected metric set
- interval: Metric collection frequency, s seconds
- $IP: Wildcard for the Pod's internal IP
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
            image: product-page:v1
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

#### nginx Proxy for Productpage Service

Since this example uses minikube, the internal cluster services are proxied through nginx, so you need to configure nginx.

- View the minikube http2 URL:

```
minikube service istio-ingressgateway -n istio-system
```

![image](../images/istio/19.png)

- Log in as root and modify `proxy_pass` to the http2 service address

```bash
vim /etc/nginx/nginx.conf
```

![image](../images/istio/20.png)

- Restart nginx

```bash
systemctl restart nginx
```

#### Access Productpage

[http://121.43.225.226/productpage](http://121.43.225.226/productpage)

## Observability Exercises

### Metrics

When deploying BookInfo, custom Pod collection is enabled with `measurement_name = "istio_prom"` configured.

Log in to 「<<< custom_key.brand_name >>>」 - 「Metrics」, view the istio_prom metric set.

![image](../images/istio/21.png)

### Traces

#### RUM

Through the User Access Monitoring module, view UV, PV, session count, visited pages, etc.

![image](../images/istio/22.png)

![image](../images/istio/23.png)

#### APM

Through Application Performance Monitoring, view trace data.

![image](../images/istio/24.png)

![image](../images/istio/25.png)

### Logs

#### stdout

DataKit defaults to collecting logs output to `/dev/stdout`. For more advanced features, refer to <[Container Log Collection](../../integrations/container.md)>.

![image](../images/istio/26.png)

#### Log Files

This example does not involve log file collection. Refer to <[Kubernetes Application RUM-APM-LOG Linked Analysis](./k8s-rum-apm-log.md)> if needed.

### Timeout Analysis

- Execute `virtual-service-ratings-test-delay.yaml`

```bash
cd /usr/local/df-demo/bookinfo
kubectl apply -f virtual-service-ratings-test-delay.yaml
```

- Log in using jason, password is empty, access the productpage interface

![image](../images/istio/27.png)

- Click on the timeout trace, observe the flame graph, and identify the timeout call.

![image](../images/istio/28.png)

![image](../images/istio/29.png)
```