# Deploy and Manage DataKit with Rancher to Quickly Build Kubernetes Observability

---

## Introduction

As a company grows, the number of servers, Kubernetes environments, and microservice applications will increase. How to efficiently observe these resources while saving manpower and resource costs is a challenge faced by enterprises. By deploying Datakit from the Rancher application store with one click, <<< custom_key.brand_name >>> provides a large number of ready-to-use observability features for K8s clusters managed by Rancher.

This article uses a well-known service mesh microservice architecture example, Bookinfo, to explain in detail how to use <<< custom_key.brand_name >>> to enhance end-to-end observability of K8s, istio, continuous integration, and canary releases.

<<< custom_key.brand_name >>> is a leading company dedicated to observability in the cloud-native field. Using one platform and deploying the DataKit Agent can connect the metrics, traces, and logs of hosts and applications. Users can log into <<< custom_key.brand_name >>> to actively monitor their K8s runtime and microservice application health status in real time.

## Case Assumptions

Assume that a company has several cloud servers, two Kubernetes clusters: one for production and one for testing. The test environment has one Master node and two Node nodes. Harbor and Gitlab are deployed on the cloud servers, and the Istio project bookinfo is deployed in the Kubernetes test environment.

Now, use <<< custom_key.brand_name >>> to perform observability on hosts, Kubernetes clusters, Gitlab CI, canary releases, RUM, APM, and Istio.

## Prerequisites

