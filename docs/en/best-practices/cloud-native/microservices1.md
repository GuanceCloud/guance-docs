# Best Practices for the Entire Process of Microservice Architecture Development to Canary Release (Part 1)

---

## Introduction

After a typical enterprise creates its container cloud environment, in order to simplify complex release processes, it usually uses GitlabCi and Jenkins for application deployment. At the same time, it considers using Rancher for unified resource orchestration management and simplifies application management through Rancher's app store. By installing DataKit with one click via the app store (for specific instructions, see the Helm installation method in the DataKit documentation), <<< custom_key.brand_name >>> provides a large number of out-of-the-box observability features for Kubernetes clusters managed by Rancher. This article explains in detail how to use <<< custom_key.brand_name >>> to achieve observability for GitlabCI, Kubernetes, and microservices using a well-known Bookinfo example.

## Case Assumptions

A company manages two sets of Kubernetes environments using Rancher: one for development testing and one for production. The company has deployed gitlab in the development testing environment for CICD. The BookInfo project is an e-bookstore and a typical multi-language microservice project. A version under development is deployed in the development testing environment. After passing the test, a canary gray release is performed on the production environment's BookInfo. The company’s observability system components are as follows: <br />1.1 SREs observe the overall Kubernetes resources of both environments on <<< custom_key.brand_name >>>, making capacity planning and emergency handling.<br />2.1 Developers observe the CICD process to understand the speed and quality of software iteration and handle faulty pipelines promptly.<br />2.2 SREs observe the canary release in the production environment to understand the state of traffic switching and rollback in a timely manner to avoid affecting production users.<br />3.1 SREs perform trace analysis across the entire application using Istio and view key health Metrics on <<< custom_key.brand_name >>>, handling abnormal requests promptly.<br />3.2 Developers manage their own logs and find log contexts through trace analysis on <<< custom_key.brand_name >>> when encountering health issues to solve problems.<br />We will explain the overall practice in three parts.

## Prerequisites

