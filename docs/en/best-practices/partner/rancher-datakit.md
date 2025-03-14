# Deploy and Manage DataKit Using Rancher for Rapid Kubernetes Observability

---

## Introduction

As enterprises grow, the number of servers, Kubernetes environments, and microservice applications increases. Efficient observability of these resources to save human and resource costs becomes a challenge for enterprises. By deploying DataKit from the Rancher app store with one click, <<< custom_key.brand_name >>> provides extensive out-of-the-box observability features for K8s clusters managed by Rancher.

This article uses a familiar service mesh microservices architecture example, Bookinfo, to explain in detail how to enhance end-to-end observability of K8s, Istio, continuous integration, canary releases, etc., using <<< custom_key.brand_name >>>.

<<< custom_key.brand_name >>> is a leading company dedicated to observability in the cloud-native domain. By using one platform and deploying the DataKit Agent, users can link metrics, traces, and logs from hosts and applications. Users can log into <<< custom_key.brand_name >>> to actively monitor their K8s runtime and microservice application health status in real time.

## Case Assumption

Assume a company has several cloud servers, two Kubernetes clusters (one production environment and one testing environment), with one master node and two worker nodes in the testing environment. Harbor and Gitlab are deployed on the cloud servers, and the Istio project bookinfo is deployed in the Kubernetes testing environment.

Now we will use <<< custom_key.brand_name >>> to observe host, Kubernetes cluster, Gitlab CI, canary release, RUM, APM, Istio, etc.

## Prerequisites

