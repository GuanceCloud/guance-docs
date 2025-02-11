# Alibaba Cloud Deployment Manual
---

## 1 Introduction
### 1.1 Document Overview
This document primarily focuses on deploying on Alibaba Cloud, introducing the complete steps from resource planning and configuration to deploying Guance and running it.

**Note:**

- This document uses **dataflux.cn** as the main domain name example. Replace it with the corresponding domain name during actual deployment.

### 1.2 Key Terms

| **Term** | **Description** |
| --- | --- |
| Launcher | A WEB application used for deploying and installing Guance. Follow the steps provided by the Launcher service to complete the installation and upgrade of Guance. |
| Operations Machine | A machine installed with kubectl, which is in the same network as the target Kubernetes cluster. |
| Installation Machine | The machine that accesses the launcher service via a browser to complete the guided installation of Guance. |
| kubectl | The command-line client tool for Kubernetes, installed on the **operations machine**. |

### 1.3 Deployment Architecture {#install-step-image}
![](img/23.install-step.png)
## 2 Resource Preparation
[Alibaba Cloud Resource List](cloud-required.md#list)

## 3 Infrastructure Deployment

### 3.1 Deployment Instructions

**RDS, InfluxDB, OpenSearch, NAS Storage** should be created according to configuration requirements, all within the same region under the same **VPC** network.
ECS, SLB, NAT Gateway are automatically created by ACK, so they do not need to be created separately, meaning steps 1, 2, and 3 in the [deployment diagram](#install-step-image) do not need separate creation.

### 3.2 Steps One, Two, Three - ACK Service Creation

#### 3.2.1 Cluster Configuration

Enter **Container Service for Kubernetes**, create a **Kubernetes** cluster, choose the **Managed Standard Cluster** option. Pay attention to the following when configuring the cluster:

- It must be in the same region as the previously created RDS, InfluxDB, Elasticsearch resources.
- Check the "Configure SNAT" option (ACK will automatically create and configure a NAT Gateway, enabling outbound internet access for the cluster).
- Check the "Public Access" option (if you are maintaining this cluster internally, you can skip this option).
- When enabling ACK services, temporarily select flexvolume as the storage driver, as CSI drivers are not yet supported in this document.

![](img/7.deployment_2.png)

#### 3.2.2 Worker Configuration

Select ECS specifications and quantity based on the configuration list or actual assessment, but ensure it meets the minimum configuration requirements. At least three or more workers are required.

![](img/7.deployment_3.png)

#### 3.2.3 Component Configuration

Ensure the "Install Ingress Component" option is checked, selecting the "Public" type. ACK will automatically create a public SLB. After installation, bind the domain name to the public IP of this SLB.

![](img/7.deployment_4.png)

### 3.3 Steps Four, Five - Dynamic Storage Configuration

You need to pre-create the NAS file system and obtain the `nas_server_url`.

#### 3.3.1 Dynamic Storage Installation

=== "CSI"

    Alibaba Cloud Container Service ACK's container storage functionality is based on Kubernetes Container Storage Interface (CSI), deeply integrating with Alibaba Cloud storage services such as EBS, NAS, CPFS, OSS, and local disks, fully compatible with Kubernetes-native storage services like EmptyDir, HostPath, Secret, ConfigMap, etc. This section introduces an overview of ACK storage CSI, supported features, usage authorization, and limitations. The console will **default install** the CSI-Plugin and CSI-Provisioner components.
    
    - Verify Plugins
      - Run the following command to check if the CSI-Plugin component is successfully deployed:
        ```shell
        kubectl get pod -n kube-system | grep csi-plugin
        ```
      - Run the following command to check if the CSI-Provisioner component is successfully deployed:
        ```shell
        kubectl get pod -n kube-system | grep csi-provisioner
        ```
    - Create StorageClass
       
      Create and copy the following content into the `alicloud-nas-subpath.yaml` file.
    
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
    
      Replace **{{ nas_server_url }}** with the Server URL of the NAS storage created earlier. Execute the command on the **operations machine**:
    
      ```shell
      kubectl apply -f ./alicloud-nas-subpath.yaml
      ```

=== "flexvolume (officially deprecated)"

    When creating clusters using versions of Alibaba Cloud Kubernetes before 1.16, if the storage plugin selected is Flexvolume, the console defaults to installing Flexvolume and Disk-Controller components but does not default install the alicloud-nas-controller component.
    
    - Install the alicloud-nas-controller component
    
      Download [nas_controller.yaml](nas_controller.yaml)
      Execute the command on the **operations machine**:
      ```shell
      kubectl apply -f nas_controller.yaml
      ```
    
    - Verify Plugins
    
      Run the following command to check if the Disk-Controller component is successfully deployed:
      ```shell
      kubectl get pod -nkube-system | grep alicloud-nas-controller
      ```
    
    - Create StorageClass
    
      Create and copy the following content into the `storage_class.yaml` file.
    
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
      Replace **{{ nas_server_url }}** with the Server URL of the NAS storage created earlier. Execute the command on the **operations machine**:
    
      ```shell
      kubectl apply -f ./storage_class.yaml
      ```

#### 3.3.2 Verification of Deployment

##### 3.3.2.1 Create PVC and Check Status

Execute the command to create a PVC:

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

##### 3.3.2.2 Check PVC Status

```shell
$ kubectl get pvc | grep cfs-pvc001

cfs-pvc001       Bound    pvc-a17a0e50-04d2-4ee0-908d-bacd8d53aaa4   1Gi        RWO            alicloud-nas           3d7h
```

>`Bound` indicates successful deployment.

### 3.4 Step Six - Cache Service

- You can use the default built-in cache service.
- If you do not use the default built-in cache service, configure Redis as follows:
  - Redis version: 6.0, supporting standalone, proxy, and master-slave modes.
  - Configure Redis password.
  - Add the internal ECS IP addresses automatically created by ACK to the Redis whitelist.

### 3.5 Step Seven - InfluxDB

- Create an administrator account (must be an **administrator account**, used for initializing DB and RP information during subsequent installations).
- Add the internal ECS IP addresses automatically created by ACK to the InfluxDB whitelist.

### 3.6 Step Eight - OpenSearch

- Create an administrator account.
- Install Chinese segmentation plugin.
- Add the internal ECS IP addresses automatically created by ACK to the OpenSearch whitelist.

### 3.7 Step Nine - RDS

- Create an administrator account (must be an **administrator account**, used for initializing various application DBs during subsequent installations).
- Modify parameter settings in the console to set **innodb_large_prefix** to **ON**.
- Add the internal ECS IP addresses automatically created by ACK to the RDS whitelist.

## 4 kubectl Installation and Configuration
### 4.1 Install kubectl
kubectl is a command-line client tool for Kubernetes, allowing you to deploy applications, check, and manage cluster resources.
Our Launcher is based on this command-line tool to deploy applications. For specific installation methods, refer to the official documentation:

[https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### 4.2 Configure kube config
To gain management capabilities over the cluster, the cluster's kubeconfig content needs to be placed in the **$HOME/.kube/config** file. You can view the kubeconfig content in the cluster's **Basic Information** section.

Choose between public or private kubeconfig based on whether your operations machine is connected to the cluster's internal network.

![](img/7.deployment_5.png)

## 5 Start Installation

After completing the above operations, you can refer to the manual [Start Installation](launcher-install.md)