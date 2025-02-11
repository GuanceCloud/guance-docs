# Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 2)

---

## Introduction

This article will introduce the overall situation of canary releases, utilizing Guance for observability of microservices' Metrics, traces, and logs. All subsequent operations regarding Rancher are conducted within the k8s-solution-cluster cluster, and this will not be reiterated.

## Canary Release

To achieve a canary release, add the label `app=reviews` to the Deployment of the deployed microservice to distinguish between different microservice names. The first deployment version should have the label `version=v1`, and the second deployment version should have the label `version=v2`. This way, traffic distribution between versions can be controlled based on these labels. For example, after deploying v2, 90% of the traffic can go to v1, and 10% to v2. Once v2 is verified as problem-free, all traffic can be switched to v2, and v1 can be taken offline, completing the entire release process.
		
![image](../images/microservices/61.png)

### Step One: Delete reviews 

In the first part, to illustrate Gitlab-CI automated deployment, three versions of reviews were deployed. Before proceeding with this operation, delete the three deployment versions of reviews. Log in to 'Rancher', navigate sequentially through 'Workloads' -> 'Deployments', find reviews-v1, and select 'Delete' on the right. Repeat this process to delete reviews-v2 and reviews-v3.

![image](../images/microservices/62.png)

### Step Two: Deploy reviews-v1

Log in to 'gitlab', find the bookinfo-views project, modify the value of `APP_VERSION` in the `.gitlab-ci.yml` file to "v1", and commit the code. Log in to 'Rancher', navigate sequentially through 'Workloads' -> 'Deployments', and observe that reviews-v1 has been successfully deployed.

![image](../images/microservices/63.png)	

### Step Three: Create DestinationRule

Define target addresses by creating subsets for the reviews Service during service discovery, specifically v1 and v2. To deploy this resource using kubectl, save the following content to the `destination-rule-reviews.yaml` file.

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: reviews
  namespace: prod
spec:
  host: reviews
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
```

```shell
kubectl create -f destination-rule-reviews.yaml
```

### Step Four: Create VirtualService

Before deploying v2, route all traffic to v1. Save the following content into the `virtual-service-reviews.yaml` file.

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

```shell
kubectl create -f virtual-service-reviews.yaml
```

Access [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage).

![image](../images/microservices/64.png)	

### Step Five: Deploy reviews-v2

Log in to 'gitlab', find the bookinfo-views project, modify the value of `APP_VERSION` in the `.gitlab-ci.yml` file to "v2", and commit the code. Log in to 'Rancher', navigate sequentially through 'Workloads' -> 'Deployments', and observe that reviews-v2 has been successfully deployed. Although v2 has been released, accessing [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage) still routes requests to the V1 version of the reviews microservice.

![image](../images/microservices/65.png)	

![image](../images/microservices/66.png)	

### Step Six: Route 10% Traffic to reviews-v2

Modify the `virtual-service-reviews.yaml` file with the following content:

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
      weight: 90
    - destination:
        host: reviews
        subset: v2
      weight: 10
```

Redeploy.

```shell
kubectl replace -f virtual-service-reviews.yaml
```

Access [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage) multiple times. The v1 and v2 versions of the reviews microservice will receive 90% and 10% of the traffic respectively.

![image](../images/microservices/67.png)	

![image](../images/microservices/68.png)	

### Step Seven: Monitor reviews-v2

#### 1. Application Performance Monitoring (APM)

Log in to 'Guance' -> 'Application Performance Monitoring' -> Topology chart in the top-right corner. Enable the environment and version distinction switch. There are two versions of reviews, where reviews:test:v2 calls the ratings service.
		
![image](../images/microservices/69.jpg)	

![image](../images/microservices/70.png)	

Click on 'Traces' at the top. Use the resource search feature to select reviews.prod and find the v2 version trace, then click to enter.
	  
![image](../images/microservices/71.png)

Observe the flame graph in the details interface. If there are any errors or timeouts in the trace calls, they will be clearly visible. The project, version, and env tags here are defined in the annotations of the deployment.yaml file in the bookinfo-views project in gitlab.

