# Launcher Service Installation Configuration

## Product Overview
   Used for deploying and installing <<< custom_key.brand_name >>>'s WEB application, following the guidance steps of the Launcher service to complete the installation and upgrade of <<< custom_key.brand_name >>>

## Keywords

| **Term**   | **Description**                                                     |
| ---------- | ------------------------------------------------------------ |
| Launcher   | Used for deploying and installing <<< custom_key.brand_name >>>'s WEB application, following the guidance steps of the Launcher service to complete the installation and upgrade of <<< custom_key.brand_name >>> |
| Operations Machine | A machine with kubectl installed, on the same network as the target Kubernetes cluster   |
| Installation Machine | A machine that accesses the launcher service via a browser to complete the guided installation of <<< custom_key.brand_name >>>       |
| hosts file | The hosts file is a system file without an extension. Its main function is to save the mapping relationship between domain names and IPs. |

## 1. <<< custom_key.brand_name >>> Offline Package Import

If installing in an offline network environment, you need to manually download the latest <<< custom_key.brand_name >>> image package first, then import all images to each Kubernetes worker node using the `docker load` command before proceeding with the subsequent guided installation.

Latest <<< custom_key.brand_name >>> image package download address:
=== "amd64"

    [https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-latest.tar.gz](https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-latest.tar.gz)
    

=== "arm64"

    
    [https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-latest.tar.gz](https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-latest.tar.gz)
    
Containerd Environment Image Import Command
```shell
$ gunzip guance-xxx-latest.tar.gz
$ ctr -n=k8s.io images import guance-xxx-latest.tar
```
???+ info "Note"
    > Images must be imported on each node, guance-xxx-latest.tar.gz resource package

## 2. Launcher Installation

- Installation

  In the `launcher` directory, execute the command

  ```shell
  helm install launcher launcher-*.tgz -n launcher --create-namespace  \
    --set ingress.hostName=launcher.dataflux.cn \
    --set storageClassName=managed-nfs-storage
  ```

> Download launcher chart [Download](https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/launcher-helm-latest.tgz)

- Uninstalling Launcher

```shell
helm uninstall <RELEASE_NAME> -n launcher
```

> Do not uninstall Launcher after successful installation unless under abnormal circumstances.

## 3. Resolve launcher Domain to Launcher Service
Since the launcher service is used for deploying and upgrading <<< custom_key.brand_name >>> and does not need to be open to users, the domain should not be resolved publicly. You can bind hosts on the **installation operation machine** to simulate domain resolution by adding the **launcher.dataflux.cn** domain binding in /etc/hosts

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

> `192.168.100.104` is the proxy IP 

## 4. Application Installation Guidance Steps
Access **launcher.dataflux.cn** in the `browser` on the **installation operation machine**, and follow the guidance steps to complete the installation configuration step by step.

![](https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/liwenjin/docker/guance-launcher.png)

### 4.1 Database Configuration

- The database connection address must use an internal network address.
- The account must be an administrator account because it needs to initialize multiple sub-application databases and database access accounts.

   

| url         | mysql.middleware       |
| ----------- | --------------------- |
| port        | 3306                  |
| Username/Password | root/mQ2LZenlYs1UoVzi |



### 4.2 Redis Configuration
- The Redis connection address must use an internal network address

  | url  | redis.middleware  |
  | ---- | ---------------- |
  | Port | 6379             |
  | Password | pNpX15GZkgICqX5D |

  

### 4.3 Time Series Engine Configuration

- TDengine
     - The TDengine connection address must use an internal network address
     - The account must be an administrator account because it needs to initialize DB and RP information

     | url         | taos-tdengine.middleware |
     | ----------- | ------------------------ |
     | Port        | 6041                     |
     | Username/Password | Your created account/your set password        |

### 4.4 Log Engine Configuration

- OpenSearch
       - The connection address must use an internal network address
           - The account must be an administrator account
   
   | url         | opensearch-cluster-client.middleware |
   | ----------- | ------------------------------------ |
   | Port        | 9200                                 |
   | Username/Password | openes/kJMerxk3PwqQ                  |
   
   

### 4.5 Other Settings

- Initial admin account name and email for <<< custom_key.brand_name >>> management backend (default password is **admin**, it is recommended to change the default password immediately after login)
- Internal network IP of cluster nodes (will be automatically obtained, need to confirm if correct)
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

> Fill in TLS domain certificate

### 4.6 Installation Information

Summarizes the information filled out previously; if any information is incorrect, you can return to the previous step to make changes.

### 4.7 Application Configuration File

The installation program will automatically initialize the application configuration template based on the provided installation information from the previous steps, but you still need to check all application templates individually and modify personalized application configurations. Specific configuration instructions are available on the installation interface.

Confirm everything is correct, then submit to create the configuration files.

### 4.8 Application Image

- Select the correct **shared storage**, i.e., the **storage class** name you created in the previous steps.
- Application images will be automatically filled based on the selected **Launcher** version, no modification is required. Confirm everything is correct, then start **creating the application**.

### 4.9 Application Status

This section lists the startup status of all application services. This process requires downloading all images, which may take several minutes to over ten minutes. Once all services have successfully started, the installation is complete.

**Note: During the service startup process, you must stay on this page without closing it until you see the prompt “version information written successfully” and no error window pops up, indicating a successful installation!**

### 4.10 Domain Resolution

Resolve all subdomains except **df-kodo.dataflux.cn** to the public IP address of the SLB or edge node ingress:

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

    After completing the above steps, <<< custom_key.brand_name >>> is fully installed and can be verified. After verification, an important step is to take the launcher service offline to prevent accidental access that could disrupt the application configuration. On the **operations machine**, execute the following command to set the number of replicas of the launcher service pod to 0:

    ```shell
    kubectl patch deployment launcher \
    -p '{"spec": {"replicas": 0}}' \
    -n launcher
    ```