- Install [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/) 1.18+.
- Install [Rancher](https://rancher.com/docs/rancher/v2.6/en/installation/) and have permission to operate Kubernetes clusters.
- Install [Gitlab](https://about.gitlab.com/).
- Install [Helm](https://github.com/helm/helm) 3.0+.
- Deploy Harbor repository or other image repositories.

## Configuration Steps

???+ warning

    The version information used in this example is as follows: DataKit `1.4.0`, Kubernetes 1`.22.6`, Rancher `2.6.3`, Gitlab `14.9.4`, Istio `1.13.2`. Different versions may result in configuration differences.

### Step 1: Install DataKit Using Rancher

For easier management, install DataKit in the `datakit` namespace. <br/>
Log in to "Rancher" - "Clusters" - "Projects/Namespace", and click "Create Namespace".

![image](../images/rancher-datakit/1.png)

Enter the name "datakit" and click "Create".
![image](../images/rancher-datakit/2.png)

Go to "Clusters" - "Marketplace" - "Chart Repositories", and click "Create".<br/>
Enter the name "datakit", URL `[https://pubrepo.guance.com/chartrepo/datakit](https://pubrepo.guance.com/chartrepo/datakit)`, and click "Create".
![image](../images/rancher-datakit/3.png)

Go to "Clusters" - "Marketplace" - "Charts", select "datakit", and click into the chart with **DataKit**.
![image](../images/rancher-datakit/4.png)

Click "Install".
![image](../images/rancher-datakit/5.png)

Select the namespace "datakit" and click "Next".
![image](../images/rancher-datakit/6.png)

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Management" module, find the `token` as shown in the figure below, and click the "Copy Icon".
![image](../images/rancher-datakit/7.png)

Switch to the Rancher interface:

- Replace the token in the figure with the copied token
- Under "Enable The Default Inputs", add "ebpf collector", i.e., add “`,ebpf`” at the end (**note that it is separated by commas**)
- Under "DataKit Global Tags", add “`,cluster_name_k8s=k8s-prod`” at the end. (Where k8s-prod is your cluster name, which you can define yourself, to set global tags for collected metrics.)

![image](../images/rancher-datakit/8.png)

Click "Kube-State-Metrics" and choose "Install".
![image](../images/rancher-datakit/9.png)

Click "metrics-server", choose "Install", and then click the "Install" button.
![image](../images/rancher-datakit/10.png)

Go to "Clusters" - "Marketplace" - "Installed Apps" to see that DataKit has been installed successfully.
![image](../images/rancher-datakit/11.png)

Go to "Clusters" - "Workloads" - "Pods" to see that the `datakit` namespace has 3 running DataKit instances, 1 kube-state-metrics, and 1 metrics-server.
![image](../images/rancher-datakit/12.png)

Since the company has multiple clusters, you need to add the `ENV_NAMESPACE` environment variable. This variable is used to distinguish elections between different clusters, and the values for multiple clusters cannot be the same.<br/>
Go to "Clusters" - "Workloads" - "DaemonSets", click on the right side of the datakit row, and select "Edit Configuration".
![image](../images/rancher-datakit/13.png)

Here, enter the variable name `ENV_NAMESPACE`, and the value `guance-k8s`, and click "Save".
![image](../images/rancher-datakit/14.png)

### Step 2: Enable Kubernetes Observability

#### 2.1 ebpf Observability

1. Enable Collector

   The **ebpf collector** was already enabled when deploying DataKit.

2. ebpf View

   Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)" - "Infrastructure", and click on "k8s-node1".

![image](../images/rancher-datakit/15.png)

Click on "Network" to view the ebpf monitoring view.

![image](../images/rancher-datakit/16.png)
![image](../images/rancher-datakit/17.png)

#### 2.2 Container Observability

1. Enable Collector

   DataKit defaults to enabling the Container collector. Here's an introduction to customizing collector configurations.

   Log in to "Rancher" - "Clusters" - "Storage" - "ConfigMaps", and click "Create".

![image](../images/rancher-datakit/18.png)

Enter the namespace "datakit", name "datakit-conf", key "container.conf", and the following content for the value.

> **Note:** In production environments, it is recommended to set `container_include_log = []` and `container_exclude_log = ["image:*"]`, and then add annotations to the Pods where you want to collect logs to collect logs for specific containers.

```toml
      [inputs.container]
        docker_endpoint = "unix:///var/run/docker.sock"
        containerd_address = "/var/run/containerd/containerd.sock"

        enable_container_metric = true
        enable_k8s_metric = true
        enable_pod_metric = true

        ## Containers logs to include and exclude, default collect all containers. Globs accepted.
        container_include_log = []
        container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*", "image:pubrepo.jiagouyun.com/datakit/datakit*"]

        exclude_pause_container = true

        ## Removes ANSI escape codes from text strings
        logging_remove_ansi_escape_codes = false

        kubernetes_url = "https://kubernetes.default:443"

        ## Authorization level:
        ##   bearer_token  - bearer_token_string  - TLS
        ## Use bearer token for authorization. ('bearer_token' takes priority)
        ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
        ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
        bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
        # bearer_token_string = "<your-token-string>"

        [inputs.container.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"
```

Fill in the content as shown in the figure and click "Create".

![image](../images/rancher-datakit/19.png)

Go to "Clusters" - "Workloads" - "DaemonSets", find datakit, and click "Edit Configuration".

![image](../images/rancher-datakit/20.png)

Click "Storage".

![image](../images/rancher-datakit/21.png)

Click "Add Volume" - "ConfigMap".

![image](../images/rancher-datakit/22.png)

Enter the volume name "datakit-conf", choose the config map "`datakit.conf`", enter "container.conf" for the subpath within the volume, and enter `/usr/local/datakit/conf.d/container/container.conf` for the container mount path, then click "Save".

![image](../images/rancher-datakit/23.png)

2. Container Monitoring View

   Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)" - "Infrastructure" - "Containers", input "host:k8s-node1", display the containers on the k8s-node1 node, and click "ingress".
![image](../images/rancher-datakit/24.png)

Click on "Metrics" to view the DataKit Container monitoring view.
![image](../images/rancher-datakit/25.png)

#### 2.3 Kubernetes Monitoring View

1. Deploy Collector

   The metric-server and Kube-State-Metrics were already installed when installing DataKit.

2. Deploy Kubernetes Monitoring View

   Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "kubernetes monitoring", select "Kubernetes Monitoring View", and click "Confirm".
![image](../images/rancher-datakit/26.png)

Click on the newly created "Kubernetes Monitoring View" to view cluster information.
![image](../images/rancher-datakit/27.png)
![image](../images/rancher-datakit/28.png)

#### 2.4 Kubernetes Overview with Kube State Metrics Monitoring View

1. Enable Collector

   Log in to "Rancher" - "Clusters" - "Storage" - "ConfigMaps", find datakit-conf, and click "Edit Configuration".
![image](../images/rancher-datakit/29.png)

Click "Add", enter the key "kube-state-metrics.conf", and enter the following content for the value, then click "Save".

```toml
          [[inputs.prom]]
            urls = ["http://datakit-kube-state-metrics.datakit.svc.cluster.local:8080/metrics","http://datakit-kube-state-metrics.datakit.svc.cluster.local:8081/metrics"]
            source = "prom_state_metrics"
            metric_types = ["counter", "gauge"]
            interval = "60s"
            tags_ignore = ["access_mode","branch","claim_namespace","cluster_ip","condition","configmap","container","container_id","container_runtime_version","created_by_kind","created_by_name","effect","endpoint","external_name","goversion","host_network","image","image_id","image_spec","ingress","ingressclass","internal_ip","job_name","kernel_version","key","kubelet_version","kubeproxy_version","lease","mutatingwebhookconfiguration","name","networkpolicy","node","node_name","os_image","owner_is_controller","owner_kind","owner_name","path","persistentvolume","persistentvolumeclaim","pod_cidr","pod_ip","poddisruptionbudget","port_name","port_number","port_protocol","priority_class","reason","resource","result","revision","role","secret","service","service_name","service_port","shard_ordinal","status","storageclass","system_uuid","type","uid","unit","version","volume","volumename"]
            metric_name_filter = ["kube_pod_status_phase","kube_pod_container_status_restarts_total","kube_daemonset_status_desired_number_scheduled","kube_daemonset_status_number_ready","kube_deployment_spec_replicas","kube_deployment_status_replicas_available","kube_deployment_status_replicas_unavailable","kube_replicaset_status_ready_replicas","kube_replicaset_spec_replicas","kube_pod_container_status_running","kube_pod_container_status_waiting","kube_pod_container_status_terminated","kube_pod_container_status_ready"]
            #measurement_prefix = ""
            measurement_name = "prom_state_metrics"
            #[[inputs.prom.measurements]]
            # prefix = "cpu_"
            # name = "cpu"
            [inputs.prom.tags]
            namespace = "$NAMESPACE"
            pod_name = "$PODNAME"
```

![image](../images/rancher-datakit/30.png)

Go to "Clusters" - "Workloads" - "DaemonSets", click on the right side of the datakit row, and select "Edit Configuration". <br/>
Click "Storage", find the config map with the volume name "datakit-conf", click "Add", fill in the container mount path with `/usr/local/datakit/conf.d/prom/kube-state-metrics.conf`, and enter `kube-state-metrics.conf` for the subpath within the volume, then click "Save".
![image](../images/rancher-datakit/31.png)

2. Kubernetes Overview with Kube State Metrics Monitoring View

   Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "kubernetes Overview", select "Kubernetes Overview with Kube State Metrics Monitoring View", and click "Confirm".

![image](../images/rancher-datakit/32.png)

Click on the newly created "Kubernetes Overview with KSM Monitoring View" to view cluster information.
![image](../images/rancher-datakit/33.png)

#### 2.5 Kubernetes Overview by Pods Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "kubernetes Overview by", select "Kubernetes Overview by Pods Monitoring View", and click "Confirm".
![image](../images/rancher-datakit/34.png)

Click on the newly created "Kubernetes Overview by Pods Monitoring View" to view cluster information.
![image](../images/rancher-datakit/35.png)

![image](../images/rancher-datakit/36.png)

#### 2.6 Kubernetes Services Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "kubernetes Services", select "Kubernetes Services Monitoring View", and click "Confirm".
![image](../images/rancher-datakit/37.png)

Click on the newly created "Kubernetes Services Monitoring View" to view cluster information.
![image](../images/rancher-datakit/38.png)

### Step 3: Deploy Istio and Applications

#### 3.1 Deploy Istio

Log in to "Rancher" - "Marketplace" - "Charts", and choose Istio for installation.
![image](../images/rancher-datakit/39.png)

#### 3.2 Enable Sidecar Injection

Create a prod namespace and enable automatic Sidecar injection for Pods created in this namespace so that Pod ingress and egress traffic is handled by the Sidecar.

Log in to "Rancher" - "Clusters" - "Projects/Namespace", and click "Create Namespace".

![image](../images/rancher-datakit/40.png)

Enter the name "prod" and click "Create".
![image](../images/rancher-datakit/41.png)

Click on the "Command Line" icon at the top of Rancher, enter "kubectl label namespace prod istio-injection=enabled", and press Enter.
![image](../images/rancher-datakit/42.png)

#### 3.3 Enable Istiod Collector

Log in to "Rancher" - "Clusters" - "Service Discovery" - "Service", check if the Service name is istiod and the namespace is istio-system.
![image](../images/rancher-datakit/43.png)

Log in to "Rancher" - "Clusters" - "Storage" - "ConfigMaps", find datakit-conf, and click "Edit Configuration".
![image](../images/rancher-datakit/44.png)

Click "Add", enter the key "prom-istiod.conf", and enter the following content for the value. Click "Save".

```toml
        [[inputs.prom]]
          url = "http://istiod.istio-system.svc.cluster.local:15014/metrics"
          source = "prom-istiod"
          metric_types = ["counter", "gauge"]
          interval = "60s"
          tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
          #measurement_prefix = ""
          metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
          measurement_name = "istio_prom"
          #[[inputs.prom.measurements]]
          # prefix = "cpu_"
          # name ="cpu"
          [inputs.prom.tags]
            app_id="istiod"
```

![image](../images/rancher-datakit/45.png)

Go to "Clusters" - "Workloads" - "DaemonSets", click on the right side of the datakit row, and select "Edit Configuration".<br/>
Click "Storage", find the config map with the volume name "datakit-conf", click "Add". Fill in the following content and click "Save":

- Container mount path: `/usr/local/datakit/conf.d/prom/prom-istiod.conf`
- Subpath within the volume: `prom-istiod.conf`

![image](../images/rancher-datakit/46.png)

#### 3.4 Enable ingressgateway and egressgateway Collectors

To collect metrics from ingressgateway and egressgateway using Service to access port 15020, you need to create new ingressgateway and egressgateway Services. 

Log in to "Rancher" - "Clusters", click the "Import YAML" icon at the top, enter the following content, and click "Import" to complete the creation of the Service.

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

---
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

![image](../images/rancher-datakit/106.png)

Log in to "Rancher" - "Clusters" - "Storage" - "ConfigMaps", find datakit-conf, and click "Edit Configuration".<br/>
Click "Add", enter the keys "prom-ingressgateway.conf" and "prom-egressgateway.conf", and reference the following content. Click "Save".

```yaml
#### ingressgateway
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
#### egressgateway
prom-egressgateway.conf: |-
  [[inputs.prom]] 
    url = "http://istio-egressgateway-ext.istio-system.svc.cluster.local:15020/stats/prometheus"
    source = "prom-egressgateway"
    metric_types = ["counter", "gauge"]
    interval = "60s"
    tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
    metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
    #measurement_prefix = ""
    measurement_name = "istio_prom"
    #[[inputs.prom.measurements]]
    # prefix = "cpu_"
    # name ="cpu"
```

![image](../images/rancher-datakit/107.png)

Go to "Clusters" - "Workloads" - "DaemonSets", click on the right side of the datakit row, and select "Edit Configuration".<br/>
Click "Storage", find the config map with the volume name "datakit-conf", add two contents and save:<br/>
First click "Add", fill in the following content and click "Save":

- Container mount path: `/usr/local/datakit/conf.d/prom/prom-ingressgateway.conf` 
- Subpath within the volume: `prom-ingressgateway.conf`

Second click "Add", fill in the following content and click "Save":

- Container mount path: `/usr/local/datakit/conf.d/prom/prom-egressgateway.conf`
- Subpath within the volume: `prom-egressgateway.conf`

![image](../images/rancher-datakit/108.png)

#### 3.5 Enable Zipkin Collector

Log in to "Rancher" - "Clusters" - "Storage" - "ConfigMaps", find datakit-conf, and click "Edit Configuration".
![image](../images/rancher-datakit/47.png)

Click "Add", enter the key "zipkin.conf", and enter the following content. Click "Save".

```toml
      [[inputs.zipkin]]
        pathV1 = "/api/v1/spans"
        pathV2 = "/api/v2/spans"
        customer_tags = ["project","version","env"]
```

![image](../images/rancher-datakit/48.png)

Go to "Clusters" - "Workloads" - "DaemonSets", click on the right side of the datakit row, and select "Edit Configuration". Click "Storage", find the config map with the volume name "datakit-conf", click "Add", fill in the following content, and click "Save":

- Container mount path: `/usr/local/datakit/conf.d/zipkin/zipkin.conf`
- Subpath within the volume: `zipkin.conf`
![image](../images/rancher-datakit/49.png)

#### 3.6 Map DataKit Service

In the Kubernetes cluster, after deploying DataKit as a DaemonSet, if a previously deployed application pushes trace data to the zipkin service in the istio-system namespace on port 9411, i.e., the access address is `zipkin.istio-system.svc.cluster.local:9411`, you need to use Kubernetes ExternalName service type.

First, define a ClusterIP service type to forward port 9529 to 9411, then use an ExternalName service to map the ClusterIP service to a DNS name. Through these two steps, the application can connect with DataKit.

1. Define Cluster IP Service

Log in to "Rancher" - "Clusters" - "Service Discovery" - "Service", click "Create" - Select "Cluster IP".
![image](../images/rancher-datakit/50.png)

Enter the namespace "datakit", name "datakit-service-ext", listening port "9411", and target port "9529".
![image](../images/rancher-datakit/51.png)

Click "Selector", enter the key "app" and value "datakit", and click "Save".
![image](../images/rancher-datakit/52.png)

2. Define ExternalName Service

"Clusters" - "Service Discovery" - "Service", click "Create" - Select "External DNS Service Name".
![image](../images/rancher-datakit/53.png)

Enter the namespace "istio-system", name "zipkin", DNS name "datakit-service-ext.datakit.svc.cluster.local", and click "Create".
![image](../images/rancher-datakit/54.png)

#### 3.7 Create Gateway Resource

Log in to "Rancher" - "Clusters" - "Istio" - "Gateways", and click the "Import YAML" icon at the top.
![image](../images/rancher-datakit/55.png)

Enter the namespace "prod", input the following content, and click "Import".

```yaml
apiVersion: networking.istio.io/v1alpha3
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
```

![image](../images/rancher-datakit/56.png)

#### 3.8 Create Virtual Service

Log in to "Rancher" - "Clusters" - "Istio" - "VirtualServices", and click the "Import YAML" icon at the top.<br/>
Enter the namespace "prod", input the following content, and click "Import".

```yaml
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

![image](../images/rancher-datakit/57.png)

#### 3.9 Create productpage, details, ratings

Annotations are added to the Pods to collect Pod metrics, as shown below.

```yaml
annotations:
  datakit/prom.instances: |
    [[inputs.prom]]
      url = "http://$IP:15020/stats/prometheus"
      source = "bookinfo-istio-product"
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
  proxy.istio.io/config: |
    tracing:
      zipkin:
        address: zipkin.istio-system:9411
      custom_tags:
        project:
          literal:
            value: "productpage"
        version:
          literal:
            value: "v1"
        env:
          literal:
            value: "test"
```

Parameter Explanation

- url: Exporter address
- source: Collector name
- metric_types: Metric type filtering
- measurement_name: Name of the collected Measurement
- interval: Collection frequency in seconds
- $IP: Wildcard for Pod internal IP
- $NAMESPACE: Namespace where the Pod resides
- tags_ignore: Ignored tags.

Below is the complete deployment file for productpage, details, ratings.

??? quote "Complete Deployment File"

    ```yaml
    ##################################################################################################
    # Details service
    ##################################################################################################
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
                source = "bookinfo-istio-details"
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
            proxy.istio.io/config: |
              tracing:
                zipkin:
                  address: zipkin.istio-system:9411
                custom_tags:
                  project:
                    literal:
                      value: "details"
                  version:
                    literal:
                      value: "v1"
                  env:
                    literal:
                      value: "test"
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
            app            app: ratings
            version: v1
          annotations:
            datakit/prom.instances: |
              [[inputs.prom]]
                url = "http://$IP:15020/stats/prometheus"
                source = "bookinfo-istio-ratings"
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
            proxy.istio.io/config: |
              tracing:
                zipkin:
                  address: zipkin.istio-system:9411
                custom_tags:
                  project:
                    literal:
                      value: "ratings"
                  version:
                    literal:
                      value: "v1"
                  env:
                    literal:
                      value: "test"
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
    # Productpage services
    ##################################################################################################
    apiVersion: v1
    kind: Service
    metadata:
      name: productpage
      namespace: prod
      labels:
        app: productpage
        service: productpage
    spec:
      ports:
      - port: 9080
        name: http
      selector:
        app: productpage
    ---
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: bookinfo-productpage
      namespace: prod
      labels:
        account: productpage
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: productpage-v1
      namespace: prod
      labels:
        app: productpage
        version: v1
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: productpage
          version: v1
      template:
        metadata:
          labels:
            app: productpage
            version: v1
          annotations:
            datakit/prom.instances: |
              [[inputs.prom]]
                url = "http://$IP:15020/stats/prometheus"
                source = "bookinfo-istio-product"
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
            proxy.istio.io/config: |
              tracing:
                zipkin:
                  address: zipkin.istio-system:9411
                custom_tags:
                  project:
                    literal:
                      value: "productpage"
                  version:
                    literal:
                      value: "v1"
                  env:
                    literal:
                      value: "test"
        spec:
          serviceAccountName: bookinfo-productpage
          containers:
          - name: productpage
            image: docker.io/istio/examples-bookinfo-productpage-v1:1.16.2
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

    ```

Click the "Import YAML" icon at the top. Enter the namespace "prod", input the above content, and click "Import".
![image](../images/rancher-datakit/58.png)
![image](../images/rancher-datakit/59.png)

#### 3.10 Deploy reviews Pipeline

Log in to Gitlab and create a bookinfo-views project.
![image](../images/rancher-datakit/60.png)

Refer to the [Gitlab Integration Documentation](../../integrations/cicd/gitlab.md) to integrate Gitlab with DataKit. Here, only Gitlab CI is configured.

Log in to "Gitlab", go to "bookinfo-views" - "Settings" - "Webhooks", enter the `host IP` of DataKit and DataKit's `9529` port, followed by `/v1/gitlab`. As shown below:
![image](../images/rancher-datakit/61.png)

Select Job events and Pipeline events, and click Add webhook.

![image](../images/rancher-datakit/62.png)

Click Test on the right side of the newly created Webhooks, select "Pipeline events", and an HTTP 200 response indicates successful configuration.
![image](../images/rancher-datakit/63.png)

Enter the "bookinfo-views" project, create `deployment.yaml` and `.gitlab-ci.yml` files in the root directory. Annotations define project, env, and version labels for distinguishing different projects and versions.

??? quote "Configuration Files"

    ```yaml
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
      name: reviews-__version__
      namespace: prod
      labels:
        app: reviews
        version: __version__
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: reviews
          version: __version__
      template:
        metadata:
          labels:
            app: reviews
            version: __version__
          annotations:
            datakit/prom.instances: |
              [[inputs.prom]]
                url = "http://$IP:15020/stats/prometheus"
                source = "bookinfo-istio-review"
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
            proxy.istio.io/config: |
              tracing:
                zipkin:
                  address: zipkin.istio-system:9411
                custom_tags:
                  project:
                    literal:
                      value: "reviews"
                  version:
                    literal:
                      value: __version__
                  env:
                    literal:
                      value: "test"
        spec:
          serviceAccountName: bookinfo-reviews
          containers:
            - name: reviews
              image: docker.io/istio/examples-bookinfo-reviews-__version__:1.16.2
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
    ```

```yaml
variables:
  APP_VERSION: "v1"

stages:
  - deploy

deploy_k8s:
  image: bitnami/kubectl:1.22.7
  stage: deploy
  tags:
    - kubernetes-runner
  script:
    - echo "Executing deployment"
    - ls
    - sed -i "s#__version__#${APP_VERSION}#g" deployment.yaml
    - cat deployment.yaml
    - kubectl apply -f deployment.yaml
  after_script:
    - sleep 10
    - kubectl get pod  -n prod
```

Change the value of `APP_VERSION` in the `.gitlab-ci.yml` file to "v1", commit the code once, change it to "v2", and commit the code again.

![image](../images/rancher-datakit/64.png)

![image](../images/rancher-datakit/65.png)

#### 3.11 Access productpage

Click on the "Command Line" icon at the top of Rancher, enter "kubectl get svc -n istio-system" and press Enter.
![image](../images/rancher-datakit/66.png)

From the above figure, you can see that the port is 31409. Based on the server IP, the productpage access path is [http://8.136.193.105:31409/productpage](http://8.136.193.105:31409/productpage).
![image](../images/rancher-datakit/67.png)

### Step 4 Istio Observability

In the previous steps, metrics have been collected for Istiod and the bookinfo application. <<< custom_key.brand_name >>> provides four default monitoring views to observe the operation of Istio.

##### 4.1 Istio Workload Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "Istio", select "Istio Workload Monitoring View", and click "Confirm". Then click on the newly created "Istio Workload Monitoring View" for observation.
![image](../images/rancher-datakit/68.png)
![image](../images/rancher-datakit/69.png)
![image](../images/rancher-datakit/70.png)

##### 4.2 Istio Control Plane Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "Istio", select "Istio Control Plane Monitoring View", and click "Confirm". Then click on the newly created "Istio Control Plane Monitoring View" for observation.
![image](../images/rancher-datakit/71.png)
![image](../images/rancher-datakit/72.png)
![image](../images/rancher-datakit/73.png)

##### 4.3 Istio Service Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "Istio", select "Istio Service Monitoring View", and click "Confirm". Then click on the newly created "Istio Service Monitoring View" for observation.
![image](../images/rancher-datakit/74.png)

##### 4.4 Istio Mesh Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "Istio", select "Istio Mesh Monitoring View", and click "Confirm". Then click on the newly created "Istio Mesh Monitoring View" for observation.
![image](../images/rancher-datakit/75.png)

### Step 5 RUM Observability

##### 5.1 Create User Access Monitoring

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to "User Access Monitoring", create a new application **devops-bookinfo**, and copy the JS below.
![image](../images/rancher-datakit/76.png)

![image](../images/rancher-datakit/77.png)

##### 5.2 Build productpage Image

Download [istio-1.13.2-linux-amd64.tar.gz](https://github.com/istio/istio/releases/download/1.13.2/istio-1.13.2-linux-amd64.tar.gz), extract the file. The JS needs to be placed where all interfaces of the productpage project can access it. In this project, the JS is copied to the `istio-1.13.2\samples\bookinfo\src\productpage\templates\productpage.html` file, where `datakitOrigin` is the address of DataKit.
![image](../images/rancher-datakit/78.png)

Parameter Explanation

- datakitOrigin: Data transmission address, which is the domain name or IP of DataKit, required.
- env: Environment to which the application belongs, required.
- version: Version to which the application belongs, required.
- trackInteractions: Whether to enable user behavior statistics, such as clicking buttons, submitting information, etc., required.
- traceType: Trace type, defaults to ddtrace, optional.
- allowedTracingOrigins: To achieve APM and RUM trace integration, fill in the domain name or IP of the backend service, optional.

Build the image and upload it to the image repository.

```shell
cd istio-1.13.2\samples\bookinfo\src\productpage
docker build -t 172.16.0.238/df-demo/product-page:v1 .
docker push 172.16.0.238/df-demo/product-page:v1
```

##### 5.3 Replace productpage Image

Go to "Clusters" - "Workloads" -> "Deployments", find "productpage-v1" and click "Edit Configuration".

![image](../images/rancher-datakit/79.png)

Replace the image `image: docker.io/istio/examples-bookinfo-productpage-v1:1.16.2` with the following image<br/>`image: 172.16.0.238/df-demo/product-page:v1`, and click "Save".
![image](../images/rancher-datakit/80.png)

##### 5.4 User Access Monitoring

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to "User Access Monitoring", find the **devops-bookinfo** application, click to enter, and view UV, PV, session count, visited pages, etc.
![image](../images/rancher-datakit/81.png)
![image](../images/rancher-datakit/82.png)

Performance Analysis 
![image](../images/rancher-datakit/83.png)

Resource Analysis 
![image](../images/rancher-datakit/84.png)

### Step 6 Log Observability

By default, logs output to `/dev/stdout` are collected when deploying DataKit. Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to "Logs" to view log information. Additionally, <<< custom_key.brand_name >>> provides联动功能 between RUM, APM, and logs. Please refer to the official documentation for the corresponding configuration.
![image](../images/rancher-datakit/85.png)

### Step 7 Gitlab CI Observability

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to "CI", click "Summary" and select the bookinfo-views project to view the execution status of Pipelines and Jobs.
![image](../images/rancher-datakit/86.png)

Go to "CI", click "Explorer", and select gitlab_pipeline.
![image](../images/rancher-datakit/87.png)

![image](../images/rancher-datakit/88.png)

Go to "CI", click "Explorer", and select gitlab_job.
![image](../images/rancher-datakit/89.png)

![image](../images/rancher-datakit/90.png)

### Step 8 Canary Release Observability

The operations include creating DestinationRule and VirtualService to route traffic only to the reviews-v1 version, publishing reviews-v2, routing 10% of traffic to reviews-v2, verifying through <<< custom_key.brand_name >>>, then fully switching traffic to reviews-v2, and decommissioning reviews-v1.

##### 8.1 Create DestinationRule

Log in to "Rancher" - "Clusters" - "Istio" - "DestinationRule", and click "Create".<br/>
Enter the namespace "prod", name "reviews", Input a host "reviews", add "Subset v1" and "Subset v2", detailed information as shown in the figure, and finally click "Create".
![image](../images/rancher-datakit/91.png)

##### 8.2 Create VirtualService

Log in to "Rancher" - "Clusters" - "Istio" - "VirtualServices", click the "Import YAML" icon at the top, input the following content, and click "Import".

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
  namespace: prod
spec:
  hosts:
    - reviews
  http:
    - route:
        - destination:
            host: reviews
            subset: v1
```

##### 8.3 Publish reviews-v2 Version

Log in to "gitlab", find the bookinfo-views project, modify the `.gitlab-ci.yml` file to set `APP_VERSION` to `v2`, and commit the changes.
![image](../images/rancher-datakit/92.png)

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to "CI" -> "Explorer", and you can see that version v2 has been deployed.

![image](../images/rancher-datakit/93.png)

##### 8.4 Switch Traffic to reviews-v2 Version

"Rancher" - "Clusters" - "Istio" - "VirtualServices", click "Edit YAML" next to reviews.
![image](../images/rancher-datakit/94.png)

Add weights so that v1 has a weight of 90 and v2 has a weight of 10, then click "Save".

![image](../images/rancher-datakit/95.png)

##### 8.5 Observe reviews-v2 Operation

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "APM" module, click the icon in the upper-right corner.
![image](../images/rancher-datakit/96.png)

Turn on "Distinguish Environments and Versions", and view the call topology diagram of bookinfo.<br />
![image](../images/rancher-datakit/97.png)

Hover over reviews-v2 to see that v2 is connected to ratings, while reviews-v1 does not call ratings.
![image](../images/rancher-datakit/98.png)

Click "Trace", select the "reviews.prod" service, and click into a trace with the "v2" version.
![image](../images/rancher-datakit/99.png)

View the flame graph.
![image](../images/rancher-datakit/100.png)

View the Span list.
![image](../images/rancher-datakit/101.png)

View the service call relationship.
![image](../images/rancher-datakit/102.png)

You can also see the service call situation in the Istio Mesh Monitoring View, where the traffic ratio between v1 and v2 versions is approximately 9:1.
![image](../images/rancher-datakit/103.png)

##### 8.6 Complete the Release

Through the operations in <<< custom_key.brand_name >>>, this release meets expectations. Go to "Rancher" - "Clusters" - "Istio" - "VirtualServices", click "Edit YAML" next to reviews, set the weight of "v2" to 100 and remove "v1", then click "Save".
![image](../images/rancher-datakit/104.png)

Go to "Clusters" - "Workloads" -> "Deployments", find "reviews-v1" and click "Delete".
![image](../images/rancher-datakit/105.png)