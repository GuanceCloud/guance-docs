# Launcher Service Installation Configuration

## Product Introduction
   Used for deploying and installing the Guance WEB application. Follow the steps guided by the Launcher service to complete the installation and upgrade of Guance.

![](img/launcher-index.png)

## Keywords

| **Term** | **Description** |
| --- | --- |
| Launcher | Used for deploying and installing the Guance WEB application. Follow the steps guided by the Launcher service to complete the installation and upgrade of Guance. |
| Operations Machine | A machine with kubectl installed, on the same network as the target Kubernetes cluster. |
| Installation Machine | A machine that accesses the Launcher service via a browser to complete the guided installation of Guance. |
| hosts File | The hosts file is a system file without an extension. Its main function is to save the mapping relationship between domain names and IP addresses. |

## Prerequisites

[Infrastructure Deployment](basic-env-install.md#basic-install) has been completed.

## 1. Launcher Installation

???+ warning "Note"
     To deploy Launcher, ensure your rbac permission is `cluster-admin`, otherwise, deploying Launcher will result in errors.
     If you are in an offline network environment, refer to [Guance Offline Package Download and Import](get-guance-images.md#offline-image) for deployment.

=== "Helm"

    - Installation
    
      ```shell
      helm install launcher launcher --repo https://pubrepo.guance.com/chartrepo/launcher -n launcher \
        --create-namespace  \
        --set ingress.hostName=<Hostname>,storageClassName=<StorageClass>
      ```
    
    ???+ warning "Note"
    
        `<Hostname>` is the Launcher ingress domain name, `<StorageClass>` is the storage class name, which can be obtained by executing `kubectl get sc`.
    
        ```
        helm install launcher launcher --repo https://pubrepo.guance.com/chartrepo/launcher -n launcher \
           --create-namespace  \
           --set ingress.hostName="launcher.dataflux.cn",storageClassName=df-nfs-storage        
        ```
       
    - Uninstall Launcher
    
    ```shell
    helm uninstall launcher -n launcher
    ```
    
    ???+ warning "Note"
        Do not uninstall Launcher unless under abnormal circumstances after successful installation.


=== "YAML"

    - YAML Installation
    
       Download Launcher YAML from: https://static.guance.com/launcher/launcher.yaml
     
       Save the above YAML content as **launcher.yaml**, place it on the **operations machine**, and replace the variable parts in the document:
    
       - {{ launcher_image }} should be replaced with the latest Launcher application image address, which can be found in the [Deployment Image](changelog.md) documentation.
       - {{ domain }} should be replaced with the main domain, such as dataflux.cn.
       - {{ storageClassName }} should be replaced with the storage class name, such as alicloud-nas.
    
       Resources configured with default storageclass will display as default; refer to the following figure:
    
       ![](img/8.deployment_4.png)
    
       Execute the following **kubectl** command on the **operations machine** to import the **Launcher** service:
       ```shell
       kubectl apply -f ./launcher.yaml
       ```
    
    - Uninstall YAML
    
      ```shell
      kubectl delete -f ./launcher.yaml
      ```
    
    ???+ warning "Note"
         Do not uninstall Launcher unless under abnormal circumstances after successful installation.

## 2. Resolving Launcher Domain Name to Launcher Service
Since the Launcher service is used for deploying and upgrading Guance and does not need to be publicly accessible, do not resolve the domain name publicly. Instead, bind the host on the **installation machine** to simulate domain name resolution by adding **launcher.dataflux.cn** to the /etc/hosts file.

=== "Cloud Infrastructure Deployment"
    ???+ note "/etc/hosts"
         ```shell
         8.XX.176.XX  launcher.dataflux.cn
         ```
    - How to Get IP
      ```shell
      kubectl get svc -n kube-system
      ```
      ![](img/21.deployment_2.png)

=== "Self-built Infrastructure Deployment"
    ???+ note "/etc/hosts"
     ```shell
     192.168.100.104   launcher.dataflux.cn
     ```

    - How to Get IP
    
      [Deploy Agent](infra-kubernetes.md#agency-install)

## 3. Application Installation Guide Steps {#deploy-steps}
Access **launcher.dataflux.cn** in the browser on the **installation machine** and follow the guide steps to complete the installation configuration.
### 3.1 Database Configuration

- The database connection address must use an internal network address.
- The account must have administrator privileges because it needs to initialize multiple sub-application databases and database access accounts.

![](img/launcher-mysql.png)

### 3.2 Cache Service Configuration
- You can choose not to enable it. If not enabled, the default cache service will be used.
- If enabled, fill in the Redis connection address, supporting single-node, proxy mode, and master-slave mode Redis clusters.

![image-20241204135708561](img/image-20241204135708561.png)

### 3.3 Time Series Engine Configuration

=== "GuanceDB"
     - Enter the insert and select commands for GuanceDB
          ![](img/launcher-guancedb.png)

=== "InfluxDB"
     - The InfluxDB connection address must use an internal network address.
          - The account must have administrator privileges because it needs to initialize DB and RP information.
          ![](img/launcher-influxdb.png)

### 3.4 Log Engine Configuration

=== "OpenSearch"

     - The connection address must use an internal network address.
     - The account must have administrator privileges.

=== "ElasticSearch"
     - The connection address must use an internal network address.
     - The account must have administrator privileges.

![](img/launcher-elasticsearch.png)

### 3.5 Other Settings

- Initial admin username and email for the Guance management backend (default password is **admin**, it is recommended to change the default password immediately after login).
- Internal network IP of cluster nodes (will be automatically obtained, confirm if correct).
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

???+ warning "Note"

     The df-kodo service can choose whether to use internal SLB. If DataWay and kodo are in the same internal network, you can choose to use the internal network during installation.

- TLS domain certificate filling

![](img/launhcer-other.png)

### 3.6 Installation Information

Summarizes the information entered earlier. If there are any errors, return to the previous step to modify.

![](img/launcher-install-setup-info.png)

### 3.7 Application Configuration File

The installation program will automatically generate application configuration templates based on the provided installation information, but you still need to check all application templates individually and modify personalized configurations. For specific configuration instructions, see the installation interface.

After confirming everything is correct, submit to create the configuration file.

![](img/launcher-review.png)

### 3.8 Application Images

- Select the correct **shared storage**, i.e., the **storage class** name you created in the previous steps.
- Application images will be automatically filled based on the selected **Launcher** version and do not need to be modified. Confirm everything is correct and start **creating the application**.

![](img/launcher-config.png)

### 3.9 Application Status

This section lists the startup status of all application services. This process requires downloading all images, which may take several minutes to over ten minutes. Once all services have successfully started, the installation is complete.

**Note: During the service startup process, stay on this page without closing it until you see the prompt “version information written successfully” and no error window pops up, indicating successful installation!**

![](img/launcher-install-ok.png)

### 3.10 Domain Resolution

Resolve all subdomains except **df-kodo.dataflux.cn** to the public IP address of the SLB or the edge node ingress address:

- dataflux.dataflux.cn
- df-api.dataflux.cn
- df-management.dataflux.cn
- df-management-api.dataflux.cn
- df-openapi.dataflux.cn
- df-func.dataflux.cn
- df-static-res.dataflux.cn

<!-- === "Cloud Infrastructure Deployment"

    After the service is installed, the cluster will automatically create a public SLB for the **kodo** service. Use the `kubectl get svc -n forethought-kodo` command to view the EXTERNAL-IP of the kodo-nginx service. The **df-kodo.dataflux.cn** subdomain should be resolved separately to the public IP of this SLB, as shown in the following figure:
    
    ![](img/7.deployment_6.tiff)
    
    This SLB needs to configure an HTTPS certificate. Upload the required certificate to the SLB console and modify the SLB listener protocol to Layer 7 HTTPS. DataWay defaults to using the HTTPS protocol for reporting data.
    
    ???+ warning "Note"
         
         Refer to [https://www.alibabacloud.com/help/zh/doc-detail/86531.htm](https://www.alibabacloud.com/help/zh/doc-detail/86531.htm) for specific methods of accessing services via SLB.
         Edit the kodo-nginx deploy YAML file and add the following annotations:
         
         ```yaml
         service.beta.kubernetes.io/alibaba-cloud-loadbalancer-cert-id: 1642778637586298_17076818419_1585666584_-1335499667 ## Actual certificate ID from the control panel ##
         service.beta.kubernetes.io/alibaba-cloud-loadbalancer-force-override-listeners: '"true"'  ## Override existing listeners with current configuration ##
         service.beta.kubernetes.io/alibaba-cloud-loadbalancer-id: lb-k2j4h4nlg2vgiwi9jyga6   ## Load balancer instance ID ## (Specify an existing SLB instance)
         service.beta.kubernetes.io/alibaba-cloud-loadbalancer-protocol-port: '"https:443"'  ## Protocol type ##
         ```

=== "Self-built Infrastructure Deployment"

    Since local Kubernetes clusters cannot use LoadBalancer services, you need to use edge node ingress.
     
    Download [kodo-ingress.yaml](kodo-ingress.yaml) and execute the installation command.
    ```shell
    kubectl apply -f kodo-ingress.yaml
    ```
    
    After configuration, deploy haproxy or nginx services on machines outside the cluster for domain proxying. For how to proxy, read [Deploy Proxy](proxy-install.md) -->

## 4. Installing DataWay (Optional) {#dataway-install}

You can install a DataWay after successful deployment. Click the settings in the upper right corner and select 【Install Data Gateway】.
![](img/launcher-dataway-0.png)
Fill in the DataWay name and binding address, click 【One-click Install】, and a success prompt will appear upon successful installation.
![](img/launcher-dataway-1.png)
You can also use other methods to [install DataWay](dataway-install.md).

## 5. After Installation

After successful deployment, refer to the manual [How to Start Using](how-to-start.md).

If issues occur during installation and reinstallation is required, refer to the manual [Maintenance Manual](faq.md).

## 6. Very Important Step!!!

After completing the above steps, Guance is fully installed and can be verified. After verification, perform a very important step: take the Launcher service offline to prevent accidental access that could disrupt the application configuration. On the **operations machine**, execute the following command to set the number of Launcher service pod replicas to 0:

```shell
kubectl patch deployment launcher \
-p '{"spec": {"replicas": 0}}' \
-n launcher
```