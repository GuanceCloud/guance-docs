# Using Rancher to Deploy and Manage DataKit for Rapid Construction of Kubernetes Observability

---

## Introduction

As enterprises grow, the number of servers, Kubernetes environments, and microservices applications increases. How to efficiently observe these resources and save human and resource costs is a challenge faced by enterprises. By deploying Datakit from the Rancher application store with one click, Guance provides a large number of out-of-the-box observability features for Kubernetes clusters managed by Rancher.

This article uses a familiar service mesh microservice architecture, the Bookinfo case, to detail how to use Guance to enhance end-to-end observability for K8s, Istio, continuous integration, canary releases, etc., in microservices.

Guance is a leading company in cloud-native observability, offering a platform where deploying the DataKit Agent can integrate metrics, traces, and logs from hosts and applications. Users can log into Guance to actively monitor their K8s runtime and microservices application health status in real-time.

## Case Assumptions

Assume a company has several cloud servers, two Kubernetes clusters (one production and one testing environment), with one Master node and two Node nodes in the testing environment. The cloud servers have deployed Harbor and Gitlab, and the Istio project bookinfo is deployed in the Kubernetes testing environment.

Now, we will use Guance to observe hosts, Kubernetes clusters, Gitlab CI, canary releases, RUM, APM, Istio, etc.

## Prerequisites

