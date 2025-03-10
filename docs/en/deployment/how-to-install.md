# Deployment Essentials



## Deployment Steps {#install-step}

<<< custom_key.brand_name >>> deployment can be initiated by following these steps:

### 1. Resource Planning and Material Preparation

* 1.1 [Resource Planning and Preparation](basic-env-install.md#basic-planning)
* 1.2 [Apply for License](get-license.md)

### 2. Deploying Infrastructure

* 2.1 [Deploy Infrastructure](basic-env-install.md#basic-install)

### 3. Deploy <<< custom_key.brand_name >>>

* 3.1 [Deploy Product Using Launcher](launcher-install.md)
* 3.2 [Initialize DataWay](dataway-install.md)
* 3.3 [Activate <<< custom_key.brand_name >>>](activate.md)

### 4. Start Exploring Features

* 4.1 [Get Started](experience-function.md)



## Precautions

### Domain Names

Deployment requires providing a domain name. If you have a real domain, it needs DNS resolution or local hosts binding.

Taking `dataflux.cn` as an example, the following describes the purpose of each subdomain:

| Subdomain Prefix | Example Domain               | Target         | Purpose                                      | Required |
| :--------------: | :--------------------------: | :------------: | :-------------------------------------------: | :------: |
| dataflux         | dataflux.dataflux.cn         | Ingress-Nginx  | <<< custom_key.brand_name >>> Console Frontend |    Yes   |
| df-api           | df-api.dataflux.cn           | Ingress-Nginx  | <<< custom_key.brand_name >>> Console API     |    Yes   |
| df-docs          | df-docs.dataflux.cn          | Ingress-Nginx  | Help Documentation                           |    No    |
| df-func          | df-func.dataflux.cn          | Ingress-Nginx  | <<< custom_key.brand_name >>> Compute Service |    No    |
| df-kodo          | df-kodo.dataflux.cn          | kodo-nginx     | Metrics Data Entry Service                   |    Yes   |
| df-management    | df-management.dataflux.cn    | Ingress-Nginx  | <<< custom_key.brand_name >>> Admin Console  |    Yes   |
| df-management-api| df-management-api.dataflux.cn| Ingress-Nginx  | <<< custom_key.brand_name >>> Admin API      |    Yes   |
| df-openapi       | df-openapi.dataflux.cn       | Ingress-Nginx  | <<< custom_key.brand_name >>> Data Interface |    No    |
| df-static-res    | df-static-res.dataflux.cn    | Ingress-Nginx  | <<< custom_key.brand_name >>> Template Resources | Yes |

For more information on <<< custom_key.brand_name >>> components, please refer to: [Component Description](deployment-description.md#module)

### Cluster Storage Classes

???+ warning "Note"

     <<< custom_key.brand_name >>> software deployment must use [nfs-subdir-external-provisioner](nfs-provisioner.md).

Deploying <<< custom_key.brand_name >>> services involves deploying two main parts: one is the basic component deployment, and the other is <<< custom_key.brand_name >>> software deployment. The storage classes used in both deployments differ as follows:



| Name                         | [nfs-subdir-external-provisioner](nfs-provisioner.md) | [OpenEBS](openebs-install.md)                 |
| :--------------------------: | :---------------------------------------------------: | :-------------------------------------------: |
| Requires Third Party?        | NFS required                                         | Not required, local disk sufficient           |
| Performance                  | Network storage, poor IO performance                  | Local storage, high IO performance            |
| Read/Write Type              | ReadWriteMany, ReadOnlyMany, ReadWriteOnce            | ReadWriteOnce                                 |
| Pros and Cons                | Pros: Shared data, multi-node mounting; Cons: Poor IO | Pros: High IO; Cons: No cross-node sharing, no dynamic scheduling support |
| Supported Environments       | Basic component deployment, <<< custom_key.brand_name >>> software deployment | Basic component deployment only               |
| Remarks                      | For POC environments, this storage class can be used for deploying basic components and <<< custom_key.brand_name >>> software. For production environments, it is not recommended to use this storage class for basic component deployment | This storage class is not suitable for deploying <<< custom_key.brand_name >>> software |

Please continue translating if there's more content.