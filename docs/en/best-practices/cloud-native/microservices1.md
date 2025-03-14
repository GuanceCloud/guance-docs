# Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 1)

---

## Introduction

After enterprises create their own container cloud environment, they typically use GitLab CI or Jenkins for application deployment to simplify complex release processes. They also consider using Rancher for unified resource orchestration management and simplify application management through the Rancher application store. By installing DataKit via the application store (see the Helm installation method in the DataKit documentation), <<< custom_key.brand_name >>> provides a large number of out-of-the-box observability features for Kubernetes clusters managed by Rancher. This article uses the familiar Bookinfo example to explain how to achieve observability for GitLab CI, Kubernetes, and microservices using <<< custom_key.brand_name >>>.

## Case Assumptions

A company manages two sets of Kubernetes environments using Rancher: one for development and testing, and another for production. The company deploys GitLab in the development and testing environment for CICD. The BookInfo project is an e-book store and a typical multi-language microservice project. A new version under development is deployed in the development and testing environment, and after passing tests, it undergoes canary gray release in the production environment. The components of the company's observability system are as follows: <br />1.1 SREs observe the overall Kubernetes resource status of both environments on <<< custom_key.brand_name >>>, ensuring capacity planning and emergency response <br />2.1 Developers monitor the CICD process to understand software iteration speed and quality, promptly handling failed pipelines.<br />2.2 SREs monitor the canary release in the production environment to understand traffic switching status and roll back if necessary to avoid impacting production users. <br />3.1 SREs use Istio to trace the entire application, viewing key health metrics on <<< custom_key.brand_name >>> and promptly handling abnormal requests.<br />3.2 Developers manage their logs and, when encountering health issues, use <<< custom_key.brand_name >>> to find log context and resolve problems through tracing. We will cover this practice in three parts.

## Prerequisites