![image](../images/microservices/72.png)	

View the execution time of each Span in the Span list.

![image](../images/microservices/73.png)	

In the service call relationship, you can see a clear topology diagram.

![image](../images/microservices/74.png)	

##### 2 Istio Mesh Monitoring View

Log in to '[Guance](https://console.guance.com/)', click on 'Scenarios' -> 'Create Dashboard', and choose **Istio Mesh Monitoring View**. In this view, you can see that the ratio of calls to reviews-v1 and reviews-v2 is approximately 9:1.

![image](../images/microservices/75.png)	

### Step Eight: Complete the Release

After verifying that the reviews-v2 version of the microservice is functioning normally, all traffic can be routed to v2. Modify the `virtual-service-reviews.yaml` file with the following content:

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
        subset: v2
```

Redeploy.

```shell
kubectl replace -f virtual-service-reviews.yaml
```

![image](../images/microservices/76.png)	

**Note**: If there is an issue with the reviews-v2 version, log in to '[Guance](https://console.guance.com/)' and refer to the last section of this chapter on trace timeout analysis to diagnose the problem. Refer to Step Six to revert all traffic back to reviews-v1 until the issue is resolved and then redeploy.

# Metrics

When deploying Bookinfo, custom configurations were used to start Pods, adding `measurement_name = "istio_prom"` to the annotations configuration. This collects metrics into the **istio_prom** Mearsurement. Log in to 'Guance' -> 'Metrics', and view the istio_prom Mearsurement.

![image](../images/microservices/77.png)	

These metrics can be used to create monitoring dashboards similar to the **Istio Mesh Monitoring View** introduced earlier.

## Traces

### RUM

Log in to '[Guance](https://console.guance.com/)', navigate to 'User Access Monitoring', find the **devops-bookinfo** application, and click to enter.

![image](../images/microservices/78.png)

View UV, PV, session count, visited pages, etc.

![image](../images/microservices/79.png)

![image](../images/microservices/80.png)

**Tip**: For front-end and back-end separated projects, you can integrate backend traces and logs in the Explorer. Detailed steps can be found in [Kubernetes Application RUM-APM-LOG Correlation Analysis](../k8s-rum-apm-log).

![image](../images/microservices/81.png)

![image](../images/microservices/82.png)

![image](../images/microservices/83.png)

### APM

Log in to '[Guance](https://console.guance.com/)', navigate to 'Application Performance Monitoring'. Through APM, view trace data.
		
![image](../images/microservices/84.png)

![image](../images/microservices/85.png)

## Logs

### stdout

Based on DataKit deployment configurations, logs output to `/dev/stdout` are collected by default. Log in to '[Guance](https://console.guance.com/)', navigate to 'Logs', and view log information.
		
![image](../images/microservices/86.png)

**Tip**: For more log collection methods, refer to:

[Best Practices for Pod Log Collection](../pod-log)

[Several Ways to Collect Logs in Kubernetes Clusters](../k8s-logs)

## Trace Timeout Analysis

The Bookinfo project includes a timeout demonstration. Using the jason user to log in causes the ratings service to timeout. Create a new `virtual-service-ratings-test-delay.yaml` with the following content:

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: ratings
  namespace: prod
spec:
  hosts:
  - ratings
  http:
  - match:
    - headers:
        end-user:
          exact: jason
    fault:
      delay:
        percentage:
          value: 100.0
        fixedDelay: 7s
    route:
    - destination:
        host: ratings
        subset: v1
  - route:
    - destination:
        host: ratings
        subset: v1
```

Deploy the resource.

```shell
kubectl apply -f virtual-service-ratings-test-delay.yaml 
```

Log in using the jason user with an empty password.

![image](../images/microservices/87.png)

Access [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage), and the ratings service will be unreachable.

![image](../images/microservices/88.png)

Log in to '[Guance](https://console.guance.com/)', navigate to 'Application Performance Monitoring'. Click on the timed-out trace.

![image](../images/microservices/89.png)

Observe the flame graph to identify the timeout call.

![image](../images/microservices/90.png)