- Install [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/).
- Install [Rancher](https://rancher.com/docs/rancher/v2.6/en/installation/).
- Install [Gitlab](https://about.gitlab.com/).
- Install the [Metrics-Server component](https://github.com/kubernetes-sigs/metrics-server#installation).
- Deploy the harbor repository or another image repository.
- Deploy Istio and familiarize yourself with [Best Practices for Observability in Microservices Based on Istio](../istio).
- Configure Gitlab-runner and familiarize yourself with [Best Practices for Observability in Gitlab-CI](../monitoring/gitlab-ci).

## Deployment Steps

### Step 1: Installing DataKit Using Rancher

#### 1.1 Deploy DataKit

##### 1.1.1 Download Deployment File

Log in to ‘[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)’, click the ‘Integration’ module, then click ‘DataKit’ in the upper left corner, select ‘Kubernetes’, and download datakit.yaml.

##### 1.1.2 Configure Token

Log in to ‘[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)’, enter the ‘Management’ module, find the token in the diagram below, and replace the value of the ENV_DATAWAY environment variable in datakit.yaml with <your-token>.

```yaml
        - name: ENV_DATAWAY
          value: https://openway.<<< custom_key.brand_main_domain >>>?token=<your-token>
```

![image](../images/microservices/1.png)	 

##### 1.1.3 Set Global Tags

Add cluster_name_k8s=k8s-istio at the end of the ENV_GLOBAL_HOST_TAGS environment variable value in the datakit.yaml file, where k8s-istio is your cluster name. This step sets the global tag for the cluster.

```yaml
        - name: ENV_GLOBAL_HOST_TAGS
          value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-istio
```

##### 1.1.4 Set Namespace

To distinguish between different clusters during DataKit elections, here you need to set the ENV_NAMESPACE environment variable, ensuring that values for different clusters are not the same. Add the following content to the environment variables section in datakit.yaml.

```yaml
        - name: ENV_NAMESPACE
          value: k8s-istio
```

##### 1.1.5 Enable Collectors

Enable ddtrace and statsd collectors. In the datakit.yaml file, find the ENV_DEFAULT_ENABLED_INPUTS environment variable and add statsd,ddtrace at the end.

```yaml
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,ddtrace
```

##### 1.1.6 Deploy DataKit

Log in to ‘Rancher’, under the browse cluster label, select the ‘k8s-solution-cluster’ cluster, open datakit.yaml, and create corresponding resources in the k8s-solution-cluster cluster based on the resource file content.

![image](../images/microservices/2.png)	 

‘Note’: To quickly proceed to the next step, this operation will merge ConfigMap and directly deploy DataKit using the kubectl command.

#### 1.2 Create ConfigMap

Enable container and zipkin collectors by defining container.conf and zipkin.conf first.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    #### container
    container.conf: |-  
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
        ##   bearer_token -> bearer_token_string -> TLS
        ## Use bearer token for authorization. ('bearer_token' takes priority)
        ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
        ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
        bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
        # bearer_token_string = "<your-token-string>"

        [inputs.container.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"
          
    #### zipkin
    zipkin.conf: |-          
        [[inputs.zipkin]]
          pathV1 = "/api/v1/spans"
          pathV2 = "/api/v2/spans"
```

[inputs.container] Parameter Description

- container_include_metric: Metrics of containers that need to be collected.
- container_exclude_metric: Metrics of containers that do not need to be collected.
- container_include_log: Logs of containers that need to be collected.
- container_exclude_log: Logs of containers that do not need to be collected.
- exclude_pause_container: true excludes pause containers.
- `container_include` and `container_exclude` must start with `image`, formatted as `"image:<glob rule>"`, indicating that the glob rule applies to the container image.
- [Glob Rule](https://en.wikipedia.org/wiki/Glob_(programming)) is a lightweight regular expression that supports basic matching units like `*` and `?`.

Then log in to ‘Rancher’, under the browse cluster label, select the ‘k8s-solution-cluster’ cluster, sequentially go into ‘More Resources’ -> ‘Core’ -> ‘ConfigMaps’, and create the defined ConfigMap using yaml format.

![image](../images/microservices/3.png)	 

Finally, associate DataKit with ConfigMap in the ‘k8s-solution-cluster’ cluster. Enter ‘Workload’ -> ‘DaemonSets’, find DataKit, choose ‘Edit YAML’ on the right, and add the following content, then click ‘Save’.

![image](../images/microservices/4.png)	 

```yaml
        - mountPath: /usr/local/datakit/conf.d/container/container.conf
          name: datakit-conf
          subPath: container.conf
        - mountPath: /usr/local/datakit/conf.d/zipkin/zipkin.conf
          name: datakit-conf
          subPath: zipkin.conf
```

If using the kubectl command to create DataKit, add the content defined in ConfigMap at the end of the datakit.yaml file, then add the configuration above to the volumeMounts section in the file.<br />‘Note’: Use --- as a separator.

#### 1.3 Check DataKit Running Status

After successfully deploying DataKit, you should see the running status as shown in the figure below.

![image](../images/microservices/5.png)	 

### Step 2: Mapping DataKit Services

When reporting trace data using Istio, the trace data will be sent to the Service **zipkin.istio-system** on port 9411. Since the DataKit service's namespace is datakit and the port is 9529, a conversion is required here. For details, please refer to [Mapping DataKit Service Using ExternalName in Kubernetes Clusters](../kubernetes-external-name).

### Step 3: Configuring DataKit for DataFlux Function

In order to collect Gitlab execution data when deploying microservices using Gitlab-CI, it is necessary to deploy DataFlux Function and configure DataKit. For detailed steps, please refer to [Best Practices for Observability in Gitlab-CI](../monitoring/gitlab-ci).

### Step 4: Deploying Bookinfo

#### 2.1 Download Source Code

Download [istio-1.13.2.zip](https://github.com/istio/istio/releases). All deployment files used later come from this compressed package. For convenience, we will use the kubectl command instead of Rancher's graphical interface to create resources.

#### 2.2 Enable RUM

To observe information about website calls, you need to enable frontend data collection. Log in to ‘[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)’, enter ‘User Analysis’, create a new application **devops-bookinfo**, and copy the JS below.

![image](../images/microservices/6.png)	 

The above JS needs to be placed in a location accessible to all interfaces of the productpage project. In this project, the JS above is copied to the **istio-1.13.2\samples\bookinfo\src\productpage\templates\productpage.html** file.
‘Note’: Regarding the DataKit address for RUM data reporting, please refer to [Best Practices for RUM Data Reporting DataKit Cluster](../monitoring/rum-datakit-cluster).

![image](../images/microservices/7.png)	 

Then re-release the productpage image and upload it to the image repository.

```shell
cd istio-1.13.2\samples\bookinfo\src\productpage
docker build -t 172.16.0.238/df-demo/product-page:v1  .
docker push 172.16.0.238/df-demo/product-page:v1
```

#### 2.3 Enable Sidecar Injection

Create the prod namespace and enable automatic injection of Sidecars for Pods created in this space, allowing Pod traffic to be handled by Sidecar.

```shell
kubectl create ns prod 
kubectl label namespace prod istio-injection=enabled
```

#### 2.4 Deploy productpage, details, ratings

In the istio-1.13.2\samples\bookinfo\platform\kube\bookinfo.yaml file, remove the part related to the deployment of the reviews microservice, deploy the Services and Deployments to the prod namespace, and add annotations to all Deployment controllers and Pod templates to enable custom collection for Pods. Modify the productpage image to the one created in the previous step. The complete file is as follows:

```yaml

# Copyright Istio Authors
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

##################################################################################################
# This file defines the services, service accounts, and deployments for the Bookinfo sample.
#
# To apply all 4 Bookinfo services, their corresponding service accounts, and deployments:
#
#   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
#
# Alternatively, you can deploy any resource separately:
#
#   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml -l service=reviews # reviews Service
#   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml -l account=reviews # reviews ServiceAccount
#   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml -l app=reviews,version=v3 # reviews-v3 Deployment
##################################################################################################

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
            #measurement_prefix = ""
            metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
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
            source = "bookinfo-istio-ratings"
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
    spec:
      serviceAccountName: bookinfo-productpage
      containers:
      - name: productpage
        #image: docker.io/istio/examples-bookinfo-productpage-v1:1.16.2
        image: 172.16.0.238/df-demo/product-page:v1
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

```shell
kubectl apply -f bookinfo.yaml
```

#### 2.5 Create Gateway Resources and Virtual Services

Modify the istio-1.13.2\samples\bookinfo\networking\bookinfo-gateway.yaml file to add the prod namespace.

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

```shell
kubectl apply -f bookinfo-gateway.yaml 
```

#### 2.6 Access productpage

View the exposed ports of ingresgateway.

```shell
kubectl get svc -n istio-system
```

![image](../images/microservices/8.png)	 

According to the virtual service rules, access [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage) in the browser to access productpage. Since the reviews service hasn't been deployed yet, the prompt **Sorry, product reviews are currently unavailable for this book** will appear.
		
![image](../images/microservices/9.png)	 

### Step 5: Automated Deployment

#### 5.1 Create Gitlab Project

Log in to Gitlab and create the bookinfo-views project.
		
![image](../images/microservices/10.png)
	 
#### 5.2 Connect Gitlab with DataKit

Refer to the [Gitlab Integration Documentation](/integrations/gitlab) to connect Gitlab and DataKit. Here, only Gitlab CI is configured.<br />        Log in to ‘Gitlab’, enter ‘bookinfo-views’ -> ‘Settings’ -> ‘Webhooks’, input the URL with the host IP of DataKit and the 9529 port of DataKit, then add /v1/gitlab. As shown in the figure below.

![image](../images/microservices/11.png)	 

Select Job events and Pipeline events, then click Add webhook.
		
![image](../images/microservices/12.png)

Click Test on the right side of the just-created Webhook, select Pipeline events, and the appearance of HTTP 200 in the figure below indicates successful configuration.
			
![image](../images/microservices/13.png)	 

       
#### 5.3 Configure Gitlab-CI for the Reviews Microservice

Log in to ‘Gitlab’, enter ‘bookinfo-views’, and create deployment.yaml and .gitlab-ci.yml files in the root directory. Annotations define the project, env, and version tags, which are used to distinguish different projects and different versions.

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
    - echo "Executing deploy"
    - ls
    - sed -i "s#__version__#${APP_VERSION}#g" deployment.yaml
    - cat deployment.yaml
    - kubectl apply -f deployment.yaml
  after_script:
    - sleep 10
    - kubectl get pod  -n prod

```

### Step 6: Observability of Gitlab CI

#### 6.1 Publish Reviews Microservice

Modify the APP_VERSION value in the .gitlab-ci.yml file to "v1", commit the code once, modify it to "v2", commit the code once, modify it to "v3" and commit the code again.
		
![image](../images/microservices/14.png)

At this point, the Pipeline is triggered three times.

![image](../images/microservices/15.png)	 

#### 6.2 Observability of Gitlab CI Pipelines

Log in to ‘[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)’, enter ‘CI’, click ‘Summary’, select the bookinfo-views project, and check the execution status of the Pipeline and Job.
		  
![image](../images/microservices/16.png)	 

![image](../images/microservices/17.png)	 

Log in to ‘[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)’, enter ‘CI’, click ‘Explorer’, and select gitlab_pipeline.
		 
![image](../images/microservices/18.png)	 

![image](../images/microservices/19.png)	 

Log in to ‘[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)’, enter ‘CI’, click ‘Explorer’, and select gitlab_job.
		 
![image](../images/microservices/20.png)	 

![image](../images/microservices/21.png)	

![image](../images/microservices/22.png)