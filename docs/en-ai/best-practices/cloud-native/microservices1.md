# Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 1)

---

## Introduction

After enterprises create their own container cloud environment, they typically use GitlabCI and Jenkins for application deployment to simplify complex release processes. They also consider using Rancher for unified resource orchestration management and simplify application management through the Rancher application store. By installing DataKit via the application store (see DataKit documentation for Helm installation), Guance provides a large number of out-of-the-box observability features for Kubernetes clusters managed by Rancher. This article uses a familiar Bookinfo case study to detail how to achieve observability with GitlabCI, Kubernetes, and microservices using Guance.

## Case Assumption

A company manages two sets of Kubernetes environments using Rancher: one for development and testing, and one for production. The company deploys GitLab in the development and testing environment for CI/CD. The BookInfo project is an electronic bookstore and a typical multi-language microservice project. A new version being developed is deployed in the development and testing environment. After passing tests, it undergoes canary gray-scale release in the production environment. The components of the company's observability system are as follows:
1.1 SRE observes the overall Kubernetes resources of both environments on Guance to plan capacity and handle emergencies.
2.1 Developers observe the CI/CD process to understand software iteration speed and quality, and promptly address pipeline errors.
2.2 SRE observes the canary release in the production environment to monitor traffic switching status and roll back if necessary to avoid impacting users.
3.1 SRE performs end-to-end tracing through Istio to view critical health metrics of applications on Guance and handle abnormal requests in a timely manner.
3.2 Developers manage their logs and find log context through traceability on Guance when health issues arise.

We will cover the entire practice in three parts.

## Prerequisites

