# Launcher Service Installation and Configuration

## Product Introduction
   Used to deploy the <<< custom_key.brand_name >>> WEB application. Follow the steps provided by the Launcher service to complete the installation and upgrade of <<< custom_key.brand_name >>>.

![](img/launcher-index.png)

## Keywords

| **Term** | **Description** |
| --- | --- |
| Launcher | Used to deploy the <<< custom_key.brand_name >>> WEB application. Follow the steps provided by the Launcher service to complete the installation and upgrade of <<< custom_key.brand_name >>>. |
| Operations Machine | A machine with kubectl installed, on the same network as the target Kubernetes cluster. |
| Installation Machine | The machine that accesses the launcher service via a browser to complete the <<< custom_key.brand_name >>> guided installation. |
| hosts File | The hosts file is a system file without an extension. Its main function is to save the mapping relationship between domain names and IP addresses. |

## Prerequisites

[Infrastructure Deployment](basic-env-install.md#basic-install) has been completed.

## 1. Launcher Installation

???+ warning "Note"
     To deploy Launcher, ensure your rbac permissions are `cluster-admin`, otherwise deploying Launcher will result in an error.
     If you are in an offline network environment, refer to [<<< custom_key.brand_name >>> Offline Package Download and Import](get-guance-images.md#offline-image) for deployment.

=== "Helm"

    - Installation
    
      ```shell
      helm install launcher launcher  --repo https://pubrepo.guance.com/chartrepo/launcher -n launcher \
        --create-namespace  \
        --set ingress.hostName=<Hostname>,storageClassName=<StorageClass>
      ```
    
    ???+ warning "Note"
    
        `<Hostname>` is the Launcher ingress domain name, `<StorageClass>` is the storage class name. You can retrieve it by executing `kubectl get sc`.
    
        ```
        helm install launcher launcher  --repo https://pubrepo.guance.com/chartrepo/launcher -n launcher \
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
    
       Download Launcher YAML from: https://<<< custom_key.static_domain >>>/launcher/launcher.yaml
     
       Save the above YAML content as a **launcher.yaml** file on the **operations machine**, then replace the variable parts within the document:
    
       - {{ launcher_image }} Replace with the latest version of the Launcher application image address, which can be obtained from the [Deployment Image](changelog.md) documentation.
       - {{ domain }} Replace with the main domain, such as dataflux.cn.
       - {{ storageClassName }} Replace with the storage class name, such as alicloud-nas.
    
       Resources configured with a default storage class will display default. Refer to the following figure:
    
       ![](img/8.deployment_4.png)
    
       Execute the following **kubectl** command on the **operations machine** to import the **Launcher** service:
       ```shell
       kubectl apply -f ./launcher.yaml
       ```
    
    - YAML Uninstallation
    
      ```shell
      kubectl delete -f ./launcher.yaml
      ```
    
    ???+ warning "Note"
         Do not uninstall Launcher unless under abnormal circumstances after successful installation.

## 2. Resolve Launcher Domain to Launcher Service
Since the Launcher service is used for deploying and upgrading <<< custom_key.brand_name >>> and does not need to be accessible to users, do not resolve the domain publicly. Instead, bind the host on the **installation machine** to simulate domain resolution by adding **launcher.dataflux.cn** to /etc/hosts.

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

=== "Self-hosted Infrastructure Deployment"
    ???+ note "/etc/hosts"
     ```shell
     192.168.100.104   launcher.dataflux.cn
     ```

    - How to Get IP
    
      [Deploy Proxy](infra-kubernetes.md#agency-install)

## 3. Application Installation Guide Steps {#deploy-steps}
Access **launcher.dataflux.cn** in the browser on the **installation machine** and follow the guide to complete the installation configuration step by step.
### 3.1 Database Configuration

- The database connection address must use an internal network address.
- The account must be an administrator account because it needs this account to initialize the databases and database access accounts for multiple sub-applications.

![](img/launcher-mysql.png)

### 3.2 Cache Service Configuration
- You can choose not to enable it. If not enabled, the default cache service will be used.
- If enabled, fill in the Redis connection address, supporting single-instance, proxy, and master-slave modes of Redis clusters.

![image-20241204135708561](img/image-20241204135708561.png)

### 3.3 Time Series Engine Configuration

=== "GuanceDB"
     - Enter GuanceDB's insert and select
          ![](img/launcher-guancedb.png)

=== "InfluxDB"
     - The InfluxDB connection address must use an internal network address.
          - The account must be an administrator account because it needs this account to initialize DB and RP information.
          ![](img/launcher-influxdb.png)

### 3.4 Log Engine Configuration

=== "OpenSearch"

     - The connection address must use an internal network address.
     - The account must be an administrator account.

=== "Elasticsearch"
     - The connection address must use an internal network address.
     - The account must be an administrator account.

![](img/launcher-elasticsearch.png)

### 3.5 Other Settings

- Initial admin account name and email for the <<< custom_key.brand_name >>> management backend (default password is **admin**, it is recommended to change the default password immediately after login).
- Internal network IP of cluster nodes (will be automatically retrieved, need to confirm if correct).
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

     The df-kodo service can optionally use an internal SLB. If DataWay and kodo are on the same internal network, choose to use the internal network during installation.

- TLS domain certificate filling

![](img/launhcer-other.png)

### 3.6 Installation Information

Summarizes the information entered earlier. If there are any errors, you can return to the previous step to make corrections.

![](img/launcher-install-setup-info.png)

### 3.7 Application Configuration Files

The installation program will automatically initialize the application configuration templates based on the installation information provided in the previous steps, but you still need to check all application templates individually and modify personalized application configurations. Detailed configuration instructions can be found in the installation interface.

Confirm everything is correct, then submit to create the configuration files.

![](img/launcher-review.png)

### 3.8 Application Images

- Select the correct **shared storage**, i.e., the **storage class** name created in the previous steps.
- Application images will be automatically filled based on the selected **Launcher** version and do not need to be modified. Confirm everything is correct, then start **creating the application**.

![](img/launcher-config.png)

### 3.9 Application Status

This section lists the startup status of all application services. This process requires downloading all images, which may take several minutes to tens of minutes. Once all services have successfully started, the installation is considered successful.

**Note: During the service startup process, stay on this page and do not close it until you see the prompt "Version information written successfully" and no error window pops up, indicating a successful installation!**

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

    After the service is installed, the cluster will automatically create a public SLB for the **kodo** service. Use the `kubectl get svc -n forethought-kodo` command to view the EXTERNAL-IP of the kodo-nginx service. The **df-kodo.dataflux.cn** subdomain should be resolved separately to this SLB's public IP, as shown in the following figure:
    
    ![](img/7.deployment_6.tiff)
    
    This SLB needs to be configured with an HTTPS certificate, which you must upload to the SLB console and modify the SLB listener protocol to layer 7 HTTPS. DataWay defaults to reporting data using the HTTPS protocol.
    
    ???+ warning "Note"
         
         For detailed methods of accessing services through the SLB, refer to: [https://www.alibabacloud.com/help/en/doc-detail/86531.htm](https://www.alibabacloud.com/help/en/doc-detail/86531.htm)
         Edit the kodo-nginx deploy YAML file and add the following annotations:
         
         ```yaml
         service.beta.kubernetes.io/alibaba-cloud-loadbalancer-cert-id: 1642778637586298_17076818419_1585666584_-1335499667 ## Use the actual certificate ID from the console ##
         service.beta.kubernetes.io/alibaba-cloud-loadbalancer-force-override-listeners: '"true"'  ## Force override existing listeners ##
         service.beta.kubernetes.io/alibaba-cloud-loadbalancer-id: lb-k2j4h4nlg2vgiwi9jyga6   ## Load balancer instance ID ## (specify an existing slb instance)
         service.beta.kubernetes.io/alibaba-cloud-loadbalancer-protocol-port: '"https:443"'  ## Protocol type ##
         ```

=== "Self-hosted Infrastructure Deployment"

    Since local Kubernetes clusters cannot use LoadBalancer services, you need to use edge node ingress.
     
    Download [kodo-ingress.yaml](kodo-ingress.yaml) and install it using the following command.
    ```shell
    kubectl apply -f kodo-ingress.yaml
    ```
    
    After configuration, deploy haproxy or nginx services on machines outside the cluster for domain proxying. For how to proxy, read [Deploy Proxy](proxy-install.md) -->

## 4. Install DataWay (Optional) {#dataway-install}

You can install a DataWay after successful deployment. Click the settings in the top-right corner and select 【Install Data Gateway】.
![](img/launcher-dataway-0.png)
Enter the DataWay name and binding address, click 【One-click Install】, and you will receive a notification upon successful installation.
![](img/launcher-dataway-1.png)
You can also use other methods to [install DataWay](dataway-install.md).

## 5. After Installation

After successful deployment, refer to the manual [How to Start Using](how-to-start.md)

If issues occur during installation and reinstallation is required, refer to the manual [Maintenance Manual](faq.md)

## 6. Very Important Step!!!

After completing the above steps, <<< custom_key.brand_name >>> is fully installed and can be verified. After verification, one very important step is to take the launcher service offline to prevent accidental access that could disrupt the application configuration. On the **operations machine**, execute the following command to set the number of pod replicas of the launcher service to 0:

```shell
kubectl patch deployment launcher \
-p '{"spec": {"replicas": 0}}' \
-n launcher
```