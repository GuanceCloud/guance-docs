# Service Mesh Microservices Architecture from Development to Canary Release Full Process Best Practices (Part 2)

---

## Introduction

This article will introduce the overall situation of canary releases, utilizing <<< custom_key.brand_name >>> for observability of microservices Metrics, APM, and LOGs. The following operations related to Rancher are all within the k8s-solution-cluster cluster, and no further reminders will be given.

## Canary Release

To achieve a canary release, add an app=reviews label to the Deployment of the microservice to distinguish the microservice name. For the first deployment version, add a version=v1 label, and for the second deployment version, add a version=v2 label. This way, traffic to each version can be controlled based on labels. For example, after deploying v2, allow 90% of the traffic to go to the v1 version and 10% to the v2 version. Once verified as problem-free, fully switch the traffic to the v2 version and take down the v1 version, completing the entire release process.

![image](../images/microservices/61.png)

### Step One: Delete reviews

In the first part of the operation, Gitlab-CI automated deployment was used to deploy three versions of reviews. Before this operation, you need to delete the three deployed versions of reviews. Log in to 'Rancher', enter the cluster, sequentially navigate to 'Workloads' -> 'Deployments', find reviews-v1, and select 'Delete' on the right side. Then use the same method to delete reviews-v2 and reviews-v3.

![image](../images/microservices/62.png)

### Step Two: Deploy reviews-v1

Log in to 'GitLab', find the bookinfo-views project, modify the value of APP_VERSION in the .gitlab-ci.yml file to "v1", and commit the code once. Log in to 'Rancher', enter the cluster, sequentially navigate to 'Workloads' -> 'Deployments', and you can see that the deployment of reviews-v1 is completed.

![image](../images/microservices/63.png)	

### Step Three: Create DestinationRule

Define the target address by dividing subsets when performing service discovery for the reviews Service, namely v1 and v2. To deploy this resource using kubectl, save the following content into the destination-rule-reviews.yaml file.

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

Before releasing v2, completely switch the traffic to v1. Save the following content into the virtual-service-reviews.yaml file.

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

Access [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage).

![image](../images/microservices/64.png)	

### Step Five: Deploy reviews-v2

Log in to 'GitLab', find the bookinfo-views project, modify the value of APP_VERSION in the .gitlab-ci.yml file to "v2", and commit the code once. Log in to 'Rancher', enter the cluster, sequentially navigate to 'Workloads' -> 'Deployments', and you can see that the deployment of reviews-v2 is completed. Although v2 has been released, accessing [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage), the reviews microservice can only request the V1 version.

![image](../images/microservices/65.png)	

![image](../images/microservices/66.png)	

### Step Six: Switch 10% Traffic to reviews-v2

Modify the virtual-service-reviews.yaml file with the following content:

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

Access [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage) multiple times, and the v1 and v2 versions of the reviews microservice will respectively receive 90% and 10% of the traffic.

![image](../images/microservices/67.png)	

![image](../images/microservices/68.png)	

### Step Seven: Observe reviews-v2

#### 1. Application Performance Monitoring

Log in to '<<< custom_key.brand_name >>>' -> 'APM' -> Topology chart in the top-right corner. Turn on the environment and version distinction switch; reviews has two versions, where reviews:test:v2 calls the ratings service.
		
![image](../images/microservices/69.jpg)	

![image](../images/microservices/70.png)	

Click the 'Trace' option above. This time we use the resource search function, select reviews.prod, find the trace of the reviews version v2, and click inside.
	  
![image](../images/microservices/71.png)

Observe the flame graph in the detail interface. If there are any errors or timeouts in the trace call, they will be clearly visible. The project, version, and env tags here are defined in the annotations section of the deployment.yaml file in the bookinfo-views project in GitLab.

![image](../images/microservices/72.png)	

View the execution duration of each Span in the Span list.   

![image](../images/microservices/73.png)	

In the service call relationship, you can see a clear topology diagram.

![image](../images/microservices/74.png)	

##### 2 Istio Mesh Monitoring View

Log in to '[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)', click 'Scenarios' -> 'Create', and choose **Istio Mesh Monitoring View**. In this view, the ratio of calls to reviews-v1 and reviews-v2 is roughly 9:1.

![image](../images/microservices/75.png)	

### Step Eight: Complete the Release

After verifying that the reviews-v2 microservice version is normal, the traffic can be fully switched to the v2 version. Modify the virtual-service-reviews.yaml file with the following content:

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

'Note' If there is an issue with the reviews-v2 version, log in to '[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)' and refer to the last section of this chapter on trace timeout analysis to analyze the problem. Refer to Step Six to fully revert the traffic back to reviews-v1, and re-release after fixing the problem.

# Metrics

When deploying Bookinfo, during the custom configuration enabling Pod startup, the annotation configuration increased measurement_name = "istio_prom", which means collecting metrics into the **istio_prom** Measurement set. Log in to '<<< custom_key.brand_name >>>' -> 'Metrics', and view the istio_prom Measurement set.

![image](../images/microservices/77.png)	

Use these metrics according to your own project needs to create similar views introduced in the previous step, such as the **Istio Mesh Monitoring View**.

## Trace

### RUM

Log in to '[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)', enter 'RUM', find the **devops-bookinfo** application, and click to enter.

![image](../images/microservices/78.png)

View UV, RUM PV, session count, visited pages, etc.

![image](../images/microservices/79.png)

![image](../images/microservices/80.png)

'Friendly Reminder' If it's a front-end and back-end separated project, you can connect backend traces and logs in the Explorer. Detailed operation steps can be found in [Kubernetes Application RUM-APM-LOG Correlation Analysis](../k8s-rum-apm-log).

![image](../images/microservices/81.png)

![image](../images/microservices/82.png)

![image](../images/microservices/83.png)

### APM

Log in to '[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)', enter 'APM'. Through APM, check the trace data.
		
![image](../images/microservices/84.png)

![image](../images/microservices/85.png)

## Logs

### Stdout

Based on the DataKit deployment configuration, default logs output to /dev/stdout are collected. Log in to '[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)', enter 'LOG', and view log information.
		
![image](../images/microservices/86.png)

'Friendly Reminder' For more log collection methods, please refer to:

[Best Practices for Pod Log Collection](../pod-log)

[Several Methods of Log Collection in Kubernetes Clusters](../k8s-logs)

## Trace Timeout Analysis

The Bookinfo project has an example demonstrating timeouts. When logging in with user jason, the ratings service will timeout. Create a new virtual-service-ratings-test-delay.yaml file with the following content:

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

Log in with jason, leaving the password blank.

![image](../images/microservices/87.png)

Access [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage), at this point the ratings service is unreachable.

![image](../images/microservices/88.png)

Log in to '[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)', enter 'APM'. Click on the timeout trace.

![image](../images/microservices/89.png)

Observe the flame graph to identify the timeout call.

![image](../images/microservices/90.png)