- Install [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/) 1.18+.
- Install [Rancher](https://rancher.com/docs/rancher/v2.6/en/installation/) and have permissions to operate Kubernetes clusters.
- Install [Gitlab](https://about.gitlab.com/).
- Install [Helm](https://github.com/helm/helm) 3.0+.
- Deploy Harbor or other image repositories.

## Operation Steps

???+ warning

    The following versions are used in this example: DataKit `1.4.0`, Kubernetes 1`.22.6`, Rancher `2.6.3`, Gitlab `14.9.4`, Istio `1.13.2`. Configuration differences may occur depending on the version.

### Step 1: Install DataKit with Rancher

For easier management, install DataKit in the datakit namespace. <br/>
Log in to "Rancher" - "Cluster" - "Project/Namespace", and click "Create Namespace".

![image](../images/rancher-datakit/1.png)

Enter the name as "datakit" and click "Create".
![image](../images/rancher-datakit/2.png)

"Cluster" - "Application Market" - "Chart Repository", click "Create".<br/>
Enter the name as "datakit", URL as `[https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/datakit](https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/datakit)`, and click "Create".
![image](../images/rancher-datakit/3.png)

"Cluster" - "Application Market" - "Charts", select "datakit", and you'll see the chart labeled **DataKit**. Click inside.
![image](../images/rancher-datakit/4.png)

Click "Install".
![image](../images/rancher-datakit/5.png)

Select the namespace as "datakit" and click "Next".
![image](../images/rancher-datakit/6.png)

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)" and enter the "Manage" module. Find the token shown in the figure below, and click the "Copy Icon" next to it.
![image](../images/rancher-datakit/7.png)

Switch to the Rancher interface:

- Replace the token in the figure with the token copied earlier.
- Under "Enable The Default Inputs," add "ebpf collector" by adding "`,ebpf`" at the end (**note that commas are used as separators**).
- Under "DataKit Global Tags," add "`,cluster_name_k8s=k8s-prod`" at the end. (Here, k8s-prod is your cluster name, which you can define yourself to set global tags for collected metrics.)

![image](../images/rancher-datakit/8.png)

Click "Kube-State-Metrics" and choose "Install".
![image](../images/rancher-datakit/9.png)

Click "metrics-server" and choose "Install", then click the "Install" button.
![image](../images/rancher-datakit/10.png)

Go to "Cluster" - "Application Market" - "Installed Apps" to check that DataKit has been successfully installed.
![image](../images/rancher-datakit/11.png)

Go to "Cluster" - "Workloads" - "Pods", and you can see that there are 3 running Datakits, 1 kube-state-metrics, and 1 metrics-server in the datakit namespace.
![image](../images/rancher-datakit/12.png)

Since the company has multiple clusters, you need to add the `ENV_NAMESPACE` environment variable. This variable distinguishes elections between different clusters, and the values for multiple clusters must not be the same.<br/>
Go to "Cluster" - "Workloads" - "DaemonSets", click the right side of the datakit row, and choose "Edit Configuration".
![image](../images/rancher-datakit/13.png)

Input the variable name as `ENV_NAMESPACE`, value as `guance-k8s`, and click "Save".
![image](../images/rancher-datakit/14.png)

### Step 2: Enable Kubernetes Observability

#### 2.1 ebpf Observability

1. Enable Collector

The **ebpf collector** has already been enabled when deploying DataKit.

2. ebpf View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)" - "Infrastructure", and click "k8s-node1".

![image](../images/rancher-datakit/15.png)

Click "Network" to view the ebpf monitoring view.

![image](../images/rancher-datakit/16.png)
![image](../images/rancher-datakit/17.png)

#### 2.2 Container Observability

1. Enable Collector

DataKit has default container collection enabled; here's an introduction to custom collector configuration.

Log in to "Rancher" - "Cluster" - "Storage" - "ConfigMaps", and click "Create".

![image](../images/rancher-datakit/18.png)

Enter the namespace as "datakit", the name as "datakit-conf", the key as "container.conf", and input the following content for the value.

> **Note:** In a production environment, it is recommended to set `container_include_log = []` and `container_exclude_log = ["image:*"]`, then add annotations to Pods requiring log collection to collect specified container logs.

```toml
      [inputs.container]
        docker_endpoint = "unix:///var/run/docker.sock"
        containerd_address = "/var/run/containerd/containerd.sock"

        enable_container_metric = true
        enable_k8s_metric = true
        enable_pod_metric = true

        ## Containers logs to include and exclude, default collect all containers. Globs accepted.
        container_include_log = []
        container_exclude_log = ["image:pubrepo.<<< custom_key.brand_main_domain >>>/datakit/logfwd*", "image:pubrepo.<<< custom_key.brand_main_domain >>>/datakit/datakit*"]

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

Fill in the content as shown in the figure below, and click "Create".

![image](../images/rancher-datakit/19.png)

Go to "Cluster" - "Workloads" - "DaemonSets", find datakit, and click "Edit Configuration".

![image](../images/rancher-datakit/20.png)

Click "Storage".

![image](../images/rancher-datakit/21.png)

Click "Add Volume" - "Configuration Map".

![image](../images/rancher-datakit/22.png)

Enter the volume name as "datakit-conf", select the configuration map as "`datakit.conf`", enter the subpath within the volume as "`container.conf`", and enter the container mount path as `/usr/local/datakit/conf.d/container/container.conf`, then click "Save".

![image](../images/rancher-datakit/23.png)

2. Container Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)" - "Infrastructure" - "Containers", input "`host:k8s-node1`", display the containers of the k8s-node1 node, and click "ingress".
![image](../images/rancher-datakit/24.png)

Click "Metrics" to view the DataKit Container monitoring view.
![image](../images/rancher-datakit/25.png)

#### 2.3 Kubernetes Monitoring View

1. Deploy Collector

The metric-server and Kube-State-Metrics have already been installed when installing DataKit.

2. Deploy Kubernetes Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "Kubernetes Monitoring", select "Kubernetes Monitoring View", and click "Confirm".
![image](../images/rancher-datakit/26.png)

Click the newly created "Kubernetes Monitoring View" to check cluster information.
![image](../images/rancher-datakit/27.png)
![image](../images/rancher-datakit/28.png)

#### 2.4 Kubernetes Overview with Kube State Metrics Monitoring View

1. Enable Collector

Log in to "Rancher" - "Cluster" - "Storage" - "ConfigMaps", find datakit-conf, and click "Edit Configuration".
![image](../images/rancher-datakit/29.png)

Click "Add", input the key as "`kube-state-metrics.conf`", and input the following content for the value, then click "Save".

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

Go to "Cluster" - "Workloads" - "DaemonSets", click the right side of the datakit row, and select "Edit Configuration". <br/>
Click "Storage", find the configuration mapping with the volume name "datakit-conf", click "Add", fill in the container mount path as "`/usr/local/datakit/conf.d/prom/kube-state-metrics.conf`", and input the subpath within the volume as "`kube-state-metrics.conf`", then click "Save".
![image](../images/rancher-datakit/31.png)

2. Kubernetes Overview with Kube State Metrics Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "Kubernetes Overview", select "Kubernetes Overview with Kube State Metrics Monitoring View", and click "Confirm".

![image](../images/rancher-datakit/32.png)

Click the newly created "Kubernetes Overview with KSM Monitoring View" to check cluster information.
![image](../images/rancher-datakit/33.png)

#### 2.5 Kubernetes Overview by Pods Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "Kubernetes Overview by", select "Kubernetes Overview by Pods Monitoring View", and click "Confirm".
![image](../images/rancher-datakit/34.png)

Click the newly created "Kubernetes Overview by Pods Monitoring View" to check cluster information.
![image](../images/rancher-datakit/35.png)

![image](../images/rancher-datakit/36.png)

#### 2.6 Kubernetes Services Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "Kubernetes Services", select "Kubernetes Services Monitoring View", and click "Confirm".
![image](../images/rancher-datakit/37.png)

Click the newly created "Kubernetes Services Monitoring View" to check cluster information.
![image](../images/rancher-datakit/38.png)

### Step 3: Deploy Istio and Application

#### 3.1 Deploy Istio

Log in to "Rancher" - "Application Market" - "Charts", and choose Istio for installation.
![image](../images/rancher-datakit/39.png)

#### 3.2 Enable Sidecar Injection

Create a prod namespace and enable automatic Sidecar injection in this space so that Pod ingress and egress traffic are handled by Sidecar.

Log in to "Rancher" - "Cluster" - "Projects/Namespace", and click "Create Namespace".

![image](../images/rancher-datakit/40.png)

Input the name as "prod" and click "Create".
![image](../images/rancher-datakit/41.png)

Click the "Command Line" icon at the top of Rancher, input "`kubectl label namespace prod istio-injection=enabled`", and press Enter.
![image](../images/rancher-datakit/42.png)

#### 3.3 Enable Istiod Collector

Log in to "Rancher" - "Cluster" - "Service Discovery" - "Service", check the Service name istiod, and the space is istio-system.
![image](../images/rancher-datakit/43.png)

Log in to "Rancher" - "Cluster" - "Storage" - "ConfigMaps", find datakit-conf, and click "Edit Configuration".
![image](../images/rancher-datakit/44.png)

Click "Add", input the key as "`prom-istiod.conf`", and input the following content for the value. Click "Save".

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

Go to "Cluster" - "Workloads" - "DaemonSets", click the right side of the datakit row, and select "Edit Configuration".<br/>
Click "Storage", find the configuration mapping with the volume name "datakit-conf", click "Add". Input the following content and click "Save":

- Container mount path fills `/usr/local/datakit/conf.d/prom/prom-istiod.conf`
- Subpath within the volume inputs `prom-istiod.conf`

![image](../images/rancher-datakit/46.png)

#### 3.4 Enable ingressgateway and egressgateway Collectors

To collect ingressgateway and egressgateway using Service to access port 15020, you need to create ingressgateway and egressgateway Services.

Log in to "Rancher" - "Cluster", click the "Import YAML" icon at the top, input the following content, and click "Import" to complete the creation of the Service.

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

Log in to "Rancher" - "Cluster" - "Storage" - "ConfigMaps", find datakit-conf, and click "Edit Configuration".<br/>
Click "Add", input the keys as "`prom-ingressgateway.conf`" and "`prom-egressgateway.conf`", and reference the following content. Click "Save".

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

Go to "Cluster" - "Workloads" - "DaemonSets", click the right side of the datakit row, and select "Edit Configuration".<br/>
Click "Storage", find the configuration mapping with the volume name "datakit-conf", add twice and save:<br/>
First click "Add", input the following content and click "Save":

- Container mount path fills `/usr/local/datakit/conf.d/prom/prom-ingressgateway.conf` 
- Subpath within the volume inputs `prom-ingressgateway.conf`

Second click "Add", input the following content and click "Save":

- Container mount path fills `/usr/local/datakit/conf.d/prom/prom-egressgateway.conf`
- Subpath within the volume inputs `prom-egressgateway.conf`

![image](../images/rancher-datakit/108.png)

#### 3.5 Enable Zipkin Collector

Log in to "Rancher" - "Cluster" - "Storage" - "ConfigMaps", find datakit-conf, and click "Edit Configuration".
![image](../images/rancher-datakit/47.png)

Click "Add", input the key as "`zipkin.conf`", and input the following content. Click "Save".

```toml
      [[inputs.zipkin]]
        pathV1 = "/api/v1/spans"
        pathV2 = "/api/v2/spans"
        customer_tags = ["project","version","env"]
```

![image](../images/rancher-datakit/48.png)

Go to "Cluster" - "Workloads" - "DaemonSets", click the right side of the datakit row, and select "Edit Configuration". Click "Storage", find the configuration mapping with the volume name "datakit-conf", click "Add", input the following content and click "Save":

- Container mount path fills `/usr/local/datakit/conf.d/zipkin/zipkin.conf`
- Subpath within the volume inputs `zipkin.conf`
![image](../images/rancher-datakit/49.png)

#### 3.6 Map DataKit Service

In the Kubernetes cluster, after deploying DataKit in DaemonSet mode, if there was previously an application pushing trace data to the zipkin service in the istio-system namespace on port 9411, i.e., the access address is `zipkin.istio-system.svc.cluster.local:9411`, then you need to use the ExternalName service type in Kubernetes.

First define a ClusterIP service type, convert port 9529 to 9411, and then use the ExternalName service to map the ClusterIP service to a DNS name. Through these two steps of conversion, the application can be connected to DataKit.

1. Define Cluster IP Service

Log in to "Rancher" - "Cluster" - "Service Discovery" - "Service", click "Create" - Select "Cluster IP".
![image](../images/rancher-datakit/50.png)

Input the namespace as "`datakit`", the name as "`datakit-service-ext`", the listening port as "`9411`", and the target port as "`9529`".
![image](../images/rancher-datakit/51.png)

Click "Selector", input the key as "app", the value as "datakit", and click "Save".
![image](../images/rancher-datakit/52.png)

2. Define ExternalName Service

"Cluster" - "Service Discovery" - "Service", click "Create" - Select "External DNS Service Name".
![image](../images/rancher-datakit/53.png)

Input the namespace as "istio-system", the name as "zipkin", and the DNS name as "datakit-service-ext.datakit.svc.cluster.local", then click "Create".
![image](../images/rancher-datakit/54.png)

#### 3.7 Create Gateway Resource

Log in to "Rancher" - "Cluster" - "Istio" - "Gateways", click the "Import YAML" icon at the top.
![image](../images/rancher-datakit/55.png)

Input the namespace as "prod", and input the following content, then click "Import".

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

Log in to "Rancher" - "Cluster" - "Istio" - "VirtualServices", click the "Import YAML" icon at the top.<br/>
Input the namespace as "prod", and input the following content, then click "Import".

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

Annotations are added to Pods to collect Pod metrics, as shown below.

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

Parameter Description

- url: Exporter address
- source: Collector name
- metric_types: Metric type filtering
- measurement_name: Name of the collected Measurement
- interval: Metric collection frequency, s seconds
- $IP: Wildcard for the Pod's internal IP
- $NAMESPACE: Namespace where the Pod resides
- tags_ignore: Ignored tags.

Below are the complete deployment files for productpage, details, and ratings.

??? quote "Complete Deployment Files"

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
      labels```yaml
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

Click the "Import YAML" icon at the top. Input the namespace as "prod", input the content above, and click "Import".
![image](../images/rancher-datakit/58.png)
![image](../images/rancher-datakit/59.png)

#### 3.10 Deploy Reviews Pipeline

Log in to Gitlab and create the bookinfo-views project.
![image](../images/rancher-datakit/60.png)

Refer to the [Gitlab Integration Document](../../integrations/cicd/gitlab.md) to connect Gitlab with DataKit; here we only configure Gitlab CI.

Log in to "Gitlab", go to "bookinfo-views" - "Settings" - "Webhooks", input the `host IP` and DataKit's `9529` port in the URL, followed by `/v1/gitlab`. As shown below:
![image](../images/rancher-datakit/61.png)

Check Job events and Pipeline events, then click Add webhook.

![image](../images/rancher-datakit/62.png)

Click Test on the right side of the newly created Webhook, select "Pipeline events", and an HTTP 200 status code indicates successful configuration.
![image](../images/rancher-datakit/63.png)

Go to the "bookinfo-views" project, create a `deployment.yaml` and `.gitlab-ci.yml` file in the root directory. Annotations define project, env, and version labels for distinguishing different projects and versions.

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

         Modify the value of `APP_VERSION` in the `.gitlab-ci.yml` file to "v1", commit once, modify it to "v2", and commit again.

![image](../images/rancher-datakit/64.png)

![image](../images/rancher-datakit/65.png)

#### 3.11 Access productpage

Click the "Command Line" icon at the top of Rancher, input "kubectl get svc -n istio-system" and press Enter.
![image](../images/rancher-datakit/66.png)

In the figure above, you can see the port is 31409, so the access path for productpage based on the server IP is [http://8.136.193.105:31409/productpage](http://8.136.193.105:31409/productpage).
![image](../images/rancher-datakit/67.png)

### Step 4 Istio Observability

In the steps above, metrics collection has been done for Istiod and the bookinfo application. <<< custom_key.brand_name >>> provides four monitoring views by default to observe the operation of Istio.

##### 4.1 Istio Workload Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "Istio", select "Istio Workload Monitoring View", and click "Confirm". Then click the newly created "Istio Workload Monitoring View" to observe.
![image](../images/rancher-datakit/68.png)
![image](../images/rancher-datakit/69.png)
![image](../images/rancher-datakit/70.png)

##### 4.2 Istio Control Plane Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "Istio", select "Istio Control Plane Monitoring View", and click "Confirm". Then click the newly created "Istio Control Plane Monitoring View" to observe.
![image](../images/rancher-datakit/71.png)
![image](../images/rancher-datakit/72.png)
![image](../images/rancher-datakit/73.png)

##### 4.3 Istio Service Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "Istio", select "Istio Service Monitoring View", and click "Confirm". Then click the newly created "Istio Service Monitoring View" to observe.
![image](../images/rancher-datakit/74.png)

##### 4.4 Istio Mesh Monitoring View

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Scenarios" module, click "Create Dashboard", input "Istio", select "Istio Mesh Monitoring View", and click "Confirm". Then click the newly created "Istio Mesh Monitoring View" to observe.
![image](../images/rancher-datakit/75.png)

### Step 5 RUM Observability

##### 5.1 Create User Access Monitoring

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to "User Access Monitoring", create a new application **devops-bookinfo**, and copy the JS below.
![image](../images/rancher-datakit/76.png)

![image](../images/rancher-datakit/77.png)

##### 5.2 Build productpage Image

Download [istio-1.13.2-linux-amd64.tar.gz](https://github.com/istio/istio/releases/download/1.13.2/istio-1.13.2-linux-amd64.tar.gz), extract the file. The JS mentioned above needs to be placed where all interfaces of the productpage project can access it. In this project, the JS is copied into the `istio-1.13.2\samples\bookinfo\src\productpage\templates\productpage.html` file, where datakitOrigin is the address of DataKit.
![image](../images/rancher-datakit/78.png)

Parameter Description

- datakitOrigin: Data transmission address, which is the domain name or IP of DataKit, mandatory.
- env: Application environment, mandatory.
- version: Application version, mandatory.
- trackInteractions: Whether to enable user behavior statistics, such as button clicks, form submissions, etc., mandatory.
- traceType: Trace type, default is ddtrace, optional.
- allowedTracingOrigins: To achieve APM and RUM trace integration, fill in the domain name or IP of the backend service, optional.

Build the image and upload it to the image repository.

```shell
cd istio-1.13.2\samples\bookinfo\src\productpage
docker build -t 172.16.0.238/df-demo/product-page:v1 .
docker push 172.16.0.238/df-demo/product-page:v1
```

##### 5.3 Replace productpage Image

Go to "Cluster" - "Workloads" -> "Deployments", find "productpage-v1" and click "Edit Configuration".

![image](../images/rancher-datakit/79.png)

Replace the image `image: docker.io/istio/examples-bookinfo-productpage-v1:1.16.2` with the following image<br />`image: 172.16.0.238/df-demo/product-page:v1`, then click "Save".
![image](../images/rancher-datakit/80.png)

##### 5.4 User Access Monitoring

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to "User Access Monitoring", find the **devops-bookinfo** application, click to enter, and view UV, PV, session count, accessed pages, etc.
![image](../images/rancher-datakit/81.png)
![image](../images/rancher-datakit/82.png)

Performance Analysis 
![image](../images/rancher-datakit/83.png)

Resource Analysis 
![image](../images/rancher-datakit/84.png)

### Step 6 Log Observability

Based on the configuration during DataKit deployment, logs output to /dev/stdout are collected by default. Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to "Logs" to view log information. Additionally, <<< custom_key.brand_name >>> also provides联动 functionality between RUM, APM, and logs. Please refer to the official documentation for corresponding configurations.
![image](../images/rancher-datakit/85.png)

### Step 7 Gitlab CI Observability

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to "CI", click "Overview", select the bookinfo-views project, and view the execution status of Pipelines and Jobs.
![image](../images/rancher-datakit/86.png)

Go to "CI", click "Explorer", and select gitlab_pipeline.
![image](../images/rancher-datakit/87.png)

![image](../images/rancher-datakit/88.png)

Go to "CI", click "Explorer", and select gitlab_job.
![image](../images/rancher-datakit/89.png)

![image](../images/rancher-datakit/90.png)

### Step 8 Canary Release Observability

The procedure is to first create DestinationRule and VirtualService, directing traffic only to the reviews-v1 version, publish reviews-v2, divert 10% of the traffic to reviews-v2, verify through <<< custom_key.brand_name >>>, then fully switch the traffic to reviews-v2, and decommission reviews-v1.

##### 8.1 Create DestinationRule

Log in to "Rancher" - "Cluster" - "Istio" - "DestinationRule", click "Create".<br/>
Input the namespace as "prod", name as "reviews", Input a host as "reviews", add "Subset v1" and "Subset v2", detailed information as shown in the figure below, finally click "Create".
![image](../images/rancher-datakit/91.png)

##### 8.2 Create VirtualService

Log in to "Rancher" - "Cluster" - "Istio" - "VirtualServices", click the "Import YAML" icon at the top, input the following content, then click "Import".

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

Log in to "gitlab", find the bookinfo-views project, modify the `APP_VERSION` value in the `.gitlab-ci.yml` file to `v2`, and commit the code.
![image](../images/rancher-datakit/92.png)

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to "CI" -> "Explorer", and you can see that the v2 version has been published.

![image](../images/rancher-datakit/93.png)

##### 8.4 Switch Traffic to reviews-v2 Version

"Rancher" - "Cluster" - "Istio" - "VirtualServices", click "Edit YAML" next to reviews.
![image](../images/rancher-datakit/94.png)

Add weights of 90 for v1 and 10 for v2, and finally click "Save".

![image](../images/rancher-datakit/95.png)

##### 8.5 Observe reviews-v2 Operation

Log in to "[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)", go to the "Application Performance Monitoring" module, and click the icon at the top right corner.
![image](../images/rancher-datakit/96.png)

Turn on "Distinguish Environment and Version", and check the service call topology diagram for bookinfo.<br />
![image](../images/rancher-datakit/97.png)

Hover over reviews-v2, and you can see that v2 connects to ratings, while reviews-v1 does not call ratings.
![image](../images/rancher-datakit/98.png)

Click "Trace", select the "reviews.prod" service, and enter a trace with "v2" version.
![image](../images/rancher-datakit/99.png)

View the flame graph.
![image](../images/rancher-datakit/100.png)

View the Span list.
![image](../images/rancher-datakit/101.png)

View the service call relationship.
![image](../images/rancher-datakit/102.png)

You can also see the service call situation in the Istio Mesh Monitoring View, with v1 and v2 version traffic roughly 9:1.
![image](../images/rancher-datakit/103.png)

##### 8.6 Complete the Release

Through operations in <<< custom_key.brand_name >>>, this release meets expectations. "Rancher" - "Cluster" - "Istio" - "VirtualServices", click "Edit YAML" next to reviews, set the weight for "v2" to 100 and remove "v1", then click "Save".
![image](../images/rancher-datakit/104.png)

Go to "Cluster" - "Workloads" -> "Deployments", find "reviews-v1" and click "Delete".
![image](../images/rancher-datakit/105.png)