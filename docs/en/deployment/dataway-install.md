# <<< custom_key.brand_name >>> DataWay Deployment

???+ warning "Note"
     If you have deployed DataWay using Launcher, you can skip the installation steps described in this document.
     This document describes how to register and install DataWay using the <<< custom_key.brand_name >>> management console. You can also use Launcher to [quickly install DataWay](launcher-install.md#dataway-install)

## Prerequisites

- <<< custom_key.brand_name >>> has been deployed. If not, refer to [Deploying Products Using Launcher](launcher-install.md)

## Basic Information and Compatibility

| Name                     | Description                                            |
| :-----------------------: | :----------------------------------------------------: |
| <<< custom_key.brand_name >>> Management Console | http://df-management.dataflux.cn                |
| Offline Installation Support | Yes                                              |
| Supported Architectures   | amd64/arm64                                     |
| Deployment Machine IP     | 192.168.100.105                                 |

## Installation Steps

### 1. Register DataWay

Log in to the management console `http://df-management.dataflux.cn` with the administrator account, the password is `admin`, and the account is the administrator account you set up. Navigate to the "<<< custom_key.brand_name >>> Management Console" under the "Data Gateway" menu, click "Create DataWay", and add a data gateway DataWay.

- **Name**: Custom name
- **Binding Address**: The access address of DataWay, used for data ingestion in DataKit. You can use `http://ip+port`

**Note: When configuring the binding address for DataWay, ensure that the DataKit host can reach this DataWay address and can report data through it.**

![](img/12.deployment_1.png)

### 2. Install DataWay

=== "Host and Docker"

    ???+ warning "Note"
          **Ensure that the host deploying DataWay can access the previously configured kodo address. It is recommended that DataWay connects to kodo via an internal network!**
     
     After adding DataWay, you can obtain an installation script for DataWay. Copy the installation script and run it on the host where DataWay is being deployed.



     ![](img/12.deployment_2.png)

=== "Kubernetes"

    - Obtain `DW_TOKEN` and `DW_UUID`

    ![](img/12.deployment_2.png)

    - Modify Configuration

    Download [dataway.yaml](dataway.yaml)

    Modify the {DW_UUID} and {DW_TOKEN} parameters in the YAML file

    - Install

    ```shell
    kubectl apply -f dataway.yaml
    ```

### 3. Verify Deployment

After installation, wait a moment and refresh the "Data Gateway" page. If you see a version number in the "Version Information" column of the newly added data gateway, it indicates that this DataWay has successfully connected to the <<< custom_key.brand_name >>> center, and front-end users can start ingesting data through it.

![](img/12.deployment_3.png)


## DataWay Access Configuration

=== "Self-hosted Kubernetes (NodePort)"
    
     - Get Node IP

     ```shell
     kubectl get nodes -o wide
     ```
      
     Output:

     ```shell
     NAME         STATUS   ROLES           AGE   VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE                KERNEL-VERSION          CONTAINER-RUNTIME
     k8s-master   Ready    control-plane   9d    v1.24.0   10.200.14.112   <none>        CentOS Linux 7 (Core)   3.10.0-957.el7.x86_64   containerd://1.6.16
     k8s-node01   Ready    <none>          9d    v1.24.0   10.200.14.113   <none>        CentOS Linux 7 (Core)   3.10.0-957.el7.x86_64   containerd://1.6.16
     k8s-node02   Ready    <none>          9d    v1.24.0   10.200.14.114   <none>        CentOS Linux 7 (Core)   3.10.0-957.el7.x86_64   containerd://1.6.16
     ```

     You can directly access: `http://10.200.14.112:30928` 

     > 10.200.14.112 is the node IP in this example; you need to access it based on your cluster's IP. You can also access DataWay via a proxy service; refer to [Proxy Configuration](proxy-install.md) for setup instructions.


=== "EKS"

    Save the following content as dataway-svc.yaml

    ```yaml
    ---

    apiVersion: v1
    kind: Service
    metadata:
      annotations:
        service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: ip
        service.beta.kubernetes.io/aws-load-balancer-scheme: internal  # Internal 
        # service.beta.kubernetes.io/aws-load-balancer-ssl-cert: "" # Certificate
        # service.beta.kubernetes.io/aws-load-balancer-scheme: internet-facing  # External
      name: dataway
      namespace: utils
    spec:
      ports:
      - name: 9528tcp02
        port: 80
        protocol: TCP
        targetPort: 9528
      selector:
        app: deployment-utils-dataway
      type: LoadBalancer
    ```

    Deploy:

    ```shell
    kubectl apply -f dataway-svc.yaml
    ```

    Check the NLB address:

    ```shell
    kubectl get svc -n utils 
    ```

    You can directly access: `http://nlbIP`

=== "Host and Docker"

    You can directly access the `9528` port of the installation machine.