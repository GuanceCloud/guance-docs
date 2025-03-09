# Alibaba Cloud Deployment Manual
---

## 1 Introduction
### 1.1 Document Overview
This document primarily covers the deployment on Alibaba Cloud, introducing the complete steps from resource planning and configuration to deploying <<< custom_key.brand_name >>> and running it.

**Note:**

- This document uses **dataflux.cn** as the primary domain name example. Replace it with the appropriate domain during actual deployment.

### 1.2 Key Terms

| **Term** | **Description** |
| --- | --- |
| Launcher | A WEB application used for deploying and installing <<< custom_key.brand_name >>>. Follow the guidance steps of the Launcher service to complete the installation and upgrade of <<< custom_key.brand_name >>>. |
| Operations Machine | A machine with kubectl installed, connected to the target Kubernetes cluster in the same network. |
| Installation Machine | A machine used to access the launcher service via a browser to complete the guided installation of <<< custom_key.brand_name >>>. |
| kubectl | The command-line client tool for Kubernetes, installed on the **operations machine**. |

### 1.3 Deployment Architecture {#install-step-image}
![](img/23.install-step.png)

## 2 Resource Preparation
[Alibaba Cloud Resource List](cloud-required.md#list)

## 3 Infrastructure Deployment

### 3.1 Deployment Description

**RDS, InfluxDB, OpenSearch, NAS Storage** should be created according to the configuration requirements, all within the same region and under the same **VPC** network.
ECS, SLB, NAT Gateway are automatically created by ACK, so there is no need to create them separately, meaning steps 1, 2, and 3 in the [deployment diagram](#install-step-image) do not require separate creation.

### 3.2 Steps One, Two, Three - ACK Service Creation

#### 3.2.1 Cluster Configuration

Enter **Container Service for Kubernetes**, create a **Kubernetes** cluster, select **Managed Standard Cluster**, and pay attention to the following cluster configuration requirements:

- It must be in the same region as the previously created RDS, InfluxDB, Elasticsearch, etc.
- Select the "Configure SNAT" option (ACK will automatically create and configure the NAT Gateway to enable outbound internet access for the cluster)
- Select the "Public Access" option (to allow public access to the cluster API; if you are managing the cluster internally, this can be unchecked)
- Choose flexvolume as the storage driver temporarily when enabling ACK services; CSI drivers are not supported in this document yet.

![](img/7.deployment_2.png)

#### 3.2.2 Worker Configuration

Mainly choose the ECS specifications and quantity. Specifications can be selected based on the configuration list or assessed according to actual needs, but they must not fall below the minimum requirements. There should be at least 3 nodes, or more.

![](img/7.deployment_3.png)

#### 3.2.3 Component Configuration

Component configuration must include selecting the "Install Ingress Component" option, choosing "Public" type. ACK will automatically create a public SLB. After installation, point the domain to the public IP of this SLB.

![](img/7.deployment_4.png)

### 3.3 Steps Four, Five - Dynamic Storage Configuration

Create the NAS file system in advance and obtain the nas_server_url.

#### 3.3.1 Dynamic Storage Installation

=== "CSI"

    Alibaba Cloud Container Service for Kubernetes' container storage capabilities are based on Kubernetes Container Storage Interface (CSI), deeply integrating with Alibaba Cloud storage services such as cloud disks EBS, file storage NAS and CPFS, object storage OSS, local disks, etc., and fully compatible with Kubernetes-native storage services like EmptyDir, HostPath, Secret, ConfigMap, etc. This section introduces an overview of ACK storage CSI, supported features, usage authorization, and usage restrictions. The console will **default install** the CSI-Plugin and CSI-Provisioner components.
    
    - Verify Plugins
      - Run the following command to check if the CSI-Plugin component has been successfully deployed.
        ```shell
        kubectl get pod -n kube-system | grep csi-plugin
        ```
      - Run the following command to check if the CSI-Provisioner component has been successfully deployed.
        ```shell
        kubectl get pod -n kube-system | grep csi-provisioner
        ```
    - Create StorageClass
       
      Create and copy the following content into the alicloud-nas-subpath.yaml file.
    
    ???+ note "alicloud-nas-subpath.yaml"
          ```yaml
          apiVersion: storage.k8s.io/v1
          kind: StorageClass
          metadata:
            name: alicloud-nas
          mountOptions:
          - nolock,tcp,noresvport
          - vers=3
          parameters:
            volumeAs: subpath
            server: "{{ nas_server_url }}:/k8s/"
          provisioner: nasplugin.csi.alibabacloud.com
          reclaimPolicy: Retain
          ```
    
      Replace **{{ nas_server_url }}** with the Server URL of the NAS storage created earlier, then run the command on the **operations machine**:
    
      ```shell
      kubectl apply -f ./alicloud-nas-subpath.yaml
      ```

=== "flexvolume (Officially Deprecated)"

    When creating clusters with Alibaba Cloud Kubernetes versions prior to 1.16, if the storage plugin is chosen as Flexvolume, the console will default install the Flexvolume and Disk-Controller components but not the alicloud-nas-controller component.
    
    - Install the alicloud-nas-controller component
    
      Download [nas_controller.yaml](nas_controller.yaml)
      Run the command on the **operations machine**:
      ```shell
      kubectl apply -f nas_controller.yaml
      ```
    
    - Verify Plugin
    
      Run the following command to check if the Disk-Controller component has been successfully deployed.
      ```shell
      kubectl get pod -nkube-system | grep alicloud-nas-controller
      ```
    
    - Create StorageClass
    
      Create and copy the following content into the storage_class.yaml file.
    
    ???+ note "storage_class.yaml"
          ```yaml
          apiVersion: storage.k8s.io/v1
          kind: StorageClass
          metadata:
            name: alicloud-nas
            annotations:
              storageclass.beta.kubernetes.io/is-default-class: "true"
              storageclass.kubernetes.io/is-default-class: "true"
          mountOptions:
          - nolock,tcp,noresvport
          - vers=3
          parameters:
            server:  "{{ nas_server_url }}:/k8s/"
            driver: flexvolume
          provisioner: alicloud/nas
          reclaimPolicy: Delete
          ```
      Replace **{{ nas_server_url }}** with the Server URL of the NAS storage created earlier, then run the command on the **operations machine**:
    
      ```shell
      kubectl apply -f ./storage_class.yaml
      ```

#### 3.3.2 Verification of Deployment

##### 3.3.2.1 Create PVC and Check Status

Run the command to create a PVC:

```shell
$ cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
 name: cfs-pvc001
spec:
 accessModes:
   - ReadWriteOnce
 resources:
   requests:
     storage: 1Gi
 storageClassName: alicloud-nas
EOF
```

##### 3.3.2.2 Check PVC

```shell
$ kubectl get pvc | grep cfs-pvc001

cfs-pvc001       Bound    pvc-a17a0e50-04d2-4ee0-908d-bacd8d53aaa4   1Gi        RWO            alicloud-nas           3d7h
```

>`Bound` indicates successful deployment.

### 3.4 Step Six - Cache Service

- You can use the default built-in cache service.
- If you do not use the default built-in cache service, configure Redis as follows:
  - Redis Version: 6.0, supporting standalone mode, proxy mode, and master-slave mode Redis clusters.
  - Configure Redis password.
  - Add the automatically created ECS internal IP to the Redis whitelist.

### 3.5 Step Seven - InfluxDB

- Create an administrator account (must be an **administrator account**, required for subsequent initialization and DB/RP creation).
- Add the internal IP of the ECS instances automatically created by ACK to the InfluxDB whitelist.

### 3.6 Step Eight - OpenSearch

- Create an administrator account.
- Install the Chinese segmentation plugin.
- Add the internal IP of the ECS instances automatically created by ACK to the OpenSearch whitelist.

### 3.7 Step Nine - RDS

- Create an administrator account (must be an **administrator account**, required for subsequent initialization and creation of various application DBs).
- Modify parameter configurations in the console to set **innodb_large_prefix** to **ON**.
- Add the internal IP of the ECS instances automatically created by ACK to the RDS whitelist.

## 4 kubectl Installation and Configuration
### 4.1 Install kubectl
kubectl is a command-line client tool for Kubernetes, allowing you to deploy applications, check, and manage cluster resources through this tool.
Our Launcher is based on this command-line tool for deploying applications. Refer to the official documentation for specific installation methods:

[https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### 4.2 Configure kube config
For kubectl to manage the cluster, the cluster's kubeconfig content must be placed in the **$HOME/.kube/config** file. You can find the kubeconfig content in the cluster's **Basic Information** section.

Choose whether to use the public or private kubeconfig based on whether your operations machine is connected to the cluster's internal network.

![](img/7.deployment_5.png)

## 5 Start Installation

After completing the above operations, refer to the manual [Start Installation](launcher-install.md) for further instructions.