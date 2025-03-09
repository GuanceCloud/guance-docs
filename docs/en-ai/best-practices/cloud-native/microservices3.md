# Service Mesh Microservices Architecture from Development to Canary Release Best Practices (Part 2)

---

## Introduction

This article will introduce the overall situation of canary release, using <<< custom_key.brand_name >>> for observability of microservices' Metrics, traces, and logs. All operations related to Rancher in this guide are performed on the k8s-solution-cluster cluster, and will not be repeated.

## Canary Release

To achieve a canary release, add the label `app=reviews` to the Deployment of the microservice to distinguish the service name. For the first deployment version, add the label `version=v1`, and for the second deployment version, add the label `version=v2`. This allows controlling the traffic distribution between versions based on labels. For example, after deploying v2, direct 90% of the traffic to v1 and 10% to v2. Once verified, switch all traffic to v2 and decommission v1. The entire release process is complete.

![image](../images/microservices/61.png)

### Step One: Delete reviews

In the previous operation, to explain Gitlab-CI automated deployment, three versions of reviews were deployed. Before this operation, you need to delete these three deployments. Log in to 'Rancher', navigate through 'Workloads' -> 'Deployments' to find reviews-v1, and select 'Delete' on the right side. Then similarly delete reviews-v2 and reviews-v3.

![image](../images/microservices/62.png)

### Step Two: Deploy reviews-v1

Log in to 'GitLab', find the bookinfo-views project, change the value of `APP_VERSION` in the `.gitlab-ci.yml` file to "v1", and commit the code. Log in to 'Rancher', navigate through 'Workloads' -> 'Deployments' to see that reviews-v1 has been deployed.

![image](../images/microservices/63.png)	

### Step Three: Create DestinationRule

Define target addresses by creating subsets for the reviews Service during service discovery, specifically v1 and v2. To deploy this resource using `kubectl`, save the following content to the `destination-rule-reviews.yaml` file.

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

```
kubectl create -f virtual-service-reviews.yaml
```

Visit [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage).

![image](../images/microservices/64.png)	

### Step Five: Deploy reviews-v2

Log in to 'GitLab', find the bookinfo-views project, change the value of `APP_VERSION` in the `.gitlab-ci.yml` file to "v2", and commit the code. Log in to 'Rancher', navigate through 'Workloads' -> 'Deployments' to see that reviews-v2 has been deployed. Even though v2 has been deployed, visiting [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage) still directs traffic only to the V1 version of reviews.

![image](../images/microservices/65.png)	

![image](../images/microservices/66.png)	

### Step Six: Route 10% of Traffic to reviews-v2

Modify the `virtual-service-reviews.yaml` file as follows:

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

Multiple visits to [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage) will show that the v1 and v2 versions of reviews receive 90% and 10% of the traffic respectively,

![image](../images/microservices/67.png)	

![image](../images/microservices/68.png)	

### Step Seven: Observe reviews-v2

#### 1. Application Performance Monitoring (APM)

Log in to '<<< custom_key.brand_name >>>' -> 'APM' -> click the topology chart in the top-right corner. Enable the environment and version distinction switch. Reviews has two versions, where reviews:test:v2 calls the ratings service.
		
![image](../images/microservices/69.jpg)	

![image](../images/microservices/70.png)	

Click on 'Traces' at the top. This time, use the resource search feature, select reviews.prod, find the trace for the v2 version of reviews, and click into it.
	  
![image](../images/microservices/71.png)

Observe the flame graph in the details interface. If there are any errors or timeouts in the trace calls, they will be clearly visible. The project, version, and env labels are defined in the annotations of the deployment.yaml file in the bookinfo-views project in GitLab.

![image](../images/microservices/72.png)	

View the execution duration of each Span in the Span list.   

![image](../images/microservices/73.png)	

In the service call relationships, you can see a clear topology map.

![image](../images/microservices/74.png)	

##### 2 Istio Mesh Monitoring View

Log in to '[<<< custom_key.brand_name >>>](https://console.guance.com/)', click 'Scenarios' -> 'Create Dashboard', and select **Istio Mesh Monitoring View**. In this view, you can see that the ratio of calls to reviews-v1 and reviews-v2 is approximately 9:1.

![image](../images/microservices/75.png)	

### Step Eight: Complete the Release

After verifying that the reviews-v2 microservice works normally, all traffic can be switched to v2. Modify the `virtual-service-reviews.yaml` file as follows:

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

**Note**: If there are issues with the reviews-v2 version, log in to '[<<< custom_key.brand_name >>>](https://console.guance.com/)' and refer to the last section of this chapter for trace timeout analysis to diagnose the problem. Refer to Step Six to completely revert traffic back to reviews-v1 until the issue is fixed and then redeploy.

# Metrics

When deploying Bookinfo, custom configuration was used to start Pods, and `measurement_name = "istio_prom"` was added in the annotations configuration. This collects metrics into the **istio_prom** Mearsurement set. Log in to '<<< custom_key.brand_name >>>' -> 'Metrics', and view the istio_prom Mearsurement set.

![image](../images/microservices/77.png)	

These metrics can be used to create similar **Istio Mesh Monitoring Views** based on your project's needs.

## Traces

### RUM

Log in to '[<<< custom_key.brand_name >>>](https://console.guance.com/)', enter 'RUM', find the **devops-bookinfo** application, and click to enter.

![image](../images/microservices/78.png)

View UV, PV, session counts, and visited pages.

![image](../images/microservices/79.png)

![image](../images/microservices/80.png)

**Tip**: For front-end and back-end separated projects, you can integrate backend traces and logs in the Explorer. Detailed steps can be found in [Kubernetes Application RUM-APM-LOG Correlation Analysis](../k8s-rum-apm-log).

![image](../images/microservices/81.png)

![image](../images/microservices/82.png)

![image](../images/microservices/83.png)

### APM

Log in to '[<<< custom_key.brand_name >>>](https://console.guance.com/)', enter 'APM'. Through APM, view trace data.
		
![image](../images/microservices/84.png)

![image](../images/microservices/85.png)

## Logs

### stdout

According to the DataKit deployment configuration, logs output to `/dev/stdout` are collected by default. Log in to '[<<< custom_key.brand_name >>>](https://console.guance.com/)', enter 'Logs', and view log information.
		
![image](../images/microservices/86.png)

**Tip**: For more log collection methods, refer to:

[Pod Log Collection Best Practices](../pod-log)

[Several Ways to Collect Logs in Kubernetes Clusters](../k8s-logs)

## Trace Timeout Analysis

The Bookinfo project includes a timeout demonstration. Using the jason user to log in causes the ratings service to time out. Create a new `virtual-service-ratings-test-delay.yaml` with the following content:

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

Create the resource.

```shell
kubectl apply -f virtual-service-ratings-test-delay.yaml 
```

Log in using the jason user with an empty password.

![image](../images/microservices/87.png)

Visit [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage), and now the ratings service is unreachable.

![image](../images/microservices/88.png)

Log in to '[<<< custom_key.brand_name >>>](https://console.guance.com/)', enter 'APM'. Click on the timed-out trace.

![image](../images/microservices/89.png)

Observe the flame graph to identify the timeout call.

![image](../images/microservices/90.png)