- Install [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/).
- Install [Rancher](https://rancher.com/docs/rancher/v2.6/en/installation/).
- Install [GitLab](https://about.gitlab.com/).
- Install the [Metrics-Server component](https://github.com/kubernetes-sigs/metrics-server#installation).
- Deploy Harbor registry or other image repositories.
- Deploy Istio and be familiar with [Best Practices for Achieving Observability in Microservices Using Istio](../istio).
- Configure GitLab-runner and be familiar with [Best Practices for Observing GitLab-CI](../monitoring/gitlab-ci).

## Deployment Steps

### Step 1: Install DataKit Using Rancher

#### 1.1 Deploy DataKit

##### 1.1.1 Download Deployment Files

Log in to『[<<< custom_key.brand_name >>>](https://console.guance.com/)』, click on the 『Integration』module, then click 『DataKit』in the top-left corner, select 『Kubernetes』, and download datakit.yaml.

##### 1.1.2 Configure Token

Log in to『[<<< custom_key.brand_name >>>](https://console.guance.com/)』, enter the 『Management』module, find the token in the image below, and replace the value of the ENV_DATAWAY environment variable in the datakit.yaml file with <your-token>.

```yaml
        - name: ENV_DATAWAY
          value: https://openway.guance.com?token=<your-token>
```

![image](../images/microservices/1.png)	 

##### 1.1.3 Set Global Tags

Add cluster_name_k8s=k8s-istio at the end of the ENV_GLOBAL_HOST_TAGS environment variable value in the datakit.yaml file, where k8s-istio is your cluster name. This step sets global tags for the cluster.

```yaml
        - name: ENV_GLOBAL_HOST_TAGS
          value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-istio
```

##### 1.1.4 Set Namespace

To distinguish different clusters during DataKit election, set the ENV_NAMESPACE environment variable. Ensure that the values for different clusters are not the same. Add the following content to the environment variables section in the datakit.yaml file.

```yaml
        - name: ENV_NAMESPACE
          value: k8s-istio
```

##### 1.1.5 Enable Collectors

Enable the ddtrace and statsd collectors. In the datakit.yaml file, find the ENV_DEFAULT_ENABLED_INPUTS environment variable and add statsd,ddtrace at the end.

```yaml
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,ddtrace
```

##### 1.1.6 Deploy DataKit

Log in to『Rancher』, under the Browse Clusters tab, select the『k8s-solution-cluster』cluster, open datakit.yaml, and create resources according to the contents of the resource file in the k8s-solution-cluster cluster.

![image](../images/microservices/2.png)	 

**Note**: To quickly proceed to the next step, this operation merges ConfigMap and directly deploys DataKit using the kubectl command.

#### 1.2 Create ConfigMap

Enable the container collector and Zipkin collector by defining container.conf and zipkin.conf.

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
        container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*", "image:pubrepo.jiagouyun.com/datakit/datakit*"]

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

- container_include_metric: Metrics of containers to collect.
- container_exclude_metric: Metrics of containers not to collect.
- container_include_log: Logs of containers to collect.
- container_exclude_log: Logs of containers not to collect.
- exclude_pause_container: true excludes pause containers.
- `container_include` and `container_exclude` must start with `image`, formatted as `"image:<glob pattern>"`, indicating that the glob pattern applies to the container image.
- [Glob Pattern](https://en.wikipedia.org/wiki/Glob_(programming)) is a lightweight regular expression supporting basic match units like `*` and `?`.

Then log in to『Rancher』, under the Browse Clusters tab, select the『k8s-solution-cluster』cluster, navigate to『More Resources』-> 『Core』-> 『ConfigMaps』, and create the defined ConfigMap using YAML format.

![image](../images/microservices/3.png)	 

Finally, associate DataKit with ConfigMap. In the『k8s-solution-cluster』cluster, go to 『Workloads』-> 『DaemonSets』, find DataKit, select『Edit YAML』on the right, and add the following content, then click『Save』.

![image](../images/microservices/4.png)	 

```yaml
        - mountPath: /usr/local/datakit/conf.d/container/container.conf
          name: datakit-conf
          subPath: container.conf
        - mountPath: /usr/local/datakit/conf.d/zipkin/zipkin.conf
          name: datakit-conf
          subPath: zipkin.conf
```

If using kubectl to create DataKit, add the content defined in ConfigMap to the end of the datakit.yaml file and place the above configuration under volumeMounts. <br /> **Note**: Use --- as a separator.
       
#### 1.3 View DataKit Running Status

After successfully deploying DataKit, you should see the running status as shown in the following figure.
		
![image](../images/microservices/5.png)	 

### Step 2: Map DataKit Services

When reporting trace data using Istio, the trace data is sent to the Service **zipkin.istio-system**, with the reporting port being 9411. Since the DataKit service namespace is datakit and the port is 9529, a conversion is needed. For details, refer to [Using ExternalName to Map DataKit Services in Kubernetes Cluster](../kubernetes-external-name).

### Step 3: Configure DataKit with DataFlux Function

When deploying microservices using GitLab-CI, to collect GitLab execution data, you need to deploy DataFlux Function and configure DataKit. For detailed steps, refer to [Best Practices for Observing GitLab-CI](../monitoring/gitlab-ci).

### Step 4: Deploy Bookinfo

#### 2.1 Download Source Code

Download [istio-1.13.2.zip](https://github.com/istio/istio/releases). All subsequent deployment files come from this compressed package. For convenience, we will use the kubectl command instead of Rancher's graphical interface to create resources.

#### 2.2 Enable RUM

To observe website call information, front-end data collection needs to be enabled. Log in to『 [<<< custom_key.brand_name >>>](https://console.guance.com/)』, enter『User Analysis』, create a new application named **devops-bookinfo**, and copy the JS code below.

![image](../images/microservices/6.png)	 

Place the JS code in a location accessible by all pages of the productpage project. This project copies the JS code into the **istio-1.13.2\samples\bookinfo\src\productpage\templates\productpage.html** file.
**Note**: For the DataKit address used for RUM data reporting, refer to [Best Practices for RUM Data Reporting DataKit Cluster](../monitoring/rum-datakit-cluster).

![image](../images/microservices/7.png)	 

Rebuild and upload the productpage image to the image repository.

```shell
cd istio-1.13.2\samples\bookinfo\src\productpage
docker build -t 172.16.0.238/df-demo/product-page:v1 .
docker push 172.16.0.238/df-demo/product-page:v1
```

#### 2.3 Enable Sidecar Injection

Create the prod namespace and enable automatic Sidecar injection for Pods created in this namespace so that Pod ingress and egress traffic is handled by Sidecar.

```shell
kubectl create ns prod 
kubectl label namespace prod istio-injection=enabled
```

#### 2.4 Deploy productpage, details, ratings

In the istio-1.13.2\samples\bookinfo\platform\kube\bookinfo.yaml file, remove the part about deploying the reviews microservice. Deploy the Services and Deployments to the prod namespace and add annotations to all Deployment controllers and Pod templates to enable custom collection. Modify the productpage image to the one created in the previous step. The complete file is as follows:

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
            metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
            measurement_name = "istio_prom"
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
            metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
            measurement_name = "istio_prom"
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
            measurement_name = "istio_prom"
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

#### 2.5 Create Gateway Resource and Virtual Service

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

Check the external port exposed by the ingress gateway.

```shell
kubectl get svc -n istio-system
```

![image](../images/microservices/8.png)	 

Based on the virtual service rules, access [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage) in the browser to access productpage. Since the reviews service has not been deployed yet, you will see the message **Sorry, product reviews are currently unavailable for this book**.
		
![image](../images/microservices/9.png)	 

### Step 5: Automated Deployment

#### 5.1 Create a GitLab Project

Log in to GitLab and create the bookinfo-views project.
		
![image](../images/microservices/10.png)
	 
#### 5.2 Connect GitLab with DataKit

Refer to the [GitLab Integration Documentation](/integrations/gitlab) to connect GitLab and DataKit. Here, only GitLab CI configuration is covered.<br />        Log in to『GitLab』, go to『bookinfo-views』-> 『Settings』-> 『Webhooks』, and input the URL with the IP address of the DataKit host and DataKit's port 9529, followed by /v1/gitlab. As shown in the image below.

![image](../images/microservices/11.png)	 

Select Job events and Pipeline events, then click Add webhook.
		
![image](../images/microservices/12.png)

Click Test next to the Webhook you just created, choose Pipeline events, and an HTTP 200 response indicates successful configuration.
			
![image](../images/microservices/13.png)	 

       
#### 5.3 Configure GitLab-CI for the Reviews Microservice

Log in to『GitLab』, go to『bookinfo-views』, and create deployment.yaml and .gitlab-ci.yml files in the root directory. Annotations define the project, env, and version labels for distinguishing different projects and versions.

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
            measurement_name = "istio_prom"
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

### Step 6: Observability of GitLab CI

#### 6.1 Deploy the Reviews Microservice

Modify the APP_VERSION value in the .gitlab-ci.yml file to "v1", commit once, change it to "v2", commit again, and finally change it to "v3" and commit once more.
		
![image](../images/microservices/14.png)

At this point, the Pipeline is triggered three times.

![image](../images/microservices/15.png)	 

#### 6.2 Observability of GitLab CI Pipelines

Log in to『[<<< custom_key.brand_name >>>](https://console.guance.com/)』, go to『CI』, click『Overview』and select the bookinfo-views project to view the execution status of Pipelines and Jobs.
		  
![image](../images/microservices/16.png)	 

![image](../images/microservices/17.png)	 

Log in to『[<<< custom_key.brand_name >>>](https://console.guance.com/)』, go to『CI』, click『Explorer』, and select gitlab_pipeline.
		 
![image](../images/microservices/18.png)	 

![image](../images/microservices/19.png)	 

Log in to『[<<< custom_key.brand_name >>>](https://console.guance.com/)』, go to『CI』, click『Explorer』, and select gitlab_job.
		 
![image](../images/microservices/20.png)	 

![image](../images/microservices/21.png)	

![image](../images/microservices/22.png)