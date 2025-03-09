# Kubernetes Storage Component Deployment {#kube-storage}

## Introduction

nfs-subdir-external-provisioner can dynamically provide PV volumes for Kubernetes. It is a simple external NFS provisioner for Kubernetes, but it does not provide NFS itself; it requires an existing NFS server to provide storage. The naming rule for persistent volume directories is: ${namespace}-${pvcName}-${pvName}.

For deploying the Kubernetes nfs subdir external provisioner component, refer to [https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner)

## Prerequisites

- An NFS service has been deployed. If not, refer to [NFS Deployment](nfs-install.md)
- A Kubernetes cluster has been deployed. If not, refer to [Kubernetes Deployment](infra-kubernetes.md)
- (Optional) Helm tool has been deployed. If not, refer to [Helm Installation](helm-install.md)

## Basic Information and Compatibility

|     NFS IP      | NSF Path | storageClass name |              Description               |
| :-------------: | :------: | :---------------: | :------------------------------------: |
| 192.168.100.105 | /nfsdata |   df-nfs-storage  | Modify configuration according to actual conditions |

|                  Name                   | Version | Offline Deployment Supported | Supported Architectures | Supported Cluster Versions |
| :-------------------------------------: | :-----: | :--------------------------: | :----------------------: | :-------------------------: |
| nfs subdir external provisioner         | 4.0.16  |             Yes              |        amd64/arm64       |            1.18+           |

## Deployment Steps

### 1. Deploy Kubernetes nfs subdir external provisioner

???+ warning "Note"
     All Kubernetes nodes must have nfs-utils installed. If not installed, execute the following command:
     ``` shell
     yum install -y nfs-utils
     ```

=== "Helm"

    Execute the command to install:

    ```bash
    helm install nfs-provisioner nfs-subdir-external-provisioner \
        --repo https://pubrepo.guance.com/chartrepo/dataflux-chart \
        --set nfs.server=192.168.100.105 \
        --set nfs.path=/nfsdata \
        --set storageClass.name=df-nfs-storage \
        -n kube-system 
    ```
    
    ???+ warning "Note"
    
         Note that `nfs.server` is the NFS address and `nfs.path` is the path, do not confuse them.

=== "Yaml"
     
    Modify the highlighted parts of the following YAML and deploy.

    ???- note "nfs-provisioner.yaml (Click to expand)"
        ```yaml hl_lines='103 105 109-110'
        ---
        apiVersion: v1
        kind: ServiceAccount
        metadata:
          name: nfs-client-provisioner
          # replace with namespace where provisioner is deployed
          namespace: kube-system
        ---
        kind: ClusterRole
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: nfs-client-provisioner-runner
        rules:
          - apiGroups: [""]
            resources: ["nodes"]
            verbs: ["get", "list", "watch"]
          - apiGroups: [""]
            resources: ["persistentvolumes"]
            verbs: ["get", "list", "watch", "create", "delete"]
          - apiGroups: [""]
            resources: ["persistentvolumeclaims"]
            verbs: ["get", "list", "watch", "update"]
          - apiGroups: ["storage.k8s.io"]
            resources: ["storageclasses"]
            verbs: ["get", "list", "watch"]
          - apiGroups: [""]
            resources: ["events"]
            verbs: ["create", "update", "patch"]
        ---
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: run-nfs-client-provisioner
        subjects:
          - kind: ServiceAccount
            name: nfs-client-provisioner
            # replace with namespace where provisioner is deployed
            namespace: kube-system
        roleRef:
          kind: ClusterRole
          name: nfs-client-provisioner-runner
          apiGroup: rbac.authorization.k8s.io
        ---
        kind: Role
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: leader-locking-nfs-client-provisioner
          # replace with namespace where provisioner is deployed
          namespace: kube-system
        rules:
          - apiGroups: [""]
            resources: ["endpoints"]
            verbs: ["get", "list", "watch", "create", "update", "patch"]
        ---
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: leader-locking-nfs-client-provisioner
          # replace with namespace where provisioner is deployed
          namespace: kube-system
        subjects:
          - kind: ServiceAccount
            name: nfs-client-provisioner
            # replace with namespace where provisioner is deployed
            namespace: kube-system
        roleRef:
          kind: Role
          name: leader-locking-nfs-client-provisioner
          apiGroup: rbac.authorization.k8s.io
    
        ---
        apiVersion: apps/v1
        kind: Deployment
        metadata:
          name: nfs-client-provisioner
          labels:
            app: nfs-client-provisioner
          # replace with namespace where provisioner is deployed
          namespace: kube-system
        spec:
          replicas: 1
          strategy:
            type: Recreate
          selector:
            matchLabels:
              app: nfs-client-provisioner
          template:
            metadata:
              labels:
                app: nfs-client-provisioner
            spec:
              serviceAccountName: nfs-client-provisioner
              containers:
                - name: nfs-client-provisioner
                  image: dyrnq/nfs-subdir-external-provisioner:v4.0.2
                  volumeMounts:
                    - name: nfs-client-root
                      mountPath: /persistentvolumes
                  env:
                    - name: PROVISIONER_NAME
                      value: k8s-sigs.io/nfs-subdir-external-provisioner
                    - name: NFS_SERVER
                      value: 192.168.100.105   # Replace with actual NFS server
                    - name: NFS_PATH
                      value: /nfsdata   # Actual shared directory       
              volumes:
                - name: nfs-client-root
                  nfs:
                    server: 192.168.100.105 # Replace with actual NFS server address
                    path: /nfsdata  # Actual shared directory
        ---
        apiVersion: storage.k8s.io/v1
        kind: StorageClass
        metadata:
          name: df-nfs-storage
          annotations:
            storageclass.beta.kubernetes.io/is-default-class: "true"  # Configure this storageclass as default
            storageclass.kubernetes.io/is-default-class: "true"
        provisioner: k8s-sigs.io/nfs-subdir-external-provisioner # or choose another name, must match deployment's env PROVISIONER_NAME'
        allowVolumeExpansion: true 
        reclaimPolicy: Delete
        parameters:
          archiveOnDelete: "false"            
    
        ```
    
    Execute the command to install:
    ```shell
    kubectl apply -f nfs-provisioner.yaml
    ```

### 2. Verify Deployment

#### 2.1 Check Pod Status

```shell
$ kubectl get pod -n kube-system | grep  nfs-provisione

nfs-provisioner-nfs-subdir-external-provisioner-79d448b5d7tbp7v   1/1     Running   0          3d5h
```

#### 2.2 Create PVC

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
 storageClassName: df-nfs-storage
EOF
```

#### 2.3 Check PVC Status

```shell
$ kubectl get pvc | grep cfs-pvc001

cfs-pvc001       Bound    pvc-a17a0e50-04d2-4ee0-908d-bacd8d53aaa4   1Gi        RWO            df-nfs-storage           3d7h
```

>`Bound` indicates successful deployment


## How to Uninstall

=== "Helm"
    
    ```shell
    helm uninstall -n kube-system nfs-provisioner
    ```

=== "Yaml"

    ```shell
    kubectl delete -f nfs-provisioner.yaml
    ```