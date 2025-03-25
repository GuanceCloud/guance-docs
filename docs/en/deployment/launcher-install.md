# Launcher Service Installation Configuration

## Product Overview
   Used for deploying the <<< custom_key.brand_name >>> WEB application, complete the installation and upgrade of <<< custom_key.brand_name >>> according to the guidance steps of the Launcher service.

![](img/launcher-index.png)

## Keywords

| **Term** | **Description** |
| --- | --- |
| Launcher | Used for deploying the <<< custom_key.brand_name >>> WEB application, complete the installation and upgrade of <<< custom_key.brand_name >>> according to the guidance steps of the Launcher service. |
| Operations Machine | A machine with kubectl installed, in the same network as the target Kubernetes cluster. |
| Installation Machine | The machine that accesses the launcher service via a browser to complete the guided installation of <<< custom_key.brand_name >>>. |
| Hosts File | The hosts file is a system file without an extension. Its main function is to save the mapping relationship between domain names and IPs. |

## Prerequisites

[Infrastructure Deployment](basic-env-install.md#basic-install) has been completed.

## 1. Launcher Installation

???+ warning "Note"
     To deploy Launcher, ensure your rbac permission is `cluster-admin`, otherwise the deployment of Launcher will result in an error.
     If it's an offline network environment, refer to [<<< custom_key.brand_name >>> Offline Package Download, Import](get-guance-images.md#offline-image) for deployment.


=== "Helm"

    - Installation
    
      ```shell
      helm install launcher launcher  --repo https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/launcher -n launcher \
        --create-namespace  \
        --set ingress.hostName=<Hostname>,storageClassName=<Stroageclass>
      ```
    
    ???+ warning "Note"
    
        `<Hostname>` is the Launcher ingress domain name, `<Stroageclass>` is the storage class name, which can be obtained by executing `kubectl get sc`.
    
        ```
        helm install launcher launcher  --repo https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/launcher -n launcher \
           --create-namespace  \
           --set ingress.hostName="launcher.dataflux.cn",storageClassName=df-nfs-storage        
        ```
       
    - Uninstalling Launcher
    
    ```shell
    helm uninstall launcher -n launcher
    ```
    
    ???+ warning "Note"
        Do not uninstall Launcher unless under abnormal circumstances after successful installation.


=== "YAML"

    - YAML Installation
    
       Launcher YAML download: https://static.<<< custom_key.brand_main_domain >>>/launcher/launcher.yaml
     
       Save the above YAML content as the **launcher.yaml** file, place it on the **operations machine**, then replace the variable parts within the document:
    
       - {{ launcher_image }} should be replaced with the latest image address of the Launcher application, which can be found in the [Deployment Image](changelog.md) documentation.
       - {{ domain }} should be replaced with the main domain, such as using dataflux.cn.
       - {{ storageClassName }} should be replaced with the storage class name, such as alicloud-nas.
    
       Resources configured with the default storage class will display defalut; see the reference diagram below:
    
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

## 2. Resolve launcher Domain Name to launcher Service
Since the launcher service is used for deploying and upgrading <<< custom_key.brand_name >>>, it does not need to be publicly accessible. Therefore, the domain name should not be resolved on the public network. Instead, you can bind the host on the **installation machine** to simulate domain name resolution by adding **launcher.dataflux.cn** to the /etc/hosts file.

=== "Cloud Infrastructure Deployment"
    ???+ note "/etc/hosts"
         ```shell
         8.XX.176.XX  launcher.dataflux.cn
         ```
    - How to Obtain IP
      ```shell
      kubectl get svc -n kube-system
      ```
      ![](img/21.deployment_2.png)

=== "Self-built Infrastructure Deployment"
    ???+ note "/etc/hosts"
     ```shell
     192.168.100.104   launcher.dataflux.cn
     ```

    - How to Obtain IP
    
      [Deploy Proxy](infra-kubernetes.md#agency-install)

## 3. Application Installation Guidance Steps {#deploy-steps}
Access **launcher.dataflux.cn** in the browser on the **installation machine**, and follow the guidance steps one by one to complete the installation configuration.
### 3.1 Database Configuration

- The database connection address must use an internal network address.
- The account must be an administrator account because this account is needed to initialize the databases and database access accounts for multiple sub-applications.

![](img/launcher-mysql.png)

### 3.2 Cache Service Configuration
- You can choose not to enable it. If not enabled, the default cache service will be used.
- If enabled, please fill in the Redis connection address, supporting single-instance mode, proxy mode, and master-slave mode of the Redis cluster version.

![image-20241204135708561](img/image-20241204135708561.png)

### 3.3 Time Series Engine Configuration

=== "GuanceDB"
     - Enter GuanceDB’s insert and select
          ![](img/launcher-guancedb.png)

=== "InfluxDB"
     - The InfluxDB link address must use an internal network address.
          - The account must be an administrator account because it needs to initialize DB and RP information.
          ![](img/launcher-influxdb.png)



### 3.4 Log Engine Configuration

=== "OpenSearch"

     - The link address must use an internal network address.
     - The account must be an administrator account.

=== "ElasticSearch"
     - The link address must use an internal network address.
     - The account must be an administrator account.

![](img/launcher-elasticsearch.png)

### 3.5 Other Settings

- Initial admin account name and email for the <<< custom_key.brand_name >>> management backend (default password is **admin**, it is recommended to change the default password immediately after login).
- Internal network IP of the cluster node (will be automatically acquired, needs confirmation if correct).
- Main domain and subdomain configurations for each sub-application. Default subdomains are as follows, which can be modified as needed:
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

     The df-kodo service can choose whether to use the internal SLB. If DataWay and kodo are in the same internal network, the installation can choose to use the internal network.

- Fill in TLS domain certificate.

![](img/launhcer-other.png)

### 3.6 Installation Information

Summarizes the information filled out earlier. If there are any errors, return to the previous step to modify.

![](img/launcher-install-setup-info.png)

### 3.7 Application Configuration Files

The installation program will automatically initialize the application configuration templates based on the installation information provided in the previous steps, but it is still necessary to check all application templates individually and modify personalized application configurations. For detailed configuration instructions, see the installation interface.

After confirming no issues, submit to create the configuration files.

![](img/launcher-review.png)

### 3.8 Application Images

- Select the correct **shared storage**, i.e., the **storage class** name created in the previous steps.
- The application images will be automatically filled in based on the selected **Launcher** version, no modification is required. Confirm no issues and start **creating the application**.

![](img/launcher-config.png)

### 3.9 Application Status

This section lists the startup status of all application services. This process requires downloading all images, which may take several minutes to over ten minutes. Once all services have successfully started, it indicates that the installation is successful.

**Note: During the service startup process, you must remain on this page without closing it until you see the prompt “version information written successfully” and no error windows pop up, indicating the installation was successful!**

![](img/launcher-install-ok.png)

### 3.10 Domain Resolution

Resolve all subdomains except **df-kodo.dataflux.cn** to the public SLB IP address or edge node ingress address:

- dataflux.dataflux.cn
- df-api.dataflux.cn
- df-management.dataflux.cn
- df-management-api.dataflux.cn
- df-openapi.dataflux.cn
- df-func.dataflux.cn
- df-static-res.dataflux.cn

<!-- === "Cloud Infrastructure Deployment"

    After the service installation is complete, the cluster will automatically create a public SLB for the **kodo** service. You can use the `kubectl get svc -n forethought-kodo` command to view the EXTERNAL-IP of the kodo-nginx service, and resolve the **df-kodo.dataflux.cn** subdomain separately to the public IP of this SLB, as shown in the figure below:
    
    ![](img/7.deployment_6.tiff)
    
    This SLB needs to be configured with an HTTPS certificate. The required certificate must be uploaded to the SLB console and the SLB listener protocol must be changed to Layer 7 HTTPS. DataWay defaults to reporting data using the HTTPS protocol.
    
    ???+ warning "Note"
         
         For specific methods of accessing services through SLB, refer to: [https://www.alibabacloud.com/help/zh/doc-detail/86531.htm](https://www.alibabacloud.com/help/zh/doc-detail/86531.htm)
         Edit the YAML file of the kodo-nginx deploy and add the following annotations content:
         
         ```yaml
         service.beta.kubernetes.io/alibaba-cloud-loadbalancer-cert-id: 1642778637586298_17076818419_1585666584_-1335499667 ## Use the actual certificate id from the control panel ##
         service.beta.kubernetes.io/alibaba-cloud-loadbalancer-force-override-listeners: '"true"'  ## Use existing configuration to force override listeners  ##
         service.beta.kubernetes.io/alibaba-cloud-loadbalancer-id: lb-k2j4h4nlg2vgiwi9jyga6   ## Load balancer instance id ## (Specify an existing slb instance)
         service.beta.kubernetes.io/alibaba-cloud-loadbalancer-protocol-port: '"https:443"'  ## Protocol type ##
         ```

=== "Self-built Infrastructure Deployment"

    Since local Kubernetes clusters cannot use LoadBalancer services, edge node ingress must be used instead.
     
    Download [kodo-ingress.yaml](kodo-ingress.yaml) and execute the command to install.
    ```shell
    kubectl apply -f kodo-ingress.yaml
    ```
    
    After configuration, deploy services like haproxy or nginx on machines outside the cluster for domain proxying. For how to proxy, read [Deploy Proxy](proxy-install.md) -->

## 4. Install DataWay (Optional) {#dataway-install}

You can install a DataWay after successful deployment. Click settings at the top right corner and select [Install Data Gateway].
![](img/launcher-dataway-0.png)
Fill in the DataWay name and binding address, click [One-click Install], and a prompt will appear upon successful installation.
![](img/launcher-dataway-1.png)
You can also use other methods to [Install DataWay](dataway-install.md).

## 5. After Installation

After successful deployment, you can refer to the manual [How to Start Using](how-to-start.md).

If problems occur during installation and reinstallation is needed, refer to the manual [Maintenance Manual](faq.md).

## 6. Very Important Step!!!

After completing the above steps, <<< custom_key.brand_name >>> is fully installed and can be verified. After verification, a very important step is to take the launcher service offline to prevent accidental access that could disrupt the application configuration. On the **operations machine**, execute the following command to set the pod replica count of the launcher service to 0:

```shell
kubectl patch deployment launcher \
-p '{"spec": {"replicas": 0}}' \
-n launcher
```