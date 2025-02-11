# Launcher Service Installation Configuration

## Product Overview
   Used to deploy and install the Guance WEB application. Follow the steps guided by the Launcher service to complete the installation and upgrade of Guance.

## Keywords

| **Term**       | **Description**                                                     |
| -------------- | ------------------------------------------------------------------- |
| Launcher       | Used to deploy and install the Guance WEB application, following the guided steps of the Launcher service to complete the installation and upgrade of Guance. |
| Operations Machine | A machine with kubectl installed, on the same network as the target Kubernetes cluster. |
| Installation Machine | The machine that accesses the launcher service via a browser to complete the guided installation of Guance. |
| hosts File     | The hosts file is a system file without an extension. Its primary function is to save the mapping relationship between domain names and IP addresses. |

## 1. Importing Guance Offline Package

If installing in an offline network environment, you need to manually download the latest Guance image package first. Use the `docker load` command to import all images into each Kubernetes worker node before proceeding with the subsequent guided installation.

Latest Guance image package download links:
=== "amd64"

    [https://static.guance.com/dataflux/package/guance-amd64-latest.tar.gz](https://static.guance.com/dataflux/package/guance-amd64-latest.tar.gz)
    

=== "arm64"

    
    [https://static.guance.com/dataflux/package/guance-arm64-latest.tar.gz](https://static.guance.com/dataflux/package/guance-arm64-latest.tar.gz)
    
Containerd Environment Image Import Command
```shell
$ gunzip guance-xxx-latest.tar.gz
$ ctr -n=k8s.io images import guance-xxx-latest.tar
```
???+ info "Note"
    > Each node must import the image, resource package: guance-xxx-latest.tar.gz

## 2. Installing Launcher

- Installation

  In the `launcher` directory, execute the command

  ```shell
  helm install launcher launcher-*.tgz -n launcher --create-namespace  \
    --set ingress.hostName=launcher.dataflux.cn \
    --set storageClassName=managed-nfs-storage
  ```

> Download the launcher chart from [Download](https://static.guance.com/dataflux/package/launcher-helm-latest.tgz)

- Uninstalling Launcher

```shell
helm uninstall <RELEASE_NAME> -n launcher
```

> Do not uninstall Launcher unless there are abnormal conditions after successful installation.

## 3. Resolving the Launcher Domain Name to the Launcher Service
Since the Launcher service is used for deploying and upgrading Guance and does not need to be publicly accessible, do not resolve the domain name publicly. You can simulate DNS resolution by binding the host on the **Installation Machine**. Add the domain binding for **launcher.dataflux.cn** in `/etc/hosts`.

```shell
192.168.100.104 df-kodo.dataflux.cn
192.168.100.104 test.dataflux.cn
192.168.100.104 launcher.dataflux.cn
192.168.100.104 dataflux.dataflux.cn
192.168.100.104 df-func.dataflux.cn
192.168.100.104 df-api.dataflux.cn
192.168.100.104 df-management.dataflux.cn
192.168.100.104 df-management-api.dataflux.cn
192.168.100.104 df-static-res.dataflux.cn
```

> `192.168.100.104` is the proxy IP address

## 4. Application Installation Guide Steps
Access **launcher.dataflux.cn** in the `browser` on the **Installation Machine** and follow the guided steps to complete the installation configuration.

![](https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/liwenjin/docker/guance-launcher.png)

### 4.1 Database Configuration

- The database connection address must use an internal network address.
- The account must be an administrator account because it needs to initialize the databases and database access accounts for multiple sub-applications.

| URL          | Middleware      |
| ------------ | --------------- |
| Port         | 3306            |
| Username/Password | root/mQ2LZenlYs1UoVzi |

### 4.2 Redis Configuration
- The Redis connection address must use an internal network address.

| URL  | Middleware  |
| ---- | ----------- |
| Port | 6379        |
| Password | pNpX15GZkgICqX5D |

### 4.3 Time Series Engine Configuration

- TDengine
     - The TDengine connection address must use an internal network address.
     - The account must be an administrator account because it needs to initialize the DB and RP information.

     | URL          | Middleware             |
     | ------------ | ---------------------- |
     | Port         | 6041                   |
     | Username/Password | Your created account/Your set password |

### 4.4 Log Engine Configuration

- OpenSearch
       - The connection address must use an internal network address.
           - The account must be an administrator account.

   | URL          | Middleware                         |
   | ------------ | ---------------------------------- |
   | Port         | 9200                               |
   | Username/Password | openes/kJMerxk3PwqQ |

### 4.5 Other Settings

- Initial admin account for the Guance management backend, including username and email (default password is **admin**, it is recommended to change the default password immediately after login).
- Internal IP addresses of cluster nodes (automatically retrieved, need to confirm if correct).
- Main domain and subdomains for each sub-application, default subdomains are as follows and can be modified as needed:
   - dataflux 【**User Frontend**】
   - df-api 【**User Frontend API**】
   - df-management 【**Management Backend**】
   - df-management-api 【**Management Backend API**】
   - df-websocket 【**Websocket Service**】
   - df-func 【**Func Platform**】
   - df-openapi 【OpenAPI】
   - df-static-res 【**Static Resource Site**】
   - df-kodo 【**kodo**】

> TLS domain certificate filling

### 4.6 Installation Information

Summarize and display the information entered previously. If any information is incorrect, return to the previous step to make changes.

### 4.7 Application Configuration Files

The installation program will automatically initialize the application configuration templates based on the information provided in the previous steps, but you still need to check each application template individually and modify personalized configurations. Refer to the installation interface for detailed configuration instructions.

Confirm everything is correct and submit to create the configuration files.

### 4.8 Application Images

- Select the correct **shared storage**, i.e., the **storage class** name you created in the previous steps.
- Application images will be automatically filled based on the selected **Launcher** version and do not need to be modified. Confirm everything is correct and start **creating the application**.

### 4.9 Application Status

This section lists the startup status of all application services. This process requires downloading all images, which may take several minutes to tens of minutes. Once all services have successfully started, the installation is complete.

**Note: During the service startup process, stay on this page and do not close it until you see the prompt “Version information written successfully” and no error windows pop up, indicating a successful installation.**

### 4.10 Domain Name Resolution

Resolve all subdomains except **df-kodo.dataflux.cn** to the public IP address of the SLB or the edge node ingress address:

- dataflux.dataflux.cn
- df-api.dataflux.cn
- df-management.dataflux.cn
- df-management-api.dataflux.cn
- df-openapi.dataflux.cn
- df-func.dataflux.cn
- df-static-res.dataflux.cn

Since local Kubernetes clusters cannot use LoadBalancer services, use the edge node ingress instead.

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: df-kodo
  namespace: forethought-kodo
spec:
  rules:
  - host: df-kodo.dataflux.cn
    http:
      paths:
      - backend:
          serviceName: kodo-nginx
          servicePort: http
        path: /
        pathType: ImplementationSpecific
---
apiVersion: v1
kind: Service
metadata:
  name: kodo-nginx
  namespace: forethought-kodo
spec:
  ports:
  - name: https
    nodePort: 31841
    port: 443
    protocol: TCP
    targetPort: 80
  - name: http
    nodePort: 31385
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: deployment-forethought-kodo-kodo-nginx
  sessionAffinity: None
  type: NodePort
```

```shell
kubectl apply -f kodo-ingress.yaml
```

## 5. Security Settings
???+ warning "Important"

    After completing the above steps, verify that Guance is installed correctly. An important final step is to take the Launcher service offline to prevent accidental access that could disrupt application configuration. On the **Operations Machine**, execute the following command to set the number of replicas for the Launcher service pod to 0:

    ```shell
    kubectl patch deployment launcher \
    -p '{"spec": {"replicas": 0}}' \
    -n launcher
    ```