- Install [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/) 1.18+.
- Install [Rancher](https://rancher.com/docs/rancher/v2.6/en/installation/) and have permissions to operate Kubernetes clusters.
- Install [Gitlab](https://about.gitlab.com/).
- Install [Helm](https://github.com/helm/helm) 3.0+.
- Deploy Harbor repository or other image repositories.

## Procedures

???+ warning

    This example uses the following versions: DataKit `1.4.0`, Kubernetes `1.22.6`, Rancher `2.6.3`, Gitlab `14.9.4`, Istio `1.13.2`. Different versions may result in configuration differences.

### Step 1: Install DataKit Using Rancher

For ease of management, install DataKit in the `datakit` namespace.

Log in to **Rancher** - **Clusters** - **Projects/Namespaces**, and click **Create Namespace**.

![image](../images/rancher-datakit/1.png)

Enter the name `datakit` and click **Create**.
![image](../images/rancher-datakit/2.png)

Go to **Clusters** - **Marketplace** - **Chart Repositories**, and click **Create**.<br/>
Enter the name `datakit`, URL `[https://pubrepo.guance.com/chartrepo/datakit](https://pubrepo.guance.com/chartrepo/datakit)`, and click **Create**.
![image](../images/rancher-datakit/3.png)

Go to **Clusters** - **Marketplace** - **Charts**, select `datakit`, and you will see a chart labeled **DataKit**. Click to enter.
![image](../images/rancher-datakit/4.png)

Click **Install**.
![image](../images/rancher-datakit/5.png)

Select the namespace `datakit` and click **Next**.
![image](../images/rancher-datakit/6.png)

Log in to **[Guance](https://console.guance.com/)**, go to the **Management** module, find the `token` as shown in the figure below, and click the **Copy Icon**.
![image](../images/rancher-datakit/7.png)

Switch to the Rancher interface:

- Replace the token in the figure with the copied token
- Under **Enable The Default Inputs**, add **ebpf collector** by adding “`,ebpf`” at the end (note that it should be separated by commas)
- Add “`,cluster_name_k8s=k8s-prod`” to **DataKit Global Tags**. (where k8s-prod is your cluster name, which you can define yourself, setting global tags for metrics collected from the cluster.)

![image](../images/rancher-datakit/8.png)

Click **Kube-State-Metrics** and choose **Install**.
![image](../images/rancher-datakit/9.png)

Click **metrics-server** and choose **Install**, then click the **Install** button.
![image](../images/rancher-datakit/10.png)

Go to **Clusters** - **Marketplace** - **Installed Apps**, and verify that DataKit has been installed successfully.
![image](../images/rancher-datakit/11.png)

Go to **Clusters** - **Workloads** - **Pods**, and you can see that there are 3 Datakits, 1 kube-state-metrics, and 1 metrics-server running in the `datakit` namespace.
![image](../images/rancher-datakit/12.png)

Since the company has multiple clusters, you need to add the `ENV_NAMESPACE` environment variable. This environment variable is used to differentiate leader elections across different clusters; values for multiple clusters must not be the same.<br/>
Go to **Clusters** - **Workloads** - **DaemonSets**, click on the right side of the datakit row, and select **Edit Configuration**.
![image](../images/rancher-datakit/13.png)

Here, input the variable name `ENV_NAMESPACE`, and the value is `guance-k8s`, then click **Save**.
![image](../images/rancher-datakit/14.png)

### Step 2: Enable Kubernetes Observability

#### 2.1 ebpf Observability

1. Enable Collector

The **ebpf collector** was already enabled when deploying DataKit.

2. ebpf View

Log in to **[Guance](https://console.guance.com/)** - **Infrastructure**, and click `k8s-node1`.

![image](../images/rancher-datakit/15.png)

Click **Network** to view the ebpf monitoring view.

![image](../images/rancher-datakit/16.png)
![image](../images/rancher-datakit/17.png)

#### 2.2 Container Observability

1. Enable Collector

DataKit defaults to enabling the Container collector. Here, we introduce custom collector configurations.

Log in to **Rancher** - **Clusters** - **Storage** - **ConfigMaps**, and click **Create**.

![image](../images/rancher-datakit/18.png)

Input the namespace `datakit`, name `datakit-conf`, key `container.conf`, and enter the following content for the value.

> **Note:** In a production environment, it is recommended to set `container_include_log = []` and `container_exclude_log = ["image:*"]`, then add annotations to the Pods that need log collection to collect logs from specific containers.

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

Fill in the content as shown in the figure and click **Create**.

![image](../images/rancher-datakit/19.png)

Go to **Clusters** - **Workloads** - **DaemonSets**, find datakit, and click **Edit Configuration**.

![image](../images/rancher-datakit/20.png)

Click **Storage**.

![image](../images/rancher-datakit/21.png)

Click **Add Volume** - **ConfigMap**.

![image](../images/rancher-datakit/22.png)

Enter the volume name `datakit-conf`, select the ConfigMap `datakit.conf`, enter the subpath within the volume `container.conf`, and the container mount path `/usr/local/datakit/conf.d/container/container.conf`, then click **Save**.

![image](../images/rancher-datakit/23.png)

2. Container Monitoring View

Log in to **[Guance](https://console.guance.com/)** - **Infrastructure** - **Containers**, input `host:k8s-node1`, display the containers on the k8s-node1 node, and click `ingress`.
![image](../images/rancher-datakit/24.png)

Click **Metrics** to view the DataKit Container monitoring view.
![image](../images/rancher-datakit/25.png)

#### 2.3 Kubernetes Monitoring View

1. Deploy Collector

metric-server and Kube-State-Metrics were already installed when installing DataKit.

2. Deploy Kubernetes Monitoring View

Log in to **[Guance](https://console.guance.com/)**, go to the **Scenarios** module, click **Create Dashboard**, input `kubernetes monitoring`, select **Kubernetes Monitoring View**, and click **Confirm**.
![image](../images/rancher-datakit/26.png)

Click the newly created **Kubernetes Monitoring View** to view cluster information.
![image](../images/rancher-datakit/27.png)
![image](../images/rancher-datakit/28.png)

#### 2.4 Kubernetes Overview with Kube State Metrics Monitoring View

1. Enable Collector

Log in to **Rancher** - **Clusters** - **Storage** - **ConfigMaps**, find datakit-conf, and click **Edit Configuration**.
![image](../images/rancher-datakit/29.png)

Click **Add**, enter the key `kube-state-metrics.conf`, and the value as follows, then click **Save**.

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

Go to **Clusters** - **Workloads** - **DaemonSets**, click on the right side of the datakit row, and select **Edit Configuration**. <br/>
Click **Storage**, find the ConfigMap with the volume name `datakit-conf`, click **Add**, enter the container mount path `/usr/local/datakit/conf.d/prom/kube-state-metrics.conf`, and the subpath within the volume `kube-state-metrics.conf`, then click **Save**.
![image](../images/rancher-datakit/31.png)

2. Kubernetes Overview with Kube State Metrics Monitoring View

Log in to **[Guance](https://console.guance.com/)**, go to the **Scenarios** module, click **Create Dashboard**, input `kubernetes Overview`, select **Kubernetes Overview with Kube State Metrics Monitoring View**, and click **Confirm**.

![image](../images/rancher-datakit/32.png)

Click the newly created **Kubernetes Overview with KSM Monitoring View** to view cluster information.
![image](../images/rancher-datakit/33.png)

#### 2.5 Kubernetes Overview by Pods Monitoring View

Log in to **[Guance](https://console.guance.com/)**, go to the **Scenarios** module, click **Create Dashboard**, input `kubernetes Overview by`, select **Kubernetes Overview by Pods Monitoring View**, and click **Confirm**.
![image](../images/rancher-datakit/34.png)

Click the newly created **Kubernetes Overview by Pods Monitoring View** to view cluster information.
![image](../images/rancher-datakit/35.png)

![image](../images/rancher-datakit/36.png)

#### 2.6 Kubernetes Services Monitoring View

Log in to **[Guance](https://console.guance.com/)**, go to the **Scenarios** module, click **Create Dashboard**, input `kubernetes Services`, select **Kubernetes Services Monitoring View**, and click **Confirm**.
![image](../images/rancher-datakit/37.png)

Click the newly created **Kubernetes Services Monitoring View** to view cluster information.
![image](../images/rancher-datakit/38.png)

### Step 3: Deploy Istio and Applications

#### 3.1 Deploy Istio

Log in to **Rancher** - **Marketplace** - **Charts**, and select Istio for installation.
![image](../images/rancher-datakit/39.png)

#### 3.2 Enable Sidecar Injection

Create a prod namespace and enable automatic Sidecar injection for Pods created in this namespace, allowing Pod ingress and egress traffic to be handled by the Sidecar.

Log in to **Rancher** - **Clusters** - **Projects/Namespaces**, and click **Create Namespace**.

![image](../images/rancher-datakit/40.png)

Enter the name `prod` and click **Create**.
![image](../images/rancher-datakit/41.png)

Click the command line icon at the top of Rancher, enter `kubectl label namespace prod istio-injection=enabled`, and press Enter.
![image](../images/rancher-datakit/42.png)

#### 3.3 Enable Istiod Collector

Log in to **Rancher** - **Clusters** - **Service Discovery** - **Service**, check if the Service name is istiod and the namespace is istio-system.
![image](../images/rancher-datakit/43.png)

Log in to **Rancher** - **Clusters** - **Storage** - **ConfigMaps**, find datakit-conf, and click **Edit Configuration**.
![image](../images/rancher-datakit/44.png)

Click **Add**, enter the key `prom-istiod.conf`, and the value as follows. Click **Save**.

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

Go to **Clusters** - **Workloads** - **DaemonSets**, click on the right side of the datakit row, and select **Edit Configuration**.<br/>
Click **Storage**, find the ConfigMap with the volume name `datakit-conf`, click **Add**. Input the following details and click **Save**:

- Container mount path: `/usr/local/datakit/conf.d/prom/prom-istiod.conf`
- Subpath within the volume: `prom-istiod.conf`

![image](../images/rancher-datakit/46.png)

#### 3.4 Enable ingressgateway and egressgateway Collectors

To access ports 15020 using Services for ingressgateway and egressgateway, you need to create new Services for ingressgateway and egressgateway.

Log in to **Rancher** - **Clusters**, click the **Import YAML** icon at the top, input the following content, and click **Import** to complete the creation of the Service.

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

Log in to **Rancher** - **Clusters** - **Storage** - **ConfigMaps**, find datakit-conf, and click **Edit Configuration**.<br/>
Click **Add**, enter the keys `prom-ingressgateway.conf` and `prom-egressgateway.conf`, and the values as follows. Click **Save**.

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

Go to **Clusters** - **Workloads** - **DaemonSets**, click on the right side of the datakit row, and select **Edit Configuration**.<br/>
Click **Storage**, find the ConfigMap with the volume name `datakit-conf`, add two contents and save:<br/>
First click **Add**, enter the following details and click **Save**:

- Container mount path: `/usr/local/datakit/conf.d/prom/prom-ingressgateway.conf`
- Subpath within the volume: `prom-ingressgateway.conf`

Second click **Add**, enter the following details and click **Save**:

- Container mount path: `/usr/local/datakit/conf.d/prom/prom-egressgateway.conf`
- Subpath within the volume: `prom-egressgateway.conf`

![image](../images/rancher-datakit/108.png)

#### 3.5 Enable Zipkin Collector

Log in to **Rancher** - **Clusters** - **Storage** - **ConfigMaps**, find datakit-conf, and click **Edit Configuration**.
![image](../images/rancher-datakit/47.png)

Click **Add**, enter the key `zipkin.conf`, and the value as follows. Click **Save**.

```toml
      [[inputs.zipkin]]
        pathV1 = "/api/v1/spans"
        pathV2 = "/api/v2/spans"
        customer_tags = ["project","version","env"]
```

![image](../images/rancher-datakit/48.png)

Go to **Clusters** - **Workloads** - **DaemonSets**, click on the right side of the datakit row, and select **Edit Configuration**. Click **Storage**, find the ConfigMap with the volume name `datakit-conf`, click **Add**, enter the following details, and click **Save**:

- Container mount path: `/usr/local/datakit/conf.d/zipkin/zipkin.conf`
- Subpath within the volume: `zipkin.conf`
![image](../images/rancher-datakit/49.png)

#### 3.6 Map DataKit Service

In a Kubernetes cluster, after deploying DataKit as a DaemonSet, if an application previously pushed trace data to the zipkin service in the `istio-system` namespace on port 9411, i.e., the access address is `zipkin.istio-system.svc.cluster.local:9411`, you need to use Kubernetes's ExternalName service type.

First, define a ClusterIP service type to redirect port 9529 to 9411, then use an ExternalName service to map the ClusterIP service to a DNS name. Through these two steps, the application can connect to DataKit.

1. Define Cluster IP Service

Log in to **Rancher** - **Clusters** - **Service Discovery** - **Service**, click **Create** - Select **Cluster IP**.
![image](../images/rancher-datakit/50.png)

Enter the namespace `datakit`, name `datakit-service-ext`, listening port `9411`, and target port `9529`.
![image](../images/rancher-datakit/51.png)

Click **Selector**, enter the key `app`, value `datakit`, and click **Save**.
![image](../images/rancher-datakit/52.png)

2. Define ExternalName Service

Go to **Clusters** - **Service Discovery** - **Service**, click **Create** - Select **External DNS Service Name**.
![image](../images/rancher-datakit/53.png)

Enter the namespace `istio-system`, name `zipkin`, DNS name `datakit-service-ext.datakit.svc.cluster.local`, and click **Create**.
![image](../images/rancher-datakit/54.png)

#### 3.7 Create Gateway Resource

Log in to **Rancher** - **Clusters** - **Istio** - **Gateways**, click the **Import YAML** icon at the top.
![image](../images/rancher-datakit/55.png)

Enter the namespace `prod`, input the following content, and click **Import**.

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

Log in to **Rancher** - **Clusters** - **Istio** - **VirtualServices**, click the **Import YAML** icon at the top.<br/>
Enter the namespace `prod`, input the following content, and click **Import**.

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

Annotations are added to the Pods to collect metrics, as shown below.

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
- metric_types: Metric type filter
- measurement_name: Name of the collected metrics
- interval: Collection frequency in seconds
- $IP: Wildcard for Pod internal IP
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
                url = "http://$IP:15020/stats