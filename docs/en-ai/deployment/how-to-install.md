# Deployment Essentials



## Deployment Steps {#install-step}

Guance deployment can be initiated according to the following steps:

### 1. Resource Planning and Material Preparation

* 1.1 [Resource Planning and Preparation](basic-env-install.md#basic-planning)
* 1.2 [Apply for License](get-license.md)

### 2. Deploying Infrastructure

* 2.1 [Deploy Infrastructure](basic-env-install.md#basic-install)

### 3. Deploy Guance

* 3.1 [Deploy Product Using Launcher](launcher-install.md)
* 3.2 [Initialize DataWay](dataway-install.md)
* 3.3 [Activate Guance](activate.md)

### 4. Start Experiencing Features

* 4.1 [Get Started](experience-function.md)



## Important Notes

### Regarding Domain Names

Deployment requires providing a domain name. If you have a real domain, DNS resolution is required, or you can use local hosts binding.

Taking `dataflux.cn` as an example, the following table describes the roles of each subdomain:

| Subdomain Prefix | Example Domain                  | Target          | Function                      | Required |
| :--------------: | :-----------------------------: | :-------------: | :----------------------------: | :------: |
| dataflux         | dataflux.dataflux.cn            | Ingress-Nginx   | Guance Console Frontend        | Yes      |
| df-api           | df-api.dataflux.cn              | Ingress-Nginx   | Guance Console API             | Yes      |
| df-docs          | df-docs.dataflux.cn             | Ingress-Nginx   | Help Documentation             | No       |
| df-func          | df-func.dataflux.cn             | Ingress-Nginx   | Guance Computing Service       | No       |
| df-kodo          | df-kodo.dataflux.cn             | kodo-nginx      | Metrics Data Entry Service     | Yes      |
| df-management    | df-management.dataflux.cn       | Ingress-Nginx   | Guance Backend Management UI   | Yes      |
| df-management-api| df-management-api.dataflux.cn   | Ingress-Nginx   | Guance Backend Management API  | Yes      |
| df-openapi       | df-openapi.dataflux.cn          | Ingress-Nginx   | Guance Data Interface          | No       |
| df-static-res    | df-static-res.dataflux.cn       | Ingress-Nginx   | Guance Template Resource Service| Yes     |

For more information on Guance components, please refer to: [Component Description](deployment-description.md#module)

### Regarding Cluster Storage Classes

???+ warning "Note"

     Guance software deployment must use the [nfs-subdir-external-provisioner](nfs-provisioner.md)

In deploying Guance services, two main parts are involved: one is the deployment of basic components, and the other is the deployment of Guance software. The storage classes for these two deployments differ as follows:



| Name                        | [nfs-subdir-external-provisioner](nfs-provisioner.md)                                                                 | [OpenEBS](openebs-install.md)                                      |
| :-------------------------: | :-------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------: |
| Third-party Requirement     | Requires NFS                                                                                                        | Does not require third-party, local disk is sufficient            |
| Performance                 | Network storage, poor IO performance                                                                                | Local storage, high IO performance                                |
| Read/Write Type             | ReadWriteMany, ReadOnlyMany, ReadWriteOnce                                                                          | ReadWriteOnce                                                    |
| Pros and Cons               | Pros: Can share data, supports multi-node mounting; Cons: Poor IO                                                   | Pros: High IO; Cons: Cannot share across multiple pods on different nodes, does not support dynamic scheduling |
| Supported Environments      | Basic component deployment, Guance software deployment                                                               | Basic component deployment                                        |
| Remarks                     | For POC environments, this storage class can be used for both basic component and Guance software deployment. For production environments, it is not recommended to use this storage class for basic component deployment | This storage class is not suitable for deploying Guance software |