- Install [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/).
- Install [Rancher](https://rancher.com/docs/rancher/v2.6/en/installation/).
- Install [GitLab](https://about.gitlab.com/).
- Install the [Metrics-Server component](https://github.com/kubernetes-sigs/metrics-server#installation).
- Deploy a Harbor repository or other image repository.
- Deploy Istio and be familiar with [best practices for achieving microservice observability with Istio](../istio).
- Configure GitLab-runner and be familiar with [best practices for GitLab-CI observability](../monitoring/gitlab-ci).

## Deployment Steps

### Step 1: Installing DataKit Using Rancher

#### 1.1 Deploy DataKit

##### 1.1.1 Download Deployment File

Log in to [Guance](https://console.guance.com/) and click on the 'Integration' module. Then click on 'DataKit' in the top-left corner, select 'Kubernetes', and download datakit.yaml.

##### 1.1.2 Configure Token

Log in to [Guance](https://console.guance.com/) and go to the 'Management' module. Find the token in the screenshot and replace the value of the ENV_DATAWAY environment variable in datakit.yaml with <your-token>.

```yaml
        - name: ENV_DATAWAY
          value: https://openway.guance.com?token=<your-token>
```

![image](../images/microservices/1.png)	 

##### 1.1.3 Set Global Tags

Add `cluster_name_k8s=k8s-istio` at the end of the ENV_GLOBAL_HOST_TAGS environment variable value in the datakit.yaml file, where k8s-istio is your cluster name. This step sets global tags for the cluster.

```yaml
        - name: ENV_GLOBAL_HOST_TAGS
          value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-istio
```

##### 1.1.4 Set Namespace

To distinguish different clusters during DataKit elections, set the ENV_NAMESPACE environment variable. Ensure different clusters have different values. Add the following content to the environment variables section in datakit.yaml.

```yaml
        - name: ENV_NAMESPACE
          value: k8s-istio
```

##### 1.1.5 Enable Collectors

Enable ddtrace and statsd collectors by adding statsd,ddtrace to the ENV_DEFAULT_ENABLED_INPUTS environment variable in datakit.yaml.

```yaml
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,ddtrace
```

##### 1.1.6 Deploy DataKit

Log in to 'Rancher', under the Browse Clusters tab, choose the 'k8s-solution-cluster' cluster, open datakit.yaml, and create resources according to the content of the resource file in the k8s-solution-cluster cluster.

![image](../images/microservices/2.png)	 

**Note:** To quickly proceed to the next step, this operation will merge ConfigMap and deploy DataKit directly using the kubectl command.

#### 1.2 Create ConfigMap

Enable container and zipkin collectors by defining container.conf and zipkin.conf.

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

[inputs.container] parameter descriptions:

- container_include_metric: Metrics to collect from containers.
- container_exclude_metric: Metrics not to collect from containers.
- container_include_log: Logs to collect from containers.
- container_exclude_log: Logs not to collect from containers.
- exclude_pause_container: True excludes pause containers.
- `container_include` and `container_exclude` must start with `image`, formatted as `"image:<glob rule>"`, indicating that the glob rule applies to container images.
- [Glob rules](https://en.wikipedia.org/wiki/Glob_(programming)) are lightweight regular expressions supporting basic match units like `*` and `?`.

Then log in to 'Rancher', under the Browse Clusters tab, choose the 'k8s-solution-cluster' cluster, navigate to 'More Resources' -> 'Core' -> 'ConfigMaps', and create the defined ConfigMap in YAML format.

![image](../images/microservices/3.png)	 

Finally, associate DataKit with ConfigMap. In the 'k8s-solution-cluster' cluster, enter 'Workloads' -> 'DaemonSets', find DataKit, choose 'Edit YAML' on the right, add the following content, and click 'Save'.

![image](../images/microservices/4.png)	 

```yaml
        - mountPath: /usr/local/datakit/conf.d/container/container.conf
          name: datakit-conf
          subPath: container.conf
        - mountPath: /usr/local/datakit/conf.d/zipkin/zipkin.conf
          name: datakit-conf
          subPath: zipkin.conf
```

If you use the kubectl command to create DataKit, add the contents defined in ConfigMap to the end of datakit.yaml and add the above configuration to the volumeMounts section.<br /> **Note:** Use --- as a separator.
       
#### 1.3 View DataKit Running Status

After successful deployment of DataKit, you should see the running status as shown in the following figure.
		
![image](../images/microservices/5.png)	 

### Step 2: Map DataKit Service

When reporting trace data using Istio, the trace data is sent to the Service named **zipkin.istio-system**, and the reporting port is 9411. Since the DataKit service namespace is datakit and the port is 9529, a conversion is needed here. For details, refer to [Using ExternalName to Map DataKit Service in Kubernetes Cluster](../kubernetes-external-name).

### Step 3: Configure DataKit with DataFlux Function

When deploying microservices using Gitlab-CI, to collect Gitlab execution data, deploy DataFlux Function and configure DataKit. Detailed steps can be found in [Gitlab-CI Observability Best Practices](../monitoring/gitlab-ci).

### Step 4: Deploy Bookinfo

#### 2.1 Download Source Code

Download [istio-1.13.2.zip](https://github.com/istio/istio/releases). All subsequent deployment files come from this compressed package. For convenience, we will use the kubectl command instead of Rancher's graphical interface to create resources.

#### 2.2 Enable RUM

To observe website call information, frontend data collection needs to be enabled. Log in to [Guance](https://console.guance.com/) and go to 'User Analysis'. Create a new application named **devops-bookinfo** and copy the JS code below.

![image](../images/microservices/6.png)	 

Place the copied JS in a location accessible by all productpage project interfaces. In this project, the JS is added to the **istio-1.13.2\samples\bookinfo\src\productpage\templates\productpage.html** file.
**Note:** Refer to [Best Practices for Reporting RUM Data to DataKit Cluster](../monitoring/rum-datakit-cluster) for the DataKit address used for RUM data reporting.

![image](../images/microservices/7.png)	 

Rebuild and upload the productpage image to the image repository.

```shell
cd istio-1.13.2\samples\bookinfo\src\productpage
docker build -t 172.16.0.238/df-demo/product-page:v1 .
docker push 172.16.0.238/df-demo/product-page:v1
```

#### 2.3 Enable Sidecar Injection

Create a prod namespace and enable automatic Sidecar injection for Pods created in this namespace to route inbound and outbound traffic through the Sidecar.

```shell
kubectl create ns prod 
kubectl label namespace prod istio-injection=enabled
```

#### 2.4 Deploy productpage, details, ratings

In the istio-1.13.2\samples\bookinfo\platform\kube\bookinfo.yaml file, remove the part about deploying the reviews microservice. Deploy Services and Deployments to the prod namespace and add annotations to all Deployment controllers and Pod templates to enable custom collection. Modify the productpage image to the one created in the previous step. The complete file is as follows:

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

Check the exposed port of the ingresgateway.

```shell
kubectl get svc -n istio-system
```

![image](../images/microservices/8.png)	 

According to the virtual service rules, browse to [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage) to access productpage. Since the reviews service has not been deployed yet, you will see the message **Sorry, product reviews are currently unavailable for this book**.

![image](../images/microservices/9.png)	 

### Step 5: Automated Deployment

#### 5.1 Create GitLab Project

Log in to GitLab and create the bookinfo-views project.
		
![image](../images/microservices/10.png)
	 
#### 5.2 Connect GitLab with DataKit

Refer to the [GitLab integration documentation](/integrations/gitlab) to connect GitLab and DataKit. Here, only GitLab CI is configured.<br /> Log in to 'GitLab', go to 'bookinfo-views' -> 'Settings' -> 'Webhooks', and input the URL with the IP address of the DataKit host and the 9529 port of DataKit followed by /v1/gitlab in the URL field. As shown in the figure below.

![image](../images/microservices/11.png)	 

Select Job events and Pipeline events, then click Add webhook.
		
![image](../images/microservices/12.png)

Click Test next to the created Webhook and choose Pipeline events. An HTTP 200 response indicates successful configuration.
			
![image](../images/microservices/13.png)	 

       
#### 5.3 Configure GitLab-CI for the Reviews Microservice

Log in to 'GitLab', go to 'bookinfo-views', and create deployment.yaml and .gitlab-ci.yml files at the root directory. Annotations define project, env, and version tags to differentiate between different projects and versions.

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
    - echo "Executing deployment"
    - ls
    - sed -i "s#__version__#${APP_VERSION}#g" deployment.yaml
    - cat deployment.yaml
    - kubectl apply -f deployment.yaml
  after_script:
    - sleep 10
    - kubectl get pod  -n prod

```

### Step 6: GitLab CI Observability

#### 6.1 Publish Reviews Microservice

Modify the APP_VERSION value in the .gitlab-ci.yml file to "v1", commit once, modify to "v2", commit once, and modify to "v3" and commit once.
		
![image](../images/microservices/14.png)

At this point, the Pipeline is triggered three times.

![image](../images/microservices/15.png)	 

#### 6.2 GitLab CI Pipeline Observability

Log in to [Guance](https://console.guance.com/), go to 'CI', click on 'Summary', and select the bookinfo-views project to view the execution status of Pipelines and Jobs.
		  
![image](../images/microservices/16.png)	 

![image](../images/microservices/17.png)	 

Log in to [Guance](https://console.guance.com/), go to 'CI', click on 'Explorer', and select gitlab_pipeline.
		 
![image](../images/microservices/18.png)	 

![image](../images/microservices/19.png)	 

Log in to [Guance](https://console.guance.com/), go to 'CI', click on 'Explorer', and select gitlab_job.
		 
![image](../images/microservices/20.png)	 

![image](../images/microservices/21.png)	

![image](../images/microservices/22.png)