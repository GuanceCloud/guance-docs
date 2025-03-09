# Launcher Service Installation Configuration

## Product Introduction
   Used for deploying and installing <<< custom_key.brand_name >>>'s WEB application. Follow the guidance steps of the Launcher service to complete the installation and upgrade of <<< custom_key.brand_name >>>.

## Keywords

| **Term**   | **Description**                                                     |
| ---------- | ------------------------------------------------------------ |
| Launcher   | Used for deploying and installing <<< custom_key.brand_name >>>'s WEB application. Follow the guidance steps of the Launcher service to complete the installation and upgrade of <<< custom_key.brand_name >>>. |
| Operations Machine | A machine with kubectl installed, in the same network as the target Kubernetes cluster.   |
| Installation Machine | The machine that accesses the launcher service via a browser to complete the guided installation of <<< custom_key.brand_name >>>.       |
| hosts File | The hosts file is a system file without an extension. Its main function is to save the mapping relationship between domain names and IP addresses. |

## 1. <<< custom_key.brand_name >>> Offline Package Import

If installing in an offline network environment, you need to manually download the latest <<< custom_key.brand_name >>> image package first. Use the `docker load` command to import all images to each Kubernetes worker node before proceeding with the subsequent guided installation.

The latest <<< custom_key.brand_name >>> image package download address:
=== "amd64"

    [https://<<< custom_key.static_domain >>>/dataflux/package/guance-amd64-latest.tar.gz](https://<<< custom_key.static_domain >>>/dataflux/package/guance-amd64-latest.tar.gz)
    

=== "arm64"

    
    [https://<<< custom_key.static_domain >>>/dataflux/package/guance-arm64-latest.tar.gz](https://<<< custom_key.static_domain >>>/dataflux/package/guance-arm64-latest.tar.gz)
    
Command to import images in a Containerd environment
```shell
$ gunzip guance-xxx-latest.tar.gz
$ ctr -n=k8s.io images import guance-xxx-latest.tar
```
???+ info "Note"
    > Images must be imported on each node, using the guance-xxx-latest.tar.gz resource package.

## 2. Launcher Installation

- Installation

  In the `launcher` directory, execute the command

  ```shell
  helm install launcher launcher-*.tgz -n launcher --create-namespace  \
    --set ingress.hostName=launcher.dataflux.cn \
    --set storageClassName=managed-nfs-storage
  ```

> Download the launcher chart from [Download](https://<<< custom_key.static_domain >>>/dataflux/package/launcher-helm-latest.tgz)

- Uninstalling Launcher

```shell
helm uninstall <RELEASE_NAME> -n launcher
```

> Do not uninstall Launcher after successful installation unless there are abnormal situations.

## 3. Resolving launcher Domain Name to Launcher Service
Since the launcher service is used for deploying and upgrading <<< custom_key.brand_name >>> and does not need to be publicly accessible, do not resolve the domain name on the public internet. You can simulate DNS resolution by binding the host on the **installation machine**. Add the domain name binding for **launcher.dataflux.cn** in `/etc/hosts`.

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

> `192.168.100.104` is the proxy IP.

## 4. Application Installation Guidance Steps
Access **launcher.dataflux.cn** in the `browser` on the **installation machine**, and follow the guidance steps to complete the installation configuration.

![](https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/liwenjin/docker/guance-launcher.png)

### 4.1 Database Configuration

- The database connection address must use an internal network address.
- The account must be an administrator account because it needs to initialize multiple sub-application databases and database access accounts.

| url         | mysql.middleware       |
| ----------- | --------------------- |
| port        | 3306                  |
| Username/Password | root/mQ2LZenlYs1UoVzi |

### 4.2 Redis Configuration
- The Redis connection address must use an internal network address.

| url  | redis.middleware  |
| ---- | ---------------- |
| Port | 6379             |
| Password | pNpX15GZkgICqX5D |

### 4.3 Time Series Engine Configuration

- TDengine
     - The TDengine connection address must use an internal network address.
     - The account must be an administrator account because it needs to initialize the DB and RP information.

     | url         | taos-tdengine.middleware |
     | ----------- | ------------------------ |
     | Port        | 6041                     |
     | Username/Password | Your created account/your set password        |

### 4.4 Log Engine Configuration

- OpenSearch
       - The connection address must use an internal network address.
           - The account must be an administrator account
   
   | url         | opensearch-cluster-client.middleware |
   | ----------- | ------------------------------------ |
   | Port        | 9200                                 |
   | Username/Password | openes/kJMerxk3PwqQ                  |

### 4.5 Other Settings

- Initial admin account name and email for the <<< custom_key.brand_name >>> management backend (default password is **admin**, it is recommended to change the default password immediately after login).
- Internal IP addresses of cluster nodes (will be automatically obtained, need to confirm if correct).
- Main domain and subdomains configuration for various sub-applications, default subdomains are as follows and can be modified as needed:
   - dataflux 【**User Frontend**】
   - df-api 【**User Frontend API**】
   - df-management 【**Admin Backend**】
   - df-management-api 【**Admin Backend API**】
   - df-websocket 【**Websocket Service**】
   - df-func 【**Func Platform**】
   - df-openapi 【OpenAPI】
   - df-static-res 【**Static Resource Site**】
   - df-kodo 【**kodo**】

> Fill in TLS domain certificate

### 4.6 Installation Information

A summary of the information entered will be displayed. If any information is incorrect, you can return to the previous step to modify it.

### 4.7 Application Configuration Files

The installation program will automatically initialize the application configuration template based on the information provided in the previous steps, but you still need to check each application template individually and modify personalized application configurations. Refer to the installation interface for specific configuration instructions.

After confirming everything is correct, submit to create the configuration files.

### 4.8 Application Images

- Select the correct **shared storage**, i.e., the **storage class** name you created in the previous steps.
- Application images will be automatically filled based on the selected **Launcher** version, no modification is required. Confirm everything is correct and start **creating the application**.

### 4.9 Application Status

This section lists the startup status of all application services. This process involves downloading all images, which may take several minutes to tens of minutes. Once all services have successfully started, it indicates the installation was successful.

**Note: During the service startup process, you must stay on this page and not close it until you see the message “Version information written successfully” and no error window pops up, indicating a successful installation!**

### 4.10 Domain Resolution

Resolve all subdomains except **df-kodo.dataflux.cn** to the SLB public IP address or edge node ingress address:

- dataflux.dataflux.cn
- df-api.dataflux.cn
- df-management.dataflux.cn
- df-management-api.dataflux.cn
- df-openapi.dataflux.cn
- df-func.dataflux.cn
- df-static-res.dataflux.cn

Since local Kubernetes clusters cannot use LoadBalancer services, you need to use edge node ingress.

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

    After completing the above steps, <<< custom_key.brand_name >>> is fully installed and can be verified. An important final step is to take the launcher service offline to prevent accidental access that could disrupt the application configuration. On the **operations machine**, execute the following command to set the number of replicas for the launcher service pod to 0:

    ```shell
    kubectl patch deployment launcher \
    -p '{"spec": {"replicas": 0}}' \
    -n launcher
    ```