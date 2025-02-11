# Kubernetes Ingress Component Deployment {#kube-ingress}

## Introduction

Nginx Ingress is an implementation of Kubernetes Ingress. It works by watching the Ingress resources in the Kubernetes cluster, converting Ingress rules into Nginx configurations, and enabling Nginx to perform Layer 7 traffic forwarding.

## Prerequisites

- A deployed Kubernetes cluster; if not deployed, refer to [Kubernetes Deployment](infra-kubernetes.md)
- (Optional) Helm tool deployed; if not deployed, refer to [Helm Installation](helm-install.md)

## Basic Information and Compatibility

| Name | Description |
| :---: | :---: |
| Ingress-nginx Version | 1.3.0 |
| Supported Cluster Version | 1.18+ |
| Ingress-nginx Port Number | 32280 |
| Offline Installation Support | Yes |
| Supported Architectures | amd64/arm64 |

## Deployment Steps

### 1. Installation
For deploying the Kubernetes Ingress component, refer to [https://github.com/kubernetes/ingress-nginx](https://github.com/kubernetes/ingress-nginx)

=== "Helm"

    - Kubernetes > 1.18

      ```shell
      helm install ingress-nginx ingress-nginx \
          --repo https://pubrepo.guance.com/chartrepo/dataflux-chart \
          -n ingress-nginx --create-namespace
      ``` 

    - Kubernetes = 1.18

      ```shell
      helm install ingress-nginx ingress-nginx \
          --repo https://pubrepo.guance.com/chartrepo/dataflux-chart \
          --version 4.1.4 \
          -n ingress-nginx --create-namespace
      ``` 

=== "Yaml"

    - Kubernetes > 1.18

      Download [ingress-nginx.yaml](ingress-nginx.yaml)

      Run the following command to install:

      ```shell
      kubectl apply -f ingress-nginx.yaml
      ``` 
      
    - Kubernetes = 1.18

      Download [ingress-nginx4.1.4.yaml](ingress-nginx4.1.4.yaml)

      Run the following command to install:

      ```shell
      kubectl apply -f ingress-nginx4.1.4.yaml
      ``` 

### 2. Verify Deployment

#### 2.1 Check Pod Status
```shell
kubectl get pods -n ingress-nginx 
NAME                                        READY   STATUS    RESTARTS   AGE
ingress-nginx-controller-7bf6c446bf-b7bq7   1/1     Running   1          26d
```

#### 2.2 Query Ports

Get the ingress-nginx NodePort port number

???+ warning "Note"

    The NodePort port numbers may differ between Helm and Yaml deployments. As shown in the figure, the ingress-nginx NodePort ports are 32280 and 32483.

```shell
kubectl get svc -n ingress-nginx
```
![ingress-nginx-svc.png](img/21.deployment_1.png)

#### 2.3 Create a Test Service
```shell
# Create a test deployment
kubectl create deployment ingress-test --image=nginx --port=80
# Create a test svc
kubectl expose deployment ingress-test --port=80 --target-port=80
# Create a test ingress
kubectl create ingress ingress-test --rule='foo.com/=ingress-test:80'
```

#### 2.4 Testing

???+ warning "Note"

     `192.168.100.101` is the IP address of the Kubernetes node

```shell
curl -H 'Host:foo.com' 192.168.100.101:32280
```
Successful result:
```shell
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

#### 2.5 Clean Up Test Service
```shell
kubectl delete deployment ingress-test
kubectl delete svc ingress-test
kubectl delete ingress ingress-test
```

## Uninstallation

=== "Helm"

    ```shell
    helm uninstall ingress-nginx  -n ingress-nginx 
    ``` 


=== "Yaml"

    ```shell
    kubectl delete -f ingress-nginx.yaml
    ```